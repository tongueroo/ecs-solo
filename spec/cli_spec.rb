describe EcsSolo::CLI do
  before(:all) do
    @args = "--noop"
  end

  describe "ecs-solo" do
    it "deploy" do
      out = execute("exe/ecs-solo deploy demo-web-development #{@args}")
      expect(out).to include("Will find task")
    end
  end
end
