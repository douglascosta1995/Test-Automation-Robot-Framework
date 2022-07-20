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

Automation_Task_2
    [Tags]  test2
    Initial steps task2
    Go to second page
    Get information about Second and Third posts
    Scroll down
    Get School address

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

Initial steps task2
    Open Browser    https://www.cesar.school/     chrome
    Maximize Browser Window
    Sleep   3
    Click Link  //*[@id="menu-item-8945"]/a

Go to second page
    Click Link  //*[@id="primary"]/div/nav/div/a[3]

Get information about Second and Third posts
    @{get_parent_post_elements}  Get WebElements     xpath://*[contains(@id,'post')]
    ${remove_first_post}   Remove From List    ${get_parent_post_elements}   0
    ${index}    Set Variable    ${0}
    Log to Console  ${\n}
    FOR     ${a}    IN      @{get_parent_post_elements}
        ${index}     Evaluate    ${index}+1
        ${id_parent}=   Get Element Attribute  ${a}  id
        ${second_post_title}=   Run Keyword If  ${index == 1}   Get Text    xpath://*[@id="${id_parent}"]/div/div/header/h2/a
        ${month_second_post_title}=   Run Keyword If  ${index == 1}     Get Text    xpath://*[@id="${id_parent}"]/div/div/div[1]/a/div/span/time[1]/span[1]
        ${day_second_post_title}=   Run Keyword If  ${index == 1}   Get Text  xpath://*[@id="${id_parent}"]/div/div/div[1]/a/div/span/time[1]/span[2]
        ${year_second_post_title}=   Run Keyword If  ${index == 1}  Get Text   xpath://*[@id="${id_parent}"]/div/div/div[1]/a/div/span/time[1]/span[3]
        ${third_post_title}=    Run Keyword If  ${index == 2}   Get Text    xpath://*[@id="${id_parent}"]/div/div/header/h2/a
        ${author_post_title}=   Run Keyword If  ${index == 2}   Get Text    xpath://*[@id="${id_parent}"]/div/div/header/div/span[2]/a/span
        Run Keyword If  ${index == 2}   Click Link      //*[@id="${id_parent}"]/div/div/header/h2/a
        Run Keyword If  ${index == 1}   Log to Console  Título do segundo post: ${second_post_title}
        Run Keyword If  ${index == 1}   Log to Console  Data do segundo post: ${day_second_post_title}/${month_second_post_title}/${year_second_post_title}
        Run Keyword If  ${index == 2}   Log to Console  Título do terceito post: ${third_post_title}
        Run Keyword If  ${index == 2}   Log to Console  Autor do terceito post: ${author_post_title}
        IF  ${index == 2}   BREAK
    END

Scroll down
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Get School address
    ${where}     Get WebElements      xpath://*[@class="onde"]/p
    ${address_school}=   Get Text  ${where}
    Log to Console  Endereço do School: ${address_school}

