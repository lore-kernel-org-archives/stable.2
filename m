Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757652;
	b=Yglm5Qcx5XOWzd8+RSvzKCX44tfcuYJ57ZlY0DyZRSNvxsspf1agYl4Rm7Xmty3JrsRO
	 ok61UYsScSAYHrQlmdC/ykwZWn/mrZKvkhfJMNKn9RjSFx2Oz6c4GdJvwLA+fHGXIFey0
	 UgTLs4VzcqifzjFoH6/MQTBBSn2dp7cPuieJ7qn2s/myYTEP11JvHPrbOLJbfCNZbpapA
	 yCmC3QP4hsKQnNQV+0Fv9v+i/xfQ0Xhx8GS5JCxmluYwikrnrK4xBzQGtrnfTGTROMj6X
	 gfuOyLI7n6ZS5hALNu5juJ0qcoPeIdIDjYms2ymbjJpBGHTYkk5kcUIuFYD0njKa7Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757652;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ssC+l7FHTZNvjshh4+FS/k6nvNfv//7Ip2k4X6XbrQg=;
	b=fQ92xgGaZHgCohPl0qhI1Y6gpwblYhFPIJ95CIROMVUp6DjHfnsDUEf8LcyNUK2DEjYp
	 2s7rqNZBI2rK5F3OmMndbI0/YJnlXJzcl0kEY8RUMLMYfY5fxZcEdYFtmA4KxIih3x1qr
	 qdWxUq1vwrqD5wMhA/phavP/EAvvyKIDrkxzo1hXvab9FVaBLv3wD+up4pw36ij9S1VoG
	 tlxUJXg0aOQu62jRE7hgpdMePFRk++Ysmd8VK0iS+9yjFS8aXISa1Gw/Yk4aJxflaK8tp
	 a6be5S2R9Q8l5ODVu3o0trYiDmNtO0jTuZxbhvNc2N1W7Jo6qF5MWJ+SGDhol3qso6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBnDOjBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D62606A31A;
	Sun, 15 Nov 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBnDOjBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E9D1F000C4;
	Sun, 15 Nov 2026 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794757651;
	bh=ssC+l7FHTZNvjshh4+FS/k6nvNfv//7Ip2k4X6XbrQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bBnDOjBI5rEpcIDxpLhV1OI9mZbML0CcNkvS1nKwGqiQqWn3z31/EXGwmqRp0YUAT
	 zPaituEts5BfK//OsZlPUbhOiAfFfxluDU6BqKCd2FdtH0a0XPY7amcE4EF9VU7LWV
	 TDgjZyRq/6l3pA6VW2a7+akXKbYDtqJ27stWVlOSQ6yHgPjytosqs36Gq3wi7nbwLU
	 rKVQdSq53X8Ckej8GC1I+pHU4t5Pl1mqrlTuxNyzA4OtcELSMGwWCbfSItKVZOqZl3
	 QIqf0FnJjl1Xry4YNM7JBR+4J9+goB0KLLgFD5dUUxFOyngCO1grbkHGJMHcz/b4JZ
	 wpac5Pdp8Pt/A==
Subject: Re: [PATCH net v4 1/3] net/sched: sch_teql: unshare the header before
 writing and fix retry strip
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Sun, 15 Nov 2026 15:47:30 +0000
Message-ID: <179475765049.2199510.14948882455046575190@kernel.org>
In-Reply-To: <QDISC-6HS9.v4.r0.20261111094338-1@mojatatu.com>
References: <QDISC-6HS9.v4.r0.20261111094338-1@mojatatu.com>
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

