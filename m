Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173846;
	b=UBQYh/k2egla4oHG9619TZElmEKWHjhSdWP/3aFrzEDcF0TEvNfaMIv7H0gctCMn/7Q5
	 dYyA0ohWoP3QTDAoEV930Jw4BuH852OrvBC5vTlD6WT36MRT0l2o4xLjSRmPAZx+92pzR
	 dnD3lc1623wUElOgJJMmQZWPCChg4ORrEFTjycM4mI6O3IyZytPDxIEV9CPDGFqS/blGl
	 E1hpQuDm8f918CM9lhw/bJqGWfsQYNxp/POTDEiN4zYbmecQz9v9PTsVXaGk5fgwFY9sn
	 k/pJhI2RhvP2ZHOd/onwKXVMtog4A0bOZvS5d6UFCJ66DePgSkRWUDdBK9oSH/kd2kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173846;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZRNxV+ctHGQkJGUcTRrGxGBFcfBRjwGvBSmUNqUGh4s=;
	b=0Mx+vz88ZnNoUdbkN/ft8ugOFrm+pc1gQSeIqgh0TByLbN5fiPBkBYC2n3e0x8XZnWLJ
	 0hnU50LL4ZTYShVIDwL3wsua0pfWV2wwsLEiEPqlJBj2hlhQQ/7lILVZo+U2YafxBC16p
	 fB3lijTlGdSaQ7kbxYFY28nSoB1kRcyCAelkKso5oAzmHPsO5cvb6yNwhG2aV7K9AIGoY
	 Uufq7N52fc6UaQVBYhizRMxOlN62fa78ejwgod73N8eGfryDuSsQLoJcjutdhnMg3pIWd
	 NLS2d3lEN9sVCNn7vaZ2a5Q+MaYrTI3N35YJ5Et7E6b+ZCDARZ2CRcwhZjs3pe1aWIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgLqA7LE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED3606A31A;
	Wed, 28 Oct 2026 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgLqA7LE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300C1F01825;
	Wed, 28 Oct 2026 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793173845;
	bh=ZRNxV+ctHGQkJGUcTRrGxGBFcfBRjwGvBSmUNqUGh4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mgLqA7LE1hT8ifeFCdgKjxs07zUMgblZj0t3wZSKxr2lqKSEgLV6wZpDGHMDmH8vg
	 dizIhqzKwtrjbGBS2t8dWYyN5k7a/3AwdNQAmKvMf8GnNoIlL3bvmm78wfgE41zb/d
	 O3XjszQs6Y3Rb+xAN+uwfp2Hl5sl9aqdL+NkdrVEzug0sF6FhlQBQZo4KGbaswucSN
	 T0BsZhXDXAW4365g1b5/MOxv9rKdnYn6zsMP6rXlIHlYIjtC39CX5tA6WdeN1jt4Fr
	 4kNtOTJ2ITRIj7n4tQLBvvNOQWTLBjWdFQrPj/+Q3IqIcTHZI900ho1+JWqe5sZQTA
	 qg7BHBvw5Lunw==
Subject:
 Re: [PATCH net v2] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
From: netdev-bot+sashiko@kernel.org
To: n0ps1edzz@gmail.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hangbin.liu@linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 28 Oct 2026 07:50:44 +0000
Message-ID: <179317384479.3134.10802512477499125760@kernel.org>
In-Reply-To: <20261026044808.613-1-n0ps1edzz@gmail.com>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In VRF redirect mode, rawv6_send_hdrinc() (net/ipv6/raw.c) no
  longer charges per-interface IPv6 SNMP counters to the slave interface.

--

ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

This patch reloads rt from skb_dst(skb) after l3mdev_ip6_out() returns in
rawv6_send_hdrinc(). The VRF output path can replace the skb dst and
release the original route, which leaves the cached pointer stale. It fixes
a KASAN slab-use-after-free reported in rawv6_sendmsg().

> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index b965258cf9e5f..bdea825434ea7 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>  	if (unlikely(!skb))
>  		return 0;
>  
> +	/* l3mdev_ip6_out() may have replaced the skb dst. */
> +	rt = dst_rt6_info(skb_dst(skb));
> +

[Severity: Medium]
Does this reload move the per-interface IPv6 counters off the slave device
in VRF redirect mode?

When the VRF device has a non-default qdisc and the packet is not
xfrm-transformed, vrf_ip6_out() calls vrf_ip6_out_redirect(), which swaps
in the VRF's private route:

drivers/net/vrf.c:vrf_ip6_out_redirect() {
    ...
	skb_dst_drop(skb);
	skb_dst_set(skb, &rt6->dst);
    ...
}

That vrf->rt6 comes from ip6_dst_alloc() in vrf_rt6_create().
rt6_info_init() zeroes everything after dst, and rt6i_idev is never set
afterwards. So after this reload, rt->rt6i_idev is NULL when the function
gets here:

	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
	...
		IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);

_DEVINC handles a NULL idev by skipping the per-device counter, so this
does not crash. Only the netns-wide counter gets bumped. The second
LOCAL_OUT pass in vrf_process_v6_outbound()->vrf_ip6_local_out() does no
OUTREQUESTS accounting either.

As a result, raw IPV6_HDRINCL packets sent on a VRF slave in this mode
would not show up in /proc/net/dev_snmp6/<slave> Ip6OutRequests or
Ip6OutDiscards, and no other device counts them.

The other IPv6 senders count OUTREQUESTS against the original route's idev
before the l3mdev diversion. ip6_xmit() does it before l3mdev_ip6_out().
__ip6_make_skb() does it before ip6_local_out(), and that covers raw
sockets without HDRINCL too.

Would it work to follow the ip6_xmit() pattern instead? That means taking
rcu_read_lock() before l3mdev_ip6_out() and counting OUTREQUESTS while the
skb still holds its reference on the original rt.

dst_release() frees through call_rcu_hurry(dst_destroy_rcu), and that
callback is also where rt6i_idev is dropped. So the original rt and its
idev should stay valid inside the read-side section. This would fix the
use-after-free without changing which device gets the stats.

>  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
>  	 * in the error path. Since skb has been freed, the dst could
>  	 * have been queued for deletion.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026044808.613-1-n0ps1edzz%40gmail.com
