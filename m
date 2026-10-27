Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086650;
	b=CrVwvITmR43zVnhYnTO/af+H/yRxyd/NES3AxoFY0PIwnmjmY8gKryJkRRDZbmGMb7jk
	 eJnt1pBmEO3Con3uy6x9askwMriPYlxcNfSzP5FjT0ecg34baZdvKjdEJSD8hB1V2I1NJ
	 HKyNbPWiWMPLgQoDKWg/KNYtcnWT++9x9NJaUh88CdYHQjZ/1mo3ZyTns4lFfWcDjR07h
	 eOS+934BimXOwfIiwN4C4VNZ93NTn8Jm5InG5KxKodaAANc5KCDyQqNz1/+xra/RuU+2w
	 ZyMprY2swqPKRhjW9by08H03VetWKmBbNQv+HoAq9r7+xNTLxbxYE0iNfuNsrj691Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086650;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2e0MsO9AHXoJdX9UWJnkLnX9r1+Gelx4hH11sNzcLnU=;
	b=KcjVZMuXmVu0eUtZ8DOHA2TFolKt2Ha/uly1sVkd6NR9yKDd0hyDSLpZpWvjMpNzQgoP
	 Y8S0hEXyqq6TPVMw7r+M54LtGYpvg5eqnxla39SqfcFFidAZP+gvxcz+MjolO58jpQ43S
	 17j4nSZIpi3jdotR6iwBkUCUysIDi7eey2GnAQh2ohiY03r1DmALhIvzxuxFDI1WpWFZG
	 UDFMlIfTLfFxeR04E/UoS3RO8UdEv4oBkTme9nYz7ogxMIeQgukt3R67BMsu8WWXmwvrX
	 aOYA1p6BtoW7vv3OIAs34jGMLqTO6VMFKaUcML8wnEvOPC2WaJftvFeAggrCyJSMFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LiMiXO05;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA4606ADA0;
	Tue, 27 Oct 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LiMiXO05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4E41F031E2;
	Tue, 27 Oct 2026 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793086649;
	bh=2e0MsO9AHXoJdX9UWJnkLnX9r1+Gelx4hH11sNzcLnU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LiMiXO059gYMjJvZr3VzMyWO43KUzF7Wp1TA4eVCncm5L4TF2HvEMMEPlmrQuxURQ
	 7Qri08L+bSiekRaf8ahClnK+pH/yZZpL66bfaqi16kUFR74WaSNx2fUIW/Io/KjkD1
	 ptoFnlFXzdZ6iJmcJVCDT6HjPOdbZrBcGF1OCEAtRZC8rilkLipcTQitTev10krH/+
	 yEzaSwjgtsSruzupiE+YaAzIX0SAbe0kZR8mJGGuXbZ5HwEJ8wGaHcELskV2REmCvo
	 DM3TfPoLLqL664GbPVq2E7xKldS4wCkDe0z5UijqVodsZ6OmlHX/E5RFNUv1FFWgGi
	 tUo1gUXxDWqGw==
