Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427692;
	b=4mFbm0j0f4RaehQ0UURtDtWKcFePNTjoEleeMny4iY+dS/1BwVtMOeB03PjLKBqPEu7z
	 IkwupQMsdbHwBaNuRGh4YcKkf576XrZ2WAjhqHq1xbIG1ZJpHPx8hgAvyNzWbxNfDD7xj
	 H5FQCVP3i5U4QAR13lZj87qCpztm4Pj+JmA73opxpQUldD1qk2ADkhb84lduBW77EHhSu
	 f8vp0lTYQa6ahWjCqzSifVzlk/MkU9WSL2MBHVOWxqGNPlNNfoLbyu1nylYQhfG3s7Tkz
	 QBIv0hm51LprXlChB6ZaOYMziiw3UCIWFx2xCvwPaGVPTspTG7MuJLMKji41UDaHC+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427692;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uewvvfPkIA+JpYak7yGl+BQUnFOTsnZsmgulW20Qso8=;
	b=wmEzYPltmeZ/d9/+58D1/HmVjtS/qLeLliyKBc9MsQz88Ej4u3IYS5b+dJ56ASxHXbNW
	 8m/HNxpC2qErVK3oxGhnEPNbwn6CpN/AECnMX6gVAZ7QbcwFHCXn2fYwq616GABLlyyP8
	 UOnllxfh1zN4Lc/C2o9/txa+jTNDGniH3EV/naCMXp3pgVJHiaZbrc3q81H0VaukhI3+T
	 r4Hs4s2Jzi4VnwzFCC1q7jgj39K9v6Ov5vAVoI5GQsdElDYB5cs3zBPDX0Y1TDcXOtXbn
	 7++forXLD8QuHkZ65TsurJ1M9ESDNgZFKSOhuvYc/bvqiymnzRn4YBzLvXuukH+S+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqR8N2xn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915E606A31A;
	Mon, 23 Nov 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqR8N2xn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD41F000D3;
	Mon, 23 Nov 2026 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795427691;
	bh=uewvvfPkIA+JpYak7yGl+BQUnFOTsnZsmgulW20Qso8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JqR8N2xnakYmvNLLnBbqqKKQTfDZxqyYHU3kVBTbuE6H42WbC0qCs9dlDvjpSZ1Ib
	 WraRrMIbFAlDVl5Z4xfDhRQyop3tKkO65sbxUR+i30t9XiSePk+Cct0RDrupKcRjpX
	 CuVyZQwBjaMbvVqf1eSeylzyBpisC/BHjFMO/0Ilv0CqKWIcq6dLBj3fsB8G+FlBYe
	 U2E4YkxtUM1kAALWo6sQUyo/Cf6C0SP3q4O0Rgj5D9/hnwRQxRtvmGZIabFianNCaC
	 hoKd4d6c5zqLm795+6DxxB9gpysoRH88sbAUD+fAJAdY/7V9a83iiQ4cM0Vb2obYgu
	 e22i8MapKYIbw==
Subject: Re: [PATCH net v4] mctp i2c: fix double free of midev on netdev
 register failure
From: netdev-bot+sashiko@kernel.org
To: kenny_hsieh@jabil.com
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 09:54:50 +0000
Message-ID: <179542769062.3135.9147379725438179456@kernel.org>
In-Reply-To: <20261119094307.3864679-1-kenny_hsieh@jabil.com>
References: <20261119094307.3864679-1-kenny_hsieh@jabil.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mctp_i2c_tx_purge() (drivers/net/mctp/mctp-i2c.c:812-822) does
  not keep the embedded unlock marker away from kfree_skb(), which the…
- [Medium] mctp i2c: running tx_thread in mctp_i2c_ndo_uninit() can re-
  select mcli->sel
- [Low] Two comments in the patched code now contradict each other about
  the bus lock.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sibling
  driver mctp-i3c has the reverse version of the same ndo_uninit…
- [Medium] This problem wasn't introduced by this patch, but
  mctp_register_netdevice() (net/mctp/device.c) leaks the mctp_dev.

--

mctp i2c: fix double free of midev on netdev register failure

After this patch, mctp_i2c_ndo_uninit() no longer frees midev. midev is
now freed only in the add_netdev() error path and in
mctp_i2c_unregister(), and ndo_uninit only detaches midev from the
client's sel and purges tx_queue, keeping the embedded unlock marker out
of the purge. The tx thread now releases the i2c bus lock itself before
it exits.

Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/

> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bbf..29a186f714d1a 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
> @@ -628,8 +628,11 @@ static int mctp_i2c_tx_thread(void *data)
>  	unsigned long flags;
>  
>  	for (;;) {
> -		if (kthread_should_stop())
> +		if (kthread_should_stop()) {
> +			/* Only the rt_mutex owner may release the bus lock */
> +			mctp_i2c_unlock_reset(midev);
>  			break;
> +		}
>  
>  		spin_lock_irqsave(&midev->tx_queue.lock, flags);
>  		skb = __skb_dequeue(&midev->tx_queue);
> @@ -782,11 +785,46 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,

[ ... ]

> +/* The unlock marker is embedded in midev, so keep it from kfree_skb() */
> +static void mctp_i2c_tx_purge(struct mctp_i2c_dev *midev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&midev->tx_queue.lock, flags);
> +	if (midev->unlock_marker.next)
> +		__skb_unlink(&midev->unlock_marker, &midev->tx_queue);
> +	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
> +
> +	skb_queue_purge(&midev->tx_queue);
> +}

[Severity: High]
The commit message says the marker "must not reach kfree_skb() through
the purge". Can it still get there?

The marker is unlinked under tx_queue.lock. The lock is then dropped,
and skb_queue_purge() takes it again to splice the queue:

net/core/skbuff.c:skb_queue_purge_reason() {
    ...
	spin_lock_irqsave(&list->lock, flags);
	skb_queue_splice_init(list, &tmp);
	spin_unlock_irqrestore(&list->lock, flags);

	__skb_queue_purge_reason(&tmp, reason);
}

In that gap, mctp_i2c_release_flow() can run on another CPU. It sees the
unlock_marker.next == NULL state that __skb_unlink() just left and
queues the marker again:

mctp_i2c_release_flow() {
    ...
		spin_lock(&midev->tx_queue.lock);
		if (!midev->unlock_marker.next)
			__skb_queue_tail(&midev->tx_queue,
					 &midev->unlock_marker);
		spin_unlock(&midev->tx_queue.lock);
    ...
}

This looks reachable from mctp_i2c_ndo_uninit(). It runs inside
unregister_netdevice() after NETDEV_UNREGISTER and before the netdev
refcount wait.

At that point MCTP keys can still hold the mctp_dev. They are released
without RTNL: by the key expiry timer through __mctp_key_remove(), by
socket close, or through mctp_key_unref(). Each of these calls
mctp_dev_release_key()->ops->release_flow().

mdev->ops is not cleared on unregister. The tx thread has already been
stopped by mctp_i2c_unregister(), so nothing else dequeues the marker in
this window.

The marker lives in netdev_priv and is never initialised, so its
skb->users is 0. kfree_skb()->skb_unref() would then hit a refcount_t
underflow / use-after-free warning, which panics with panic_on_warn.

Would it work to unlink the marker and splice the queue onto a local
list under a single tx_queue.lock hold, and then purge the local list? A
later re-queue would be harmless: the purge in mctp_i2c_midev_free()
runs after unregister_netdev() has waited for all references.

[ ... ]

> @@ -797,17 +835,9 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
>  	mctp_i2c_unlock_reset(midev);

[Severity: Low]
This isn't a bug, but is this mctp_i2c_unlock_reset() call still needed?
In mctp_i2c_midev_free() it reads:

	/* Unconditionally unlock on close */
	mctp_i2c_unlock_reset(midev);

Both callers have stopped the tx thread before this point. The thread's
only exit is the new kthread_should_stop() branch, which already resets
i2c_lock_count. Nothing outside the tx thread increments i2c_lock_count,
so this call never does anything.

If it ever did fire, it would release the rt_mutex from a non-owner
context. The new "Only the rt_mutex owner may release the bus lock"
comment in mctp_i2c_tx_thread() rules that out.

Could the call and the "Unconditionally unlock on close" comment be
removed, or replaced with a WARN that the count is already zero?

>  
>  	/* Remove the netdev from the parent i2c client. */

[ ... ]

> @@ -837,11 +872,11 @@ static void mctp_i2c_ndo_uninit(struct net_device *dev)
>  {
>  	struct mctp_i2c_dev *midev = netdev_priv(dev);
>  
> -	/* Perform cleanup here to ensure that mcli->sel isn't holding
> -	 * a reference that would prevent unregister_netdevice()
> -	 * from completing.
> +	/* Drop sel's reference and queued skbs before unregister waits
> +	 * for the last netdev reference. midev is freed elsewhere.
>  	 */
> -	mctp_i2c_midev_free(midev);
> +	mctp_i2c_midev_detach(midev);
> +	mctp_i2c_tx_purge(midev);
>  }

[Severity: Medium]
Can the tx thread put midev back into mcli->sel after this detach has
run?

