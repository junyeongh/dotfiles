---
name: markdown-output
description: Guidelines for formatting markdown output, including structure and LaTeX math notation.
---

## Formatting Guidelines

**Structure**

- Follow user instructions on heading style
- Avoid section headings (`##`, `###`) unless explicitly requested
- Use **bold** for main topics and *italics* for subtopics within prose

**Mathematical Expressions (LaTeX)**

Only when user explicitly requests LaTeX math, use MathJax-compatible dollar sign notation:

| Type | Syntax | Example | When to Use |
| --- | --- | --- | --- |
| Inline | `$...$` | `$E=mc^2$` | Equations within a sentence |
| Block | `$$...$$` | See below | Standalone equations |

Block equation example:
```
$$
E = mc^2
$$
```

Do NOT use `\(`, `\)`, `\[`, or `\]` delimiters.
