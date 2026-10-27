Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133277;
	b=Z6gRPWQwT3T7NkmprmVMTgKNvSUeSIrrvkgFfwtdwKozVyoGOtLN0hhFLoIO7ZvfHECP
	 QJrO9wytC8CPB9WxOw9jKQ+tQ0vo7libi3rt1sZbZ/aeh2e9arxArTqXIHgjbReic+YGF
	 nGXy4RPJVyCVak/e4jZRXHEsJf7Wxj2BRCTx2bNBoU8twgP2HeFkg29IO78RIRR1qFr4n
	 ww3s01ziHBGnlhyOGKpJU1M7YLv7H4Fs3AYuLXylogslHIb+hjVVVxXE4nQqWqiyUelZB
	 /VyTHeCcrq2o7Sb3fZr4QCsrm9/uZ1NtS5fwbyfq5mGBP9aUV+Q7lYh+oCLUy9SdUWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133277;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qyzQ7xnx+8HWZMHa2Kc/8JqcbawNuI9hs09DU//OnEc=;
	b=gRcn6r81MUBOcPnfEVqvDDzsvGmQeJxqUQKn1w0hfTGmQWWVwnFy/CzTtvlbeRFFl0oz
	 dx8hUu3pTbL/SSV6MkVjzDxMbxq2abVvB1v59Sbw/lBbwLdrxJP5ZTyswGuqQcw9jRePf
	 Dj6VGfldNgq6iCGWAfrEHXGd7tRDo+risqAY/AF9GhJg+soBgLiLNXKSocewSzEza2U7s
	 aryeXyjGr6yL00w3pwhJbLNcmLfRznhRDq405Jxwz0cN8cac1DnZ9v8B6OtySA46Aq+sV
	 sgeMcNh70ZitkxUnPjy5x8BjXJ0dcC//X0Qbf3uUbZg1pk7FdB7aMpNcqlbKKO5TDUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfDwDK75;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66C606A31F;
	Tue, 27 Oct 2026 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfDwDK75
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B506C1F01825;
	Tue, 27 Oct 2026 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133276;
	bh=qyzQ7xnx+8HWZMHa2Kc/8JqcbawNuI9hs09DU//OnEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AfDwDK75H7j1zEWctOfHgX8baXztg1/8X8YT5hNEGFTKOsVGAsAwsWo3yLjJnW/Pf
	 GyGuSnXxOsXClZZPi2nYiRYeXjRZTHWllBSN2wNMm4krJAeEaOPtgx2bx8iD/4ubuX
	 tQmi/pqiBBzluXj/IaK7jlcXSt1mwa/K4bH+X2tDJbv4H2mm4mVvn5ZMMRtN3gH48T
	 xix/fdVMRB5W/f2UiBqnz8T2/8zIceza97h477GdRyL9xhhb6HKTvGd9yh42wzJ6oU
	 pnycqeerxqiZoXCNVnmTQY0SU0BF/ARB3gyELiqVFuPA7USpZN+5tdlVoJJnXYJVeu
	 5yyoXFnSK2UzA==
Subject: Re: [PATCH net v2] net: sched: prevent scheduling deactivated qdiscs
From: netdev-bot+sashiko@kernel.org
To: david.lee@trailofbits.com
Cc: vinicius.gomes@intel.com, kuba@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kylebot@openai.com, dominik.czarnota@trailofbits.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 27 Oct 2026 20:34:35 +0000
Message-ID: <179313327525.3134.15618266937324300579@kernel.org>
In-Reply-To: <20261023194712.package1-20-v2-david.lee@trailofbits.com>
References: <20261023194712.package1-20-v2-david.lee@trailofbits.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not cover the IFF_UP-but-no-carrier case.

--

net: sched: prevent scheduling deactivated qdiscs

This patch makes __netif_schedule() return early for qdiscs that have
__QDISC_STATE_DEACTIVATED set. The goal is to stop a late TAPRIO
advance_timer callback from scheduling a qdisc after some_qdisc_is_busy()
has reported it idle. It also makes transition_one_qdisc() reschedule
nonempty queues on reactivation.

Link: https://lore.kernel.org/netdev/20260805102514.740834-1-david.lee@trailofbits.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1a09e78691180..bcd2d5197d5b7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3478,6 +3478,9 @@ static void __netif_reschedule(struct Qdisc *q)
>  
>  void __netif_schedule(struct Qdisc *q)
>  {
> +	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state)))
> +		return;
> +

