*** Settings ***
Library  SeleniumLibrary     run_on_failure=Nothing
Library    Collections
Library    String

Test Teardown   Close Browser

*** Variables ***
${parent element}       //*[@id="ember58"]/td[1]/span
@{list_closed_topics}

*** Test Cases ***
Automation_Task_1
    [Tags]  test1
    Initial steps task1
    Go to Demo Page
    Scroll down
    Sleep   2
    Scroll down
    Sleep   2
    Get Closed Titles and Post with Highest Number of views
    Get Topics and Information about Category


*** Keywords ***
Initial steps task1
    Open Browser    https://www.discourse.org/     chrome
    Maximize Browser Window

Go to Demo Page
    Click Link  xpath=/html/body/nav/div/ul/li[4]/a
    Switch Window   title:Demo

Get Closed Titles and Post with Highest Number of views
    @{get_parent_elements}  Get WebElements     xpath://*[contains(@id,'ember')]

    Log to Console  ${\n}
    FOR     ${a}    IN      @{get_parent_elements}
        ${id_parent}=   Get Element Attribute  ${a}  id
        ${class_views_checker}=   Run Keyword And Ignore Error    Get Element Attribute  //*[@id="${id_parent}"]/td[4]   class
        ${contains}=  Evaluate   "heatmap-med" in """${class_views_checker}"""
        ${presence_checker} =   Run Keyword And Return Status   Element Should Be Visible   xpath://*[@id="${id_parent}"]/td[1]/span/div/span
        ${closed_title}=    Run Keyword If      ${presence_checker}     Get Text   xpath://*[@id="${id_parent}"]/td[1]/span/a
        ${title_highest_view}=    Run Keyword If      ${contains}     Get Text   xpath://*[@id="${id_parent}"]/td[1]/span/a
        Run Keyword If      ${title_highest_view != None}     Log to Console      The topic with highest number of views is: ${title_highest_view}
        Run Keyword If      ${closed_title != None}     Append To List      ${list_closed_topics}       ${closed_title}
    END
    ${first_element}   Remove From List    ${list_closed_topics}   0
    Log to Console      The list of closed topics are:
    FOR     ${b}    IN      @{list_closed_topics}
        Log to Console      ${b}
    END

Get Topics and Information about Category
     @{list_of_all_topics}  Get WebElements     //*[@class="title raw-link raw-topic-link"]
    ${number_of_topics}     Get Length      ${list_of_all_topics}

    #available categories: tech, general, discourse, videos, gaming, movies, sports, school, pics, music, pets
    @{tech_topics}   Get WebElements     //*[@class='category-name' and text()='tech']
    @{general_topics}   Get WebElements     //*[@class='category-name' and text()='general']
    @{discourse_topics}   Get WebElements     //*[@class='category-name' and text()='discourse']
    @{videos_topics}   Get WebElements     //*[@class='category-name' and text()='videos']
    @{gaming_topics}   Get WebElements     //*[@class='category-name' and text()='gaming']
    @{movies_topics}   Get WebElements     //*[@class='category-name' and text()='movies']
    @{sports_topics}   Get WebElements     //*[@class='category-name' and text()='sports']
    @{school_topics}   Get WebElements     //*[@class='category-name' and text()='school']
    @{pics_topics}   Get WebElements     //*[@class='category-name' and text()='pics']
    @{music_topics}   Get WebElements     //*[@class='category-name' and text()='music']
    @{pets_topics}   Get WebElements     //*[@class='category-name' and text()='pets']
    ${number_of_tech_topics}     Get Length      ${tech_topics}
    ${number_of_general_topics}     Get Length      ${general_topics}
    ${number_of_discourse_topics}     Get Length      ${discourse_topics}
    ${number_of_videos_topics}     Get Length      ${videos_topics}
    ${number_of_gaming_topics}     Get Length      ${gaming_topics}
    ${number_of_movies_topics}     Get Length      ${movies_topics}
    ${number_of_sports_topics}     Get Length      ${sports_topics}
    ${number_of_school_topics}     Get Length      ${school_topics}
    ${number_of_pics_topics}     Get Length      ${pics_topics}
    ${number_of_music_topics}     Get Length      ${music_topics}
    ${number_of_pets_topics}     Get Length      ${pets_topics}
    ${number_of_topics_without_category}    Evaluate      ${number_of_topics}-${number_of_tech_topics}-${number_of_general_topics}-${number_of_discourse_topics}-${number_of_videos_topics}-${number_of_gaming_topics}-${number_of_movies_topics}-${number_of_sports_topics}-${number_of_school_topics}-${number_of_pics_topics}-${number_of_music_topics}-${number_of_pets_topics}
    Log to Console  Number of Tech Topics: ${number_of_tech_topics}
    Log to Console  Number of General Topics: ${number_of_general_topics}
    Log to Console  Number of Discourse Topics: ${number_of_discourse_topics}
    Log to Console  Number of Videos Topics: ${number_of_videos_topics}
    Log to Console  Number of Gaming Topics: ${number_of_gaming_topics}
    Log to Console  Number of Movies Topics: ${number_of_movies_topics}
    Log to Console  Number of Sports Topics: ${number_of_sports_topics}
    Log to Console  Number of School Topics: ${number_of_school_topics}
    Log to Console  Number of Pics Topics: ${number_of_pics_topics}
    Log to Console  Number of Music Topics: ${number_of_music_topics}
    Log to Console  Number of Pet Topics: ${number_of_pets_topics}
    Log to Console  Number of Topics without category: ${number_of_topics_without_category}

Scroll down
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

