Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4632470E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415670; cv=none; b=MN4Joi984h3RY3+nlx19ZpQ2SW7VS6SYz3xXJsQ83r1zxAMnpeo0TMDNW8fzXOopFlimrnR5lLWcGNGvS3AU70YcEIoCIsIGFgdU8gwVGj0oZAQT9a4qzNJgGc8Pa+OWIZ5SER8R2VKKCRKJ22g4SIKKHulTbWyot6U/XX2xB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415670; c=relaxed/simple;
	bh=J1zt4rx56PIwCnSUgj8Kv3HkVdhpNZkvMksfba9PgI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csi95uXxkS8w2O4bcVk9iWq4kfZgJTLcl5GOL2YvwWNXdvtXQ/DqPzHcK+s60oq0MBXYgDPhONWG773hp0ZB2MpB0z7uUTpixA1gAfm/DfGJgSY7nzffzX8eSgEYz3YSfCWi+2QZn23jaDQ/a/MD/QdQIJAqBa92IBbpHEYQI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RrDjogs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCJJn73x; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RrDjogs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCJJn73x"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1E227A004D;
	Thu, 30 Jul 2026 08:47:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jul 2026 08:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785415666; x=1785502066; bh=Wok43lBs7S
	8sjIwVsnNpkmLUCLkJgK7/W7vW1LmkLyg=; b=RrDjogs7AtyohwGcuH34AfOIQL
	iWqhmiEFmeZpVdLrBAKsUD10VvhykbAoF8a0+Yj1WmvfoeyCCzWFYQGLrfDdzhh1
	V+HUUQv+9uRmYKuXG9iMTlVNbHoScVPI7VJAkIFOdyxOOSFAn+ubInV3kC8tityN
	2t3qVgTcDxHmIFjWKRGWj0VoI1GJEvhzdFc6ExHW3HSshk9ygmtWKGYnzTwijPSi
	g4BqogfHSLbjZadEwaFXwBOwgKtfCuPXMWFowSe60V+VVkAKjea+pzvaYDLhOs32
	1x2/aayzdnDuqMxXSJrlPTSgjnNLPW85zRHSW5KNuv4t8mz7cx3DC2iQDUFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785415666; x=1785502066; bh=Wok43lBs7S8sjIwVsnNpkmLUCLkJgK7/W7v
	W1LmkLyg=; b=ZCJJn73x2crMVE01ZqkWHzy00lF9QfTKzexYfpED+kTSH0Ul1iw
	ORSrD91N3h2NklP6qSz0ECbYY9jLIiwqf7KQrvUzcRvVI0jCc028/egJETnmGQvh
	PgO3rB8Eml2G8bRJk09BDnFjf9yP0DjRBD99Byp7tAA2uJQv4q0heF2Rm75MPUz7
	WGFGdp9mv6e59SGfTAcvpIAvTslCVgs/j4/q+HdBv0diH6RNcuidoejBaaoJ2WEU
	QHDRzlK0TxOGWGBbjsVkYl8xZcgdm4r7bSjvKY4nNplehPzUMAfRPq7YvzU3XgRJ
	JgBj3zExbDzoVVl1zWMka+87oFbavyhlcCg==
X-ME-Sender: <xms:8kdrat1odYH9mhmBOISY5DtJapyoUDWyBPPAUaPfJmrXAbKH-XNYRw>
    <xme:8kdraroDgkMM0XgEl3TjjcU6H8UzFFBTPkCkALQz7V8b9GTyCX0Lp6eTgtc0WIvfb
    _BptsHEEFvHJ7sDCT3o_k15Kk-DmpKGBtGygsamfK9RXuK4og>
