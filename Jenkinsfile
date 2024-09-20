pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Pull code from your Git repository
                git url: 'https://github.com/gitober/TimeCalculator.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        // Run Maven build (use bat for Windows)
                        bat 'mvn clean package'
                    } catch (Exception e) {
                        echo "Build failed: ${e}"
                        throw e  // Stop the pipeline if the build fails
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    try {
                        // Run unit tests (use bat for Windows)
                        bat 'mvn test'
                    } catch (Exception e) {
                        echo "Tests failed: ${e}"
                        throw e  // Stop the pipeline if tests fail
                    }
                }
            }
            post {
                always {
                    // Publish JUnit test results
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Code Coverage') {
            steps {
                script {
                    try {
                        // Generate JaCoCo coverage report (use bat for Windows)
                        bat 'mvn jacoco:report'
                    } catch (Exception e) {
                        echo "Code coverage report generation failed: ${e}"
                        throw e  // Stop the pipeline if JaCoCo report generation fails
                    }
                }
            }
            post {
                always {
                    // Publish JaCoCo coverage report
                    jacoco execPattern: 'target/jacoco.exec',
                           classPattern: 'target/classes',
                           sourcePattern: 'src/main/java',
                           inclusionPattern: '**/*.class'
                }
            }
        }
    }

    post {
        always {
            // Cleanup workspace after the build is finished
            cleanWs()
        }
    }
}
