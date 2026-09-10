Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700B35E948;
	Thu, 10 Sep 2026 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019223; cv=none; b=QKbIhbcgIAFVzBSNKRR9t3zwEHXDkFBS5FTl/Sgj6GpE2VzXRjrGsiSn/QWiSpfMftxX3dU5bf9pexfyf5QKoGm2XSpRWPhCjNl4JT5gL/m8IxU4BIOnw95o1oEJuI12l8FvVOt9tQTgFIOrr//t8sq2WTuYVAo3kDn5B2anFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019223; c=relaxed/simple;
	bh=qs6Z8CFzvZFim5aACpS8p+XZllCkNji2gLarIBZz/zY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNlL6EQsaXhnKAWm9DuJ7Ufl1u9c7R2CNG44HWF3n5Tgzue6oMjHFd7c33rarPX+RamtKEjSwvNkwXKrU4JKC0xIebn93Bzrc2gu8kLkNQ4xYLmwnX69H+tcI7Y3GIStWdrDYF240Aa0ZVEevVRjn61JjQu+mP+o7pNHf5LZyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGTy2Ig6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGTy2Ig6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F21F000FF;
	Thu, 10 Sep 2026 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789019221;
	bh=df1IwpVaY4WEHXnsjUW+GtbrSC7JurnzMcxUU78FhQI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kGTy2Ig64ZSEsubsoZpTqOTNknz69H5wBtElBb2s8p0wS+N/xbXW0Viyag1MeC/lh
	 vRPispeKS77vxe08YZYiW9/V1AOA37JklbNjaw52v2jvylAfOLWNA/gfXavKKaUCD6
	 8DBs/ndOgFhVs2TSqSGAfETIQ17dpVdNtPToynHR24fEAScScK7OWGUz2Q6kIUec8+
	 brLOn/6gB8SasA4HiVIQ+dhrjBBBhnpJ7Rd9QFJ717VI0SPNYgw0g1tu0xsq5MXc2w
	 PI/5uFyfDpLiDM2hJXIEgiqaW/QAM4SZ/Anbk2BTW96Fb+gQs5Lnrz3vwahSEoZdL3
	 w+pNxOhwBej2Q==
Subject: Re: [PATCH] net: wwan: t7xx: validate the HS2 message data length
From: netdev-bot+sashiko@kernel.org
To: zhugl3@xiaopeng.com
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 05:46:59 +0000
Message-ID: <178901921967.219967.14297389311939486523@kernel.org>
In-Reply-To: <20260909054401.718959-1-zhugl3@xiaopeng.com>
References: <20260909054401.718959-1-zhugl3@xiaopeng.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (2) · Medium: 1 · Low: 0

- [High] The new validation in control_msg_handler() bounds the modem-
  supplied data_length only from above (`data_length > skb->len`).
- [Medium] control_msg_handler()
  (drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:179-205) never verifies…

