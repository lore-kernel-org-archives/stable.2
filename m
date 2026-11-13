Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528212;
	b=e1vYEwOV/ISAa8zj88q3qGS+cDxEKhn2b/xI4pa5HCetyG8YS7RBp+QJC5+Ww3uhyM9+
	 LF8PayEZHjqsMe9B85HWODrRjbjy0C9O6hWqn0w0gK5dUYZXCwKiz2NxyxJMGvOJNbea1
	 tvYbmFEI+xBbWtGF8mTHd8mB5NDZUqG1D/jDf0jjGQIrI06OeBdkFP/SAagygO2O+T8bl
	 mg5ldaR99g0Kt5NP11uv6XfQbEkeYGsI4jMCmpzFzbhWjNpgxONBqHs/K4dMOzYnTUFkV
	 z6JOFUH/EgSaqJ3Y2A5BrvscoTTduKy28ZEKu9cfeV2SLhAgat4jwzJOcDQkZ7n6R7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528212;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mD7pZSBd7EvZHJEFH4uAL2i4QQbvrCkQsbm2ULwufSI=;
	b=rCCKw86+fqQafii4Dpt1RHUJc85XDm6BLqf1phv0/zxtTG5jCm66mQNLhPYE40cgq6Fp
	 Lr/2tS6ilu2MzBb/ir0s7iqkpurRg3rC5nyR1I33TU8tKv0ejSmOs2xo3eaSRlLCoo5ld
	 GLXnHzMu/RpmFaJLO33CL3gHd12EBw4LOnUYpDwskdb6cXdlZm2mvUUtl0pLKdrouu99w
	 cebEBWN2n4O9v6vg0sM+0VQ4yAzUHFqjOSgsqikdtIV+zhyC93E1xSaH6j02zN4GZG8gh
	 QtATPiTsH7ve5Npb6rnpMEiYkrjOLyOrgUL+ZOhhAYkbVgc/ALth5hWQLcWGvj5TeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKnUUyyd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D8606A321;
	Fri, 13 Nov 2026 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKnUUyyd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC451F000C4;
	Fri, 13 Nov 2026 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794528211;
	bh=mD7pZSBd7EvZHJEFH4uAL2i4QQbvrCkQsbm2ULwufSI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lKnUUyydyueSLUDTINIjBGZO+7VYgYenYVCem5b8nts8ODqjuL/5sPwOWDPZKEJFk
	 TRLumq6fElvERg0T1zYfu3jL9HI6lktNoEpuceP9Gi9CU3bCPS+3adwnsKsyMz5VQx
	 3DfZJ2yKl0k21MXXYSRMYpo5Tmefr7tjFCKAMhskyNIgYcZbyuf1mXli89Xwyz6C/N
	 PuqHiZzQqHWSI4kBaxFu6L6BmntDXDzl0LEC1aiT0otwprrkjsOkwgsg3wD460AAH3
	 1Vezd4xpD5kKwz7R4F7h0atab0sN+XWKY+Olta5tTG+WqrW0zESBQsW9j3daJqhJB3
	 Qv0w3yF9zxsWw==
Subject:
 Re: [PATCH wpan] ieee802154: atusb: complete each transmitted frame only once
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: stefan@datenfreihafen.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 13 Nov 2026 00:03:30 +0000
Message-ID: <179452821058.2199510.6478538599475344430@kernel.org>
In-Reply-To: <20261110-atusb-tx-once-v1-1-43e2b92f2072@gmail.com>
References: <20261110-atusb-tx-once-v1-1-43e2b92f2072@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In atusb_xmit(), the new error-path clear does not close the
  double-free it is meant to close.
- [Medium] atusb_tx_done() takes the pending skb with xchg() (line 206)
  before it compares the reported seq with expect, and the seq-mismatch…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  atusb_tx_done() frees the pending skb on any device report, without…
- [High] This problem wasn't introduced by this patch, but
  atusb_disconnect() kills and frees tx_urb (lines 1080-1081) and never…
- [High] This problem wasn't introduced by this patch, but
  atusb_disconnect() calls usb_free_urb(atusb->tx_urb) (line 1081)…

--

ieee802154: atusb: complete each transmitted frame only once

This patch changes atusb_tx_done() to take the pending skb out of
atusb->tx_skb with xchg(), and to ignore completion reports when no
frame is pending. It also clears atusb->tx_skb in atusb_xmit() when
usb_submit_urb() fails, so no stale pointer is left after mac802154
frees the skb.

> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 5f7fc4ee7a071..2460eb19b72b1 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -195,21 +195,26 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  	u8 expect = atusb->tx_ack_seq;
> +	struct sk_buff *skb;
>  
>  	dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
> +
> +	/* The device may report a tx completion when no frame is pending,
> +	 * or more than once for the same frame.  Complete each frame only
> +	 * once.
> +	 */
> +	skb = xchg(&atusb->tx_skb, NULL);
> +	if (!skb)
> +		return;
> +

[Severity: Medium]
Is a duplicate report handled if it arrives after the next frame has
been queued? The pending skb is taken before seq is compared with
expect. A stale report therefore consumes whatever frame is pending
when it arrives.

Consider this sequence:

  report with seq N
    atusb_tx_done()
      ieee802154_xmit_complete(skbN)
        ieee802154_release_queue()

  atusb_xmit(skbN+1)
    atusb->tx_skb = skbN+1;
    atusb->tx_ack_seq++;          /* now N+1 */
    usb_submit_urb(atusb->tx_urb, GFP_ATOMIC)

  duplicate report with seq N
    atusb_tx_done()
      expect = N+1
      skb = xchg(&atusb->tx_skb, NULL);   /* skbN+1 */
      seq != expect
        ieee802154_xmit_hw_error(atusb->hw, skbN+1)

Here skbN+1 is freed with IEEE802154_SYSTEM_ERROR while its control URB
may still be using skbN+1->data. When the real report for N+1 arrives,
tx_skb is NULL, so that report is dropped.

The code before this patch also failed the pending frame on a seq
mismatch. The new comment, though, says duplicate reports for the same
frame are handled.

There is a related ordering problem. expect is read before the xchg(),
and atusb_xmit() writes tx_skb and tx_ack_seq with plain stores. A
report for N could read the stale expect == N, take skbN+1, and
complete it as a success.

Could the skb be consumed only when the reported seq matches the seq
recorded for that skb, checked atomically with the hand-off, and the
report ignored otherwise? Or could the comment be narrowed to match
what is actually handled?

>  	if (seq == expect) {
>  		/* TODO check for ifs handling in firmware */
>  		if (reason == IEEE802154_SUCCESS)
> -			ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> +			ieee802154_xmit_complete(atusb->hw, skb, false);
>  		else
> -			ieee802154_xmit_error(atusb->hw, atusb->tx_skb, reason);
> +			ieee802154_xmit_error(atusb->hw, skb, reason);

[Severity: High]
This is a pre-existing issue, but can the skb be freed here while the
control URB that carries skb->data is still in flight?

atusb_xmit() passes skb->data directly as the transfer buffer of
tx_urb. The URB completion handler records no state:

static void atusb_xmit_complete(struct urb *urb)
{
	dev_dbg(&urb->dev->dev, "atusb_xmit urb completed");
}

The seq check does not protect against this, because the device learns
the seq from wIndex of the control request. A device can ACK the SETUP
stage, NAK the control OUT data stage, and meanwhile send a 1-byte
report on the bulk-in endpoint:

  atusb_in() -> atusb_in_good() -> atusb_tx_done()
    -> ieee802154_xmit_complete() -> dev_consume_skb_any(skb)

The HCD still has skb->data mapped. When the device finally accepts the
data stage, it receives memory that has been freed and may have been
reallocated.

This completion also releases the mac802154 queue. The next
atusb_xmit() then rewrites atusb->tx_dr and the fields of the
still-active tx_urb in usb_fill_control_urb(). usb_submit_urb() hits
WARN_ONCE("URB %p submitted while active\n") and returns -EBUSY. When
the original URB completes, the HCD unmaps it using the overwritten
transfer_buffer_length.

Could skb ownership be tied to completion of the control URB? For
example, the frame could be completed only after both the URB
completion and the device report have been seen.

>  	} else {
> -		/* TODO I experience this case when atusb has a tx complete
> -		 * irq before probing, we should fix the firmware it's an
> -		 * unlikely case now that seq == expect is then true, but can
> -		 * happen and fail with a tx_skb = NULL;
> -		 */
> -		ieee802154_xmit_hw_error(atusb->hw, atusb->tx_skb);
> +		ieee802154_xmit_hw_error(atusb->hw, skb);
>  	}
>  }
>  
> @@ -351,6 +356,8 @@ static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>  			     (unsigned char *)&atusb->tx_dr, skb->data,
>  			     skb->len, atusb_xmit_complete, NULL);
>  	ret = usb_submit_urb(atusb->tx_urb, GFP_ATOMIC);
> +	if (ret)
> +		atusb->tx_skb = NULL;

