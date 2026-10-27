Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098208;
	b=M/ACXcLaIQXNB/Jw344gB1z2TYSUCvLzCF19OR9YaWqRho/Fa5/4fXkXs4xz45gnduNb
	 kiAob21pkbqMvi6fhAoqN9Lj09+e4qyXwoKE+wXQUmA8CiRdq2dVOjZtbZaCHv9nvsUX+
	 e097vj+8sHHHOUMpOPfD56ODDkxFJICgLqs6skEs5jYvvgsM4EnQIhrvk0Kg7t+C4rxXF
	 GPDYEzBLr3fSoIJXREE2j4DAeL7eJ7OKMxFa3IcKOMZaaBDnL1fhpFMBaCQb+FxVXwQge
	 oPr5z/sTYXkai0hwNnVfeTAqaiUfbi8mTOsk34kZlFsKnIhMC1bmhcTTh6F+12dOcFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GLGLTdg4EouiLoSbpJxeE4wAdsu+lGHS2NhfYc2W3NA=;
	b=vcKC1VJlMtk9yF4w08TxlNvpoCgpMpUEmjJEWz0mBui8+xTwN9VX1o0/BlVC556ll7rJ
	 XZdIJiuDLzp2dNOJs6S269yFpr51pp997btXxNQAHhuezCTe067WKXWCWILOiRsfsmAxD
	 Lvxg3DfgGVTFW/qrfKI3KsneD62QtL0BeRUXwws2LgnwYUBKjThJ2HgV3ENZpLUr9rpL2
	 G1BQexzuBgDoRUCQJ0gTTb6QuwURTd/TvzLjGPM/iKibFs3Bi71JbEWagmzzEu2yOD97v
	 sPg8c/jBYeMzLkOuTqFBOwksdqMlxJwHvrap/9anA60Rt41ZF/8YoRI6o6nap1qOefw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c2q/G1WX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AD606A31A;
	Tue, 27 Oct 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2q/G1WX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B7F1F01828;
	Tue, 27 Oct 2026 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098207;
	bh=GLGLTdg4EouiLoSbpJxeE4wAdsu+lGHS2NhfYc2W3NA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c2q/G1WXzvwVRBHK0osYz/2pmFEa3qGmAvfUjxd7AGJAmQ7LlJPCEGUanHcAz33Hg
	 cKeg1Xs5xwvwPpVchDyadQud9khehPb0wND5mk24QMAJNvcr+wGWuRA+wvx0KC+7OD
	 ZlBec2MPd19JbXNh6ixtqo6PcfTsqTUbIzkUyb11LL8/KevKvfYfS1Y3cKjFuHMxqK
	 j/SOPjb+mUpVWj6UKIien16d9FoNmS3JrrqxngkbXHbH9A4KY2rtEVnFtHNrN8bXto
	 gshuBPGwijHEjpPh1i5Wl/w/piOD08jO7vTaS6KKjjLmWEX9MeyKVVhNI3+Uw7MFp1
	 6XGQ43xBZt8jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8151C3AA9380;
	Tue, 27 Oct 2026 10:50:07 +0000 (UTC)
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
Subject: Re: [PATCH net v6] net: ipv4: add zero check for snd_cwnd_clamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179309820631.3724916.7962338860107889277.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 10:50:06 +0000
References: <20261021235732.1313305-2-kj2864@nyu.edu>
In-Reply-To: <20261021235732.1313305-2-kj2864@nyu.edu>
To: Jerry Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org, edumazet@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Oct 2026 19:57:33 -0400 you wrote:
> When RTAX_CWND is locked, user is able to pass 0 into it.
> This could lead to writing 0 to tp->snd_cwnd, leading to a
> division by zero error.
> 
> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> Call Trace:
>  <IRQ>
>  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
>  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tcp_input.c:4440)
>  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
>  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
>  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
>  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
>  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
>  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfilter.h:319 net/ipv4/ip_input.c:262)
>  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./include/li)
>  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
>  __netif_receive_skb (net/core/dev.c:6410)
>  process_backlog (net/core/dev.c:6761)
>  __napi_poll.constprop.0 (net/core/dev.c:7830)
>  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
>  handle_softirqs (kernel/softirq.c:645)
>  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
>  irq_exit_rcu (kernel/softirq.c:775)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> 
> [...]

Here is the summary with links:
  - [net,v6] net: ipv4: add zero check for snd_cwnd_clamp
    https://git.kernel.org/netdev/net/c/363c8c79220d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


