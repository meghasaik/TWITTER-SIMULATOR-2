defmodule HelloWeb.RoomChannel do
  use Phoenix.Channel
  def join("room:lobby", message, socket) do
    if authorized?(message) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  def handle_in("loggin", log, socket) do
     IO.inspect("Logg")
     GenServer.call(:server, {:login, log})
     push socket, "loggedIn",  %{"log" => log}
     {:reply, :loggedIn, socket}
  end
  def handle_in("register", name, socket) do
      IO.inspect("Inside register")
        GenServer.call(:server, {:register, name, socket})
        push socket, "registered",  %{"name" => name}
        {:reply, :registered, socket}
    end
    def handle_in("subscribe", message, socket) do
      #IO.inpect("Inside subscribe")
       userName = message["name"]
       usersToSub = message["usersubs"] 
       GenServer.call(:server, {:followers, usersToSub, userName})
       push socket, "subscribed",  %{"userName" => userName}
       {:reply, :subscribed, socket}
    end
    def handle_in("tweet_now", message, socket) do
    IO.inspect("Inside tweets")
     tweetText = message["tweets"]
     userName = message["name"]
     GenServer.cast(:server, {:usertweet, {userName, tweetText}})
     {:noreply, socket}
   end
   
   'def handle_in("search", message, socket) do
        userName = message["username"]
        GenServer.cast(:server, {:search, userName})
        {:noreply, socket}
    end
    def handle_info({:search_result, tweetText}, socket) do
      push socket, "search_result", %{"searched_tweet" => tweetText}
      {:noreply, socket}
    end

   def handle_in("mentions", message, socket) do
      name = message["name"]
      GenServer.cast(:server, {:getmentions, name})
      {:noreply, socket}
    end
    def handle_info({:search_men, tweetText}, socket) do
      #IO.inspect ["search mentions", tweetText]
      push socket, "mentions", %{"searched_tweet" => tweetText}
      {:noreply, socket}
    end'

    def handle_in("logout", name, socket) do
        IO.inspect("Out of log")
          GenServer.call(:server, {:logout, name})
          push socket, "loggedOut",  %{"name" => name}
          {:reply, :loggedOut, socket}
      end
      
      def handle_info( {:tweetsub, user_id, tweettext},socket) do
        IO.inspect("I came back")
        {:reply, :tweetedback, socket}
      end
      
   def handle_info(tweetText, socket) do
      push socket, "tweetsub", tweetText
      {:noreply, socket}
    end
  defp authorized?(_message) do
    true
  end
end