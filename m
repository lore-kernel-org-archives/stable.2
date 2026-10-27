Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086649;
	b=m+dggUvxOL4sVMu1yOwHEQyCAc7gZWE0xK/pULmakhCt79iAK30qlrBp47XSxYvaNwXD
	 TvCXFe1KZci/Gbil8uXgdSsY3wV3RBfzrZIXTNvLSSumqKTWEKWneXaGnhva4P5/JYfyR
	 RDuEIjNMYhPftIrTs6k4oM8w2V3g2cgw9v9F4qhjFLEzyWQjmfrfS1ogjSHTA1ZskbIW2
	 3By7CwgVS+yv2HT/9jROQ9f3kRLkwAwIsdbRxi1qtFz1Yk/7JaDztZRg3sDMhRDI07JzY
	 7KXiqaBiJgIpz06TRUcTrc5F86nq/UoRaesYTUqvan5Iei9JLYfspw5+YW3jmoAUkFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086649;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XazMYHQ4YDq84ivlXp0m0RYPuCcD0RTYnpWVm+WmuqI=;
	b=tpTMDBvREV1FHKb6aPV8iYhlaR/jPlpmum9+dn1++YHC80Pjf0QFXDxXrKidc1O8J5uE
	 kQ68QtNx4liCw7jwIojpIuiQWF/W6m5ukjy4uI6PIlgt+AhK0jcxLh1JzgK6l3BXn/XVD
	 Z2TCPuq2guZicvr4rbebtLnxeDllyM/4xKEQBKGRAcx9oXtlQHYcdh/ceyVvPeUf9m+Gr
	 KrOAwjGle8g35gjiHQYrMCpV03vSNVgztakBZPLo8dak68z+kexZMEnSMeY9a4IPQcbKs
	 OWq2lj0j8iNQh72RNH/W/9gF124xq/GPQTzh8pSCl37Qq7PJw4jaLweYAdS8hwPwF+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtObGSZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AF606AD9C;
	Tue, 27 Oct 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtObGSZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F61F01829;
	Tue, 27 Oct 2026 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793086648;
	bh=XazMYHQ4YDq84ivlXp0m0RYPuCcD0RTYnpWVm+WmuqI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UtObGSZvh4LPf0hFqvcRwEE1iA0l2y1Tp0dFCkGqH7Nn6GL7krK1XQ2BzY9VkSazt
	 uj37l3qDLRwaN3bbFLPUvRYfAUs3y6Ucmwl1B2xAUhO5S4ZuZ2+8DdbG7LRYEsdRfB
	 aL6pX6ToIQGSadrThkdt4grBXB00691yl7LG/OFOjLcayEbWwtdES8K1r6zoxFmgWF
	 c95uHDC76TzVnRqztMKsSmjTX+8yWgNUSsJoGPaXRDPe6k58hlg6yXuEZPrtqA9+2V
	 pULix4JICYRapeadyFN8nctO4dIMnKAQKl803oNnHXsksYCx0iGMl2eaV/OZAcA/d0
	 938Ho2cZJ95wA==
