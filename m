Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445385;
	b=Jm0CV2GRTDUPsltvuz92uaMnSYOKw6+Nz6tmsa2bAG2SEpKTAyq4T1cilvSXo2t2hgnM
	 vSw8KhoCajj+qmxzZgLp/yD/larlF+REPj2bbO0BDJKj76QZvRU+Sc45lD/GF2j855yXy
	 ykJxX/wEG/2X+VlCio3xh50Kpe6/Qv4p/klh5c0lq68YcFbmOmzmtXwbpkCQRX0cWiYFb
	 w1BpqZEgEeY4dDtnvvVf3UvlE6K4FN96JRO7Wwms9Nz4YLngSPksC9vTVHY0pFDvjufwc
	 ZI0cZ728rrMxeViflVgUNVuBrdiMc8UyxTcqs+jkIIa+evPRW9uDB4nK7qA2ddBtAww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445385;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=322oHPhgc7zYpt8HncL/bytYWXSRCTI0Z6cOYScqDVw=;
	b=Xa1eThmlJA9FiYD9UcSPqOsZq8F1fygRnSBrlm+sqKI5B9/HweXoFfnVIPTA+oUl58qx
	 fdMA2EZVyE/oxgLZi3m+fwze78ZBfKhNyIK5Rms+uNVnrax7YRQjuvALHK3sO6F/BXl5c
	 cN1e7P5gcKkdZYMBr/9TwjXSRdiXSCIpPdzUvO/OF1IYUh2EsOVGJg0zblS2oc6iwekgg
	 2OQbHMAELwR2UeXC9zC5fzRA2snta5NDfOApOWQvR2fZBrOIYzvYRBBhgbeOndRyLspe4
	 KDT+OSyZ2gEIqne6G4MpdhjPi/X+wN6K37ZwrlasQDlyT9VXbILt31XKQWZsJkRC1tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQgPMAPy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5281606A319;
	Mon, 19 Oct 2026 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQgPMAPy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC141F000C5;
	Mon, 19 Oct 2026 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445384;
	bh=322oHPhgc7zYpt8HncL/bytYWXSRCTI0Z6cOYScqDVw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NQgPMAPyeQWYtXFB4MdL4Oi/ipd0pEabdDUucJyNVBeywyWSjVzakt6CTmlW6/3Wn
	 6S9gGSexQ4e/UrnA+JC1oJgp/aC28k52CCh17aCK6blZT2bm4T0upadOyx72YHu6rP
	 DZgQqsJqRq1tB+ektO2C/lC0dJXBRyMZxMyKKQwtOMRsQfR7WlWvqOfL1b/XlgXB4o
	 OHeINQvmLIa/UeP17HZA0B2+73CdEOlBeatmtS9dlc84nbjlIK7ljYLLeOZrnwNUcA
	 n999UaSrJKZ4shuK/NhwzeR3zWvqrgnVd4HcCWwUrgGFVKMCcyp8ukIMBcBkkljiPP
	 jl5YbFKpeG7Ig==
Subject: Re: [PATCH net v3] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hawk@kernel.org, daniel@iogearbox.net,
 sashiko-bot@kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 19 Oct 2026 21:29:43 +0000
Message-ID: <179244538310.3135.3763209372390556732@kernel.org>
In-Reply-To: <QDISC-MD1X.v3.r0.20261015165943-1@mojatatu.com>
References: <QDISC-MD1X.v3.r0.20261015165943-1@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net/sched/sch_generic.c, try_bulk_dequeue_skb(): the patch
  adds a new requeue of a mismatched follower to q->skb_bad_txq in the…
- [Medium] net/sched/sch_generic.c, qdisc_cap_skb_tx_queue(): an out-of-
  range queue_mapping is sent to device queue 0 through…

--

net/sched: clamp skb->queue_mapping before indexing the tx queue

A tc BPF program on an egress qdisc can store an out-of-range value in
skb->queue_mapping after netdev_core_pick_tx() has already picked the
queue. This patch caps that value against real_num_tx_queues on the qdisc
dequeue side. The head is capped in dequeue_skb(), and both bulk helpers
cap each follower and requeue it to skb_bad_txq if it no longer matches
the head.

Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0d..6b548099b55d8 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -96,9 +96,31 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
>  
>  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
>  
> +/* A tc BPF program on a transmit qdisc can change __sk_buff->queue_mapping
> + * after the tx queue was picked. Re-cap it against the device and write it
> + * back, so a driver that re-reads skb_get_queue_mapping() stays in range.
> + */
> +static u16 qdisc_cap_skb_tx_queue(struct net_device *dev, struct sk_buff *skb)
> +{
> +	u16 queue = skb_get_queue_mapping(skb);
> +	u16 capped;
> +
> +	capped = netdev_cap_txqueue(dev, queue);
> +	if (unlikely(capped != queue))
> +		skb_set_queue_mapping(skb, capped);
> +
> +	return capped;
> +}

