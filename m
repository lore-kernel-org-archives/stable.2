Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317F4399FF;
	Mon, 10 Aug 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404061; cv=none; b=XjPxZVtjLlJyTn6TFz5N+64zplPht9vRUK5lmyifaaHaKvUoKK2hdASyMjYbwl/RYVmVIaCkKG0zeARd7arC2f2ZU00C7Kr9UHAFTS8rXK+Q9gmG+CgmBbWjm1Sb73eViZUnurDGo3kFKk2L18KPyksADDxDqn+rTn9B7+MInRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404061; c=relaxed/simple;
	bh=BHhkJiSWz9N6Gs1rL1aaBrj6zMsbSMx9eJU+h2srhbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gJ0Aom2GV6WcOtul5nvfGDMtpqhKe/DthoRY7P1EYMHJ04q2bY2Df1BSdP33OYgInprA7I2JX0Db9qQbtM/qj5yznTGm7tgL18c2Ohg/xhP7TLV9DZnmU+udVOtUgqnYHSr5+w+7NIwfFywJyGAkGjcSYI+XdmqCclzMjbUieS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBusI+/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBusI+/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3E31F000E9;
	Mon, 10 Aug 2026 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404060;
	bh=9VEROiIKH2KnlK7uIHHycp0RWf1jN5seEZmIToRP6dM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mBusI+/380oFGLpATRULMHpIkaHNKlf2Z4GvQD26gb6yXgMQwvt/t6RHtrJrUkZVJ
	 bcaophXlmzlc4H6H9HuSMgE0VJsU9Doj6faTlXlQNezDWBxh+e4YuSWzLZSk6W8//T
	 wNTchOz0YE/E9w7r3yBM/oB/IRES/Owk8EEdok23Zne1Si2FpuN28CZSJklM9nbExL
	 gUqXtLej8PsqVQXfTqDZV0HAWdaoo76TRdaNi+Kx6vzzvbZhtLuv9CuGWuLJzDGDBq
	 xV16N0ZshPphLHiqg6BE+RQ+BlgQIwpGEYj889Ed6lyhF9LR0muJeoUjKlzzxGqvnc
	 1JwN9UI8mQQtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1989F392626C;
	Mon, 10 Aug 2026 23:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: act_gact,
 act_police: range check the fallback control action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640401671.250217.8105547661685166030.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:20:16 +0000
References: <20260806101252.809593-1-hj351016@gmail.com>
In-Reply-To: <20260806101252.809593-1-hj351016@gmail.com>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 19:12:52 +0900 you wrote:
> tcf_action_check_ctrlact() range checks the primary control action:
> 
> 	if (!opcode)
> 		ret = action > TC_ACT_VALUE_MAX ? -EINVAL : 0;
> 
> TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
> cannot be set that way. But act_gact and act_police each carry a second,
> independent control action supplied by user space that never reaches that
> helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
> TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
> verbatim from the action.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: act_gact, act_police: range check the fallback control action
    https://git.kernel.org/netdev/net/c/883b56ae58fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


