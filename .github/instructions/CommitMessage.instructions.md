---
name: Commit Message Generation
description: "Use when: generating SCM sparkle commit messages from staged changes with causality-first classification and required body bullets"
---

# Commit Message Generation Rules

Generate exactly one Conventional Commit message from the staged changes provided by VS Code.

Use only the provided staged-change context, optional ticket text, and optional user-provided commit intent. Do not invent missing facts.

Determine input sufficiency before classifying the commit. First decide whether the available context supports exactly one causal change with confidence.

Determine one causal change first. Derive the commit type from that causal change, not from file count, diff size, or the largest code block. Treat all other changes as follow-up work.

Causality model:
- The causal change is the smallest substantive change that fulfills the primary purpose of the commit.
- Follow-up changes are required only because of the causal change, such as tests, refactoring, interface adjustments, build changes, or import updates.
- If two or more plausible causal changes remain after reviewing the available context, explicitly mark causality as unclear instead of choosing one.
- If causality is unclear, use the narrowest evidence-backed type that can be justified. Use `chore` only when no narrower type is supported by evidence.

Prefer explicit behavioral evidence, failing scenarios, issue descriptions, and rename metadata over filenames or amount of change. If the context does not support one clear causal interpretation, keep the message conservative and explicitly mark the uncertainty.

Interaction mode:
- If no follow-up interaction is available, do not ask clarifying questions.
- If follow-up interaction is available, ask at most 2 concise clarification questions, and only when the answer materially affects the commit type or causal description.
- Do not ask questions that can be answered from the provided diff context.

Rename handling:
- Treat Git rename metadata such as `R100`, `rename from`, `rename to`, or similarity-based rename summaries as first-class evidence.
- Do not describe an evidenced rename as separate delete and add operations.
- If rename evidence is only indirect, use cautious wording such as `possible rename`.
- If rename confidence is unclear, state `Rename detection uncertain: not found`.
- If a rename is detected and at least one additional non-rename change exists, include both the rename and the additional change as separate bullets.

Type guardrails:
- Pure rename/move without behavior change -> `refactor` or `chore`.
- Typo or path correction that fixes broken or inconsistent references -> `fix`.
- Variable-only naming cleanup without behavior change -> `refactor`.
- New automation, tooling, or workflow file (e.g., `.agent.md`, `.instructions.md`, `.prompt.md`, CI pipeline, settings) that introduces a new developer-facing capability -> `feat`.
- Changes that only modify prose in existing documentation without introducing capability -> `docs`.
- Do not use `feat` for rename-only, naming-only, typo-only, or cleanup-only changes.
- Do not use `docs` for new configuration or tooling files simply because they are written in Markdown.

Header rules:
- Format must be `<type>[optional scope][optional !]: <description>`.
- The description must state the actual problem, risk, or inconsistency and the intended resolution.
- The description must answer both why the change was needed and what issue it solves.
- Avoid vague verbs such as `improve`, `enhance`, `update`, `cleanup`, or `optimize` unless the concrete problem is named.
- Prefer problem-oriented descriptions over activity-oriented descriptions.

Body rules:
- Always include a body after one blank line below the header.
- The body must be a single ordered bullet list.
- The first bullet must describe the causal change.
- Remaining bullets must describe follow-up changes in logical or causal order.
- If the available context is insufficient or conflicting, the first bullet must say `Causality unclear from provided context; not found.`

Output rules:
- Output only the final commit message.
- Output must be in English.
- No Markdown fences, no explanations, no preamble.
- Maximum 14 total lines.
- Use `not found` instead of inventing missing facts.

Target shape:

<type>[optional scope][optional !]: <description>

- <causal change>
- <follow-up change>
