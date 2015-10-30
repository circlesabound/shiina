module WelcomeHelper
   def result(skill)
      string = ["<div class='individual-result'>",
         "#{skill}",
         "</div>"].join("\n") + "\n"
   end
end
