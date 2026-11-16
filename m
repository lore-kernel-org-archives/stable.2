Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848861;
	b=RQrIn5OfCELf6pcejpW4L+rGMKsjrCG257QJiYK8Suh94n3+HVe+yDVWQuL52ZemTv6T
	 FAqH8e9urKwmaTU9zk56ljtqChKLsmIWFPUgqCm71jvlQRNXKFVYsBbyHwkGi+xTARIUQ
	 eXq3V0mRIyRXj8iQ2aA2E8z04BWLxbLDrtETqph+SP53vAqGcQV4WcTqFc5Kt7MxUh9fw
	 sKUDAstMNSPOTB5W0+4NhQN/S9A3GvmJqfE75Tq2HnzMAzXqnxS3S+SQyyai4RDHZtCwc
	 TnB/4UCR3D4kksccG30trrdvBdgfw7a0nyqWBhu4L3fWdlZ/07uMl1DWeN84ngLdJkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848861;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LrPchhpZJR/1gFY94P7uZJUteTqsj+C1U2e/SDMmL2Y=;
	b=GJyHUWCaZ92Fygw4hVp5kYkJlD1EnEHVBs1v2nIy1p7ZomoFVFYJ3OuY07YIjpNg5QVa
	 0Yj6g8eVVqV2k+OgInR+zOsDsUOMXSw8lGoHOAig1OFQ6hMgUGkxpE5FZRjUAjIcKvubp
	 CBun9+0wdV+dgh5P0QgDJkUVrbjnp+8X/cgr5eE5dfxia37dZaYRNps+7sm7IqVwFG3ss
	 s8CPZw2vbCy+b5yAczTKLelWXhpfWLcgqg8eIHZRXZYe45A2mP+w8ALOzDhGd44ZlmynU
	 PkPwCE1GtWT1BYwGV7oAo8YuTY8kMMBJb8eZ0pC7Ri3tMORv+5W4xnkjAeZEO8Ko13A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F9/rn9YY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA9606A32C;
	Mon, 16 Nov 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9/rn9YY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4601F000C4;
	Mon, 16 Nov 2026 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848861;
	bh=LrPchhpZJR/1gFY94P7uZJUteTqsj+C1U2e/SDMmL2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F9/rn9YYCWS44yZBatgT3UQFikp0tYuQXvgprTbgrD4W0JVVRwe/rtA0sv9F011Bp
	 jbNt2VqDEZWWE/+O2b7V9ZUn97KBKyUnthok+rtC0gw9/3VxxnHA2hNn0D8C0ytCLG
	 XKVASn0VhoxmWIPBCn0+Dq60Obf9tZPemX3mWufj2WOqKkjWkTX47Zv5tM94ww2erm
	 uRAIuKAnqwDZbFC/LGj8AIlmdw5/VEWp0ZhFZCOS7pEFJ6GPkkX9+4khFOwxNRst6Y
	 l2inPP7JbrcjNUSQdPR40aRfQFh0c/hFyeQ6InEeF48fWRl8fOPHGomc0xsz6p6q4g
	 t+JWiyWIXcM7g==
Subject:
 Re: [PATCH net v3] net/sched: sch_qfq: revalidate aggregate after peek
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 16 Nov 2026 17:07:40 +0000
Message-ID: <179484886054.3136.13514425685595573517@kernel.org>
In-Reply-To: <20261112164954.2786444-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112164954.2786444-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In qfq_dequeue() (net/sched/sch_qfq.c), `q->deferred_enqueues`
  is one pointer per qdisc.
- [High] The new replay loop in qfq_dequeue()
  (net/sched/sch_qfq.c:1200-1202) calls `qdisc_enqueue(next, sch, ...)`.
- [High] net/sched: sch_qfq: premature qdisc_qlen_dec() triggers false
  qlen_notify
- [Medium] qfq_dequeue() calls qdisc_root_sleeping(sch) twice without
  holding rcu_read_lock(): once at line 1171 to set TCQ_F_DEQUEUE_DROPS,…
