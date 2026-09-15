Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174B3B83FC;
	Tue, 15 Sep 2026 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477271; cv=none; b=XTZnPwEptEj8u5EP9KUGskgHoEQ5yyIIDzh2x7RbNp2hANdxRZz7trS5ZCaj/ECfjlc0/q43GhL+s/iKGIPXtbQAMLXn9X7Jzv98K8laalIcwLtXBUBwcGe5IytIhHm3ys4rcFZIv2ftlqSFythJk++QckE00dOTCbjWt5hVsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477271; c=relaxed/simple;
	bh=X3yu9EpBrkDnQC2rpNCvAHoyo2oI73MPTKB/tYAsvrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SbHvC3g1a9ISH8Vk3LK8QKN9McMCeP4Q+puxHeOxh5vvdKwUEl+LoAOrst8S/8IiLAlKQV0xKNrjb1xdLbWY7yZu0L/x9vdZWW8VnApssShlNqGY5Sjx80oVqUVCuEGMmLr2EbSgoDBKS4InOn2ID7d3Kft4FEZ0anvcLJnYErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM6hoDYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM6hoDYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E17F1F000FF;
	Tue, 15 Sep 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477270;
	bh=DwrNzdpZsdBICzQS3joCbAAZTICEFFGqUOqLpF4/IqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jM6hoDYf7e3eYetsZv3kATelJT+mn44wj8+tKPT/+GFteMnHS4mYNgAHXLxZjuRR2
	 rHrfOlBP0eAZKBU5vKV8aRii/GUpkCJnskMoA7nibhyI6YB5rcVkzYps4RcFuIxvDe
	 NaJEUQJeB2jUyOjJsavaAXmVRm7/myfhuSHXycE5rH6qPG0Wk/5jaTxbER1Ql9QdCj
	 EPVB2/ewiTpSBeo82J5sBFQV95BScAZqzqgYznz9lJZuD25XV3mGTcjeXNLAibcjLI
	 j1zgI7fQxjGotlwtzIglHrotpqpyZNldrcDYsjKqDCl41hvUudybrX7Op3W5UYBCzm
	 3yAO4Z2s+ikKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2539263A4;
	Tue, 15 Sep 2026 13:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: hhf: cap hh_flows_limit at change time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178947720466.1607766.7479529593447485027.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 13:00:04 +0000
References: <QDISC-B855.v1.20260911153152@mojatatu.com>
In-Reply-To: <QDISC-B855.v1.20260911153152@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vtlam@google.com, stable@vger.kernel.org, victor@mojatatu.com,
 hybris@mojatatu.ai, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Sep 2026 14:09:19 -0400 you wrote:
> hhf_change() stores TCA_HHF_HH_FLOWS_LIMIT with no upper bound. A huge
> hh_flows_limit lets each new heavy-hitter flow pass the
> hh_flows_current_cnt check in alloc_new_hh() and forces a fixed-size
> kzalloc(GFP_ATOMIC) per flow under spoofed traffic, for unbounded memory
> growth.
> 
> Bound the attribute with NLA_POLICY_MAX() at 2*HH_FLOWS_CNT (the
> hhf_init() default) and report the rejected value via extack. The
> deprecated nested parse is kept: legacy tc does not set NLA_F_NESTED on
> TCA_OPTIONS. Configs relying on hh_limit above the default were relying
> on unbounded, unsafe behaviour and are not supported going forward.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: hhf: cap hh_flows_limit at change time
    https://git.kernel.org/netdev/net/c/2cef2588c995
  - [net,2/2] selftests/tc-testing: add hhf hh_limit cap tests
    https://git.kernel.org/netdev/net/c/0654f4dba1fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


