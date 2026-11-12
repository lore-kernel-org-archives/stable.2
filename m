Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457891;
	b=vloR/rdNThHaNbcjNdnvAsB3UvzfRxxzBWzS4FatXve8ZKW8R5E6rJ1NzBrQjhK4lN30
	 0wIgZNw4JxXwWIsCPKBrIenn+/DKYeVmauBeDPzr+dnqil25kUsvCyyv5aNkAVAVacDem
	 cb6wYhg8qBKFDyts0/wcpci17vUCR2IL84yFnP/zilxxskZOTGqDCBe4DOfch8gSphz62
	 8AcXk64R7N80WE5MJ3nRZLIXeGajl2JV9rtqgRMeRyFFEj/2dsu29KpL3TAA4ct8t58sL
	 JhNIyr1ZP8ci2CP6gc8QvYs4B7Bsy/2XaAo/vT2k7k3W3kXvfNFgpzPLtWp030qzpag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457891;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ewDQkyi302TW6WSeRV08GWmgo3FjljwrHal9OxzqK/0=;
	b=MwWoK/sCq8pbJhf2LHNL/0M1Fd+ySOMt64IlqzSUrTm/ZIfNJ+pTrY+MWiIL+Zp03V7m
	 xEeyctWe0gYUugxcGnIn8ZQYLqVGjO4BxoAkib2SO+j9pivy0Ti5Auot1V538ok4bDnTa
	 nHzBHb7kp6Sws9OY5PW9bnxb6GUAeolSyk2+ED7l6xSoPQ7QyTpQoAegbMGm5auAL5P3y
	 5mcn+ucx/XkUEa9T2mcI2SgGl8l/LWWD1avrOLaJjbgfPARNkRbSFuJTBI8ltZSfxJwXZ
	 hpTzIoRi6mxenFVF0O4gfsQOh9w/tbMXH/4y+zod3cWvxXTSO0gmQAuNVqIMqZUPHbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRzl8FhK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB84606A32E;
	Thu, 12 Nov 2026 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRzl8FhK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64EC1F00A05;
	Thu, 12 Nov 2026 04:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457891;
	bh=ewDQkyi302TW6WSeRV08GWmgo3FjljwrHal9OxzqK/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZRzl8FhKA1apZMK9+2RxDRRzxQ+PGis7fLpNSLp49YLYMy1JjffLK5WBnjWKDUdsy
	 3xZW+qkGBRm1om1tjxXQWUYEXPfN7kjvsIZ1A/aETSBXy7uyD+i2OmV7YPJkWgs9WN
	 eiwUer4ABxovj0XBPvqhUBbR+w80yN84Bkd4qpk5hEBwsfCEJbU/vTIO3IPHA1vkm2
	 tf2vIp9rAune4VbrCSXiKunlVH11AcAZJKXXN+bDlDZ+UpbBhUGYo7YqvBrrZRIISE
	 4BXI0prC1WStkj/P085ahCPql7/7lB/m77JtwhMa+5qaFpCugaMmsuZWtcCmjVO7Q6
	 LMPRSQws2cdpw==
Subject: Re: [PATCH net] net: usb: rtl8150: fix rx tasklet use-after-free on
 disconnect
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com
Date: Thu, 12 Nov 2026 04:31:30 +0000
Message-ID: <179445789040.2199510.7426210198945271595@kernel.org>
In-Reply-To: <20261110043016.56986-1-mhun512@gmail.com>
References: <20261110043016.56986-1-mhun512@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch's new tasklet_kill() calls in rtl8150_disconnect()
  cannot reliably stop rx_fixup() when it keeps rescheduling itself, and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the stale
  dev->rx_skb pointer can lead to a double free or a device DMA into…
- [High] This problem wasn't introduced by this patch, but pegasus.c, the
  driver rtl8150 was derived from, has the same late-completion tasklet…

--

net: usb: rtl8150: fix rx tasklet use-after-free on disconnect

This adds a second tasklet_kill() in rtl8150_disconnect(), placed after
unlink_all_urbs(). It is meant to drain an RX tasklet that a late
read_bulk_callback() could have scheduled after the first kill, before the
driver data is freed.

> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index d51e43170e033..98c36c3779564 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -971,6 +971,8 @@ static void rtl8150_disconnect(struct usb_interface *intf)
>  		tasklet_kill(&dev->tl);
>  		unregister_netdev(dev->netdev);
>  		unlink_all_urbs(dev);
> +		/* A completion may have scheduled it after the first kill. */
> +		tasklet_kill(&dev->tl);

[Severity: Medium]
Can this tasklet_kill() actually end the rx_fixup() reschedule loop that the
commit message describes?

The commit message says "disabled endpoints make RX resubmissions fail, so
rx_fixup() can keep rescheduling itself". It then says "tasklet_kill()
drains any late tasklet and prevents self-rescheduling".

rtl8150_driver has no soft_unbind, so usb_unbind_interface() disables the
endpoints before calling ->disconnect(). The device is still attached, so
usb_submit_urb() passes its -ENODEV check. usb_hcd_link_urb_to_ep() then
returns -ENOENT, or -EPERM while usb_kill_urb() is in progress:

