Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225104FC8CD
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774345; cv=none; b=RvA8qDqA6SGvSEZRQALrnXS49ifhkcVvfDLz9GTAQyc6HZAUuZVNK1o31SraTS2eN+wTWl+C+wWcioLxjL8OXaxZPsEukF9i9S9iJlRcjqr0/HYyg9wXf7VTNsFC/Z+RdJt67Qe9qcWjTlayEoJSfsFbm2RT5AiSU6ZzG9huRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774345; c=relaxed/simple;
	bh=KbGbv3FDaXJtdO0szveTqzbTR8JHO+RTA21kzTAQ4b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmYoNRElWvYLQR2MINVmy1phV0ski+lBDqw9fU+ESyb1GCmqmp2AhOz1IzQ3sZIolL4pqr2lGIU08nEeJD/byp+e0rAdWSgWYEb8euHiGn6e8betqplP2S72Z5HdQ/M8s5nbe5tOC7LHeVY93g4i8sN6H1d8Xs4w+Tk5lhK8khA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qyOzgSmX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v8QyBrzq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qyOzgSmX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8QyBrzq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 38AEB1D006C8;
	Wed, 30 Sep 2026 09:18:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 30 Sep 2026 09:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774331; x=1790860731; bh=NPE+Vp4vWK
	QPzmkpmCrJV0s8+KQRhRa0vdlx/BguDV8=; b=qyOzgSmXqdpTT9GP69OOfWVNKV
	WAuwlgJa/+eXJVzI5tx9j/VKHyceb85+0km3POTsvTQy+QWFFSvhbjIAwjRewKNY
	5Y1XL/B6rrErN0zPhz7zKyKk7O/MWBIaMRs70lQ70PICcTkFeb8tLKldMDnLoi/x
	TjDsfM77EICovQMeFb3EZIyTLU8gZ1wwQl83ANShmiDbR/RO3AqyLeG3KoGxKZzF
	QXhzdk07JuW+cJRt1I6PE03OPwYsIZCpvHICy39MLmWK3Mjs0i9fwd85Ccm+2j0o
	dDD86PdcbSkrgH+1bILkVa0CFFBnQrLiaSeVVqntswPeTk55o7eXMBLlmURA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774331; x=1790860731; bh=NPE+Vp4vWKQPzmkpmCrJV0s8+KQRhRa0vdl
	x/BguDV8=; b=v8QyBrzq1E3/YUCg9n6v8l/h9amL/qz0J62BjsFHvjbCV5vwmkE
	fYr1oFWoSRKlEt05lQNmstosYYKChsrU+U8YYPokn48HP2a7Sr61FRVmrvDmMtn8
	uHJ42RUK4xrXSKjsTtbP5yFt7awLzultCEgE8EzW84rsyV5IbQvJH0XqnigtYhaz
	7hDm4CG42vC/imQkexO25/YPAULPwZ4xP41qNnqgzGxBqJ2NcnwYoCvZXBBmpb+N
	T+SW0Z27JaIq3PyUu3zexs3B3DSiXffjY4Q4Sn6PMa70jjTY3UdKQLVLLqvtIv5w
	mR1gcxymUFXj3Ql11oAb3UskAyMkA2/MlRw==
X-ME-Sender: <xms:Ogy9apIfklNk26fnNTzWCW6lZ6e7zNtRxgnz6RcdtfbvGvFlJUHnBw>
    <xme:Ogy9aoOeocQGIEhRrF1sDrdBWFrhOdRqbFVulh4Ebt5t1SgHNGWDZK1czGLdVD5cZ
    Ieop9kGRK64uJ_tdZG_JRJdT3qe4Yeg3s9D2Urn_8W1oRMRTqM>
