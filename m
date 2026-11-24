Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512666;
	b=rYaUtfVhZ1j0R0P//7Fd0ePY4fzX59Srw5bOgn012YxdMFNFalkJ43npA+xr7iCZ5hN4
	 DSnGzsf+OTVSLQvxez32defYiJnp290zs2V5A/G4rihUsJ0NlV+tSul+ren2b7C8DhnPc
	 9fWpo6fJgazXsePcqzaphkJhM+RMzxrcdN74ZrMgYofHhmAMoQOrMIisUsyl1ZV0TvCZu
	 BUijLSFoF+JPsAdwE8q3XxR1O/AOGoPYjKRmcyNcgU9UOACg1q8uXtMbYxg6pvFeM/zxb
	 Lu5/4F3vcfYManHJRM1PiaqXVuH7TdxQNf5SW1QUu0dXKvvWCUTNqUdTPHlk/g17l6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512666;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=U/HNWif1ZVECeK3JYpem65ii+B67CFXrmyP8vaDY9lY=;
	b=1jo1OK8Fn4Lbz+kQz2RwDPeJSEoZ3Pgyth8DNtRfSgTFmChcH+C1GwwnJ/9/2tAkJ6GS
	 fAsUtrCWVg1UB58FHIwp+BHjCpoNFglyISJOZ8BXbvZ3GN5mwXljHbVMCkU95zmGbpSEM
	 1qLm8P7r2vhf1Ee4eYf37jk0wry5JzYDYrfv+DhW5agPhC/W39EwL2TYX4AyzO4C5nUjd
	 LQDrEMnxUbFbFdrtT5IVWUj2VDoAg9b9uICUELKQ8KStKmv20E3SxBAgjW+T1fDlFrQC6
	 yzl1vYEybT/AZO7aquleHhj7swcI/NnE55AAMhjzmomCr5irtOBprLncdp0tRADYnMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f3/CJm6u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47234606A68F;
	Tue, 24 Nov 2026 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3/CJm6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8727C1F000C6;
	Tue, 24 Nov 2026 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512666;
	bh=U/HNWif1ZVECeK3JYpem65ii+B67CFXrmyP8vaDY9lY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f3/CJm6uOD0E0Rpou9IthYh6bIvFVB2GTOOTgL248PjV8F18DW/fsT0ojbM2IkWP2
	 g5b+EKFyyouivhC3UEkY1MaLG7Hotu8+yB6iQfKGat52XC5/enBg4yjSIrl8I2+CNq
	 Wc3yqjw+B3XmgY6t8NbVDG08DgXbkWbOYh0E0jGncb9ZA3sLtLH6PYXR71N3/Y7fGV
	 LRbtACsGxLK56rSH+wZOw7oo9Z2+i+SkW3dKfDJU82/IOlENRfLJtiFo+doyp1hF+b
	 nPATVf35eVim+zLDc8PVTydp8s1OQZGWKLcLXJ9Xt81jTdgzzI/OSjBknVOu2fk9J7
	 IG1GJJbPK+ImA==
Subject: Re: [PATCH can-next v10 13/14] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:31:05 +0000
Message-ID: <179551266509.3131.3496151929213632849@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-13-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-13-7c165c35d04a@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] gs_usb_host_frame_header_valid()
  (drivers/net/can/usb/gs_usb.c) now rejects every received CAN error…
- [Low] The patch is titled "drop invalid CAN error frames" and checks
  only DLC and RTR.
- [Low] In gs_usb_host_frame_header_valid(), the new DLC check (line 648)
  and RTR check (line 660) are independent if-blocks.
- [Low] When the new checks reject an RX error frame,
  gs_usb_receive_bulk_callback() goes from the data_length < 0 check…

--

can: gs_usb: gs_usb_host_frame_header_valid(): drop invalid CAN error frames

This commit adds checks to gs_usb_host_frame_header_valid() for received
CAN error frames. They must have a length of CAN_ERR_DLC and must not have
the RTR flag set. Frames that fail are reported with a rate limited error
message, and the URB is resubmitted without delivering the frame.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index b345ab34a200a..7229d002b938a 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -639,6 +639,35 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
>  		valid = false;
>  	}
>  
> +	if (!(header->echo_id == GS_HOST_FRAME_ECHO_ID_RX))
> +		return valid;
> +
> +	/* checks for RX'ed (non-echo) CAN frames */
> +
> +	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
> +		if (header->can_dlc != CAN_ERR_DLC) {
> +			stats->rx_errors++;
> +			stats->rx_length_errors++;
> +
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "invalid DLC in CAN error frame (can_dlc=%u, exptect_can_dlc=%u)\n",
> +					   header->can_dlc, CAN_ERR_DLC);
> +
> +			valid = false;
> +		}

[Severity: Medium]
Can dropping the whole frame here lose controller state transitions?

When this check fails, gs_usb_get_rx_data_length() returns -EINVAL, and
gs_usb_receive_bulk_callback() jumps straight to resubmit_urb. That also
skips the gs_update_state() call:

drivers/net/can/usb/gs_usb.c:gs_usb_receive_bulk_callback() {
    ...
	data_length = gs_usb_get_rx_data_length(dev, hf, urb->actual_length);
	if (data_length < 0)
		goto resubmit_urb;
    ...
			/* ERROR frames tell us information about the controller */
			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
				gs_update_state(dev, cf);
    ...
}

