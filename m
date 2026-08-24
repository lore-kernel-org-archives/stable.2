Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7023815F9;
	Mon, 24 Aug 2026 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598113; cv=none; b=pWnrlG/7oJNnWvb9Rx/g3OREr8X6+Jx1hWKFSPv47o3H/orkdeCPhfEaPU5C3pzO2RBTkFwemHSizITc8yeRZLKS5gG6Av6dy5oWqEMNpzd6sl3wDQBGeWbUPYTlqMl2eSIBd3cMk375zeSVzMhcZV/0lcwd726IAjT0P2wsQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598113; c=relaxed/simple;
	bh=eBfFrUsPK6F7O6dnhUc+ZBpA0h3SI4VvwkmmB4fyoQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbUKj7w3SO5NZHgcv1d4OpRedumt376pm/Ibhpu1MkeqLFA2j7tFaW4s4R+z8NsJVC1bueEgCu89ZngMlsg5Mv3eQ5L8TYBWY/An+tY8gm7giUnlHqTyj/CTdAiR4r7aCPj99R+zzm7sFBaZeUb+XV+goLAhPd04zoJjZaXCWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwQGbyNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwQGbyNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121971F000E9;
	Mon, 24 Aug 2026 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598111;
	bh=q29f7wdmzkjqg3X+b3IisSfZoqTbAcOUikamgP8GBZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NwQGbyNyzkO7yrYikvr0/92dVTeGzK3yq0MlwrPC2q16N0Ge1QU37t8lCraVfW19S
	 ERNxPcYkv/ETo6vBS/m04oWuJjSJYhzUKXzMoY9b6ufCd/Jb7PN6QNQVBpvL+P7GOG
	 JhxBknZufIcThKLoiy3LJmrSQt1p2GsiF6aGwIGXllp4ubKa0nl6JrYi9xMBhYTZ8K
	 G0w9BwSSJN6h8LWZ6a49lgqYxFWEqhMcvJK5+PA9Oo2ezhyplk8JaU1QTjGdb29W5k
	 +yOE2pyVdsEGCDBvb6Fw7FH6JFOzZqiK9rygynpShW5b8odKPFkDhvRumvz4TAtrqv
	 OaV+TpRoYBaKA==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	jtornosm@redhat.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	stable@vger.kernel.org,
	rafal.romanowski@intel.com
Subject: Re: [PATCH net 4/4] ice: skip unnecessary VF reset when setting trust
Date: Mon, 24 Aug 2026 12:01:50 -0700
Message-ID: <20260824190150.2714587-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204537.2189112-5-anthony.l.nguyen@intel.com>
References: <20260821204537.2189112-5-anthony.l.nguyen@intel.com>
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

The patch makes ice_set_vf_trust() skip the VF reset in most cases: granting
trust only sets the ICE_VIRTCHNL_VF_CAP_PRIVILEGE bit, and revoking trust
only resets when vf->num_mac_lldp is non-zero or one of the promiscuous
state bits is set.  A new helper, ice_setup_vf_trust(), toggles the
capability bit for the no-reset path.

A few questions about the new revocation logic below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..558937899818 100644
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
> +static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
> +{
> +	if (setting)
> +		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +}

[Severity: Low]
This isn't a bug, but doesn't ice_vf_lib.c already have a helper with
exactly these semantics?

drivers/net/ethernet/intel/ice/ice_vf_lib.c:
static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
{
	assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, vf->trusted);
}

