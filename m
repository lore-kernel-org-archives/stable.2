Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742007;
	b=FDTGDBlnnjnQTvwQL01bEBcCjK665UbZ+I1V+X+a82Ve8PVUwWVJiLo4EsL2+gh7LnQ8
	 eRrb+2s6kRsppIBBFXmfcKiLcfnApVFhlIIwMcVRV+6hJ2j6+l34m7nigexiEZvNLLF9d
	 AbBeQvluHMPvffNW16im+m/LOq94yO1yVx9iG3upk+CKegCudUSUvQO6ULnYQzNsVccHP
	 0sbj8aSWZK76mBRXC3UcrhqwUJVkM40AJjfS/S5cfGafIg7E8egWwD27PqN/xmhlsys+F
	 Ji9zn5UgO1xtLRPW215QQ5KBpqGa3k2gBe4+/LGSVB/5qmj2PkxWqqiu/xn9GANJJ5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=SM699TxzXYhrN8+H01lC8wYwldlVkdKMwpFwy0ByGq0=;
	b=s0cYsJE8+yQkmKjuD9RWOVis2mvv4kfMGI6mPmkQJYE02DhVfmyr6W1FzVNkg5G6JJkc
	 MfhUwlFO0ESl3lFb526o/D0qE2MPWRsbMlVY/lTW0Sve/tcjgxE9VFN1xS3GG61/GIifq
	 U3hDNHrYzg1kEgkZEAD3trxPJfSufynhAljIBH52EIGexuJqKl/xjxbqHzr0cJL66AAnp
	 zhZM1hXpd71QA6791lNDR+jQHuKp6WITN0SF9vvLmSY7HtVImOCPdyQojMilKobaXPl88
	 OBlgo0UDjggFq78aYr/DBBTDMcYr2wyZgUhZ+liITe7z136Ve47g44q8GBirO3MUxFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE9Rui18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5B606A329;
	Tue,  3 Nov 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE9Rui18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDE71F00A02;
	Tue,  3 Nov 2026 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742006;
	bh=SM699TxzXYhrN8+H01lC8wYwldlVkdKMwpFwy0ByGq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UE9Rui18aXObGzDuJhoCx6vrH5rlRlj9PjwGNkVht1rf5/L/NeuMrTYivx8PPO7m0
	 96sNLxoNJmQRpE8+9eMEi9nHu/zNA/0S0+J+wCD5CKpRJ9P1DcA/jRHxMgL7zBXeVG
	 6Xit0uz4/m8o76z0DPVdBvrBpItMBBOwz5MRV682M+r8d5738b68OOS7Dimqzt8Sid
	 Swp3iiI9AOS2noLc4otWWZgi2loyuwQqfAa+ao9xvb/LDEE6ArfdxZr/O3To8uPooP
	 iN1VWwTPvHpDZVrwpab2oycJhXTJ84j4ZADdoE7GTaSY+yZ5qoFNDSVGoktobK5aTb
	 4SM3qOHelMvEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0314B391B0A1;
	Tue,  3 Nov 2026 21:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net/sched: clamp skb->queue_mapping before
 indexing
 the tx queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179374200480.1894115.5049965810872091350.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:40:04 +0000
References: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com>
In-Reply-To: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 vinicius.gomes@intel.com, horms@kernel.org, hawk@kernel.org,
 daniel@iogearbox.net, sashiko-bot@kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 16:36:31 -0400 you wrote:
> This issue was caught by Sashiko (nipa). A producer-side path cap is
> already merged (ea4d4b5dddb5); this patch adds the matching consumer-side
> caps.
> 
> The issue:
> The tx queue is picked and capped in netdev_core_pick_tx() before the
> __dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside an
> egress qdisc (not clsact) can then change __sk_buff->queue_mapping; that
> store is never re-checked. bpf_convert_ctx_access() bounds it only by
> NO_QUEUE_MAPPING, not by the device's queue count.
> 
> [...]

Here is the summary with links:
  - [net,v6] net/sched: clamp skb->queue_mapping before indexing the tx queue
    https://git.kernel.org/netdev/net/c/f19f2b308beb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


