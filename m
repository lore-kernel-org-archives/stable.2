Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435234;
	b=w16OynmoBVyB+7QNiIik9nkyKP3MHYjiPRazhGKlPNIlYCXn1mNjSsgORY3WMU++wQkV
	 eUAH4/2/IyA44rzIDZ/o8affh+ZIALAqRJ4wy+899cO6RYUHuKwVzSj0xcxCR8pJVrijT
	 EFPtALhHXBVWHUs0sbN0gqI87Cy8EIA5FYWa5S3lADCYR+hmx0rodv7eorv8wyGxZT55h
	 WEuoxMMVttgHbPLloq6e3U/fwBV9gR0KAcus0jZanVrp6x0C9214WLIbRDcTS2BaKAu3n
	 I/iIAw9eOszzhWH2HM6el4KFnboGUjEGKF60B8s9EPgJu55avqwYBdq1aAEEz2cA0pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435234;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=58dnyHmcGYM5K/noXPXYN5UJ12SWVEjcuBJMitDAktY=;
	b=n+TQJ1FEoOBHF2H34sJeHclTdaiPKOYomaLOrm8aaW7korIw9BKtr4PxeGFvRf2ol8Jr
	 WGA240qOTesXbOpOHIsgkSmOosLS0EmR6JRF3pjHM7gINpK/ksRQq+394L4gSg0h7qPva
	 H8EtUXmalBRwVgQSv8wWGAuBkEim0p/Hzp4DF+7rgohUBBqeckTY1L5tL7GtOtk5pfYGd
	 P6q5q8guUScDdKsmV6cdnUSf6CQKJOC7OvFF4PpSthbnJ358f8Y5MAsI8DcUEmnmkH+v1
	 UdeiSCHy1H/sG7bzpDM4EK4lfFxgDQ6pidh3h6uwOvbOC4tE5QKxgUDik4G6swYK50A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2VrxARw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8361606A32A;
	Mon, 23 Nov 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2VrxARw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E731F000CF;
	Mon, 23 Nov 2026 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435234;
	bh=58dnyHmcGYM5K/noXPXYN5UJ12SWVEjcuBJMitDAktY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I2VrxARwlNQzNhupuGPSVkr2zfOt6vIXI0i03VUfNDROroNsYb97TXMgVwcuKDpwz
	 Y5u6/G9+t8PYd+W/lRMKBnFX1+/qKKV0Z/CQ4HD5BdstFy4oxChMiQm9t4UMYKygMd
	 UsZPz35/IX7F0/+DUXiE198AFHBP2Hnc7HY1wYxX5IdrrYwG6j6dI4wLJaR2I8NmK3
	 V9ynzJRq8VyqMHudIBOQcUL7SxoxSroErlgPya1CprcUZmFoN3d0oaG5ofYXW5qDxs
	 tSxiO1d6nFk3zd7E1sdpJZlqAUq2CkGGbCguywWuQtSoiq0wkxEjfZN9My5BDIX7xC
	 IltUcGbPvC00Q==
