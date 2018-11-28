# frozen_string_literal: true

module PathHelper
  module_function

  def root_path
    ::Pathname.new(File.expand_path(File.join('..', '..'), __dir__))
  end

  def file_fixture(*names)
    root_path.join('spec', 'fixtures', 'files', ::File.join(names))
  end

  def tmp_path
    root_path.join('tmp')
  end
end
