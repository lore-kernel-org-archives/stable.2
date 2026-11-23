Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435233;
	b=c8Sq6p33PyK4JaiHWB1lmsTgCVitRff+CCBClyFmhnKlblqZoEhwfNpQ6MGvAw5Ymjuk
	 3md7hrMuk+eJG9nxIsg3LME5l2M+r4vCIedtk7LY3zZyyKKD5B3xcHt8xSPs9RrUuV4yw
	 TD6ttpj2O/uEKzgeoWEmVwtaQc6dxwkGiUrN7canxZeiJjPTX2ZwLhluYIdlSYJmlnhUp
	 yZbkzLsMVXJZHDEIjxHNPXWze/VT7TnfvxS/TA+knLFYFcHF0tlTCbay5MFctA98B1WsS
	 76xNXQRlM5G8mtrOeBbCY75ijWS9DUx6sdx+9QBwGdc1EuePzSXN8fNUE0dz3oOzkdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435233;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y/D1twa1MYWchKekhhuFxyZ5gtSR8MGZMsqVWjtYgdg=;
	b=YOZfEdjqjbGEcr7xEnjxZwiCnzuD9qwbpmxyHPcxNzB3fM75x8PIvYDBFdN+CfEI2MT4
	 2fXL6x5YmvWSosdJL/T/1Bq2F6YkU4ttouKiSv2TvaNEzEs24yY0lJMM67ljTv2K5u2zo
	 WkvzqL1wPeY7/Nx3qxr0uSyYZ0dY/wwBUXROHMMqH9d5mMI0rIs5PiGeiuJH5Tkyr11Vh
	 O+RgGbmGjLrmsueRq6ek1SxlV+g/iHBBWd+cOlCm5zrv3IA4/a4zEBLJGyTZ4w5dwMs0E
	 bQvOY9Da4E07wwaE/rFqhlcJ7SP7U0bAJJzfDn1UtO6J3WMoZZnGE3V6b3En/OvVFXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=no0OQpWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D752606A31A;
	Mon, 23 Nov 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=no0OQpWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381651F000C0;
	Mon, 23 Nov 2026 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435232;
	bh=Y/D1twa1MYWchKekhhuFxyZ5gtSR8MGZMsqVWjtYgdg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=no0OQpWbAF5ZTWk5yriN5poBbaqF8wCJzqZZOB59PaoMFPJlpHzTDWhIAW52TnBqV
	 Oy+h4Ka+7XGd5lTWOG97mI4MeFNOwEmWWDQx6r0RTIKxpRpgl/Gu7ylIkv7vtxU59V
	 ufBo9bR6uuy2vKDx/x2vvto3c94OiFs5rErH/97Gucl/OKwshWDFd+qLtR8wh89DBN
	 x0kdgcW4hEfdBVPjKikEKgyQkFb6iJUZpjo4fCtfic0MqD0bVveXdWSjyEi0BUZ9cu
	 mqPwga4lcfKxp63DMGEOmon0TCGixR5P4lfPW2onQvDuW7mj2jTFA5VDwcTZZstkX9
	 UUNjMYboW9h9Q==
Subject: Re: [PATCH can-next v9 12/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:31 +0000
Message-ID: <179543523180.3131.8385656651883959137@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-12-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-12-db121d488945@pengutronix.de>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds an unprivileged local DoS that permanently
  wedges TX on the gs_usb CAN interface.
- [Low] The new netdev_err() format string in
  gs_usb_host_frame_header_valid() has a typo: "exptect_can_dlc" (should…

--

can: gs_usb: gs_usb_host_frame_header_valid(): drop invalid CAN error frames

This commit adds two checks to gs_usb_host_frame_header_valid(). Frames
with CAN_ERR_FLAG set must have a DLC of CAN_ERR_DLC, and they must not
have CAN_RTR_FLAG set. If either check fails, the frame is dropped and
the URB is resubmitted.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index e4e177aee48b0..a1192867e49b8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -639,6 +639,30 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
>  		valid = false;
>  	}
>  
> +	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
> +		if (header->can_dlc != CAN_ERR_DLC) {

[Severity: High]
This check only looks at CAN_ERR_FLAG and never at echo_id. Does it
also reject TX echo frames (echo_id < GS_MAX_TX_URBS) as well as real RX
frames?

On transmit, gs_can_start_xmit() copies the can_id and DLC from
userspace into the host frame unchanged:

    hf->can_id = cpu_to_le32(cf->can_id);
    hf->can_dlc = can_get_cc_dlc(cf, dev->can.ctrlmode);

The FD path does the same with can_fd_len2dlc(). The device sends this
header back as the echo.

A CAN_RAW socket needs no capability. Through one, a user can send a
frame with CAN_ERR_FLAG set and len != 8, or a frame with
CAN_ERR_FLAG | CAN_RTR_FLAG. Neither net/can nor can_dev_dropped_skb()
filters these on transmit.

When the echo arrives, gs_usb_receive_bulk_callback() does:

    data_length = gs_usb_get_rx_data_length(dev, hf, urb->actual_length);
    if (data_length < 0)
        goto resubmit_urb;

That jump skips the echo branch:

    gs_free_tx_context(txc);
    atomic_dec(&dev->active_tx_urbs);
    netif_wake_queue(netdev);

gs_usb_xmit_callback() returns early when urb->status == 0, so nothing
else releases the tx context or the echo skb.

After GS_MAX_TX_URBS such frames, every tx context is leaked, and
gs_can_start_xmit() has already stopped the queue:

    if (atomic_read(&dev->active_tx_urbs) >= GS_MAX_TX_URBS)
        netif_stop_queue(netdev);

Can anything wake the queue again before the interface is taken down and
brought back up? Until then no user can transmit, and the echo skbs stay
charged to the socket. Each rejected echo also bumps
rx_errors/rx_length_errors and logs an error. Before this patch, these
echoes completed normally.

The later patch in this series, "can: gs_usb:
gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC",
also leaves the CAN_ERR_FLAG block unconditional. The problem is
therefore still there at the end of the series.

Should these checks apply only when header->echo_id ==
GS_HOST_FRAME_ECHO_ID_RX, or should echo frames never be dropped by
payload validation?

> +			stats->rx_errors++;
> +			stats->rx_length_errors++;
> +
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "invalid DLC in CAN error frame (can_dlc=%u, exptect_can_dlc=%u)\n",

[Severity: Low]
This isn't a bug, but there's a typo in the format string: "exptect_can_dlc"
should probably be "expected_can_dlc". It is still there at the end of the
series.

The commit message also says:

    ensure that the RTR flag is not sent.

Should that say "set"? The code checks that the RTR flag is not set in
the received header.

> +					   header->can_dlc, CAN_ERR_DLC);
> +
> +			valid = false;
> +		}
> +
> +		if (header->can_id & cpu_to_le32(CAN_RTR_FLAG)) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
