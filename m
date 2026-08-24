Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E93384CC4;
	Mon, 24 Aug 2026 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598110; cv=none; b=bgsnd0xd/3mzXUYVF2vuiMnL3e2pCfo8ghPeLVWQS650CcxdvBBoMStCMFBCW/urKJwISPNmIDBrx+Iujc+ymUF4SRZq9YxEu5r/WXq2Jk8We55mN3So0Rdp1lG/PX4f/s20UsRBkgfdZuTkiz05UZ0ZfKWiiP7Iqxbo8IQ4CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598110; c=relaxed/simple;
	bh=eyU6r0SishXykL6vOGQc0Xujzk1E/Hki3H9UxM5+g9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4DjmECyFVJLZDZP3BIyi0JJSn0XERk/fT04b3TQxeKa7ZWszKxqE/eHFe1ah2e7kiWmN9Tccykm9PAmq3gtN6lNdaRb1Gs8YxoCfN+dcfJv1+kI2/2vweEud8V9HJ3Qtg0aMmVEB4BkzUi1HMiY9bScWSsNuSC87cn8yRp0tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ1pQWoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ1pQWoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF89B1F00A3A;
	Mon, 24 Aug 2026 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598108;
	bh=whCxGhkN1F/IkrbyKB7rAyMLLjPIW2qrMZfBStfHyG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJ1pQWoJps39Mrc3jMFCH6/BbjZPxGL91CytMbzcTrdcb+kxXf7oN6rFKPEGnoF71
	 MGodN7YYeZUTxZdkSSne6E+kz6T7TVBsvfFCALj3WTqwNIt5hCzvRxOuf+8dYDqkkz
	 YWstNiHbzLNsKjDYgp0BTZJntyHDdJx9j75NDhqGQuME4GHllPnvnkfvUe5OR4mSXO
	 uUjOi6oz6BLFGxwKChOFXTQZIW3jdtmreL/R+C5qsIVI68QfsdZSvjdqYvg7KTeC8H
	 4x26hSXGTjZZw32XCeF2aE/sTnXodw7kjLELeN7ZC2K87l7kYEQWX8shyRVuYw4XPJ
	 SHScW3+gApCiQ==
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
Subject: Re: [PATCH net 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Mon, 24 Aug 2026 12:01:47 -0700
Message-ID: <20260824190147.2714513-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204537.2189112-3-anthony.l.nguyen@intel.com>
References: <20260821204537.2189112-3-anthony.l.nguyen@intel.com>
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

This changes i40e_ndo_set_vf_trust() so that the VF reset is only performed
when trust is being revoked and the VF has ADQ, cloud filters or
promiscuous mode configured. In the other cases a new helper,
i40e_setup_vf_trust(), just sets or clears
I40E_VIRTCHNL_VF_CAP_PRIVILEGE. A few questions below about the state that
the skipped reset used to clean up.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec15..0cc434b26eb8 100644
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
> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
> +{
> +	if (setting)
> +		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +}

[Severity: Medium]

This helper writes I40E_VIRTCHNL_VF_CAP_PRIVILEGE from the ndo (rtnl)
context. i40e_alloc_vf_res() derives the same bit from an unsynchronized
read of vf->trusted:

i40e_alloc_vf_res()
	if (vf->trusted)
		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
	else
		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);

That runs from i40e_reset_vf()->i40e_cleanup_reset_vf()->i40e_alloc_vf_res()
in service task context, and a VF can request a reset itself through
VIRTCHNL_OP_RESET_VF.

If that path reads vf->trusted and is preempted before the
set_bit()/clear_bit(), can i40e_ndo_set_vf_trust() update vf->trusted and
call i40e_setup_vf_trust() in between, so the stale write lands last? That
would leave vf->trusted true with the capability bit clear, or vf->trusted
false with the bit still set.

Before this patch the ndo always followed the vf->trusted update with
i40e_vc_reset_vf(), so the bit was recomputed from the final value of
vf->trusted. With the reset skipped, is anything left that reconciles the
two?

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

[Severity: High]

Does this condition need to consider the MAC and VLAN filters that the VF
was only allowed to install because it was trusted?

Trust is checked at add time only. i40e_check_vf_permission():

	vf_trusted = test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
	...
	if (!vf_trusted && !is_multicast_ether_addr(addr) &&
	    vf->pf_set_mac && ...)
		return -EPERM;
	...
	if (!vf_trusted)
		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
	else
		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(...);