- [Medium] qfq_dequeue() now does a plain read-modify-write of the root
  qdisc's flags word on every dequeue: `qdisc_root_sleeping(sch)->flags…
- [Medium] On every packet it dequeues, qfq_dequeue() sets
  TCQ_F_DEQUEUE_DROPS on the root qdisc, which may be a different qdisc…
- [Low] The commit message says only "A QFQ child callback can re-enter
  qfq_enqueue() during a peek or dequeue".

--

net/sched: sch_qfq: revalidate aggregate after peek

This patch makes qfq_dequeue() restart when the in-service aggregate
changes during a child peek. It also defers enqueues that re-enter
qfq_enqueue() while agg_dequeue() runs, and replays them after service
accounting. Finally, qfq_enqueue() now rechecks class activity and uses
cl->agg after peeking the child.

> A QFQ child callback can re-enter qfq_enqueue() during a peek or
> dequeue.

[Severity: Low]
This isn't a bug, but could the commit message name the trigger?

As far as I can tell, the path is:

  netem_dequeue()
    qdisc_enqueue(skb, q->qdisc, &to_free)
      netem_enqueue()           <- duplicating child netem
        rootq->enqueue(skb2, rootq, to_free)
          qfq_enqueue()
            qfq_change_agg() -> ... -> qfq_destroy_agg()

The goto tfifo_dequeue loop in netem_dequeue() can also cause several
nested enqueues from a single peek.

The v2 changelog says "Clarify the trigger". The body still doesn't name
a qdisc or a configuration.

> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index e900890e9c544..d867d3b918def 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c

[ ... ]

> @@ -1151,17 +1160,23 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  		 */
>  		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
>  		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
> +		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
> +			goto restart;
>  	}
>  	if (!skb)
>  		return NULL;
>  
>  	qdisc_qlen_dec(sch);
>  
> +	qdisc_root_sleeping(sch)->flags |= TCQ_F_DEQUEUE_DROPS;

[Severity: Medium]
Is it safe to call qdisc_root_sleeping() here without rcu_read_lock()?

qdisc_root_sleeping() is:

	return rcu_dereference_rtnl(qdisc->dev_queue->qdisc_sleeping);

On the transmit path only rcu_read_lock_bh() is held, and RTNL is not:

  __dev_queue_xmit()
    __dev_xmit_skb()
      qdisc_run()
        dequeue_skb()
          qfq_dequeue()

With CONFIG_PROVE_RCU, can this trigger a "suspicious
rcu_dereference_check() usage" splat on every dequeue? The
qdisc_root_sleeping() call in the replay loop below has the same
problem.

qdisc_dequeue_drop() uses the same root->to_free mechanism, and it
wraps the call:

	rcu_read_lock();
	root = qdisc_root_sleeping(q);

[Severity: Medium]
Can this plain read-modify-write of the root qdisc's flags race with
qdisc_offload_dump_helper()?

This line runs under the root qdisc lock. qdisc_offload_dump_helper()
changes the same word while holding only RTNL:

	sch->flags &= ~TCQ_F_OFFLOADED;
	...
	if (!err)
		sch->flags |= TCQ_F_OFFLOADED;

It runs on every tc qdisc show, through tc_fill_qdisc() -> tbf_dump()
-> tbf_offload_dump(). prio, red, ets, gred, fifo and mq reach it the
same way.

