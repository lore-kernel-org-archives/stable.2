Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B237E5DB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777521; cv=none; b=iEgwOhzTNHdCg6XRTUgA8uoReGeErN8FaHssETKPSvXE3zM6dgch612oXrXbyLJakhNV6a/MXM3pAkp3usWrbznAXncLpenUNcRVpW9VmkRBED/HOWyd266cCD+H/Lv6jJPJ+4ouruW42PXyIFa4t8I3ZNDHciviUsZjQtDq1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777521; c=relaxed/simple;
	bh=AhvAQL8O5Jk4vC0PumAqO5/Cncp1oHZ7q9AgcpHqkYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R366z/ekBYgRS5LkHrI57l99Qey6eaNhG1cSZBLB5Z4mcz7azwbf75hHc3XvqvHCk85mbaSLu1iq1hnqO5vGYPeUG+fgCvAPjc0tvESzHTNx4jlXzg0R4T6G08cBZbxE4MbLpYDvzFFRt4/HHStfqCge1W+EQDGmhdqu9Jrcsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WGYxrqaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eu6wHgdq; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WGYxrqaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eu6wHgdq"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 874081D006C8;
	Wed, 30 Sep 2026 10:11:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790777505; x=1790863905; bh=SWgJNiPFKv
	CAl4sEV/Js4cCyPGEfPwNxuSyd66aac3Q=; b=WGYxrqaMUP0Vr9QuxxqLIoemfy
	JXTpWQEe5hxKiwqmw7v//SE8Aioj224RP/jz/SmKPRe52I+LhMdL5nW3A9+1J5KI
	lQu2rE4zzmLVoIEffdy0sjxhbtWeaTZZDFoOIuqJEAN2NvZTnWO/fRQ2aeVmo3mS
	2dS7OCGT1VByYY82f0j8M3DLdWEwSF1qfILjvB22NzssXHGEETYgpXwn/4l9Zamc
	2wBaIF6QLIouHtsZfyOmCm1hkx8LGOIizced4SEmx0azZTb66lzuvR/2gjfPE3NX
	ayP47ceUPRNmGHhf0OB6mpGal6hMnnW8uHOEAKK7yO4INoccVo44wofHihRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790777505; x=1790863905; bh=SWgJNiPFKvCAl4sEV/Js4cCyPGEfPwNxuSy
	d66aac3Q=; b=Eu6wHgdqXXx3YnCvpeq5zKOI20pIi2UzcCKSaJqu5zboT1UeKQz
	IwiAJh3SSB3f34SWazihpq3YPAb5+NJjK0r7fJzIYgLjxKnpZKkC1F3yMGlRr7g3
	V1d8G2sNm9eN7fxvc/KFUDWoix6sezGG8k8iKF5sHGES6ZspBu1Rc3BdIrwkul6G
	qAqASdCmlo27l3/nb6PPKJuc99wpiiOzL6TJ0Av2mNIrLYEsHUy0nmTiM4RLfGNI
	aDbBP5EtNBRvzd7HqmHLisZvnzV6g61WBIb+OKQRqWOSzZjJLJCGU4eX7M8fTg3J
	1fRRCrllquSbEJCxE4KMHqNyPij4IUtIedA==
X-ME-Sender: <xms:oRi9aj0uEKGVK26LNMDjhL-z-yaS0KG-BgaqLbzQjiVqb8chAkPk9g>
    <xme:oRi9ajq7WNZPDKt_tA3PeTMe4A6bCuFjC_hcUlpdzmwip_VfLMpcVlCECJzYoj_CB
    sjLT1ow3HNT1eo4UrGFKTDvmcrZoIJdcLNMX2mt0HM1ogtAHJs>
X-ME-Received: <xmr:oRi9ajJqACj8p4o4QUx_29qcHynrQ4gObw8FGUMztwlpuD7DEatSjVs8767PDZbKkp9WILBmCQER6E1w49m-L_aWjJT2-1qD3C7qlXPbyvg>
X-ME-Proxy-Cause: dmFkZTEye1epKUq1f0c28hYWGxrKo/vXNqlQLCgDduP16es5S8eG+7PgKS3uQANMS+tJVI
    lSUQaI1QduqObPznxt/HDxGmnYGFe6GyLgGaRrNGJl7IgzwHiI5ZHFk6g4uzqYkzNsRkGP
    0l2ZT6zy/AoL9Qx0ffUXiVRbksjRMj3ZhWfSKPAd+oIDR2peWJRUwruJuu3B0Imh9+Qoz6
    l6bpFj/ReZpVPTlRsr1CVxRpw1sIcwqT0gyXdFRCUj1uVcE+GQ+sauBfAbpsF9lBtoVUho
    JzYAtSrbrhfVlMi+drbWzFqeTC93Nh+dMiXFmmsZyeLFEgETMTkWOT5srfh7syfwUUusqJ
    oRDF8niH3kSvgvxx/6FRhHWWe2yIbcnyCOXfnfSXQvE2nSRkLxmMFX+TJ35CD/ghQUhJKV
    j/a/rdJU/E4krzFaTDqgzYdaWyvYG+mSCQlbwOlyGERakZeJ8LL5gnzV0JYGJjjn2aAnZ4
    7N5cTabZl1gv6zoWNSxS+97gsDbsOij9sFkat+4s/1hSspEuj1K/DuzQv7Irjs/vNdw5+4
    HZz57imngRu3gIpUPJg3QNn2vI8tagDbzNIUBBzuQCESJsXg9vJsdZVCVbybcJuPDXEdwM
    3+MYYTm+SY0BfoN4L/hfzMaBU+sqlc5WfmPps1ERxJP8oJenvWv7O4sFNWZQ
