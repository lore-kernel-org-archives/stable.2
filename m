Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9836997A;
	Wed, 12 Aug 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498259; cv=none; b=QtXLbA8z07/QYZ9sz1fP91cMpBhGOlITCzL682krTIUhcdg1KXsBVEygq0idJs1OwvIDs7rwa39rJxi8FU6ncyJu6G+woLxiMWdKp27J89cqBJWPd/JfcopepY0aI9MfyL0AwyF3vNlo4yfE7nl4upZgsyIq/G2I8h+nu1xB6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498259; c=relaxed/simple;
	bh=naixSqASUEWyLcUoyPlnTkRw7OWERJMx4Xd58gD4FO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cpls1D7bhFI9C5v2q3C+EvIvdxrqUci5/QEHIP9toZz4VkW7jdTZW1Z88QeB2m1hd95M7nlcGOLMVWQYoFU55Xjg4gKynVvXSeQQ1GfF3OelhXJQ5qblj1ALZGnbGfqYU/pabugN1xB+5tUIbxsoOJ90AiiHJDXa26B096lELHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFKH6iLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFKH6iLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146D61F00A3A;
	Wed, 12 Aug 2026 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498258;
	bh=A08mXLdjqukLbqylyZeV05fMav42Yas5h+Ym+Y+zOBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SFKH6iLkAakgGNKW1nC7xb0aT1tFDG4yJxruQ/2wDequ/Ac0nR5mABIlzvbpXq2pE
	 acq5CbjkcEZ8/2FtVspMp1/tfeW9qqfm3HN/puD/RyTUhGosW28GE8VqIHC8nBItkG
	 /KwJ0bwp9v0Sb6fz5so4rMzWzw0BkHxTtzze+WQI6zCsD4b4rNqGr/V1wV9T/cLWRw
	 559j2uJDQhbAK5K5XCoMdZym57oLujHA93I/TWf6pAhkpW79+MWjDI+vdRRTf/1ebs
	 JmHDQYFusXKOgH0yZ+2qpSeGNbJ7P+FtL9H8JpQO6sd2ahY4w2AiXnRema6+4wEQnd
	 uwoWC2+12rCCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A33809A3C;
	Wed, 12 Aug 2026 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on
 a->goto_chain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649821363.1227528.5392526569605009176.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:30:13 +0000
References: <20260809090928.868186-1-jhs@mojatatu.com>
In-Reply-To: <20260809090928.868186-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai,
 victor@mojatatu.com, dcaratti@redhat.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Aug 2026 05:09:28 -0400 you wrote:
> tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> rcu_access_pointer(a->goto_chain) and then calling
> tcf_action_goto_chain_exec(), which does a second, independent
> rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the gact
> replace path) can clear a->goto_chain between the two reads, so the second
> read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
    https://git.kernel.org/netdev/net/c/f60b396ee174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


