Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6D231842;
	Thu, 15 Oct 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058269; cv=none; b=b9hSS0HUjY6bPo9txMhAoSwpfVYvZ9z7cHd1K7oJPEo2IM+SGRTybCrWFDbGbjI689Fw2WDsOheMmiBL1waDEIbL+WD28ijM1SgY7Vad09n0rPT9RNB5z2Tf90hd9QAl6OCricx56uVjMWLcHqZHBrHzSnGmXWd3NyAXD0tNnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058269; c=relaxed/simple;
	bh=ubxi68fA75Y5UgK7PQDLNn6R5jdJ9OqqK+WFdSw+qYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXLAmqp+KLTzHGM+43PudzikH6EqGAycIL/iucIb4ZYo5QSW1uMjgB3lHZav3puLYv57KtSvF1VWrLKBxCpCKPJsvu/cg+R6KOht/WKvIv1V+UrcYhFv0ibOVV9FtA3tq4FmYWZWu1SulUp0c8RqfelDJ3THM1LdwI/jUAOOgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISqjAgWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISqjAgWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572201F000C4;
	Thu, 15 Oct 2026 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058267;
	bh=FHzZdRZIY5rUs75/kxxc54yY58fqdLpmETBQpCwn99o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ISqjAgWANpBEzznvbjbAXdM5fJq2cBhBVTcHLrcXe9anGuDWrTpSIP90ZYepTh9rq
	 bUXSxM2+qbF2uf0OppO+CWVQvYJ6aTJOsk0l3X+Pkr01Thb06YRLOIO5VwN0mt74n0
	 jyj23tCrJdVxsrN1v5WART+JLFxXRBpfS7qFcp50kHkb/2bwG4+O9cb2T70WiUmxnY
	 7S9/NU4VLiYVpuQV7bbGxbNKKinVDu9Vb0a18mr1fey0ojtwLAIuqyLiMo2VTmNniy
	 E+jJcfSBdRlAAjjIZDrg5hq0pPCYTd/GBxf5aPxaXBqCQDt0YaRnPMsF+YMb4/QZ1G
	 PGTxhuA5nUnhA==
Date: Thu, 15 Oct 2026 11:57:45 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Kaho Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
Message-ID: <atCf_85Ei_J9CDtd@kwain>
References: <20261014195640.430824-2-kj2864@nyu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014195640.430824-2-kj2864@nyu.edu>

On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> This could lead to division of zero error if not checked properly.
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
> Fix by checking if user pass in zero as parameter,
> if so reject the value zero.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")

This looks like a refactoring commit only, 814d488c6126 might be more
appropriate but please check.

> Cc: stable@vger.kernel.org
> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> ---
>  net/ipv4/metrics.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b38..e83a129a25b6 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if (type == RTAX_CWND && val == 0) {
> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
> +			return -EINVAL;
> +		}
>  		metrics[type - 1] = val;
>  	}

My understanding is tcp_snd_cwnd(tp) can return 0 and then the divide by
0 occurs in tcp_cong_avoid_ai. Have you also considered updating
tcp_snd_cwnd_set to not only warn about invalid values but also reject
them, preventing similar oops?
