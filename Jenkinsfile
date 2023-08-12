@Library('shared-libraries2') _

pipeline {
    agent any

    environment {
        IMAGE_NAME = '' // Placeholder for dynamic image name
    }
    stages {
        stage('Checkout Source') {
            steps {
                script {
                    try {
                      setJobDisplayName() // Calling the shared library function
                        checkoutScm()
                    } catch(Exception e) {
                        error "Failed during Checkout Source stage: ${e.message}"
                    }
                }
            }
        }

        stage('Unit Test') {
            steps {
                script {
                    try {
                        decisionWrapper('Unit Test') {
                            gradleUnitTest()
                        }
                    } catch(Exception e) {
                        error "Unit Test stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Integration Test') {
            steps {
                script {
                    try {
                        decisionWrapper('Integration Test') {
                            gradleIntegrationTest()
                        }
                    } catch(Exception e) {
                        error "Integration Test stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Decision: Helm Lint') {
            steps {
                script {
                    try {
                        decisionWrapper('Helm Lint') {
                            runHelmLint()
                        }
                    } catch(Exception e) {
                        error "Helm Lint stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    try {
                        env.IMAGE_NAME = buildImage()
                    } catch(Exception e) {
                        error "Build Image stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Blackduck Scan') {
            steps {
                script {
                    try {
                        decisionWrapper('Blackduck Scan') {
                            blackduckScan('.')
                        }
                    } catch(Exception e) {
                        error "Blackduck Scan stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Veracode Scan') {
            steps {
                script {
                    try {
                        decisionWrapper('Veracode Scan') {
                            veracodeScan('.')
                        }
                    } catch(Exception e) {
                        error "Veracode Scan stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Push to Artifactory') {
            steps {
                script {
                    try {
                        pushToArtifactory(env.IMAGE_NAME, 'http://my.artifactory.url')
                    } catch(Exception e) {
                        error "Push to Artifactory stage failed with error: ${e.message}"
                    }
                }
            }
        }

        stage('Cleanup Workspace') {
            steps {
                script {
                    try {
                        cleanupWorkspace()
                    } catch(Exception e) {
                        error "Workspace cleanup failed with error: ${e.message}"
                    }
                }
            }
        }
    }
}