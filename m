Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512664;
	b=Q+Tp/4WUO8uf58RvuhT1kn0YFmIvC1Dr9fMTmScw6DpUGpaceNpuiR1RYoQHbpEXZwQF
	 YW9Ql/eJxEX55+UiGg/QBpCL2AGIvBhU2XASLeWmkCM3EmrOQ+PfzRC8/Iab8eOtrUgif
	 av1xbomUbZnmsEl6xNdPEvnl5b9ui5luKqkHNx1JdTpQrHDOOs04JqsmtRlG4tU8Pwwry
	 gHFxG0pqLrrW5dtSd6y6ofAcTfokRKAJXfHJvgu+WXGogDMlTxQgR6KY7gnrzKPMuA2wD
	 GbsuELM/3v76A5lNsHM8ej8N8IIuJqobVhEhONbeQEqrcUlCqPAil9wMZ5xyVfzFPGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512664;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6aNvAfGgueTvpTlhUrmJk5+spY0XMUeD9zKAbtQbabo=;
	b=mDlBacx81xstcmB1QWOQJ6ZFhVxYIGGVZfW6ucLI+gAMnL9C1n4NXxB3s/MBE8MXuyKF
	 yNf/AbOc/MId/+P558LywSAIKCUqDEYjWrY0KcMNxeo9Qzg8v8PBradvtls0p5IBxGRYI
	 Fqw4aINbUAE7FTnGYlNuCCCkmMdhRroAOpEQ9ifv1RrHo0r2MggNBJiN7/GT/K9l34ElH
	 9pslAL9ZHxm0STbxzTvZQsdfA5BegPcYWL52g2EkS0F9ClNhcdtK3/Ypf9VTVqVl27ffL
	 ryh4GsMqlse9OavRDIh6b7IdJkQAGQdVJNl0h6Ouh5oyrbiNzI4vi+b5m6k2PBZ8Xag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy74G+j+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA4606A33E;
	Tue, 24 Nov 2026 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy74G+j+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7531F000EE;
	Tue, 24 Nov 2026 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512664;
	bh=6aNvAfGgueTvpTlhUrmJk5+spY0XMUeD9zKAbtQbabo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jy74G+j+WNX7ce4LmqsrOOeZ4DCc4ClvZmWGOMQtdDp0s40fEKAvw9AgTrcLT0zdw
	 t8KB04nBI36uakMU8qG0OeVsuXo1ifP1dx9csy+ln+9TiVPHC8i0Hp2cyDlGUrrGCJ
	 7+BIZ4dkKrBwPZpeLKdCbbpmpzsZziFufqG0F1xJDWmY23/Lnh733yuieHOQMBl5SN
	 9LIeTpVGxUa51i3zEhmj7NLVb+zRtDBu91ntPjxza58SNkLDDLeLI847OOgy8lygMl
	 eRbYkMmU7WForCl9uWis7lkTkjT6ccpL9fCElzGi2SWfxJZWeYdCLugdKPJvAdjsZt
	 iDD2yI5qASqMQ==
Subject: Re: [PATCH can-next v10 12/14] can: gs_usb: gs_can_start_xmit(): mask
 invalid parts of CAN ID before sending
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:31:03 +0000
Message-ID: <179551266332.3131.13201472550336097370@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-12-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-12-7c165c35d04a@pengutronix.de>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message names the wrong macro.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  gs_can_start_xmit() sends uninitialized kernel heap memory to the USB…

--

can: gs_usb: gs_can_start_xmit(): mask invalid parts of CAN ID before sending

This commit masks the CAN ID in gs_can_start_xmit() before the frame is
sent to the device. Flags that are not valid in the TX path are removed,
and the ID is limited to 11 or 29 bits depending on CAN_EFF_FLAG.
CAN_RTR_FLAG is kept only for CAN-CC frames.

> - CAN_ERR_MASK is used exclusively in the receive path between the
>   driver and user space to signal problems with the CAN controller.

[Severity: Low]
Should this bullet say CAN_ERR_FLAG instead of CAN_ERR_MASK?

include/uapi/linux/can.h has:

#define CAN_ERR_FLAG 0x20000000U /* error message frame */
#define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */

CAN_ERR_MASK has the same value as CAN_EFF_MASK. In gs_can_start_xmit(),
the new EFF masks keep every CAN_ERR_MASK bit and drop only CAN_ERR_FLAG:

    can_id &= CAN_EFF_MASK | CAN_EFF_FLAG;
    ...
    can_id &= CAN_EFF_MASK | CAN_RTR_FLAG | CAN_EFF_FLAG;

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 4aa674c743f67..b345ab34a200a 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -1006,8 +1012,14 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
>  		memcpy(hf->canfd->data, cfd->data, cfd->len);
>  	} else {
>  		cf = (struct can_frame *)skb->data;
> +		canid_t can_id = cf->can_id;
> +
> +		if (can_id & CAN_EFF_FLAG)
> +			can_id &= CAN_EFF_MASK | CAN_RTR_FLAG | CAN_EFF_FLAG;
> +		else
> +			can_id &= CAN_SFF_MASK | CAN_RTR_FLAG;
>  
> -		hf->can_id = cpu_to_le32(cf->can_id);
> +		hf->can_id = cpu_to_le32(can_id);
>  		hf->can_dlc = can_get_cc_dlc(cf, dev->can.ctrlmode);
>  
>  		memcpy(hf->classic_can->data, cf->data, cf->len);

[Severity: High]
This isn't a bug introduced by this patch, but does gs_can_start_xmit()
send uninitialized kernel heap memory to the USB device?

The TX buffer is not zeroed when it is allocated:

    hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);

The function writes only the header fields plus cf->len (0..8) or
cfd->len (0..64) payload bytes. It then submits the whole buffer:

    usb_fill_bulk_urb(urb, dev->udev,
                      dev->parent->pipe_out,
                      hf, dev->hf_size_tx,
                      gs_usb_xmit_callback, txc);

When CAN_CTRLMODE_FD is enabled, gs_can_open() sizes the buffer for a
64 byte payload, even when the frame is classic CAN:

    dev->hf_size_tx = struct_size(hf, canfd, 1);

In FD mode, a classic frame leaves at least 56 data bytes unwritten. A
short or zero-length FD frame leaves up to 64. The quirk byte in
classic_can_quirk and canfd_quirk (LPC546XX devices) is never written
either.

That would expose leftover slab contents with every transmitted frame,
to the device or to anyone sniffing the bus. Would kzalloc(), or a
memset() of the area after the copied payload, fix this?

Later patches in this series do not seem to address it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
