name "barbudos_application"

run_list(
  "role[barbudos_node]",
  "recipe[barbudos_application]"
)