Subject: Re: [PATCH 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
 before register_candev()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 27 Oct 2026 07:37:27 +0000
Message-ID: <179308664758.3130.9049840508592700660@kernel.org>
In-Reply-To: <20261025-gs_usb-fixes-v1-2-f74ebbd4da36@pengutronix.de>
References: <20261025-gs_usb-fixes-v1-2-f74ebbd4da36@pengutronix.de>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a memory leak to the gs_usb_probe() error path
  in drivers/net/can/usb/gs_usb.c.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the
  gs_usb_probe() register-failure path keeps an existing use-after-free.

--

can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()

This patch moves register_candev() out of gs_make_candev() and into a
second loop in gs_usb_probe(). Every channel, including dev->parent and
parent->hf_size_rx, is now fully set up before any channel is registered.
This closes the window where userspace could bring up a partially
initialized CAN interface.

Closes: https://sashiko.dev/#/bug/linux-be54de7d-0b75-408c-b3ee-dd90c9756857
Closes: https://sashiko.dev/#/bug/linux-71076d59-0843-4749-a5ab-fdd98a08582f

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 15f28833f2deb..985d6a9113d96 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1490,18 +1490,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>  	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
>  	SET_NETDEV_DEV(netdev, &intf->dev);
>  
> -	rc = register_candev(dev->netdev);
> -	if (rc) {
> -		dev_err(&intf->dev,
> -			"Couldn't register candev for channel %d (%pe)\n",
> -			channel, ERR_PTR(rc));
> -		goto out_can_rx_offload_del;
> -	}
> -
>  	return dev;
>  
> -out_can_rx_offload_del:
> -	can_rx_offload_del(&dev->offload);
>  out_free_candev:
>  	free_candev(dev->netdev);
>  	return ERR_PTR(rc);
> @@ -1593,14 +1583,14 @@ static int gs_usb_probe(struct usb_interface *intf,
>  			/* save error code to return later */
>  			rc = PTR_ERR(parent->canch[i]);
>  
> -			/* on failure destroy previously created candevs */
> +			/* on failure clean up previously created candevs */
>  			icount = i;
> -			for (i = 0; i < icount; i++)
> -				gs_destroy_candev(parent->canch[i]);
> +			for (i = 0; i < icount; i++) {
> +				can_rx_offload_del(&parent->canch[i]->offload);
> +				free_candev(parent->canch[i]->netdev);
> +			}
>  
> -			usb_kill_anchored_urbs(&parent->rx_submitted);
> -			kfree(parent);
> -			return rc;
> +			goto out_usb_kill_anchored_urbs;
>  		}
>  		parent->canch[i]->parent = parent;
>  

[ ... ]

> @@ -1621,7 +1611,30 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
>  	}
>  
> +	for (i = 0; i < icount; i++) {
> +		struct gs_can *dev = parent->canch[i];
> +
> +		rc = register_candev(dev->netdev);
> +		if (rc) {
> +			dev_err(&intf->dev,
> +				"Couldn't register candev for channel %d (%pe)\n",
> +				i, ERR_PTR(rc));
> +
> +			icount = i;
> +			for (i = 0; i < icount; i++)
> +				gs_destroy_candev(parent->canch[i]);

[Severity: High]
Does this leak the candevs for channel i and every channel after it?

The second loop only runs after the first loop has called gs_make_candev()
for all channels. At that point every canch[] entry holds an allocated
netdev with rx-offload attached.

When register_candev() fails for channel i, only canch[0..i-1] go through
gs_destroy_candev(). Channels canch[i] through canch[channel_cnt - 1] never
get can_rx_offload_del() or free_candev().

The kfree(parent) at out_usb_kill_anchored_urbs then frees canch[], which
held the only pointers to those netdevs.

Before this patch, gs_make_candev() cleaned up its own channel when
register_candev() failed, and no later channels had been allocated yet.

The USB device can trigger this. register_candev() returns -EINVAL when
can_bittiming_const_valid() fails:

drivers/net/can/dev/dev.c:can_bittiming_const_valid() {
    ...
	if (!btc->sjw_max)
		return false;
    ...
}

gs_make_candev() copies sjw_max straight from the device's
GS_USB_BREQ_BT_CONST reply. A device that reports sjw_max == 0 for channel
0 would leak every channel on each probe.

Should this error path also run can_rx_offload_del() and free_candev() on
channels i through channel_cnt - 1, the same teardown the first loop's
error path uses?

> +
> +			goto out_usb_kill_anchored_urbs;
> +		}
> +	}
> +
>  	return 0;
> +
> +out_usb_kill_anchored_urbs:
> +	usb_kill_anchored_urbs(&parent->rx_submitted);
> +	kfree(parent);
> +
> +	return rc;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this teardown order
cause a use-after-free in gs_usb_receive_bulk_callback()?

The old gs_make_candev() failure path had the same pattern. Registered
channels 0..i-1 are destroyed one at a time, and gs_destroy_candev() frees
each netdev right after unregistering it. The freed pointers stay in
parent->canch[].

The shared RX URBs are only killed when the last active channel closes:

gs_can_close() {
    ...
	parent->active_channels--;
	if (!parent->active_channels) {
		usb_kill_anchored_urbs(&parent->rx_submitted);
    ...
}

The only other place they are killed is out_usb_kill_anchored_urbs, which
runs after the whole destroy loop.

Suppose userspace has already brought up canch[0] and canch[1] when
register_candev() fails for a later channel. Unregistering canch[0] closes
it, but active_channels is still 1, so the RX URBs keep running after
canch[0] is freed.

If the device then sends a frame with hf->channel == 0, the callback
dereferences the freed entry:

gs_usb_receive_bulk_callback() {
    ...
	dev = parent->canch[hf->channel];

	netdev = dev->netdev;
	stats = &netdev->stats;

	if (!netif_device_present(netdev))
    ...
}

A frame with an out-of-range channel id goes to the device_detach label
instead. That code calls netif_device_detach() on every non-NULL canch[]
entry, which writes to the state field of the freed netdev.

The window is shorter now that no USB control messages run between
registrations, but the ordering is the same. gs_usb_disconnect() is not
affected, because usb_unbind_interface() disables the interface before it
calls disconnect.

Would it help to unregister all the registered channels first, so the last
close stops the shared RX URBs, and only then free them?

>  
>  static void gs_usb_disconnect(struct usb_interface *intf)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025-gs_usb-fixes-v1-0-f74ebbd4da36%40pengutronix.de
