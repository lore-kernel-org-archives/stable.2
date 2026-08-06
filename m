Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6948665E;
	Thu,  6 Aug 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036840; cv=none; b=dBmVigDvEJ8dalvjfxQokooV957WBgJqdW0aU01SdJMsO+fXqLUaA3ZC+BwItvsdwx4sejMQchba82rKSpeeYb296Rnhc51PL4Fg4Xf7NqASMQUMUl9hYwHRcG0OdeaiTFVJVFTcR4UDCuiB+emmydZsSOk3lUsXW15ddlrmg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036840; c=relaxed/simple;
	bh=HN/d1phmX3vGdaiAIseinb5iU4fSLsA6dFNKBgYMBVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtklT+x9pOPP3p6A8+6UqTKAbcpbYQUmPxN0NwYaR1hXwJfvJBCSYzL7BOlayKeBG74p125nSYGY7pUFeL0whf+hR6hqgE9pmbyyZXLP7zL0GtCHFPnq/M7JZVYzVsGoOQOJjnEnwSZWCWhtanuU4sRQYeNOkycCdNPVxAl9+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhL9cNcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhL9cNcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0121E1F00A3A;
	Thu,  6 Aug 2026 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036839;
	bh=0wl9vbPG1RuJkFuqGApRJfA2tlKQR8LLabN7xom5/SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EhL9cNcVeC0HqnRaF5GhiGPkOxhR9aqWHZHNFeKYh1aMZc1kQH/O1o72g6+CL7UhU
	 mWhpH3KQWQ3kmq6xJqfJRxQVHzjBVfuEjSbrmh7s3CkBvG4cf41sVwjHSv28TOvR+i
	 OKo0c386ZMqXAdcqvICmoeoemdorfUpsGDnR4+s473sfQxC4WEbcJ4pI3M7x6p/tqU
	 YdtnQ+ETDSFoMOYC9wIe10Ce62OKWBan4IrYOCdYirxqP9KaKx0dxxrUrxj3BU1gwY
	 mq3GGSSUX5ge2Yflqei6jHju7lOlTThDuvF0Gtef/edfiu1leiE5R1EKIFiNmHk0VA
	 /8skwbZu9jSiw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	doruk@0sec.ai,
	michal.swiatkowski@linux.intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net 06/10] ice: fix stats array overflow via proper realloc
Date: Thu,  6 Aug 2026 10:20:37 -0700
Message-ID: <20260806172037.2935748-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-7-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: fix stats array overflow via proper realloc

This drops ice_vsi_alloc_stat_arrays() and makes
ice_vsi_realloc_stat_arrays() handle the initial allocation as well, so
ice_vsi_cfg_def() now goes through the realloc path.  The array sizes are
tracked in two new fields, tx_ring_stats_len and rx_ring_stats_len, which
the free path uses instead of vsi->alloc_txq/alloc_rxq.

Closes: https://redhat.atlassian.net/browse/RHEL-164321

> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index fc91b6665f905..83da5ba6eeb17 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -328,6 +328,8 @@ enum ice_vsi_state {
>  struct ice_vsi_stats {
>  	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
>  	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
> +	u16 tx_ring_stats_len;
> +	u16 rx_ring_stats_len;
>  };
>  
>  /* struct that defines a VSI, associated with a dev */

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index e48ee5940f173..c71849119d04e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -513,51 +512,6 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)

[ ... ]

> -	vsi_stat->tx_ring_stats =
> -		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
> -	if (!vsi_stat->tx_ring_stats)
> -		goto err_alloc_tx;
> -
> -	vsi_stat->rx_ring_stats =
> -		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
> -	if (!vsi_stat->rx_ring_stats)
> -		goto err_alloc_rx;

[ ... ]

