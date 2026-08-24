Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300035F8D2;
	Mon, 24 Aug 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589043; cv=none; b=K8H1nJSU6A4H2yFGQ/+OSXNF/AeSyFphiLQfvG9cL6eW/sdhs3UBdnXMvSp2dIx5w56bXziI46qBYi/hLU+XHKKovtz3pGJIBmbevC6PCTOtjef9s2Qk9ewy2rLjeL4507JtNVDNMSRrcVBUmBjWf31gJ7N7Bf5jOxhvhF5joE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589043; c=relaxed/simple;
	bh=QqPjj7ldJ0heWDbPJ00z8ATxo9dRfqyDS51BJi8W3O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0+RA1s4jH2w7ICYohwmRtRFEMcRpF+XHk+ALug2x5srXqIl25413cLWHTeRIrJyV2lsGXpScH5sjhOXGUGRH8BMm18RmnACYT+KfCS/6yFUdQsz2bBhwLlSVCOc9cKh3j58GbO7zrS2dv00oOLk4esiK9RZs+VVayeIyiANNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVLxiV+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVLxiV+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90A1F000E9;
	Mon, 24 Aug 2026 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589041;
	bh=ccprj7uvs6H815Axks6UBkPHSJxlZwnAj8ISZ9LuDAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZVLxiV+oTRWjlhl9TLRFJ+ftJKIt0tfvbR4cvhxwJEzVduSN62BDHTGD0X0vshAG7
	 fMHpTQDiXPSA+4vvc23tau/brQBHzbwInKsyG18zIpwQkChA3OI13nBKTmp0/wydXN
	 vL/cHwRtcOGL+XY5+Dg4W+TYf+I0TD9KXhWqCty8M3zhlwnLERAzGJeqZaF+J/gS3J
	 A7Oeb58ttpDBCla4SzvRntAJhJTzUWxZKYBUoKbv/AFs8dESkdOZSfmpN5gBcYUJHD
	 xk0DLhzV5WAh+wO6tHt3c8uKRbTmtTzX1wnBbIvLMZmTT92CFxkZi1TcoYIIB1BeeA
	 pruFyUwOoP+yA==
From: Simon Horman <horms@kernel.org>
To: blbllhy@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] amt: fix tunnel list corruption on device stop
Date: Mon, 24 Aug 2026 17:30:29 +0100
Message-ID: <20260824163029.1034695-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822045407.28983-1-blbllhy@gmail.com>
References: <20260822045407.28983-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822045407.28983-1-blbllhy@gmail.com?part=1
---
amt: fix tunnel list corruption on device stop

This changes amt_dev_stop() to unlink tunnels under amt->lock using
list_del_init(), adds a list_empty() ownership check to
amt_tunnel_expire(), clears sk_user_data before synchronize_net(), and
switches the per-tunnel GC work to disable_delayed_work_sync().

A few questions on the changelog and on the new drain loop below.

First, about the two justifications given in the changelog:

>     1. Quiesce RX: clear sk_user_data and call synchronize_net() to ensure
>        no RCU readers are traversing tunnel_list. This makes list_del_init()
>        safe (it is not RCU-reader-safe unlike list_del_rcu()).

[Severity: Medium]
Is this claim accurate for all readers of amt->tunnel_list?

amt_dev_xmit() traverses the same list in relay mode:

drivers/net/amt.c:amt_dev_xmit() {
	...
	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
		hash = amt_group_hash(tunnel, &group);
	...
}

That reader is not reached through amt->sk / sk_user_data, so clearing
sk_user_data and calling synchronize_net() does not cover it.

>     4. Use disable_delayed_work_sync() instead of cancel_delayed_work_sync()
>        to prevent amt_update_handler() from rearming the GC timer in a rare
>        race where a packet arrives before the socket is fully released.

Can this window still exist after the change in point 1?