X-ME-Received: <xmr:8kdrati812NKJ1DvGKX3XmjoAbJ76vYflL0rRJAJ1mgEubs_Mrc_qLPN0_-OjTtkIcYUiCDVQVfnD6iT4PRfqgcx8blE4yAQfDG50AElvdU>
X-ME-Proxy-Cause: dmFkZTEKCXtNf+MWK8O/2DLEVi/0uVKNcfIz9wVYsEsnP7R3WBLDMJVKBzlB+lhiejzHL+
    EUQkWrs6Q/jZTT5OqHWf9HOanM4zkwjeifztEgncJybU5EGiXVZmBCuZcI3YFNsmFUjX6w
    lLHocoKxRzCGXgbR88DejXnlvlB+7i3thpJyFuWHJfk6zxn7qqpalZSLmqPloTh+urGctY
    ZmvHHXAjbOCP/VuQwI85p6jEguR/WhJIyIaSgnYdYO/GqaGewRrdeoMvN0smZnQhf2UzJm
    ir/QKarw2oMnCUlecTVZkY4KkdIv55aqWRlypksQBLXLTfrZfTvt7Jeb/IQcuACfZH1VbX
    1S7fTvP2iKNg9CrP51opECShcn5HoeXn4wnkp5GeILiPWj/H1dWk/sAB80L0YTYI/fBj7A
    DKE/RFKk57E/JTZuFfJMorMZVYg1089OnyhEvLY1h4KxThNFthWV9/czNR0wBx7D7FkrLN
    5ezlsEdAvdj544MpRsX4Y+zdx9nOBDMxIKhSTUuU5vv4xEVtf94jNAMSOWa7q1APN45+Xv
    MlhNYB787W+tebGvPRjIluorJyl1+Oe6ZC6Yd/MMoVMX27vlGQ3vPUiJNjbOYvHDmBW6tK
    uh7PLYfhr3Mt/QbR/qmMZqoEEVTMS0o48CGdOXfhUjaDQptDZBqYuZH6QBkQ
X-ME-Proxy: <xmx:8kdrannXWHH6eEJfP8lDPCaJ4A7LDmdyG1_-0GzK124qhm0Enbbdlw>
    <xmx:8kdramr8R7pCyHGfOJ-1ka_LzT5XZRVHMKN9t0bRy2vbK0mg4eDPCw>
    <xmx:8kdrajLzq3q6tNWDE-jl2CXI-fSUq0OEpjoXuidcGpOz7viW6stXtg>
    <xmx:8kdraiCUybsfdkUF9LfCMn2EjRglMsbqMgoyFYwTa-rv-d8RfihDYA>
    <xmx:8kdralumLAUjvdVbd1YficRfzAB3iGICA0ElCQBGNL2dMIwh8VXu1D7X>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:47:46 -0400 (EDT)
Date: Thu, 30 Jul 2026 14:47:33 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] gve: move DQO rx buffer management related
 code to a new file
Message-ID: <2026073025-dragonfly-ravishing-5a7a@gregkh>
References: <2026072027-feline-deserving-7fc7@gregkh>
 <20260728132004.3954154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728132004.3954154-1-sashal@kernel.org>

