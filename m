Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB047CA73
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260672; cv=none; b=FxxsTGni1kmElyIuFXxdT4TW+mZeqCArlTSSoCulP0bHGOk39RQerXyrtCu1rzzEczx5pUX/kdBqrwMQWm0XVYU71UcD/Bto6TqJ1jpEIlBvZYkjB/8nj5Y4Mum71rg963fPy7LfL6BugHHOcBp6IJbVGPb3BydC7bqwgwMM+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260672; c=relaxed/simple;
	bh=kLCPJHfnPYk6jxIxd56fZeydQCtMBIcUA041uVwy4s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muvKaOCQLK4MfeWGabQnPco+p/tdMjPL4K4FQW80Vfjt7fHrmtYtNeGw5b60w3pzWTvUZ5g9b8lXtwB/co+HZmj73AbL72nHbaFpzJxvTQMQxfe/nKsmKTCKHGpADyVL16E2S6ltueg8bDrFM0xjyvkNPMKLmvJ/QSiVvb/fHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbN2o7/4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbN2o7/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788260667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRv81smlVWxNb1A0Cr9qAtGJQ8qZ9KnUs2NstCo31Yc=;
	b=JbN2o7/4atHHvwd6IafHyJyyLN6OLLtmO2ONmJLw8QQHALCLHC7UJroLPK8/cg4+LtKFgx
	tPa+jIZWHrtkiOXm9/ZawmXV5hU/H/2eNO/RLTDvqrafMffaCpgljSksEBRLjNeqPS/hiI
	/20TPP+tYkaDZ2+Yt8rEQTkMyLwUx7k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-plUwejrXP9aoqQnNbURvgw-1; Tue,
 01 Sept 2026 07:04:18 -0400
X-MC-Unique: plUwejrXP9aoqQnNbURvgw-1
X-Mimecast-MFC-AGG-ID: plUwejrXP9aoqQnNbURvgw_1788260650
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 122801845530;
	Tue,  1 Sep 2026 11:04:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.14])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40A8E423;
	Tue,  1 Sep 2026 11:04:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: johnathan.browall@topgolf.com
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pontus.hallstedt@topgolf.com
Subject: Re: [PATCH net v2] bnxt_en: avoid redundant RX mask updates in UC overflow state
Date: Tue,  1 Sep 2026 13:04:01 +0200
Message-ID: <20260901110401.153294-1-pabeni@redhat.com>
In-Reply-To: <20260828-bnxt-uc-overflow-v2-1-faddc16b0ea0@topgolf.com>
References: <20260828-bnxt-uc-overflow-v2-1-faddc16b0ea0@topgolf.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
bnxt_en: avoid redundant RX mask updates in UC overflow state

The patch records the unicast filter overflow condition in a new vnic flag
so that bnxt_uc_list_updated() stops reporting the UC list as changed while
the list is too long for the available L2 filters, and so that
bnxt_set_rx_mode() keeps the promiscuous bit in the mask it computes.  The
goal is to stop resending an identical HWRM_CFA_L2_SET_RX_MASK on every
rx-mode callback.

Link: https://patch.msgid.link/20260827-bnxt-uc-overflow-v1-1-f20d48864fe9@topgolf.com

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 9c2cc50276a59..d960cf942e99e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13791,6 +13791,16 @@ static bool bnxt_uc_list_updated(struct bnxt *bp,
>  	struct netdev_hw_addr *ha;
>  	int off = 0;
>  
> +	/* In the overflow state all unicast is accepted through the
> +	 * promiscuous RX mask and no secondary L2 filters are in use,
> +	 * so the list only needs reprogramming once it fits the
> +	 * available filters again.  Reporting an update here would
> +	 * resend an identical SET_RX_MASK on every callback, which
> +	 * causes brief RX packet loss on some chips.
> +	 */
> +	if (vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG)
> +		return netdev_hw_addr_list_count(uc) <= (BNXT_MAX_UC_ADDRS - 1);
> +

[Severity: High]

Can this early return defeat the rx-mode retry after a failed
SET_RX_MASK?

In bnxt_cfg_rx_mode() the overflow branch now latches both the flag and the
cached promiscuous bit before bnxt_hwrm_cfa_l2_set_rx_mask() has installed
anything, and after the secondary L2 filters have already been freed:

	for (i = 1; i < vnic->uc_filter_count; i++) {
		struct bnxt_l2_filter *fltr = vnic->l2_filters[i];

		bnxt_hwrm_l2_filter_free(bp, fltr);
		bnxt_del_l2_filter(bp, fltr);
	}

	vnic->uc_filter_count = 1;
	...
	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
		vnic->flags |= BNXT_VNIC_UC_PROMISC_FLAG;

If the subsequent HWRM fails, the only reaction is the MCAST fallback plus a
log message, and nothing clears the flag or the cached bit:

	rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, 0);
	if (rc && (vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_MCAST)) {
		...
	}
	if (rc)
		netdev_err(bp->dev, "HWRM cfa l2 rx mask failure rc: %d\n",
			   rc);

	return rc;

