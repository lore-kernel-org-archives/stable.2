Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000248167A;
	Mon, 21 Sep 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990508; cv=none; b=ll2dvmvQjNI7ToCb/ZRl7Tk3+LGKuARe0CmspgSz6slaK+hmusbVkFiRFQfW59dwPdYC/pYn5u9nQ5orjhC+w4yZAD8BKnK6Dn6kHOXJhFmIdCG/qFJc8Qwkft2J0GZJeBEqK1P9rkPdnaIGkkm2BisEz9PR7WnxfQpMhEtDrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990508; c=relaxed/simple;
	bh=aK8dCs0f+Fxt5fuDPrF6l/ep1El6yd6ny6LpOAax5fA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lt2sh8/7eOQ6g/cj40Kc4OGvn0zvxiksqJI0NSalmP0gqkf5W9ZkE4ymw8QYub8G3OGDCF4uRx3hOe6LzQldtT9kSfgBiMW0IZjiIoCZEFJ3H88CWtSXBu6/0goFaoPmvMENvZWHnBL/GNYX9LfqJgsawqaXeROX5DbTwPasjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVVvcwRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVVvcwRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C21F000FF;
	Mon, 21 Sep 2026 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990506;
	bh=KyIzbVUhq1HctyEq/OfnvyuEkaEwN2uGoE8H4yzypLU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nVVvcwRvYxptV5IWO6JI2uEq7d1WjMbgb3sUo1I9DB0xXGNjS+OZ0HXDU9ZuugZhO
	 XLzY2R6ROB6+lFkEVthSWz8191E0dK4xiO71E/oeznm7Vnf0/qnJlHZUv+FcXvUZSw
	 x+7bf9aCgtuq/fotVCLFrnL2YoT638q52mGPmQu4TjoCJYmIyH7UukDK1lRJ1KvGLj
	 eZUA8ecu+HwMhWOoD2631rstcU4qLc9wORcb71D8LRaKHEZLVpzb1Z3K4ai3ZwKoEP
	 g3AWROyKM3BLiS8Zo4xtMaeGh1uAxqHZbSgBWlUqDANuVDJjIj2mYJTvGLifUP9+bt
	 nRBM//cp56tQA==
Subject:
 Re: [PATCH] net: cxgb: Fix skb reference leak in espibug_workaround_t204()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 jeff@garzik.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stephen@networkplumber.org,
 stable@vger.kernel.org
Date: Mon, 21 Sep 2026 11:35:04 +0000
Message-ID: <178999050491.2160803.7893971966748337214@kernel.org>
In-Reply-To: <20260917105425.2147804-1-vulab@iscas.ac.cn>
References: <20260917105425.2147804-1-vulab@iscas.ac.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: the identical skb reference leak remains in
  the sibling ESPI workaround timer callback espibug_workaround()…

Pre-existing issues:
- [High] Pre-existing skb_buff_head list corruption in the exact call
  path the patch touches: espibug_workaround_t204() re-submits the very…
- [High] Pre-existing dangling cached skb pointer leading to use-after-
  free and double free around the espibug_skb[] reference protocol that…

--

net: cxgb: Fix skb reference leak in espibug_workaround_t204()

The ESPI workaround timer for T204 adapters takes an extra reference on the
cached espibug skb before handing it to t1_sge_tx().  When t1_sge_tx()
returns NETDEV_TX_BUSY the skb was never queued, so the patch drops the
extra reference in that case.

> diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
> index d8fca697874a5..d4677c5b8d744 100644
> --- a/drivers/net/ethernet/chelsio/cxgb/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
> @@ -2052,7 +2052,8 @@ static void espibug_workaround_t204(struct timer_list *t)
>  			 * the skb once the DMA has completed.
>  			 */
>  			skb = skb_get(skb);
> -			t1_sge_tx(skb, adapter, 0, adapter->port[i].dev);
> +			if (t1_sge_tx(skb, adapter, 0, adapter->port[i].dev))
> +				dev_kfree_skb_any(skb);
>  		}
>  	}
>  	mod_timer(&sge->espibug_timer, jiffies + sge->espibug_timeout);

[Severity: Medium]
Should the sibling handler espibug_workaround() in the same file get the
same treatment?  It has the identical sequence and still discards the
return value:

drivers/net/ethernet/chelsio/cxgb/sge.c:espibug_workaround() {
	        /* bump the reference count to avoid freeing of the
	         * skb once the DMA has completed.
	         */
	        skb = skb_get(skb);
	        t1_sge_tx(skb, adapter, 0, adapter->port[0].dev);
}

