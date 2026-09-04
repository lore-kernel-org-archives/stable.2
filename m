Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BE1D9663;
	Fri,  4 Sep 2026 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482916; cv=none; b=YDIg/8xuc0ZGFLdIhKVMXfbgqt7flpPPQQ+v8JC6UtB5Zf9ObTD2keutJZ2tzuY4r6XEzrbe7OLZ7Y/ELc/HrN0Vl6xOJjRxXewMfnbjHSWCxImBybF0FOu08SQk1DCobsBC623HJY7qEumD3+c1b3E+Bozdy6VP+6womRvHaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482916; c=relaxed/simple;
	bh=iEAEwpVzOE3Af53JLyu9mH57pjY87sEiVAmOac/k+y0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T0RnEqsaIZy59bBpyx3FJEvO9VIB7mQW9bkwatVtQYJBHgju0UJm6QKBmVExRyPJkb67qbhLPrC3nYk+OLHoYsmqEs1ST0tnrODnyCvzjXdNpvtRz/25lt9ZNdI8adfNJICr8syf17zjsWQlPXnfayaIm0bVqKoncdOGOqnCHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py+L6I0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py+L6I0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF251F000E9;
	Fri,  4 Sep 2026 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482914;
	bh=dOHVVyF7okVEYuipss94Zjsce8DACDFZcyzQ1q6L0KE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Py+L6I0dgr2GZcPFIenLIVBMD/N3Yh3DK62DctohpBYKifUY3nM847tI09Ls+qWpv
	 OXPh9LeB3U5YeFJrD+gY9Cx7r/8bxPgwiBC4wgfXXtIqM8Vlddxn09qAk2ctVIEx68
	 MMKkujZApmUgIrYPMejyag8YYVB/Sks+EDi65XVQIL/sOyzHndp3e2NUH9zEb6QQDW
	 q6d4CDv1piOmGIOZBBrmPUwOBbqmNsAA/OErwLv8AtcuNit0n7tlxHInYtx1jlDZdE
	 WzxiEcrgZ1IZp1A8aVBX6E0qCYXk6uIIKoZfjVzwRVB6fqoc7zeWkP70IPZy10l+9b
	 7jb+HOlx1zd5Q==
Subject: Re: [PATCH net v3] bnxt_en: avoid redundant RX mask updates in UC
 overflow state
From: netdev-bot+sashiko@kernel.org
To: johnathan.browall@topgolf.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 pontus.hallstedt@topgolf.com
Date: Fri, 04 Sep 2026 00:48:33 +0000
Message-ID: <178848291342.4131868.10306546194660342556@kernel.org>
In-Reply-To: <20260901-bnxt-uc-overflow-v3-1-2ea7c42c013c@topgolf.com>
References: <20260901-bnxt-uc-overflow-v3-1-2ea7c42c013c@topgolf.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] In the steady UC-overflow state (BNXT_VNIC_UC_PROMISC_FLAG
  set, uc count > BNXT_MAX_UC_ADDRS-1), a mask-only rx-mode change whose…
- [Medium] BNXT_VNIC_UC_PROMISC_FLAG can remain set while secondary L2
  filters are programmed (vnic->uc_filter_count > 1), and the new short-…
- [Low] The new comment in bnxt_uc_list_updated() (bnxt.c:13794-13800)
  asserts that in the flagged state "no secondary L2 filters are…

--

bnxt_en: avoid redundant RX mask updates in UC overflow state

The patch adds a new vnic flag, BNXT_VNIC_UC_PROMISC_FLAG, that records
the state in which the unicast address list is longer than the available
L2 filter slots.  While the flag is set, bnxt_uc_list_updated() only
reports an update once the list fits again, and bnxt_set_rx_mode() keeps
the promiscuous bit in the recomputed mask, so an unchanged rx mode no
longer resends HWRM_CFA_L2_SET_RX_MASK.  The flag is committed only after
bnxt_hwrm_cfa_l2_set_rx_mask() has succeeded.