X-ME-Received: <xmr:Ogy9asUHHARMnNoEYDUBxCEr9AoSDGlAyEG8HOxhmsmsHJe7s4-VhSbTV5_CvE-RbQv-aOHj3peITNa715KfKXC-06ZqgaLSPpKMOuYTH8Q>
X-ME-Proxy-Cause: dmFkZTG2F0ywl02x45prMRdeZnxza9poDQVTqyy4pBCmz9satG+pYG8YYIlGj9elImgZac
    yXNSG/duNheMJ4x3QFjmU47mubwY7Mvti/1E+jlrsxQPHOtFtWgWIQyY89F6rudX2tfScH
    vTRfhCs+ovOVEv9ZWHJ8dwInyDBEfcvk9+vvSWUohMyVoZb5maJ3vl09lCu4fDCVIa8mmu
    4+pqZWTzsCI2UrZsdkUnuV+aApNXcAKjbPwCYe5NT86LV63p69Bx5qVURzShnqwkl1LD+7
    fnc+3Djf/UVKWxSER6tzbUWfEL/3slFQ6VqnykudjeyInxEJSP1zRxVQJAgikvk2R8T5oD
    ElHR4ZuuE8wH85C5nx9a5AGIfnzMnm0J3KFeVrRpijjHUTT1MSlZYkTSjjGrZRerpdgsZO
    2FMi2mZ+6vQJ7xjtzoj8WvCyMzBXSX03JFA7t8ukg5xvrtMw5cCKcHAzYE4Cv7m7+SZLCX
    9An8417z9E/nsj4ZF5mhrGaTjbsDcgtkCSYcgRFVzSfZxci+01OlbVKnzkzN+uxdsMeXcS
    N9/Oa13hIGkHT1GBSYbaNoYVYFAMoFmbzkI6yJqxohnakJzQ6YVHU6w66P0vKKp6SCUBzM
    PuVRkn9wAw2OGfdaGvQyWmliFBvIp1ncWO8+94dB+mRTgMrjODoP7CE+p9bQ
X-ME-Proxy: <xmx:Ogy9amnEiMe63hbJhHjIrrGGfS3MBIz7rhtqvezz25b4X5U6d3nYBg>
    <xmx:Owy9arNfPoiwfHSN63lmFduYTtK1EqzM0iSl3izWXxHOr1ozjH4rCA>
    <xmx:Owy9auKh_0GPDj7sijSWMNDDcXlKySFZL5lp4ehhxo839O5kub7Q9A>
    <xmx:Owy9al27G4cc7ahGOv39HRGrdMJTSkwVPtvuo_hFf6ufnUwajHeLTw>
    <xmx:Owy9aqPHi0HVIb83iq0Wpo3ZA-7WcSMpXNV5Dq6dgje50ZrA4up_RfFV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:18:50 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:18:45 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] ipv6: start using dst_dev_rcu()
Message-ID: <2026093041-conduit-frighten-fec2@gregkh>
References: <2026091758-subsector-deity-17bd@gregkh>
 <20260917183945.1201473-1-sashal@kernel.org>
 <20260917183945.1201473-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917183945.1201473-2-sashal@kernel.org>

