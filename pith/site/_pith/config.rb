project.assume_content_negotiation = true
project.assume_directory_index = true

project.helpers {
  def git_ref
    `git rev-parse --short HEAD`.strip
  end
}