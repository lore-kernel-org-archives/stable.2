Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4B39DBFF;
	Mon, 20 Jul 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544213; cv=none; b=sZ3RuPmlkZeBYZ+nPSvTwq/HcqmIppz/1q6yD5ch8tBGIg5zX+Z5qSv6TO1euTxzA8zTpjeSK26Hw620pEbkq4Jdh19Bi8CktiMpuJEIBCWnr4y3wD4Y+m45UzKETob9mzKsU5jggRH/vFmQnvi8K6UipJWheUIkgemlvPhwZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544213; c=relaxed/simple;
	bh=JOcq7YdmE8pqxYCXCoOmg3kyDP0SwghFQZ3mMEmpZd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiVwa2F66wvnZ4p4NUGnenqT8D70yS10fN0ve9sXsfna37aod/ITQqm8GnvfP4g9xcG9iuBkUTvqo+agRCNww0o9nBaxVgh/cE5ANb1OUEe2OxqApym8z18anR92DTdZCGKiTUOficzrLsosQawHLqnQV54Dehd9eBc6lrD+sO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGlKo/x4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGlKo/x4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA61F000E9;
	Mon, 20 Jul 2026 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544208;
	bh=OSjqkmld1DCh7sm1IDi6p3kqnOBZ5HqEziqUJWOhbWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGlKo/x4XQ3vxklby5zZFphibrxtMMcdLCLH7lGxkQ54ymR1F9WWKWMsVOmtuE4AS
	 se2bywTExEuGNwhHi5xwWsrGFAZfC351R4hXN7j9lMUnuaR2S+5IDpyH/fMdvQmwD7
	 MjopMGNS5L/yypBKGw70gNKm7cjbEPfuLvwFfpXyq/yLp/H69RzEe5K1YQWsQhhJ6h
	 OugYDVO0YIDlWk43u7XtZu67QNadurOwafeKKRkWF+55oJ2TOkE6wGhT/bdnm7qwpt
	 zQ63rjzWDLLoqTNzAGx3+u8g9QAH2t0hJ8Ce8Pu3OmXl+LpLaFxkEnU1uaXnzy39T6
	 yel7c46U6xOlg==
From: Simon Horman <horms@kernel.org>
To: michael.bommarito@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE
Date: Mon, 20 Jul 2026 11:40:44 +0100
Message-ID: <20260720104043.61416-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711150628.2914205-1-michael.bommarito@gmail.com>
References: <20260711150628.2914205-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260711150628.2914205-1-michael.bommarito@gmail.com?part=1
---
--- Patch [1]: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE ---
commit ea80048daa839e9f12f06618139e15fddebc0ac5
Author: Michael Bommarito <michael.bommarito@gmail.com>

net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE

The commit adds bounds checking for max message size during HWC initialization.
It claims this prevents an out-of-bounds DMA buffer write in
mana_hwc_alloc_dma_buf().

>    mana_hwc_init_event_handler() in hw_channel.c stores device-advertised
>    HWC_INIT_DATA_MAX_REQUEST and HWC_INIT_DATA_MAX_RESPONSE values
>    without bounds checking. mana_hwc_alloc_dma_buf() later computes the
>    DMA buffer size as MANA_PAGE_ALIGN(q_depth * max_msg_size) in 32-bit
>    arithmetic. A malicious device returning a large max_msg_size causes
>    the product to wrap, allocating a small buffer while laying out
>    q_depth request slots at the unwrapped stride, placing slots outside
>    the allocation.

[Severity: Medium]
Is this description accurate?

The modified variables (hwc->hwc_init_max_req_msg_size and
hwc->hwc_init_max_resp_msg_size) appear to be dead code that do not affect
memory allocation. mana_hwc_alloc_dma_buf() is invoked before the event
handler runs (via mana_hwc_init_queues()) using hardcoded sizes (4096),
not the hardware-provided ones.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index e3c24d50dad07..94594fba112f9 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -150,10 +150,14 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
>  			break;
>  
>  		case HWC_INIT_DATA_MAX_REQUEST:
> +			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
> +				val = HW_CHANNEL_MAX_REQUEST_SIZE;
>  			hwc->hwc_init_max_req_msg_size = val;
>  			break;
>  
>  		case HWC_INIT_DATA_MAX_RESPONSE:
> +			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
> +				val = HW_CHANNEL_MAX_REQUEST_SIZE;

[Severity: Low]
Does this incorrectly clamp HWC_INIT_DATA_MAX_RESPONSE using
HW_CHANNEL_MAX_REQUEST_SIZE instead of HW_CHANNEL_MAX_RESPONSE_SIZE?

>  			hwc->hwc_init_max_resp_msg_size = val;
>  			break;
>  

[Severity: High]
This is a pre-existing issue, but is it possible for a malicious device
to trigger an out-of-bounds MMIO write via an unchecked doorbell index?

Earlier in mana_hwc_init_event_handler():

	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
		eq_db.as_uint32 = event->details[0];
		hwc->cq->gdma_eq->id = eq_db.eq_id;
		gd->doorbell = eq_db.doorbell;

When the driver posts WQEs and rings the doorbell via mana_gd_ring_doorbell():

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_ring_doorbell() {
    ...
    void __iomem *addr = gc->db_page_base + gc->db_page_size * db_index;
    ...
    writeq(e.as_uint64, addr);
    ...
}

If eq_db.doorbell is excessively large, could it calculate a memory-mapped
address that exceeds gc->bar0_size, resulting in an out-of-bounds writeq()
that corrupts adjacent mappings?


[Severity: High]
This is a pre-existing issue, but does the unchecked max_num_cqs value
allow a malicious device to exhaust system memory?

Later in mana_hwc_init_event_handler():

		case HWC_INIT_DATA_MAX_NUM_CQS:
			gd->gdma_context->max_num_cqs = val;
			break;

This unbounded max_num_cqs value is later used for memory allocation:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_establish_channel() {
    ...
	gc->cq_table = vcalloc(gc->max_num_cqs, sizeof(struct gdma_queue *));
    ...
}

If max_num_cqs is an exceptionally large 32-bit value (e.g., 0x1FFFFFFF),
could vcalloc() attempt to allocate multiple gigabytes of memory and cause a
host-level denial of service?
