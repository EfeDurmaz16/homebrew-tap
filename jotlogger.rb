# typed: false
# frozen_string_literal: true

class Jotlogger < Formula
  desc "Workflow-aware developer operations terminal for backend debugging"
  homepage "https://github.com/EfeDurmaz16/jot-logger"
  url "https://github.com/EfeDurmaz16/jot-logger.git",
      tag: "v0.1.0",
      revision: "5713fc92d6ebca15908436ddf51b469fc6cc0d6c"
  license "MIT"
  head "https://github.com/EfeDurmaz16/jot-logger.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/EfeDurmaz16/jot-logger/internal/cli.Version=#{version}
      -X github.com/EfeDurmaz16/jot-logger/internal/cli.Commit=#{Utils.git_head}
      -X github.com/EfeDurmaz16/jot-logger/internal/cli.Date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/jotlogger"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jotlogger version")
  end
end