On Thu, Sep 17, 2026 at 02:39:45PM -0400, Sasha Levin wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit b775ecf1655cedbc465fd6699ab18a2bc4e7a352 ]
> 
> Refactor icmpv6_xrlim_allow() and ip6_dst_hoplimit()
> so that we acquire rcu_read_lock() a bit longer
> to be able to use dst_dev_rcu() instead of dst_dev().
> 
> __ip6_rt_update_pmtu() and rt6_do_redirect can directly
> use dst_dev_rcu() in sections already holding rcu_read_lock().
> 
> Small changes to use dst_dev_net_rcu() in
> ip6_default_advmss(), ipv6_sock_ac_join(),
> ip6_mc_find_dev() and ndisc_send_skb().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-3-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/ipv6/anycast.c     | 2 +-
>  net/ipv6/icmp.c        | 6 +++---
>  net/ipv6/mcast.c       | 2 +-
>  net/ipv6/ndisc.c       | 2 +-
>  net/ipv6/output_core.c | 8 +++++---
>  net/ipv6/route.c       | 7 +++----
>  6 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> index 19ab520ea049d..8bf06f8cf9d68 100644
> --- a/net/ipv6/anycast.c
> +++ b/net/ipv6/anycast.c
> @@ -100,7 +100,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
>  		rcu_read_lock();
>  		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
>  		if (rt) {
> -			dev = dst_dev(&rt->dst);
> +			dev = dst_dev_rcu(&rt->dst);
>  			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
>  			ip6_rt_put(rt);
>  		} else if (ishost) {
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 229ae205450d3..e4e40f0694238 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -209,7 +209,8 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
>  	 * this lookup should be more aggressive (not longer than timeout).
>  	 */
>  	dst = ip6_route_output(net, sk, fl6);
> -	dev = dst_dev(dst);
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);
>  	if (dst->error) {
>  		IP6_INC_STATS(net, ip6_dst_idev(dst),
>  			      IPSTATS_MIB_OUTNOROUTES);
> @@ -224,11 +225,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
>  		if (rt->rt6i_dst.plen < 128)
>  			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
>  
> -		rcu_read_lock();
>  		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
>  		res = inet_peer_xrlim_allow(peer, tmo);
> -		rcu_read_unlock();
>  	}
> +	rcu_read_unlock();
>  	if (!res)
>  		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
>  				  ICMP6_MIB_RATELIMITHOST);
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 8a37e878e5f8e..298bf64899548 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -179,7 +179,7 @@ static struct inet6_dev *ip6_mc_find_dev(struct net *net,
>  		rcu_read_lock();
>  		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
>  		if (rt) {
> -			dev = dst_dev(&rt->dst);
> +			dev = dst_dev_rcu(&rt->dst);
>  			dev_hold(dev);
>  			ip6_rt_put(rt);
>  		}
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 87bed84a00532..26ad7cab0383f 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -508,7 +508,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
>  
>  	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
>  
> -	dev = dst_dev(dst);
> +	dev = dst_dev_rcu(dst);
>  	idev = __in6_dev_get(dev);
>  	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
>  
> diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
> index 90a178dd24aae..5be101401a00e 100644
> --- a/net/ipv6/output_core.c
> +++ b/net/ipv6/output_core.c
> @@ -104,18 +104,20 @@ EXPORT_SYMBOL(ip6_find_1stfragopt);
>  int ip6_dst_hoplimit(struct dst_entry *dst)
>  {
>  	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
> +
> +	rcu_read_lock();
>  	if (hoplimit == 0) {
> -		struct net_device *dev = dst_dev(dst);
> +		struct net_device *dev = dst_dev_rcu(dst);
>  		struct inet6_dev *idev;
>  
> -		rcu_read_lock();
>  		idev = __in6_dev_get(dev);
>  		if (idev)
>  			hoplimit = READ_ONCE(idev->cnf.hop_limit);
>  		else
>  			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
> -		rcu_read_unlock();
>  	}
> +	rcu_read_unlock();
> +
>  	return hoplimit;
>  }
>  EXPORT_SYMBOL(ip6_dst_hoplimit);
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 3e5bf8a5b32b2..f49b0578ae347 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2949,7 +2949,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
>  
>  		if (res.f6i->nh) {
>  			struct fib6_nh_match_arg arg = {
> -				.dev = dst_dev(dst),
> +				.dev = dst_dev_rcu(dst),
>  				.gw = &rt6->rt6i_gateway,
>  			};
>  
> @@ -3244,7 +3244,6 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
>  
>  static unsigned int ip6_default_advmss(const struct dst_entry *dst)
>  {
> -	struct net_device *dev = dst_dev(dst);
>  	unsigned int mtu = dst_mtu(dst);
>  	struct net *net;
>  
> @@ -3252,7 +3251,7 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
>  
>  	rcu_read_lock();
>  
> -	net = dev_net_rcu(dev);
> +	net = dst_dev_net_rcu(dst);
>  	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
>  		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
>  
> @@ -4266,7 +4265,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
>  
>  	if (res.f6i->nh) {
>  		struct fib6_nh_match_arg arg = {
> -			.dev = dst_dev(dst),
> +			.dev = dst_dev_rcu(dst),
>  			.gw = &rt->rt6i_gateway,
>  		};
>  
> -- 
> 2.53.0
> 
> 

did not apply
