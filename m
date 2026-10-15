Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8E5293E9;
	Thu, 15 Oct 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069109; cv=none; b=m3BXZcz364DHgoAr41LuDbVqJ3N28uHw7LvalM9YXFKgWTiHV1JDDg3++/vLnqkPme93J3+FYM7X1TwnIy04jUFBQDFY3Du/qiZM2fttUjJwu5rwKh8hjH86SZfhDad1MQsfUg5GiDzTKQB6XdOIOIRMUSB14HOl5Hi5Bap9px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069109; c=relaxed/simple;
	bh=O2+1GwEE0AsDmP5QqMiPLXgMPBGGavsO6FmACr+IRVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbFaTdrpOBzAJbu4Sjr7sL2EGo+z0Zdv+OsHZvYYqvIZvrjcgq6mDWvdk8cyv2v+k3Hg48wwciTpCelCsrh12kT+yxcWhBknFlcqI8TeYVpbn59slpHQnn6wMt/vNBmkSKHlSvQK4bwCPntNlMS5I2COpEbYtnd0f9hnA/nGEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnQPqeck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnQPqeck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506601F000C4;
	Thu, 15 Oct 2026 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069106;
	bh=c+hYfQRfw/vcaP+SdQuPcP8r55bXq9Rsby8ykddfBB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BnQPqeckA/+14E1ejZnXfCGBkUgNzXeDijJXXHFi7106QQUDRv0FDiHRMrKMsriL3
	 3rQCNWIC/fmJbV+/+MJWLofyiiktBd+2/CDkUeLfg7OKWtqj2t+EqiiOWUCnsDsf2B
	 Z7xRLseQa/bfv9u/etIaR1Me2HjqAGSO2xtOezJNkrQHhnu6hVXEOSQllqoiNSGuLh
	 /0XS4KxcQ6F0Qn5ZsVqQ/aCsfEZwFW4O5pLv2FkXtlEelC2DZnkE8DrV5QxKHPTNCJ
	 BzNvRKd2TWCrboJCDc6I0SGHT1uj/IcwZYLuCX5bxdkYW7UL5lZH43uCqH2zwaV365
	 2PMz3ZybAy+bQ==
Date: Thu, 15 Oct 2026 13:58:22 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
Message-ID: <20261015125822.GH83879@horms.kernel.org>
References: <QDISC-MD1X.v2.20261009135842@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-MD1X.v2.20261009135842@mojatatu.com>

On Fri, Oct 09, 2026 at 02:09:03PM -0400, Jamal Hadi Salim wrote:
> This issue was caught by Sashiko (nipa). A producer-side path cap is
> already merged (ea4d4b5dddb5); this patch adds the matching consumer-side
> cap.
> 
> The issue:
> The tx queue is picked and capped in netdev_core_pick_tx(), before the
> __dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside
> egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
> that store is never re-checked. bpf_convert_ctx_access() bounds it only
> by NO_QUEUE_MAPPING, not by the device's queue count.
> 
> On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
> indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it with
> just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bounds
> txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
> allocation on non-lltx devices such as ifb. Drivers that index their rings
> from skb_get_queue_mapping() (ex: ifb) go out of range the same way.
> 
> The Fix:
> Cap the mapping at the consumer and write the capped value back, so both
> the qdisc's _tx[] lookup and any later driver read stay in range. The cap
> folds into the dequeue path instead of a separate walk over the returned
> list: dequeue_skb() caps the head, and each bulk helper caps the element it
> appends. netdev_cap_txqueue() already logs a ratelimited notice and selects
> queue 0. The single-packet case pays one extra compare against
> real_num_tx_queues.
> 
> A bulk-dequeued list is transmitted under the single tx queue lock of the
> head skb, so every element must belong to that same queue. The fast bulk
> helper (TCQ_F_ONETXQUEUE, taken on BQL devices by the per-queue children
> of mq, mqprio, taprio and htb, and by any qdisc on a single-queue device
> such as the prio root in the reproducer) must therefore compare each
> capped follower against the head and requeue a mismatch, exactly as the
> slow helper already does; appending a follower that caps to a different
> queue would send it under the wrong _xmit_lock.
> 
> Conditions to recreate the bug:
> Load a SCHED_CLS or SCHED_ACT program that stores __sk_buff->queue_mapping
> (a tc BPF action is enough), attach it to a transmit qdisc (for example a
> matchall filter on a prio root), and send a packet. With a 1-queue device a
> store of 1 indexes one past dev->_tx[]. Under KASAN with panic_on_warn=1
> the unfixed kernel faults with "BUG: KASAN: slab-out-of-bounds in
> sch_direct_xmit". Loading the program needs CAP_BPF/CAP_SYS_ADMIN, so the
> trigger is root.
> 
> Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc clsact")
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 -> v2:
> - try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) capped
>   each follower but appended it without comparing it against the head, so
>   a mismatched follower was still sent under the head's txq lock. Compare
>   the capped follower with the head and requeue a mismatch to skb_bad_txq,
>   matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
> ---
>  net/sched/sch_generic.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 5 deletions(-)

Hi Jamal,

Weirdly, this patch is mangled and does not apply.

> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0..b65bec7e2643 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,

This hunk results in 31 lines, not 33.

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
> +
> +static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
> +					     struct sk_buff *skb)
> +{
> +	return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb));
> +}
> +
>  static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
>  {
> -	const struct netdev_queue *txq = q->dev_queue;
> +	const struct netdev_queue *txq;
>  	spinlock_t *lock = NULL;
>  	struct sk_buff *skb;
>  

...

> @@ -216,6 +242,17 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,

And this hunk results in 15 lines, not 17.

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
>  		bytelimit -= nskb->len; /* covers GSO len */
>  		skb->next = nskb;
>  		skb = nskb;

...

pw-bot: changes-requested