and i40e_vc_add_vlan_msg():

	if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {

Nothing revalidates filters that are already installed when the privilege
bit is dropped.

Previously the revoke always went through
i40e_vc_reset_vf()->i40e_reset_vf()->i40e_cleanup_reset_vf(), which calls
i40e_free_vf_res():

i40e_free_vf_res()
	if (vf->lan_vsi_idx) {
		i40e_vsi_release(pf->vsi[vf->lan_vsi_idx]);

so every MAC/VLAN filter was purged, and i40e_cleanup_reset_vf() also set
vf->num_vlan = 0.

A VF that used only the privileged MAC/VLAN allowances has
adq_enabled == false, num_cloud_filters == 0 and both promisc bits clear,
so it takes the else branch here and only the capability bit is cleared.
Can such a VF keep receiving on MAC/VLAN combinations an untrusted VF may
never request, including a MAC that overrides the administratively set
vf->default_lan_addr, while ip link reports trust off?

Is the requested MACVLAN resync enough to cover this? Following
i40e_sync_vsi_filters()->i40e_correct_vf_mac_vlan_filters() in
i40e_main.c:

	new_vlan = i40e_get_vf_new_vlan(vsi, NULL, f, vlan_filters, trusted);
	if (new_vlan != f->vlan) { ... }

that only re-derives I40E_VLAN_ANY versus 0 for existing filters, it does
not delete filters that exceed the untrusted quota.

As a second effect, vf->num_vlan and the active MAC filter count stay above
the untrusted limits, so does every later VLAN/MAC add from that VF get
rejected until an unrelated reset happens?

[Severity: Medium]

Can this sample of VF-controlled state race with the virtchnl handlers that
write it? i40e_vc_process_vf_msg() is called from
i40e_clean_adminq_subtask() in i40e_main.c:

	case i40e_aqc_opc_send_msg_to_pf:
		ret = i40e_vc_process_vf_msg(pf, ...);

which runs in service task context without rtnl_lock and without taking
__I40E_VIRTCHNL_OP_PENDING, so it does not exclude this ndo.

CPU1 in i40e_vc_config_promiscuous_mode_msg() passes the gate and starts
the admin queue work:

	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) { ... }
	...
	aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id,
						 allmulti, alluni);
	if (aq_ret)
		goto err_out;
	... test_and_set_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states)

CPU0 then runs i40e_ndo_set_vf_trust(), sees both promisc bits still clear
(they are set only after the admin queue sequence), takes the else branch,
clears the privilege bit and skips the reset. CPU1 finishes and sets
I40E_VF_STATE_UC_PROMISC with promiscuous mode programmed in hardware.

Does that leave an untrusted VF promiscuous indefinitely? The same ordering
appears in i40e_vc_add_cloud_filter(), where

	hlist_add_head(&cfilter->cloud_node, &vf->cloud_filter_list);
	vf->num_cloud_filters++;

happens after the filter is programmed, and in i40e_vc_add_qch_msg() which
sets vf->adq_enabled last.

> +		i40e_vc_reset_vf(vf, true);

[Severity: Medium]

This is a pre-existing issue and not introduced by this patch, but in this
branch the capability bit and the hardware promiscuous teardown are only
side effects of the reset, and i40e_vc_reset_vf() is void and can return
having done nothing:

i40e_vc_reset_vf()
	if (test_bit(__I40E_VFS_RELEASING, pf->state))
		return;
	if (i40e_reset_vf(vf, false))
		return;

i40e_reset_vf() also returns true immediately when __I40E_VF_RESETS_DISABLED
or __I40E_VF_DISABLE is set, and after 20 attempts the helper only warns.

In those cases vf->trusted is already false and the driver prints "VF %u is
now untrusted", but the bit consulted by i40e_check_vf_permission(),
i40e_vc_config_promiscuous_mode_msg(), i40e_vc_add_vlan_msg() and
i40e_vc_add_cloud_filter() is still set, since i40e_setup_vf_trust() is
only called from the else branch. i40e_ndo_get_vf_config() reports
ivi->trusted = vf->trusted, so the two can disagree.

Would calling i40e_setup_vf_trust(vf, setting) unconditionally, before the
branch, make both artifacts deterministic?

> +		i40e_del_all_cloud_filters(vf);

[Severity: Medium]

This ordering is pre-existing and not introduced by this patch, the
baseline also called i40e_vc_reset_vf() before i40e_del_all_cloud_filters()
in the "if (vf->adq_enabled && !vf->trusted)" block, but the restructuring
keeps it.

The reset just above releases the ADQ channel VSIs and zeroes their ids in
i40e_free_vf_res():

	if (j)
		i40e_vsi_release(pf->vsi[vf->ch[j].vsi_idx]);
	vf->ch[j].vsi_idx = 0;
	vf->ch[j].vsi_id = 0;

and i40e_alloc_vf_res() re-creates them with newly assigned seids. The
teardown then looks the VSI up by the recorded seid in
i40e_find_vsi_from_seid():

	for (i = 0; i < vf->num_tc ; i++) {
		vsi = i40e_find_vsi_from_id(pf, vf->ch[i].vsi_id);
		if (vsi && vsi->seid == seid)
			return vsi;
	}

If the seid changed, i40e_del_all_cloud_filters() takes the error path:

	vsi = i40e_find_vsi_from_seid(vf, cfilter->seid);
	if (!vsi) {
		dev_err(... "can't delete cloud filter\n" ...);
		continue;
	}

so the hlist_del(), the kfree(cfilter) and the vf->num_cloud_filters
decrement are all skipped. Does this leak the struct i40e_cloud_filter
allocations? Nothing else walks vf->cloud_filter_list, and with
vf->num_cloud_filters stuck non-zero the VF also takes the reset branch
here forever. Would deleting the cloud filters before triggering the reset
be the right order?

> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}
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
