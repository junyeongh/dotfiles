# MD060 Formatting Examples and Reference

## Style Comparison

### Aligned Style (Default)

All columns are padded to align vertically. This is the most readable style in source form.

**Example:**
```markdown
| Name    | Age | City        |
| ------- | --- | ----------- |
| Alice   | 30  | New York    |
| Bob     | 25  | Los Angeles |
| Charlie | 35  | Chicago     |
```

### Compact Style

Minimal padding with single spaces. Balances readability and space efficiency.

**Example:**
```markdown
| Name | Age | City |
| --- | --- | --- |
| Alice | 30 | New York |
| Bob | 25 | Los Angeles |
| Charlie | 35 | Chicago |
```

### Tight Style

No padding - pipes directly adjacent to content. Most space-efficient.

**Example:**
```markdown
|Name|Age|City|
|---|---|---|
|Alice|30|New York|
|Bob|25|Los Angeles|
|Charlie|35|Chicago|
```

## Column Alignment Patterns

### Left-aligned (`:---`)

```markdown
| Name  | Age |
| :---- | :-- |
| Alice | 30  |
```

### Center-aligned (`:---:`)

```markdown
| Name  | Status |
| :---: | :----: |
| Alice |   OK   |
```

### Right-aligned (`---:`)

```markdown
| Name  | Price |
| ----- | ----: |
| Item  | 19.99 |
```

### Mixed alignment

```markdown
| Left  | Center | Right |
| :---- | :----: | ----: |
| A     |   B    |     C |
```

## Special Character Handling

### Emoji Support

The formatter correctly handles emoji as double-width characters:

```markdown
| User  | Status |
| ----- | ------ |
| Alice | ✅      |
| Bob   | ❎      |
```

### CJK Characters

Chinese, Japanese, and Korean characters render at double width:

```markdown
| Name  | Response |
| ----- | -------- |
| 李明  | 是的     |
| User1 | Yes      |
```

### Empty Cells

Empty cells (cells with no data) are handled properly in all styles:

**Aligned style:**
```markdown
| User    | Status |
| ------- | ------ |
| Alice   |        |
| Bob     |        |
```

**Compact style:**
```markdown
| User | Status |
| --- | --- |
| Alice | |
| Bob | |
```

**Tight style:**
```markdown
|User|Status|
|---|---|
|Alice||
|Bob||
```

## Common Use Cases

### Documentation Tables

Use **aligned** style for maximum readability:
```markdown
| Parameter | Type   | Description          |
| --------- | ------ | -------------------- |
| name      | string | The user's name      |
| age       | number | The user's age       |
| email     | string | The user's email     |
```

### Data Tables

Use **compact** style for balance:
```markdown
| ID | Name | Value |
| --- | --- | --- |
| 001 | Alpha | 42 |
| 002 | Beta | 87 |
| 003 | Gamma | 15 |
```

### Configuration Files

Use **tight** style for minimal footprint:
```markdown
|Key|Value|Type|
|---|---|---|
|host|localhost|string|
|port|8080|number|
|debug|true|boolean|
```

## Troubleshooting

### Tables Not Being Formatted

- Ensure table has at least 2 rows (header + delimiter)
- Verify delimiter row contains only dashes, colons, and pipes
- Check for at least one pipe character in each row

### Misaligned Wide Characters

- The formatter accounts for emoji and CJK characters automatically
- If alignment looks off, verify the terminal/editor supports wide characters

### Performance with Large Files

- The formatter processes tables in-place
- Large files with many tables may take a few seconds
- Use `--preview` to check before modifying files
