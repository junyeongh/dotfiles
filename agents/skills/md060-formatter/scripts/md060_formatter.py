#!/usr/bin/env python3
"""
MD060 Markdown Table Formatter

This script formats markdown tables according to the MD060 (table-column-style) rule.
It supports three main styles: aligned, compact, and tight.

Styles:
- aligned: All columns are aligned with padding
- compact: Minimal padding (1 space on each side)
- tight: No padding (pipes directly adjacent to content)

Usage:
    python md060_formatter.py <input_file> [--style STYLE] [--aligned-delimiter] [--output OUTPUT]

    Or use as a module:
    from md060_formatter import format_markdown_table, format_markdown_file
"""

import re
import sys
import argparse
from typing import List, Tuple
from enum import Enum


class TableStyle(Enum):
    """Supported table styles for MD060"""

    ALIGNED = "aligned"
    COMPACT = "compact"
    TIGHT = "tight"
    ANY = "any"


class MD060Formatter:
    """Format markdown tables according to MD060 specification"""

    def __init__(self, style: TableStyle = TableStyle.ALIGNED, aligned_delimiter: bool = False):
        """
        Initialize the formatter.

        Args:
            style: The table style to enforce (aligned, compact, tight, or any)
            aligned_delimiter: Whether to align delimiter row pipes with header row
        """
        self.style = style
        self.aligned_delimiter = aligned_delimiter

    def get_visual_width(self, text: str) -> int:
        """
        Calculate visual width of text, accounting for emoji and CJK characters.

        Emoji and CJK characters typically render at twice the width of Latin characters.
        """
        width = 0
        for char in text:
            code_point = ord(char)
            # CJK Unified Ideographs and emoji ranges (simplified check)
            if (
                0x4E00 <= code_point <= 0x9FFF  # CJK Unified Ideographs
                or 0x3400 <= code_point <= 0x4DBF  # CJK Extension A
                or 0x20000 <= code_point <= 0x2A6DF  # CJK Extension B
                or 0x1F300 <= code_point <= 0x1F9FF  # Emoji
                or 0x2600 <= code_point <= 0x27BF  # Miscellaneous Symbols & Dingbats
                or 0x2B00 <= code_point <= 0x2BFF  # Miscellaneous Symbols and Arrows
                or 0xFE00 <= code_point <= 0xFE0F  # Variation Selectors
                or 0x1F000 <= code_point <= 0x1F02F  # Mahjong Tiles
                or 0x1F0A0 <= code_point <= 0x1F0FF  # Playing Cards
                or 0x1F100 <= code_point <= 0x1F64F  # Enclosed characters, Emoticons
                or 0x1F680 <= code_point <= 0x1F6FF  # Transport and Map Symbols
                or 0x1F900 <= code_point <= 0x1F9FF
            ):  # Supplemental Symbols
                width += 2
            else:
                width += 1
        return width

    def parse_table_row(self, row: str) -> List[str]:
        """
        Parse a table row into cells.

        Args:
            row: A markdown table row

        Returns:
            List of cell contents (stripped of padding)
        """
        # Remove leading/trailing pipes and whitespace
        row = row.strip()
        if row.startswith("|"):
            row = row[1:]
        if row.endswith("|"):
            row = row[:-1]

        # Split by pipe and strip each cell
        cells = [cell.strip() for cell in row.split("|")]
        return cells

    def is_delimiter_row(self, row: str) -> bool:
        """Check if a row is a delimiter row (contains only dashes, colons, and pipes)"""
        cleaned = re.sub(r"[|\s]", "", row)
        return bool(re.match(r"^:?-+:?(:?-+:?)*$", cleaned))

    def parse_alignment(self, delimiter_cell: str) -> str:
        """
        Parse alignment from a delimiter cell.

        Returns:
            'left', 'center', 'right', or 'default'
        """
        cell = delimiter_cell.strip()
        if cell.startswith(":") and cell.endswith(":"):
            return "center"
        elif cell.endswith(":"):
            return "right"
        elif cell.startswith(":"):
            return "left"
        else:
            return "default"

    def create_delimiter_cell(self, width: int, alignment: str) -> str:
        """Create a delimiter cell with proper alignment markers"""
        if alignment == "center":
            return ":" + "-" * (width - 2) + ":"
        elif alignment == "right":
            return "-" * (width - 1) + ":"
        elif alignment == "left":
            return ":" + "-" * (width - 1)
        else:
            return "-" * width

    def format_table(self, table_lines: List[str]) -> List[str]:
        """
        Format a markdown table according to the specified style.

        Args:
            table_lines: List of lines that make up the table

        Returns:
            List of formatted table lines
        """
        if len(table_lines) < 2:
            return table_lines  # Not a valid table

        # Parse all rows
        rows = []
        delimiter_index = -1

        for i, line in enumerate(table_lines):
            if self.is_delimiter_row(line):
                delimiter_index = i
            cells = self.parse_table_row(line)
            rows.append(cells)

        if delimiter_index == -1:
            return table_lines  # No delimiter row found

        # Get number of columns
        num_cols = len(rows[0]) if rows else 0

        # Parse alignments from delimiter row
        alignments = []
        if delimiter_index < len(rows):
            for cell in rows[delimiter_index]:
                alignments.append(self.parse_alignment(cell))

        # Calculate column widths based on style
        if self.style == TableStyle.ALIGNED:
            col_widths = self._calculate_aligned_widths(rows, delimiter_index)
        elif self.style == TableStyle.COMPACT:
            col_widths = self._calculate_compact_widths(rows, delimiter_index)
        elif self.style == TableStyle.TIGHT:
            col_widths = [0] * num_cols
        else:  # ANY - detect and use existing style
            col_widths = self._detect_and_calculate_widths(rows, delimiter_index)

        # Format each row
        formatted_lines = []
        for i, row in enumerate(rows):
            if i == delimiter_index:
                # Format delimiter row
                formatted_cells = []
                for j, cell in enumerate(row):
                    alignment = alignments[j] if j < len(alignments) else "default"
                    if self.style == TableStyle.ALIGNED or self.aligned_delimiter:
                        width = col_widths[j] if j < len(col_widths) else 3
                        delimiter = self.create_delimiter_cell(width, alignment)
                    else:
                        delimiter = self.create_delimiter_cell(3, alignment)
                    formatted_cells.append(delimiter)
            else:
                # Format data row
                formatted_cells = []
                for j, cell in enumerate(row):
                    width = col_widths[j] if j < len(col_widths) else 0
                    formatted_cell = self._format_cell(cell, width, alignments[j] if j < len(alignments) else "default")
                    formatted_cells.append(formatted_cell)

            # Assemble the row
            if self.style == TableStyle.TIGHT:
                formatted_line = "|" + "|".join(formatted_cells) + "|"
            elif self.style == TableStyle.COMPACT:
                # For compact style, empty cells should have single space, non-empty get space on both sides
                parts = ["|"]
                for cell in formatted_cells:
                    if cell == "":
                        parts.append(" |")
                    else:
                        parts.append(" " + cell + " |")
                formatted_line = "".join(parts)
            else:
                formatted_line = "| " + " | ".join(formatted_cells) + " |"

            formatted_lines.append(formatted_line)

        return formatted_lines

    def _calculate_aligned_widths(self, rows: List[List[str]], delimiter_index: int) -> List[int]:
        """Calculate column widths for aligned style"""
        if not rows:
            return []

        num_cols = len(rows[0])
        col_widths = [0] * num_cols

        for i, row in enumerate(rows):
            for j, cell in enumerate(row):
                if j < num_cols:
                    if i == delimiter_index:
                        # Delimiter cells need at least 3 characters
                        col_widths[j] = max(col_widths[j], 3)
                    else:
                        col_widths[j] = max(col_widths[j], self.get_visual_width(cell))

        return col_widths

    def _calculate_compact_widths(self, rows: List[List[str]], delimiter_index: int) -> List[int]:
        """Calculate column widths for compact style (content width only)"""
        if not rows:
            return []

        num_cols = len(rows[0])
        col_widths = [0] * num_cols

        for i, row in enumerate(rows):
            for j, cell in enumerate(row):
                if j < num_cols and i != delimiter_index:
                    col_widths[j] = max(col_widths[j], self.get_visual_width(cell))

        return col_widths

    def _detect_and_calculate_widths(self, rows: List[List[str]], delimiter_index: int) -> List[int]:
        """Detect existing style and calculate appropriate widths"""
        # For 'any' style, default to aligned
        return self._calculate_aligned_widths(rows, delimiter_index)

    def _format_cell(self, content: str, width: int, alignment: str) -> str:
        """
        Format a single cell with proper padding and alignment.

        Empty cells (content='') are handled correctly in all styles:
        - Tight: Returns empty string (no padding)
        - Compact: Returns empty string (no padding)
        - Aligned: Returns padding spaces to match column width
        """
        if self.style == TableStyle.TIGHT:
            return content

        visual_width = self.get_visual_width(content)
        padding_needed = max(0, width - visual_width)

        if self.style == TableStyle.COMPACT:
            return content

        # Aligned style - add padding based on alignment
        if alignment == "right":
            return " " * padding_needed + content
        elif alignment == "center":
            left_pad = padding_needed // 2
            right_pad = padding_needed - left_pad
            return " " * left_pad + content + " " * right_pad
        else:  # left or default
            return content + " " * padding_needed


