Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91D41E6CB;
	Thu, 16 Jul 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206194; cv=none; b=YVwiBGZFyNwedUVk9kHBY+Q/xBnaX2acGNE7OEc4RvXaM8VZjY7DejgqfL7Y0hVWJBYowNDtl8S74JpvSE3v6VoXXKO18P2E57p0zeHZ0s0AMcxEEm9INmGTd2mI2alzLpsmMWc5Jrm7fTwQB6vcgFAVTy2xQb48Q8L7wY3VDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206194; c=relaxed/simple;
	bh=srIyBDg0zIgsZEktS9hxZD2lKjLh1HP/H77kcG09KzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV8qEfdn7CY6AXKQ0fgdRWOFC86c6Bt6K6CHNF2syMh98nsPJab9SdKhyvE2mfY1rBWnqBkYrDAh0zr9j6Y9Df6onL/vOzPuhj8dRVeCESzQYU7oTTtCzpPQMNWWPE2FRhFO05cQVaBBbIrHU9iIkGuRLxVFdvtfcwXBAWZ6aEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM6CxH5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM6CxH5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933881F00A3A;
	Thu, 16 Jul 2026 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206193;
	bh=sRmSoYQ1H3fBB3GhAuOFx+4D+QchTkAKC/wuASYBpj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZM6CxH5jy48DAmRrE7l+JwcTOqthQhRKOjRZSN2DxfqkeFH/hL75g+YBxtdGGvtl0
	 5LXZyNY/50Jf2TlAPD84/GsQ/XQm3P0f/mzFwTRS1/1FSAXHbj4g3u5EXnQRpxlHui
	 HBV2LPUbtZBdvIwEfYPaoS2VFRnE+nq/xDx1nmKbmhBFzfU1rQyWgqcSagdz+hKKdB
	 AitzLdE4Bs3YzHvKeNfTRjkxUuzs8tNlA5Sa9rln9p09oA1cbrQ0CzfcK1dX3GI0SG
	 0ssXYwiJ38eXwQtVdn9JK77R2vG+z0cpaIDKKkZ1B8A23wix6UMJ78Ce7GcJDgp61A
	 ne0Jod7H4XUmw==
From: Simon Horman <horms@kernel.org>
To: security@auditcode.ai
Cc: Simon Horman <horms@kernel.org>,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: flush rx_mac_cmd_list before freeing sdata
Date: Thu, 16 Jul 2026 13:49:27 +0100
Message-ID: <20260716124926.304297-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710111353.12138-1-security@auditcode.ai>
References: <20260710111353.12138-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/
---
mac802154: flush rx_mac_cmd_list before freeing sdata

This patch adds mac802154_flush_queued_mac_cmds() and calls it from
ieee802154_if_remove() and ieee802154_unregister_hw() to drain
local->rx_mac_cmd_list before sdata is freed, aiming to close a KASAN
use-after-free in mac802154_rx_mac_cmd_worker().

> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index b823720630e7..59a045cccfe9 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -694,6 +694,16 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
>  	mutex_unlock(&sdata->local->iflist_mtx);
>  
>  	synchronize_rcu();
> +
> +	/*
> +	 * Drop any rx_mac_cmd_list entry still pointing at this sdata
> +	 * before it is freed below: mac802154_rx_mac_cmd_worker() runs
> +	 * asynchronously on local->mac_wq and derefs mac_pkt->sdata with
> +	 * no liveness check of its own (see mac802154_flush_queued_mac_cmds()
> +	 * for details).
> +	 */
> +	mac802154_flush_queued_mac_cmds(sdata->local, sdata);
> +
>  	unregister_netdevice(sdata->dev);
>  }

[High]
When ieee802154_if_remove() runs to delete one interface, does anything
stop RX softirq on sibling interfaces of the same phy from concurrently
enqueueing into local->rx_mac_cmd_list while the flush is walking it?

The producer path is ieee802154_subif_frame(), reached from the RX
tasklet under rcu_read_lock only, and it unconditionally does:

    mac_pkt->sdata = sdata;
    list_add_tail(&mac_pkt->node, &sdata->local->rx_mac_cmd_list);
    queue_work(sdata->local->mac_wq, &sdata->local->rx_mac_cmd_work);

with no lock on rx_mac_cmd_list. list_del_rcu() + synchronize_rcu()
above only quiesces the sdata being removed; other sdata on the same
local remain in local->interfaces and can keep receiving MAC-command
frames on other CPUs throughout the flush.

> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index ea1efef3572a..2f8c57e78db1 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -277,6 +277,17 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
>  	tasklet_kill(&local->tasklet);
>  	flush_workqueue(local->workqueue);
>  
> +	/*
> +	 * tasklet_kill() above stops any further frame reaching
> +	 * ieee802154_subif_frame(), but mac802154_rx_mac_cmd_worker() may
> +	 * still be queued/running on local->mac_wq and derefs the sdata of
> +	 * every interface ieee802154_remove_interfaces() is about to free
> +	 * below. flush_workqueue(local->workqueue) does not cover it --
> +	 * that is the DATA workqueue, not local->mac_wq -- so drain it
> +	 * explicitly first.
> +	 */
> +	mac802154_flush_queued_mac_cmds(local, NULL);
> +
>  	rtnl_lock();
>  
>  	ieee802154_remove_interfaces(local);

[High]
Does tasklet_kill() actually stop any further frame from reaching
ieee802154_subif_frame() here?