Subject: Re: [PATCH 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check
 for overflow flag if SKB allocation fails
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 27 Oct 2026 07:37:28 +0000
Message-ID: <179308664876.3130.13155434112115626633@kernel.org>
In-Reply-To: <20261025-gs_usb-fixes-v1-3-f74ebbd4da36@pengutronix.de>
References: <20261025-gs_usb-fixes-v1-3-f74ebbd4da36@pengutronix.de>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In gs_usb_receive_bulk_callback()
  (drivers/net/can/usb/gs_usb.c), both new SKB-allocation-failure…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  gs_usb_receive_bulk_callback() (drivers/net/can/usb/gs_usb.c) the…
- [Low] At this commit, the check_overflow block in
  gs_usb_receive_bulk_callback() (drivers/net/can/usb/gs_usb.c:744-746)…

--

can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails

This commit changes the alloc_can_skb() and alloc_canfd_skb() failure
paths in gs_usb_receive_bulk_callback(). They now update the RX statistics
and jump to a new check_overflow label instead of resubmitting the URB
directly. As a result, GS_CAN_FLAG_OVERFLOW in the host frame is still
handled when the SKB allocation fails.

Closes: https://sashiko.dev/#/bug/linux-7b3fe6a0-4628-4d0e-aec0-69f4bf8ad5d4

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 985d6a9113d96..5687544af99c8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -673,8 +673,12 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
>  		if (hf->flags & GS_CAN_FLAG_FD) {
>  			skb = alloc_canfd_skb(netdev, &cfd);
> -			if (!skb)
> -				goto resubmit_urb;
> +			if (!skb) {
> +				netdev->stats.rx_dropped++;
> +				netdev->stats.rx_errors++;
> +
> +				goto check_overflow;
> +			}

[Severity: Medium]
The commit message says "first update the dropped RX statistics". However,
both new allocation failure branches (CAN FD here, and Classical CAN in the
next hunk) also increment rx_errors. Is rx_errors the right counter for a
host-side allocation failure?

The kernel-doc for struct rtnl_link_stats64 in include/uapi/linux/if_link.h
defines the two counters like this:

 * @rx_errors: Total number of bad packets received on this network device.
 ...
 * @rx_dropped: Number of packets received but not processed,
 *   e.g. due to lack of resources or unsupported protocol.

In this path the frame arrived intact and only the SKB allocation on the
host failed.

Other CAN drivers that handle an alloc_can_skb() or alloc_canfd_skb()
failure count only rx_dropped. Examples are m_can.c, c_can_main.c,
mcp251xfd-rx.c, kvaser_usb_hydra.c and es58x_core.c. The shared rx-offload
helper also leaves rx_errors alone:

drivers/net/can/dev/rx-offload.c:can_rx_offload_offload_one() {
    ...
	if (IS_ERR(skb)) {
		offload->dev->stats.rx_dropped++;
		offload->dev->stats.rx_fifo_errors++;
    ...
}

With this change, would memory pressure on the host show up as RX errors
on a gs_usb interface? Those would look like bus or controller faults, and
the change would reach stable through the Cc: stable tag.

A minor point: the new lines use netdev->stats directly, while the rest of
gs_usb_receive_bulk_callback() uses the local stats pointer.

>  
>  			cfd->can_id = le32_to_cpu(hf->can_id);
>  			cfd->len = data_length;
> @@ -686,8 +690,12 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  			memcpy(cfd->data, hf->canfd->data, data_length);
>  		} else {
>  			skb = alloc_can_skb(netdev, &cf);
> -			if (!skb)
> -				goto resubmit_urb;
> +			if (!skb) {
> +				netdev->stats.rx_dropped++;
> +				netdev->stats.rx_errors++;
> +
> +				goto check_overflow;
> +			}
>  
>  			cf->can_id = le32_to_cpu(hf->can_id);
>  			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

[Severity: Medium]
This isn't a bug introduced by this patch, but the Classical CAN error
frame handling is still skipped when alloc_can_skb() fails. A little
further down, after the allocation succeeds:

	/* ERROR frames tell us information about the controller */
	if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
		gs_update_state(dev, cf);

gs_update_state() is the only place where controller state reported by the
device reaches dev->can.state and can_stats (restarts, bus_off,
error_warning, error_passive). It reads cf->can_id and cf->data[1], and the
same values are available in hf->can_id and hf->classic_can->data[1].

An error frame can carry a BUS_OFF, RESTARTED, warning or passive
transition. If one arrives while alloc_can_skb() fails, the goto
check_overflow skips the state update. Can dev->can.state then stay stale
until another state change frame arrives and its allocation succeeds?

Some peer drivers update controller state even when the error SKB
allocation fails. For example, esd_usb.c does:

	skb = alloc_can_err_skb(priv->netdev, &cf);
	if (!skb)
		stats->rx_dropped++;

	if (state != priv->old_state) {

The original return, and the later goto resubmit_urb from commit
68c5724ecd15, also skipped this update. The patch does not address it.

[ ... ]

> @@ -728,6 +736,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  		netif_wake_queue(netdev);
>  	}
>  
> +check_overflow:
>  	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;

[Severity: Low]
This is a pre-existing issue, but at this commit the overflow block
continues like this:

		skb = alloc_can_err_skb(netdev, &cf);
		if (!skb)
			goto resubmit_urb;
		...
	}

	can_rx_offload_irq_finish(&dev->offload);

resubmit_urb:

If alloc_can_err_skb() fails, this path skips
can_rx_offload_irq_finish(). An RX SKB queued earlier in the same callback
by gs_usb_rx_offload(), or an echo SKB queued by gs_usb_get_echo_skb(),
then stays on offload->skb_irq_queue. NAPI is not scheduled until a later
URB completion calls irq_finish.

On the new allocation failure paths added here, nothing has been queued
before check_overflow, so this patch does not make the delay worse.

The next patch in this series, "can: gs_usb:
gs_usb_receive_bulk_callback(): add missing call to
can_rx_offload_irq_finish", changes this to goto can_rx_offload_irq_finish
and adds a matching label, which fixes the skipped irq_finish.

One part is not covered by that patch: when alloc_can_err_skb() fails,
rx_dropped is not incremented for the lost overflow error frame. The
overflow event itself is still counted in rx_over_errors and rx_errors.
Should rx_dropped be incremented here as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025-gs_usb-fixes-v1-0-f74ebbd4da36%40pengutronix.de
