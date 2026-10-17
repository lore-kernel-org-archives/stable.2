Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577793BFAFC
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214494; cv=none; b=QK5GKaiP8JoSYjcJxjaKohhsKuuXadH8vWQAc7FeWw0SAqMzMNDj65Mm+gtPQYCbewc9UPukKWbYrxMAn3ebeQgGGMoESKkEOX4HNDJwpqEIax0uumIhx6ISHG/nzX2BQHBR1CQR2UYqoT0lbvgUWVNPbHh1VjD6DU1JIAIE5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214494; c=relaxed/simple;
	bh=aC4Bvl+lsY8CU7Vvs//CHQEgxOBks6KfY7owryN0QbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=irQPIwMgcmbmTr9EPpNRSCNHN0LneSvDm/5idmtAd5NoR6DiIky6JDn/1hRUKWairwRqaz8sSgMShwd56t2SoO/5CTDx1S4PPbEDjW1Ex+67GEJAQ01q5zudf0qldebxcETEGUS+qPDQS2t96rtREz+62Rg/Qi8qqje6YAvdY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idvv7AwR; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idvv7AwR"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9821ca96fso4624315ad.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792214493; x=1792819293; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FrYQNLOC0ua6Y12Q7VcbQ5pmrylw5LYh/sMmd8pDQ8=;
        b=idvv7AwRBqCjKS0p+o3BPgccAWAslq48nlSk9Uk6QP3NowhJgSJlhwM5j4BWTA1PM5
         5lF/NmvOMwOE/LGj7wFRqyZOEVALMzazs/RQxgVu1J8BVH3efWjAXlXfoziAjqeruSLc
         dpY9GPpWFBoO9OsCqvToKxZ30w9R/nwtfm2a+VCUD8WSZw4OoJxI6fi0PF8113MTkzlh
         jFcjW1PMQKyOSvgT9+XvPNOWGs7g9n6006U262aQy0RLDWlQ5VgrCLL5qQKcCyN9Fxft
         FqvzFRo2TH9gseuxBnmrhfINNYOCl0SLZMnOiY5/kStDqC4CEpOcydhkmK/4O0eFEMdl
         Z8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214493; x=1792819293;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FrYQNLOC0ua6Y12Q7VcbQ5pmrylw5LYh/sMmd8pDQ8=;
        b=VUP2wx99VW2hgmKwnsSkUAP1vnL/TlqOPfCI6b5MdJ1jj6yMc14T7NJ9cGyrJ43gZ8
         aDpLrp/IY/JyxICSmamTwqE2ONyuelrE3AVss4s4HXsgk/ntvJGDyQrM32BYawpwZBzq
         LArFuop3Ek9bioM25bvEMpQ6YOPRvXep688sS7/UqPrEXL7LNADaqn37KAtYk4sU+V5y
         Xa7yo+BqZqwxkq48FpyfwM1Q4nbJw0tUHC21x8zTUBN9fCQTZ4cnogpQWr0Q5yx1EALr
         LFv/xZTFb414d+3934FrVSwWU5TCqSeRUCOqjx3DHpYRmCKkVBoT3Q0+1RKfGk3xkcNz
         lkoA==
X-Forwarded-Encrypted: i=1; AKwUvBwLZ7Qsqhf8XLnv+JuMRpx2a+3W1vLntRnnugcxc+6EeAviJIYKlDLZsuvNdPRCySkeRdWpoB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBCqHMNZrKtUGQSADXZUk9HgEe8GsibLBbCWg178yzfJuLCJsD
	gR68MJvhydeRu1N/9xOXAzcF4Tt/fqgsYVcSvc4kJguCBwXZWbXAHG7lniFl4GYKMOQdYcY8g9K
	trUp9AA==
X-Received: from plxq15.prod.google.com ([2002:a17:902:dacf:b0:2e9:3d99:bb3f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e943:b0:2e9:79db:449c
 with SMTP id d9443c01a7336-2e9a6f55653mr15650925ad.47.1792214492411; Fri, 16
 Oct 2026 22:21:32 -0700 (PDT)
Date: Sat, 17 Oct 2026 05:21:31 +0000
In-Reply-To: <20261015201549.4023-2-kj2864@nyu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015201549.4023-2-kj2864@nyu.edu>
Message-ID: <atMFPKhON1IK5cxc@google.com>
Subject: Re: [PATCH net v3] net: ipv4: add zero check for snd_cwnd_clamp
From: kuniyu@google.com
To: Kaho Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, 15 Oct 2026 16:15:50 -0400, Kaho Jiang wrote:
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

While at it, please check RTAX_INITCWND too (although it is
ignored and TCP_INIT_CWND is used), also use !val.


> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
> +			return -EINVAL;
> +		}
>  		metrics[type - 1] = val;
>  	}
>  
> -- 
> 2.43.0
> 
