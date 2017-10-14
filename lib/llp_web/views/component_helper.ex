defmodule LlpWeb.ComponentHelper do
  alias LlpWeb.ComponentView

  def component(template, assigns) do
    ComponentView.render("#{template}.html", assigns)
  end
end