Take a tree like TBF -> QFQ, where tbf_dequeue() peeks the child and
runs qfq_dequeue(). A stale write-back from the dump can clear
TCQ_F_DEQUEUE_DROPS, and then qdisc_run_end() does not collect
root->to_free:

	if (qdisc->flags & TCQ_F_DEQUEUE_DROPS) {
		to_free = qdisc->to_free;
		...

Would the replay drops then stay on root->to_free, and leak if the root
is destroyed first?

The race can go the other way too. The QFQ write can undo a
TCQ_F_OFFLOADED update, so TCA_HW_OFFLOAD would be reported wrongly in
dumps.

Before this patch, the data path did not write another qdisc's flags.

[Severity: Medium]
This sets TCQ_F_DEQUEUE_DROPS on the root qdisc on every dequeued
packet, and nothing clears it. The root may be a different qdisc type.

Until now, a qdisc set this flag on itself at init (codel, fq_codel,
cake and dualpi2). That matches the flag's description, "->dequeue()
can drop packets in q->to_free".

Say QFQ sets the flag on an HTB root. Every codel, fq_codel, cake or
dualpi2 under that root then switches qdisc_dequeue_drop() from
kfree_skb_reason() to deferring drops onto root->to_free. qdisc_run_end()
also starts returning root->to_free. Both stay that way after the QFQ
qdisc is deleted.

The unconditional |= also writes to the root qdisc's first cache line on
every packet, and other CPUs read that line in __dev_xmit_skb().

The commit message only says "Keep replay drops on the same root".
Should it describe this cross-qdisc change? Should it also mention the
dependency on the TCQ_F_DEQUEUE_DROPS and qdisc_run_end() to_free code,
given the requested stable backport?

> +	__skb_queue_head_init(&deferred_enqueues);
> +	q->deferred_enqueues = &deferred_enqueues;
>  	skb = agg_dequeue(in_serv_agg, cl, len);
> +	q->deferred_enqueues = NULL;

[Severity: High]
Can a nested qfq_dequeue() on the same qdisc clear this pointer while
the outer call is still inside agg_dequeue()?

q->deferred_enqueues is a single pointer per qdisc. It is set, then
cleared to NULL, with no save and restore. Consider a tree where QFQ Q
is a child of another QFQ R:

  R (qfq) -> class X -> Q (qfq) -> class Y -> netem A -> netem B (duplicate)

The sequence could be:

  qfq_dequeue(R) peeks X
    qdisc_peek_dequeued(Q)
      qfq_dequeue(Q)                       <- D1, sets Q->deferred_enqueues
        agg_dequeue()
          qdisc_peek_len(A)
            netem_dequeue(A)
              netem_enqueue(B)
                rootq->enqueue(skb2, rootq, to_free)
                  qfq_enqueue(R)
                    qdisc_enqueue(skb2, Q) <- deferred, NET_XMIT_SUCCESS
                    cl->qdisc->ops->peek(Q) <- X is still active
                      qdisc_peek_dequeued(Q)
                        qfq_dequeue(Q)     <- D2

Q->gso_skb is still empty because D1 has not returned, so the peek runs
a full qfq_dequeue(Q). On its way out, D2 sets Q->deferred_enqueues to
NULL. It then replays its own list through the normal qfq_enqueue()
path, while D1 is still inside agg_dequeue().

>From then on, re-entrant enqueues during D1's agg_dequeue() are no
longer deferred. That covers D2's replay and later passes of the
tfifo_dequeue loop in netem_dequeue(A). On that path, this chain can
free the in_serv_agg that D1 still holds:

  qfq_enqueue()
    qfq_change_agg()
      qfq_deact_rm_from_agg()
        qfq_destroy_agg()
          kfree(agg)

agg_dequeue() then continues with:

	else if (cl->deficit < qdisc_peek_len(cl->qdisc)) {
		cl->deficit += agg->lmax;
		list_move_tail(&cl->alist, &agg->active);
	}

After that, qfq_dequeue() updates in_serv_agg->budget and reads
in_serv_agg->F.

Doesn't this leave reachable the same use-after-free and active list
corruption that the commit is meant to fix? Is a save and restore of
the previous pointer needed here? Another option would be to avoid
peeking a child that is in the middle of its own dequeue.

>  
>  	if (!skb) {
>  		qdisc_qlen_inc(sch);
> -		return NULL;
> +		goto replay_deferred;
>  	}

[ ... ]

> @@ -1181,6 +1196,11 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  		 len, (unsigned long long) in_serv_agg->F,
>  		 (unsigned long long) q->V);
>  
> +replay_deferred:
> +	while ((next = __skb_dequeue(&deferred_enqueues)) != NULL)
> +		if (qdisc_enqueue(next, sch, &qdisc_root_sleeping(sch)->to_free))
> +			qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(next));

