Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFFA3603D5;
	Mon, 21 Sep 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973468; cv=none; b=PUnXbNRZchd5UKpxub+f1JzheP6N4E9tlb9W17VPlGMgP1EIXr+VcOx/xHXwGA6e+sNo87dQCjOH9DtdxqOd5RrAefBXLwRqqA8HyBiHwYdzfEhAapkim81T6wFMG4hSfajK4sVePXvBzQnpztiOvjJ8iUfQ18kXETwJ2gREdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973468; c=relaxed/simple;
	bh=aHgwTJFT4K3I2siFVlfhslh2UNmwBahJvTxhCEU5Vhc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGhgbFw1e1MGfaoBuD+5ZHdQJqYUmgiFk7CwxzhToCDp5xb4A3eT7Zrr5cb+7tUDZubffo49gzrJGU4/PUT54GoO3j4se9hU/ksTiKSK5uo4O/iMB7AewEcUwA8cgBhluR2TbHmZOOmSuHzWhJhoIDXnvnWIvYx4Kmvo/mKgOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2o1yf3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2o1yf3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895251F000FF;
	Mon, 21 Sep 2026 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973466;
	bh=yrFrf31CzAGMwRVxOb97SRJtR701Pk6b6btKA5i372s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X2o1yf3UWx/O/Wfs2sgXcw7A9oUbDTMmCY1FsrvYF2M7TvotQyraSaFEayUrfssUN
	 fa00hrqjtmQ9DWugzLfLAcmkwQ8e/MN99UbjF3qxj8PDecQ6yqXULn/mHjn2NsGIyn
	 l/J/nZkxmcjXMi9F+XaL6n2nfCNj3s2pWO14wcxEDlAf6gpWv2rlwIA0ev4a/9JkIZ
	 B193k4tnt6LJs8J3QJuKVem3/k6zj9GHf70Fs5uBy5hnr4eG+TqllZKPWAlnfEp/QH
	 7zGAnuXlTyGjvyMCe8NARC0TXpGcytfLIrE4nXXPVMZNx27mePx3SuoAu1/35Ly+nc
	 o3b2cyN3jehSw==
Subject: Re: [Intel-wired-lan] [PATCH net] ice: roll back the port VLAN when
 ice_eswitch_br_set_pvid() fails
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 stable@vger.kernel.org
Date: Mon, 21 Sep 2026 06:51:05 +0000
Message-ID: <178997346505.2160803.11431169848249487697@kernel.org>
In-Reply-To: <20260920064754.1935818-1-xiaolinkui@126.com>
References: <20260920064754.1935818-1-xiaolinkui@126.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete rollback of the VLAN ops table: the commit message
  states the patch fixes the case where "in Double VLAN Mode, the inner…
- [High] ice_eswitch_br_set_pvid() mutates and dispatches through the
  per-VSI VLAN ops function-pointer table while holding only rtnl_lock,…
- [Medium] The newly added err_clear_port_vlan label in
  ice_eswitch_br_set_pvid()…
- [Medium] The new unwind assumes the VF VSI was not already in port-VLAN
  mode before ice_eswitch_br_set_pvid() ran, but…

--

ice: roll back the port VLAN when ice_eswitch_br_set_pvid() fails

This adds two unwind labels to ice_eswitch_br_set_pvid() so that a failing
set_port_vlan() or add_vlan() clears the port VLAN from the VSI context and
hands the VLAN ops back to ice_port_vlan_off(), instead of returning the
error with the VF VSI left in port VLAN mode.

