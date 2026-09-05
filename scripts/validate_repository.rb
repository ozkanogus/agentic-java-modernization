#!/usr/bin/env ruby
# frozen_string_literal: true

require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).parent.realpath
SKILL = ROOT / "skills/agentic-java-modernization"
errors = []

required = %w[
  README.md AGENTS.md CONTRIBUTING.md LICENSE
  docs/architecture.md docs/case-studies/spring-boot-sample-erp.md
  skills/agentic-java-modernization/SKILL.md
  skills/agentic-java-modernization/agents/openai.yaml
  skills/agentic-java-modernization/assets/AGENTS.template.md
  skills/agentic-java-modernization/assets/MIGRATION_PLAN.template.md
  skills/agentic-java-modernization/assets/MIGRATION_REPORT.template.md
  skills/agentic-java-modernization/assets/README.template.md
  skills/agentic-java-modernization/assets/REPOSITORY_PROFILE.template.md
  skills/agentic-java-modernization/assets/TEST_BASELINE.template.md
  skills/agentic-java-modernization/references/branching.md
  skills/agentic-java-modernization/references/production-readiness.md
]
required.each { |path| errors << "missing required file: #{path}" unless (ROOT / path).file? }

yaml_files = Dir.glob(ROOT.join("**/*.{yml,yaml}").to_s, File::FNM_DOTMATCH)
yaml_files.each do |file|
  begin
    parsed = YAML.safe_load(File.read(file), permitted_classes: [], aliases: false)
    errors << "YAML root is not a mapping: #{Pathname.new(file).relative_path_from(ROOT)}" unless parsed.is_a?(Hash)
  rescue Psych::Exception => e
    errors << "invalid YAML #{Pathname.new(file).relative_path_from(ROOT)}: #{e.message.lines.first.strip}"
  end
end

skill_text = (SKILL / "SKILL.md").read
frontmatter = skill_text.match(/\A---\n(.*?)\n---\n/m)
if frontmatter.nil?
  errors << "SKILL.md has no YAML frontmatter"
else
  begin
    metadata = YAML.safe_load(frontmatter[1], permitted_classes: [], aliases: false)
    errors << "SKILL.md name must be agentic-java-modernization" unless metadata["name"] == "agentic-java-modernization"
    errors << "SKILL.md description is missing" unless metadata["description"].is_a?(String) && !metadata["description"].strip.empty?
    errors << "SKILL.md license must remain Apache-2.0" unless metadata["license"] == "Apache-2.0"
  rescue Psych::Exception => e
    errors << "invalid SKILL.md frontmatter: #{e.message.lines.first.strip}"
  end
end

markdown_files = Dir.glob(ROOT.join("**/*.md").to_s, File::FNM_DOTMATCH)
markdown_files.each do |file|
  path = Pathname.new(file)
  text = path.read
  text.scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |raw_target|
    target = raw_target.strip.sub(/\A<|>\z/, "")
    next if target.empty? || target.start_with?("#")
    next if target.match?(%r{\A(?:https?|mailto):}i)

    file_part = target.split("#", 2).first
    next if file_part.empty?

    resolved = path.dirname.join(file_part).cleanpath
    unless resolved.to_s.start_with?(ROOT.to_s + File::SEPARATOR) && resolved.exist?
      errors << "broken local link in #{path.relative_path_from(ROOT)}: #{target}"
    end
  end
end

template_sections = {
  "README.template.md" => %w[Business\ Context Architecture\ Overview Local\ Development Testing Deployment],
  "AGENTS.template.md" => %w[Commands Critical\ Areas Required\ Verification Modernization\ Constraints],
  "REPOSITORY_PROFILE.template.md" => %w[Platform\ and\ Build Tests\ and\ Baseline Unknowns\ and\ Required\ Decisions],
  "TEST_BASELINE.template.md" => %w[Baseline\ Summary Critical\ Behavior\ Protection Coverage Baseline\ Gate],
  "MIGRATION_PLAN.template.md" => %w[Recommended\ Target Migration\ Graph Branching\ and\ Production\ Synchronization Stages Execution\ Rule],
  "MIGRATION_REPORT.template.md" => %w[Outcome Verification\ Summary Production\ Readiness\ Findings Deployment,\ Regression,\ and\ UAT Remaining\ Risks\ and\ Follow-up]
}
template_sections.each do |file, sections|
  content = (SKILL / "assets" / file).read
  sections.each do |section|
    heading = section.tr("\\", "")
    errors << "#{file} missing section: #{heading}" unless content.match?(/^## #{Regexp.escape(heading)}$/)
  end
end

if errors.empty?
  puts "Repository validation passed (#{yaml_files.length} YAML files, #{markdown_files.length} Markdown files)."
  exit 0
end

warn errors.map { |error| "ERROR: #{error}" }.join("\n")
exit 1
