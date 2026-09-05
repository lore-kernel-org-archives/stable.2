Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8C1A9F8C;
	Sat,  5 Sep 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641479; cv=none; b=MNCewIs4zRAQAEQwg2moPHooTKG2X6sw9uC3jgmVSrstMRiuRmh0+fkvVIQvH4AiaOTCDq5Es7l9ZM4IpQc9TplQnVaXtZhM7ZbcKkohockpqqG5pxGr7lgHp6R59/lRFwuVwzOVQPjDvHsRGnPSEikIDWnoQjHMb2G/P3qCA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641479; c=relaxed/simple;
	bh=eP6I4rdFH8zi9D0PcFC/JBxFgEdkQSnAujY0LoJUvho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m7A1+Gp2fnCk1TbDHVLQkmHrJJJhj2Lp1Uoo6GQPVpl9AEVKLSoZl/LYPDmJXCyc0FUkKvwux0spNrgr1KeImlLVIOudK+qUC/dd1NeTBWFTy4KEk17MqzxSVZLDWhKQTlnBd85+WIYnf4PbP3fTMEqrHsP8dR+eDjT7QjvB0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXWNxR5D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWNxR5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7684C1F00A3A;
	Sat,  5 Sep 2026 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788641478;
	bh=VnIsu5itAlYzuL5X7MCY8u3HD0I3nPhqDgGGuXqAu7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aXWNxR5DumPj4E2M+Ip9txZQTRfTqQYnEFNQgMfzXfnjqV8So99aOyZ3OYhtm003k
	 c18JJrel6i4FMZbqJZNWnL56yE0ONPu/VuQ6CwN4fWHhAd1ErTFRZl2WULFgY+4irX
	 pMAzU90NV8udVEu+9IB3b1A6rRgUmUzpceNOK4QXlGoGF2nj3Yaf2eQsGKb8zC2K0C
	 igGTzn6L6bxFaMLJkOr8fjC44Bik2KLRQlOEVF6DVE6GNhuJG1fu4CPo42Lf93OnbO
	 ctCV08XrufOOEvGWef5vT83sqvGjsoOZA5gg6zxZqR4eEoymankS/B09bEbiEG8xP5
	 QkLPsadoVBisA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B0D3924FED;
	Sat,  5 Sep 2026 20:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/9] net/sched: clamp quantum/psched_mtu in change
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178864141844.1349963.2611834823551423169.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 20:50:18 +0000
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, vega@nebusec.ai, stable@vger.kernel.org,
 toke@redhat.com, chia-yu.chang@nokia-bell-labs.com,
 subramanian.vijay@gmail.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 17:39:21 -0400 you wrote:
> This is a followup to commit 709f34f7c28d ("net/sched: fq: add overflow
> bounds to quantum and initial quantum").
> 
> The quantum_backlog_overflow series and the five siblings that followed
> clamped the init-path quantum in fq, fq_codel, fq_pie, hhf, sfq. The
> change() paths were not clamped but it is the same pattern, same writer
> of q->quantum, same privilege level (CAP_NET_ADMIN in a user namespace).
> A user can override the init clamp via tc qdisc change, restoring the
> small-quantum deficit spin that the init clamp was meant to prevent.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/9] net/sched: fq: clamp quantum and initial_quantum in change path
    https://git.kernel.org/netdev/net/c/094cc07f98df
  - [net,v3,2/9] net/sched: fq_pie: clamp quantum in change path
    https://git.kernel.org/netdev/net/c/4864f58c53eb
  - [net,v3,3/9] net/sched: sfq: clamp quantum in change path
    https://git.kernel.org/netdev/net/c/fb9f88a33c51
  - [net,v3,4/9] net/sched: hhf: clamp quantum in change and init paths
    https://git.kernel.org/netdev/net/c/eb56a495f59b
  - [net,v3,5/9] net/sched: dualpi2: clamp psched_mtu at all call sites
    https://git.kernel.org/netdev/net/c/3c01f1ca5dfc
  - [net,v3,6/9] net/sched: pie: clamp psched_mtu in pie_drop_early
    https://git.kernel.org/netdev/net/c/54370e44c002
  - [net,v3,7/9] net/sched: drr: clamp quantum in change class
    https://git.kernel.org/netdev/net/c/8382abec0f15
  - [net,v3,8/9] net/sched: ets: clamp quantum in parse and fallback paths
    https://git.kernel.org/netdev/net/c/1c38487f46b2
  - [net,v3,9/9] selftests: tc-testing: update ETS test 41f5 for clamped quanta
    https://git.kernel.org/netdev/net/c/8f0229bef3cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


