Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757653;
	b=YT29GG5jm6x1/nOHZ95uALwCfeOiOwvj+3/UzPGsWcSFcgL4iFkI7yZuGnu1YIg/w+fK
	 ITfBCbLjdUa4BPigZn92AqS+BxgWa1+LgGS/NjW99ev0AsTvWKwX47BO56ojYm0OCL2y+
	 vu1hTaAHoEZqwZ7SRVIvqjhuatkj3gX/PJJ5FBqnEt6/I5jfUAVjhbuCHYUW2w4JHDxbd
	 eiPuccE0vCHDKD0dzg/UCEFi/gyum070CxOMtZbMouxjFKKRKQfRTTNS3C6fmBG8ox90w
	 ws/8JkbXbkbDYn4JUd0BQpeW0dTvakn9QZb6aDoM3w2BoE8B7J97YUQNS9jt7qffY8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757653;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=drYBVwb1O7PjkEdSxQ7VDO99vSxLe3uiv56MMlcoFsE=;
	b=DT9RycZ9wF1qaGv4HZh5cpb0m74gEf2pZ/jZ9mh2kxP7V+j0l6U/KWnoLqKl0DMyZ1PE
	 Ydpvtite/hlml5sdS7AP7ThxJCzajESBr1gfK60ZGAnc7zlnPSRUrX9SNqruXUd5aAiGZ
	 dvA0zW+chri5AoXc0J+cGRhbzFjw0qhhQNdYxjardOdiPLO1Y6slzkjfWzBype++2S17e
	 nDqrbKeoonGsdLXgORYjBNe88SSi5liyndu1dj2TvR5S6t85shGhqVMtDtelI0ioFKJks
	 w5dwr5gbTtEO0c3PxYvKwqqVJ626wNdvX29RN370a1Zg4r2D0YFdq2dI3DcFqhen7ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQAlcJg2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCE606A331;
	Sun, 15 Nov 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQAlcJg2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FC41F000C4;
	Sun, 15 Nov 2026 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794757652;
	bh=drYBVwb1O7PjkEdSxQ7VDO99vSxLe3uiv56MMlcoFsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RQAlcJg29DmqUdLbKFjewSYH8Bx1N1dyCCQKB6kkpM1roEmi9ZjwFyHtMbL/XaHVS
	 AodsczZ/o3+0gX9gSa+e/GPK3nz0K19AcNWE1rtBphDF73JDnauvQaOzoobOvQl6/a
	 nAWpt1VAgtyRqlr9865VAJ+9TbH/U6cIsFlXVlZnY2EvlYVzA9cimKnYeNobA1cqY+
	 qbeO2Z5Fef6uhh9YuPYLFWf9ypCD195Y/nt3f51YMU5Lj7TMeHA6GNiK8juX9Rf5tF
	 2su61lp3l7cRG2TcbJdXjNryLVpXCidLKMVxSlVQsvl35tqyB0OVez9fHSeQNdUhZ/
	 42czDxesZ8jqQ==
Subject: Re: [PATCH net v4 2/3] net: neighbour: reinject a parked skb through
 a headerless output device
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Sun, 15 Nov 2026 15:47:31 +0000
Message-ID: <179475765178.2199510.12946653524000550678@kernel.org>
In-Reply-To: <QDISC-6HS9.v4.r0.20261111094338-2@mojatatu.com>
References: <QDISC-6HS9.v4.r0.20261111094338-2@mojatatu.com>
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

- [Medium] The new check in neigh_update_process_arp_queue()
  (net/core/neighbour.c) is `if (!n1->dev->header_ops) skb->dev =…

--

net: neighbour: reinject a parked skb through a headerless output device

When n1->dev has no header_ops, this patch makes
neigh_update_process_arp_queue() set skb->dev to n1->dev before it calls
n1->output. Here n1 is the top-level neighbour looked up again from the
skb's dst. The patch is aimed at sch_teql, which parks skbs on the slave's
neighbour with skb->dev set to the slave.

Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a892..1b556fa17c57c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		/* headerless output transmits on skb->dev, not n1->dev */
> +		if (!n1->dev->header_ops)
> +			skb->dev = n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);

[Severity: Medium]
Can this gate send a redirected skb back through the egress hooks of the
original device?

The check has no way to tell sch_teql apart from forwards that move the
skb to another device but keep the original route's dst attached. Two
forwards do this: nft fwd ... neigh, and bpf_redirect_neigh() called with
explicit nexthop parameters.

Here is the sequence:

1. One of these forwards runs at the egress hook of a device X that has no
header_ops (for example wireguard, ipip or sit). nft_fwd_validate() allows
NF_NETDEV_EGRESS. The egress hooks run before the dst is dropped, so
dst->dev is still X:

net/core/dev.c:__dev_queue_xmit() {
    ...
	skb = nf_hook_egress(skb, &rc, dev);
    ...
	skb = sch_handle_egress(skb, &rc, dev);
    ...
	if (dev->priv_flags & IFF_XMIT_DST_RELEASE)
		skb_dst_drop(skb);
    ...
}

2. The forward sets skb->dev to an ARP-capable device Y and transmits
without dropping the dst:

net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
    ...
	skb->dev = dev;
	skb_clear_tstamp(skb);

	nf_dev_xmit_recursion_inc();
	neigh_xmit(neigh_table, dev, addr, skb);
    ...
}

On the BPF side, __bpf_redirect_neigh_v4() replaces the dst only when
nh is NULL:

	if (!nh) {
		...
		skb_dst_drop(skb);
		skb_dst_set(skb, &rt->dst);
	}

	err = bpf_out_neigh_v4(net, skb, dev, nh);

The IPv6 path through bpf_out_neigh_v6() follows the same pattern.

3. If Y's neighbour is INCOMPLETE, the skb is parked on Y's arp_queue
with the stale dst still attached.

4. When Y's neighbour resolves, the drain loop sets n1 from
dst_neigh_lookup_skb(dst, skb). That gives X's neighbour, and because X
has no header_ops, arp_constructor() set it up with neigh_direct_output:

net/ipv4/arp.c:arp_constructor() {
    ...
	if (!dev->header_ops) {
		neigh->nud_state = NUD_NOARP;
		neigh->ops = &arp_direct_ops;
		neigh->output = neigh_direct_output;
    ...
}

5. The new gate changes skb->dev from Y back to X, and
neigh_direct_output() then calls dev_queue_xmit() on X.

As a result, X's nft netdev egress chain and its tc egress BPF program
run a second time on a packet they have already handled.

nft_fwd_neigh_eval() calls ip_decrease_ttl() (or decrements hop_limit)
again, so TTL drops by 2. A packet that arrives with TTL 2 is then
dropped.

Counters, quotas and limits count the packet twice, and BPF mangling or
encapsulation is applied twice. If the second pass makes a different
decision, the packet leaves on X instead of the forward target.

Before this patch the same parked skb was also mishandled: it left Y
through neigh_direct_output with no link header. So the patch changes how
this case fails, but running the hooks a second time is new.

The commit message describes this side effect:

  Those forwards supply their own device and nexthop and do not consult
  the retained dst, so dropping it at those two sites is where that is
  fixed; that is a separate change to the producers.

That producer change does not appear in the series. The later commit
"net/sched: sch_teql: keep skb->dev consistent on the arp-queue path"
only touches sch_teql.c, so the double traversal is still there at the
end of the series.

Could skb_dst_drop() be added to nft_fwd_neigh_eval() and to the nh != NULL
paths of __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() as part of
this series, ordered before this patch?

>  		if (n2)
>  			neigh_release(n2);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v4.r0.20261111094338%40mojatatu.com