[Severity: High]
Can the skb still be freed twice on this path? atusb_xmit() publishes
the skb with a plain store, before it reads skb->data and skb->len and
before it submits:

	atusb->tx_skb = skb;
	atusb->tx_ack_seq++;
	...
	usb_fill_control_urb(..., skb->data, skb->len, ...);

atusb_xmit() runs with only BH disabled. In the meantime,
atusb_tx_done() can run on another CPU from the bulk-in URB completion,
or from hardirq on HCDs that complete in IRQ context:

  CPU0                                CPU1
  atusb_xmit()
    atusb->tx_skb = skb;
                                      atusb_in_good()
                                        atusb_tx_done()
                                          xchg(&atusb->tx_skb, NULL)
                                          ieee802154_xmit_complete()
                                            dev_consume_skb_any(skb)
                                            atomic_dec_and_test(...)
    usb_fill_control_urb(..., skb->data, skb->len, ...)
    ret = usb_submit_urb(...);   /* fails */
    atusb->tx_skb = NULL;
    return ret;
  ieee802154_tx()
    err_wake_netif_queue:
      atomic_dec_and_test(&local->phy->ongoing_txs)
      kfree_skb(skb);

The error path cannot tell whether the driver still owns the skb or
atusb_tx_done() has already completed it. The result is a second
kfree_skb() of the same skb. ongoing_txs also underflows, after which
the wait_event() in ieee802154_sync_queue() never completes.

The device can force the submit to fail. It can report frame N early
while it NAKs the data stage of N's control transfer. Frame N+1 is then
sent while tx_urb->hcpriv is still set, and usb_submit_urb() returns
-EBUSY. An unplug can also make the submit fail with -ENODEV.

Even when the submit succeeds, usb_fill_control_urb() can read
skb->data and skb->len of an skb that is already freed. The URB is then
submitted with freed memory as its transfer buffer.

Would it work to read skb->data and skb->len before publishing, and on
failure do something like this?

	if (cmpxchg(&atusb->tx_skb, skb, NULL) != skb)
		return 0;

Or, more robustly, could publish and submit be serialized against
completion with an irqsave spinlock?

>  	dev_dbg(&usb_dev->dev, "%s done (%d)\n", __func__, ret);
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but atusb_disconnect() kills
and frees tx_urb without completing the skb still held in
atusb->tx_skb:

drivers/net/ieee802154/atusb.c:atusb_disconnect() {
	...
	usb_kill_anchored_urbs(&atusb->rx_urbs);
	atusb_free_urbs(atusb);
	usb_kill_urb(atusb->tx_urb);
	usb_free_urb(atusb->tx_urb);

	ieee802154_unregister_hw(atusb->hw);
	...
}

If a frame is pending when the device is unplugged, or the device never
sends its report, is the skb leaked and phy->ongoing_txs never
decremented?

This can also deadlock. ieee802154_mlme_tx() takes rtnl_lock() and then
waits in ieee802154_sync_queue() with no timeout:

	wait_event(local->phy->sync_txq, !atomic_read(&local->phy->ongoing_txs));

ieee802154_mlme_tx() is called from mac802154_transmit_beacon_req() and
mac802154_transmit_beacon(). If such a transmit is pending when the
device goes away, the waiter holds RTNL forever. atusb_disconnect() ->
ieee802154_unregister_hw() -> rtnl_lock() then blocks behind it.

Now that atusb_tx_done() uses xchg(), could disconnect complete the
pending frame after usb_kill_urb(atusb->tx_urb) and before
unregistering?

	skb = xchg(&atusb->tx_skb, NULL);
	if (skb)
		ieee802154_xmit_hw_error(atusb->hw, skb);

[Severity: High]
This is also a pre-existing issue. In the atusb_disconnect() sequence
above, usb_free_urb(atusb->tx_urb) runs before
ieee802154_unregister_hw().

The wpan interfaces stay registered until ieee802154_unregister_hw() ->
ieee802154_remove_interfaces() closes the netdevs under RTNL. Their TX
queues are awake whenever no frame is pending. Can a sender on another
CPU reach the freed URB in that window?

  ieee802154_subif_start_xmit()
    ieee802154_tx()
      drv_xmit_async()
        atusb_xmit()
          usb_fill_control_urb(atusb->tx_urb, ...)
          usb_submit_urb(atusb->tx_urb, GFP_ATOMIC)

atusb_xmit() does not check atusb->shutdown. This path would write into
a freed URB and then submit it. After a sysfs unbind the device is
still attached, so the freed URB could even reach the HCD.

Could tx_urb be freed only after ieee802154_unregister_hw()? Or could TX
be stopped before the URB is killed and freed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-atusb-tx-once-v1-1-43e2b92f2072%40gmail.com