gs_update_state() is the only runtime code that updates dev->can.state and
the bus_off, restarts, error_warning and error_passive counters. Its
bus-off and restart branches look only at cf->can_id:

drivers/net/can/usb/gs_usb.c:gs_update_state() {
	if (cf->can_id & CAN_ERR_RESTARTED) {
		dev->can.state = CAN_STATE_ERROR_ACTIVE;
		can_stats->restarts++;
	} else if (cf->can_id & CAN_ERR_BUSOFF) {
		dev->can.state = CAN_STATE_BUS_OFF;
		can_stats->bus_off++;
    ...
}

A bus-off or restart frame with a short DLC carried everything the driver
needed, but it is now discarded. If firmware sends such a frame, would
dev->can.state stay ERROR_ACTIVE or ERROR_WARNING while the controller is
actually bus-off? User space would also never see the event.

Nothing appears to correct the state later. gs_usb_get_state() is only
reached through do_get_berr_counter, the driver sets no do_get_state, and
gs_usb_can_get_berr_counter() ignores the polled state.

Short frames were not a memory safety problem before this patch.
alloc_can_skb() zeroes the can_frame and memcpy() copies only data_length
bytes, so data[1] reads as 0.

Would it be better to repair the frame instead? Setting len to CAN_ERR_DLC
and clearing CAN_RTR_FLAG, with a rate limited warning, would give user
space well formed frames without losing the state transition. The same
applies to the RTR check below.

It is not confirmed that any deployed gs_usb firmware (candleLight, CANtact
Pro, cannectivity, the original Geschwister Schneider firmware) sends error
frames with a DLC other than 8. The commit message also does not say that
state changes carried only in can_id are dropped as well.

> +
> +		if (header->can_id & cpu_to_le32(CAN_RTR_FLAG)) {
> +			stats->rx_errors++;

[Severity: Low]
Is a single frame counted twice in rx_errors here?

The DLC check above and this RTR check are independent, and neither
returns. An RX error frame with CAN_ERR_FLAG | CAN_RTR_FLAG and can_dlc != 8
therefore adds 2 to rx_errors. include/uapi/linux/if_link.h describes
rx_errors as the "Total number of bad packets received on this network
device".

The next patch in the series ("can: gs_usb:
gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC") adds a
third independent block for can_dlc > CAN_MAX_RAW_DLC. That block also
increments rx_errors and rx_length_errors. At the end of the series, an
error frame with can_dlc > 15 and RTR set would add 3 to rx_errors and 2 to
rx_length_errors.

Could the counter be incremented once per rejected frame instead? For
example, gs_usb_get_rx_data_length() could do it when
gs_usb_host_frame_header_valid() returns false.

> +
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "invalid RTR flag in CAN error frame\n");
> +
> +			valid = false;
> +		}
> +	}

[Severity: Low]
Should these checks also reject error frames that have GS_CAN_FLAG_FD set
in header->flags?

An RX error frame with GS_CAN_FLAG_FD (and optionally BRS or ESI) set and
can_dlc == 8 still passes here. gs_usb_receive_bulk_callback() then takes
the FD branch:

drivers/net/can/usb/gs_usb.c:gs_usb_receive_bulk_callback() {
    ...
		if (hf->flags & GS_CAN_FLAG_FD) {
			skb = alloc_canfd_skb(netdev, &cfd);
			...
			cfd->can_id = le32_to_cpu(hf->can_id);
			cfd->len = data_length;
			if (hf->flags & GS_CAN_FLAG_BRS)
				cfd->flags |= CANFD_BRS;
			if (hf->flags & GS_CAN_FLAG_ESI)
				cfd->flags |= CANFD_ESI;
    ...
}

The resulting canfd_frame keeps CAN_ERR_FLAG. gs_update_state() is only
called in the classic branch, so the driver state ignores this frame.

can_rcv_filter() in net/can/af_can.c delivers any frame with CAN_ERR_FLAG
to RX_ERR subscribers. Sockets with CAN_RAW_FD_FRAMES enabled would
therefore receive the error frame as a struct canfd_frame.

SocketCAN error frames are always classic struct can_frame. This looks
like another kind of invalid error frame that, going by its subject, the
patch is meant to drop. The behaviour predates this patch, but it falls
within what the patch sets out to cover.

> +
> +	return valid;
>  }

[Severity: Low]
When the new checks reject an RX error frame,
gs_usb_receive_bulk_callback() goes straight to resubmit_urb and skips the
overflow handling:

drivers/net/can/usb/gs_usb.c:gs_usb_receive_bulk_callback() {
    ...
check_overflow:
	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
		stats->rx_over_errors++;
		stats->rx_errors++;
    ...
}

Is it intended that a GS_CAN_FLAG_OVERFLOW bit in a rejected error frame
is lost? In that case rx_over_errors is not counted and no
CAN_ERR_CRTL_RX_OVERFLOW error frame is generated.

The flags byte does not depend on can_dlc or the RTR bit, and
gs_usb_get_gs_can() has already confirmed that the full header was
received.

Earlier validation failures (out of range echo_id, short read) already
skip overflow handling this way. This patch adds new cases that reach the
same path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