A few questions about the new unwind path below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 1d8a6b95ccda..53ce98ba7007 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -679,16 +679,23 @@ ice_eswitch_br_set_pvid(struct ice_esw_br_port *port,
>  	vlan_ops = ice_get_compat_vsi_vlan_ops(port->vsi);
>  	err = vlan_ops->set_port_vlan(port->vsi, &port_vlan);
>  	if (err)
> -		return err;
> +		goto err_disable_port_vlan;
>  
>  	err = vlan_ops->add_vlan(port->vsi, &port_vlan);
>  	if (err)
> -		return err;
> +		goto err_clear_port_vlan;
>  
>  	ice_eswitch_br_port_vlans_flush(port);
>  	port->pvid = vlan->vid;
>  
>  	return 0;
> +
> +err_clear_port_vlan:
> +	vlan_ops->clear_port_vlan(port->vsi);

[Severity: Medium]
Is it intentional to drop the return value of clear_port_vlan() here?  The
op is declared fallible in struct ice_vsi_vlan_ops:

	int (*clear_port_vlan)(struct ice_vsi *vsi);

and both implementations can fail.  ice_vsi_clear_outer_port_vlan() and
ice_vsi_clear_inner_port_vlan() start with:

	ctxt = kzalloc_obj(*ctxt);
	if (!ctxt)
		return -ENOMEM;

	ice_restore_vlan_info(&vsi->info, &vsi->vlan_info);
	vsi->info.port_based_outer_vlan = 0;

and end with:

	err = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
	if (err)
		dev_err(...);

So on an ice_update_vsi() failure vsi->info has already been mutated while
hardware keeps the port VLAN and the RX_VLAN_PRUNE_ENA bit programmed by
the preceding set_port_vlan(), with no matching prune filter (add_vlan() is
the call that failed).

Since port->pvid stays 0 and the VLAN was never inserted into port->vlans,
can any later path retry that clear?  ice_eswitch_br_vlan_cleanup() only
reaches ice_eswitch_br_clear_pvid() when:

	if (port->pvid == vlan->vid)
		ice_eswitch_br_clear_pvid(port);

The ops table is then handed back unconditionally, which also restores the
real dis_rx_filtering().  ice_port_vlan_on() deliberately replaces it while
a port VLAN is active:

	/* all Rx traffic should be in the domain of the assigned port VLAN,
	 * so prevent disabling Rx VLAN filtering
	 */
	vlan_ops->dis_rx_filtering = noop_vlan;

Could the VF then use virtchnl to clear the prune bit while the hardware
port VLAN is still programmed?  Would it be better to only call
ice_vf_vsi_disable_port_vlan() when clear_port_vlan() succeeded, and log or
propagate the failure otherwise?

[Severity: High]
Can vlan_ops->clear_port_vlan be NULL by the time this new call runs?

vlan_ops points at the live table (&vsi->outer_vlan_ops or
&vsi->inner_vlan_ops), not a snapshot, and clear_port_vlan only exists
while the port VLAN flavour is installed by ice_port_vlan_on():

	vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
	vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;

ops_unsupported in ice_vsi_vlan_ops.c has no .clear_port_vlan initializer,
and ice_port_vlan_off() never assigns it either.

The bridge path holds only rtnl (ice_eswitch_br_event_blocking ->
ice_eswitch_br_port_obj_add -> ice_eswitch_br_port_vlan_add ->
ice_eswitch_br_vlan_create -> ice_eswitch_br_set_pvid) and
ice_eswitch_br.c never takes vf->cfg_lock, while set_port_vlan() and
add_vlan() sleep (kzalloc(GFP_KERNEL) plus an admin queue wait).

A VF-initiated reset runs concurrently under a disjoint lockset:

ice_vc_reset_vf()/ice_process_vflr_event()
  ice_reset_vf()                      /* vf->cfg_lock + pf->lag_mutex */
    ice_vf_reconfig_vsi()
      ice_vsi_cfg()
        ice_vsi_cfg_def()
          ice_vsi_init_vlan_ops()     /* reinstalls ops_unsupported */

If that lands inside the window, does the new err_clear_port_vlan label
dereference a NULL function pointer?  The same missing serialization also
lets a virtchnl handler fetch one flavour of the ops and execute it after
the unwind flipped the table back.

> +err_disable_port_vlan:
> +	ice_vf_vsi_disable_port_vlan(port->vsi);

[Severity: High]
The commit message says this hand-back addresses the case where "in Double
VLAN Mode, the inner add_vlan() and del_vlan() stop doing anything".  Does
ice_port_vlan_off() actually restore those two?

ice_port_vlan_on() sets them in DVM:

	vlan_ops = &vsi->inner_vlan_ops;

	if (ice_is_dvm_ena(&pf->hw)) {
		vlan_ops->add_vlan = noop_vlan_arg;
		vlan_ops->del_vlan = noop_vlan_arg;
		...

ice_port_vlan_off() re-points its local vlan_ops at the outer table before
it assigns del_vlan, and never touches the inner add_vlan at all:

	vlan_ops = &vsi->inner_vlan_ops;

	vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
	...
	if (ice_is_dvm_ena(&pf->hw)) {
		vlan_ops = &vsi->outer_vlan_ops;

		vlan_ops->del_vlan = ice_vsi_del_vlan;
		...

So after the unwind a DVM VF VSI keeps inner add_vlan/del_vlan ==
noop_vlan_arg, where ice_vsi_init_unsupported_vlan_ops() installs
op_unsupported_vlan_arg for a DVM VF VSI without a port VLAN.

Those pointers are live for the VF: ice_vc_process_vlan_msg() calls

	status = vsi->inner_vlan_ops.add_vlan(vsi, &vlan);

and the matching .del_vlan() for legacy VIRTCHNL_OP_ADD_VLAN/DEL_VLAN, with
DVM explicitly allowed there.  Is the VF's C-tag filter add/del then
reported as success while ice_fltr_add_vlan() is never issued and
vsi->num_vlan is not updated, until the VF VSI is rebuilt?

Should ice_port_vlan_off() also restore the inner add_vlan/del_vlan, which
would additionally cover the same residue on the existing
ice_eswitch_br_clear_pvid() path, or should the commit message be narrowed
to what ice_port_vlan_off() really restores?

[Severity: Medium]
What happens here when the VF VSI was already in port VLAN mode before
ice_eswitch_br_set_pvid() ran?

ice_vf_vsi_enable_port_vlan() is a plain ops-table overwrite with no
nesting or refcount:

	void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi)
	{
		if (WARN_ON_ONCE(!vsi->vf))
			return;

		ice_port_vlan_on(vsi);
	}

ice_set_vf_port_vlan() has no switchdev or bridge guard, it just records
the VLAN and resets the VF:

	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
	...
	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);

after which ice_vf_vsi_init_vlan_ops() calls ice_port_vlan_on() because
ice_vf_is_port_vlan_ena(vf) is true, and
ice_vf_rebuild_host_vlan_cfg() programs it:

	if (ice_vf_is_port_vlan_ena(vf)) {
		err = vlan_ops->set_port_vlan(vsi, &vf->port_vlan_info);

ice_eswitch_br_set_pvid() only inspects the bridge-tracked port->pvid,
which is still 0 in that configuration, so it proceeds.  On a failing
set_port_vlan() the new path calls ice_port_vlan_off() while the SR-IOV
port VLAN is still active in hardware and vf->port_vlan_info is still set,
which makes dis_rx_filtering the real ice_vsi_dis_rx_vlan_filtering()
again.  On a failing add_vlan() the clear additionally zeroes
vsi->info.port_based_{outer,inner}_vlan.

Does the unwind need to restore the actual prior state rather than assume
"port VLAN off" was the baseline?

> +
> +	return err;
>  }
>  
>  static struct ice_esw_br_vlan *

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920064754.1935818-1-xiaolinkui%40126.com
