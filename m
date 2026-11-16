Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794802714;
	b=hLOfNkQw9RBzwFNFfIBx9bateHsDXU+DeamERzdykK2FWImV0prKva05hfiA8N0F6eaN
	 TbzA49hx1c7sLu9rIVuxSYnI8SA0eczHDdQa1IElixk4HR8ZsdAdSor2TPMpBXZ6Km2Nv
	 bJaVnHwKNq61cbxhS4spoPtu5Qy6/MYDq6RODLTp/YX/fhF8sdlqhZS8GmIevS/kIedTw
	 zxZQdi0VCb7eiCXqH0AMVD7M+kkRUdyzX2ba1adhWeLy+UpzU0/p066foRqFskGwtRLiD
	 7+Lo60uaqggo2yuBMXk1vPQyOBYqpr8cPvfGIPMPolt/sBJjDqk493Jvi8Eq4Zn+VJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794802714;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0aMec3Kr1hhWIOX0FdD2MawjGgaX3T9TpKnNsq0oMSk=;
	b=w8eCSkVJvPTISuu3hEjhdOKq320JGd0OkLJePxoLZ7iIDGsDHPt/zXZwnCIuKpESB4v5
	 jchkO62VYRdpSQXHMQ+8NBB817rwBuOXO6GU0bGTU9KQLXxwg/cyeoqwzJgNuIb7gqmRn
	 m4z8VZswArtWQ1V1Gpu28T41ZnPZJRvWb9ROviEK5g52hFLK4yoxYlhNxZV7FSVwN46D8
	 0k/ZbpeqeeC53gTQPTuASAp3bpfv5AMygn5Fiw2hzYmSiKVUT379fR/QxtByyFRL3UtOC
	 KRnmFduWT1zfjAYsXg71Fv2vC6PhUiwPleQBMZ6O8gbpzIsXonn0vEkcldhWoghvqXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaaw9Agr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FC606A323;
	Mon, 16 Nov 2026 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaaw9Agr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DE31F000C4;
	Mon, 16 Nov 2026 04:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794802714;
	bh=0aMec3Kr1hhWIOX0FdD2MawjGgaX3T9TpKnNsq0oMSk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kaaw9Agr6/dPKiuIFnSu/Be17dbv139tkiFkDTcF3QmvhPGMLtlRrTCS+CWdpMkck
	 qlIsLexLbAMvbnZ4snB5hUXH3Y5Md5F8YkLEvC79vZwZWO3rCOtp0MiiKNXvbx7nbN
	 1jm1ECeXclhz6/N0F78VHaw0u0X79oSc3yu8NI96SErONcKnOhBv5Ygzdz3SkX2IOt
	 qrVi0C8o5u7+d/YcM5odl1BnTKPtH9QJcu9eGFpu9ZdTda9gyVOykfSyDQ9mWJBEe1
	 2vIfvlU1OtpPf+IBRmzj3TUIJqM7PP4SMAD3Ja+IH+UDPaF3OUAyGsrB736z4dMIW7
	 G/QHpNBpJdMiQ==
Subject: Re: [PATCH can-next v7 5/6] can: gs_usb: fix hardware timestamp state
 for mixed channels
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuangpeng.kernel@gmail.com, stable@vger.kernel.org,
 vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 04:18:32 +0000
Message-ID: <179480271276.3132.8527433601721507031@kernel.org>
In-Reply-To: <20261114-gs_usb-fixes-v7-5-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-5-58b6341b1c08@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] gs_usb_timestamp_start() (drivers/net/can/usb/gs_usb.c) now
  returns any error from the interface-wide GS_USB_BREQ_TIMESTAMP…
- [Low] The commit message only says the old gating "leads to problems".

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the RX URB
  completion handler gs_usb_receive_bulk_callback() reaches…

--

can: gs_usb: fix hardware timestamp state for mixed channels

This patch moves the HW timestamp cyclecounter setup into gs_usb_probe().
The setup runs when any channel advertises GS_CAN_FEATURE_HW_TIMESTAMP.
A new gs_usb_timestamp_start() initializes the timecounter and schedules
the worker when the first channel opens, and start/stop are now gated on
a parent-wide flag instead of the opened or closed channel's feature bits.

> Currently both the initialization and shutdown of the HW timestamping
> infrastructure is tied to the flags of the first channel opened
> respectively last channel closed. This leads to problems if the first
> channel opened doesn't have the timestamping feature, but the second
> channel has.

[Severity: Low]
Could the commit message name the problems this fixes? Reading the
pre-patch code, there seem to be two.

First case: the first opened channel lacks GS_CAN_FEATURE_HW_TIMESTAMP
and a later one has it. Then gs_usb_timestamp_init() never runs and
parent->tc stays zeroed from kzalloc_flex(). RX on the timestamping
channel then takes this path:

