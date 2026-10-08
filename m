Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56035AC14;
	Thu,  8 Oct 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481395; cv=none; b=ITGngYqMSz2BtDXwt8fndwIz5YwnUEkAEA/xoCtnm1skU74O0jr7zLHDaHlKrFSBce8KDNSMJ4nt6LZIe9FKtuof3OooDuyR8HyeVrmpIwCSa0jeS5yDcjNjskEwWSwFlKu9kXakUXsOkBIXPl3Uw013Zw9xHZh+XFID15QDWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481395; c=relaxed/simple;
	bh=MRj5impy8Vk+DD/bJOaCp+DyPU0X9DS6HIW/LsQ3w1U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtSwSyfQAxtp80VHPEV02CK/w/9/9XCoYK8DxNe4DcJhuQ0RrAN7WT3P5oRcKqo0482MwIBdssg+QeFPIjx5mFinKxUsqyc16OhDWh1u6S6Xw7p04PpRf9GIBIWYZICul+Dh7K5MP+GxRTgZaMauVaLc2jfA+2kXAXbbiO39rLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/8qWxts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/8qWxts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A31F000FF;
	Thu,  8 Oct 2026 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481393;
	bh=Z51g25J98X4St1q37rgoWLX+8hpZLjRIkwHxaqzOoOs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D/8qWxts5ImJVwf8wwG+W3orcwud+IH9j0Uox2fS4p9Ip/890VZmk0ecu4gRc0ZwM
	 1TLglxSzlwQcfx0maYRe9bC7nWs+l86/qFaMpv/jzJBLWgO1m1necmTYrHIQt1JPLt
	 /10rtrS+2QrZg8glO+VyQ0whDEjQU5LqPRtRTBNJndhgpComqpzUeLx7eiV+aKxKCP
	 N0FBVB2SSXysBthcK4DwOJdoGoot4bcEG77fsYvwYk9HvInrIVv998Tqf5y7iGOtDJ
	 mpu45P3JaobsVlLfC/Acyp84bPHuaE022iZjG3zJHvCClCOqhvZQJNFN5s2inyCiHB
	 EvIM7QRgt01cw==
Subject: Re: [PATCH net] net/sched: clamp skb->queue_mapping before indexing
 the tx queue
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hawk@kernel.org, daniel@iogearbox.net,
 sashiko-bot@kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 08 Oct 2026 17:43:12 +0000
Message-ID: <179148139264.434549.11911268397957695516@kernel.org>
In-Reply-To: <QDISC-MD1X.v1.20261005193231@mojatatu.com>
References: <QDISC-MD1X.v1.20261005193231@mojatatu.com>
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

- [High] The patch fixes the out-of-range index, but on the
  TCQ_F_ONETXQUEUE fast bulk path a packet whose queue_mapping does not…

--

net/sched: clamp skb->queue_mapping before indexing the tx queue

A tc BPF program running inside an egress qdisc can store an out-of-range
skb->queue_mapping after netdev_core_pick_tx() has already capped it. This
patch adds the cap on the qdisc dequeue side. dequeue_skb() caps the head
skb and the bulk helpers cap each skb they append. The capped value is
written back to the skb, and an out-of-range mapping becomes 0.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0d..e3e76e794aae2 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
>  
>  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
>  
> +/* A tc BPF program attached to a transmit qdisc runs inside q->enqueue(),
> + * after the tx queue has been picked and capped, so its store to
> + * __sk_buff->queue_mapping is not re-capped. Bound it against the device at
> + * the consumer and write the capped value back, so a driver that re-reads
> + * skb_get_queue_mapping() in ndo_start_xmit() also indexes in range.
> + */

[ ... ]

> @@ -208,6 +232,7 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>  				 int *packets, int budget)
>  {
>  	int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
> +	struct net_device *dev = qdisc_dev(q);
>  	int cnt = 0;
>  
>  	while (bytelimit > 0) {
> @@ -216,6 +241,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>  		if (!nskb)
>  			break;
>  
> +		/* A tc BPF store may have poisoned the mapping after pick;
> +		 * cap every element before it reaches the driver.
> +		 */
> +		qdisc_cap_skb_tx_queue(dev, nskb);
>  		bytelimit -= nskb->len; /* covers GSO len */
>  		skb->next = nskb;
>  		skb = nskb;

[Severity: High]
Can a follower whose queue_mapping differs from the head's still reach the
driver under the wrong tx queue lock here?

The return value of qdisc_cap_skb_tx_queue() is ignored, and nskb is
appended no matter what. try_bulk_dequeue_skb_slow() compares each
follower with the head and diverts mismatches:

    if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=
                 skb_get_queue_mapping(skb))) {
        qdisc_enqueue_skb_bad_txq(q, nskb);
        break;
    }

This fast path has no such check. It is the path taken on BQL devices by
TCQ_F_ONETXQUEUE qdiscs. That includes the per-queue children of mq,
mqprio, taprio and htb offload, which get the flag in mq_init_common()
and mq_graft().

The whole list is then sent under the head's txq only:

qdisc_restart()
    txq = skb_get_tx_queue(dev, skb);
  sch_direct_xmit()
    HARD_TX_LOCK(dev, txq, smp_processor_id());
    dev_hard_start_xmit(skb, dev, txq, &ret);

Capping to 0 can create a mismatch in two ways:

  - In an mq child bound to txq N, a tc BPF program sets a follower's
    mapping out of range. The follower is rewritten to 0, but it is still
    sent under txq N's lock.

  - A poisoned head is capped to 0 in dequeue_skb(). The whole list then
    goes out under txq 0's lock, while unpoisoned followers keep mapping
    N.

Drivers that pick their ring from the skb mapping would then touch
another queue's ring and BQL state without holding that queue's
_xmit_lock. virtio_net start_xmit() is one example:

    int qnum = skb_get_queue_mapping(skb);
    struct send_queue *sq = &vi->sq[qnum];

igb is another. igb_tx_queue_mapping() picks the ring, and
netdev_tx_sent_queue(txring_txq(tx_ring)) updates BQL.

Meanwhile another CPU can legitimately hold the right lock: the mq child
that owns that txq, PACKET_QDISC_BYPASS, or netpoll. Could that race on
the descriptor ring and the dql counters? It would also let packets
bypass a stopped txq 0.

igb also changes behaviour in one case. Take a 2-ring device and a
follower stored as 3 inside mq child 1. igb's modulo used to map it to
ring 1, which matched the held lock. With this patch it goes to ring 0
while txq 1's lock is held.

There is also a possible stall. dequeue_skb() still runs the ONETXQUEUE
frozen pre-check and computes the bulk byte limit against q->dev_queue
(txq N). A capped head that is requeued into child N's gso_skb now
depends on txq 0 instead. When txq 0 wakes, netif_tx_wake_queue()
reschedules txq 0's qdisc, not child N. Could child N stall until
something else is enqueued to it?

The new comment says a driver that re-reads skb_get_queue_mapping()
"also indexes in range". Staying in range doesn't look sufficient,
because per-queue driver state is protected by the matching txq lock.

ifb is not affected by this fast path. It doesn't use BQL, so
qdisc_avail_bulklimit() returns 0 and no followers are appended. The
drivers exposed are BQL multi-queue ones such as virtio_net, igb and
ixgbe.

Would it work to compare each follower's capped mapping with the head's
here, and push mismatches to skb_bad_txq the way the slow path does?
Another option for ONETXQUEUE qdiscs would be to cap to the index of
q->dev_queue instead of 0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
