Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438882;
	b=u0pk6nR8lmoritb2eKF/uJ+a45E+bjJAy61iksq7ZjnTwDBdU0flCassrE8telibbPMk
	 L5kc9V/rfVRPq8EIUU8S7c8oNoFK8cegUQYnW8f12dNBmTfEA0O+5PvLsjyYdG/k3S/eo
	 2LBJV0SjMwcjHEogO4CtD0wa6lzp/ym9dEFfmBjkYcnqh9r1VWl7wZVlLkBs9VIDD+CrO
	 c9krmAlMGoaTb9s5Ov0JEYwjOSUmtPZbEjGW6EqRraOWRa5GYyoNjFUhNUH3f1HNGVbTg
	 pT/9fENx7+ZCqStQ2pLwWUD/wmgC99tzZKJ3qrhFmujToEMEJ9d8r+99pf5aoKTLY/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438882;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eslbTwCS3DOxu5OkG+CmAJ6KLSRI8ONcb53rubmd8D4=;
	b=5nuYJ3hS7je5q1VQB50olUgArKvu+kRL+ojXSPXQe2mb/F03xU6JCThkRuzK2/e4KwJw
	 siGZj1oiOs6SUm8vs8sqxEJJKm8aRRdeUGHMgvwXuPheglvJCtWwvuaoaGjmgfVM6Ss6E
	 kDAenBYmujN1K4pKuPUkXw6SWpab0Wvg58CoTpMlsT1dUALYzlIznb83b/0lS16OTVNdL
	 ahmvRo5rn+B7bNKpUupN0524pz5mr9b39b9D8ImpNZBVTe7Z7RxmLROoNPyzXYXC2vgz7
	 NUwrbCVg0/OUSN0IefMQ89UrY76o58ljU2w0MxnGS6M94XV67fVrofh/rJUQW+IcaWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivys1QOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B0606A31E;
	Mon, 23 Nov 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivys1QOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546901F000E0;
	Mon, 23 Nov 2026 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438881;
	bh=eslbTwCS3DOxu5OkG+CmAJ6KLSRI8ONcb53rubmd8D4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ivys1QOH3tQj2lONDekX2iV3dojbsWZsnOsDbtJ7DY57xT3h2WF5+Q82ZAKuJgczD
	 8vrAEXW3LLvPCkwvth+lKnpV1vgDG0e7RtcjQFLx9NMhlDsRVN2OdkyQwbiCYcMH7a
	 Uoxdbkq5tlJBY4w3bX00bXH0EOT/JtmkHmNXOKRpoSRLYRgXNYisdewpeza//+DxuT
	 ev/5I/Yy9GVILZcumqAknoa58gGtFzQjFit9R5vFc0Y3HHhWz+JKhIlQ0M7whN8cri
	 nty8CaMd0mFsiTm1emb4Gfv9jbpQfdpDJlQAmAs3fycR163FZSTs7+znC87WzTJ/iR
	 y13+5yK9q2Dkg==
Subject: Re: [PATCH net v6 1/3] net/sched: sch_teql: unshare the header before
 writing and fix retry strip
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 23 Nov 2026 13:01:20 +0000
Message-ID: <179543888086.3135.17583427226707859195@kernel.org>
In-Reply-To: <QDISC-6HS9.v6.r0.20261119070330-1@mojatatu.com>
References: <QDISC-6HS9.v6.r0.20261119070330-1@mojatatu.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new comment in __teql_resolve() ("Each attempt starts from
  the network header, as neigh_resolve_output() does.") and the matching…

--

net/sched: sch_teql: unshare the header before writing and fix retry strip

This patch calls skb_cow_head() in __teql_resolve() before the neighbour
can write or queue the skb, so a cloned header is not corrupted. It also
pulls the skb to its network header before resolving. On retry,
teql_master_xmit() now pulls back only the link header length the slave
added.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v4.r0.20261111094338-1%40mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index dc21cd9704a25..44730a5e89178 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c

[ ... ]

> @@ -292,6 +292,18 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
>  		n = mn;
>  	}
>  
> +	/* Unshare the head before the neighbour can write or queue it. */
> +	if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Each attempt starts from the network header, as
> +	 * neigh_resolve_output() does.
> +	 */
> +	if (skb_network_offset(skb) > 0)
> +		__skb_pull(skb, skb_network_offset(skb));
> +
>  	if (neigh_event_send(n, skb_res) == 0) {

[Severity: Low]
Is this comment accurate? The commit message makes the same claim:

  "Start every attempt from the network header, as neigh_resolve_output()
  does"

The pull only runs when three things hold: the slave has header_ops, the
skb has a dst, and the neighbour lookup succeeds. teql_resolve() still
returns early, before it calls __teql_resolve():

net/sched/sch_teql.c:teql_resolve() {
    ...
	if (!dev->header_ops || !dst)
		return 0;
    ...
}

Also, __teql_resolve() returns -ENOENT or PTR_ERR(mn) before it reaches
the pull.

Take an skb that has a dst and skb_network_offset() > 0. One example is
the tc-mirred redirect from a physical device's clsact egress that the
commit message mentions.

If a slave without header_ops is tried first, it transmits the skb with
the incoming link-layer bytes still in front of the network header.

If a header_ops slave was tried earlier in the same round and failed or
was busy, that same slave gets the skb starting at the network header.
So what goes on the wire still depends on slave order.

The comparison with neigh_resolve_output() is also not exact. That
function only pulls once the neighbour has resolved:

net/core/neighbour.c:neigh_resolve_output() {
	if (!neigh_event_send(neigh, skb)) {
		...
		do {
			__skb_pull(skb, skb_network_offset(skb));
    ...
}

Here the pull runs before neigh_event_send(), whatever that returns. On
the -EAGAIN and queued paths the leading bytes are dropped while *hlen
stays 0.

The retry comment in teql_master_xmit() is accurate about the header
that was pushed:

	/* Pull back only the header this slave added. */
	if (hlen > 0)
		__skb_pull(skb, hlen);

However, the link-layer bytes that the earlier pull in __teql_resolve()
removed are never restored. So the skb does not go back to the state it
was in before the attempt, and neither comment says so.

The old unconditional retry pull already behaved in this order-dependent
way, so this is only about the wording. Could the comments and the commit
message be changed to describe what the code actually does?

> @@ -299,9 +311,12 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v6.r0.20261119070330%40mojatatu.com