gs_usb_receive_bulk_callback()
  gs_usb_rx_offload() / gs_usb_get_echo_skb()
    gs_usb_set_timestamp()
      gs_usb_skb_set_timestamp()
        timecounter_cyc2time()

timecounter_cyc2time() dereferences tc->cc->mask with tc->cc == NULL. It
does this under a tc_lock that was never initialized.

Second case: the first opened channel has the feature and the last
closed one does not. Then gs_can_close() skips gs_usb_timestamp_stop(),
gs_usb_timestamp_work() keeps rescheduling itself, and
gs_usb_disconnect() frees parent while the work is still queued.

The Closes: links point to an external tracker. Would it help to state
the NULL pointer dereference and the use-after-free in the changelog?

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 980c4a748c946..b7780a23eff3b 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -332,11 +336,13 @@ struct gs_usb {
>  	/* time counter for hardware timestamps */
>  	struct cyclecounter cc;
>  	struct timecounter tc;
> -	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
> +	u32 timestamp_initial;
> +	spinlock_t tc_lock; /* spinlock to guard access cc, tc, timestamp_initial */
>  	struct delayed_work timestamp;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but is
spin_lock_bh() the right primitive for tc_lock?

gs_usb_skb_set_timestamp() is reached from the RX URB completion
gs_usb_receive_bulk_callback():

static void gs_usb_skb_set_timestamp(struct gs_can *dev,
				     struct sk_buff *skb, u32 timestamp)
{
	...
	spin_lock_bh(&parent->tc_lock);
	ns = timecounter_cyc2time(&parent->tc, timestamp);
	spin_unlock_bh(&parent->tc_lock);
	...
}

Some host controllers don't set HCD_BH. OHCI is one: ohci_hc_driver has
.flags = HCD_MEMORY | HCD_DMA | HCD_USB11. On those, usb_hcd_giveback_urb()
runs the completion directly from the HCD hardirq handler:

	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
		__usb_hcd_giveback_urb(urb);
		return;
	}

In that context, spin_unlock_bh() would hit WARN_ON_ONCE(in_hardirq())
in __local_bh_enable_ip().

gs_usb_timestamp_work() holds the same lock with hard IRQs enabled:

	spin_lock_bh(&parent->tc_lock);
	timecounter_read(&parent->tc);
	spin_unlock_bh(&parent->tc_lock);

gs_usb_timestamp_read() also re-takes the lock the same way after its
USB transfer. Suppose the HCD interrupt arrives on that CPU in this
window and completes an RX URB for a timestamping channel. Can
gs_usb_skb_set_timestamp() then spin forever on the lock held by the
worker it interrupted?

This patch keeps the scheme, and it is still there at the end of the
series. Would spin_lock_irqsave() on all tc_lock paths avoid this?

[ ... ]

> @@ -475,19 +491,44 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)

[ ... ]

> +static int gs_usb_timestamp_start(struct gs_usb *parent)
> +{
> +	u32 timestamp = 0;
> +	int err;
> +
> +	/* read current timestamp, might be used later for initial time stamp */
> +	err = gs_usb_get_timestamp(parent, &timestamp);
> +	if (err)
> +		return err;

[ ... ]

> @@ -988,9 +1029,15 @@ static int gs_can_open(struct net_device *netdev)
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
> +			if (rc)
> +				goto out_can_rx_offload_disable;
> +		}

[Severity: Medium]
Is it intended that a failed GS_USB_BREQ_TIMESTAMP read now makes ifup
fail?

gs_usb_timestamp_start() returns any error from gs_usb_get_timestamp(),
for example a STALL, a short read (-EREMOTEIO from
usb_control_msg_recv()) or a control timeout. gs_can_open() then aborts
through out_can_rx_offload_disable.

The check here uses the parent-wide GS_USB_PARENT_FLAGS_HW_TIMESTAMP,
not dev->feature. On a mixed device, a channel without
GS_CAN_FEATURE_HW_TIMESTAMP that is opened first now sends this request
and can fail to open because of it.

Before this patch, the initial read went through gs_usb_timestamp_read()
inside timecounter_init(). On error that path only logged "HW timestamps
may be inaccurate" and the open still succeeded. A channel without the
timestamp feature also never sent the request.

The commit message doesn't mention this change. It is also unchanged
later in the series: "can: gs_usb: properly shut down timestamp worker"
keeps the "if (err) return err;".

Should a timestamp read failure still be fatal when the channel being
opened doesn't use HW timestamps?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114-gs_usb-fixes-v7-0-58b6341b1c08%40pengutronix.de