[Severity: Medium]

Does sending an out-of-range mapping to queue 0 here break the assumption
documented for TCQ_F_ONETXQUEUE per-queue children (mq, mqprio, taprio,
htb offload)?

include/net/sch_generic.h:
#define TCQ_F_ONETXQUEUE	0x10 /* dequeue_skb() can assume all skbs are for
				      * q->dev_queue : It can test
				      * netif_xmit_frozen_or_stopped() before
				      * dequeueing next packet.
				      * Its true for MQ/MQPRIO slaves, or non
				      * multiqueue device.

Say a filter on the child attached to txq i (i != 0) stores a
queue_mapping >= real_num_tx_queues. The head is then rewritten to 0
here.

dequeue_skb() still uses q->dev_queue in three places: the ONETXQUEUE
frozen check, the BQL limit passed to try_bulk_dequeue_skb(), and
trace_qdisc_dequeue(). qdisc_restart(), though, transmits on
skb_get_tx_queue(dev, skb), which is txq 0.

If txq 0 is stopped at that point, sch_direct_xmit()->dev_requeue_skb()
puts the list on q->gso_skb. The gso_skb path in dequeue_skb() then
returns NULL for as long as txq 0 is frozen. When txq 0 wakes:

net/core/dev.c:netif_tx_wake_queue() {
    ...
	q = rcu_dereference(dev_queue->qdisc);
	__netif_schedule(q);
    ...
}

this schedules child 0, not q. Can q then stay idle until another packet
is enqueued to it?

Capping to 0 is consistent in netdev_core_pick_tx(), because the qdisc
is then taken from txq 0. Here the qdisc has already been chosen.

For ONETXQUEUE qdiscs, would capping to q->dev_queue's index keep the
documented invariant and avoid this?

> +
> +static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
> +					     struct sk_buff *skb)
> +{
> +	return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb));
> +}
> +

[ ... ]

> @@ -208,6 +231,7 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>  				 int *packets, int budget)
>  {
>  	int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
> +	struct net_device *dev = qdisc_dev(q);
>  	int cnt = 0;
>  
>  	while (bytelimit > 0) {
> @@ -216,6 +240,15 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>  		if (!nskb)
>  			break;
>  
> +		/* Re-cap a mapping changed after pick; requeue a
> +		 * follower that no longer matches the head, which owns
> +		 * the _xmit_lock for the whole list.
> +		 */
> +		if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=
> +			     skb_get_queue_mapping(skb))) {
> +			qdisc_enqueue_skb_bad_txq(q, nskb);
> +			break;
> +		}

[Severity: Medium]

Can this stall a per-queue child qdisc of mq, mqprio, taprio offload or
htb offload on a multiqueue BQL device?

A follower can fail to match the head here in two ways. A filter on the
child (BPF, or act_skbedit queue_mapping) can set a valid queue X that
differs from the head's queue Y. Or an out-of-range value can be capped
to 0 by qdisc_cap_skb_tx_queue() while the head maps to another queue.

In both cases the follower is parked on q->skb_bad_txq, and nothing
reschedules q or sets the MISSED bit. On the next dequeue_skb(), the
ONETXQUEUE check only looks at q->dev_queue (Y), which is running. If X
is stopped:

dequeue_skb()
  qdisc_dequeue_skb_bad_txq()
    __skb_dequeue_bad_txq()
      txq = skb_cap_tx_queue(qdisc_dev(q), skb);   /* X, stopped */
      skb = SKB_XOFF_MAGIC;
      qdisc_maybe_clear_missed(q, txq);
  if (skb == SKB_XOFF_MAGIC)
      return NULL;

So q->dequeue() is never called. All of q's backlog then waits behind
the parked skb, including traffic for q's own running txq Y.

When X wakes, netif_tx_wake_queue() schedules rcu_dereference(X->qdisc).
mq_attach() grafted X's own child there, not q, and Y never stopped.

Does anything reschedule q before a new packet is enqueued to it?

The commit message says the fast helper must requeue a mismatch:

    exactly as the slow helper already does

The slow helper only runs for non-ONETXQUEUE root qdiscs. There every
txq->qdisc is q, so a wake on any queue reschedules q.

Does that reasoning carry over to per-queue children, where a wake on X
cannot reach the child attached to Y?

>  		bytelimit -= nskb->len; /* covers GSO len */
>  		skb->next = nskb;
>  		skb = nskb;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
