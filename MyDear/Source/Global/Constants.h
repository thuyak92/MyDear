//
//  Constants.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define HOST    @"http://52.69.239.6/"

#define GOOGLE_MAP_API_KEY      @"AIzaSyBMtizOqE1uJZhnsph34ZCKOM2GeQLJpZs"

//Segue identifier
#define SEGUE_HOME_TO_DETAIL            @"segueHomeToDetail"
#define SEGUE_HOME_TO_SEARCH            @"segueHomeToSearch"
#define SEGUE_MAP_TO_SEARCH             @"segueMapToSearch"
#define SEGUE_MAP_TO_DETAIL             @"segueMapToDetail"
#define SEGUE_POST_TO_POST_SETTING      @"SeguePostToPostSetting"
#define SEGUE_INFO_TO_LOGIN             @"SegueInfoToLogin"
#define SEGUE_LOGIN_TO_USER_INFO        @"segueLoginToUserInfo"

//Storyboard Identifier
#define STORY_BOARD_LOGIN               @"storyboardLogin"

//Tab bar
#define TAB_HOME        0
#define TAB_MAP         1
#define TAB_POST        2
#define TAB_TALK        3
#define TAB_INFO        4

//Class Name
#define CLASS_ERROR     @"error"
#define CLASS_POST      @"post"
#define CLASS_USER      @"user"

//URL
#define URL_USER        @"api/v1/users"
#define URL_POST        @"api/v1/posts"
#define URL_SEARCH      @"api/v1/posts/search"
#define URL_POST_DETAIL @"api/v1/posts/1"
#define URL_LOGIN       @"api/v1/login"
#define URL_REGISTER    @"api/v1/register"
#define URL_UPDATE_USER @"api/v1/users/%ld"

//Dictionary key
#define KEY_STATUS          @"status"
#define KEY_DATA            @"data"
#define KEY_SEARCH          @"search"
#define KEY_CURRENT_USER    @"currentUser"
#define KEY_DISTANCE        @"distance"
#define KEY_LOGIN_AS_GUEST  @"loginAsGuest"

//Response status
#define KEY_RESPONSE_STATUS_OK  1
#define KEY_RESPONSE_STATUS_NG  0

//Color
#define COLOR_TINT      @"#FF4545"
#define COLOR_DEFAULT   @"#333333"

//Formatter
#define TIME_FORMAT         @"HH:mm"
#define DATE_FORMAT         @"dd-MM-yyyy"
#define DATE_TIME_FORMAT    @"yyyy-MM-dd HH:mm"

#endif /* Constants_h */