That callback is the one installed for single-port T2 boards:

	if (is_T2(sge->adapter)) {
		timer_setup(&sge->espibug_timer,
			    adapter->params.nports > 1 ? espibug_workaround_t204 : espibug_workaround,
			    0);

and subr.c lists single-port T2 boards (CHBT_BOARD_N210, CHBT_BOARD_CHT210,
CH_BRD_T210_1F, CH_BRD_T210_1CU) with .port_number = 1, so it is live code.

It also looks like the more exposed of the two: it does not test
netif_queue_stopped() before calling t1_sge_tx(), and sge->espibug_timeout
stays at 1 jiffy for nports == 1 versus HZ/100 for T204, so it re-enters the
same call much more often.

Since t1_sge_stop() only drops a single reference per slot:

	for (i = 0; i < MAX_NPORTS; i++)
		kfree_skb(sge->espibug_skb[i]);

and t1_start_xmit() only repopulates the slot when it reads NULL, does each
leaked reference make sge->espibug_skb[0] permanently unfreeable?  Would it
make sense to fix both call sites in one patch?

[Severity: High]
This isn't a bug introduced by this patch, but can the same skb pointer end
up enqueued twice on the scheduler queue in this exact path?

On T204 sge->tx_sched is non-NULL and skb->dev is still set from the
original t1_start_xmit(), so t1_sge_tx() always routes this submission
through sched_skb():

	if (sge->tx_sched && !qid && skb->dev) {
use_sched:
		...
		skb = sched_skb(sge, skb, credits);
		if (!skb) {
			spin_unlock(&q->lock);
			return NETDEV_TX_OK;
		}

sched_skb() enqueues unconditionally and can then leave the skb on the
queue while returning NULL:

drivers/net/ethernet/chelsio/cxgb/sge.c:sched_skb() {
		skbq = &s->p[skb->dev->if_port].skbq;
		__skb_queue_tail(skbq, skb);
		s->num++;
	...
	if (credits < MAX_SKB_FRAGS + 1)
		goto out;
}

That low-credit state (and the port quota check where len <=
s->p[s->port].avail fails) is what a stuck ESPI produces, which is exactly
when this timer handler runs.

Since skb_get() returns the same pointer that is cached in
sge->espibug_skb[i], and nothing in espibug_workaround_t204() tests whether
the previous submission is still sitting in the scheduler queue, the next
expiry hands the identical, still-queued pointer to __skb_queue_tail()
again.

Can that corrupt the skbq list (skb->next/prev pointing at itself) and
desynchronize s->num, leading to reclaim_completed_tx() later consuming an
skb the queue still references?  Note the new dev_kfree_skb_any() does not
cover this case, since sched_skb() success is reported as NETDEV_TX_OK.

[Severity: High]
This is a pre-existing issue, but the new dev_kfree_skb_any() call may make
it worse: is the cached pointer in sge->espibug_skb[] left dangling after
the interface goes down?

t1_sge_stop() frees the slot but never clears it:

drivers/net/ethernet/chelsio/cxgb/sge.c:t1_sge_stop() {
	for (i = 0; i < MAX_NPORTS; i++)
		kfree_skb(sge->espibug_skb[i]);
}

The only writer of the array is t1_start_xmit(), and it only publishes a
new skb when the slot reads NULL:

		if ((unlikely(!adapter->sge->espibug_skb[dev->if_port]))) {
			...
				adapter->sge->espibug_skb[dev->if_port] = skb;

So after cxgb_down() -> t1_sge_stop() drops the last reference, does the
slot keep pointing at freed memory while also blocking a fresh skb from
being cached?

On the following ifup, t1_sge_start() re-arms the timer:

	if (is_T2(sge->adapter))
		mod_timer(&sge->espibug_timer, jiffies + sge->espibug_timeout);

and espibug_workaround_t204() then reads skb->cb[0], writes into the buffer
via skb_copy_to_linear_data_offset(), calls skb_get() on it and hands it to
write_tx_descs() for DMA.  With this patch the same freed pointer can also
reach dev_kfree_skb_any() on the NETDEV_TX_BUSY path, and a second
interface down would run kfree_skb() on it again.

Would setting sge->espibug_skb[i] = NULL after the kfree_skb() in
t1_sge_stop() be the right fix here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917105425.2147804-1-vulab%40iscas.ac.cn
