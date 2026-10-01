Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B472DF6E6;
	Thu,  1 Oct 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876360; cv=none; b=t3TbGgSRaq+UAz+cCM5+EtLCUaag98TxqJ56VEXYkkm/9NQCpVWeiqubK4uhZiMHZbBWtC034FlNEbfn0djU9Qvds6L1D1/pwKcQk83o6sxCNUnFtL3NuhHd8/9CIk0kPnGS6HyjZkWuAO+N0luzsgIPyt33jrC36ze3mlB8Y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876360; c=relaxed/simple;
	bh=3AnBrlFtlpDzLVxH/zDW23dDoB0PDoNLlzth8ZTAM8k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T7nQbfokvq7PVkObWhv668iNruV9fcbvB1wA5UA/ZiaBwMvEn9XZBL7pkSwp/TPN/zYcGLnfz0tDhJ2Kw9ZBfpm3e+mkppYr9GhY0ZtpPC55zadDqNZDyB9CtDl234Oz0NbwHRacY3jjRYlB14qyGKx+GUrsQbFYEjIm9C0UrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCSq0uc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCSq0uc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B701F000FF;
	Thu,  1 Oct 2026 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790876358;
	bh=lgqeNL93HiCcB16MEYCbQ841RII6fEAvBZGg+LCWL6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JCSq0uc3PcgXpPzLrVev4kJd3GxtIlujXolWVJRGnR9Zv5awb87sDMDPPnhkzJpsH
	 I7B5l8/YW0iyJlXF7K51NohG6h6HoPg/OGzl0sW5KucivPrDyjzpYpX8bczHBOZYAt
	 luSbJYzLfvCB46lKD9j9YlZxDBBCEsOdl4cPo5nNL4SjoIVfblCcC/affa6vXdhssX
	 uVrjSRPCfeLbvbD9RBNJ+BHKbaf7krSam2jKwWPP5rNyQeFWV3eUG9CsQjtSZxDspm
	 V+9CPgBv9k6HkXpovfvb9EWP5/k0jBYMhxsC6EG/XEoS/3CO0dbnwaEhaTK6rHksHa
	 ppNoirj3DO8rw==
Subject: Re: [PATCH v2] net: wwan: t7xx: validate the HS2 message data length
From: netdev-bot+sashiko@kernel.org
To: zhugl3@xiaopeng.com
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, guozh23@xiaopeng.com
Date: Thu, 01 Oct 2026 17:39:17 +0000
Message-ID: <179087635719.434549.7704184034967242243@kernel.org>
In-Reply-To: <20260929023914.247374-1-zhugl3@xiaopeng.com>
References: <20260929023914.247374-1-zhugl3@xiaopeng.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch checks the control-header length in only one place:
  inside the CTL_ID_HS2_MSG arm of control_msg_handler()…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  control_msg_handler() in drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c…
- [Medium] When t7xx_core_hk_handler() fails, it jumps to err_free_event
  without clearing core_info->handshake_ongoing.
- [Low] The kernel-doc for t7xx_port_enum_msg_handler() in
  drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c lists only 0 and -EFAULT as…

--

net: wwan: t7xx: validate the HS2 message data length

In control_msg_handler(), this patch rejects a CTL_ID_HS2_MSG message
when it is shorter than struct ctrl_msg_header, or when its data_length
is larger than what is left in the skb. It also makes
t7xx_prepare_device_rt_data() reject a runtime data payload shorter
than struct feature_query.

> diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> index adb29d30c63fe..de689aa3f8822 100644
> --- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> +++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c

[ ... ]

