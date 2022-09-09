pipeline{
    //指定用集群中的哪个节点
    agent any
    //声明全局变量
    environment {
        key = 'value'
    }

    stages{
       stage('拉取git仓库代码'){
          steps{
	          checkout([$class: 'GitSCM', branches: [[name: '${tag}']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/wornxiao/springboot-hello.git']]])
	      }
       }
       stage('通过maven构建项目'){
          steps{
                sh '/var/jenkins_home/maven/bin mvn clean package -DskipTest'
          }
       }
       stage('通过sonarQuebe做质量检测'){
          steps{
            echo '通过sonarQuebe做质量检查'
          }
       }
       stage('通过docker制作自定义镜像'){
          steps{
            echo '通过docker制作自定义镜像'
          }
       }
       stage('将自定义对象推送到harbor仓库中'){
          steps{
            echo '将自定义对象推送到harbor仓库中'
          }
       }
       stage('通过Publish Over SSH 通知目标主机'){
          steps{
            echo '通过Publish Over SSH 通知目标主机'
          }
       }
    }
}
