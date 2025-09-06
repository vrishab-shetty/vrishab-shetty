#!/bin/bash

# Function to update a section in README.md
update_section() {
    local section_name="$1"
    local template_file="$2"
    local readme_file="README.md"

    local start_marker="<!-- ${section_name}_START -->"
    local end_marker="<!-- ${section_name}_END -->"

    # Read the content from the template file
    local content
    content=$(cat "${template_file}")

    # Use sed to replace the content between the markers
    sed -i "/${start_marker}/,/${end_marker}/c\\${start_marker}\n${content}\n${end_marker}" "${readme_file}"
}

# Update the sections
update_section "WORKING_ON" "templates/working_on.md"
update_section "LEARNING" "templates/learning.md"
update_section "PROJECTS" "templates/projects.md"

echo "README.md has been updated successfully!"
