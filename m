Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0B3F327A;
	Tue, 29 Sep 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683867; cv=none; b=NM4mav0ZVddnpPPSb01Y9FrY2Inqg9oaNA16Icbhl57WYZ6WAZA5tcQdDuZMeuzTM5/MyMn08gqtlJMleSMGJaahc88pbc8ddY/DCR11VruqsRctWTRTvZDyEJGPYynbp792wZr+lcOVZjRwSLMATxxRpXclfV7SChWSNaXOQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683867; c=relaxed/simple;
	bh=JMpibS+emmAWxrdejAIKkVgRpGUMsskFaZuanFvenTY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rri8xZsoueZX5edRlyhkICvSZVfCFeZgKhczZZgpSDLfx9NqgrtXv/o5XQ6GnY9w9wt2ImLOlkgKWRO12ca2C91cammPuZNzMdBCT+g3qhat0RTttXAsnrlGt99JQomlJHsMiDxowXxQvN13ktS4k4hgoG2eYXH3CAR621n0ryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkhSEivx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkhSEivx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EE21F000FF;
	Tue, 29 Sep 2026 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683860;
	bh=sAfgFHfkUXD+jfvtAi4J7fZQjFaGsP2RE564qdfQ5Pc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NkhSEivxCTyq0tMOyqxPLe/1KDtvBflMbVqqRdiuAi6fQ1nbZFtzd+oo9HWzXN8d6
	 UwBtB5r7z0n305ThhQg9kTbbyeoeGQW8QMHEGbMQe7KwWf6GRm3cTQ+kTKRWqaS3Os
	 3lUoy6I9va0dTBbfxJJckEoYLxCp6221j9qqlN4+z3clJ/5IzbFNzgKD5YToHxEssj
	 cRs+c8e5T90jjwjUr4NijhWoXjQnQoH0T2CwIuiWD/6uGlHc8UXiw+43JB/GGkgMox
	 /aovIO8zz3xkcco8MCjueC4HZEfznbLShl/4LwjjErACRde9BivxeixG40sAaOXIS/
	 scgBFrK7Dl6Bg==
Subject: Re: [PATCH net] ipv4: Fix device use-after-free in ip_skb_dst_mtu()
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jheffner@psc.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 29 Sep 2026 12:10:58 +0000
Message-ID: <179068385893.434549.3173123670853979127@kernel.org>
In-Reply-To: <20260927071051.3693368-1-nicoyip.dev@gmail.com>
References: <20260927071051.3693368-1-nicoyip.dev@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This fix is incomplete.

--

ipv4: Fix device use-after-free in ip_skb_dst_mtu()

This patch wraps the dev->mtu read in ip_skb_dst_mtu() in
rcu_read_lock()/rcu_read_unlock() and switches it to dst_dev_rcu(). It
targets a KASAN-reported net_device use-after-free on the multicast and
broadcast output path, where ip_mc_output() reaches ip_finish_output()
without an RCU read lock held.

> diff --git a/include/net/ip.h b/include/net/ip.h
> index 6f602df72ee62..14d6f77f3bb89 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -543,7 +543,9 @@ static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
>  		return ip_dst_mtu_maybe_forward(dst, forwarding);
>  	}
>  
> -	mtu = min(READ_ONCE(dst_dev(dst)->mtu), IP_MAX_MTU);
> +	rcu_read_lock();
> +	mtu = min(READ_ONCE(dst_dev_rcu(dst)->mtu), IP_MAX_MTU);
> +	rcu_read_unlock();

[Severity: High]
Is this fix complete? The commit message names the root cause as
ip_mc_output() reaching ip_finish_output() with no RCU read lock held.
That is still the case after this patch, so the other device reads on the
same path are still unprotected.

ip_mc_output() in net/ipv4/ip_output.c does a plain load of the device.
It takes no RCU and no reference, then stores the pointer in skb->dev and
passes it as outdev:

net/ipv4/ip_output.c:ip_mc_output() {
	struct rtable *rt = skb_rtable(skb);
	struct net_device *dev = rt->dst.dev;
	...
	skb->dev = dev;
	...
	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
			    net, sk, skb, NULL, skb->dev,
			    ip_finish_output,
			    !(IPCB(skb)->flags & IPSKB_REROUTED));
}

Right after ip_skb_dst_mtu() returns, __ip_finish_output()->
ip_finish_output2() reads the device again, before its own
rcu_read_lock():

net/ipv4/ip_output.c:ip_finish_output2() {
	struct net_device *dev = dst_dev(dst);
	unsigned int hh_len = LL_RESERVED_SPACE(dev);
	...
	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
	...
	rcu_read_lock();
	neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
	...
}

Can the same race described in the commit message now hit freed memory in
ip_finish_output2() instead of in ip_skb_dst_mtu()?

The same seems to apply to ip_do_fragment(). It calls ip_skb_dst_mtu() and
then reads the device outside RCU when reached from ip_mc_output() via
ip_fragment():

	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);

There are more users of the pointer that ip_mc_output() saved in skb->dev.
On the GSO path, ip_finish_output_gso() calls netif_skb_features(skb).
The multicast and broadcast loopback clones go through
ip_mc_finish_output()->dev_loopback_xmit().

No caller on the UDP path from the KASAN trace provides RCU either.
ip_send_skb() calls ip_local_out() directly:

net/ipv4/ip_output.c:ip_send_skb() {
	err = ip_local_out(net, skb->sk, skb);
	...
}

ip6_send_skb() wraps ip6_local_out() in rcu_read_lock().

The unicast path already has the full-coverage pattern. It was added to
ip_output() by commit 1dbf1d590d10a6 ("net: Add locking to protect
skb->dev access in ip_output"):

	rcu_read_lock();
	dev = skb_dst_dev_rcu(skb);
	skb->dev = dev;
	...
	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
				net, sk, skb, indev, dev,
				ip_finish_output,
				!(IPCB(skb)->flags & IPSKB_REROUTED));
	rcu_read_unlock();

Would it be better to apply the same outer RCU section in ip_mc_output(),
and maybe also in ip_send_skb() to match ip6_send_skb()? That would cover
the whole ip_finish_output() chain instead of only the dev->mtu read here.

>  	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927071051.3693368-1-nicoyip.dev%40gmail.com