On Tue, Jul 28, 2026 at 09:20:03AM -0400, Sasha Levin wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> [ Upstream commit 93c68f1275f9e21ccfed9ee292aedb11c3f6241b ]
> 
> In preparation for the upcoming page pool adoption for DQO
> raw addressing mode, move RX buffer management code to a new
> file. In the follow on patches, page pool code will be added
> to this file.
> 
> No functional change, just movement of code.
> 
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Link: https://patch.msgid.link/20241014202108.1051963-2-pkaligineedi@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: d676c9a73bdc ("gve: fix header buffer corruption with header-split and HW-GRO")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/google/gve/Makefile      |   3 +-
>  drivers/net/ethernet/google/gve/gve.h         |  18 ++
>  .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 230 ++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 225 -----------------
>  4 files changed, 250 insertions(+), 226 deletions(-)
>  create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> 
> diff --git a/drivers/net/ethernet/google/gve/Makefile b/drivers/net/ethernet/google/gve/Makefile
> index 9ed07080b38a25..4520f1c07a638f 100644
> --- a/drivers/net/ethernet/google/gve/Makefile
> +++ b/drivers/net/ethernet/google/gve/Makefile
> @@ -1,4 +1,5 @@
>  # Makefile for the Google virtual Ethernet (gve) driver
>  
>  obj-$(CONFIG_GVE) += gve.o
> -gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o
> +gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o \
> +	    gve_buffer_mgmt_dqo.o
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 8ddd366d9fde54..99fd933a1f30d4 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1173,6 +1173,24 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
>  u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
>  bool gve_header_split_supported(const struct gve_priv *priv);
>  int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
> +/* rx buffer handling */
> +int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs);
> +void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
> +		       bool free_page);
> +struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx);
> +bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
> +				struct gve_rx_buf_state_dqo *buf_state);
> +void gve_free_buf_state(struct gve_rx_ring *rx,
> +			struct gve_rx_buf_state_dqo *buf_state);
> +struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
> +						   struct gve_index_list *list);
> +void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
> +			   struct gve_rx_buf_state_dqo *buf_state);
> +struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx);
> +int gve_alloc_page_dqo(struct gve_rx_ring *rx,
> +		       struct gve_rx_buf_state_dqo *buf_state);
> +void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
> +			 struct gve_rx_buf_state_dqo *buf_state);
>  /* Reset */
>  void gve_schedule_reset(struct gve_priv *priv);
>  int gve_reset(struct gve_priv *priv, bool attempt_teardown);
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> new file mode 100644
> index 00000000000000..8e50f0e4bb2ecb
> --- /dev/null
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Google virtual Ethernet (gve) driver
> + *
> + * Copyright (C) 2015-2024 Google, Inc.
> + */
> +
> +#include "gve.h"
> +#include "gve_utils.h"
> +
> +int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
> +{
> +	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
> +}
> +
> +void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
> +		       bool free_page)
> +{
> +	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
> +	if (free_page)
> +		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
> +			      DMA_FROM_DEVICE);
> +	bs->page_info.page = NULL;
> +}
> +
> +struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
> +{
> +	struct gve_rx_buf_state_dqo *buf_state;
> +	s16 buffer_id;
> +
> +	buffer_id = rx->dqo.free_buf_states;
> +	if (unlikely(buffer_id == -1))
> +		return NULL;
> +
> +	buf_state = &rx->dqo.buf_states[buffer_id];
> +
> +	/* Remove buf_state from free list */
> +	rx->dqo.free_buf_states = buf_state->next;
> +
> +	/* Point buf_state to itself to mark it as allocated */
> +	buf_state->next = buffer_id;
> +
> +	return buf_state;
> +}
> +
> +bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
> +				struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	s16 buffer_id = buf_state - rx->dqo.buf_states;
> +
> +	return buf_state->next == buffer_id;
> +}
> +
> +void gve_free_buf_state(struct gve_rx_ring *rx,
> +			struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	s16 buffer_id = buf_state - rx->dqo.buf_states;
> +
> +	buf_state->next = rx->dqo.free_buf_states;
> +	rx->dqo.free_buf_states = buffer_id;
> +}
> +
> +struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
> +						   struct gve_index_list *list)
> +{
> +	struct gve_rx_buf_state_dqo *buf_state;
> +	s16 buffer_id;
> +
> +	buffer_id = list->head;
> +	if (unlikely(buffer_id == -1))
> +		return NULL;
> +
> +	buf_state = &rx->dqo.buf_states[buffer_id];
> +
> +	/* Remove buf_state from list */
> +	list->head = buf_state->next;
> +	if (buf_state->next == -1)
> +		list->tail = -1;
> +
> +	/* Point buf_state to itself to mark it as allocated */
> +	buf_state->next = buffer_id;
> +
> +	return buf_state;
> +}
> +
> +void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
> +			   struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	s16 buffer_id = buf_state - rx->dqo.buf_states;
> +
> +	buf_state->next = -1;
> +
> +	if (list->head == -1) {
> +		list->head = buffer_id;
> +		list->tail = buffer_id;
> +	} else {
> +		int tail = list->tail;
> +
> +		rx->dqo.buf_states[tail].next = buffer_id;
> +		list->tail = buffer_id;
> +	}
> +}
> +
> +struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx)
> +{
> +	struct gve_rx_buf_state_dqo *buf_state;
> +	int i;
> +
> +	/* Recycled buf states are immediately usable. */
> +	buf_state = gve_dequeue_buf_state(rx, &rx->dqo.recycled_buf_states);
> +	if (likely(buf_state))
> +		return buf_state;
> +
> +	if (unlikely(rx->dqo.used_buf_states.head == -1))
> +		return NULL;
> +
> +	/* Used buf states are only usable when ref count reaches 0, which means
> +	 * no SKBs refer to them.
> +	 *
> +	 * Search a limited number before giving up.
> +	 */
> +	for (i = 0; i < 5; i++) {
> +		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
> +		if (gve_buf_ref_cnt(buf_state) == 0) {
> +			rx->dqo.used_buf_states_cnt--;
> +			return buf_state;
> +		}
> +
> +		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
> +	}
> +
> +	/* For QPL, we cannot allocate any new buffers and must
> +	 * wait for the existing ones to be available.
> +	 */
> +	if (rx->dqo.qpl)
> +		return NULL;
> +
> +	/* If there are no free buf states discard an entry from
> +	 * `used_buf_states` so it can be used.
> +	 */
> +	if (unlikely(rx->dqo.free_buf_states == -1)) {
> +		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
> +		if (gve_buf_ref_cnt(buf_state) == 0)
> +			return buf_state;
> +
> +		gve_free_page_dqo(rx->gve, buf_state, true);
> +		gve_free_buf_state(rx, buf_state);
> +	}
> +
> +	return NULL;
> +}
> +
> +int gve_alloc_page_dqo(struct gve_rx_ring *rx,
> +		       struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	struct gve_priv *priv = rx->gve;
> +	u32 idx;
> +
> +	if (!rx->dqo.qpl) {
> +		int err;
> +
> +		err = gve_alloc_page(priv, &priv->pdev->dev,
> +				     &buf_state->page_info.page,
> +				     &buf_state->addr,
> +				     DMA_FROM_DEVICE, GFP_ATOMIC);
> +		if (err)
> +			return err;
> +	} else {
> +		idx = rx->dqo.next_qpl_page_idx;
> +		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
> +			net_err_ratelimited("%s: Out of QPL pages\n",
> +					    priv->dev->name);
> +			return -ENOMEM;
> +		}
> +		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
> +		buf_state->addr = rx->dqo.qpl->page_buses[idx];
> +		rx->dqo.next_qpl_page_idx++;
> +	}
> +	buf_state->page_info.page_offset = 0;
> +	buf_state->page_info.page_address =
> +		page_address(buf_state->page_info.page);
> +	buf_state->last_single_ref_offset = 0;
> +
> +	/* The page already has 1 ref. */
> +	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
> +	buf_state->page_info.pagecnt_bias = INT_MAX;
> +
> +	return 0;
> +}
> +
> +void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
> +			 struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	const u16 data_buffer_size = priv->data_buffer_size_dqo;
> +	int pagecount;
> +
> +	/* Can't reuse if we only fit one buffer per page */
> +	if (data_buffer_size * 2 > PAGE_SIZE)
> +		goto mark_used;
> +
> +	pagecount = gve_buf_ref_cnt(buf_state);
> +
> +	/* Record the offset when we have a single remaining reference.
> +	 *
> +	 * When this happens, we know all of the other offsets of the page are
> +	 * usable.
> +	 */
> +	if (pagecount == 1) {
> +		buf_state->last_single_ref_offset =
> +			buf_state->page_info.page_offset;
> +	}
> +
> +	/* Use the next buffer sized chunk in the page. */
> +	buf_state->page_info.page_offset += data_buffer_size;
> +	buf_state->page_info.page_offset &= (PAGE_SIZE - 1);
> +
> +	/* If we wrap around to the same offset without ever dropping to 1
> +	 * reference, then we don't know if this offset was ever freed.
> +	 */
> +	if (buf_state->page_info.page_offset ==
> +	    buf_state->last_single_ref_offset) {
> +		goto mark_used;
> +	}
> +
> +	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
> +	return;
> +
> +mark_used:
> +	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
> +	rx->dqo.used_buf_states_cnt++;
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 1154c1d8f66f05..b343be2fb118ad 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -16,189 +16,6 @@
>  #include <net/ipv6.h>
>  #include <net/tcp.h>
>  
> -static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
> -{
> -	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
> -}
> -
> -static void gve_free_page_dqo(struct gve_priv *priv,
> -			      struct gve_rx_buf_state_dqo *bs,
> -			      bool free_page)
> -{
> -	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
> -	if (free_page)
> -		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
> -			      DMA_FROM_DEVICE);
> -	bs->page_info.page = NULL;
> -}
> -
> -static struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
> -{
> -	struct gve_rx_buf_state_dqo *buf_state;
> -	s16 buffer_id;
> -
> -	buffer_id = rx->dqo.free_buf_states;
> -	if (unlikely(buffer_id == -1))
> -		return NULL;
> -
> -	buf_state = &rx->dqo.buf_states[buffer_id];
> -
> -	/* Remove buf_state from free list */
> -	rx->dqo.free_buf_states = buf_state->next;
> -
> -	/* Point buf_state to itself to mark it as allocated */
> -	buf_state->next = buffer_id;
> -
> -	return buf_state;
> -}
> -
> -static bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
> -				       struct gve_rx_buf_state_dqo *buf_state)
> -{
> -	s16 buffer_id = buf_state - rx->dqo.buf_states;
> -
> -	return buf_state->next == buffer_id;
> -}
> -
> -static void gve_free_buf_state(struct gve_rx_ring *rx,
> -			       struct gve_rx_buf_state_dqo *buf_state)
> -{
> -	s16 buffer_id = buf_state - rx->dqo.buf_states;
> -
> -	buf_state->next = rx->dqo.free_buf_states;
> -	rx->dqo.free_buf_states = buffer_id;
> -}
> -
> -static struct gve_rx_buf_state_dqo *
> -gve_dequeue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list)
> -{
> -	struct gve_rx_buf_state_dqo *buf_state;
> -	s16 buffer_id;
> -
> -	buffer_id = list->head;
> -	if (unlikely(buffer_id == -1))
> -		return NULL;
> -
> -	buf_state = &rx->dqo.buf_states[buffer_id];
> -
> -	/* Remove buf_state from list */
> -	list->head = buf_state->next;
> -	if (buf_state->next == -1)
> -		list->tail = -1;
> -
> -	/* Point buf_state to itself to mark it as allocated */
> -	buf_state->next = buffer_id;
> -
> -	return buf_state;
> -}
> -
> -static void gve_enqueue_buf_state(struct gve_rx_ring *rx,
> -				  struct gve_index_list *list,
> -				  struct gve_rx_buf_state_dqo *buf_state)
> -{
> -	s16 buffer_id = buf_state - rx->dqo.buf_states;
> -
> -	buf_state->next = -1;
> -
> -	if (list->head == -1) {
> -		list->head = buffer_id;
> -		list->tail = buffer_id;
> -	} else {
> -		int tail = list->tail;
> -
> -		rx->dqo.buf_states[tail].next = buffer_id;
> -		list->tail = buffer_id;
> -	}
> -}
> -
> -static struct gve_rx_buf_state_dqo *
> -gve_get_recycled_buf_state(struct gve_rx_ring *rx)
> -{
> -	struct gve_rx_buf_state_dqo *buf_state;
> -	int i;
> -
> -	/* Recycled buf states are immediately usable. */
> -	buf_state = gve_dequeue_buf_state(rx, &rx->dqo.recycled_buf_states);
> -	if (likely(buf_state))
> -		return buf_state;
> -
> -	if (unlikely(rx->dqo.used_buf_states.head == -1))
> -		return NULL;
> -
> -	/* Used buf states are only usable when ref count reaches 0, which means
> -	 * no SKBs refer to them.
> -	 *
> -	 * Search a limited number before giving up.
> -	 */
> -	for (i = 0; i < 5; i++) {
> -		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
> -		if (gve_buf_ref_cnt(buf_state) == 0) {
> -			rx->dqo.used_buf_states_cnt--;
> -			return buf_state;
> -		}
> -
> -		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
> -	}
> -
> -	/* For QPL, we cannot allocate any new buffers and must
> -	 * wait for the existing ones to be available.
> -	 */
> -	if (rx->dqo.qpl)
> -		return NULL;
> -
> -	/* If there are no free buf states discard an entry from
> -	 * `used_buf_states` so it can be used.
> -	 */
> -	if (unlikely(rx->dqo.free_buf_states == -1)) {
> -		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
> -		if (gve_buf_ref_cnt(buf_state) == 0)
> -			return buf_state;
> -
> -		gve_free_page_dqo(rx->gve, buf_state, true);
> -		gve_free_buf_state(rx, buf_state);
> -	}
> -
> -	return NULL;
> -}
> -
> -static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
> -			      struct gve_rx_buf_state_dqo *buf_state)
> -{
> -	struct gve_priv *priv = rx->gve;
> -	u32 idx;
> -
> -	if (!rx->dqo.qpl) {
> -		int err;
> -
> -		err = gve_alloc_page(priv, &priv->pdev->dev,
> -				     &buf_state->page_info.page,
> -				     &buf_state->addr,
> -				     DMA_FROM_DEVICE, GFP_ATOMIC);
> -		if (err)
> -			return err;
> -	} else {
> -		idx = rx->dqo.next_qpl_page_idx;
> -		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
> -			net_err_ratelimited("%s: Out of QPL pages\n",
> -					    priv->dev->name);
> -			return -ENOMEM;
> -		}
> -		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
> -		buf_state->addr = rx->dqo.qpl->page_buses[idx];
> -		rx->dqo.next_qpl_page_idx++;
> -	}
> -	buf_state->page_info.page_offset = 0;
> -	buf_state->page_info.page_address =
> -		page_address(buf_state->page_info.page);
> -	buf_state->last_single_ref_offset = 0;
> -
> -	/* The page already has 1 ref. */
> -	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
> -	buf_state->page_info.pagecnt_bias = INT_MAX;
> -
> -	return 0;
> -}
> -
>  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
>  {
>  	struct device *hdev = &priv->pdev->dev;
> @@ -557,48 +374,6 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>  	rx->fill_cnt += num_posted;
>  }
>  
> -static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
> -				struct gve_rx_buf_state_dqo *buf_state)
> -{
> -	const u16 data_buffer_size = priv->data_buffer_size_dqo;
> -	int pagecount;
> -
> -	/* Can't reuse if we only fit one buffer per page */
> -	if (data_buffer_size * 2 > PAGE_SIZE)
> -		goto mark_used;
> -
> -	pagecount = gve_buf_ref_cnt(buf_state);
> -
> -	/* Record the offset when we have a single remaining reference.
> -	 *
> -	 * When this happens, we know all of the other offsets of the page are
> -	 * usable.
> -	 */
> -	if (pagecount == 1) {
> -		buf_state->last_single_ref_offset =
> -			buf_state->page_info.page_offset;
> -	}
> -
> -	/* Use the next buffer sized chunk in the page. */
> -	buf_state->page_info.page_offset += data_buffer_size;
> -	buf_state->page_info.page_offset &= (PAGE_SIZE - 1);
> -
> -	/* If we wrap around to the same offset without ever dropping to 1
> -	 * reference, then we don't know if this offset was ever freed.
> -	 */
> -	if (buf_state->page_info.page_offset ==
> -	    buf_state->last_single_ref_offset) {
> -		goto mark_used;
> -	}
> -
> -	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
> -	return;
> -
> -mark_used:
> -	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
> -	rx->dqo.used_buf_states_cnt++;
> -}
> -
>  static void gve_rx_skb_csum(struct sk_buff *skb,
>  			    const struct gve_rx_compl_desc_dqo *desc,
>  			    struct gve_ptype ptype)
> -- 
> 2.53.0
> 
> 

Did not apply, and patch 2/2 worked on it's own.
