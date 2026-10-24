Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814334;
	b=Dow+X7tPfqvg7GFzuTFo5SaC4SmLpaZO7ltJqpzEtdwnh8CBAu7MQ8BNo1nAIDyYdW5W
	 zPIJK0+BGv47hQDZCeiRBHOk20DMsSon9Vpsq6h1FoaCTPwN68sfMnpvOOSICXmY74OUA
	 XaTWsois3D/Hl8UwNQNjPRXnGOUF13odbnii9dphaprCToHFHx8nNUQIyrP4Z1xHWKe3B
	 GqfXd59i193S7SiLTjG4ZctIjAgKsCXJCAlQyDWH5pszJ2sL6A3DxmO8rEZRdD6kjjYul
	 Fe/Fqi1iiUE0fPgd7x7IgBptJyve6XrHUWrtyEBFEGd20ArAB9QNIP2ua4RglMFu0Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814334;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Clro7WDG4KT0INDinVZ33ttbuJ91LAtBbiQ6xrtq6IM=;
	b=ZXIneLBvQxNrcAlGJcSb6nlaUYiskC8E9Vmx9eUHoi/Hc3oqF6lV8LUDho5W/i7ILv+Z
	 ffom2GI+z7In5GLKkODtnrdkF3YBmrEDapJ6FtWjw8p4pd9PwICyeZLtVX6yKpi4ADeuq
	 TV6mVHvfNE8WPFMUzH5SWJ6MyDiTrK+lw3itbhFl9mBRMFZEkefG7mG5t2IhbUTQ9V3fD
	 J8QVFjUaN4GmNQfHR9eaJUn31t7hrmOh1j/uHHE9g0fJyKDEeJSYBJKVmC3uwIbgQ6cqw
	 V9jgD+qxMMRF9V3A/TK++Qgp1AEQSl4zmAk7+04E245WJXyLl1rCQbHE94JPp50vlkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GrqCY1/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A842606A329;
	Sat, 24 Oct 2026 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrqCY1/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EA51F01825;
	Sat, 24 Oct 2026 03:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814334;
	bh=Clro7WDG4KT0INDinVZ33ttbuJ91LAtBbiQ6xrtq6IM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GrqCY1/YWHEs78RmUkXM0yLQiFkrTMIOm+XbsCFshZgqvBrkgSeVv5jDlIDhUV6vW
	 /r5BU7oDz/Y8gC/DwyFsdy6xzOXECzoTj6LpVhHNv7NW5uVkPO6yfrBoxVtchiZVfs
	 z7jYC1YRq5KcbTgJ6Fm7SQ9zQDrPWU7iU4fq4iTrdtknsrd+6pbY2OI4BldFLNbYV5
	 C3y9OZGcSRKs+gPrwQYYmdE/5bknI4zXeaKdryIpw4Xd3h+YpO2km4ULw3iUB1SGjl
	 Yfbfr2zs9SOhOpvx9KvYcDk6HWP1nFhX64Xy0EmF6stBVT7KjKAqWbGTFUNynvL+Cp
	 p9bXFrw0Y74Xg==
Subject: Re: [PATCH v6 08/13] can: peak_usb: reject records for unset channels
 in PCAN-USB Pro
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 24 Oct 2026 03:58:53 +0000
Message-ID: <179281433330.3130.2295013111859378415@kernel.org>
In-Reply-To:
 <20261022-canfd_check_channel_idx-v6-8-197704231551@peak-system.fr>
References:
 <20261022-canfd_check_channel_idx-v6-8-197704231551@peak-system.fr>
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

- [Medium] In pcan_usb_pro_decode_buf(), a record for a channel whose
  usb_if->dev[] slot is NULL now makes…

Pre-existing issues:
- [High] Use-after-free in the probe error path of peak_usb_create_dev().
- [High] NULL pointer dereference when a channel is opened before
  dev_init().

--

can: peak_usb: reject records for unset channels in PCAN-USB Pro

This commit makes the PCAN-USB Pro record decoders reject a record when
the channel's usb_if->dev[] slot is still NULL. It also clears the slot in
pcan_usb_pro_free(). Slots are now published with smp_store_release() and
read with READ_ONCE().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index cbc23953ce610..151c5ea2859be 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -543,7 +543,12 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
>  	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;
>  
> -	dev = usb_if->dev[ctrl_idx];
> +	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
> +
> +	/* reject records for a channel that is not (or no longer) set up */
> +	if (!dev)
> +		return -EINVAL;

[Severity: Medium]
Should an empty slot be treated as an error here? The commit message
describes this as an expected window: channel 0's RX is running before
channel 1 has been initialized.

