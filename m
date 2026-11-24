Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512661;
	b=eTy5lxJvG2BQa+05A5QaXJcXCS/+rYCpRUZlq/GSqCPHNOUh41vS+GXN7vs/0P2WMdXw
	 VSpTzWd5pUAuolDdmJTWy/L85FGmvQfTK+9Z4GruesyJVnUCqYhBvTyoEpiJSxMvailWE
	 Z2es4KOqX4BbQHlGy69nAIajtIyb0w89YMNgV+Bro1bKNg64TbsNrvoKUk/f8h6p5VOFR
	 P4y3gw84/m755YvEE5cb3muQgz9Kr4xalOz6Jum3yVCu4H7AoNHS5bB2QdTgblwYi0yzx
	 RXfTnalLykVLlt8NjdTjUfX7IkemsZ/4leSfAFuk5lV8dmg+H+IedBSfZAybFfqSfjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512661;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=czr2NgLQec8c2t82MWxyebebRxRKRhT0v09ygt+K2IE=;
	b=fsV4nYjnB1+lkp5UJXfkKyEwMez6jt3SWM9UuCd/BDnGQuiztkWBYxkKCgc4irbQu+lx
	 p0wzz6wCkZfKW27tMA5QzZfGdjVMXb2KSmWH3aiDQCSsjWd7sBOuYirJvHyH001wzgQpe
	 EfSHMnJMpwQW0mambIgYjwhatZNRfZ055u7ag3yuPIQfdCUoWjXCrVBcGB5eZ42ZEFtnH
	 UkMZUYBmwzyRLOLysNWW5jYTl+RRQYpnD3saqzgzU2bE4DcFSHdT8tk+hCJTcFqxhks+S
	 HHUSTOczU/sZz2vOuHrLCeI/ZDd8aB9iiGgcPt5IdPciE8VRl+5N+mUbD28GTAjwKdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MssYBrxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EC606A687;
	Tue, 24 Nov 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MssYBrxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579361F000EC;
	Tue, 24 Nov 2026 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512660;
	bh=czr2NgLQec8c2t82MWxyebebRxRKRhT0v09ygt+K2IE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MssYBrxMMfn4OvF++ExgouQ8j0l1vzUrCSTACFH2IpVix/pwALfUu4L6i772AFr2u
	 lhAY9DZIuQk4+B4EZIoH1S02o0e4Wp0K2S6BipV8tTrz5qCDBNYbRJNZqf5dsb9+cN
	 77UnLh6k4lqkrHyTCFUCqLMcAU/YN1bflQvY9TKymKdNgewUo0sHbdARWTaTK0Bfif
	 eVk92HVJj2eoYlzPR7efcuNCnrpYewemBu1OrsWjtU2EC2FNf3soZoSa5P6mDnFVyH
	 0dslA0+ORonK4zWJwNI6Gkdl2CNITD9JDT6lg2uTMAN6pB/tzQvLTSY3+5kbt4Q2jh
	 EvHvjWpxZ6hmg==
Subject: Re: [PATCH can-next v10 09/14] can: gs_usb: gs_usb_get_gs_can():
 introduce new function to consolidate validation of struct gs_can
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:30:59 +0000
Message-ID: <179551265988.3131.9960814686983174068@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-9-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-9-7c165c35d04a@pengutronix.de>
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

- [Medium] This patch quietly changes how gs_usb_receive_bulk_callback()
  handles a frame for a channel whose netdev is not present.

--

can: gs_usb: gs_usb_get_gs_can(): introduce new function to consolidate validation of struct gs_can

This commit moves the decoding and validation of struct gs_can from the
host frame header into a new helper, gs_usb_get_gs_can(). The helper
returns the gs_can pointer on success, or NULL on error. A fatal flag
tells the caller whether to detach the device or resubmit the URB.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 75adec495e657..9078460aebcaa 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -651,6 +651,43 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
>  	return minimum_length;
>  }
>  
> +static struct gs_can *
> +gs_usb_get_gs_can(const struct gs_usb *parent,
> +		  const struct gs_host_frame_header *header, u32 actual_length,
> +		  bool *fatal)
> +{

[ ... ]

> +	struct gs_can *dev = parent->canch[header->channel];
> +	const struct net_device *netdev = dev->netdev;
> +
> +	if (!netif_device_present(netdev)) {
> +		*fatal = true;
> +
> +		return NULL;
> +	}

[Severity: Medium]
Is this a deliberate behaviour change? Before this patch, the
!netif_device_present() case did a plain return in
gs_usb_receive_bulk_callback(). It dropped that one URB without
resubmitting it, and it left the other channels alone:

-	if (!netif_device_present(netdev))
-		return;

With *fatal = true, the caller now jumps to device_detach. That label
detaches every channel on the adapter:

device_detach:
		for (rc = 0; rc < parent->channel_cnt; rc++) {
			if (parent->canch[rc])
				netif_device_detach(parent->canch[rc]->netdev);
		}

A netdev can be not-present while the USB device is still attached.
gs_usb_probe() fills parent->canch[] for all channels first. It then
calls register_candev() one channel at a time:

	for (i = 0; i < icount; i++) {
		struct gs_can *dev = parent->canch[i];

		rc = register_candev(dev->netdev);

So channel 0 can be opened before channel 1 is registered, and
gs_can_open() submits the shared bulk-IN URBs. If the device then sends
a frame tagged with the unregistered channel, would that now detach the
running channel 0 as well?

Once channel 0 is detached, its later RX frames also hit the fatal
path and the URBs are never resubmitted. TX queues stop, and reopening
fails with -ENODEV. gs_usb.c never calls netif_device_attach(), so the
channels appear to stay detached until the device is re-probed.

The other detach sites in this file only detach the affected channel's
netdev on -ENODEV, for example in gs_can_start_xmit():

		if (rc == -ENODEV) {
			netif_device_detach(netdev);

A single bool also can't express the old third outcome: drop the URB,
don't resubmit, don't detach.

The commit message says:

    If fatal is
    true, detach the device, otherwise re-submit the URB.

It doesn't mention that a case which used to just drop the URB now
detaches every channel. If this change is intended, could the commit
message say so? Otherwise, could the old drop-only behaviour be kept for
the not-present case?

This behaviour looks the same at the end of the series. The final
gs_usb_get_gs_can() still sets *fatal for !netif_device_present(), and
probe still registers the channels in sequence.

> +
> +	if (!netif_running(netdev))
> +		return NULL;
> +
> +	return dev;
> +}

[ ... ]

> @@ -678,30 +716,17 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  		return;
>  	}
>  
> -	minimum_length = sizeof(hf->header);
> -	if (urb->actual_length < minimum_length) {
> -		dev_err_ratelimited(&parent->udev->dev,
> -				    "short read (actual_length=%u, minimum_length=%u)\n",
> -				    urb->actual_length, minimum_length);
> +	dev = gs_usb_get_gs_can(parent, &hf->header, urb->actual_length, &fatal);
> +	if (!dev) {
> +		if (fatal)
> +			goto device_detach;
>  
>  		goto resubmit_urb;
>  	}
>  
> -	/* device reports out of range channel id */
> -	if (hf->channel >= parent->channel_cnt)
> -		goto device_detach;
> -
> -	dev = parent->canch[hf->channel];
> -
>  	netdev = dev->netdev;
>  	stats = &netdev->stats;
>  
> -	if (!netif_device_present(netdev))
> -		return;
> -
> -	if (!netif_running(netdev))
> -		goto resubmit_urb;
> -

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