X-ME-Proxy: <xmx:oRi9avT0rNQQ3O33kBXFF80_jhb-wgYmciGyIpe790CSrSZkmz19nw>
    <xmx:oRi9arORQCRqT3vhwa-1l5L6rF4f2tz920gavT97zRNeVMcbFfcv1w>
    <xmx:oRi9asVZ00_HpBKqzRkykCZ6YkfuiJ37ZhE11GrdfkMnydmN9LpCAA>
    <xmx:oRi9amhYMPRYt5EQ4V6XP3vs9176KNfxrfIUzKEoG56ywx18FQDBvw>
    <xmx:oRi9ahD1_-Y2Ah8Dlie3ysDYEsQ16aibgm4xbRXGojL9gEA6VKeffSbc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:11:44 -0400 (EDT)
Date: Wed, 30 Sep 2026 16:10:09 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Yong Wang <edragain@163.com>,
	Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y 5/5] tcp: clamp route advmss to TCP_MIN_MSS
Message-ID: <2026093005-skimmer-underfoot-a5df@gregkh>
References: <2026083105-buddhist-verdict-4f97@gregkh>
 <20260901141804.1031618-1-sashal@kernel.org>
 <20260901141804.1031618-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901141804.1031618-5-sashal@kernel.org>

On Tue, Sep 01, 2026 at 10:18:04AM -0400, Sasha Levin wrote:
> From: Yong Wang <edragain@163.com>
> 
> [ Upstream commit 870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1 ]
> 
> tcp_select_initial_window() assumes that callers never pass an MSS
> smaller than 1, but route-derived advmss values can violate that
> assumption.
> 
> A too-small explicit RTAX_ADVMSS is one way to get there, but it is not
> the only one. The same divide-by-zero can also be reached through the
> "default advmss" path when RTAX_ADVMSS is left at 0 and the effective
> advmss is later driven down by route MTU and min_adv_mss.
> 
> Introduce a tcp_dst_advmss() helper that clamps route advmss to
> TCP_MIN_MSS before TCP consumes it, and use it in the TCP paths that
> derive advmss from dst metrics. This keeps the effective MSS from
> dropping to zero before tcp_select_initial_window() rounds the receive
> window.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Yong Wang <edragain@163.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> Link: https://patch.msgid.link/251eaf8277fa7c66364c9815c5da01662d269181.1787074852.git.edragain@163.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/net/tcp.h        | 5 +++++
>  net/ipv4/tcp_ipv4.c      | 2 +-
>  net/ipv4/tcp_minisocks.c | 2 +-
>  net/ipv4/tcp_output.c    | 6 +++---
>  net/ipv6/tcp_ipv6.c      | 2 +-
>  5 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 23d830a7a6c82..8f411176b4180 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1475,6 +1475,11 @@ static inline int tcp_full_space(const struct sock *sk)
>  	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
>  }
>  
> +static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
> +{
> +	return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
> +}
> +
>  static inline void __tcp_adjust_rcv_ssthresh(struct sock *sk, u32 new_ssthresh)
>  {
>  	int unused_mem = sk_unused_reserved_mem(sk);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 97e3ce3e60f98..446e696fb31e7 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1624,7 +1624,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  	tcp_ca_openreq_child(newsk, dst);
>  
>  	tcp_sync_mss(newsk, dst4_mtu(dst));
> -	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
> +	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
>  
>  	tcp_initialize_rcv_mss(newsk);
>  
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 86f0feb2497f1..c5df72b548955 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -403,7 +403,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
>  	u32 rcv_wnd;
>  	int mss;
>  
> -	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
> +	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
>  	window_clamp = READ_ONCE(tp->window_clamp);
>  	/* Set this up on the first call only */
>  	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 5abad93d3c743..67b88a962079f 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -125,7 +125,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
>  	int mss = tp->advmss;
>  
>  	if (dst) {
> -		unsigned int metric = dst_metric_advmss(dst);
> +		unsigned int metric = tcp_dst_advmss(dst);
>  
>  		if (metric < mss) {
>  			mss = metric;
> @@ -3698,7 +3698,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>  	}
>  	skb_dst_set(skb, dst);
>  
> -	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
> +	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
>  
>  	memset(&opts, 0, sizeof(opts));
>  	now = tcp_clock_ns();
> @@ -3810,7 +3810,7 @@ static void tcp_connect_init(struct sock *sk)
>  
>  	if (!tp->window_clamp)
>  		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
> -	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
> +	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
>  
>  	tcp_initialize_rcv_mss(sk);
>  
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 243d398c35868..4a6a0d95af150 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1341,7 +1341,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  	tcp_ca_openreq_child(newsk, dst);
>  
>  	tcp_sync_mss(newsk, dst6_mtu(dst));
> -	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
> +	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
>  
>  	tcp_initialize_rcv_mss(newsk);
>  
> -- 
> 2.53.0
> 
> 

did not apply
