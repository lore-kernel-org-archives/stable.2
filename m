Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093337;
	b=O1A6Su3aag2kZM1zrNBqxhyY6bTz//3Be0yE/S8uxPfr/we2hsZj8XxOn2u8fOR5dd45
	 wSQJLUH7fnaCb/3k//R1mfM4CUJbj5t4Hc92vO+QIeIQxN5T5uNE5YoyA1uaKv8nXpw9b
	 LVF9qfJ1IEiMLDyBavBxs5a47leovfSvZJF2nevXN5Yl4MY10pVUQcrZnK1tXuRzn55yQ
	 7+h26hEMAtvFBs/DGId6Pe+mxkYh+fM4y8Nb4QeLo/3Z1vd0k95JTcYMgEHq2dhXIn1+E
	 hd0rfJtGQ8hegh/h2zIxvihau65tkWdVEwKWhgb3JrxOIBC2nHRXUl9YyQUZDxXoTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093337;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=p8NdlJeb1TRhp00Fu41Y5tkNGTY0mONjNOfygteb5+c=;
	b=TggjYzZBugxZ3igX4Dt1ytCpL9/ZC/OC4XJRloi0UCuCtScKY5kkc7B4ay42rZz/zr5t
	 HCEZzBDlkOCEwMKFpCxAeT1GdphMNhoRNbWzvrNwsDNEGG51nstha6mCq3EI5Vxy/Qn/G
	 2OjTGCUkMLUYwKZAg9N2UVmKu+MbpaCUv+3Fauvcg5giuTFSqDRDg/qJqDZPIkFI7zlBU
	 cpwL2jSZAB8gLhNVnIJtctx37kB8SqXu6MjoMx7Jf8boy7L9+FDNxhIaomkyMzgAfRCu1
	 fhAriW1zxNS8f//pzS5WujdjVGT3Wik6byrx3duTQD0yw4sqI307Eh/peD4YlzPWFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qp/NnmyW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21447606A31B;
	Tue, 27 Oct 2026 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qp/NnmyW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693731F031E7;
	Tue, 27 Oct 2026 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093337;
	bh=p8NdlJeb1TRhp00Fu41Y5tkNGTY0mONjNOfygteb5+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qp/NnmyWnjy7TIppdQNM2xAgatHT4wbLz786wY9DtJeF/QUUDgI1CVJFfhiBvCGjd
	 jYfK9SdhHRhYiN46SFP4dtWsWgKiI6R7IYT0rKLQAHu9NNpGNsD97qmr8vWbL9+DFj
	 ulj1BLsPNWTRZCnXtadOID/fkikxFHo5cdXYy3Cys+K5/ELUOxgrsXWd10u+d0QITn
	 mfA8aBdmXwqYJlACVBYHrZIcoyltSBj4HpxNDUMsGvCOc3XdpO5UvWRcGFMf9opUa1
	 41fCjbakJqK504gwL2xBwE1y/azIUjEH/pTkgw9f6ePLgGqzvbTDZAMOOs0Q3G5QbN
	 UuaX+vDUQ0BXQ==
