#!/usr/bin/env bash
# 一键创建 GitHub 公开仓库 ai-personal-profile，推送内容，并建好待办 Issues。
# 前提：已安装 gh 并执行过 `gh auth login`。在本仓库目录内运行：bash setup_github.sh
set -euo pipefail

REPO=ai-personal-profile

gh repo create "$REPO" --public \
  --description "我的跨 AI 共享个人档案" \
  --source=. --remote=origin --push

gh repo edit --enable-issues

gh label create profile-update --color 0E8A16 --description "档案内容更新" --force

for section in "个人简介与背景" "工作与学习习惯" "沟通风格偏好" "常用工具与技术栈" "项目经验与成果" "长期目标"; do
  gh issue create --label profile-update \
    --title "[填充] ${section}" \
    --body "把 README 中「${section}」的示例条目替换为真实内容。完成后提交说明写 closes #编号。"
done

echo "完成：$(gh repo view --json url -q .url)"
