Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792931241;
	b=FQqpWIZ7NzYIeFpP2NB7jUren1eYHOOzjKcF84wqI0bbqXnzo6yXXXrXzz7/c+rmZr5x
	 dHZxxuOvatAG7KrZnfyQOBBaPDlVEZWC3R4Oog+bRpQXRt7HPSdtM7oqarismMl5aqppf
	 4LviSCPi1Vf9st/1baJSinuvEpyXvjQyMQ8G4soaCardbdns17gcLijnQ+gbddSChCIb8
	 OS83MS+eFITMX6ORZmoP831iCH7Wi0ObjQN8ZcmacbflBxw3EHGGwOoQ1HFt/MIJ5ImJM
	 Oqi3WenknXa0sXg1n9RW0qSyQChDXysycM5FcgoKzEC/a/Hg8bJQAtTfQQMlw2twjwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931241;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HaTBAqVWN8l8NtR7a+7TI1wWGP43M5MdEGvYDuOrNEM=;
	b=I9YJi6sR4XrcmBALQIvnen4t628dHYvoC511kz8AoIkGvSqsbV06loQV5CQ5hWhxVF8a
	 8suLollAeh/o61r5LerBfLNOpBiXToF+61symj1oVNvuepduf+f7juRoPD2r3WRAcZL/m
	 WZipQNBZ0AgFh2ZWcMrEZeK41YOdfVmVaUOf37uIa+efSN7qyJYXJQ8Xk2BbhQliHExn9
	 2d8/EAbGy4YhI99znHAVfZg+GNlAF/POpiv/fdYK+b9s0waifcdGbr8MUMTrxy4GP08YS
	 MWxcsjfNdgCSPlKv2x1fCY3TrjhBTQ0b9xlYueHEYtg+irb2su48lNXISt6yVTzNbHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSfRzNkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20686606A31A;
	Sun, 25 Oct 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSfRzNkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F7D1F01825;
	Sun, 25 Oct 2026 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792931240;
	bh=HaTBAqVWN8l8NtR7a+7TI1wWGP43M5MdEGvYDuOrNEM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RSfRzNkS5OrYf0rLyP1zaSUtfu/gFWTbT/0lMEwe1VYf2BhKJRdNLA5olY49WdKaK
	 sBz9VPxODFMuevQ9+Ao+S/Cb2oVrE1UwnssGu9JUAAQyoJ017NnzqUyLDoPeligL1y
	 DejPsCJNHfDMNHLmeFRoZMJYzvyBWqw1EqS77tsnS/r0MJ6FGGTz3yMWvb9BhezC0I
	 hg44SVxZO8r14F1A0N5MAu32/pxf6oYBdUp0F3ZZJgLqJ2YoTn0dlJIurmOrNGZTqw
	 tNk7KfjRq6Ji0B7tg/0p2xefJGM8b1+6g+Oa1OMplQTvumZwtf8tPn2j+/1MRSglIN
	 tkyiqAjDTWdHw==
Subject: Re: [PATCH net v4] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hawk@kernel.org, daniel@iogearbox.net,
 sashiko-bot@kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 25 Oct 2026 12:27:19 +0000
Message-ID: <179293123940.3134.1149128679923234677@kernel.org>
In-Reply-To: <QDISC-MD1X.v4.r0.20261021042722-1@mojatatu.com>
References: <QDISC-MD1X.v4.r0.20261021042722-1@mojatatu.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the patch re-caps a queue_mapping stored by tc
  BPF only at dequeue time, in dequeue_skb(), __skb_dequeue_bad_txq()…
- [Low] For TCQ_F_ONETXQUEUE qdiscs, qdisc_cap_skb_tx_queue() overwrites
  every skb's queue_mapping with q->dev_queue's index, including valid…

--

net/sched: clamp skb->queue_mapping before indexing the tx queue