> @@ -2316,11 +2270,19 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  	struct ice_ring_stats **rx_ring_stats;
>  	struct ice_vsi_stats *vsi_stat;
>  	struct ice_pf *pf = vsi->back;
> -	u16 prev_txq = vsi->alloc_txq;
> -	u16 prev_rxq = vsi->alloc_rxq;
> +	u16 prev_txq, prev_rxq;
> +
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;
>  
>  	vsi_stat = pf->vsi_stats[vsi->idx];
> +	if (!vsi_stat) {
> +		vsi_stat = kzalloc_obj(*vsi_stat);
> +		if (!vsi_stat)
> +			return -ENOMEM;
> +	}
>  
> +	prev_txq = vsi_stat->tx_ring_stats_len;
>  	if (req_txq < prev_txq) {
>  		for (int i = req_txq; i < prev_txq; i++) {
>  			if (vsi_stat->tx_ring_stats[i]) {

[Severity: High]

This isn't a bug introduced by this patch, but can the array still end up
smaller than what the consumers iterate for a VF VSI?  The replaced
ice_vsi_alloc_stat_arrays() sized the arrays from vsi->alloc_txq /
vsi->alloc_rxq, while ice_vsi_realloc_stat_arrays() sizes them from the
req_* values:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_realloc_stat_arrays() {
	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
	...
}

For ICE_VSI_VF, ice_vsi_set_num_qs() does not consult vsi->req_txq /
vsi->req_rxq at all:

	case ICE_VSI_VF:
		if (vf->num_req_qs)
			vf->num_vf_qs = vf->num_req_qs;
		vsi->alloc_txq = vf->num_vf_qs;
		vsi->alloc_rxq = vf->num_vf_qs;

So the two counts have independent writers.  vsi->req_txq / vsi->req_rxq
are set on a VF VSI only by ice_sriov_set_msix_vec_count() (the
sriov_vf_msix_count sysfs write) and I could not find anything that clears
them again for a VF VSI -- neither ice_vsi_decfg() nor ice_vsi_alloc_def()
touches them, and the only vsi->req_txq = 0 is on the PF mqprio path in
ice_main.c.

Given that, does this sequence still overflow tx_ring_stats[] /
rx_ring_stats[]?

1) host writes sriov_vf_msix_count, so ice_sriov_set_msix_vec_count() sets
   vsi->req_txq = vsi->req_rxq = 2 and they stay at 2
2) the guest sends VIRTCHNL_OP_REQUEST_QUEUES for 16 queues;
   ice_vc_request_qs_msg() bounds it only by ICE_MAX_RSS_QS_PER_VF and the
   free queue count, sets vf->num_req_qs and calls ice_reset_vf()
3) ice_reset_vf() -> ice_vf_reconfig_vsi() -> ice_vsi_cfg() ->
   ice_vsi_cfg_def(); ice_vsi_alloc_def() -> ice_vsi_set_num_qs() sets
   alloc_txq = alloc_rxq = 16
4) ice_vsi_realloc_stat_arrays() then shrinks to req_txq = 2 and records
   tx_ring_stats_len = 2

ice_vsi_alloc_ring_stats() still walks 0..alloc_txq-1 with no bound check
against the new length fields:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_alloc_ring_stats() {
	ice_for_each_alloc_txq(vsi, i) {
		...
		ring_stats = tx_ring_stats[i];
		if (!ring_stats) {
			...
			WRITE_ONCE(tx_ring_stats[i], ring_stats);
		}
		ring->ring_stats = ring_stats;
	}
}

That is both an out-of-bounds read and an out-of-bounds pointer store for
i >= 2, which looks like the same slab-out-of-bounds signature quoted in
the commit message.  ice_qp_reset_stats() in ice_base.c indexes
vsi_stat->tx_ring_stats[q_idx] / rx_ring_stats[q_idx] the same way without
consulting the new lengths.

Would using the freshly computed vsi->alloc_txq / vsi->alloc_rxq (or
max(req_*, alloc_*)) for the sizing close this?  The req_* preference looks
only meaningful for the pre-ice_vsi_cfg_def() call in ice_vsi_rebuild(),
where alloc_* is still stale.

>  
> @@ -2379,7 +2353,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>  		return ret;
>  
>  	/* allocate memory for Tx/Rx ring stat pointers */
> -	ret = ice_vsi_alloc_stat_arrays(vsi);
> +	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
>  		goto unroll_vsi_alloc;
>
