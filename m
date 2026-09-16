Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7B4CEE4E;
	Wed, 16 Sep 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580324; cv=none; b=ZsPkiq5aKpM/ZJ/BPfOrr0esQT9rdTOFZX0lGszyf+11wYpHP3+FS5s+FV/cRNMaQYrCgdHLlr2AULBAmME5OKEgvXtlt7KwsyrF5A/mOhvXv8n5tBwrh2tbcXpTqHf7LkFPKMISjh6HIOxtfZhWC05n8s3bv2uEHIoD+1Nj1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580324; c=relaxed/simple;
	bh=huuvDYYHx4dziZjSfHbT0AUGsvZFvUBJqk93qr3mpbA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B//lHPHoXLVtwZ+ZFIyG4meGBacKwlpl6oWXVVzEOktM+0VRQWNBpd4XIGiqVq5FNpQ0FnokFQveWGKiplf9AXhzEM/zD33xJ5fnltrO9agu2YHO/bLZjjSDIMeu96Xl7IH/zpp6a1JtKidpu4gx3nhAPMb7PTKUraKBiyMyS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo+n4HIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo+n4HIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72E21F000FF;
	Wed, 16 Sep 2026 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580310;
	bh=vruFXSNiZzTcRGVZVsS3u3NJkuqePVUQ0NhUeEs2RY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vo+n4HIFQCH/Qa2BWMIvwrWrS5r26RhT2ws+YF6RT7Wd+uj5Sv2n8POsTYRuQzvaT
	 KRCh2NnHmu6S4DoOdWdms2m7LANEkliYt7DRzYoc+eFogKdI+x1Cx7BdQHFP5fNXAi
	 2yoKffnnTLgCsg1tPaQJsYlIhKeEg0MjmQBZU3HXLEX+Qob0aSZX3l17CvW1tFSWFK
	 T82bPU9qBWeWTrVljlSMgoMYN1dWFC87cvOesp0gfYoGzU+eRFosO0BxNvyiy+NUib
	 WBx5zuCNAbtcJitN7jD0DeJJP2xPyctkJjk33P+ebSWsx21gH7tpwm27ovc3iyodf3
	 LjN3gr4CJgNEA==
Subject: Re: [PATCH ipsec v2] xfrm: fix races in device state cleanup
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 16 Sep 2026 17:38:29 +0000
Message-ID: <178958030946.22033.17018749865001469631@kernel.org>
In-Reply-To: <20260914133540.3666907-1-nicoyip.dev@gmail.com>
References: <20260914133540.3666907-1-nicoyip.dev@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

- [High] net/xfrm/xfrm_state.c, xfrm_dev_state_free(): the patch
  publishes `WRITE_ONCE(xso->dev, NULL)` (line 788) under…
- [Low] net/xfrm/xfrm_state.c, xfrm_dev_state_flush() line 1011: the new
  `&& xfrm_state_hold_rcu(x)` gate makes the deferred device-GC pass…

Pre-existing issues:
- [Medium] Split responsibility for validating xso->dev between core and
  driver: include/net/xfrm.h, xfrm_dev_state_update_stats() snapshots…

--

xfrm: fix races in device state cleanup

The patch makes the deferred device-GC pass in xfrm_dev_state_flush() take a
temporary xfrm_state reference while it still holds xfrm_state_dev_gc_lock,
and moves the xso->dev clearing and the dev_gclist unlink under that same
lock so only one caller claims the device cleanup. hlist_del() is replaced
by hlist_del_init() so the node is left unhashed.

