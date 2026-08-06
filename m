Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D47483BD9;
	Thu,  6 Aug 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036839; cv=none; b=FEEyWtCyyBKXgEdQsTbKdPXwCqNrDuaZAgKDDwa2BmGPvgDDISdjVcvSOnFGPWERoMhIiq+ftLbdbZavrkTK64iQF1R2FHTvn3DcMG1evHK/umNtcDIeLd2f4oKWeSV2sYl33laLAQbB85PiTYyx3d3UCaI9EVuk1flDDhfxX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036839; c=relaxed/simple;
	bh=EzwvdKaFJT7MEd7732zd6p5vSIwekeonF9KfM51pD+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l37Iey9irySLWzl7XnMFbvcTW3p+6Jm1EamXEKXC/gern+q0It9tetTSmC+c+jxrFnSgvLXUdbNhT7cb4x0h2p53J7UO7kOn1efx5nfo9CNDgmM+IIrGk9VUr5WTSosErNW0CYTHLwnrGmSqV+eaQwbutGQ0SnVG2OqftKFqVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvqjUsAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvqjUsAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E4D1F000E9;
	Thu,  6 Aug 2026 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036837;
	bh=VNu6z97uYtGA9znTuFeCX/oISOk9eGI2tJZmhWXvVb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvqjUsARLImpFDUBzSY+qzYrcFqSdPYQBWlXSbQnDMvak6zTZOR6ODD9m4zOjz1Fo
	 aJe4u7uqnabukxptgSwV1CJDbuYLkTKAqVn9GH8X0/5Q+q+1PdHLj/q8jGOlTqEXow
	 +tlD0PuZgXhJ/5yz7Xbm6dGY3EuJjtY6PvBZJFCG8l3J9HeHn63UXdw2wi9nfp1qB2
	 TjoPa4X44zwQWz2Qd5+7hoBAJcjWVGrH0Hr5/1aft36em7tStQrXIJqeJAjj+D6Las
	 kEgPt7fIdJzlf7AaKE/0OnqZFky9EPiYEZGxYW8LqfGlFZPlh63c/iWrvy0sJpFjVp
	 gh0tkg3+GmVuA==
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
Subject: Re: [PATCH net 04/10] ice: skip unnecessary VF reset when setting trust
Date: Thu,  6 Aug 2026 10:20:36 -0700
Message-ID: <20260806172036.2935667-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-5-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-5-anthony.l.nguyen@intel.com>
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
ice: skip unnecessary VF reset when setting trust

This changes ice_set_vf_trust() so that granting trust never resets the VF,
and revoking trust only resets when vf->num_mac_lldp is non-zero or one of
the promiscuous state bits is set.  A new helper, ice_setup_vf_trust(),
flips ICE_VIRTCHNL_VF_CAP_PRIVILEGE directly on the no-reset path.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de02155966..5589378998181 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1366,6 +1366,23 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
>  }
>  
> +/**
> + * ice_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no advanced
> + * features configured that need cleanup).
> + */

[Severity: Low]
This isn't a bug, but does the kernel-doc match the only call site?  The
comment says the helper "is only called when it's safe to skip the reset (VF
has no advanced features configured that need cleanup)", yet
ice_set_vf_trust() takes the else branch for every trust grant without
looking at vf->num_mac_lldp, the promiscuous bits, vf->num_mac or the VLAN
count at all, and on revoke it only consults the LLDP counter and the two
promiscuous bits.  Would it be clearer to describe the condition the caller
actually enforces?

