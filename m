Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094053;
	b=DgVf5ruo9DKoGBB6NWDP69jSQwBfqRoV4hN50c28NCPIbvpnmFJjm8VYh2tQTNIyRdoE
	 xuQxRYdk/8DZr87WQdnh9FpAEUP3NnT4wsZk+UKqIF+Xmw1E7mIsOl9me3AXuQCRU5D1g
	 ys4Y0xq5ljeQLV/uaazOTf/HTNkKHREyq+oxtjqA5PD3NOHiMtdHmoReFo5dEEP1/aVmO
	 Yx2qt9qOqyzrpZATMxp4+U99vmt+C7v5a9eYgahmVAU6n01OySFQaaNROOzHnHuzfWYq3
	 rkm2OHfHWRdJA7IppczZYodPTdxSwFH+rxQX5q6c/E33CusWrllSD8hSgh9SZnKRx7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094053;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HaweunadkOKFbBWdricEl36vtaiW9LRn8m4Vp5jchCE=;
	b=1GyTNNVrnQVWw3Rth2rPnIwSWxTVDk6Q1wfAO50Sq7DYIilDuh7LepddgvJBJdLy+8w1
	 yrLDptmEEI/9bFPTemfo8YFK3qnA04cvDnCoosZrzJSFwFO4LdTozzvVal8asQ3ACLjkB
	 WxqAuu7gfMMnOau2KaVZ+gHmZOd/RhOXt7geQ3PpL4NmEOrW49xEPuuZzeoinpMp2e9WE
	 FiYAUhMt91mvGxg2m+p7/4M26suCn/c4E6ERfVIZiUyLTUihWaOL8pAJGFWSAwTE2W7fM
	 tS5WBAbYCjTh5gYiI58LcElLmd3yr6FR7BVmc5Dnzya+iGk6LlR3jF7SP+28Ny1P8Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTgaBJGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AE606A31A;
	Tue, 27 Oct 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTgaBJGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838181F01829;
	Tue, 27 Oct 2026 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094053;
	bh=HaweunadkOKFbBWdricEl36vtaiW9LRn8m4Vp5jchCE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TTgaBJGrxSV5r96R9PhUUd/5G9KQ5JbinFixjcXCqiC21797qoEdQvfowC8w0HHZ8
	 0HWrU/EoVWgIZwkSgS7tUdPuaiJCBwzyPehFTKbVA4n83pfGqVUqAFJ7LbkgcL6ps+
	 x6PzY9qaEh2Wz8bfwjcNkOqK8hgR11mVPcZu/X+v6cSO497uP+SEJKrJt8j6becCuG
	 NRT0gCwptfm8Cq4KigTOAknM5f8nzYXP9myjEteA3A0qcPjGKts+/4jHi7wvNTeu3a
	 mZafFiMLDYwnDIOswiMPHCU/JkRX8xGtmj9S9X5I/8U+aCl8GeSme7IQs9rx/Gs2CC
	 ieVoCO5GZm40w==
Subject: Re: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 27 Oct 2026 09:40:52 +0000
Message-ID: <179309405203.3130.15846151010657082871@kernel.org>
In-Reply-To: <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Broken error unwind in gs_usb_probe()
  (drivers/net/can/usb/gs_usb.c) when register_candev() fails.

Pre-existing issues:
- [High] The probe error unwind in gs_usb_probe() frees channel objects
  before it stops the shared RX URBs.

--

can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()

This patch moves register_candev() out of gs_make_candev() and into a
second loop in gs_usb_probe(). The aim is to set dev->parent and
parent->hf_size_rx before any CAN interface becomes visible to userspace.
The error paths now share a common out_usb_kill_anchored_urbs label.

