Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814333;
	b=Rp2Jfc6qOKe1l2BSnfp+irvF2BLFrD3ClzXAcFF0kiJl9+eSbOTpsYz1ouDwcq4W+vel
	 0MSNGdG1aMIdYJEJpNxonSk7u/V/rgbiuKl2kM25Zqz5/xKvvfki5BpQN85+DZajBX++g
	 M3XpnLv6uQSXCaICAY/PVx3lg7OZWXbHB3v5cU1/1HHNRcSyimvDFkZB2Ol0kUH7wibkU
	 Y1JhR/AOh55vVJOF5ZB81/dtjDfWDd4dfLuio56eRdY3z0QKk1aIB/n2qicpBkIiGJyVW
	 e1O/Fer1V1RE1VcEUvCHz/bgW6nrqouGlRsbJv82eIW/nwxr1M+SR0AaXuf+AJ/LU2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814333;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3mTgRnLhsdY5CnedtJDb77nGg3hZqBLMMhQMdL5jNng=;
	b=5t5K8zWLqL/SWfsNb/Suy4JfJetuD7i0fDo5iDhy6SOX6Z2iedv233HV2e7wefU0QYVv
	 4mypQqPBgrVACxiOpGIhHu33DGyzCWF3BYKtGDRGCiGkbpFExDJIJcDxOOr8b9vpthKNw
	 aAal2t12NXVXTAEF/0HnWWRrXEKFPVHtanFdM+1LePuoNIILuhTGFL8MUH6LFZ3hRdAxU
	 T48+oItEGFIzDhITDGaoT72sCWNSGeW8staTlol67V0y8DLOVr/53BB+yQMgct497Wc8Q
	 TX8WyI7kQmNbGk8P1wzooVQhl0H4/UT7jpatS0VXEQt7ZdyIP62D40YisiykT3DHAew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMjtceFh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B76606A31F;
	Sat, 24 Oct 2026 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMjtceFh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A151B1F01828;
	Sat, 24 Oct 2026 03:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814333;
	bh=3mTgRnLhsdY5CnedtJDb77nGg3hZqBLMMhQMdL5jNng=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GMjtceFhWIHzpL70r7B6WTxMSgJO96WAImetMBrYZ6oRQhpNPH10ZuK/8Y8fXIHiD
	 7HRQFnBInJVfDau1Q5XMaPnePcvW9ILzvf3m0PAyYYwWpK55oWJfar1C1/zdrXclQs
	 M2FgdHOnNiUnjjw6oxyCCWKNMEeRaHC1/auQNvtD6H2MfNSpOD/orLj4pFVfeBUH3a
	 NX/huSIru/R6c8yAbWA1wUnwgg4tsvOvcGT66cNWCUuXqrERvQWNt6CQtk/tMTOIG8
	 MRqd1CqVC1hb4vX4zZj2snFdC+qFD8xY1dLg6HRj5ipu7+UqLDL0VO6AiT3yf2XYMR
	 4WZjpNPKgOuig==
Subject:
 Re: [PATCH v6 06/13] can: peak_usb: harden channel handling in PCAN-USB FD
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 24 Oct 2026 03:58:52 +0000
Message-ID: <179281433224.3130.6010222623227756144@kernel.org>
In-Reply-To:
 <20261022-canfd_check_channel_idx-v6-6-197704231551@peak-system.fr>
References:
 <20261022-canfd_check_channel_idx-v6-6-197704231551@peak-system.fr>
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

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The probe-error cleanup in peak_usb_create_dev() (adap_dev_free
  label) calls peak_usb_stop_rx(dev->prev_siblings).

Pre-existing issues:
- [Medium] PCAN-USB Pro has the same NULL channel-slot bug that this
  patch fixes for PCAN-USB FD.
- [Medium] When peak_usb_disconnect() runs from the probe-error path,
  peak_usb_stop_rx() clears PCAN_USB_STATE_CONNECTED on all siblings…

--

can: peak_usb: harden channel handling in PCAN-USB FD

The PCAN-USB FD decoders now check the channel number against the
adapter's controller count, and they drop records for a channel whose
usb_if->dev[] slot is NULL. The slot is cleared in pcan_usb_fd_free().
A new helper, peak_usb_stop_rx(), clears CONNECTED under RTNL and poisons
the RX anchors. It is called from the probe error path and from
peak_usb_disconnect().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index a1b17e1e6fea6..49d2c01b8ef7e 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

[ ... ]

> @@ -1014,6 +1041,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>  	return 0;
>  
>  adap_dev_free:
> +	/* the whole interface is released when probing a channel fails:
> +	 * stop RX on the channels already created, since their RX URBs may
> +	 * carry records for this one.
> +	 */
> +	peak_usb_stop_rx(dev->prev_siblings);