amt_update_handler() and amt_request_handler() are only called from
amt_rcv(), which resolves amt via rcu_dereference_sk_user_data(sk) inside
rcu_read_lock_bh(). Once sk_user_data is NULLed and synchronize_net() has
returned, amt_rcv() can no longer find amt, so the packet-driven
mod_delayed_work(amt_wq, &tunnel->gc_wq, ...) in amt_update_handler()
cannot run any more.

So point 1 says no RCU reader can be traversing tunnel_list, while point 4
describes a packet reaching amt_update_handler(), which can only reach that
mod_delayed_work() from inside list_for_each_entry_rcu() over
amt->tunnel_list. Could the changelog be made consistent about which
readers the quiesce actually covers, given that this is the stated reason
for dropping the RCU-safe removal primitive and the patch is tagged for
stable?

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index bddc24e1856d..a5db02d81291 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -1348,6 +1348,11 @@ static void amt_tunnel_expire(struct work_struct *work)
>  	struct amt_dev *amt = tunnel->amt;
>  
>  	spin_lock_bh(&amt->lock);
> +	/* amt_dev_stop() marks tunnels it owns with list_del_init(). */
> +	if (list_empty(&tunnel->list)) {
> +		spin_unlock_bh(&amt->lock);
> +		return;
> +	}
>  	rcu_read_lock();
>  	list_del_rcu(&tunnel->list);
>  	amt->nr_tunnels--;

[Severity: High]
This isn't a bug introduced by this patch, but does the new list_empty()
guard cover the case where the GC work is rearmed while it is already
running?

amt_update_handler() rearms the work under rcu_read_lock_bh() only, without
amt->lock:

drivers/net/amt.c:amt_update_handler() {
	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
		if (tunnel->ip4 == saddr) {
			if ((nonce == tunnel->nonce &&
			     response_mac == tunnel->mac)) {
				mod_delayed_work(amt_wq, &tunnel->gc_wq,
						 msecs_to_jiffies(amt_gmi(amt))
								  * 3);
	...
}

Once process_one_work() has cleared the work's PENDING bit,
mod_delayed_work() arms the delayed timer again, and amt_tunnel_expire()
then proceeds to list_del_rcu() + kfree_rcu(tunnel, rcu) with
tunnel->gc_wq.timer still armed. The rearm delay is amt_gmi() * 3, which is
far longer than the grace period behind kfree_rcu(), so the timer_list
inside the freed tunnel stays linked in the timer wheel.

The drain loop in amt_dev_stop() does not help here, because the first
callback has already removed the tunnel from amt->tunnel_list, so
disable_delayed_work_sync() is never called for it.

And if the work does run again on still-mapped memory, the new guard cannot
detect it either: list_del_rcu() leaves entry->next unchanged, so
list_empty(&tunnel->list) is false and a second list_del_rcu() runs with
prev == LIST_POISON2, which is the same lib/list_debug.c BUG this patch is
fixing.

> @@ -3097,13 +3104,21 @@ static int amt_dev_open(struct net_device *dev)
>  	amt->req_cnt = 0;
>  	WRITE_ONCE(amt->remote_ip, 0);
>  
> -	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
> -		list_del_rcu(&tunnel->list);
> +	spin_lock_bh(&amt->lock);
> +	while (!list_empty(&amt->tunnel_list)) {
> +		tunnel = list_first_entry(&amt->tunnel_list,
> +					  struct amt_tunnel_list, list);
> +		list_del_init(&tunnel->list);
>  		amt->nr_tunnels--;

[Severity: High]
Can this wedge a concurrent amt_dev_xmit()?

list_del_init() points the node at itself:

include/linux/list.h:list_del_init() {
	__list_del_entry(entry);
	INIT_LIST_HEAD(entry);
}

amt->tunnel_list is published with list_add_tail_rcu() in
amt_request_handler() and read locklessly in amt_dev_xmit():

drivers/net/amt.c:amt_dev_xmit() {
	...
	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
	...
}

A reader parked on the node being unlinked gets itself back from
list_next_entry_rcu() and never reaches the list head, so it spins forever
with BH disabled inside an RCU read-side section. That also stalls the
grace period behind the kfree_rcu(tunnel, rcu) calls in the same loop.

Is this TX reader quiesced anywhere? amt_link_setup() sets:

drivers/net/amt.c:amt_link_setup() {
	dev->priv_flags		|= IFF_NO_QUEUE;
	dev->lltx		= true;
	...
}

With the noqueue qdisc, noqueue_init() leaves qdisc->enqueue == NULL, so
dev_deactivate_queue() never sets *sync_needed and dev_deactivate_many()
skips its synchronize_net() for this device. And __dev_direct_xmit(), used
by AF_PACKET PACKET_QDISC_BYPASS and xsk generic xmit, tests liveness
before disabling BH:

net/core/dev.c:__dev_direct_xmit() {
	if (unlikely(!netif_running(dev) ||
		     !netif_carrier_ok(dev)))
		goto drop;

	skb = validate_xmit_skb_list(skb, dev, &again);
	...
	local_bh_disable();
	...
}

so a sender can pass the check, be preempted across __dev_close_many() and
amt_dev_stop()'s synchronize_net(), and only then enter amt_dev_xmit().

The previous list_del_rcu() poisoned only entry->prev and left entry->next
intact, so a racing reader still terminated. Would keeping list_del_rcu()
here (and using a different marker for the ownership test in
amt_tunnel_expire()) avoid this?

> -		cancel_delayed_work_sync(&tunnel->gc_wq);
> +		spin_unlock_bh(&amt->lock);
> +
> +		disable_delayed_work_sync(&tunnel->gc_wq);
>  		amt_clear_groups(tunnel);
>  		kfree_rcu(tunnel, rcu);

[Severity: High]
This is a pre-existing issue, but the works nested under the tunnel are
still only cancelled with the non-waiting cancel_delayed_work() while the
tunnel-level work is now upgraded to disable_delayed_work_sync().

amt_clear_groups() -> amt_del_group() does:

drivers/net/amt.c:amt_del_group() {
	if (cancel_delayed_work(&gnode->group_timer))
		dev_put(amt->dev);
	hlist_del_rcu(&gnode->node);
	...
	kfree_rcu(gnode, rcu);
}

and amt_destroy_source() does the same for the source timer:

drivers/net/amt.c:amt_destroy_source() {
	cancel_delayed_work(&snode->source_timer);
	hlist_del_init_rcu(&snode->node);
	...
}

cancel_delayed_work() returns false once process_one_work() has cleared
PENDING, and it is never waited for. The callbacks dereference the objects
and take tunnel->lock before entering any RCU read-side section:

drivers/net/amt.c:amt_group_work() {
	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
	struct amt_dev *amt = gnode->amt;
	...
	spin_lock_bh(&tunnel->lock);
	...
}

drivers/net/amt.c:amt_source_work() {
	struct amt_group_node *gnode = snode->gnode;
	struct amt_dev *amt = gnode->amt;
	...
	tunnel = gnode->tunnel_list;
	spin_lock_bh(&tunnel->lock);
	rcu_read_lock();
	...
}

A worker preempted between PENDING being cleared and spin_lock_bh() is in
plain preemptible process context, not an RCU reader, so the grace periods
behind kfree_rcu(gnode, rcu) and kfree_rcu(tunnel, rcu) can complete. When
it resumes it takes spin_lock_bh() on freed memory, reads gnode fields from
freed memory, and can call dev_put(amt->dev) derived from that state.

Would it make sense to use the sync cancel for the group and source timers
too, so the cancel-before-free ordering is complete for everything nested
under the tunnel?

>  	}
> +	spin_unlock_bh(&amt->lock);
>  
>  	return 0;
>  }
