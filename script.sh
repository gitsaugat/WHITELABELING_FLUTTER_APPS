#check app path
check_app_path(){
    echo "Checking if App exists"
    if test -d "$1"; then
        echo "✔️ App found"
        continue
    else
        echo "App doesnt exist or either you provided wrong path"
        exit 1
    fi 
}
#check icon path and check if file exists
check_icon_path(){
   echo "Chcecking if Icon Exists or not :)"
    if test -f "$1"; then
    echo "✔️ Icon found"
    continue
    else
        echo "your Icon file doesnt exist or either you provided wrong path"
        exit 1
    fi
}

#Install sed 

install_sed(){
    echo "Installing SED text editor"
    sudo apt install sed
}

#Copy icon to the path 

copy_icon_to_path(){
    if test -d "$2/icon";then 
        echo "Setting Icon"
        cp -r $1 $2
    else
        echo "Creating Icon Dir and Setting Icon"
        cd $2
        mkdir icon 
        cp -r $1 "$2/icon"
    fi
}

#ios change app name
configure_ios_configuration__APP_NAME(){

    local IOS_DIR_PATH="$1/ios/Runner"
    local IOS_CONFIGURATION_FILE="$1/ios/Runner/Info.plist"

    if test -d $1;then

        echo "Entering into the app [IOS] $IOS_DIR_PATH"
        cd "$IOS_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file Info.plist"
        echo "$IOS_CONFIGURATION_FILE"

        if test -f "$IOS_CONFIGURATION_FILE";then 

            echo "✔️ found Info.plist"
            echo "Naming the App to $2"
            sed -i "s/$3/$2/g" Info.plist
            echo "✔️ Successfully named the app"

        else
            echo "File doesnot exist"
            exit 1
        fi
    else
        echo "Directory doesnot exist"
        exit 1
    fi
}

#ios change package name
configure_ios_configuration__PACKAGE_NAME(){

    local IOS_DIR_PATH="$1/ios/Runner.xcodeproj/"
    local IOS_CONFIGURATION_FILE="$1/ios/Runner.xcodeproj/project.pbxproj"

    if test -d $IOS_DIR_PATH;then

        echo "Entering into the app [IOS] $IOS_DIR_PATH"
        cd "$IOS_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file Info.plist"

        if test -f "$IOS_CONFIGURATION_FILE";then 

            echo "✔️ found project.pbxproj"
            echo "Naming the App to $2"
            sed -i "s/$3/$2/g" project.pbxproj
            echo "✔️ Successfully named the package"

        else
            echo "File doesnot exist"
            exit 1
        fi
    else
        echo "Directory doesnot exist"
        exit 1
    fi
}

#android change app name
configure_android_configuration__APP_NAME(){

    local ANDROID_DIR_PATH="$1/android/app/src/main/"
    local ANDROID_CONFIGURATION_FILE="$1/android/app/src/main/AndroidManifest.xml"

    if test -d $ANDROID_DIR_PATH;then

        echo "Entering into the app[ANDROID] $ANDROID_DIR_PATH"
        cd "$ANDROID_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file info.plist"

        if test -f "$ANDROID_CONFIGURATION_FILE" ;then 

            echo "✔️ found AndroidManifest.xml"
            echo "Naming the App to $2"
            sed -i "s/$3/$2/g" AndroidManifest.xml
            echo "✔️ Successfully named the app"

        else
            echo "File doesnot exist"
            exit 1
        fi

    else
        echo "Directory doesnot exist"
        exit 1
    fi
}

#android change package name
configure_android_configuration__PACKAGE_NAME(){

    local ANDROID_DIR_PATH="$1/android/app/src/main/"
    local ANDROID_CONFIGURATION_FILE="$1/android/app/src/main/AndroidManifest.xml"

    if test -d $ANDROID_DIR_PATH;then

        echo "Entering into the app[ANDROID] $ANDROID_DIR_PATH"
        cd "$ANDROID_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file AndroidManifest.xml"

        if test -f "$ANDROID_CONFIGURATION_FILE" ;then 

            echo "✔️ found AndroidManifest.xml"
            echo "Naming the package to $2"
            sed -i "s/$3/$2/g" AndroidManifest.xml
            echo "✔️ Successfully named the package"

        else
            echo "File doesnot exist"
            exit 1
        fi

    else
        echo "Directory doesnot exist"
        exit 1
    fi
}
configure_android_configuration__PACKAGE_NAME_SECOND(){

    local ANDROID_DIR_PATH="$1/android/app/src/profile/"
    local ANDROID_CONFIGURATION_FILE="$1/android/app/src/profile/AndroidManifest.xml"

    if test -d $ANDROID_DIR_PATH;then

        echo "Entering into the app[ANDROID] $ANDROID_DIR_PATH"
        cd "$ANDROID_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file AndroidManifest.xml"

        if test -f "$ANDROID_CONFIGURATION_FILE" ;then 

            echo "✔️ found AndroidManifest.xml"
            echo "Naming the package to $2"
            sed -i "s/$3/$2/g" AndroidManifest.xml
            echo "✔️ Successfully named the package"

        else
            echo "File doesnot exist"
            exit 1
        fi

    else
        echo "Directory doesnot exist"
        exit 1
    fi
}

