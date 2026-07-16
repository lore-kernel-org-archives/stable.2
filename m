Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B8432E60;
	Thu, 16 Jul 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222383; cv=none; b=EPfieJ3RRGECtVdQfFoUaB3u7VQGjp02rXS/BfBkEUs3deCgj12ZYN5iYqQN36xmNr8OLVUCPXP6EAg2FuUTN17mhQpaWdo5UV/0I7wITcdgEQtCGqCJici2VzbMX/gbmXOA8RpIztY7M5wP5eeqHMO6awbVLHsVIOWakMjC4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222383; c=relaxed/simple;
	bh=2R3Zy3Oc2F9nEYce8EZ7zSOxqiiE9SXDn4tkjFJb78k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBFI3AyuCBrgqt+prtLiTwOONZsWeFVjrI/Am0DIXt+yigJK6sNvNaVg08I3gr3zQYzpVAuxgxEjXZDxLls7JeFtSSjaicQX640C8U2CecB8E4xCtWu8lO+SGEJE105KA69w0CJW0A6dOozXQhvPL01NGQKZ3vPTUk5jWWXTTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWk/L63J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWk/L63J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B6E1F000E9;
	Thu, 16 Jul 2026 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222380;
	bh=VvXD7P2U6C3fS9i7YGrQQGTQ6ENKTQ3zgNTKJ4lXVL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWk/L63JsjQYpZCAXpVLAyL7khKgtTCVSdT80jfQSVtD0qDMAdg1yVaZClfweL8RB
	 W8RhwpHNOuQ2YTrOzQk2vpZJKIBhZm8YX7n9izlRbfiROYq6uXGxZ+nodWZ1iZnvBm
	 59mzs6ccilIzgnosJF0UYABHwoAx4OgYq6xuzK9cIH/g9PVDhxGMm23jYQS5gJ4aJC
	 y4v20g0h6Hv3080GY/IZaVjyG1JjAzdmwz0mVRh1KkRQeWMNsKICZHna7O4Czta4Ih
	 wqabfYGC+slIX6KI3zT55/w/9Y/pXb4hf8ti5IywKx8+nTUB7j2kmF2s+2YmbSkVuh
	 9gexAZh2JGczQ==
From: Simon Horman <horms@kernel.org>
To: doruk@0sec.ai
Cc: Simon Horman <horms@kernel.org>,
	chandrashekar.devegowda@intel.com,
	ricardo.martinez@linux.intel.com,
	haijun.liu@mediatek.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: validate control-message data_length against the skb
Date: Thu, 16 Jul 2026 18:17:38 +0100
Message-ID: <20260716171737.372991-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711071338.58345-1-doruk@0sec.ai>
References: <20260711071338.58345-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH] net: wwan: t7xx: validate control-message data_length against the skb ---
commit d01ff7bcea9777a110312cfd4a96824ff782a70a
Author: Doruk Tan Ozturk <doruk@0sec.ai>

net: wwan: t7xx: validate control-message data_length against the skb
    
control_msg_handler() handles a CTL_ID_HS2_MSG control message by pulling
the ctrl_msg_header and passing the modem-supplied data_length as the
length of the handshake-2 payload to t7xx_fsm_append_event(). This commit
rejects a data_length that exceeds the received payload.

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index f869e4ed9ee9a..871ed63d3c4d2 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -186,10 +186,15 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
>  			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
>  				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
>  
> -			ret = t7xx_fsm_append_event(ctl, event, skb->data,
> -						    le32_to_cpu(ctrl_msg_h->data_length));
> -			if (ret)
> -				dev_err(port->dev, "Failed to append Handshake 2 event");
> +			if (le32_to_cpu(ctrl_msg_h->data_length) > skb->len) {
> +				dev_err(port->dev, "Invalid Handshake 2 data length\n");
> +				ret = -EINVAL;
> +			} else {
> +				ret = t7xx_fsm_append_event(ctl, event, skb->data,
> +							    le32_to_cpu(ctrl_msg_h->data_length));
> +				if (ret)
> +					dev_err(port->dev, "Failed to append Handshake 2 event");
> +			}
>  		}
>  
>  		dev_kfree_skb_any(skb);

[Severity: High]
This is a pre-existing issue, but I noticed that earlier in this function
we call skb_pull() without validating the header size against skb->len:

drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:control_msg_handler() {
    ...
	ctrl_msg_h = (struct ctrl_msg_header *)skb->data;
	switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
	case CTL_ID_HS2_MSG:
		skb_pull(skb, sizeof(*ctrl_msg_h));
    ...
}

Because skb_pull() fails silently if the length is insufficient, could this
lead to out-of-bounds reads and processing of uninitialized memory if the
modem sends a packet smaller than sizeof(struct ctrl_msg_header)?

I found a similar pattern in t7xx_port_proxy_recv_skb() where we read
ccci_header and call skb_pull() without checking if skb->len is large enough:

drivers/net/wwan/t7xx/t7xx_port_proxy.c:t7xx_port_proxy_recv_skb() {
    ...
	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
	...
	channel = FIELD_GET(CCCI_H_CHN_FLD, le32_to_cpu(ccci_h->status));
	...
	skb_pull(skb, sizeof(*ccci_h));
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but I found an issue in the
HIF CLDMA receive path where an unchecked modem-provided length is passed
directly to skb_put():

drivers/net/wwan/t7xx/t7xx_hif_cldma.c:t7xx_cldma_gpd_rx_from_q() {
    ...
	skb_put(skb, le16_to_cpu(gpd->data_buff_len));
    ...
}

If the modem provides a gpd->data_buff_len larger than the dynamically
allocated SKB's tailroom, wouldn't this trigger an skb_over_panic() and
cause a system denial of service?

[Severity: High]
This is a pre-existing issue, but it looks like we might be missing a read
memory barrier in the same receive path:

drivers/net/wwan/t7xx/t7xx_hif_cldma.c:t7xx_cldma_gpd_rx_from_q() {
    ...
	if ((gpd->flags & GPD_FLAGS_HWO) || !req->skb) {
		...
	}
	...
	skb_put(skb, le16_to_cpu(gpd->data_buff_len));
    ...
}

Since we poll for the hardware ownership flag (GPD_FLAGS_HWO) and then
read the data_buff_len without an intervening dma_rmb(), could the CPU
speculatively reorder the read of the descriptor's payload fields to occur
before the ownership flag check is globally visible?

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a missing write
memory barrier in the transmission path when setting the ownership flag:

drivers/net/wwan/t7xx/t7xx_hif_cldma.c:t7xx_cldma_gpd_handle_tx_request() {
    ...
	gpd->data_buff_len = cpu_to_le16(skb->len);

	spin_lock_irqsave(&md_ctrl->cldma_lock, flags);
	if (md_ctrl->txq_active & BIT(queue->index))
		gpd->flags |= GPD_FLAGS_HWO;
    ...
}

Because spin_lock_irqsave() only provides ACQUIRE semantics, could the
memory writes for data_buff_len be delayed past the lock and become
visible to the hardware after the GPD_FLAGS_HWO flag is set?