def find_tables(content: str) -> List[Tuple[int, int, List[str]]]:
    """
    Find all markdown tables in the content.

    Returns:
        List of tuples (start_line, end_line, table_lines)
    """
    lines = content.split("\n")
    tables = []
    current_table = []
    table_start = -1

    for i, line in enumerate(lines):
        stripped = line.strip()

        # Check if this looks like a table row
        if stripped and "|" in stripped:
            if not current_table:
                table_start = i
            current_table.append(line)
        else:
            # End of table
            if current_table:
                # Verify it's a valid table (has at least 2 rows with a delimiter)
                has_delimiter = any(
                    re.match(r"^\s*\|?\s*:?-+:?\s*(\|\s*:?-+:?\s*)*\|?\s*$", row) for row in current_table
                )
                if len(current_table) >= 2 and has_delimiter:
                    tables.append((table_start, i - 1, current_table))
                current_table = []

    # Don't forget the last table if the file ends with it
    if current_table:
        has_delimiter = any(re.match(r"^\s*\|?\s*:?-+:?\s*(\|\s*:?-+:?\s*)*\|?\s*$", row) for row in current_table)
        if len(current_table) >= 2 and has_delimiter:
            tables.append((table_start, len(lines) - 1, current_table))

    return tables


def format_markdown_file(content: str, style: TableStyle = TableStyle.ALIGNED, aligned_delimiter: bool = False) -> str:
    """
    Format all tables in a markdown file.

    Args:
        content: The markdown file content
        style: The table style to enforce
        aligned_delimiter: Whether to align delimiter row pipes

    Returns:
        Formatted markdown content
    """
    lines = content.split("\n")
    formatter = MD060Formatter(style, aligned_delimiter)

    # Find all tables
    tables = find_tables(content)

    # Process tables in reverse order to avoid index shifting
    for start_line, end_line, table_lines in reversed(tables):
        formatted_table = formatter.format_table(table_lines)
        # Replace the original table with formatted version
        lines[start_line : end_line + 1] = formatted_table

    return "\n".join(lines)


