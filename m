Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF03FCB37;
	Tue, 25 Aug 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657469; cv=none; b=QQ2naUgvLjxHECE0UE+N/G9136BNnAGkCjB7AnPOWNEDHqthX5i8L8H+ztFU900SVUimCohR2LVDYpWBVSR+ry70CoKsGdqqSLJVRl7u2Q5EhS4W6+d+T3e1zBy4UyHuiIc28BgjLv4vx6pNxxSv2VIEt0en3FNUHvXHBgeKO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657469; c=relaxed/simple;
	bh=VjJko0yA3d3YUMxZUcmEj/Vhj9nnISoGVu0m8VeLzBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Acrw/WcAR6BXzyVR1TR7f2SJq8rQNAqyEoR7UBy2F08c7CQ2g1TdKi+pGL867+U36HflxQGmQ1shdCSNl2Iaziqts6PDPvY9JwUpNDuStvXVYz+c510gpZbPG2TkYBHNe5p1Th/Gcb1it0q1JqHjFbyb3WPJc9U9ekZdSsbcrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyUYwbSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyUYwbSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB981F000E9;
	Tue, 25 Aug 2026 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657467;
	bh=w1SXzpz7rikUBZtWYHQVrdcAXSUIx0iFDqOEdDDx3Qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LyUYwbSIdBWTCB7Iiyt2+L9a/zD6fPaegOurpi2U+KOz3gt8f1eE9iIM98kBvX3fi
	 tX4tgt7eKNJdGw2+8UiXXcIzc/FCnIlm1JgjBxn5ipnMNjcada76N3j4lTmhc2duep
	 27DKAcuiidmEGFUV/cXgbN+DRt1vpsewvxQERfeA+lfXeERQxCTPi6wTKm/xn+wcx8
	 wajj3nliZD4L3Xv9KcM7uN+M7x9sLcjjG9cINVaoRd4J8uaDqw/ZOz14nWOH8djH0F
	 NLkSkzHmg1W8Bl4aNlb6kpZIB2TgvIqQ7zX/xdjIxTOvjru5Wk1KzzY1OC34zw3vMb
	 W5TwO0gWaw5fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03F073924FD4;
	Tue, 25 Aug 2026 11:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/6] net: sched: fix quantum/mtu overflow in fq,
 fq_codel, sch_codel, fq_pie, hhf, sfq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178765741495.3403300.2275787044891472077.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 11:30:14 +0000
References: <20260822195509.112717-1-jhs@mojatatu.com>
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tahiliani@nitk.edu.in, sdp.sachin@gmail.com, vsaicharan1998@gmail.com,
 mohitbhasi1998@gmail.com, lesliemonis@gmail.com, gautamramk@gmail.com,
 vtlam@google.com, stable@vger.kernel.org, vega@nebusec.ai,
 victor@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Aug 2026 15:55:03 -0400 you wrote:
> Several qdiscs derive their per-flow quantum or CoDel mtu from
> psched_mtu() without an overflow or zero clamp, which can drive the
> dequeue/credit-refill loop into a soft lockup or silently disable the
> AQM. vega@nebusec.ai provided reports and PoCs for the following qdiscs:
> sch_fq, sch_fq_codel, sch_fq_pie, sch_hhf, and sch_sfq.
> 
> sch_codel was found by inspection for the same pattern. It's TheLinuxWay
> (i.e cutnpaste code from somewhere for your new feature) and the AIs
> are having a lot of fun finding patterns. We must overcome!
> 
> [...]

Here is the summary with links:
  - [net,v3,1/6] net/sched: fq: add overflow bounds to quantum and initial quantum
    https://git.kernel.org/netdev/net/c/709f34f7c28d
  - [net,v3,2/6] net/sched: fq_codel: clamp default quantum and mtu
    https://git.kernel.org/netdev/net/c/d9ebd8f9aa8b
  - [net,v3,3/6] net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
    https://git.kernel.org/netdev/net/c/6439461f1618
  - [net,v3,4/6] net/sched: fq_pie: clamp default quantum to avoid signed overflow
    https://git.kernel.org/netdev/net/c/c86cd7ed0b0e
  - [net,v3,5/6] net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
    https://git.kernel.org/netdev/net/c/2164b512b97b
  - [net,v3,6/6] net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
    https://git.kernel.org/netdev/net/c/816e90057ab1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