The MCAST fallback does not fire when MASK_MCAST is absent, i.e. with
IFF_ALLMULTI, with an MC list above BNXT_MAX_MC_ADDRS, or with no MC
addresses at all.

On the retry, bnxt_set_rx_mode() strips PROMISC and immediately re-adds it
from the new flag, so mask equals the already-committed vnic->rx_mask, and
bnxt_uc_list_updated() now returns false through the hunk above, so the
guard is skipped entirely:

	if (mask != vnic->rx_mask || uc_update || mc_update) {
		vnic->rx_mask = mask;

		return bnxt_cfg_rx_mode(bp, uc, uc_update);
	}

	return 0;

netif_rx_mode_run() in net/core/dev_addr_lists.c treats that zero return as
success and drops the retry state:

		if (err)
			netif_rx_mode_schedule_retry(dev);
		else
			dev->rx_mode_retry_count = 0;

At that point the hardware has neither the secondary L2 filters (freed) nor
the promiscuous bit (never installed), so traffic for the secondary unicast
addresses is dropped until the UC list shrinks below the filter limit, the
rx flags or the MC list change, or the interface is brought down and up.

bnxt_init_chip() depends on the same retry:

	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, true);
	if (rc == -EAGAIN) {
		netif_rx_mode_schedule_retry(bp->dev);
		rc = 0;
	} else if (rc) {
		goto err_out;
	}

so a transient -EAGAIN or -ENODEV on open with more than
BNXT_MAX_UC_ADDRS - 1 unicast addresses would leave the interface up with
no unicast filtering path at all.

Before this patch, the overflow state left vnic->uc_filter_count == 1 with a
non-empty UC list, so bnxt_uc_list_updated() returned true on every callback
and the mask was re-sent until it succeeded.  Would it work to latch the
flag and the cached promiscuous bit only after bnxt_hwrm_cfa_l2_set_rx_mask()
returns success, or to clear them again on failure so the retry still
programs the mask?

>  	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
>  		return true;
>  
> @@ -13826,6 +13836,13 @@ static int bnxt_set_rx_mode(struct net_device *dev,
>  	if (dev->flags & IFF_PROMISC)
>  		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
>  
> +	/* Keep the promiscuous bit while the UC list is longer than the
> +	 * available L2 filters, so that an unchanged rx mode is not
> +	 * treated as a mask change.
> +	 */
> +	if ((vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG) && bnxt_promisc_ok(bp))
> +		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
> +
>  	uc_update = bnxt_uc_list_updated(bp, uc);
>  
>  	if (dev->flags & IFF_BROADCAST)
> @@ -13869,7 +13886,12 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
>  	netif_addr_lock_bh(dev);
>  	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
>  		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
> +		vnic->flags |= BNXT_VNIC_UC_PROMISC_FLAG;
>  	} else {
> +		vnic->flags &= ~BNXT_VNIC_UC_PROMISC_FLAG;
> +		if (!(dev->flags & IFF_PROMISC))
> +			vnic->rx_mask &=
> +				~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
>  		netdev_hw_addr_list_for_each(ha, uc) {
>  			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
>  			off += ETH_ALEN;

[ ... ]
-- 
This is an AI-generated review.