Closes: https://sashiko.dev/#/bug/linux-be54de7d-0b75-408c-b3ee-dd90c9756857
Closes: https://sashiko.dev/#/bug/linux-71076d59-0843-4749-a5ab-fdd98a08582f

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 15f28833f2deb..2564c16727935 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -1621,7 +1612,36 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
>  	}
>  
> +	for (i = 0; i < icount; i++) {
> +		struct gs_can *dev = parent->canch[i];
> +
> +		rc = register_candev(dev->netdev);
> +		if (rc) {
> +			const unsigned int cur = i;
> +
> +			dev_err(&intf->dev,
> +				"Couldn't register candev for channel %d (%pe)\n",
> +				i, ERR_PTR(rc));
> +
> +			for (i = 0; i < cur; i++)
> +				gs_destroy_candev(dev);
> +
> +			for (; i < parent->channel_cnt; i++) {
> +				can_rx_offload_del(&dev->offload);
> +				free_candev(dev->netdev);
> +			}

[Severity: Critical]
Both cleanup loops use dev, and dev still points at parent->canch[cur],
the channel whose register_candev() just failed. Should these use
parent->canch[i], like the gs_make_candev() failure loop earlier in
gs_usb_probe()?

As written, the first loop calls gs_destroy_candev() cur times on
canch[cur], which was never registered. unregister_candev() on a
NETREG_UNINITIALIZED netdev hits the WARN_ON(1) in
unregister_netdevice_many_notify(). free_netdev() then frees it
immediately:

net/core/dev.c:free_netdev() {
    ...
	if (dev->reg_state == NETREG_UNINITIALIZED ||
	    dev->reg_state == NETREG_DUMMY) {
		kvfree(dev);
    ...
}

So when cur >= 2, does each later pass touch freed memory and then free
it again?

The second loop then calls can_rx_offload_del() and free_candev() on the
same dev once for each remaining channel. If cur >= 1, dev has already
been freed. If cur == 0 and channel_cnt >= 2, canch[0] is freed
channel_cnt times.

Aren't the netdevs and NAPI instances of canch[cur + 1] through
canch[channel_cnt - 1] leaked as well?

Also, canch[0] through canch[cur - 1] are never unregistered, but their
dev->parent points at the struct gs_usb that kfree(parent) frees below.
Since probe fails, gs_usb_disconnect() never runs for them. Wouldn't any
later open, close, xmit or ethtool call on those netdevs dereference the
freed parent?

Userspace may have opened one of them during the window. In that case
gs_can_open() may have started the self-rearming parent->timestamp
delayed work through gs_usb_timestamp_init(), and only gs_can_close()
cancels it.

The device can force this failure. gs_make_candev() copies sjw_max from
the GS_USB_BREQ_BT_CONST reply without checking it. register_candev()
then fails with -EINVAL through can_bittiming_const_valid():

	if (!btc->sjw_max)
		return false;

A device that reports icount >= 2 and sjw_max == 0 for channel 1 would
reach this unwind every time it is plugged in.

The later patches in this series only touch gs_can_start_xmit() and
gs_usb_receive_bulk_callback(), so this is still present at the end of
the series.

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

[Severity: High]
This isn't a bug introduced by this patch, but the unwind frees the
channel objects before usb_kill_anchored_urbs() stops the shared RX URBs.
The baseline code used the same order.

Suppose userspace opened two or more of the registered channels during
the probe window. In that case gs_destroy_candev() -> unregister_candev()
-> gs_can_close() only kills the RX URBs once active_channels reaches 0:

	parent->active_channels--;
	if (!parent->active_channels) {
		usb_kill_anchored_urbs(&parent->rx_submitted);

So the RX URBs keep completing while canch[0] is freed, and
gs_usb_receive_bulk_callback() does:

	dev = parent->canch[hf->channel];

	netdev = dev->netdev;
	stats = &netdev->stats;

	if (!netif_device_present(netdev))

Can this dereference a freed gs_can and net_device when the device sends
a frame with hf->channel == 0?

The device_detach path in the same callback walks every
parent->canch[rc]->netdev, so it seems to have the same exposure.

The disconnect path is not affected, because usb_unbind_interface()
disables the endpoints before calling ->disconnect(). The probe failure
path gets no such help from the USB core.

Would it make sense to kill the RX URBs before tearing down the channels
in this unwind?

> +
> +	return rc;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025-gs_usb-fixes-v2-0-535d45097f72%40pengutronix.de
