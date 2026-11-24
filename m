Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512668;
	b=g3IilPqZScjtUDP3MJhPvSRZOzehspxW6++pe/xYs2UgLNwLmTEAN1Z/W+soyi4fIpbl
	 bt7w5h/uzjogvoyGoeFEAN2EYN6ZhXoejNCdZAbQUkFWOByqj3TnciHTox6mZ9vx1roM9
	 Y82/2npSQpIMcegPymhy8eft9oBfZK81T0tD0t2cjz0b7GNE9vhrCyNEvF+H5UyXCyBmU
	 cCJRX1u9SexXfvw3/rNEDYEhGHBAlgnDN4EsDUOfmVLYjww0hashTEXoD/a0id4AsV8gf
	 i1LE5Sh+gAXIjFgmlzuwESoolaln46MAu1yEinVEOoU5NVMciqRMcTWbxOHXUhuFStQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512668;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zwpk2HtrDkk2RVyDBioMiVcOMH6ocx4IB03S8a23t8U=;
	b=ZaSr8FeI8n8lVr64Yj89BBBGTNwT8NS1xphG9P84hlFSjUm5Lpoq9WXTQdaIhgzP7a0T
	 972xuk6Aahhz2CNaGH+XxAByc6iIC8KsuyWwxNzK/vKMW4I1CAOMGnBmKrXuVgoaS6VDq
	 1sPfP5uZGdb+iVym35z8vMDISR+d2jIM925Qbi0UUCFnRK8VaxWTbTWqjNdzecHw35lkQ
	 KqvtdTqysYcmQxoFHv4IjddCpdAW0ok+C6On4cEZF0UeGItqSi4A6rLMyai+55+DGOy6f
	 yLaDzU7pyU054JWEpq09aQ2SWVg7KgTf+e60jJhTPZcIHVdVTUY5/JUPc60i/9i3p7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAI5xrfR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D18606A336;
	Tue, 24 Nov 2026 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAI5xrfR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A4E1F000C6;
	Tue, 24 Nov 2026 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512667;
	bh=zwpk2HtrDkk2RVyDBioMiVcOMH6ocx4IB03S8a23t8U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CAI5xrfR+gbCwZ3/uuRPQH9dqmDvykKXkEdj9A/Le0yo3/1NgdJ8i972Cac9sMEcp
	 GKN9wyJ2YUrfJ7jndqMcs3hoKOaSmts5s7to7SPvRbZ0W8CT7XDOTtekqoMrPOXMLh
	 F5qMla//Z/l4cRLY8G2L1HZaqmO/zlSQhVaMcBN82HWfT7ODtkVU25uHMt1Fk4m9kE
	 lUhu1kILbqFSrT7eMDC/wxtT5UNVqF6WVQr7Ql6IinAMvUJJK5pUv+rRCWkchD35rS
	 3owfeRbKGmuRs04FIIvDeFrD94F/23NB5Ob51MfANuvDeK+YWduOr0OYOR2gBzqJvL
	 m4T9G3uuv6/WA==
Subject: Re: [PATCH can-next v10 14/14] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:31:06 +0000
Message-ID: <179551266677.3131.6488994858051921423@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-14-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-14-7c165c35d04a@pengutronix.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In gs_usb_host_frame_header_valid()
  (drivers/net/can/usb/gs_usb.c), an RX CAN error frame (CAN_ERR_FLAG…
- [Low] The commit "can: gs_usb: gs_usb_host_frame_header_valid(): drop
  CAN frames with invalid DLC" fixes a user-visible bug that comes from…

--

can: gs_usb: gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC

This commit adds a check to gs_usb_host_frame_header_valid() that drops
received CAN frames with a DLC above 0xf. It updates the rx error
counters, logs a rate-limited error and resubmits the URB.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de

> According to the respective CAN standards, the maximum DLC length for
> CAN-CC and CAN-FD frames is 0xf. The code in driver assumes that this limit
> has been verified.
>
> Drop CAN frames with DLC > 0xf, print a error message and resubmit the URB.

[Severity: Low]
Should this patch have a Fixes: tag and Cc: stable? The commit message
also doesn't say what goes wrong without the check.

Before this patch, gs_usb_receive_bulk_callback() passed the raw device
DLC to the helper unchecked:

    can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

The helper in include/linux/can/length.h assumes the range has already
been checked:

    /* the caller already ensured that dlc is a value from 0 .. 15 */
    if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
        cf->len8_dlc = dlc;

With CAN_CTRLMODE_CC_LEN8_DLC enabled, a USB device sending can_dlc
0x10..0xff gives userspace a struct can_frame with len8_dlc above
CAN_MAX_RAW_DLC. For CAN-FD, can_fd_dlc2len() masks the DLC with 0x0F, so
a DLC of 0x1X is accepted with a different payload length.

gs_make_candev() has advertised CAN_CTRLMODE_CC_LEN8_DLC since commit
4c01fc87675e ("can: drivers: add len8_dlc support for various CAN
adapters"). That commit looks like a reasonable Fixes: target.

Other gs_usb fixes in the same series carry Fixes: and Cc: stable, for
example "can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to
can_rx_offload_irq_finish". Could this one get the same tags, plus a
sentence on the user-visible effect?

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 7229d002b938a..5e8ea308fabf5 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -668,6 +668,20 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
>  		}
>  	}
>  
> +	/* we can check for max CAN-CC and CAN-FD DLC at the same time, they are both 0xf */
> +	BUILD_BUG_ON(CAN_MAX_RAW_DLC != CANFD_MAX_DLC);
> +	if (header->can_dlc > CAN_MAX_RAW_DLC) {
> +		stats->rx_errors++;
> +		stats->rx_length_errors++;

[Severity: Medium]
Can a single error frame be counted twice here?

Take an RX frame with CAN_ERR_FLAG set in can_id and can_dlc in 16..255.
The existing error-frame block earlier in
gs_usb_host_frame_header_valid() already counts it and keeps going
instead of returning:

    if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
        if (header->can_dlc != CAN_ERR_DLC) {
            stats->rx_errors++;
            stats->rx_length_errors++;
            ...
            valid = false;
        }

This new check then runs for the same frame and increments rx_errors and
rx_length_errors again. It also logs a second error message.

gs_usb_get_rx_data_length() drops exactly one frame here, but both
counters go up by 2. If CAN_RTR_FLAG is also set, rx_errors goes up
by 3.

include/uapi/linux/if_link.h defines rx_length_errors as "Number of
packets dropped due to invalid length", so this would over-count.

Would it work to make the new range check an else branch of the
error-frame DLC check? Another option is to update the counters once at
the end of the function when valid is false.

> +
> +		if (net_ratelimit())
> +			netdev_err(netdev,
> +				   "out of range DLC (can_dlc=%u, max_can_dlc=%u)\n",
> +				   header->can_dlc, CAN_MAX_RAW_DLC);
> +
> +		valid = false;
> +	}
> +
>  	return valid;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
