# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
    robot.respond /website find (.*)/i, (res) ->
        # Vars
        website_name = res.match[1]
        center_url = process.env.CENTER_API_ROOT
        center_token = process.env.CENTER_TOKEN

        robot.http("#{center_url}/en/api/websites/websites/?name=#{website_name}")
            .header("Authorization", "Token #{center_token}")
            .get() (err, resp, body) ->
                if err
                    res.reply "Encountered an error :( #{err}"
                    return

                data = JSON.parse body

                if data.results.length > 0
                    response = "I found this websites:\n"
                    for website in data.results
                        response += "#{website.name} - #{center_url}#{website.url}\n"
                else
                    response = "I coudn't find any website with the name or url: #{website_name}"

                res.reply response
                return