[Severity: High]
Should this also stop RX on dev, and not only on its previous siblings?
The comment above peak_usb_stop_rx() says it stops "dev and on all its
previous siblings", but this call skips the channel that is failing.

At this commit, peak_usb_create_dev() calls register_candev() before
dev_init() and dev_set_bus(). So userspace may already have opened the
failing channel, and its RX URBs may be in flight, when
dev_set_bus(dev, 0) fails.

On a single-channel PCAN-USB FD, dev->prev_siblings is NULL, so nothing
gets stopped. The error path then runs:

peak_usb_create_dev()
    dev->adapter->dev_free(dev)
        pcan_usb_fd_free()
            kfree(pdev->cmd_buffer_addr);
            kfree(pdev->usb_if);
    unregister_candev(netdev)
        peak_usb_ndo_stop()
            dev->adapter->dev_stop(dev)
                pcan_usb_fd_stop()
                    pdev->usb_if->dev_opened_count--;

Can the RX completions of this channel, and then pcan_usb_fd_stop(), use
usb_if and the command buffer after they have been freed here?

The later patch in this series, "can: peak_usb: register the netdevs only
once all channels are set up", seems to close this window. It moves
register_candev() into peak_usb_probe(), after all channels have been
created. At this commit, though, the window is still open.

>  	if (dev->adapter->dev_free)
>  		dev->adapter->dev_free(dev);
>  

[ ... ]

> @@ -1038,13 +1071,14 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  	struct peak_usb_device *dev;
>  	struct peak_usb_device *dev_prev_siblings;
>  
> -	/* unregister as many netdev devices as siblings */
> +	/* stop RX on all channels before unregistering and freeing them */
> +	peak_usb_stop_rx(usb_get_intfdata(intf));
> +
>  	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {
>  		struct net_device *netdev = dev->netdev;
>  		char name[IFNAMSIZ];
>  
>  		dev_prev_siblings = dev->prev_siblings;
> -		clear_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
>  		strscpy(name, netdev->name, IFNAMSIZ);
>  
>  		unregister_candev(netdev);

[Severity: Medium]
This is a pre-existing issue, but when peak_usb_disconnect() is called
from the probe error path, the device is still attached and its interface
has not been disabled.

peak_usb_stop_rx() clears PCAN_USB_STATE_CONNECTED on every channel before
any unregister_candev() runs. For a channel that is already up,
unregister_candev() then calls:

peak_usb_ndo_stop()
    dev->adapter->dev_stop(dev)
    dev->adapter->dev_set_bus(dev, 0)
        pcan_usb_fd_send_cmd()

and pcan_usb_fd_send_cmd() starts with:

	/* usb device unregistered? */
	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return 0;

After a failed probe, is the CAN controller left bus-on, while
peak_usb_ndo_stop() treats the bus-off command as successful?

The old loop already cleared CONNECTED just before each
unregister_candev(), so these commands were dropped before this patch
too. The patch now clears it on all channels at once.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 15d275d6a1277..eee5b5eaa247d 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[ ... ]

> @@ -536,10 +537,16 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
>  	struct sk_buff *skb;
>  	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
>  
> -	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware */
> +	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
> +		return -EINVAL;
> +
> +	dev = READ_ONCE(usb_if->dev[pucan_msg_get_channel(rm)]);
> +
> +	/* reject records for a channel that is not (or no longer) set up */
> +	if (!dev)
> +		return -EINVAL;
>  
> -	dev = usb_if->dev[pucan_msg_get_channel(rm)];
>  	netdev = dev->netdev;

[Severity: Medium]
This isn't a bug introduced by this patch, but the PCAN-USB Pro decoders
look like they have the same problem that this patch fixes for PCAN-USB
FD.

In pcan_usb_pro.c, pcan_usb_pro_handle_canmsg() and
pcan_usb_pro_handle_error() check ctrl_idx only against the table size,
then dereference the slot:

	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
		return -EINVAL;

	dev = usb_if->dev[ctrl_idx];
	netdev = dev->netdev;

The channels share the bulk-in endpoint, so channel 0's RX URBs could
carry a channel 1 record before pcan_usb_pro_init() has filled
usb_if->dev[1]. Can that lead to a NULL pointer dereference in URB
completion context? At this commit, register_candev() runs before
dev_init() in peak_usb_create_dev(), so channel 0 can already be open at
that point.

Unlike the new pcan_usb_fd_free(), pcan_usb_pro_free() also leaves
usb_if->dev[dev->ctrl_idx] set when the channel is freed.

The commit message does not mention PCAN-USB Pro. Two later patches in
this series appear to fix this: "can: peak_usb: reject records for unset
channels in PCAN-USB Pro" and "can: peak_usb: register the netdevs only
once all channels are set up".

>  
>  	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-canfd_check_channel_idx-v6-0-197704231551%40peak-system.fr
