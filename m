Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF3373BF2;
	Thu,  6 Aug 2026 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036837; cv=none; b=S8ERiekaxBNGFv6xeAbXzpUJifsxnrguNK/2l2D4i5bWSmogWl1Px34VyIa+iIfqGIdu17g81pseOMZWY/TZrs5N+Yb88nHvRxk03G8/NVOk1pbhTSwDSow7VGzFpyOks8pBdlBJHpf8EXx2o8mUlsFl0AXzPJjrrZ1oukU/xKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036837; c=relaxed/simple;
	bh=Pdiwbuw1xBM8VjepAC6PY+V+Nhp3v3vBkdZiE6Exaes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYa1SVxf+KZMWUw1cx65qvBPa4ykk9QhUKHXcbnVRxBkKWFf49PvSjoXG5OhcwGJHJ3xJRhD7sy0fwJnxCotPnQ6uF3Lu1L1Zp88y3mZVqVmxgHgvFDRt8QRZ+W15tz23PxzWh3AEZj+G/MiftnlnLV+jS8U+MJOm06r498daYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH3W13hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH3W13hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1D1F000E9;
	Thu,  6 Aug 2026 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036835;
	bh=lXodhEixoWYm+1HeqpnVEnBqMk0WOyleEgsuW/1VOjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UH3W13hnfISkyxwGT1zv0UKzWsj0z1rLw7eOBAQHbxas4TmXc6WaIY2QCbEjxJzeD
	 m0f5IaGEfSmuhjI+T82/du8qFz4oluLr6wA0vbtu6v+u4h3xo9uNEJYKuPmsHx+yX1
	 Fdk87iPNVLp6Z9bo+PGBGt4YyIluSt1Z2jA7qI8mMxrga+MVBos5W02TYTAzaXvo8C
	 IawJRZn5pS2DsV8tWlGpS3m3rrZncaY4Ic2BbGOI2B0Os76rUdAN1CAB4BEtHJm6sZ
	 JeNLIolbENugYhRRpLvGnfg9eqz3x8D29G73ZuCJm3QLoH2P1O/HRae4pvn2LBRNE6
	 RfNrk5w+OyYqA==
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
Subject: Re: [PATCH net 02/10] i40e: skip unnecessary VF reset when setting trust
Date: Thu,  6 Aug 2026 10:20:34 -0700
Message-ID: <20260806172034.2935502-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-3-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-3-anthony.l.nguyen@intel.com>
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
i40e: skip unnecessary VF reset when setting trust

This changes i40e_ndo_set_vf_trust() so that granting trust never resets
the VF, and revoking trust only resets when the VF has ADQ, cloud filters
or promiscuous mode configured. A new helper i40e_setup_vf_trust() flips
I40E_VIRTCHNL_VF_CAP_PRIVILEGE directly when the reset is skipped.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec156..0cc434b26eb88 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4943,6 +4943,23 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no advanced
> + * features configured that need cleanup).
> + */

[Severity: Low]
This isn't a bug, but is the stated precondition accurate? The only call
site is the else branch of a condition that begins with !setting, so the
helper runs for every trust grant no matter what the VF has configured.

An untrusted VF can already have "advanced features" configured:
i40e_vc_add_qch_msg() sets vf->adq_enabled = true after checking spoofchk,
negotiated ADQ capability, TC count and queue availability, with no
trust/privilege test, and i40e_validate_cloud_filter() only requires
I40E_VIRTCHNL_VF_CAP_PRIVILEGE for advanced-mode filters.

Would it be clearer to document the real contract, i.e. "called whenever
the reset is skipped: on every grant, and on revokes where no cleanup is
deemed necessary"?

> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
> +{
> +	if (setting)
> +		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +}

[Severity: Medium]
Can this write of the privilege bit be clobbered by a concurrent VF reset?

i40e_alloc_vf_res() recomputes the same bit from a plain read of
vf->trusted, with no lock and no READ_ONCE():

	if (vf->trusted)
		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
	else
		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);

Its only caller is i40e_cleanup_reset_vf(), reached from i40e_reset_vf()
in the service task for guest-initiated resets (VIRTCHNL_OP_RESET_VF and
VFLR). i40e_vc_process_vf_msg() is dispatched from
i40e_clean_adminq_subtask() without rtnl_lock() and without
__I40E_VIRTCHNL_OP_PENDING, so it runs in parallel with the ndo handler:

service task				ndo path (rtnl held)
i40e_alloc_vf_res()
  reads old vf->trusted
					vf->trusted = setting;
					i40e_setup_vf_trust(vf, setting);
  set_bit()/clear_bit() using
  the stale value

vf->trusted and I40E_VIRTCHNL_VF_CAP_PRIVILEGE then stay inconsistent
until some later reset. Before this patch i40e_ndo_set_vf_trust() always
called i40e_vc_reset_vf(), which retries i40e_reset_vf() (serialized by
test_and_set_bit(I40E_VF_STATE_RESETTING)) until a reset happened in the
caller's own thread, so the bit was always recomputed last from the
up-to-date vf->trusted. Does the new path need a barrier or to hold off
against I40E_VF_STATE_RESETTING?

>  /**
>   * i40e_ndo_set_vf_trust
>   * @netdev: network interface device structure of the pf
> @@ -4987,19 +5004,20 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
>  
> -	i40e_vc_reset_vf(vf, true);
> +	/* Reset only if revoking trust and VF has advanced features configured */
> +	if (!setting &&
> +	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
> +	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
> +	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {
> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);
> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}

[Severity: High]
Does revoking trust still remove the MAC and VLAN filters that only a
trusted VF was allowed to install?