def main():
    """Command-line interface for the formatter"""
    parser = argparse.ArgumentParser(description="Format markdown tables according to MD060 specification")
    parser.add_argument("input", help="Input markdown file")
    parser.add_argument(
        "--style",
        "-s",
        choices=["aligned", "compact", "tight", "any"],
        default="aligned",
        help="Table formatting style (default: aligned)",
    )
    parser.add_argument(
        "--aligned-delimiter", "-d", action="store_true", help="Align delimiter row pipes with header row"
    )
    parser.add_argument("--output", "-o", help="Output file (default: overwrite input file)")
    parser.add_argument("--preview", "-p", action="store_true", help="Preview changes without modifying files")

    args = parser.parse_args()

    # Read input file
    try:
        with open(args.input, "r", encoding="utf-8") as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: File '{args.input}' not found", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file: {e}", file=sys.stderr)
        sys.exit(1)

    # Format the content
    style = TableStyle(args.style)
    formatted_content = format_markdown_file(content, style, args.aligned_delimiter)

    # Output
    if args.preview:
        print(formatted_content)
    else:
        output_file = args.output or args.input
        try:
            with open(output_file, "w", encoding="utf-8") as f:
                f.write(formatted_content)
            print(f"Successfully formatted tables in '{output_file}'")
        except Exception as e:
            print(f"Error writing file: {e}", file=sys.stderr)
            sys.exit(1)


if __name__ == "__main__":
    main()