It is called from ice_vf_rebuild_host_cfg() on the reset path.  Would it be
preferable to export that one (ice_vf_lib_private.h already declares
ice_is_vf_trusted()) rather than carry a second copy of the rule that
derives ICE_VIRTCHNL_VF_CAP_PRIVILEGE from vf->trusted in a different file?

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
Is this predicate complete with respect to everything trust gates in ice?
Besides LLDP filters and promiscuous mode, vf->trusted also gates the MAC
and VLAN filter quotas and the administratively assigned MAC:

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_can_vf_change_mac() {
	if (vf->pf_set_mac && !ice_is_vf_trusted(vf))
		return false;
}

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vc_handle_mac_addr_msg() {
	if (set && !ice_is_vf_trusted(vf) &&
	    (vf->num_mac + al->num_elements) > ICE_MAX_MACADDR_PER_VF) {
}

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vf_has_max_vlans() {
	if (ice_is_vf_trusted(vf))
		return false;
}

So a guest that was trusted can have installed extra unicast/multicast MAC
filters, a MAC that overrides the pf_set_mac address, and more than
ICE_MAX_VLAN_PER_VF VLANs.  None of that shows up in num_mac_lldp or the
promisc bits, so with those clear, "ip link set <pf> vf N trust off" takes
the new else branch.

Do those hardware filters then stay programmed after the log prints "VF N is
now untrusted"?  Previously the unconditional reset reached:

drivers/net/ethernet/intel/ice/ice_vf_lib.c:ice_vf_reconfig_vsi() {
	ice_vsi_decfg(vsi);
	ice_fltr_remove_all(vsi);
}

followed by ice_vf_rebuild_host_cfg(), which re-adds only broadcast plus the
host-sanctioned MAC/VLAN config.

The software counters look affected too.  They are cleared only on the reset
path:

drivers/net/ethernet/intel/ice/ice_vf_lib.c:ice_vf_clear_counters() {
	if (vsi)
		vsi->num_vlan = 0;

	vf->num_mac = 0;
	vf->num_mac_lldp = 0;
}

Can vf->num_mac therefore remain above ICE_MAX_MACADDR_PER_VF after trust is
revoked, so that later legitimate MAC adds from the now-untrusted VF are
rejected until some unrelated reset happens?

Relatedly, the kernel-doc on ice_setup_vf_trust() says it "is only called
when it's safe to skip the reset (VF has no advanced features configured
that need cleanup)", and the commit message says the features needing cleanup
are "(MAC LLDP filters, promiscuous mode)".  Should both mention the MAC and
VLAN filter state as well?

> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> +		vf->trusted = trusted;
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	} else {
> +		vf->trusted = trusted;
> +		ice_setup_vf_trust(vf, trusted);
> +	}

[Severity: High]
What happens to the negotiated VLAN V2 capabilities when trust changes
without a reset?  The advertised limit is derived from vf->trusted once, at
negotiation time, and then cached on the PF:

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vc_get_max_vlan_fltrs() {
	if (vf->trusted)
		return VLAN_N_VID;
	else
		return ICE_MAX_VLAN_PER_VF;
}

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vc_get_offload_vlan_v2_caps() {
	/* store negotiated caps to prevent invalid VF messages */
	memcpy(&vf->vlan_v2_caps, caps, sizeof(*caps));
}

VLAN V2 adds are validated against that snapshot only:

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vc_validate_add_vlan_filter_list() {
	if (num_requested_filters > vfc->max_filters)
		return false;
}

and the snapshot is invalidated only on the reset path:

drivers/net/ethernet/intel/ice/ice_vf_lib.c:ice_vf_set_initialized() {
	memset(&vf->vlan_v2_caps, 0, sizeof(vf->vlan_v2_caps));
}

If the VF negotiated VIRTCHNL_VF_OFFLOAD_VLAN_V2 while trusted, does the
else branch leave max_filters at VLAN_N_VID, allowing the now-untrusted VF
to keep programming VLAN filters well beyond ICE_MAX_VLAN_PER_VF?

In the other direction, after granting trust without a reset both the PF
cache and the guest cache still hold 8:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_get_max_vlans_allowed() {
	else if (VLAN_V2_ALLOWED(adapter))
		return adapter->vlan_v2_caps.filtering.max_filters;
}

so is the commit message statement "When granting trust, no reset is needed
- we can just set the capability flag to allow privileged operations"
accurate for VLAN filtering, where the privilege only becomes usable after
renegotiation?

[Severity: Medium]
This isn't a bug introduced by this patch, but while ice_set_vf_trust() is
being touched: the switchdev check earlier in this same function returns
without releasing the VF reference taken by ice_get_vf_by_id():

	if (ice_is_eswitch_mode_switchdev(pf)) {
		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
		return -EOPNOTSUPP;
	}

Every other exit uses "goto out_put_vf;" so that ice_put_vf() drops the
kref_get_unless_zero() reference.  Since the leaked reference keeps the
refcount above zero, ice_release_vf() never runs, so neither
pci_dev_put(vf->vfdev) nor the kfree_rcu() of the ice_vf ever happens when
SR-IOV is disabled or the driver is unbound.  Would it make sense to convert
that return into "goto out_put_vf;" here?
