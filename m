Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795342117;
	b=U5H/Brhcisu9L5UUPkMrDhJ1bu29QnH+a98nEkakQoARSibaauLQJoPZ3o4+M1YTPtMk
	 KZW3E5Yk+bD6tA6CjUAqtDN0iqrCp5rsChddxZA4PECG1NV99pWf3WUqsKXU7i2XjFUuO
	 1TmnIxizdtpUbYzH700U25fHCWVceHrG5YPtF78naLJKyp02+K5MRqAjc2oWROkg56S+P
	 mqcaYV/Ftw/WF8NCGpWAQRcGY17PQN4bo+uP/Oggqt7qKBZap+Xsx1EgcRTPXiEzA92mN
	 bCB3En4WwaGZnMAdImJUYHSFAhwQ3ypJOGSMla8LLK8NqaoTKDsgYWTHH8DAMJuSbHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342117;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KhZvViciytwGLSje7vvILIzm+0pXs3Dr46ub9cFA0qU=;
	b=3rSwFZeQW42TImQIIyYf2dVjWdZoDTJA5Og9RqnZWPyQRA+zfZPpvVuWcmaTzolelX5k
	 FfzJn0a5CUCHA3FQEjaSRa+KwRcSNTPcvBcZ5AOhHWx3CVLoy4tE/gkq5JCBqbxeG795G
	 NB4n5pFCMbrWxNXsxZ44hLw+SfYzbZAEvM8rkEZx2oLFV1Sg5noC7vpZy22KM1ue3HCWM
	 fdq7mBhC6zWpNaTgFB8p469Ff863AH5KKAcsDYwfdTu4QGWcWYUlClTPMZsviCDgDP33W
	 GGUbZ0w+nztT40FN5XnDUFtEynqlAT/ntl+CqoHVSDX3Ff40bwgJa47giAR5ZCNjB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jMkZ8u/U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A0606A320;
	Sun, 22 Nov 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMkZ8u/U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1281F000C4;
	Sun, 22 Nov 2026 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795342117;
	bh=KhZvViciytwGLSje7vvILIzm+0pXs3Dr46ub9cFA0qU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jMkZ8u/UrOkpWfwKjHIu7aslnRsyUenWoaG6BDrECHs8PmrgerhArb+s/X7shAVQ1
	 47BE9MmFEQ90cjniA/AmGqafGdp1K1BM95R4b43mGukZKEu9cbsj9kIeop1TmfLjoX
	 CEa3rZKbnCDdulvKANG4ELqBTafZwSM9M20uY9IF6G4z5XcL1RxmzG/qNTEE87q1Ai
	 T3YbXBaaPz4jvPgSrV9HhRvm3LTYz++82Ats9lmnNsLNZ+wFTdwrS30pLe3xSjL5UR
	 fAQY8HmY1EUl8CAHeKeWl1qXCCsSH7xFzA3S5xHbpICen3F3gTE6F/VfwFKd0NblXD
	 679/Wy4NtUPhg==
Subject: Re: [PATCH net v3] mctp i2c: fix double free of midev on netdev
 register failure
From: netdev-bot+sashiko@kernel.org
To: kenny_hsieh@jabil.com
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 22 Nov 2026 10:08:36 +0000
Message-ID: <179534211612.3135.16240214184359507035@kernel.org>
In-Reply-To: <20261118090515.3390034-1-kenny_hsieh@jabil.com>
References: <20261118090515.3390034-1-kenny_hsieh@jabil.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mctp_i2c_tx_purge() (drivers/net/mctp/mctp-i2c.c:814-824) is
  meant to keep the embedded midev->unlock_marker away from kfree_skb(),…
- [Low] After this patch, mctp_i2c_midev_free()
  (drivers/net/mctp/mctp-i2c.c:848-849) still has "/* Unconditionally…