[Severity: High]
Does this guard cover the case where the device is IFF_UP but the carrier
is off?

Only qdisc_deactivate() sets the DEACTIVATED bit, and
dev_deactivate_queue() calls it only on dev_queue->qdisc:

net/sched/sch_generic.c:dev_deactivate_queue() {
    ...
	qdisc = rtnl_dereference(dev_queue->qdisc);
	if (qdisc) {
		if (qdisc->enqueue)
			*sync_needed = true;
		qdisc_deactivate(qdisc);
		rcu_assign_pointer(dev_queue->qdisc, &noop_qdisc);
	}
}

With the carrier off, dev_activate() returns before it reaches
transition_one_qdisc():

net/sched/sch_generic.c:dev_activate() {
    ...
	if (!netif_carrier_ok(dev))
		/* Delay activation until next carrier-on event */
		return;
    ...
}

So dev_queue->qdisc stays &noop_qdisc. Because noop_qdisc is
TCQ_F_BUILTIN, qdisc_deactivate() does nothing to it. The TAPRIO in
qdisc_sleeping never gets the bit, and qdisc_alloc() does not set it
either.

Here is a possible sequence, for example on a multiqueue veth whose peer
is down, or a multiqueue TAP with no reader:

1. tc qdisc add ... root taprio (software mode). taprio_change() calls
   taprio_start_sched(), which arms advance_timer. taprio_attach() puts
   the taprio in each qdisc_sleeping, and dev_activate() returns early.

2. tc qdisc del/replace root. qdisc_graft() calls
   dev_deactivate(dev, false). Only noop_qdisc is flagged.
   dev_reset_queue() is skipped because reset_needed is false, and
   some_qdisc_is_busy() returns. advance_timer is still armed.

3. On another CPU:

   advance_sched()
     __netif_schedule(sch)    <- DEACTIVATED is clear, SCHED gets set
   net_tx_action()
     clear_bit(__QDISC_STATE_SCHED, &q->state)
     qdisc_run()
       taprio_dequeue()
         taprio_dequeue_from_txq()
           child = q->qdiscs[txq]

4. Meanwhile, on CPU0:

   notify_and_destroy()
     qdisc_put()
       __qdisc_destroy()
         qdisc_reset()        <- taprio_reset(), without the root lock
         taprio_destroy()
           hrtimer_cancel(&q->advance_timer)
           qdisc_synchronize(sch)
           kfree(q->qdiscs)
           q->qdiscs = NULL

qdisc_synchronize() waits only for SCHED to clear. It does not wait for a
qdisc_run() that has already started, and net_tx_action() clears SCHED
before it calls qdisc_run().

Can taprio_dequeue_from_txq() then read the freed q->qdiscs array and call
child->ops->peek() through the pointer it loaded? And if it runs after
q->qdiscs = NULL, does it hit a NULL dereference instead?

The skb double-ownership in the commit message is probably not possible
here. Enqueues go to noop_qdisc, so the child queues are empty. It is
still the same race, though: TAPRIO gets scheduled after the busy check.

Before 47e8dbb6e763, graft-time dev_deactivate() always ran
dev_reset_queue() on qdisc_sleeping. That reached taprio_reset() and
hrtimer_cancel() before some_qdisc_is_busy(), whatever the carrier state.

Would it make sense to stop or neutralize the TAPRIO advance_timer for the
sleeping qdisc during graft deactivation? For example, the timer could be
cancelled before the busy wait, or qdisc_sleeping could be flagged as well
as dev_queue->qdisc.

This next part is a pre-existing issue, not one introduced by this patch.
If the device is not IFF_UP, qdisc_graft() skips dev_deactivate()
entirely:

net/sched/sch_api.c:qdisc_graft() {
    ...
		if (dev->flags & IFF_UP)
			dev_deactivate(dev, false);
    ...
}

So a taprio created on a down interface can still be scheduled by its own
timer while it is being destroyed.

>  	/* If q->defer_list is not empty, at least one thread is
>  	 * in __dev_xmit_skb() before llist_del_all(&q->defer_list).
>  	 * This thread will attempt to run the queue.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023194712.package1-20-v2-david.lee%40trailofbits.com
