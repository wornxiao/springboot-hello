pipeline{
    //指定用集群中的哪个节点
    agent any
    //声明全局变量
    environment {
        harbor_name = 'admin'
        harbor_pass ='Harbor12345'
        harbor_addr = '192.168.189.129:8081'
        harbor_repo = 'wornxiao'
    }

    stages{
       stage('拉取git仓库代码'){
          steps{
	          checkout([$class: 'GitSCM', branches: [[name: '${tag}']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/wornxiao/springboot-hello.git']]])
	      }
       }
       stage('通过maven构建项目'){
          steps{
             sh 'mvn clean package -DskipTest'
          }
       }
       stage('通过sonarQuebe做质量检测'){
          steps{
            echo '通过sonarQuebe做质量检查'
          }
       }
       stage('通过docker制作自定义镜像'){
          steps{
           sh '''mv target/*.jar ./docker
docker build -t ${JOB_NAME}:$tag docker '''
          }
       }
       stage('将自定义对象推送到harbor仓库中'){
          steps{
		  sh '''docker login -u ${harbor_name} -p ${harbor_pass} ${harbor_addr}
              docker tag ${JOB_NAME}:${tag}  ${harbor_addr}/${harbor_repo}/${JOB_NAME}:${tag}
              docker push ${harbor_addr}/${harbor_repo}/${JOB_NAME}:${tag}
              docker image prune -f'''
          }
       }
       stage('将yml文件 上传到k8s集群主机'){
          steps{
             sshPublisher(publishers: [sshPublisherDesc(configName: 'k8s', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'pipeline.yml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
          }
       }
       stage('远程交付yml资源到k8s集群'){
          steps{
           sh 'ssh root@192.168.189.131 kubectl apply -f /usr/local/k8s/pipeline.yml'
          }
       }
     }
}