> +static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
> +{
> +	if (setting)
> +		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +}
> +
>  /**
>   * ice_set_vf_trust
>   * @netdev: network interface device structure
> @@ -1401,11 +1418,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>  
>  	mutex_lock(&vf->cfg_lock);
>  
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> -
> -	vf->trusted = trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	/* Reset only if revoking trust and VF has advanced features configured */
> +	if (!trusted &&
> +	    (vf->num_mac_lldp > 0 ||
> +	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
> +	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {

[Severity: High]
Should this predicate also cover the MAC and VLAN filter quotas that trust
lifts?  Trust does more than gate LLDP filters and promiscuous mode.

The unicast/multicast MAC budget is only enforced for untrusted VFs, in
ice_vc_handle_mac_addr_msg() (virt/virtchnl.c):

	if (set && !ice_is_vf_trusted(vf) &&
	    (vf->num_mac + al->num_elements) > ICE_MAX_MACADDR_PER_VF) {

The VLAN budget works the same way, in ice_vf_has_max_vlans():

	static bool ice_vf_has_max_vlans(struct ice_vf *vf, struct ice_vsi *vsi)
	{
		if (ice_is_vf_trusted(vf))
			return false;

and a trusted VF may override an administratively set MAC, in
ice_can_vf_change_mac():

	if (vf->pf_set_mac && !ice_is_vf_trusted(vf))
		return false;

All three checks run only at add time, so already-programmed filters are
never re-audited.  Previously the reset was what removed them, via
ice_reset_vf() -> ice_vf_reconfig_vsi() -> ice_fltr_remove_all(), and
ice_vf_pre_vsi_rebuild() -> ice_vf_clear_counters() is what reset the
accounting:

	if (vsi)
		vsi->num_vlan = 0;

	vf->num_mac = 0;
	vf->num_mac_lldp = 0;

So for a VF that added over-quota MAC or VLAN filters while trusted, but
never enabled promiscuous mode and never added an LLDP MAC, does "ip link
set <pf> vf N trust off" now report success while the hardware switch
filters stay programmed?  Since the ice anti-spoof behaviour is driven by
that filter list, can the now-untrusted guest keep receiving and
transmitting with addresses and VLANs it was only permitted to program while
trusted?

There is a second effect of skipping ice_vf_clear_counters(): vf->num_mac
and vsi->num_vlan stay at their trusted-era values, which are above the
untrusted limits.  Does that make every subsequent filter add from the
untrusted VF fail against stale accounting until some unrelated VF reset
happens?

> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);

[Severity: Medium]
This isn't a bug introduced by this patch, since the pre-patch loop had the
same shape, but the unchecked ice_get_vf_vsi(vf) result is handed to a callee
whose NULL check comes after a dereference, in ice_vf_update_mac_lldp_num()
(ice_vf_lib.c):

	bool lldp_by_fw = test_bit(ICE_FLAG_FW_LLDP_AGENT, vsi->back->flags);
	bool was_ena = ice_vf_is_lldp_ena(vf) && !lldp_by_fw;
	bool is_ena;

	if (WARN_ON(!vsi)) {
		vf->num_mac_lldp = 0;
		return;
	}

vsi->back is read in the initializer, before WARN_ON(!vsi), so both the
warning and the vf->num_mac_lldp = 0 fallback that terminates this loop are
unreachable for a NULL VSI.

I could not find a reachable state where vf->num_mac_lldp is non-zero with a
NULL VF VSI (ice_free_vf_res() and the reset paths all zero the counter),
so this looks latent rather than triggerable.  Would it be worth computing
lldp_by_fw after the WARN_ON(!vsi) check so the guard actually guards?

> +		vf->trusted = trusted;
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);

[Severity: Medium]
This is a pre-existing asymmetry rather than something the patch introduces,
but now that ice_setup_vf_trust() exists, should it be called on this branch
too?

On the reset branch, vf->trusted is written but ICE_VIRTCHNL_VF_CAP_PRIVILEGE
in vf->vf_caps, which is what ice_is_vf_trusted() reads, is only re-derived
as a side effect of the rebuild:

ice_reset_vf() -> ice_vf_post_vsi_rebuild() -> ice_vf_rebuild_host_cfg() ->
ice_vf_set_host_trust_cfg()

	static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
	{
		assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, vf->trusted);
	}

ice_reset_vf() has several exits that never reach the rebuild, for example:

	if (test_bit(ICE_VF_RESETS_DISABLED, pf->state)) {
		dev_dbg(dev, "Trying to reset VF %d, but all VF resets are disabled\n",
			vf->vf_id);
		return 0;
	}

plus the ice_is_vf_disabled() path, the two WARN_ON(!vsi) exits and
ice_vf_reconfig_vsi() failure.  The return value is discarded here and the
dev_info() below prints "VF %u is now %strusted" regardless.

On those paths, do vf->trusted and the privilege bit diverge while the
operation still reports success?  ICE_VF_RESETS_DISABLED is only set in
ice_remove(), and the other exits leave ICE_VF_STATE_ACTIVE cleared, which
the privileged virtchnl handlers check first, so this looks like a state and
reporting inconsistency rather than retained privilege.  Would calling
ice_setup_vf_trust(vf, trusted) on both branches and propagating
ice_reset_vf()'s error be worthwhile?

> +	} else {
> +		vf->trusted = trusted;
> +		ice_setup_vf_trust(vf, trusted);
> +	}

[Severity: Medium]
What happens to the already negotiated VLAN_V2 capabilities when trust
changes without a reset?  The advertised VLAN filter budget is derived from
vf->trusted once, in ice_vc_get_max_vlan_fltrs() (virt/virtchnl.c):

	static u16 ice_vc_get_max_vlan_fltrs(struct ice_vf *vf)
	{
		if (vf->trusted)
			return VLAN_N_VID;
		else
			return ICE_MAX_VLAN_PER_VF;
	}

and cached by ice_vc_get_offload_vlan_v2_caps():

	/* store negotiated caps to prevent invalid VF messages */
	memcpy(&vf->vlan_v2_caps, caps, sizeof(*caps));

VIRTCHNL_OP_ADD_VLAN_V2 is then validated only against that cached copy, in
ice_vc_validate_add_vlan_filter_list():

	if (num_requested_filters > vfc->max_filters)
		return false;

with no ice_is_vf_trusted() re-check.  The cache is invalidated only by
ice_vf_set_initialized():

	memset(&vf->vlan_v2_caps, 0, sizeof(vf->vlan_v2_caps));

which is reached from ice_vf_post_vsi_rebuild(), i.e. only on the reset path
this branch skips.  The iavf side caches and enforces the advertised limit
itself as well, in iavf_get_max_vlans_allowed() and iavf_vlan_rx_add_vid().

So for a VLAN_V2 capable VF, is granting trust here a no-op for the VLAN
path, leaving the VF and PF both at ICE_MAX_VLAN_PER_VF?  And in the other
direction, if the VF negotiated caps while already trusted and trust is
revoked through this branch, does it keep the VLAN_N_VID budget while
untrusted?

>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>  

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but it is in
the function being modified.  Earlier in ice_set_vf_trust(), the switchdev
check returns without releasing the reference taken by ice_get_vf_by_id():

	vf = ice_get_vf_by_id(pf, vf_id);
	if (!vf)
		return -EINVAL;

	if (ice_is_eswitch_mode_switchdev(pf)) {
		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
		return -EOPNOTSUPP;
	}

ice_get_vf_by_id() documents that "This function takes a reference to the VF,
which must be released by calling ice_put_vf()", and the out_put_vf label at
the end of the function is what normally does that.  Does each "ip link set
<pf> vf N trust on|off" issued while the PF is in switchdev mode leak a VF
reference, so ice_sriov_free_vf() never runs for that struct ice_vf?  Would
"ret = -EOPNOTSUPP; goto out_put_vf;" be the right fix while here?