configure_android_configuration__PACKAGE_NAME_KOTLIN(){

    local ANDROID_DIR_PATH="$1/android/app/src/main/kotlin/com/daphne/primo/"
    local ANDROID_CONFIGURATION_FILE="$1/android/app/src/main/kotlin/com/daphne/primo/MainActivity.kt"

    if test -d $ANDROID_DIR_PATH;then

        echo "Entering into the app[ANDROID] $ANDROID_DIR_PATH"
        cd "$ANDROID_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file MainActivity.kt"

        if test -f "$ANDROID_CONFIGURATION_FILE" ;then 

            echo "✔️ found MainActivity.kt"
            echo "Naming the package to $2"
            sed -i "s/$3/$2/g" MainActivity.kt
            echo "✔️ Successfully named the package"

        else
            echo "File doesnot exist"
            exit 1
        fi

    else
        echo "Directory doesnot exist"
        exit 1
    fi
}
#android change application id
configure_android_configuration_APPLICATION_ID(){

    local ANDROID_DIR_PATH="$1/android/app/"
    local ANDROID_CONFIGURATION_FILE="$1/android/app/build.gradle"

    if test -d $ANDROID_DIR_PATH;then

        echo "Entering into the app[ANDROID] $ANDROID_DIR_PATH"
        cd "$ANDROID_DIR_PATH"
        echo "✔️ entered"
        echo "Searching file build.gradle"

        if test -f "$ANDROID_CONFIGURATION_FILE" ;then 

            echo "✔️ found build.gradle"
            echo "Naming the application id to $2"
            sed -i "s/$3/$2/g" build.gradle
            echo "✔️ Successfully changed application_id"

        else
            echo "File doesnot exist"
            exit 1
        fi

    else
        echo "Directory doesnot exist"
        exit 1
    fi
}
#create a new dir structure as package name [KOTLIN]

create_new_nested_directory_KOTLIN(){
    local KOTLIN_DIR="$1/android/app/src/main/kotlin/com/daphne/primo"
    local TEMP_DIR="$1/android/app/src/main/kotlin/"
    local NEW_DIR="test/$2"

    if test -d $TEMP_DIR;then
        cd $TEMP_DIR
        mkdir -p $NEW_DIR
        echo "created a new temp dir $NEW_DIR"
    else
        echo "$TEMP_DIR directory doesnt exist"
    fi 
}

copy_kt_extentioned_file_KOTLIN(){
    local KOTLIN_DIR="$1/android/app/src/main/kotlin/com/daphne/primo"
    local TEMP_DIR="$1/android/app/src/main/kotlin/"
    local NEW_DIR="test/$2"

    if test -d $KOTLIN_DIR;then
        if test -d "$TEMP_DIR/$NEW_DIR";then
            echo "Copying files from $KOTLIN_DIR TO $TEMP_DIR/$NEW_DIR"
            cp "$KOTLIN_DIR/MainActivity.kt" "$TEMP_DIR/$NEW_DIR"
            echo "Copied"
        else
            echo "$TEMP_DIR/$NEW_DIR directory not found"
            exit 1
        fi 
    else
        echo "$KOTLIN_DIR directory doesnt exist"
        exit 1
    fi
}

delete_old_package_KOTLIN(){
    local KOTLIN_DIR="$1/android/app/src/main/kotlin/"

    if test -d $KOTLIN_DIR;then
        cd $KOTLIN_DIR
        echo "Deleting previous directory $KOTLIN_DIR"
        rm -rf com
        echo "Deleted"
    else
        echo "$KOTLIN_DIR doesnt exist"
        exit 1
    fi
}

