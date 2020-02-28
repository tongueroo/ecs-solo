describe EcsSolo::CLI do
  before(:all) do
    @args = "--from Tung"
  end

  describe "ecs_solo" do
    it "hello" do
      out = execute("exe/ecs_solo hello world #{@args}")
      expect(out).to include("from: Tung\nHello world")
    end

    commands = {
      "hell" => "hello",
      "hello" => "name",
      "hello -" =>  "--from",
      "hello name" => "--from",
      "hello name --" => "--from",
    }
    commands.each do |command, expected_word|
      it "completion #{command}" do
        out = execute("exe/ecs_solo completion #{command}")
        expect(out).to include(expected_word) # only checking for one word for simplicity
      end
    end
  end
end
