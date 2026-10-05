Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26F492E35
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209335; cv=none; b=I/FPEqltBtADztMOZCpNubcyO5am/vDEphWtT0oqZ4ewHJJyUaE3e5N7a1r3Z8JAHARub3Vq3b5Qcks876DdAvq/s3cGEPXMp74+PkOOKoqkvKn9/nfUviCZ1RvpDkGLYBZrAMfyV4Egh/i/TJTs689rANLBiFZ8avRfyk1qShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209335; c=relaxed/simple;
	bh=LjGdt3QJxCMTUQ/GgXGO+E1wzqiIkBRUfQ45hhbrdqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G70bqfZbtQSB4R62jOspPwzacQOTGi2fn/dy+CXVKRVn5vu8L2FPc2YWykd7fQuzZsDSMdMeDEVfDQXmmsb1d4nY0u1Z4QuyEVNV6RoN10HrTjmM7M31cN/xMystF4urR3WayHzgSR7vy05jEVrqKRaMJhFKjY09+gV3pztcUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZJgIWJJT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZJgIWJJT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 536C34E4118B;
	Mon,  5 Oct 2026 14:08:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E93E601A5;
	Mon,  5 Oct 2026 14:08:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51746103301E2;
	Mon,  5 Oct 2026 16:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791209326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=amazYib6JJlAEBxLc+xTEs/eTJtuJjAY30N5DyMbksQ=;
	b=ZJgIWJJTyuRQEgDQsWyjoO6MmxVzu5D0C4Tqc4Ix6GCfurY3y/nBkGGXT4lAzOOCDxvc0u
	0eG+11W9HVc3Hz4EVoGgB9Tmjb9v53sXwE6ZDqeZuhyOFkxXB0q6rDBABcFmzp2eFuErCF
	ac77NuATVhBHGrgJbOAxT5uUvODbCr8OePL23dTlL9KqYuj4k4bBLFESobzBi70yfc91tP
	EWTHMTOXcdRiHCHjwLytj1oMew5QmTkjY2tbmLBRNOl7an6EhW1JAYVU/rEbZxGQ83q0ZS
	jdHKCHC1gOaa8ok7pnCmajvf3sf3UvIZUowH2Y8o3JZCxoKMYPcb3w5RBirSxQ==
Message-ID: <0638218f-cfb7-4d53-98b0-d20b08dcf9fc@bootlin.com>
Date: Mon, 5 Oct 2026 16:08:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: use RCU in ip6_output()
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20261005-cve-2026-40158-v1-1-98505c5ee970@bootlin.com>
Content-Language: en-US
From: Miguel Gazquez <miguel.gazquez@bootlin.com>
In-Reply-To: <20261005-cve-2026-40158-v1-1-98505c5ee970@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi.

Sorry, I forgot to put the prefix. This is a backport for the 6.12 
branch, where the upstream commit apply cleanly.

On 10/5/26 16:06, Miguel Gazquez (Schneider Electric) wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 11709573cc4e48dc34c80fc7ab9ce5b159e29695 ]
> 
> Use RCU in ip6_output() in order to use dst_dev_rcu() to prevent
> possible UAF.
> 
> We can remove rcu_read_lock()/rcu_read_unlock() pairs
> from ip6_finish_output2().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-5-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
> ---
>   net/ipv6/ip6_output.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index e53dbf14873a..50ed10b448c4 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -60,7 +60,7 @@
>   static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	struct dst_entry *dst = skb_dst(skb);
> -	struct net_device *dev = dst_dev(dst);
> +	struct net_device *dev = dst_dev_rcu(dst);
>   	struct inet6_dev *idev = ip6_dst_idev(dst);
>   	unsigned int hh_len = LL_RESERVED_SPACE(dev);
>   	const struct in6_addr *daddr, *nexthop;
> @@ -70,15 +70,12 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
>   
>   	/* Be paranoid, rather than too clever. */
>   	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
> -		/* Make sure idev stays alive */
> -		rcu_read_lock();
> +		/* idev stays alive because we hold rcu_read_lock(). */
>   		skb = skb_expand_head(skb, hh_len);
>   		if (!skb) {
>   			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
> -			rcu_read_unlock();
>   			return -ENOMEM;
>   		}
> -		rcu_read_unlock();
>   	}
>   
>   	hdr = ipv6_hdr(skb);
> @@ -125,7 +122,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
>   
>   	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
>   
> -	rcu_read_lock();
>   	nexthop = rt6_nexthop(dst_rt6_info(dst), daddr);
>   	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
>   
> @@ -133,7 +129,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
>   		if (unlikely(!neigh))
>   			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
>   		if (IS_ERR(neigh)) {
> -			rcu_read_unlock();
>   			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
>   			kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
>   			return -EINVAL;
> @@ -141,7 +136,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
>   	}
>   	sock_confirm_neigh(skb, neigh);
>   	ret = neigh_output(neigh, skb, false);
> -	rcu_read_unlock();
>   	return ret;
>   }
>   
> @@ -235,22 +229,29 @@ static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
>   int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	struct dst_entry *dst = skb_dst(skb);
> -	struct net_device *dev = dst_dev(dst), *indev = skb->dev;
> -	struct inet6_dev *idev = ip6_dst_idev(dst);
> +	struct net_device *dev, *indev = skb->dev;
> +	struct inet6_dev *idev;
> +	int ret;
>   
>   	skb->protocol = htons(ETH_P_IPV6);
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);
> +	idev = ip6_dst_idev(dst);
>   	skb->dev = dev;
>   
>   	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
>   		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
> +		rcu_read_unlock();
>   		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
>   		return 0;
>   	}
>   
> -	return NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
> -			    net, sk, skb, indev, dev,
> -			    ip6_finish_output,
> -			    !(IP6CB(skb)->flags & IP6SKB_REROUTED));
> +	ret = NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
> +			   net, sk, skb, indev, dev,
> +			   ip6_finish_output,
> +			   !(IP6CB(skb)->flags & IP6SKB_REROUTED));
> +	rcu_read_unlock();
> +	return ret;
>   }
>   EXPORT_SYMBOL(ip6_output);
>   
> 
> ---
> base-commit: 7aba70ab2e8d8ab3cd45abcaa15e1119a00dc42a
> change-id: 20261005-cve-2026-40158-297526f781f7
> 
> Best regards,
> --
> Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

-- 
Miguel Gazquez, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