A few questions below.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 36a4f6793edef..282d09d0c2475 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -780,17 +780,20 @@ EXPORT_SYMBOL_GPL(xfrm_dev_state_delete);
>  void xfrm_dev_state_free(struct xfrm_state *x)
>  {
>  	struct xfrm_dev_offload *xso = &x->xso;
> -	struct net_device *dev = READ_ONCE(xso->dev);
> +	struct net_device *dev;
>  
> +	spin_lock_bh(&xfrm_state_dev_gc_lock);
> +	dev = READ_ONCE(xso->dev);
>  	if (dev && dev->xfrmdev_ops) {
> -		spin_lock_bh(&xfrm_state_dev_gc_lock);
> +		WRITE_ONCE(xso->dev, NULL);

[Severity: High]
Can moving this clear ahead of the driver callback open a NULL dereference
window on the output path?

After this change xso->dev is published as NULL here, the lock is dropped,
and xso->type is only set to XFRM_DEV_OFFLOAD_UNSPECIFIED after
xdo_dev_state_free() returns.  For the whole duration of the callback a
lockless reader sees xso.type == XFRM_DEV_OFFLOAD_PACKET together with
xso.dev == NULL.

xfrm_output() picks the offload branch purely on the type:

net/xfrm/xfrm_output.c:xfrm_output() {
	...
	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
		if (!xfrm_dev_offload_ok(skb, x)) { ... }
	...
		if (x->props.mode == XFRM_MODE_TUNNEL && !skb->sk)
			return xfrm_dev_direct_output(sk, x, skb);
	...
}

and xfrm_dev_offload_ok() explicitly tolerates a NULL device:

net/xfrm/xfrm_device.c:xfrm_dev_offload_ok() {
	struct net_device *dev = x->xso.dev;
	...
	if ((!dev || dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
	...
ok:
	if (!dev)
		return true;
}

so a forwarded (skb->sk == NULL) tunnel-mode packet reaches:

net/xfrm/xfrm_output.c:xfrm_dev_direct_output() {
	skb->dev = x->xso.dev;
	__skb_push(skb, skb->dev->hard_header_len);
}

Before this patch xso->dev was cleared after the callback, one store before
xso->type, so the inconsistent state lasted a couple of instructions.  Now
it spans the driver callback, which can block for a long time, for example:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:mlx5e_xfrm_free_state() {
	if (sa_entry->work)
		cancel_work_sync(&sa_entry->work->work);

	if (sa_entry->dwork)
		cancel_delayed_work_sync(&sa_entry->dwork->dwork);

	mlx5e_accel_ipsec_fs_del_rule(sa_entry);
	mlx5_ipsec_free_sa_ctx(sa_entry);
}

The state can still be referenced by an xfrm_dst bundle while
xfrm_dev_state_flush() runs (ip link set <offload dev> down or device
unregister), so a packet can be inside xfrm_output() at that moment.  Would
it be safer to clear xso->type before, or together with, xso->dev under the
lock?

>  		if (!hlist_unhashed(&x->dev_gclist))
> -			hlist_del(&x->dev_gclist);
> -		spin_unlock_bh(&xfrm_state_dev_gc_lock);
> +			hlist_del_init(&x->dev_gclist);
> +	}
> +	spin_unlock_bh(&xfrm_state_dev_gc_lock);
>  
> +	if (dev && dev->xfrmdev_ops) {
>  		if (dev->xfrmdev_ops->xdo_dev_state_free)
>  			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);

[Severity: Medium]
This isn't a bug introduced by this patch, but the reordering above changes
which contexts can race with an unchecked re-read of x->xso.dev in the mlx5
stats callback.

The core snapshots and validates the device, then passes only x:

include/net/xfrm.h:xfrm_dev_state_update_stats() {
	struct net_device *dev = READ_ONCE(xdo->dev);

	if (dev && dev->xfrmdev_ops &&
	    dev->xfrmdev_ops->xdo_dev_state_update_stats)
		dev->xfrmdev_ops->xdo_dev_state_update_stats(x);
}

and the driver re-reads the field with no NULL check:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:mlx5e_xfrm_update_stats() {
	struct net *net = dev_net(x->xso.dev);

The clear in xfrm_dev_state_free() does not take x->lock and no stats reader
takes xfrm_state_dev_gc_lock, so a clear landing between the core check and
the driver re-read gives dev_net(NULL).

With this patch the clear now happens before xdo_dev_state_free(), which is
where mlx5e_xfrm_free_state() does cancel_delayed_work_sync() on the delayed
work that runs mlx5e_ipsec_handle_sw_limits() -> xfrm_state_check_expire()
-> xfrm_dev_state_update_stats().  Previously the clear only happened after
that work had been cancelled.

Should the callback receive the dev the core already validated, the way
xdo_dev_state_add/delete/free do, or should the driver NULL-check?

> -		WRITE_ONCE(xso->dev, NULL);
>  		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
>  		netdev_put(dev, &xso->dev_tracker);
>  	}
> @@ -1005,9 +1008,10 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
>  	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
>  		xso = &x->xso;
>  
> -		if (xso->dev == dev) {
> +		if (xso->dev == dev && xfrm_state_hold_rcu(x)) {

[Severity: Low]
Does this turn the deferred pass into a best-effort one?

When refcount_inc_not_zero() fails the entry is skipped with no cleanup, no
restart and no error, so xfrm_dev_state_flush() can return to
xfrm_dev_event() while the xso->dev_tracker netdev reference is still
outstanding.  The trailing xfrm_flush_gc() does not close that window,
because the state is only queued after the refcount already dropped to zero:

net/xfrm/xfrm_state.c:__xfrm_state_destroy() {
	spin_lock_bh(&xfrm_state_gc_lock);
	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
	spin_unlock_bh(&xfrm_state_gc_lock);
	schedule_work(&xfrm_state_gc_work);
}

net/xfrm/xfrm_state.c:xfrm_flush_gc() {
	flush_work(&xfrm_state_gc_work);
}

so flush_work() can observe the work as idle just before it is queued.

The same applies to a state claimed by another xfrm_dev_state_free() caller,
since the claim unlinks it from dev_gclist under the lock while the netdev
reference is only dropped after the callback returns.

To be clear, this does not look like the unregister hang that 07b87f9eea0c
addressed: a zero refcount means the destroy path is committed and
unconditionally reaches xfrm_dev_state_free() -> netdev_put() through the GC
worker, and netdev_wait_allrefs_any() polls with msleep() and rebroadcasts
NETDEV_UNREGISTER once a second, which re-runs xfrm_dev_state_flush().  So
the observable effect appears to be a bounded extra delay in device
unregistration in a rare interleaving.

Separately, since every successful claim does goto restart_gc from the list
head while skipped entries stay on the list, the walk re-scans them each
time.  Was an O(n^2) re-walk of the device GC list intended here?

>  			spin_unlock_bh(&xfrm_state_dev_gc_lock);
>  			xfrm_dev_state_free(x);
> +			xfrm_state_put(x);
>  			spin_lock_bh(&xfrm_state_dev_gc_lock);
>  			goto restart_gc;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914133540.3666907-1-nicoyip.dev%40gmail.com