> @@ -563,7 +568,8 @@ static void t7xx_core_hk_handler(struct t7xx_modem *md, struct t7xx_sys_info *co
>  	if (ctl->exp_flg)
>  		goto err_free_event;
>  
> -	ret = t7xx_prepare_device_rt_data(core_info, dev, event->data);
> +	ret = t7xx_prepare_device_rt_data(core_info, dev, event->data,
> +					  event->length);
>  	if (ret) {
>  		dev_err(dev, "Device failure parsing runtime data: %d", ret);
>  		goto err_free_event;

[Severity: Medium]
This isn't a bug introduced by this patch, but the new data_length
check in t7xx_prepare_device_rt_data() is one more way into this
error path. The err_free_event path leaves core_info->handshake_ongoing
set.

A zero-length HS2 payload, or a t7xx_parse_host_rt_data() failure,
already reached the same path before this patch.

Suppose t7xx_md_hk_wq() exits here while t7xx_ap_hk_wq() is still
waiting. When fsm_routine_starting() later times out, it runs:

	if (!md->core_md.ready) {
		dev_err(dev, "MD handshake timeout\n");
		if (md->core_md.handshake_ongoing)
			t7xx_fsm_append_event(ctl, FSM_EVENT_MD_HS2_EXIT, NULL, 0);

		fsm_routine_exception(ctl, NULL, EXCEPTION_HS_TIMEOUT);
		return -ETIMEDOUT;

It returns without appending FSM_EVENT_AP_HS2_EXIT.

Nothing is left to consume FSM_EVENT_MD_HS2_EXIT. The MD worker is
gone, and the AP worker only matches FSM_EVENT_AP_HS2 and
FSM_EVENT_AP_HS2_EXIT.

The AP worker waits in t7xx_core_hk_handler() on:

		wait_event_interruptible(ctl->event_wq, !list_empty(&ctl->event_queue) ||
					 kthread_should_stop());

That wait returns at once while the queue is non-empty, and
kthread_should_stop() is always false in a kworker.

Could the AP kworker busy-loop here until an AP HS2 message arrives or
the next MD handshake clears the stale event?

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index f869e4ed9ee9a..5ed07c406a5ed 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -178,22 +178,39 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
>  
>  	ctrl_msg_h = (struct ctrl_msg_header *)skb->data;
>  	switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
> -	case CTL_ID_HS2_MSG:
> -		skb_pull(skb, sizeof(*ctrl_msg_h));
> +	case CTL_ID_HS2_MSG: {
> +		u32 data_length;
> +
> +		if (skb->len < sizeof(*ctrl_msg_h)) {
> +			dev_err(port->dev,
> +				"Invalid HS2 message: need %zu, have %u\n",
> +				sizeof(*ctrl_msg_h), skb->len);
> +			ret = -EINVAL;
> +			dev_kfree_skb_any(skb);
> +			break;
> +		}

[Severity: Medium]
The commit message says:

  Reject the message when it is shorter than the control header

The check is only in the CTL_ID_HS2_MSG arm, though. By the time it
runs, the switch has already read ctrl_msg_h->ctrl_msg_id to pick the
arm.

Nothing upstream sets a minimum length. t7xx_port_proxy_recv_skb()
calls skb_pull(skb, sizeof(*ccci_h)) and forwards whatever is left, so
skb->len here can be anywhere from 0 to 11.

For such a message, the CTL_ID_MD_EX* and CTL_ID_DRV_VER_ERROR arms
still call fsm_ee_message_handler(). It logs ctrl_msg_h->ex_msg and
uses it to decide whether to reply to the modem and queue
FSM_EVENT_MD_EX or FSM_EVENT_MD_EX_REC_OK, without any length check:

	case CTL_ID_MD_EX:
		if (le32_to_cpu(ctrl_msg_h->ex_msg) != MD_EX_CHK_ID) {

The CTL_ID_PORT_ENUM arm still has the same no-op skb_pull() the
commit message describes. Only the msg_len check in
t7xx_port_enum_msg_handler() rejects the message there.

These reads stay inside the CLDMA RX buffer, so there is no heap
overread. However, stale buffer contents still decide which arm runs
and whether replies and FSM events are generated.

Would a single skb->len < sizeof(*ctrl_msg_h) check before the switch
(free the skb, return -EINVAL) cover all arms, instead of the check
inside the HS2 arm?

[ ... ]

>  		dev_kfree_skb_any(skb);
>  		break;
> +	}
>  
>  	case CTL_ID_MD_EX:
>  	case CTL_ID_MD_EX_ACK:

[Severity: High]
This isn't a bug introduced by this patch, but since this function is
being changed anyway: do the CTL_ID_PORT_ENUM and default arms of
control_msg_handler() leak the skb?

port_ctl_rx_thread() passes ownership to the handler and never frees
the skb itself:

		skb = __skb_dequeue(&port->rx_skb_list);
		spin_unlock_irqrestore(&port->rx_wq.lock, flags);

		control_msg_handler(port, skb);

The HS2 and MD_EX arms call dev_kfree_skb_any(). These two arms do
not, and nothing frees the skb after the switch:

	case CTL_ID_PORT_ENUM:
		skb_pull(skb, sizeof(*ctrl_msg_h));
		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
		...
		break;

	default:
		ret = -EINVAL;
		dev_err(port->dev, "Unknown control message ID to FSM %x\n",
			le32_to_cpu(ctrl_msg_h->ctrl_msg_id));
		break;

If so, every port enumeration message leaks a whole CLDMA RX buffer
(3584 bytes on shared queues, about 63KB on the jumbo queue), and so
does every message with an unknown ctrl_msg_id. The modem controls
this input and can send it over and over.

[Severity: Low]
This is a pre-existing issue, but the kernel-doc for
t7xx_port_enum_msg_handler() lists only 0 and -EFAULT as return values:

 * Return:
 * * 0		- Success.
 * * -EFAULT	- Message check failure.

The function also returns -EINVAL from both length checks:

	if (msg_len < sizeof(*port_msg)) {
		...
		return -EINVAL;
	}
	...
	if (msg_len < struct_size(port_msg, data, port_count)) {
		...
		return -EINVAL;
	}

Should -EINVAL be added to the kernel-doc?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929023914.247374-1-zhugl3%40xiaopeng.com
