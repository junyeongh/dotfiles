---
name: md060-formatter
description: Format markdown tables according to MD060 (table-column-style) specification. Use when the user asks to format markdown tables or make tables consistent. Consider `COMPACT` as the default format.
---

# MD060 Markdown Table Formatter

## Overview

This skill formats markdown tables according to the MD060 (table-column-style) markdownlint specification, ensuring consistent and professional table formatting across markdown documents.

## Quick Start

For simple formatting tasks, use the `md060_formatter.py` script directly:

```python
from scripts.md060_formatter import format_markdown_file, TableStyle

# Read markdown content
content = """
| Name | Age | City |
|---|---|---|
| Alice | 30 | New York |
"""

# Format with aligned style (default)
formatted = format_markdown_file(content, style=TableStyle.ALIGNED)
```

## Formatting Styles

### Style Selection Guide

**Use ALIGNED when:**

- Creating documentation or README files
- Source readability is important
- Tables will be edited frequently by humans

**Use COMPACT when:**

- Balancing readability and file size
- Tables have moderate amounts of data
- Working in space-constrained environments

**Use TIGHT when:**

- Minimizing file size is critical
- Tables are auto-generated
- Source readability is not a priority

### Implementation

```python
from scripts.md060_formatter import format_markdown_file, TableStyle

# Aligned style (default)
aligned = format_markdown_file(content, TableStyle.ALIGNED)

# Compact style
compact = format_markdown_file(content, TableStyle.COMPACT)

# Tight style
tight = format_markdown_file(content, TableStyle.TIGHT)

# With aligned delimiter option
formatted = format_markdown_file(
    content, 
    style=TableStyle.COMPACT,
    aligned_delimiter=True
)
```

## Workflow

### Step 1: Identify Input Source

Determine where the markdown content is coming from:

**From user-uploaded file:**
```python
# File is in /mnt/user-data/uploads
content = open('/mnt/user-data/uploads/document.md').read()
```

**From user-provided text:**
```python
# Extract from conversation
content = user_message
```

**From existing file in conversation:**
```python
# User references a file they created earlier
content = open('/path/to/file.md').read()
```

### Step 2: Format the Tables

```python
from scripts.md060_formatter import format_markdown_file, TableStyle

# Choose appropriate style based on user preference or default to ALIGNED
style = TableStyle.ALIGNED  # or COMPACT, TIGHT

# Format all tables in the document
formatted_content = format_markdown_file(content, style=style)
```

### Step 3: Output the Result

**Save to outputs directory:**
```python
output_path = '/mnt/user-data/outputs/formatted_document.md'
with open(output_path, 'w') as f:
    f.write(formatted_content)
```

**For preview/display:**
```python
# Show formatted result to user
print(formatted_content)
```

## Advanced Features

### Preserving Column Alignment

The formatter automatically preserves column alignment markers:

- Left: `:---`
- Center: `:---:`
- Right: `---:`

These are maintained regardless of the formatting style chosen.

### Wide Character Support

The formatter correctly handles:

- **Emoji**: Counted as 2-width characters (✅, ❎, 👍)
- **CJK characters**: Chinese, Japanese, Korean characters (用户, 是的)

No special handling needed - the formatter automatically accounts for visual width.

### Tables Without Leading/Trailing Pipes

The formatter automatically normalizes tables:

**Input:**
```
Name | Age | City
---|---|---
Alice | 30 | NYC
```

**Output:**
```markdown
| Name  | Age | City |
| ----- | --- | ---- |
| Alice | 30  | NYC  |
```

## Common Patterns

### Format Single File

```python
from scripts.md060_formatter import format_markdown_file, TableStyle

# Read file
with open('/mnt/user-data/uploads/document.md', 'r') as f:
    content = f.read()

# Format
formatted = format_markdown_file(content, TableStyle.ALIGNED)

# Save
with open('/mnt/user-data/outputs/formatted_document.md', 'w') as f:
    f.write(formatted)
```

### Format Multiple Files

```python
import os
from scripts.md060_formatter import format_markdown_file, TableStyle

upload_dir = '/mnt/user-data/uploads'
output_dir = '/mnt/user-data/outputs'

for filename in os.listdir(upload_dir):
    if filename.endswith('.md'):
        input_path = os.path.join(upload_dir, filename)
        output_path = os.path.join(output_dir, f'formatted_{filename}')
        
        with open(input_path, 'r') as f:
            content = f.read()
        
        formatted = format_markdown_file(content, TableStyle.ALIGNED)
        
        with open(output_path, 'w') as f:
            f.write(formatted)
```

### Format Inline Markdown

```python
from scripts.md060_formatter import format_markdown_file, TableStyle

# User provides markdown text directly
markdown_text = """
# My Document

| Feature | Status |
|---|---|
| Auth | Done |
| API | In Progress |
"""

formatted = format_markdown_file(markdown_text, TableStyle.COMPACT)
print(formatted)
```

## Reference Materials

For detailed examples of each style and edge cases, see `references/examples.md`.

## Troubleshooting

### Tables Not Detected

- Verify table has header row and delimiter row
- Check delimiter row format: should be `|---|---|---|` pattern
- Ensure pipes are present (at minimum between columns)

### Unexpected Formatting

- Check for malformed delimiter rows
- Verify content doesn't have unescaped pipes in cell text
- Look for inconsistent column counts across rows

### Wide Character Issues

- Formatter handles emoji and CJK automatically
- If alignment looks wrong in output, check if terminal/viewer supports wide chars
- Visual width calculation is built-in, no configuration needed

## Technical Details

**Script location:** `scripts/md060_formatter.py`

**Key functions:**

- `format_markdown_file(content, style, aligned_delimiter)` - Main formatting function
- `format_markdown_table(table_lines, style)` - Format a single table
- `find_tables(content)` - Locate all tables in content

**Supported styles:** `TableStyle.ALIGNED`, `TableStyle.COMPACT`, `TableStyle.TIGHT`, `TableStyle.ANY`

**Python version:** 3.6+

**Dependencies:** None (uses only standard library)