The new condition does not consider filter state, so a VF with no ADQ, no
cloud filters and no promiscuous bits takes the else branch, which only
clears the privilege bit.

While trusted, i40e_check_vf_permission() lets the VF install MACs that
override the administratively set vf->pf_set_mac address and raises the
limit from I40E_VC_MAX_MAC_ADDR_PER_VF to
I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF():

	if (!vf_trusted && !is_multicast_ether_addr(addr) &&
	    vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
		... return -EPERM;
	}
	...
	if (!vf_trusted)
		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
	else
		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(...);

i40e_vc_add_vlan_msg() likewise only enforces I40E_VC_MAX_VLAN_PER_VF on
add when the privilege bit is clear.

Previously the unconditional i40e_vc_reset_vf() reached
i40e_cleanup_reset_vf() -> i40e_free_vf_res(), which does
i40e_vsi_release(pf->vsi[vf->lan_vsi_idx]), destroying the VSI and all its
filters; i40e_alloc_vsi_res() then re-added only vf->default_lan_addr and
broadcast, and i40e_cleanup_reset_vf() set vf->num_vlan = 0.

Can the __I40E_MACVLAN_SYNC_PENDING work repair this instead? Looking at
i40e_correct_vf_mac_vlan_filters() it only recomputes the VLAN id of
existing entries:

	new_vlan = i40e_get_vf_new_vlan(vsi, NULL, f, vlan_filters, trusted);
	if (new_vlan != f->vlan) { ... }

so no MAC filter is deleted on trust loss.

There is also a functional side effect: mac_add_max drops back to 18 while
i40e_count_active_filters(vsi) still reflects the trusted-era filters, so
every later VIRTCHNL_OP_ADD_ETH_ADDR from that VF fails with -EPERM,
including a re-add of its primary MAC after a guest link down/up.

The commit message says "For VFs in a clean state, we can safely change
the trust setting without the disruptive reset" and lists only "ADQ/cloud
filters, promiscuous mode" as state requiring cleanup. Should the MAC and
VLAN filter state be part of that list, or at least mentioned as a
behaviour change?

[Severity: High]
Is there a check-then-act window here against the virtchnl handlers?

vf->adq_enabled, vf->num_cloud_filters and the promisc state bits are
written from the service task via i40e_clean_adminq_subtask() ->
i40e_vc_process_vf_msg(), which takes neither rtnl_lock() nor
__I40E_VIRTCHNL_OP_PENDING (all test_and_set_bit() sites for that bit are
ndo/sriov_configure entry points). The privilege bit is only cleared after
the sampling:

CPU0 i40e_ndo_set_vf_trust()
	vf->trusted = false;
	test_bit(I40E_VF_STATE_UC_PROMISC) == 0
	test_bit(I40E_VF_STATE_MC_PROMISC) == 0

CPU1 i40e_vc_config_promiscuous_mode_msg()
	/* privilege bit still set */
	i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti, alluni);
	... i40e_aq_set_vsi_unicast_promiscuous()/multicast in HW
	test_and_set_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states)

CPU0
	i40e_setup_vf_trust(vf, false);	/* clears privilege, no reset */

Does anything clear the hardware promiscuous flags afterwards? A later VF
request to disable promiscuous mode is rejected once the privilege bit is
clear, and the PF reports success to the VF:

	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
		... aq_ret = 0; goto err_out;
	}

and i40e_sync_vsi_filters() refuses to touch promiscuous for an untrusted
SRIOV VSI. The same window applies to the plain writes vf->adq_enabled =
true in i40e_vc_add_qch_msg() and vf->num_cloud_filters++ in
i40e_vc_add_cloud_filter(), which are read here without READ_ONCE() or a
lock. Since the guest chooses when to send those messages, it can toggle
promisc off and on to make the sampled bits read zero.

[Severity: Medium]
Can the software promisc bits under-report the hardware state?

In i40e_vc_config_promiscuous_mode_msg() the state bits are only set after
a fully successful call:

	aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti, alluni);
	if (aq_ret)
		goto err_out;

but i40e_set_vsi_promisc() issues several admin queue commands and can
succeed on some and fail on others:

	aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, seid, multi_enable, NULL);
	if (aq_ret) { ... return aq_ret; }
	aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, seid, unicast_enable, NULL, true);
	if (aq_ret) { ... }
	return aq_ret;

If multicast promiscuous is enabled in firmware and the unicast command
fails (or only some VLANs are programmed in the per-VLAN loop), no state
bit is recorded while the VSI is promiscuous in hardware. Trust revocation
then takes the no-reset branch and nothing clears it:
i40e_sync_vsi_filters() does

	if (vsi->type == I40E_VSI_SRIOV && pf->vf &&
	    !pf->vf[vsi->vf_id].trusted) {
		clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
		goto out;
	}

without issuing any promiscuous AQ command. Before this patch
i40e_cleanup_reset_vf() unconditionally ran

	/* disable promisc modes in case they were enabled */
	i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_id, false, false);

regardless of the software bits. Would it be safer to call that
unconditionally on revoke rather than infer the state from the bits? Note
this one depends on an admin queue command failing part way through, which
I could not show a guest or admin can force.

> +
>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>  
> -	if (vf->adq_enabled) {
> -		if (!vf->trusted) {
> -			dev_info(&pf->pdev->dev,
> -				 "VF %u no longer Trusted, deleting all cloud filters\n",
> -				 vf_id);
> -			i40e_del_all_cloud_filters(vf);
> -		}
> -	}
> -
>  out:
>  	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
>  	return ret;
