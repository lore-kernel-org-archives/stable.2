Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512655;
	b=Zox6aJeL2X5X0rxRUbsSmp0BXAg8a1WBJhBqqqrm7C8pFFYhH3LFtNwHnqrl6WmDPixj
	 5tR3mKeYEwatM/+VH6f6W8ZTPf1jnaF6P3l9EXawCPUSDNwNS99f6vm3g5kiSJFZb0EH0
	 7CcX9htSfYgQnxYrTIjleMVIf0X1hopYCVyM1ltbSeBlW5GXzxMPnQjVwLD6vYcKn5La2
	 ZxUaqpNXkbB+Zmk6mDypoWTvts7atmYZVR/fw8naoK2C6NQk0ooIsYlFSNfTzw/4lCaKK
	 9ElMwQTdtNlQ4gmqHruMK91JUNaz7e6B7Tjwf98lf7ZXbASwLyCqAz7GHEN9kRsFZhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512655;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gyvQNr+4EvcEUbCX+ebNXaAU/jp2CoN2a24T02dVql0=;
	b=r9mo+YBwlP7A050+H2TOgUgcXyI4tc2z3e3tBdG5PUMHOiT0R5RfwfeUMsxJIKqNm8Xk
	 ammHQ9/59eC2heO3j054hfCwo92tQip+mbkmM5MgZm0gvJrz48hkJ8H+fzt1tsnSJJEGu
	 2YkAKc/zExDOxxXDCnhwQ+sT0tH4OHBv63PDRVHCtVvVOLDKAeB2jdN8S1sZU916L3+Uq
	 eF3l8bvptv0w1Vr4qiE3jqVa/DLmeE7s/gdMDBY+N1xfy9LPSrbaZirrY2ZaFKAqrFxjg
	 YabJiKERwlkRMswa+QfsMg8YW2U2aeA/zyeK4BnNrGv5CFTG3jJ1iIIxTArXXOq8URQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ch3PndU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D3606A33C;
	Tue, 24 Nov 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ch3PndU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDF41F000C0;
	Tue, 24 Nov 2026 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512654;
	bh=gyvQNr+4EvcEUbCX+ebNXaAU/jp2CoN2a24T02dVql0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ch3PndU+2YYHTrFzCzDB4fv9JRggxu8vuDFnzgJAypRbJsk1qUxHz8+eEF19EAwEN
	 Fk7A7ijZz8wH4JwpRrAcEkmy3+2bluqa1Cmv4sxXK9bJFL8HLjGE0jaxjjE8wdZzMH
	 6BWaaOJiA8PQQ1FiLV4orBv1CB/eVK0RCymR5Nwqlt74f9RjNnzQ+piLLzFzb+b0b8
	 t8z4zsh4G6mTYQbLqolhJMoFs72B15fCvozB2L00K16iVCYEQFNw1QV7YPQYOTq6Lv
	 26RzJ7hrM/QBjOdDVq2DCIsRT5RrjkDfuDhprdSr4U7vYjIaNt+TDABouXeOdeefMe
	 WYOfCftverbWw==
Subject: Re: [PATCH can-next v10 02/14] can: gs_usb:
 gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation
 fails
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:30:53 +0000
Message-ID: <179551265385.3131.15670583860360674202@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-2-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-2-7c165c35d04a@pengutronix.de>
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

- [Medium] In gs_usb_receive_bulk_callback()
  (drivers/net/can/usb/gs_usb.c), the CAN-CC RX branch now handles an…

--

can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails

When the RX SKB allocation fails in gs_usb_receive_bulk_callback(), this
commit increments rx_dropped. It then jumps to the overflow flag check
instead of resubmitting the URB right away. This applies to both the
CAN-FD and CAN-CC receive paths.

Closes: https://sashiko.dev/#/bug/linux-7b3fe6a0-4628-4d0e-aec0-69f4bf8ad5d4

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index d1124c49460e3..9e8567544c882 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -686,8 +689,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  			memcpy(cfd->data, hf->canfd->data, data_length);
>  		} else {
>  			skb = alloc_can_skb(netdev, &cf);
> -			if (!skb)
> -				goto resubmit_urb;
> +			if (!skb) {
> +				stats->rx_dropped++;
> +
> +				goto check_overflow;
> +			}
>  
>  			cf->can_id = le32_to_cpu(hf->can_id);
>  			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

[Severity: Medium]
Does this goto also skip the controller state update for error frames?
A few lines further down in the same CAN-CC branch of
gs_usb_receive_bulk_callback() there is:

	/* ERROR frames tell us information about the controller */
	if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
		gs_update_state(dev, cf);

gs_update_state() is the only place in the RX path that sets
dev->can.state. It is also the only place that increments the can_stats
counters restarts, bus_off, error_warning and error_passive. It reads
these values from cf, so it cannot run when alloc_can_skb() fails:

gs_update_state() {
	...
	if (cf->can_id & CAN_ERR_RESTARTED) {
		dev->can.state = CAN_STATE_ERROR_ACTIVE;
		can_stats->restarts++;
	} else if (cf->can_id & CAN_ERR_BUSOFF) {
		dev->can.state = CAN_STATE_BUS_OFF;
		can_stats->bus_off++;
	...
}

Suppose the device sends a host frame with CAN_ERR_FLAG and
CAN_ERR_BUSOFF, CAN_ERR_RESTARTED or CAN_ERR_CRTL set, and the
GFP_ATOMIC allocation fails. Would dev->can.state then stay stale, for
example ERROR_ACTIVE while the controller is bus-off? Would the
can_device_stats counters reported to userspace under-count?

The old goto resubmit_urb skipped this too. However, the commit message
says the failure path "neither updates the statistics nor checks whether
an overflow flag is set", and after this change the can_stats and state
accounting are still skipped on that path.

Could the state be decoded from hf->can_id and hf->classic_can->data[1],
so it is applied even without an skb? Several other CAN drivers
(at91_can.c, mcp251xfd-core.c, rockchip_canfd-core.c, esdacc.c and
pcan_usb_fd.c) call can_change_state() with cf == NULL for this reason.
Some of them carry comments like "things must be done even in case of
OOM".

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