- [Medium] The fix leaves a gap: `skb_cow_head()` in `__teql_resolve()`
  (net/sched/sch_teql.c) only runs when `neigh_event_send(n, skb_res) ==…

--

net/sched: sch_teql: unshare the header before writing and fix retry strip

This patch calls skb_cow_head() in __teql_resolve() before
dev_hard_header() writes the slave's link header, so that a header-cloned
skb does not corrupt the other clone. It also records how many header bytes
each slave added in teql_master_xmit() and pulls back only that many on
retry. As a result, an AF_PACKET frame with no dst keeps its user-supplied
header.

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index dc21cd9704a25..3f781a3ffb41a 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c

[ ... ]

> @@ -293,15 +293,24 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
>  	}
>  
>  	if (neigh_event_send(n, skb_res) == 0) {
> +		int off = skb_network_offset(skb);
>  		char haddr[MAX_ADDR_LEN];
>  
>  		neigh_ha_snapshot(haddr, n, dev);
> +		/* Unshare the header before dev_hard_header() writes to it. */
> +		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
>  		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
>  				    haddr, NULL, skb->len) < 0)
>  			err = -EINVAL;
> +		/* The bytes prepended above skb->data, pulled back on retry. */
> +		*hlen = skb_network_offset(skb) - off;
>  	} else {
>  		err = (skb_res == NULL) ? -EAGAIN : 1;
>  	}

[Severity: Medium]
The skb_cow_head() only runs when neigh_event_send() returns 0. What
happens to a header-cloned skb that takes the else branch instead?

Suppose every slave neighbour is unresolved on the first pass of
teql_master_xmit(). Then neigh_event_send(n, NULL) fails, teql_resolve()
returns -EAGAIN and nores is set, and no unshare has run. teql then
restarts with the same skb as skb_res:

teql_master_xmit() {
    ...
	if (nores && skb_res == NULL) {
		skb_res = skb;
		rcu_read_unlock();
		goto restart;
	}
    ...
}

On the restart, neigh_event_send(n, skb_res) parks the skb on the slave
neighbour's arp_queue with its header still cloned:

net/core/neighbour.c:__neigh_event_send() {
    ...
			skb_dst_force(skb);
			__skb_queue_tail(&neigh->arp_queue, skb);
    ...
}

The usual reinjection path is covered. The skb's dst resolves to teql0's
own neighbour, whose output is neigh_direct_output(). That re-enters
teql_master_xmit(), where the new skb_cow_head() runs.

However, neigh_update_process_arp_queue() can fall back to a different
neighbour:

net/core/neighbour.c:neigh_update_process_arp_queue() {
    ...
		n2 = NULL;
		if (dst &&
		    READ_ONCE(dst->obsolete) != DST_OBSOLETE_DEAD) {
			n2 = dst_neigh_lookup_skb(dst, skb);
			if (n2)
				n1 = n2;
		}
		READ_ONCE(n1->output)(n1, skb);
    ...
}

This happens in two cases:

- The dst became DST_OBSOLETE_DEAD while the skb was parked (for example,
  a route delete that ends in dst_dev_put()), or dst_neigh_lookup_skb()
  fails. Then n1 stays the slave's neighbour.

- In the tc-mirred setup from the commit message, the dst belongs to the
  physical device, so n1 is that device's neighbour.

In both cases neigh_resolve_output() writes the link header without
checking skb_header_cloned():

net/core/neighbour.c:neigh_resolve_output() {
    ...
			__skb_pull(skb, skb_network_offset(skb));
			seq = read_seqbegin(&neigh->ha_lock);
			err = dev_hard_header(skb, dev, ntohs(skb->protocol),
					      neigh->ha, NULL, skb->len);
    ...
}

Can this overwrite the link header of the other clone, such as the mirred
original still pending on the physical device or a PF_PACKET tap clone? In
the mirred case the bytes written are usually identical, but they differ if
the lladdr changed in the meantime.

The commit message says "a header-cloned skb is unshared before the write",
but the arp_queue handoff does not seem to be covered.

The later patches in the series don't add an unshare on this path either:

- "net: neighbour: reinject a parked skb through a headerless output
  device" only rewrites skb->dev for a headerless n1.

- "net/sched: sch_teql: keep skb->dev consistent on the arp-queue path"
  only moves the skb->dev = slave assignment.

Would it work to call skb_cow_head() before neigh_event_send(n, skb_res),
or once at the top of teql_master_xmit()?

> +out:
>  	neigh_release(n);
>  	return err;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v4.r0.20261111094338%40mojatatu.com
