ESpec.configure fn(config) ->
  config.before fn(_tags) ->
    {:ok, %{answer: 42, order_spec_answer: 42}}
  end
  config.finally fn(shared) -> shared.answer end
end

Code.require_file("spec/support/assertions/check_error_shared_spec.exs")

path = Path.expand("../tmp/beams", __DIR__)
File.rm_rf!(path)
File.mkdir_p!(path)
Code.prepend_path(path)

defmodule ESpec.TestHelpers do
  def write_beam({:module, name, bin, _} = res) do
    beam_path = Path.join(unquote(path), Atom.to_string(name) <> ".beam")
    File.write!(beam_path, bin)
    res
  end
end