drivers/usb/core/hcd.c:usb_hcd_link_urb_to_ep() {
    ...
	if (unlikely(!urb->ep->enabled)) {
		rc = -ENOENT;
		goto done;
	}
    ...
}

In rx_fixup(), -ENODEV is the only error that skips the reschedule, and
nothing checks RTL8150_UNPLUG:

drivers/net/usb/rtl8150.c:rx_fixup() {
    ...
try_again:
	status = usb_submit_urb(dev->rx_urb, GFP_ATOMIC);
	if (status == -ENODEV) {
		netif_device_detach(dev->netdev);
	} else if (status) {
		set_bit(RX_URB_FAIL, &dev->flags);
		goto tlsched;
	}
    ...
tlsched:
	tasklet_schedule(&dev->tl);
}

tasklet_kill() only returns once the waiter sets TASKLET_STATE_SCHED
itself:

	wait_on_bit_lock(&t->state, TASKLET_STATE_SCHED, TASK_UNINTERRUPTIBLE);

tasklet_action_common() clears TASKLET_STATE_SCHED and wakes the waiter
just before it calls t->callback(t). rx_fixup() then sets the bit again
before it returns. All of this runs in non-preemptible softirq context.

On a CONFIG_SMP=n non-RT kernel, or when the waiter runs on the same CPU as
the tasklet, process context would only ever see TASKLET_STATE_SCHED set.
Wouldn't rtl8150_disconnect() then sleep in TASK_UNINTERRUPTIBLE forever
while ksoftirqd keeps running rx_fixup()?

The first tasklet_kill() already had this limitation. The new call relies
on the same assumption to close the use-after-free.

For tasklet_kill() to be reliable here, would rx_fixup() and the resched
path in read_bulk_callback() need to stop resubmitting and rescheduling
once RTL8150_UNPLUG is set?

>  		free_all_urbs(dev);
>  		free_skb_pool(dev);
>  		dev_kfree_skb(dev->rx_skb);

[Severity: High]
This is a pre-existing issue, but can dev->rx_skb still be stale when it is
freed here?

read_bulk_callback() passes dev->rx_skb to the stack, and if the pool is
empty it leaves the pointer unchanged:

	netif_rx(dev->rx_skb);
	...
	skb = pull_skb(dev);
	spin_unlock_irqrestore(&dev->rx_pool_lock, flags);
	if (!skb)
		goto resched;

	dev->rx_skb = skb;

The pool has only RX_SKB_POOL_SIZE (4) entries, and only rx_fixup() refills
it. rx_fixup() is also the only place that replaces the pointer. If every
GFP_ATOMIC allocation in fill_skb_pool() fails, it just reschedules:

	skb = pull_skb(dev);
	spin_unlock_irq(&dev->rx_pool_lock);
	if (skb == NULL)
		goto tlsched;
	dev->rx_skb = skb;

Suppose rtl8150_disconnect() runs in that state. The tasklet_kill() calls
stop the loop but leave the pointer as it is. Would dev_kfree_skb(dev->rx_skb)
then double free an skb that the network stack already consumed?

Something similar looks possible across close and open. rtl8150_close()
does not kill the tasklet or clear rx_skb. rtl8150_open() then reuses a
non-NULL rx_skb as the bulk-in buffer:

	if (dev->rx_skb == NULL)
		dev->rx_skb = pull_skb(dev);
	...
	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);

Could the device then DMA packet data into freed memory?

[Severity: High]
This isn't a bug introduced by this patch, but pegasus.c, which rtl8150 was
derived from, seems to have the same late-completion tasklet problem. This
patch doesn't change it.

In pegasus read_bulk_callback(), when the resubmit fails, rx_tl is scheduled
without checking PEGASUS_UNPLUG again:

	else if (rx_status) {
		pegasus->flags |= PEGASUS_RX_URB_FAIL;
		goto tl_sched;
	}
	...
tl_sched:
	tasklet_schedule(&pegasus->rx_tl);

During unbind the endpoints are already disabled, so the resubmit fails with
-ENOENT. It fails with -EPERM once usb_kill_urb() has set urb->reject.

The only tasklet_kill() is in pegasus_close(), and it runs before the URBs
are killed:

	tasklet_kill(&pegasus->rx_tl);
	unlink_all_urbs(pegasus);

pegasus_disconnect() then goes from unlink_all_urbs() to free_netdev()
without draining the tasklet:

	unregister_netdev(pegasus->net);
	unlink_all_urbs(pegasus);
	free_all_urbs(pegasus);
	...
	free_netdev(pegasus->net);

Consider a completion that passes the netif_running() check before
__dev_close_many() clears __LINK_STATE_START. If it reaches
tasklet_schedule() after the tasklet_kill() in pegasus_close(), rx_tl is
left pending with no later kill.

rx_fixup() returns early on PEGASUS_UNPLUG, so there is no endless loop.
It still reads pegasus->flags, though, and tasklet_action_common() touches
the tasklet_struct inside netdev_priv(). Could either of those run after
free_netdev()?

Does pegasus_disconnect() need a tasklet_kill(&pegasus->rx_tl) after
unlink_all_urbs() too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110043016.56986-1-mhun512%40gmail.com
