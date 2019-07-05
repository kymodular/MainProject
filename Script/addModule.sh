#!/bin/bash

# 计时
SECONDS=0

# 时间
get_date() {
    date=`date '+%Y-%m-%d-%H-%m-%S'`
    return $date;
}

create_module() {
    category_template_git="https://github.com/kymodular/category-pod-template.git"
    module_template_git="https://github.com/kymodular/module-pod-template.git"

    echo "\033[32mstart configure\033[0m"
    read -p "Enter a module name: " module_name

    module_category_name="${module_name}_Category"

    echo "\033[32mcreate $module_category_name\033[0m"
    cd ../
    pod lib create $module_category_name --template-url=$category_template_git
    pod lib create $module_name --template-url=$module_template_git

    cd ./MainProject/

    plistPath="./MainProject/ModuleData.plist" 

    /usr/libexec/PlistBuddy \
    -c "add :0 dict" \
    -c "add :0:moduleName string $module_name" \
    -c "add :0:name string $module_name" \
    -c "add :0:description string 'auto add'" \
    $plistPath

    podCommandModuleCategory="pod \"$module_category_name\", :path => \"../$module_category_name/\""
    podCommandModule="pod \"$module_name\", :path => \"../$module_name/\""

    sed -i "" "/auto input depend end/ i\\
    $podCommandModuleCategory
    " Podfile

    sed -i "" "/auto input depend end/ i\\
    $podCommandModule
    " Podfile

    pod install
}