- [Low] The new comment in mctp_i2c_unregister()
  (drivers/net/mctp/mctp-i2c.c:874-877) says the explicit…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sibling
  driver mctp-i3c has the teardown-ownership flaw in the opposite…

--

mctp i2c: fix double free of midev on netdev register failure

This patch stops mctp_i2c_ndo_uninit() from freeing midev. midev is now
freed only in the add_netdev() error path and in mctp_i2c_unregister().
ndo_uninit only detaches midev from mcli->sel and purges tx_queue
(skipping the embedded unlock marker), and the tx thread releases the
bus rt_mutex itself before exiting.

Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/

> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bbf..a3d0cae41e131 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c

[ ... ]

> @@ -782,11 +785,60 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,

[ ... ]

> +/* Drops queued skbs, keeping the embedded unlock marker from kfree_skb() */
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
Can the unlock marker still reach kfree_skb() here? The marker is
unlinked in one tx_queue.lock section, and then skb_queue_purge() takes
the lock again separately.

The unlink leaves unlock_marker.next == NULL. Between the two critical
sections, mctp_i2c_release_flow() can queue the marker again:

drivers/net/mctp/mctp-i2c.c:mctp_i2c_release_flow() {
    ...
		spin_lock(&midev->tx_queue.lock);
		if (!midev->unlock_marker.next)
			__skb_queue_tail(&midev->tx_queue,
					 &midev->unlock_marker);
		spin_unlock(&midev->tx_queue.lock);
    ...
}

One possible sequence during device teardown:

CPU0
mctp_i2c_unregister()
  mctp_unregister_netdev()
    unregister_netdevice_many_notify()
      mctp_i2c_ndo_uninit()
        mctp_i2c_tx_purge()
          __skb_unlink(&midev->unlock_marker, &midev->tx_queue)
          spin_unlock_irqrestore(&midev->tx_queue.lock, flags)

CPU1 (or softirq on CPU0 after the irqrestore)
mctp_sk_expire_keys()
  __mctp_key_remove()
    mctp_dev_release_key()
      mctp_i2c_release_flow()
        __skb_queue_tail(&midev->tx_queue, &midev->unlock_marker)

CPU0
          skb_queue_purge(&midev->tx_queue)
            skb_queue_purge_reason()
              kfree_skb_reason(&midev->unlock_marker)

ndo_uninit runs before netdev_wait_allrefs(). At this point flow keys
can still hold a mctp_dev reference, and mdev->ops is never cleared.

Keys can also be released by socket close, by route input through
__mctp_key_done_in(), or by a final mctp_key_unref(). None of these
hold RTNL. The tx thread has already been stopped, so nothing else
drains the queue.

The marker is embedded in netdev_priv and its users count is 0. A
kfree_skb() on it would trigger the refcount_t underflow warning in
skb_unref().

The commit message says the marker "must not reach kfree_skb() through
the purge". Could this be done in a single critical section instead?
For example, splice tx_queue into a local list and unlink the marker
from it under one tx_queue.lock hold, or skip the marker while purging.

