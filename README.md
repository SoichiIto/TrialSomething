# Test
Test


・GitHub Actions テスト
　・self -hosted  runner 1つのランナーに対して実行できるJObの数は１つまで
　・複数の有効なself -hosted  runnerが存在すれば並列でJOBが割り当てられる
　・１つの端末に複数のランナーを設定することができる
　　　ワークディレクトリを複数作成し各々にrunnerのCongifを実施。
　　　ランナー名を別々にする

　・self-hosted runnerの自動スケーリング
　　ARC

　参考
　　・Actions
　　　https://docs.github.com/ja/actions/learn-github-actions/understanding-github-actions
　　　https://docs.github.com/ja/actions/using-workflows/workflow-syntax-for-github-actions
　　　https://zenn.dev/hsaki/articles/github-actions-component
　　　https://speakerdeck.com/oracle4engineer/get-started-github-actions
     https://docs.github.com/ja/actions/examples/using-scripts-to-test-your-code-on-a-runner

　　・self-hosted runnerの自動スケーリング
　　　https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners/autoscaling-with-self-hosted-runners
　　　https://swet.dena.com/entry/2023/02/28/100000

　・WebHook
　　　https://docs.github.com/ja/webhooks
　　　https://docs.github.com/ja/webhooks/webhook-events-and-payloads#workflow_job

　・MarketPlace
　　https://github.com/marketplace?type=actions


 ・RunnerをServiceとして設定する
 　https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service?platform=windows
　　　Start-Service "actions.runner.*"
 　　Stop-Service "actions.runner.*"
 　　Get-Service "actions.runner.*"

  ・コマンドラインからMATLAB起動
  　https://jp.mathworks.com/help/matlab/ref/matlabwindows.html