This patch re-caps skb->queue_mapping in the qdisc dequeue path
(dequeue_skb(), __skb_dequeue_bad_txq() and the bulk helpers). The goal is
to stop a tc BPF store made after netdev_core_pick_tx() from indexing past
dev->_tx[]. For TCQ_F_ONETXQUEUE qdiscs the mapping is pinned to
q->dev_queue; for other qdiscs it goes through netdev_cap_txqueue().

Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0d..fdd070840cb55 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -96,9 +96,37 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
>  
>  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
>  
> +/* A tc BPF program may change skb->queue_mapping after the tx queue
> + * was picked, so re-cap it before use. A TCQ_F_ONETXQUEUE qdisc is
> + * bound to a single tx queue, so pin the mapping to q->dev_queue.
> + */
> +static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb)
> +{
> +	u16 queue = skb_get_queue_mapping(skb);
> +	struct net_device *dev = qdisc_dev(q);
> +	u16 capped;
> +
> +	if (q->flags & TCQ_F_ONETXQUEUE)
> +		capped = q->dev_queue - netdev_get_tx_queue(dev, 0);

[Severity: Low]
This isn't a memory safety issue, and the commit message does describe
the pinning. Should the change in steering behaviour still be called out
for stable users?

For TCQ_F_ONETXQUEUE qdiscs, this overwrites every skb's queue_mapping
with the index of q->dev_queue. That includes valid in-range values set
by a filter on a per-queue child, for example in tcf_skbedit_act():

	if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
	    skb->dev->real_num_tx_queues > params->queue_mapping) {

Before this patch, qdisc_restart() used skb_get_tx_queue() and honoured
an in-range mapping on the head skb. Under mq, mqprio, htb offload or
taprio offload children on multiqueue devices, that steering is now
silently replaced with the child's own queue.

The pre-patch try_bulk_dequeue_skb() already sent followers under the
head's tx lock whatever their mapping was. The TCQ_F_ONETXQUEUE comment
in include/net/sch_generic.h also documents the invariant being restored.

However, Documentation/networking/tc-queue-filters.rst describes
"skbedit queue_mapping $tx_qid" without saying where the filter has to
sit. Would a note there help?

> +	else
> +		capped = netdev_cap_txqueue(dev, queue);

[ ... ]

> @@ -322,6 +358,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
>  	skb = q->dequeue(q);
>  	if (skb) {
>  bulk:
> +		/* cap the head; the bulk helpers cap every appended element */
> +		qdisc_cap_skb_tx_queue(q, skb);

[Severity: High]
This caps the mapping at dequeue time. Can the same BPF-stored value
still reach a consumer on the enqueue side that uses it as an array
index?

taprio_enqueue() in net/sched/sch_taprio.c indexes q->qdiscs[], which
has dev->num_tx_queues entries, without a bounds check:

net/sched/sch_taprio.c:taprio_enqueue() {
    ...
	queue = skb_get_queue_mapping(skb);

	child = q->qdiscs[queue];
	if (unlikely(child == &noop_qdisc))
    ...
}

This path looks reachable with software-mode taprio as the root:

  - taprio_attach() installs the taprio root on every tx queue
  - a prio child is grafted onto a taprio class
  - a cls_bpf filter on that prio stores a large
    __sk_buff->queue_mapping (bpf_convert_ctx_access() only rejects
    values >= NO_QUEUE_MAPPING)
  - a duplicating netem sits on one of the prio bands

netem_enqueue() clones the skb, and __copy_skb_header() copies
queue_mapping. It then re-enqueues the clone at the root:

net/sched/sch_netem.c:netem_enqueue() {
    ...
	if (skb2) {
		struct Qdisc *rootq = qdisc_root_bh(sch);

		skb2->tc_depth++; /* prevent duplicating a dup... */
		rootq->enqueue(skb2, rootq, to_free);
    ...
}

netem inherits its dev_queue from prio, and taprio is grafted on every
tx queue, so rootq is the taprio root. That gives:

netem_enqueue()
  taprio_enqueue()
    child = q->qdiscs[queue]   /* out of bounds */
    taprio_enqueue_one()
      qdisc_enqueue()          /* calls child->enqueue */

All of this runs before dequeue_skb(), so the new cap never sees the
clone.

Commit ea4d4b5dddb5 cited this taprio_enqueue() out-of-bounds access. It
left the "tc BPF program attached to a transmit qdisc" store path for a
separate followup.

Does closing that case need a check on the store or enqueue side, or in
taprio_enqueue() itself?

>  		if (qdisc_may_bulk(q))
>  			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
>  		else

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r0.20261021042722-1%40mojatatu.com