> +
> +/* Runs inside unregister, after dev_close() and before the refcount wait,
> + * including when register_netdevice() fails at NETDEV_REGISTER. Both steps
> + * can repeat, so mctp_i2c_midev_free() still frees midev exactly once.
> + */
> +static void mctp_i2c_ndo_uninit(struct net_device *dev)
> +{
> +	struct mctp_i2c_dev *midev = netdev_priv(dev);
> +
> +	mctp_i2c_midev_detach(midev);
> +	mctp_i2c_tx_purge(midev);
> +}
> +
>  /* Counterpart of mctp_i2c_midev_init */
>  static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
>  {
>  	struct mctp_i2c_client *mcli = midev->client;
> -	unsigned long flags;
>  
>  	if (midev->tx_thread) {
>  		kthread_stop(midev->tx_thread);
> @@ -797,17 +849,9 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
>  	mctp_i2c_unlock_reset(midev);

[Severity: Low]
This isn't a bug, but is this call still needed? The existing comment
just above it reads "Unconditionally unlock on close". The new comment
in mctp_i2c_tx_thread() says:

	/* Only the rt_mutex owner may release the bus lock */

mctp_i2c_lock_nest() is only reached from mctp_i2c_xmit() in the tx
thread, and the tx thread now resets i2c_lock_count itself when it
stops. So by the time mctp_i2c_midev_free() gets here, i2c_lock_count
should always be 0, and this call does nothing.

Could it be dropped, or replaced with something like
WARN_ON(midev->i2c_lock_count), so it doesn't contradict the new
owner-only rule?

>  
>  	/* Remove the netdev from the parent i2c client. */

[ ... ]

> @@ -827,23 +871,17 @@ static void mctp_i2c_unregister(struct mctp_i2c_dev *midev)
>  	spin_unlock_irqrestore(&midev->lock, flags);
>  	wait_for_completion(&midev->rx_done);
>  
> +	/* Release sel's reference on the netdev, otherwise
> +	 * mctp_unregister_netdev() blocks waiting for it.
> +	 */
> +	mctp_i2c_midev_detach(midev);
> +

[Severity: Low]
Is this comment accurate? mctp_i2c_ndo_uninit() also calls
mctp_i2c_midev_detach(). unregister_netdevice_many_notify() calls
ndo_uninit before net_set_todo(), and the refcount wait in
netdev_wait_allrefs() only happens later, from netdev_run_todo() at
rtnl_unlock() time.

So mctp_unregister_netdev() would not block on sel's reference even
without this early detach.

If the early detach exists for some other reason, such as moving sel to
a sibling midev before unregister starts, could the comment say that
instead?

>  	mctp_unregister_netdev(midev->ndev);
> -	/* midev has been freed now by mctp_i2c_ndo_uninit callback */
> +	mctp_i2c_midev_free(midev);
>  
>  	free_netdev(midev->ndev);
>  }
>  
> -static void mctp_i2c_ndo_uninit(struct net_device *dev)
> -{
> -	struct mctp_i2c_dev *midev = netdev_priv(dev);
> -
> -	/* Perform cleanup here to ensure that mcli->sel isn't holding
> -	 * a reference that would prevent unregister_netdevice()
> -	 * from completing.
> -	 */
> -	mctp_i2c_midev_free(midev);
> -}

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
mctp-i3c has the same ndo_uninit ownership problem, but in the opposite
direction.

mctp_i3c_ndo_uninit() does the full mctp_i3c_bus_free(), and
mctp_i3c_bus_add() skips mctp_i3c_bus_free() when registration fails:

drivers/net/mctp/mctp-i3c.c:mctp_i3c_bus_add() {
    ...
	list_add(&mbus->list, &busdevs);
    ...
	mbus->tx_thread = kthread_run(mctp_i3c_tx_thread, mbus,
				      "%s/tx", ndev->name);
    ...
	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_I3C);
	if (rc < 0) {
		dev_warn(&ndev->dev, "netdev register failed: %d\n", rc);
		goto err_free_netdev;
	}
    ...
}

register_netdevice() can return before it reaches its err_uninit label,
in which case ndo_uninit is never called. Two cases:

- dev_get_valid_name() fails, for example with -EEXIST when a netdev
  named mctpi3c<id> already exists.
- netdev_name_node_head_alloc() fails.

free_netdev() then sees NETREG_UNINITIALIZED and calls kvfree() on the
netdev, which contains mbus.

Does this leave a freed mbus on busdevs? That list is later walked by
mctp_i3c_bus_add_new(), mctp_i3c_notify_bus_remove() and
mctp_i3c_bus_remove_all(). And would mbus->tx_thread keep running on
the freed mbus->tx_wq?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118090515.3390034-1-kenny_hsieh%40jabil.com