Subject: Re: [PATCH can-next v9 13/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, shuangpeng.kernel@gmail.com,
 stable@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 12:00:33 +0000
Message-ID: <179543523333.3131.16865758831688588605@kernel.org>
In-Reply-To: <20261121-gs_usb-fixes-v9-13-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-13-db121d488945@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new DLC check in gs_usb_host_frame_header_valid()
  (drivers/net/can/usb/gs_usb.c:666-678) ignores echo_id.
- [Low] The commit fixes a real contract violation that userspace can
  see, but it has no Fixes: tag and the message does not state the…
- [Low] In gs_usb_host_frame_header_valid()
  (drivers/net/can/usb/gs_usb.c), the new out-of-range DLC check (lines…

--

can: gs_usb: gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC

This patch adds a check to gs_usb_host_frame_header_valid() that rejects
any host frame with a DLC above 0xf. A rejected frame increments
rx_errors and rx_length_errors, logs a rate limited error and causes the
URB to be resubmitted.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de

> According to the respective CAN standards, the maximum DLC length for
> CAN-CC and CAN-FD frames is 0xf. The code in driver assumes that this limit
> has been verified.

[Severity: Low]
Should this have a Fixes: tag, and could the message state what goes
wrong without the check?

Before this patch, gs_usb_receive_bulk_callback() passed the
device-supplied hf->can_dlc directly to can_frame_set_cc_len(). That
call came in with commit 26949ac935e3 ("can: gs_usb: add CAN-FD
support"):

    can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

The helper expects the caller to have checked the value already:

include/linux/can/length.h:can_frame_set_cc_len() {
	/* the caller already ensured that dlc is a value from 0 .. 15 */
	if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
		cf->len8_dlc = dlc;
}

With CAN_CTRLMODE_CC_LEN8_DLC enabled, a len8_dlc above 15 could
therefore reach raw CAN socket users.

On the FD path, can_fd_dlc2len() does dlc2len[dlc & 0x0F]. A DLC such as
0x1f was silently turned into a valid 64 byte frame instead of being
rejected.

Other fixes in this series carry Fixes: and Cc: stable tags, for example
"can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if
SKB allocation fails". Would the same tags make sense here, so stable
backporters have something to go on?

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index a1192867e49b8..2da2f8843e5d5 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -663,6 +663,20 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
>  		}
>  	}
>  
> +	/* we can check for max CAN-CC and CAN-FD DLC at the same time, they are both 0xf */
> +	BUILD_BUG_ON(CAN_MAX_RAW_DLC != CANFD_MAX_DLC);
> +	if (header->can_dlc > CAN_MAX_RAW_DLC) {

[Severity: Medium]
This check runs whatever header->echo_id is, so TX echo frames
(echo_id < GS_MAX_TX_URBS) with can_dlc > 15 are now rejected as well.
What happens to the pending TX context in that case?

gs_usb_get_rx_data_length() returns -EINVAL, and
gs_usb_receive_bulk_callback() then skips the echo completion branch:

gs_usb_receive_bulk_callback() {
	...
	data_length = gs_usb_get_rx_data_length(dev, hf, urb->actual_length);
	if (data_length < 0)
		goto resubmit_urb;
	...
	} else { /* echo_id == hf->echo_id */
		txc = gs_get_tx_context(dev, hf->echo_id);
		...
		gs_free_tx_context(txc);

		atomic_dec(&dev->active_tx_urbs);

		netif_wake_queue(netdev);
	}
	...
}

The TX context slot and the echo skb that gs_can_start_xmit() stored
with can_put_echo_skb() then stay held until gs_can_close(). The
active_tx_urbs count is never decremented either. The driver has no
ndo_tx_timeout or other recovery path.

After GS_MAX_TX_URBS such echoes, gs_alloc_tx_context() fails and
gs_can_start_xmit() returns NETDEV_TX_BUSY. Once the leaked
active_tx_urbs count reaches GS_MAX_TX_URBS, gs_can_start_xmit() stops
the queue and nothing wakes it. TX then stalls until the interface is
taken down and brought back up.

Echo frames never use can_dlc. gs_usb_get_minimum_rx_length() only
converts the DLC to a length for echo_id == GS_HOST_FRAME_ECHO_ID_RX,
and the echo path takes its data from dev->can.echo_skb[]. Before this
patch, an echo with a bogus can_dlc completed normally.

Could the DLC check be limited to echo_id == GS_HOST_FRAME_ECHO_ID_RX?

> +		stats->rx_errors++;
> +		stats->rx_length_errors++;

[Severity: Low]
Can error frames be counted twice here? Take a frame with CAN_ERR_FLAG
set and can_dlc > 15, for example 0x20. The existing check earlier in
gs_usb_host_frame_header_valid() already fires for it:

	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
		if (header->can_dlc != CAN_ERR_DLC) {
			stats->rx_errors++;
			stats->rx_length_errors++;

Nothing skips the new check once valid is false, so both counters are
incremented again. That one dropped frame adds 2 to rx_length_errors
and at least 2 to rx_errors.

struct rtnl_link_stats64 in include/uapi/linux/if_link.h documents both
counters as counting packets, not individual validation failures.

> +
> +		if (net_ratelimit())
> +			netdev_err(netdev,
> +				   "out of range DLC (can_dlc=%u, max_can_dlc=%u)\n",
> +				   header->can_dlc, CAN_MAX_RAW_DLC);
> +
> +		valid = false;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-gs_usb-fixes-v9-0-db121d488945%40pengutronix.de