tasklet_kill() clears TASKLET_STATE_SCHED and waits for a running
instance to finish, but it does not prevent a subsequent
tasklet_schedule() from a driver's ieee802154_rx_irqsafe() path. If a
driver interrupt fires between mac802154_flush_queued_mac_cmds(local,
NULL) and destroy_workqueue(local->mac_wq) further down, a new
mac_pkt would be added to rx_mac_cmd_list, the worker would be queued
on local->mac_wq, and it would then run against sdatas already freed
by ieee802154_remove_interfaces().

Note this call site also runs before rtnl_lock() a few lines below,
which is relevant to the kernel-doc comment quoted further down.

> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index cd8f2a11920d..0b167f76cb23 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -128,6 +128,48 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
>  	kfree(mac_pkt);
>  }
>  
> +/**
> + * mac802154_flush_queued_mac_cmds - drop pending rx_mac_cmd_list work
> + * @local: the mac802154 device the queue belongs to
> + * @sdata: interface being torn down, or %NULL to flush unconditionally
> + *
> + * Every queued &struct cfg802154_mac_pkt stashes a raw pointer to the
> + * interface it was received on (see ieee802154_subif_frame() below) which
> + * mac802154_rx_mac_cmd_worker() dereferences without ever checking whether
> + * that interface is still alive. Callers must invoke this before freeing
> + * @sdata -- or every interface on @local, when @sdata is %NULL -- so the
> + * worker can never run against freed memory:
> + *
> + *  - cancel_work_sync() waits out a run already in flight. That is still
> + *    safe to let finish because nothing has been freed yet, and it blocks
> + *    any new run from starting for as long as we hold the RTNL.

[Low]
Is this description of cancel_work_sync() accurate?

cancel_work_sync() only guarantees the work is not pending or executing
by the time it returns, and does not itself block future queue_work()
calls. RTNL is not held at the ieee802154_unregister_hw() call site
(the flush is invoked before rtnl_lock() there), and at the
ieee802154_if_remove() site RTNL is a plain mutex that does not disable
BH and does not serialize with the RX softirq path
ieee802154_tasklet_handler() -> ieee802154_rx() ->
__ieee802154_rx_handle_packet() -> ieee802154_subif_frame(), which is
what enqueues into rx_mac_cmd_list and re-arms rx_mac_cmd_work via
queue_work(local->mac_wq, ...).

Could this comment be reworded to describe an invariant the code
actually provides?

> + *  - every list entry pointing at @sdata (all of them, if @sdata is NULL)
> + *    is then dropped so no future run of the worker can see it.
> + *
> + * Mirrors mac802154_flush_queued_beacons() in scan.c, which does not need
> + * the cancel_work_sync() step because its worker never dereferences sdata.
> + */
> +void mac802154_flush_queued_mac_cmds(struct ieee802154_local *local,
> +				     struct ieee802154_sub_if_data *sdata)
> +{
> +	struct cfg802154_mac_pkt *mac_pkt, *tmp;
> +
> +	cancel_work_sync(&local->rx_mac_cmd_work);
> +
> +	list_for_each_entry_safe(mac_pkt, tmp, &local->rx_mac_cmd_list, node) {
> +		if (sdata && mac_pkt->sdata != sdata)
> +			continue;
> +
> +		list_del(&mac_pkt->node);
> +		kfree_skb(mac_pkt->skb);
> +		kfree(mac_pkt);
> +	}
> +
> +	/* Other interfaces on @local may still have entries pending. */
> +	if (!list_empty(&local->rx_mac_cmd_list))
> +		queue_work(local->mac_wq, &local->rx_mac_cmd_work);
> +}

[High]
Given that ieee802154_subif_frame() can still be entered from softirq on
sibling interfaces after cancel_work_sync() returns, what protects
rx_mac_cmd_list during this iteration?

The producer does:

    list_add_tail(&mac_pkt->node, &sdata->local->rx_mac_cmd_list);
    queue_work(sdata->local->mac_wq, &sdata->local->rx_mac_cmd_work);

with no lock. cancel_work_sync() does not block a subsequent
queue_work(), so mac802154_rx_mac_cmd_worker() can start on another CPU
while this function is still iterating. The worker does
list_first_entry_or_null() + list_del() on the same list, and the
iterator here pre-loads tmp = list_next_entry(pos) each round.

Under that shape, could a concurrent list_del() from the worker on the
head entry (a) target the same entry the flush is about to delete
(double kfree() of mac_pkt), (b) free the entry that tmp points at
(use-after-free inside the flush loop), or (c) race with a
list_add_tail() from the producer softirq and leave neighbour pointers
inconsistent?

The trailing:

    if (!list_empty(&local->rx_mac_cmd_list))
        queue_work(local->mac_wq, &local->rx_mac_cmd_work);

also reads list state and re-arms the worker without any lock, which is
a TOCTOU against a softirq list_add_tail() on the same list.

Would either a spin_lock_bh() around every rx_mac_cmd_list mutation
plus the queue_work() (matching the softirq producer), or preventing
new enqueues for the sdata being torn down in ieee802154_subif_frame()
before the flush runs, close this window?

Also, in the multi-interface case ieee802154_if_remove() only quiesces
the sdata being removed with synchronize_rcu(); does this fix actually
address the scenario the commit message describes, where MAC_CMD
traffic is arriving on a sibling interface of the same phy during
NL802154_CMD_DEL_INTERFACE?