A few questions on the new state handling below.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 9c2cc50276a59..1e9e869340ef3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13791,6 +13791,16 @@ static bool bnxt_uc_list_updated(struct bnxt *bp,
>  	struct netdev_hw_addr *ha;
>  	int off = 0;
>  
> +	/* In the overflow state no secondary L2 filters are programmed
> +	 * and unicast RX relies on the promiscuous mask, so the list
> +	 * only needs reprogramming once it fits the available filters
> +	 * again.  Reporting an update here would resend an identical
> +	 * SET_RX_MASK on every callback, which causes brief RX packet
> +	 * loss on some chips.
> +	 */

[Severity: Low]
This isn't a bug, but does the comment hold for an untrusted VF?

bnxt_cfg_rx_mode() sets uc_promisc = true on overflow, but the skip_uc
block then removes the bit again:

	if ((vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS) &&
	    !bnxt_promisc_ok(bp))
		vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;

The flag is still committed from uc_promisc afterwards, so in that case
the flag is set while the promiscuous mask bit was never installed, and
unicast RX does not rely on it.

The same bit then means "overflow occurred" here and at the commit site,
but "promiscuous is installed and usable" in bnxt_set_rx_mode(), which
gates on bnxt_promisc_ok(bp).  Note that gating the commit itself on
bnxt_promisc_ok(bp) would bring the redundant sends back for untrusted
VFs, since bnxt_uc_list_updated() would again report an update on every
callback while vnic->uc_filter_count is 1.  Could the comment be reworded
so it does not claim promiscuous reception is in effect, and could the
difference between the two readers be spelled out?

> +	if (vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG)
> +		return netdev_hw_addr_list_count(uc) <= (BNXT_MAX_UC_ADDRS - 1);
> +

[Severity: Medium]
Can this short-circuit leave secondary L2 filters programmed for good?
It decides from the flag and the list length only, ignoring
vnic->uc_filter_count, and vnic->uc_filter_count can be greater than 1
while the flag is set.

The way in is a failed attempt to leave the overflow state.  With
uc_update true, bnxt_cfg_rx_mode() frees the old filters, takes the else
branch (uc_promisc = false), programs the secondary filters, and then
returns early without committing the flag if either the filter
programming fails:

	rc = bnxt_hwrm_set_vnic_filter(bp, 0, i, vnic->uc_list + off);
	if (rc) {
		...
		} else if (rc == -EAGAIN) {
			netdev_warn(bp->dev, "FW busy while setting vnic filter, will retry\n");
		...
		vnic->uc_filter_count = i;
		return rc;
	}

or the new mask send fails.  The flag is therefore still set with filters
installed.  If the UC list grows above BNXT_MAX_UC_ADDRS - 1 again before
a retry succeeds, this return reports "no update", bnxt_cfg_rx_mode()
jumps to skip_uc and never runs:

	for (i = 1; i < vnic->uc_filter_count; i++) {
		struct bnxt_l2_filter *fltr = vnic->l2_filters[i];

		bnxt_hwrm_l2_filter_free(bp, fltr);
		bnxt_del_l2_filter(bp, fltr);
	}

so the filters for unicast addresses that may already have been removed
from the netdev stay programmed until the list drops below the limit
again or bnxt_hwrm_clear_vnic_filter() runs at close.  On an untrusted VF
this is visible as frames for removed addresses still being accepted
while newly added ones are not.  Before the patch the uc_filter_count
mismatch always reported an update, so the next rx-mode callback freed
them.

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
> @@ -13853,6 +13870,9 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
>  	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
>  	struct netdev_hw_addr *ha;
>  	int i, off = 0, rc;
> +	bool uc_promisc;
> +
> +	uc_promisc = !!(vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG);
>  
>  	if (!uc_update)
>  		goto skip_uc;
> @@ -13869,7 +13889,12 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
>  	netif_addr_lock_bh(dev);
>  	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
>  		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
> +		uc_promisc = true;
>  	} else {
> +		uc_promisc = false;
> +		if (!(dev->flags & IFF_PROMISC))
> +			vnic->rx_mask &=
> +				~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
>  		netdev_hw_addr_list_for_each(ha, uc) {
>  			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
>  			off += ETH_ALEN;

[ ... ]

> @@ -13907,11 +13932,24 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
>  		vnic->mc_list_count = 0;
>  		rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, 0);
>  	}
> -	if (rc)
> +	if (rc) {
>  		netdev_err(bp->dev, "HWRM cfa l2 rx mask failure rc: %d\n",
>  			   rc);
> +		return rc;
> +	}
>  
> -	return rc;
> +	/* Commit the overflow state only once the mask is installed, so
> +	 * that a failed attempt keeps the state marked as changed and the
> +	 * next retry or rx-mode callback programs the mask again.
> +	 */

[Severity: Medium]
In the steady overflow state, is there anything left after this failure
path that marks the state as changed?

The commit message says:

  "The flag is committed only after bnxt_hwrm_cfa_l2_set_rx_mask()
   succeeds, so a failed attempt leaves the state marked as changed and
   the next retry or rx-mode callback programs the mask again.  This
   matches the behavior before this patch"

bnxt_set_rx_mode() assigns vnic->rx_mask = mask before it calls
bnxt_cfg_rx_mode(), so after the send fails the driver already records
the new mask while the firmware still holds the old one:

	if (mask != vnic->rx_mask || uc_update || mc_update) {
		vnic->rx_mask = mask;

		return bnxt_cfg_rx_mode(bp, uc, uc_update);
	}

	return 0;

On the retry from netif_rx_mode_run() the recomputed mask is identical,
because the new bnxt_set_rx_mode() hunk re-adds PROMISCUOUS from the
flag; uc_update is false through the new early return in
bnxt_uc_list_updated() (the list is still above the limit); and
mc_update is false.  So mask == vnic->rx_mask, the function returns 0
without any firmware call, and netif_rx_mode_run() clears
dev->rx_mode_retry_count, ending the retry sequence.

A concrete case: with 19 secondary unicast addresses, "ip link set dev X
allmulticast on" whose SET_RX_MASK fails (hwrm_req_send_silent() can
return -EBUSY/-ETIMEDOUT/-ENODEV, and the MCAST fallback branch is
skipped because ALL_MCAST rather than MCAST is set) leaves ALL_MCAST
unprogrammed with no further attempt.

Before the patch this converged, since vnic->uc_filter_count was 1 while
the list was non-empty, so bnxt_uc_list_updated() returned true and every
callback re-issued the mask.  The underlying "rx_mask committed before
send" defect is pre-existing and is described in the notes under the
"---" line, but the accidental uc_update signal that made the overflow
case recover is removed here.  Should the flag commit be paired with
committing vnic->rx_mask only after a successful send, or should the
commit message drop the claim that this matches the previous behaviour?

> +	netif_addr_lock_bh(dev);
> +	if (uc_promisc)
> +		vnic->flags |= BNXT_VNIC_UC_PROMISC_FLAG;
> +	else
> +		vnic->flags &= ~BNXT_VNIC_UC_PROMISC_FLAG;
> +	netif_addr_unlock_bh(dev);
> +
> +	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901-bnxt-uc-overflow-v3-1-2ea7c42c013c%40topgolf.com