[Severity: High]
Can the replay loop send a false qlen_notify to the parent qdisc?

qdisc_qlen_dec(sch) runs before agg_dequeue(). The deferral in
qfq_enqueue() returns NET_XMIT_SUCCESS without touching sch->q.qlen.
The ancestors above sch have already counted each deferred skb, but
sch has not. So while the replay loop runs, sch->q.qlen counts neither
the skb about to be returned nor the deferred skbs still on the list.

When a parent peeks a QFQ child, qdisc_peek_dequeued() calls
qfq_dequeue(). It stores the result in sch->gso_skb and calls
qdisc_qlen_inc() only after qfq_dequeue() returns. DRR, ETS, HFSC and
QFQ all peek their children this way.

Say sch holds one packet and a deferred skb fails to enqueue during
the replay. qdisc_tree_reduce_backlog() then computes
notify = !sch->q.qlen, which is true, and calls cops->qlen_notify() on
the parent. The parent deactivates sch's class. Yet qfq_dequeue() still
returns an skb, which ends up in sch->gso_skb with q.qlen == 1.

The same happens with two deferred skbs where the first fails and the
second succeeds. This case applies even when the parent dequeues sch
directly, as HTB does. The parent is told sch is empty, and then the
second replay puts a packet in sch without reactivating the class.

In both cases the parent's class stays inactive while sch holds a
packet. It is not served until a later enqueue reactivates it.

With an outer QFQ, the first case runs inside the outer agg_dequeue(),
through qdisc_peek_len(cl->qdisc):

	else if (cl->deficit < qdisc_peek_len(cl->qdisc)) {
		cl->deficit += agg->lmax;
		list_move_tail(&cl->alist, &agg->active);
	}

By this point qfq_qlen_notify() has already taken cl off agg->active.
If cl was the only active class, qfq_deactivate_agg() has also run.
Since agg is the outer in-service aggregate, it picked a new one.

list_move_tail() then puts cl back on agg->active, but agg is now
neither in service nor in any slot. Wouldn't later enqueues to that
aggregate see a non-empty active list and skip qfq_activate_agg()?
That would stall the aggregate for good. The outer qfq_dequeue() also
goes on to charge len to its stale in_serv_agg.

The early qdisc_qlen_dec() is not new. But this patch adds a new
caller of qdisc_tree_reduce_backlog() in that window, along with skbs
that sch has not counted yet. Could the deferred skbs be counted in
sch->q.qlen when they are queued? Or could the decrement move after
the replay? Or is there another way to keep sch->q.qlen in step with
its ancestors whenever the tree is walked?

[Severity: High]
Can qdisc_pkt_len(next) read next after it has been freed?

qfq_enqueue() passes the child's error back unchanged. Not every child
puts a dropped skb on to_free. Take a TBF child and a GSO skb larger
than max_size:

  qfq_dequeue()                 <- replay loop
    qfq_enqueue()
      qdisc_enqueue(skb, cl->qdisc, to_free)
        tbf_enqueue()
          tbf_segment()

If no segment could be enqueued, tbf_segment() ends with:

	kfree_skb(skb);
	return NET_XMIT_DROP;

The deferred skb here is a netem duplicate made with skb_clone(), so it
can be a GSO skb.

In that case qdisc_pkt_len(next) reads the cb of a freed skb. The
resulting garbage length is subtracted from every ancestor's
qstats.backlog.

Would it be safer to save qdisc_pkt_len(next) before calling
qdisc_enqueue(), the way netem_dequeue() does?

>  
>  	return skb;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112164954.2786444-2-Jeremy.Jean%40oss.cyber.gouv.fr