move_and_create_original_package_from_test_package_KOTLIN(){
    local TEMP_DIR="$1/android/app/src/main/kotlin/test/$2"
    
    if test -d $TEMP_DIR;then 
        cd "$1/android/app/src/main/kotlin/"
        echo "Moving $2 to original space"
        mv -v test/*  "$1/android/app/src/main/kotlin/"
        echo "Deleting Temp Directory"
        rm -rf test
        echo "Deleted"
    else
        echo "$TEMP_DIR doesnt exist"
        exit 1
    fi
}

check_and_add_gitattributes(){
    local gitattributes="
            ios/project.pbxproj merge=ours
            ios/runner/Info.plist merge=ours
            android/app/build.gradle merge=ours 
            android/app/src/main/AndroidManifest.xml merge=ours 
            android/app/src/main/kotlin merge=ours 
            android/app/src/main/AndroidManifest.xml merge=ours 
            android/app/src/main/kotlin/MainActivity.kt merge=ours
            android/app/src/debug/AndroidManifest.xml merge=ours
            android/app/src/profile/AndroidManifest.xml merge=ours
            "
    if test -f $1;then
        echo "you already have a merge strategy file gitignore"
        echo "a for replace b for keep "
        read choice 
        if test choice == a;then
            rm -rf "$1/.gitattributes"
            echo gitattributes > .gitattributes
        else
            continue
        fi 
    else
        echo "app dir not found"
    fi 
}

create_new_branch(){
    git checkout master 
    git pull 
    git checkout -b $1
}

push_new_branch(){
    git add .
    git commit -m "initial commit"
    git push --set-upstream origin $1
}

#configure_android
configure_android(){
    configure_android_configuration__APP_NAME $1 $2 $7
    configure_android_configuration__PACKAGE_NAME $1 $3 $5
    configure_android_configuration__PACKAGE_NAME_SECOND $1 $3 $5
    configure_android_configuration__PACKAGE_NAME_KOTLIN $1 $3 $5
    configure_android_configuration_APPLICATION_ID $1 $4 $6
}
#check paths
checkpaths(){
    check_app_path $1
    check_icon_path $2
}

#configure_ios
configure_ios(){
    configure_ios_configuration__APP_NAME $1 $2 $5
    configure_ios_configuration__PACKAGE_NAME $1 $3 $4

}

#kotlin directory renames and file handling
kotlin(){
    create_new_nested_directory_KOTLIN $1 $2
    copy_kt_extentioned_file_KOTLIN $1 $2 
    delete_old_package_KOTLIN $1 $2
    move_and_create_original_package_from_test_package_KOTLIN $1 $2
}

end_git_control(){
    check_and_add_gitattributes $1
    push_new_branch $2
}

start_git_control(){
    create_new_branch $1
}


# basic inputs and output

echo "Welcome to DAPHNE SOLUTIONS whitelabeling script :)"
echo "Enter a name for your Application eg: app :"
read __APP_NAME
echo "Enter the package name for your Application eg: com.example.company :"
read __PACKAGE_NAME
echo "Enter the application id for your Application eg: com.example.app"
read __APPLICATION_ID
echo "Enter the path where your App Icon exists :"
read __ICON_PATH
echo "Enter the path to the app to WhiteLabel :"
read __APP_PATH 
echo "Enter package name to replace"
read __TO_REPLACE_PACKAGE_NAME
echo "Enter App name to replace"
read __TO_REPLACE_APP_NAME
echo "Enter Application ID to replace"
read __TO_REPLACE_APPLICATION_ID
echo "Enter New Kotlin Package Path"
read __KOTLIN_NEW_PATH
echo "Enter a branch name eg: app/app-name-package-name use - instead of dots no space allowed"
read __BRANCH_NAME

#function executions
checkpaths $__APP_PATH $__ICON_PATH
install_sed
start_git_control $__BRANCH_NAME
copy_icon_to_path $__ICON_PATH $__APP_PATH
configure_ios $__APP_PATH $__APP_NAME $__PACKAGE_NAME $__TO_REPLACE_PACKAGE_NAME $__TO_REPLACE_APP_NAME
configure_android $__APP_PATH $__APP_NAME $__PACKAGE_NAME $__APPLICATION_ID $__TO_REPLACE_PACKAGE_NAME $__TO_REPLACE_APPLICATION_ID $__TO_REPLACE_APP_NAME
kotlin $__APP_PATH $__KOTLIN_NEW_PATH
git_control $__APP_PATH , $__BRANCH_NAME
echo "✔️ Done"