Message-ID: <2812b71c-cd0c-4d87-a57c-427ef40d078b@kernel.org>
Date: Tue, 27 Oct 2026 10:28:53 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: fix packet reordering on requeue
To: Antonio Quartulli <antonio@mandelbit.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 Chris Arges <carges@cloudflare.com>
References: <20261026153113.3275494-1-antonio@mandelbit.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20261026153113.3275494-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 16:31, Antonio Quartulli wrote:
> dev_requeue_skb() appends requeued skbs to the tail of q->gso_skb, while
> dequeue_skb() takes them back one at a time from the head. If the driver
> returns NETDEV_TX_BUSY again for the first of them, it moves behind the
> skbs still parked there and is sent after them.
> 
> This showed up as heavy TCP reordering while benchmarking over veth,
> which returns NETDEV_TX_BUSY whenever its ring is full since
> commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops").
> 
> Requeue the skbs at the head of gso_skb, keeping their order. With 4 TCP
> streams over a veth pair with a pfifo qdisc, this removes about 1.3M
> out-of-order segments and 15-37k retransmits per 15 seconds, and raises
> throughput from about 40 to 76 Gbit/s.
> 
> Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
> Fixes: 9540d977618c ("net: sched: fix skb leak in dev_requeue_skb()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---

Thanks for finding and fixing this!

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> Notes:
> 
> - Setup: 8-vCPU VM, veth pair; sender with a pfifo qdisc and TSO off,
>    receiver with GRO and threaded NAPI; iperf3, 15 s runs.
> 

For others, notice threaded NAPI an important setup parameter here.
This makes it more likely and reliable for ptr_ring producer and
consumer to run on different CPUs.  This situation can still occur
without threaded NAPI, when multiple localhost userspace applications
run producing packets into veth, as they will likely get be schedules on
different CPUs.

FYI, we also run veth with threaded NAPI in production, but used in a
routing setup (no "localhost" apps).  We have configured veth to have
many queues (64), and we use qdisc MQ on top to avoid serialization on
the qdisc root-lock.  Thus, we should be less affected, as we spread
flows more across qdisc.


> - A single stream gets about 7% slower (87 -> 81 Gbit/s), with 0
>    retransmits instead of 1-20k. This is not a cost of the change: without
>    the losses TCP keeps the veth ring full, and veth_poll() waking the
>    queue makes net_tx_action() run the transmit work on the receiver's
>    NAPI CPU. With VETH_RING_SIZE raised to 4096 the ring doesn't fill,
>    nothing is requeued and both kernels do 86-90 Gbit/s, while 4 streams
>    still go from 45 to 70 Gbit/s.
> 
> - History: before a53851e2c321, gso_skb was a single pointer.
>    dev_requeue_skb() stored the busy skb there with the rest of the list
>    still chained through skb->next, and dequeue_skb() handed the whole
>    chain back, so the order was kept. a53851e2c321 turned gso_skb into a
>    queue that dequeue_skb() drains one skb at a time; requeuing queued
>    only the first skb (at the head for locked qdiscs, at the tail for
>    TCQ_F_NOLOCK ones) and lost the rest of the list. 9540d977618c fixed
>    that leak by queueing every skb of the list, and moved the locked path
>    to the tail too, "to avoid skb out of order". Appending keeps a
>    requeued list in order while gso_skb is empty, but not when the
>    requeued skb was just taken from the head of a non-empty gso_skb,
>    which is the case fixed here. So locked qdiscs reorder since
>    9540d977618c, TCQ_F_NOLOCK ones since a53851e2c321; both are in 4.16.
> 
>   net/sched/sch_generic.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0..e79e9f33efba 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -168,8 +168,11 @@ static inline void qdisc_enqueue_skb_bad_txq(struct Qdisc *q,
>   
>   static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
>   {
> +	struct sk_buff_head requeue;
>   	spinlock_t *lock = NULL;
>   
> +	__skb_queue_head_init(&requeue);
> +
>   	if (q->flags & TCQ_F_NOLOCK) {
>   		lock = qdisc_lock(q);
>   		spin_lock(lock);
> @@ -178,7 +181,7 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
>   	while (skb) {
>   		struct sk_buff *next = skb->next;
>   
> -		__skb_queue_tail(&q->gso_skb, skb);
> +		__skb_queue_tail(&requeue, skb);
>   
>   		/* it's still part of the queue */
>   		if (qdisc_is_percpu_stats(q)) {
> @@ -194,6 +197,11 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
>   		skb = next;
>   	}
>   
> +	/* the skbs may come from the head of gso_skb, so put them back there:
> +	 * appending them would let the ones still parked overtake them
> +	 */
> +	skb_queue_splice(&requeue, &q->gso_skb);
> +
>   	if (lock) {
>   		spin_unlock(lock);
>   		set_bit(__QDISC_STATE_MISSED, &q->state);