A negative return makes pcan_usb_pro_decode_buf() jump to fail and stop
parsing the URB:

pcan_usb_pro_decode_buf() {
    ...
		case PCAN_USBPRO_RXRTR:
			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
			if (err < 0)
				goto fail;
    ...
fail:
	if (err)
		pcan_dump_mem("received msg",
			      urb->transfer_buffer, urb->actual_length);
}

Both channels share the same bulk-in endpoint. Wouldn't that drop every
record that follows the channel 1 record in the same transfer? That
includes channel 0 CAN frames, channel 0 status records and RXTS
calibration records.

The non-zero return also makes peak_usb_read_bulk_callback() dump the
buffer a second time:

			err = dev->adapter->dev_decode_buf(dev, urb);
			if (err)
				pcan_dump_mem("received usb message",
					      urb->transfer_buffer,
					      urb->transfer_buffer_length);

Neither dump is rate limited, and both run from URB completion context.

Would it work better to skip just this record and go on to the next one?
The same applies to the -EINVAL return added to
pcan_usb_pro_handle_error().

Two later commits in the series seem to resolve this.

"can: peak_usb: register the netdevs only once all channels are set up"
makes this branch unreachable while RX is running.

"can: peak_usb: dump undecodable URBs once and rate limit decode errors"
removes the dump in pcan_usb_pro_decode_buf() and rate limits the one in
the callback.

At this commit, though, the window is still there.

[ ... ]

> @@ -933,7 +943,8 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
>  	}
>  
>  	pdev->usb_if = usb_if;
> -	usb_if->dev[dev->ctrl_idx] = dev;
> +	/* publish dev to the decoders */
> +	smp_store_release(&usb_if->dev[dev->ctrl_idx], dev);

[Severity: High]
This is a pre-existing issue, but pdev->usb_if is only assigned here,
after the netdev has already been registered. In peak_usb_create_dev():

	set_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
	...
	err = register_candev(netdev);
	...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);

pcan_usb_pro_init() also issues several synchronous USB requests on
channel 0 before it gets to this assignment.

If canX is configured and opened in that window, can
peak_usb_ndo_open()->...->pcan_usb_pro_start() dereference a NULL usb_if?

	if (pdev->usb_if->dev_opened_count == 0) {

RX completions in the same window would also reach
pcan_usb_pro_decode_buf() with a NULL usb_if. The handlers do
READ_ONCE(usb_if->dev[ctrl_idx]) before the new check, so the added NULL
check on dev does not cover this case.

The later commit "can: peak_usb: register the netdevs only once all
channels are set up" seems to fix this. It registers the netdevs in
peak_usb_probe() only after every channel's dev_init() and dev_set_bus()
have succeeded, and its commit message names this dereference.

> @@ -981,6 +992,9 @@ static void pcan_usb_pro_exit(struct peak_usb_device *dev)
>   */
>  static void pcan_usb_pro_free(struct peak_usb_device *dev)
>  {
> +	/* clear this channel's slot: dev is going to be freed */
> +	WRITE_ONCE(pcan_usb_pro_dev_if(dev)->dev[dev->ctrl_idx], NULL);
> +
>  	/* last device: can free pcan_usb_pro_interface object now */
>  	if (!dev->prev_siblings && !dev->next_siblings)
>  		kfree(pcan_usb_pro_dev_if(dev));

[Severity: High]
This isn't a bug introduced by this patch, but can this kfree() cause a
use-after-free on the probe error path in peak_usb_create_dev()?

adap_dev_free:
	peak_usb_stop_rx(dev->prev_siblings);

	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);

For channel 0, dev->prev_siblings is NULL, so no RX gets stopped. Then
pcan_usb_pro_free() frees the shared pcan_usb_pro_interface before the
netdev is unregistered.

Suppose can0 was opened between register_candev() and a failing
dev_set_bus(dev, 0). unregister_candev()->...->pcan_usb_pro_stop() would
then read and decrement dev_opened_count in freed memory:

	if (pdev->usb_if->dev_opened_count == 1)
		pcan_usb_pro_set_ts(dev, 0);

	pdev->usb_if->dev_opened_count--;

Channel 0's own RX URBs were never poisoned, so they could also complete
into pcan_usb_pro_decode_buf() with the freed usb_if.

The WRITE_ONCE() added here runs before the kfree(), so it is fine by
itself. The later commit "can: peak_usb: register the netdevs only once
all channels are set up" removes register_candev() from
peak_usb_create_dev(), and its commit message names this use-after-free.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-canfd_check_channel_idx-v6-0-197704231551%40peak-system.fr
