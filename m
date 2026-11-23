Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435224;
	b=Tz3jAd1yKO85GlTixxj+NuOGWzah6T22MIzlHhLeMXLsXKbneLniywk1hJ5f0kEXpVjx
	 VLcMBY4xetJTYww0f91tdyxX/ju7mk+TX0AlfvPSeELHmKP2oBTS58sdV6umkwv2DTMbr
	 MoeyXgVP3cRVRgJvIjkhcuE182cWxxgMVX4f0EM9oeSDJ4RalQ3y/dyzXY06D21OYU7fg
	 oG3S4o7t3aMGEzY7pd+udXejEBLNZfLvpYSi3aWoa18n6HvTUTfnHA1dEjEeaE7oyAhJc
	 T6SihEIZ48ghfGUZHsoimsEbfxqtRx3lzn//ZrmBg6d2az9FkNHSBGvnHLwinrUauUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435224;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3gcpq/J0YYuK6PvfJzkzuLL/NDzkyJbMUIThLtA9Ve0=;
	b=bq5zSxiJhwMv1aPY8FzzwiKu1iCeV9IawT5Yu2JWoaB7Av4lIL/IruGz33KTqPteWSa0
	 Sr2bVy/MRQ6C1krFH3G/o2fU9OrSjYbOvVRh+vNQ5ecs53KW4I2rT8Ir64+vJEsX8fZJn
	 jqP6zlN4tU2Y6jZVv2UlhgANsQgy80e5tE5XNM4IRcYOkH3mSEz2TxI2+qJYFYrWQc4Qq
	 ISpL9uhjwLKi3XmzF+86FrvK3DKrqiyXSxFUoTuRuh35TZSk0zFwbj4UWDTjAwESRKfWj
	 RvftpICOCxyl14Rv2T7b2Eq7agvF1HarOkau1MNnsqesTaigWrXfkpnemS0HbdbVSNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9Y3VKWv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D3606A31A;
	Mon, 23 Nov 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9Y3VKWv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1011F000C0;
	Mon, 23 Nov 2026 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435223;
	bh=3gcpq/J0YYuK6PvfJzkzuLL/NDzkyJbMUIThLtA9Ve0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O9Y3VKWvj61K2GVnnhqlv1oiGK94re4F5BXCcenvjRxa5GmPk7NJzWTnxHoM04An8
	 zxa+xzLk3wy4FGESLipB7ksUAu0Y1gL6mm2aO6eLK/iRTuEkx6DG2/hVoTAW9drim5
	 HGIEv3D4PC+CZGbtrPxaRP5SBLMiygxpZ7UocJPr6fAL50wLDxJSKBc7s6MfwoIXLj
	 Knt7dmZvqn/5RjQaPqebJpLvvNLc+UtEUS3GR3v2j82LX3nj0q45fOiX5MmvAtrn8o
	 /o/QPmsDvHRr1gM8XYq7fd1tcUfqp2mBieLUbRdXDD/oRNj0EFHghzlCmoCqG+vIn1
	 BkHAkZEIT9ISA==
Subject: Re: [PATCH can-next v9 05/13] can: gs_usb: fix hardware timestamp
 state for mixed channels
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:22 +0000
Message-ID: <179543522241.3131.6628219369362226414@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-5-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-5-db121d488945@pengutronix.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/can/usb/gs_usb.c, gs_can_open() has an
  unbalanced brace in the new gs_usb_timestamp_start() error handling,…

--

can: gs_usb: fix hardware timestamp state for mixed channels

The HW timestamp infrastructure is now set up in gs_usb_probe() when any
channel advertises GS_CAN_FEATURE_HW_TIMESTAMP. Initial time sync and the
scheduling of the delayed worker move into a new gs_usb_timestamp_start(),
which runs when the first channel is opened. Shutdown is keyed off a new
per-parent flag instead of the feature bits of the last channel closed.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 470dd52d97dfe..30bcb734c5df8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -990,9 +1030,19 @@ static int gs_can_open(struct net_device *netdev)
>  
>  	can_rx_offload_enable(&dev->offload);
>  
> +	/* rely on RTNL to serialize concurrent ifup/ifdown */
> +	ASSERT_RTNL();
> +
>  	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_init(parent);
> +		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
> +			rc = gs_usb_timestamp_start(parent);
> +			if (rc) {
> +				if (rc == -ENODEV) {
                                                   ^

[Severity: Medium]
Is there a stray opening brace here? Nothing closes it, so the two closing
braces below end the -ENODEV block and the if (rc) block. The
if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) block is left open.

Every later closing brace in gs_can_open() is then off by one. The
function's final brace after the out_can_rx_offload_disable label no
longer ends gs_can_open(), so the next definition is parsed as a nested
function:

    static int gs_usb_get_state(const struct net_device *netdev,

That doesn't compile, so drivers/net/can/usb/gs_usb.c can't be built at
this commit and bisection through it breaks.

The goto out_can_rx_offload_disable also ends up inside the -ENODEV block.
The commit message says a failed initial timestamp read should make the
open fail. The usb_submit_urb() error handling in the RX URB loop follows
that pattern, detaching only on -ENODEV but always taking the goto:

    rc = usb_submit_urb(urb, GFP_KERNEL);
    if (rc) {
        if (rc == -ENODEV)
            netif_device_detach(dev->netdev);
        ...
        goto out_usb_unanchor_urb;
    }

Should this be if (rc == -ENODEV) without the brace?

The next patch in the series, "can: gs_usb: add support for context
analysis", removes this brace, but that patch isn't tagged for stable.
This patch has Cc: stable@vger.kernel.org. Would backporting it on its
own give stable trees a driver that doesn't build?

> +					netif_device_detach(netdev);
> +
> +				goto out_can_rx_offload_disable;
> +			}
> +		}
>  
>  		for (i = 0; i < GS_MAX_RX_URBS; i++) {
>  			u8 *buf;

[ ... ]

> @@ -1107,10 +1157,10 @@ static int gs_can_open(struct net_device *netdev)
>  	if (!parent->active_channels) {
>  		usb_kill_anchored_urbs(&parent->rx_submitted);
>  
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP)
>  			gs_usb_timestamp_stop(parent);
>  	}
> -
> +out_can_rx_offload_disable:
>  	can_rx_offload_disable(&dev->offload);
>  	close_candev(netdev);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
