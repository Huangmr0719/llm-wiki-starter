#!/usr/bin/env bash
set -e

echo "========================================"
echo "  LLM Wiki Starter — Setup"
echo "========================================"
echo ""
echo "Choose your language / 选择语言:"
echo "  [1] English (default)"
echo "  [2] 中文 (Chinese)"
echo ""

read -p "Enter choice (1/2) [default: 1]: " choice
choice=${choice:-1}

if [ "$choice" = "2" ]; then
  LANG_DIR="i18n/zh-CN"
  echo ""
  echo "✓ 使用中文版本..."
else
  LANG_DIR="i18n/en"
  echo ""
  echo "✓ Using English version (root files are already in English)..."
fi

if [ "$choice" = "2" ]; then
  # Overwrite root files with Chinese versions
  cp "$LANG_DIR/CLAUDE.md" ./CLAUDE.md
  cp "$LANG_DIR/skills/ingest.md" ./skills/ingest.md
  cp "$LANG_DIR/skills/lint.md" ./skills/lint.md
  cp "$LANG_DIR/skills/query-and-keep.md" ./skills/query-and-keep.md
  echo "✓ CLAUDE.md + 3 skill files → 已切换为中文"
  echo ""
  echo "下一步:"
  echo "  1. 在 Obsidian 中打开此文件夹作为 vault"
  echo "  2. 安装并启用 'Local REST API' 社区插件"
  echo "  3. 复制 API Key，运行:"
  echo "     claude mcp add-json obsidian-vault '{ \"type\": \"stdio\", \"command\": \"uvx\", \"args\": [\"mcp-obsidian\"], \"env\": { \"OBSIDIAN_API_KEY\": \"你的密钥\", \"OBSIDIAN_HOST\": \"127.0.0.1\", \"OBSIDIAN_PORT\": \"27124\" } }'"
  echo "  4. 在 Claude Code 中说: '采访我，帮我填写 CLAUDE.md'"
else
  echo "✓ Root files are already in English. No changes needed."
  echo ""
  echo "Next steps:"
  echo "  1. Open this folder as a vault in Obsidian"
  echo "  2. Install and enable 'Local REST API' community plugin"
  echo "  3. Copy the API Key, run:"
  echo "     claude mcp add-json obsidian-vault '{ \"type\": \"stdio\", \"command\": \"uvx\", \"args\": [\"mcp-obsidian\"], \"env\": { \"OBSIDIAN_API_KEY\": \"your-key\", \"OBSIDIAN_HOST\": \"127.0.0.1\", \"OBSIDIAN_PORT\": \"27124\" } }'"
  echo "  4. In Claude Code, say: 'Interview me to fill out my CLAUDE.md'"
fi

echo ""
echo "========================================"
echo "  Setup complete! Happy thinking. 🧠"
echo "========================================"
