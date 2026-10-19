Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66024534B7;
	Mon, 19 Oct 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398812; cv=none; b=rg0TCht/s9bFkUmwWFQYWLIkxXQIHF0VIWqPMpEjD0ytf6ncwgB/IQBkdegWsdQpa/4XgPQsrztC+G1cjnWvgXIsIzv3oboxLa0Aj8M/Fw1klVGABMBLgM1NpDCq5aXlVIZjEtxEZai3uv4quY/XR6aIuoxspFNtEcymbQmgKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398812; c=relaxed/simple;
	bh=0tc+7e5ERNzkGutQX1PNSv71eGwmHwj5lPN8UTXoldE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mChcHqhMJbfW4E+OsoNCN1/2FzqA6eTMcAi8mrV1S94jT90vsEdPrsFrA+l6P/aEi7s+axSeUisxgSPsESToneWfE/MqwFiP1ofK8GgDiR9CuePtIEfUJiSIDAUzBsp1rqjH0QHA4I8w3SO2j2tl4vJ89c1HwAiPZxCDuFCnvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWo7jM7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWo7jM7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13921F000C4;
	Mon, 19 Oct 2026 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792398811;
	bh=IK0sXuhZ5deIdhI5ZoljWsNdq8PHkjbXwO2tF69oNWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RWo7jM7HRYUErWa0ZhfJ/fdtmrVB4NsbND6vQoqgb1ouiW7uRyVmUujGTdjPMpXh0
	 b7rGi4WihBygFFsgVuTxfYN5O6oeuWepvgAZXlQ6rmUV1gO+ZLcfIr139jPF8m50t9
	 LlQI6kXYbUFXgANWquIEGG+4OITFL4OssNg7zY/uE8FMODgx1suQd/DhiA1BtL2uHj
	 w+a3TPxGpRz5MVxGU25tBSNuHQzNsZPHfwpskixNPcJkC+54fcispc5v7pmjD15yU+
	 CmmGjtDDgK/DRORpHK967FCKI3NRcJZoTivqMEKw9J6wLXi67bsqANqDC2Qbi6BXlD
	 +PJ1gWSqfjYkw==
Date: Mon, 19 Oct 2026 10:33:28 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Kaho Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: ipv4: add zero check for snd_cwnd_clamp
Message-ID: <atXVqZDUhE9Z8InH@kwain>
References: <20261017214845.28769-2-kj2864@nyu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017214845.28769-2-kj2864@nyu.edu>

On Sat, Oct 17, 2026 at 05:48:46PM -0400, Kaho Jiang wrote:
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
> Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
> Cc: stable@vger.kernel.org
> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> ---
>  include/net/tcp.h  | 3 +--
>  net/ipv4/metrics.c | 4 ++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4416cdf9bf30..ad80b8fb8a52 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1521,8 +1521,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>  
>  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
>  {
> -	WARN_ON_ONCE((int)val <= 0);
> -	WRITE_ONCE(tp->snd_cwnd, val);
> +	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));

Please keep the warning (it's not only about 0).

>  }
>  
>  static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b38..cb36686973e5 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if (type == RTAX_CWND && !val) {
> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
> +			return -EINVAL;
> +		}
>  		metrics[type - 1] = val;
>  	}
>  
> -- 
> 2.43.0
> 
