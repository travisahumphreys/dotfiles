-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.hyprlang" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  --  { import = "astrocommunity.note-taking.obsidian-nvim" },
  { import = "astrocommunity.media.img-clip-nvim" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.programming-language-support.csv-vim" },
}