The old ndo_uninit went through mctp_i2c_midev_free(), which stopped
midev->tx_thread before touching sel. The new one leaves the tx thread
running. That is fine on the mctp_i2c_unregister() path, which calls
kthread_stop() first, but not on the register failure path this patch
is fixing.

mctp_i2c_midev_init() wakes the tx thread before mctp_i2c_add_netdev()
calls mctp_register_netdev(). If a NETDEV_REGISTER notifier fails after
a packet has been queued, register_netdevice() unwinds through
unregister_netdevice_queue(), which calls mctp_i2c_ndo_uninit(). The
rtnl_unlock() in mctp_register_netdev() then runs netdev_run_todo() and
waits for the last reference in netdev_wait_allrefs_any().

If the tx thread dequeued an skb just before mctp_i2c_tx_purge() ran,
it carries on into mctp_i2c_xmit(), which selects the device without
checking whether midev is still attached:

mctp_i2c_xmit() {
    ...
	case MCTP_I2C_TX_FLOW_NONE:
		/* no flow: full lock & unlock */
		mctp_i2c_lock_nest(midev);
		mctp_i2c_device_select(midev->client, midev);
    ...
}

The MCTP_I2C_TX_FLOW_NEW case does the same.

mctp_i2c_device_select() sets mcli->sel = midev and takes
dev_hold(midev->ndev), although midev is no longer on mcli->devs. With
list_empty(&midev->list) now true, every later mctp_i2c_midev_detach()
returns early and never drops that reference. netdev_wait_allrefs_any()
then waits forever, and mctp_i2c_add_netdev() never gets to the error
path that would call mctp_i2c_midev_free().

Would it work to stop the tx thread in mctp_i2c_ndo_uninit() before the
detach, as the old code effectively did? mctp_i2c_midev_free() already
skips kthread_stop() when tx_thread is NULL, and the tx thread now
releases the bus lock itself on exit. Or should mctp_i2c_device_select()
refuse to select a midev that has already been removed from mcli->devs?

[Severity: High]
This isn't a bug introduced by this patch, but mctp-i3c seems to have
the reverse form of the same ndo_uninit mismatch:

drivers/net/mctp/mctp-i3c.c:mctp_i3c_bus_add() {
    ...
	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_I3C);
	if (rc < 0) {
		dev_warn(&ndev->dev, "netdev register failed: %d\n", rc);
		goto err_free_netdev;
	}
    ...
}

This skips mctp_i3c_bus_free() because it assumes mctp_i3c_ndo_uninit()
already ran. That isn't true for early failures:

- mctp_add_dev() can fail before register_netdevice() is called.
- register_netdevice() can fail in dev_get_valid_name(), for example
  with -EEXIST, since the name is a fixed "mctpi3c<id>".
- register_netdevice() can fail when allocating the name node.

The register_netdevice() failures take "goto out" and never reach
ndo_uninit.

In those cases mbus stays on the global busdevs list, and the tx thread
started by kthread_run() keeps sleeping on mbus->tx_wq. Meanwhile
free_netdev() frees the netdev, and mbus with it.

Can the tx thread, or later walks of busdevs in
mctp_i3c_bus_remove_all() and mctp_i3c_bus_add_new(), then use freed
memory?

The approach this patch takes for mctp-i2c might fit mctp-i3c as well:
the error path always frees, and the uninit work is safe to repeat.

[Severity: Medium]
This is a pre-existing issue, and this patch neither claims to fix it nor
relies on it. Does mctp_register_netdevice() leak the mctp_dev when
register_netdevice() fails?

net/mctp/device.c:mctp_register_netdevice() {
	...
	mdev = mctp_add_dev(dev);
	if (IS_ERR(mdev))
		return PTR_ERR(mdev);

	mdev->ops = ops;
	mdev->binding = binding;

	return register_netdevice(dev);
}

mctp_add_dev() allocates the mdev, sets refs to 1, takes dev_hold(dev)
and publishes dev->mctp_ptr. Only the NETDEV_UNREGISTER notifier
(mctp_unregister()->mctp_dev_put()) frees it. register_netdevice() only
reaches that notifier when a NETDEV_REGISTER notifier fails.

None of the other failure paths free it. These are dev_get_valid_name(),
name node allocation, netdev_check_ops, pcpu stats, dev_index_reserve,
NETDEV_POST_INIT and kobject registration. At most they send
NETDEV_PRE_UNINIT, which mctp doesn't handle.

The driver's free_netdev() then frees the netdev, and the mdev and its
untracked netdev hold are leaked. With CONFIG_NET_DEV_REFCNT_TRACKER,
could this also trigger a ref_tracker warning at free_netdev()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119094307.3864679-1-kenny_hsieh%40jabil.com
