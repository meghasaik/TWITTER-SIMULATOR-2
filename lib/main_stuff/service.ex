defmodule Service_Provider do
#  use GenServer
def tables() do
  :ets.new(:usertable, [:set, :public, :named_table])
  :ets.new(:subscribers, [:set, :public, :named_table])
  :ets.new(:tweet, [:set, :public, :named_table, {:read_concurrency, true}, {:write_concurrency, true}])
  :ets.new(:hashtag, [:set, :public, :named_table, {:read_concurrency, true}, {:write_concurrency, true}])
  :ets.new(:mention, [:set, :public, :named_table, {:read_concurrency, true}, {:write_concurrency, true}])
  :ets.new(:subscribed_to, [:set, :public, :named_table])
  :ets.new(:users_logged_in, [:set, :public, :named_table])
  IO.puts("created")
end  
def user_register( username, userID) do
  :ets.insert_new(:usertable, { username, userID})
  IO.inspect("Inserted element-user_register")
end  
def user_remove(user_id) do
  :ets.delete(:usertable, user_id)
end
def user_log(userID) do
  if :ets.member(:usertable, userID) do
    :ets.insert(:users_logged_in, {userID})
else
  False
end
  IO.puts("loggedin")
end
def is_user_logged(userID) do
  IO.puts("check logging")
  :ets.member(:users_logged_in, userID)
 end
 def container(table, value, key) do
   if :ets.lookup(table, key) == [] do
     :ets.insert(table, {key, []})
     IO.puts("Inserted in table with null")
   else 
   [ele]= :ets.lookup(table, key)
   list= elem(ele,1)
   list = [value | list]
   :ets.insert(table, {key, value})
   IO.puts("Inserted in table without null")
 end
 end
 def followers_to_user( followerslist, user_id) do
      followerslist =
        Enum.filter(followerslist, fn sub -> :ets.member(:usertable, sub) end)
        container(:subscribed_to, followerslist, user_id)
      #  container(:subscribed_to, user_id, followerslist)

      Enum.each(followerslist, fn sub ->
        container(:subscribers, [user_id], sub)
        #container(:subscribers, sub, [user_id]) 
      end) 
      followerslist
 end
 def tweet_writing(tweet_string, userID) do
  if getId(userID) == [] do
    IO.puts("The user does not exist" <> userID)
  end
  IO.puts("tweeted1")
  { _, mentions} = DosProject4.get_mention_info(tweet_string)
  { _, hashtags} = DosProject4.get_hashtag_info(tweet_string)
  #container(:tweet, userID, tweet_string)
  container(:tweet, tweet_string, userID)
  Enum.each(mentions, fn usermention ->
    container(:mention, tweet_string, usermention)
  end)
  Enum.each(hashtags, fn userhashtag ->
    container(:hashtag, tweet_string, userhashtag)
  end)
 end
 
 def get_usertweet(user_id) do
   result = :ets.lookup(:tweet, user_id)
   if result == [] do
     result
   else
     [{_, tweet}] = result
     tweet
   end
 end

"def get_mention_info(tweet_string) do
  mention = Regex.scan(~r/@[a-z0-9A-Z_]*/, tweet_string) |> List.flatten
  {tweet_string,mention}
end

def get_hashtag_info(tweet_string) do
  hashtag = Regex.scan(~r/\#[a-z0-9A-Z_]*/, tweet_string) |> List.flatten
  {tweet_string , hashtag}
end"

 def mentioned_tweets(user_id) do
   result = :ets.lookup(:mention, user_id)
  
   if result == [] do
     result
    # IO.inspect(result)
   else
     [{_user, mentweet}] = result
     mentweet
     #IO.inspect(mentweet)
   end
   
 end

 def hashtagged_tweets(user_id) do
   result = :ets.lookup(:hashtag, user_id)
   if result == [] do
     result
   else
     [{_user, hash}] = result
     hash
   end
 end


 def get_user_subcribers(user) do
    pid = :ets.lookup(:subscribers, user)
  # pid = :ets.lookup(:subscribed_to, user)
#   IO.puts("Going to service")
   if pid == [] do
     
  #   IO.puts("User subcribers :1")
     pid
   else
     [{_user, subs}] = pid
     
    # IO.puts("User subcribers:2")
     subs
   end
  end
 def getId(username) do
       pid = :ets.lookup(:usertable, username)
    #   IO.puts("Going to lookup")
    if pid == [] do  
      pid
    #  IO.puts("User id:1")
    else
      [{_, result}] = pid
    result
  #  IO.puts("User id:2")
  end
end
  def user_log_off(username) do
    :ets.delete(:usertable, username)
  end
end
 

