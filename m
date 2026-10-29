Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297777;
	b=skbsiNl+DRKPyJ76reiPiwOjjPJWwO90ZO3UHcUSB4drgtcKY8LydK7KEgWS7ZPplPcn
	 ZgPzqVhzk40Nq5FLUlRT2Lnlx21Q29aHrvI5D6RptH1Vwu6i9E9zIomP6lp16gthnQaA/
	 92hjr1ld+vFl9oTT2xrmUal823YnJw9fgjGmeVCUf0vrOX2C3fayermRYMDTD86I4C4L9
	 /CVDH2rJL/50iuqNmme1fkI/WbnjigdJ8gD3WAmWjbUOeVDiYVW+9PE2ulOIg07xVxT/T
	 WGSn378S3TErs5ypmVKxgC1CJnLm6DoOHgzXrP0aUKZPwzzltGCuT/VWQErk+0OPKsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297777;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YCty3KVa5xRdvMsKJANqLK9+srhfOJGoVNkKo5xizWo=;
	b=fJKxGsXX/Bavsc6TxVcq9jDlx9xEmjhY8BK5M+JBvqGmhvNlKK20dXr0yGMLhMOCpTjD
	 CHgPIWeSniKH1Hh/jxMbR2BUj2+M1OvACWXZXfIF5ZpXVdst78EBaqQq29pX/n/VL0m5S
	 kdlZp1Va4MC9ulSbxlNQoMAs0xfe4XrJ9PCyZ49mDtup+Egi0HP1zvuFX05QxWB37LsBL
	 pHjNjkx8V9LoblHnaFCMzqSxS0d9bQobz7/0iwaAo/cAUnASsJtJ2ELYdViOm8RF39nTt
	 F1Jz5ltX0NI8WZ98oJfo4QFeOyl84r0x7IOjyzRhC9ec+nVpbqmQzsf50X6Xpd4VLng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbcqz8OS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C0606A334;
	Thu, 29 Oct 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbcqz8OS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B711F01816;
	Thu, 29 Oct 2026 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297776;
	bh=YCty3KVa5xRdvMsKJANqLK9+srhfOJGoVNkKo5xizWo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bbcqz8OSZeV6ud3xfB2PxlrFgz5pKWK1/zMaKCk1m2mq2yT9mIsbLw8V3qf9Xl39W
	 1gUhcmpDxD2uPxNca1PXMKH73YmKUeG2JuVfdTcOM9Zwvv7c1EjxfIBHZIbbpFyghD
	 DKTV1KU+r+qa30swXgepKl5NY22bm+VWbMmRawdTdeDvqbOgMfjMzJd2C3M8RjdhCx
	 Bj/kJB5W2iZVjpQrLDQbzYkKfjKIuC5T7IBV4ahs0V36+HLi3nfSmgLZA92KnjN0+B
	 kk24Ukzi8qlIE0np/oiwQVHdzyhV6gEaCdVm0aXn2E/k5h0fpIfoyD+V2WsQ1HmN2H
	 ga566q1PqmBOw==
Subject: Re: [PATCH net v5] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 vinicius.gomes@intel.com, horms@kernel.org, hawk@kernel.org,
 daniel@iogearbox.net, sashiko-bot@kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 29 Oct 2026 18:16:15 +0000
Message-ID: <179329777513.3134.12135506558709584471@kernel.org>
In-Reply-To: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com>
References: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com>
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

- [Medium] The patch silently changes behaviour on stable kernels, and
  its commit message and docs do not describe the change accurately.

--

net/sched: clamp skb->queue_mapping before indexing the tx queue

A tc BPF store can leave skb->queue_mapping out of range. This patch caps
it in the qdisc dequeue paths in sch_generic.c and in taprio_enqueue(), so
it can no longer index dev->_tx[] or q->qdiscs[] out of bounds. On a
TCQ_F_ONETXQUEUE qdisc the mapping is pinned to the qdisc's own
q->dev_queue instead of being capped to queue 0.

Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://lore.kernel.org/netdev/179293123940.3134.1149128679923234677@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r0.20261021042722-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0..5dc1d47f811a 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -96,9 +96,34 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
>  
>  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
>  
> +/* Re-cap a stale queue_mapping; an ONETXQUEUE qdisc pins q->dev_queue. */
> +static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb)
> +{
> +	u16 queue = skb_get_queue_mapping(skb);
> +	struct net_device *dev = qdisc_dev(q);
> +	u16 capped;
> +
> +	if (q->flags & TCQ_F_ONETXQUEUE)
> +		capped = q->dev_queue - netdev_get_tx_queue(dev, 0);
> +	else
> +		capped = netdev_cap_txqueue(dev, queue);

[Severity: Medium]

On a TCQ_F_ONETXQUEUE qdisc, this branch rewrites the mapping of every skb,
not just the out-of-range ones. Is that intended for in-range mappings that
a classifier sets on purpose?

The rewrite happens in several places. dequeue_skb() applies it to the head
skb and to gso_skb. try_bulk_dequeue_skb() applies it to each follower.
__skb_dequeue_bad_txq() applies it to skbs taken from skb_bad_txq.

Here is one way to hit it. Take a per-queue child of mq, mqprio, taprio or
htb offload whose q->dev_queue is txq i. A filter on that child can run
"action skbedit queue_mapping j" with j != i and j < real_num_tx_queues.
tcf_skbedit_act() accepts that value:

net/sched/act_skbedit.c:tcf_skbedit_act() {
    ...
	if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
	    skb->dev->real_num_tx_queues > params->queue_mapping) {
		if (skb_at_tc_egress(skb))
			netdev_xmit_skip_txqueue(true);
		skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb));
	}
    ...
}

A tc BPF store of an in-range value behaves the same way.

Before this patch, qdisc_restart() sent the packet on
skb_get_tx_queue(dev, skb), which is queue j. With this patch,
dequeue_skb()->qdisc_cap_skb_tx_queue() first rewrites j back to i. The
packet then goes out on queue i, and nothing is logged.

The commit message says:

    netdev_cap_txqueue() already logs a ratelimited notice and selects
    queue 0.

The TCQ_F_ONETXQUEUE branch never calls netdev_cap_txqueue(), though. That
also covers the 1-queue reproducer in the commit message, because
qdisc_create() sets the flag on every non-multiqueue device:

net/sched/sch_api.c:qdisc_create() {
    ...
		if (!netif_is_multiqueue(dev))
			sch->flags |= TCQ_F_ONETXQUEUE;
    ...
}

So in that reproducer, a store of 1 from the filter on the prio root is
quietly pinned to 0, with no notice.

The only place that says in-range mappings from a filter on a per-queue
child are now overridden is the v4 -> v5 note below the "---". git am drops
that part, and the patch is tagged for stable.

Documentation/networking/tc-queue-filters.rst also still says:

    2) TC filter directs traffic to a transmit queue with the action
       skbedit queue_mapping $tx_qid.

It does not limit where the filter can be attached.

Could the commit message describe the pinning of in-range mappings, and the
missing log message on the TCQ_F_ONETXQUEUE path? Should the documentation
be updated to match?

> +
> +	if (unlikely(capped != queue))
> +		skb_set_queue_mapping(skb, capped);
> +
> +	return capped;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v5.r0.20261026053226-1%40mojatatu.com
