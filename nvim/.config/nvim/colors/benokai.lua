-- Benokai: Monokai colours on the terminal's own (dark) background.
-- Covers legacy syntax groups, Tree-sitter captures (@...), coc semantic tokens
-- (CocSem...) and coc's UI, so every language gets the same palette.

vim.cmd('highlight clear')
if vim.g.syntax_on then vim.cmd('syntax reset') end
vim.o.background = 'dark'
vim.g.colors_name = 'benokai'

local c = {
  fg        = '#ffffff',
  soft      = '#d0d0d0', -- punctuation
  dim       = '#bcbcbc',
  comment   = '#75715e',
  linenr    = '#6c6c6c',
  invisible = '#444444',
  selection = '#5f5f5f',
  ref       = '#3a3a3a', -- references to the symbol under the cursor
  ref_write = '#4e2a3a', -- ...where it gets assigned
  panel     = '#262626',
  search    = '#303030',
  line      = '#1c1c1c',
  gutter    = '#121212',
  pink      = '#ff005f',
  green     = '#afd700',
  cyan      = '#5fd7ff',
  purple    = '#af87ff',
  yellow    = '#d7d787',
  orange    = '#fd971f',
  lemon     = '#ffff5f',
}

local groups = {
  -- Editor UI
  Normal        = { fg = c.fg },
  NormalFloat   = { fg = c.fg, bg = c.panel },
  FloatBorder   = { fg = c.linenr, bg = c.panel },
  Cursor        = { fg = c.panel, bg = c.fg },
  CursorLine    = { bg = c.line },
  CursorColumn  = { bg = c.ref },
  ColorColumn   = { bg = c.ref },
  LineNr        = { fg = c.linenr, bg = c.gutter, bold = true },
  CursorLineNr  = { fg = c.yellow, bg = c.gutter, bold = true },
  SignColumn    = {},
  VertSplit     = { fg = c.selection, bg = c.selection },
  WinSeparator  = { link = 'VertSplit' },
  Visual        = { bg = c.selection },
  Search        = { fg = c.lemon, bg = c.search },
  IncSearch     = { fg = c.panel, bg = c.yellow },
  CurSearch     = { link = 'IncSearch' },
  MatchParen    = { fg = c.pink, underline = true },
  Folded        = { fg = c.comment, bg = c.panel },
  NonText       = { fg = c.invisible },
  SpecialKey    = { fg = c.invisible },
  Whitespace    = { fg = c.invisible },
  Directory     = { fg = c.purple },
  Title         = { fg = c.fg, bold = true },
  ErrorMsg      = { fg = c.fg, bg = c.pink },
  WarningMsg    = { fg = c.orange },
  StatusLine    = { fg = c.fg, bg = c.selection, bold = true },
  StatusLineNC  = { fg = c.fg, bg = c.selection },
  TabLineFill   = { fg = c.fg, bg = '#000000' },
  TabLine       = { fg = c.dim, bg = '#000000' },
  TabLineSel    = { fg = c.fg, bg = '#585858' },
  Pmenu         = { fg = c.dim, bg = c.panel },
  PmenuSel      = { fg = '#eeeeee', bg = c.ref, bold = true },
  PmenuSbar     = { bg = c.panel },
  PmenuThumb    = { bg = c.selection },
  DiffAdd       = { fg = c.fg, bg = '#5f8700', bold = true },
  DiffDelete    = { fg = '#870000' },
  DiffChange    = { fg = c.fg, bg = '#005f5f' },
  DiffText      = { fg = c.fg, bg = '#005f87', bold = true },

  -- Diagnostics (coc's CocError*/CocWarning* groups link to these)
  DiagnosticError          = { fg = c.pink },
  DiagnosticWarn           = { fg = c.orange },
  DiagnosticInfo           = { fg = c.cyan },
  DiagnosticHint           = { fg = c.dim },
  DiagnosticUnderlineError = { undercurl = true, sp = c.pink },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = c.orange },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = c.cyan },
  DiagnosticUnderlineHint  = { undercurl = true, sp = c.dim },
  DiagnosticUnnecessary    = { fg = c.comment },
  DiagnosticDeprecated     = { strikethrough = true },

  -- Legacy syntax groups (files without a Tree-sitter parser)
  Comment      = { fg = c.comment, italic = true },
  Constant     = { fg = c.purple },
  String       = { fg = c.yellow },
  Character    = { fg = c.purple },
  Number       = { fg = c.purple, bold = true },
  Float        = { fg = c.purple },
  Boolean      = { fg = c.purple, italic = true, bold = true },
  Identifier   = { fg = c.cyan, italic = true, bold = true },
  Function     = { fg = c.green, bold = true },
  Statement    = { fg = c.pink, bold = true },
  Conditional  = { fg = c.pink },
  Repeat       = { fg = c.pink },
  Label        = { fg = c.yellow },
  Operator     = { fg = c.pink },
  Keyword      = { fg = c.pink },
  Exception    = { fg = c.pink },
  PreProc      = { fg = c.pink },
  Include      = { fg = c.pink },
  Define       = { fg = c.pink },
  Macro        = { fg = c.green },
  Type         = { fg = c.cyan },
  StorageClass = { fg = c.cyan, italic = true },
  Structure    = { fg = c.purple },
  Typedef      = { fg = c.cyan },
  Special      = { fg = c.fg },
  SpecialChar  = { fg = c.purple },
  Tag          = { fg = c.pink, bold = true },
  Delimiter    = { fg = c.soft },
  Underlined   = { underline = true },
  Todo         = { fg = c.comment, reverse = true, bold = true },
  Error        = { fg = c.pink, underline = true },

  -- Tree-sitter: identifiers
  ['@variable']           = { fg = c.fg },
  ['@variable.builtin']   = { fg = c.orange, italic = true },  -- self, this
  ['@variable.parameter'] = { fg = c.orange, italic = true },
  ['@variable.member']    = { fg = c.fg },
  ['@property']           = { fg = c.fg },
  ['@constant']           = { fg = c.purple },
  ['@constant.builtin']   = { fg = c.purple, italic = true },  -- nil, None, true
  ['@module']             = { fg = c.fg, italic = true },      -- packages, imports
  ['@label']              = { fg = c.yellow },

  -- Tree-sitter: functions and types
  ['@function']             = { fg = c.green, bold = true },
  ['@function.call']        = { fg = c.green },
  ['@function.method']      = { fg = c.green, bold = true },
  ['@function.method.call'] = { fg = c.green },
  ['@function.builtin']     = { fg = c.cyan },
  ['@constructor']          = { fg = c.cyan },
  ['@type']                 = { fg = c.cyan },
  ['@type.builtin']         = { fg = c.cyan, italic = true },
  ['@type.definition']      = { fg = c.cyan, bold = true },
  ['@attribute']            = { fg = c.green, italic = true },  -- decorators

  -- Tree-sitter: keywords and punctuation
  ['@keyword']                 = { fg = c.pink },
  ['@keyword.function']        = { fg = c.cyan, italic = true }, -- func, def, function
  ['@keyword.type']            = { fg = c.cyan, italic = true }, -- type, struct, class
  ['@keyword.modifier']        = { fg = c.cyan, italic = true }, -- const, async, export
  ['@keyword.import']          = { fg = c.pink },
  ['@keyword.return']          = { fg = c.pink, bold = true },
  ['@operator']                = { fg = c.pink },
  ['@punctuation']             = { fg = c.soft },
  ['@punctuation.special']     = { fg = c.pink },               -- ${} in templates
  ['@string.escape']           = { fg = c.purple },
  ['@string.regexp']           = { fg = c.orange },
  ['@string.special']          = { fg = c.purple },
  ['@comment.documentation']   = { fg = c.comment, italic = true },
  ['@comment.todo']            = { link = 'Todo' },

  -- Tree-sitter: JSX/TSX and HTML
  ['@tag']           = { fg = c.pink },
  ['@tag.builtin']   = { fg = c.pink },
  ['@tag.attribute'] = { fg = c.green, italic = true },
  ['@tag.delimiter'] = { fg = c.soft },

  -- Tree-sitter: per-language touches
  ['@property.yaml']  = { fg = c.pink },
  ['@property.json']  = { fg = c.pink },
  ['@property.toml']  = { fg = c.pink },
  ['@property.css']   = { fg = c.cyan },
  ['@type.css']       = { fg = c.green },
  ['@property.scss']  = { fg = c.cyan },
  ['@type.scss']      = { fg = c.green },

  -- Tree-sitter: markdown
  ['@markup.heading']         = { fg = c.fg, bold = true },
  ['@markup.strong']          = { bold = true },
  ['@markup.italic']          = { italic = true },
  ['@markup.strikethrough']   = { strikethrough = true },
  ['@markup.link']            = { fg = c.cyan },
  ['@markup.link.url']        = { fg = c.orange, italic = true },
  ['@markup.link.label']      = { fg = c.cyan },
  ['@markup.raw']             = { fg = c.yellow },
  ['@markup.list']            = { fg = c.pink },
  ['@markup.quote']           = { fg = c.dim, italic = true },

  -- coc semantic tokens, only for what syntax alone can't know. init.vim turns
  -- off coc's default CocSem links (g:coc_default_semantic_highlight_groups), so
  -- token types not listed here (variable, keyword, string...) have no colour
  -- and Tree-sitter's finer one shows through.
  CocSemTypeParameter      = { link = '@variable.parameter' },
  CocSemTypeTypeParameter  = { fg = c.cyan, italic = true },
  CocSemTypeNamespace      = { link = '@module' },
  CocSemTypeType           = { link = '@type' },
  CocSemTypeClass          = { link = '@type' },
  CocSemTypeInterface      = { link = '@type' },
  CocSemTypeStruct         = { link = '@type' },
  CocSemTypeEnum           = { link = '@type' },
  CocSemTypeEnumMember     = { link = '@constant' },
  -- gopls says "definition", pyright and tsserver say "declaration"
  CocSemTypeModTypeDefinition          = { link = '@type.definition' },
  CocSemTypeModClassDeclaration        = { link = '@type.definition' },
  CocSemTypeModInterfaceDeclaration    = { link = '@type.definition' },
  CocSemTypeModVariableDefaultLibrary  = { link = '@variable.builtin' },
  CocSemTypeModTypeDefaultLibrary      = { link = '@type.builtin' },

  -- coc: references to the symbol under the cursor
  CocHighlightText  = { bg = c.ref },
  CocHighlightRead  = { bg = c.ref },
  CocHighlightWrite = { bg = c.ref_write },

  -- coc: UI
  CocFloating        = { link = 'NormalFloat' },
  CocFloatBorder     = { link = 'FloatBorder' },
  CocMenuSel         = { link = 'PmenuSel' },
  CocSearch          = { fg = c.cyan, bold = true },  -- matched letters in completion
  CocInlayHint       = { fg = c.comment, italic = true },
  CocUnusedHighlight = { link = 'DiagnosticUnnecessary' },
}

for name, spec in pairs(groups) do
  vim.api.nvim_set_hl(0, name, spec)
end
