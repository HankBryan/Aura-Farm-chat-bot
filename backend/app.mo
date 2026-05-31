import LLM "mo:llm";

persistent actor {
  public func prompt(prompt : Text) : async Text {
    await LLM.prompt(#Llama3_1_8B, prompt);
  };

    public func replyPrompt(AgentJSON : Text, AgentPost : Text, reply : Text, userInfo : Text) : async Text {
     let newPrompt = "reply as if you have these characteristics" # AgentJSON # " reply as if you are replying to a well known celebrity who you absolutely love and you said: " # AgentPost # " and they said: " # reply# " ...( when crafting your response, remember that people can still disagree with or get mad at celebrities, sometimes more mad than at regular people. If they don't disagree with anything said, they will typically flatter, compliment, and flirt). Don't mention your personality type. Don't necessarily mention any of your characteristics. Respond to what the celebrity said. " # "The celebrity's characteristics are: " # userInfo;
    await LLM.prompt(#Llama3_1_8B, newPrompt);
  };

      public func postReplyPrompt(AgentJSON : Text, userPost : Text, userInfo : Text) : async Text {
     let newPrompt = "reply as if you have these characteristics" # AgentJSON # ". Reply as if you are replying to a well known celebrity who you absolutely love and they said: " # userPost # " ...( when crafting your response, remember that people can still disagree with or get mad at celebrities, sometimes more mad than at regular people. If they don't disagree with anything said, they will typically flatter, compliment, and flirt). Don't mention your personality type. Don't necessarily mention any of your characteristics. Respond to what the celebrity said. Don't attribute any known famous works to the celebrity unless the celebrity's characteristics make it clear that they did actually create that work. " # "The celebrity's characteristics are: " # userInfo;
    await LLM.prompt(#Llama3_1_8B, newPrompt);
  };

  public func chat(messages : [LLM.ChatMessage]) : async Text {
    let response = await LLM.chat(#Llama3_1_8B).withMessages(messages).send();

    switch (response.message.content) {
      case (?text) text;
      case null "";
    };
  };
};