Pre-existing issues:
- [High] control_msg_handler() owns the skb dequeued by
  port_ctl_rx_thread() (drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c:262…
- [High] t7xx_cldma_gpd_rx_from_q()
  (drivers/net/wwan/t7xx/t7xx_hif_cldma.c:159-161) passes the device-…

--

net: wwan: t7xx: validate the HS2 message data length

This adds a bound on the modem-supplied data_length field of a
CTL_ID_HS2_MSG control message before it is handed to
t7xx_fsm_append_event(), rejecting the message when data_length is
larger than the remaining skb length.

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index f869e4ed9ee9..0f2ead8a7caa 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -178,22 +178,32 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
>  
>  	ctrl_msg_h = (struct ctrl_msg_header *)skb->data;
>  	switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
> -	case CTL_ID_HS2_MSG:
> +	case CTL_ID_HS2_MSG: {
> +		u32 data_length;
> +
>  		skb_pull(skb, sizeof(*ctrl_msg_h));
> +		data_length = le32_to_cpu(ctrl_msg_h->data_length);

[Severity: Medium]
Is the new bound sound when the message is shorter than the control
header itself?  Nothing in control_msg_handler() checks that skb->len is
at least sizeof(struct ctrl_msg_header) (12 bytes), and the return value
of skb_pull() is discarded:

include/linux/skbuff.h:
	static inline void *skb_pull_inline(struct sk_buff *skb, unsigned int len)
	{
		return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
	}

So for a 0..11 byte message the pull is a no-op: skb->data still points
at the control header and skb->len still counts those header bytes.  The
subsequent data_length > skb->len test is then evaluated against the
wrong length, and t7xx_fsm_append_event() stores control-header bytes as
if they were HS2 payload.

The read of ctrl_msg_h->data_length itself is at offset 8..11, which is
past skb->tail for such a short message, i.e. it reads the uninitialized
part of the skb data area allocated in t7xx_cldma_alloc_and_map_skb().

The length reaching here is fully device-controlled, with no floor
anywhere upstream:

t7xx_hif_cldma.c:t7xx_cldma_gpd_rx_from_q() {
	...
	skb_put(skb, le16_to_cpu(gpd->data_buff_len));
	...
}

t7xx_port_proxy.c:t7xx_port_proxy_recv_skb() {
	...
	skb_pull(skb, sizeof(*ccci_h));

	ret = port_conf->ops->recv_skb(port, skb);
	...
}

Would it be worth adding the same header floor the enumeration path
already has, before the pull?

	if (skb->len < sizeof(*ctrl_msg_h))
		return -EINVAL;

t7xx_port_enum_msg_handler() does this for its own header:

	if (msg_len < sizeof(*port_msg)) {
		dev_err(dev, "Port enum msg too short for header: need %zu, have %zu\n",
			sizeof(*port_msg), msg_len);
		return -EINVAL;
	}

>  
>  		if (port_conf->rx_ch == PORT_CH_CONTROL_RX ||
>  		    port_conf->rx_ch == PORT_CH_AP_CONTROL_RX) {
>  			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
>  				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
>  
> -			ret = t7xx_fsm_append_event(ctl, event, skb->data,
> -						    le32_to_cpu(ctrl_msg_h->data_length));
> -			if (ret)
> -				dev_err(port->dev, "Failed to append Handshake 2 event");
> +			if (data_length > skb->len) {
> +				dev_err(port->dev, "Invalid HS2 message length %u\n",
> +					data_length);
> +				ret = -EINVAL;
> +			} else {
> +				ret = t7xx_fsm_append_event(ctl, event, skb->data,
> +							    data_length);
> +				if (ret)
> +					dev_err(port->dev, "Failed to append Handshake 2 event");
> +			}

[Severity: High]
Should data_length also be bounded from below here?  Only the upper
bound is enforced, so data_length == 0 (or anything smaller than
sizeof(struct feature_query), 72 bytes) is accepted and becomes the FSM
event payload length.

t7xx_fsm_append_event() sizes the allocation from that value:

t7xx_state_monitor.c:t7xx_fsm_append_event() {
	...
	event = kmalloc_flex(*event, data, length,
			     in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
	...
	event->length = length;

	if (data && length)
		memcpy(event->data, data, length);
	...
}

with the payload being a counted flexible array:

t7xx_state_monitor.h:
	struct t7xx_fsm_event {
		struct list_head	entry;
		enum t7xx_fsm_event_state event_id;
		unsigned int		length;
		unsigned char		data[] __counted_by(length);

The consumer of that payload does not look at event->length:

t7xx_modem_ops.c:t7xx_core_hk_handler() {
	...
	ret = t7xx_prepare_device_rt_data(core_info, dev, event->data);
	...
}

t7xx_modem_ops.c:t7xx_prepare_device_rt_data() {
	struct feature_query *md_feature = data;
	...
	if (le32_to_cpu(md_feature->head_pattern) != MD_FEATURE_QUERY_ID ||
	    le32_to_cpu(md_feature->tail_pattern) != MD_FEATURE_QUERY_ID) {
	...
}

With data_length == 0 that reads 72 bytes (head_pattern,
feature_set[64], tail_pattern) out of a 24-byte allocation, and the
out-of-bounds feature_set bytes are then echoed back to the device in
the HS3 reply via rt_feature->support_info = md_feature->feature_set[i].
The length-aware t7xx_parse_host_rt_data() called just before it simply
returns 0 for a short payload, since its loop condition is
offset < data_length with offset starting at sizeof(struct
feature_query).

Would rejecting data_length < sizeof(struct feature_query) here, or
making t7xx_prepare_device_rt_data() length-aware, be preferable to the
max-only check?

>  		}
>  
>  		dev_kfree_skb_any(skb);
>  		break;
> +	}
>  
>  	case CTL_ID_MD_EX:
>  	case CTL_ID_MD_EX_ACK:

Two more observations about surrounding code that the same malformed
control messages reach:

[Severity: High]
This isn't a bug introduced by this patch, but does control_msg_handler()
leak the RX skb for two of the switch arms it is being modified in?
port_ctl_rx_thread() hands ownership over and never frees it:

	skb = __skb_dequeue(&port->rx_skb_list);
	spin_unlock_irqrestore(&port->rx_wq.lock, flags);

	control_msg_handler(port, skb);

Only the CTL_ID_HS2_MSG and CTL_ID_MD_EX* arms call
dev_kfree_skb_any().  The enumeration arm returns without freeing:

	case CTL_ID_PORT_ENUM:
		skb_pull(skb, sizeof(*ctrl_msg_h));
		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
		...
		break;

and so does the unknown-message arm:

	default:
		ret = -EINVAL;
		dev_err(port->dev, "Unknown control message ID to FSM %x\n",
			le32_to_cpu(ctrl_msg_h->ctrl_msg_id));
		break;

t7xx_port_enum_msg_handler() only parses the buffer, and
port_ctl_send_msg_to_md() allocates a fresh skb through
t7xx_ctrl_alloc_skb(), so neither takes ownership.  Since ctrl_msg_id is
modem-supplied, can a modem repeatedly sending an unrecognized
ctrl_msg_id leak one RX skb (CLDMA_SHARED_Q_BUFF_SZ, 3584 bytes, plus
skb overhead) per message without bound?

[Severity: High]
This is a pre-existing issue and not something this patch introduces,
but it is the same modem-supplied length trust boundary one layer down.
Can t7xx_cldma_gpd_rx_from_q() panic on a device-reported GPD length
larger than the RX buffer?

t7xx_hif_cldma.c:t7xx_cldma_gpd_rx_from_q() {
	...
	skb->len = 0;
	skb_reset_tail_pointer(skb);
	skb_put(skb, le16_to_cpu(gpd->data_buff_len));
	...
}

gpd->data_buff_len is a __le16 written by the device, so up to 65535,
while the skb comes from __dev_alloc_skb(queue->tr_ring->pkt_size) with
pkt_size being CLDMA_SHARED_Q_BUFF_SZ (3584),
CLDMA_DEDICATED_Q_BUFF_SZ (2048) or CLDMA_JUMBO_BUFF_SZ (64528).  The
only limit given to the hardware is advisory:

t7xx_hif_cldma.c:t7xx_cldma_ring_init() {
	...
	gpd->rx_data_allow_len = cpu_to_le16(ring->pkt_size);
	...
}

Nothing re-checks the returned length against pkt_size or the skb
tailroom, so a length beyond the buffer would take skb->tail past
skb->end and hit skb_over_panic() -> BUG().  Would a check of
data_buff_len against tr_ring->pkt_size before the skb_put() be
appropriate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909054401.718959-1-zhugl3%40xiaopeng.com
