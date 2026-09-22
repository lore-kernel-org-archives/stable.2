Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227F4570D0;
	Tue, 22 Sep 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090284; cv=none; b=TQNw0ziZoFoIHlFxxqKRlY12cIfnvcERezQVneXvwBdgHxxF0Gz41+Dax/H7maJ7/o0Hf51FUTnTLxnJEhukLn+p+rf88nZHwr9pV/rLjgvoXHkUXmM7CI8MHuAU6ssrc2LGfoFDv0TQlX0eVEEC6fvLicWXL6/GCKJASlVk6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090284; c=relaxed/simple;
	bh=15HkibEpQmCW+19fUFq8VXDh4YsgQ14loxKhOxO0lII=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQeTUZwa8G0leMCP+z8UR9cZx/qlvYLMlGXi+yUnCSkyAk1mNUkxHV93NYvy6IQ8U+THl5cyhwkJJpSVqLOkZiUc++UupHUN6wKa+BAKFOzDc6H49y03Ky/BqMBecr5bfHBVPv6HguYBE+PkR5J8msz98mjNM7PZzmh6pdAuop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6CXXqI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6CXXqI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98AD1F000FF;
	Tue, 22 Sep 2026 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090282;
	bh=SCUskFf4P9uSaGgRY2DVcZeibiyVC9XecefXdSM92Hg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k6CXXqI5y/J0EJrREtniefQG6Xg6CdtuQprCHaleooshSYJWEUL04kAFvwXdyB2PU
	 lbNAnhPKZ4SpEThqh06cABShaNf5S1kfH7G4mCtN0xULjmZ++sW5ZxoxzEmcrwvBSm
	 QxKFai5SDu+iH96dCDJPNue7ShuxbQ+MBQ6u3g7uF6XvwwfJAyKPBB3mbuGKhTkvl/
	 dK56IVjCbEWDgKzcYqj/TEpotv8SG/KNy/qS/tY/jZU2DLgO0Ov7tN93TjXaTRYT7O
	 ccfyQVWRje1ZYZ0PZfUES2qJixyraN+hLoC/ej+Ke7RNHQK/dsLf8WfIiGuuBIkU4O
	 eTlYRZexoknJw==
Subject:
 Re: [PATCH net] ice: detach the VF representor when ice_start_vfs() fails
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 stable@vger.kernel.org
Date: Tue, 22 Sep 2026 15:18:01 +0000
Message-ID: <179009028142.2160803.9147341738754348504@kernel.org>
In-Reply-To: <20260921031616.3390259-1-xiaolinkui@126.com>
References: <20260921031616.3390259-1-xiaolinkui@126.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The newly added ice_eswitch_detach_vf(pf, vf) in the
  ice_start_vfs() teardown loop…

Pre-existing issues:
- [High] AB-BA lock ordering inversion between pf->vfs.table_lock and the
  devlink instance lock.
- [Medium] ice_start_vfs() teardown loop
  (drivers/net/ethernet/intel/ice/ice_sriov.c:507-515) still never…

--

ice: detach the VF representor when ice_start_vfs() fails

The patch adds a call to ice_eswitch_detach_vf() in the ice_start_vfs()
teardown loop so that port representors created by ice_eswitch_attach_vf()
are destroyed when VF startup fails. It is placed ahead of
ice_vf_vsi_release() so that repr->src_vsi is still valid. A few questions
about the new call site below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..1b563aba3bbd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,6 +508,7 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt == 0)
>  			break;
>  
> +		ice_eswitch_detach_vf(pf, vf);

[Severity: High]
Should this call be made with vf->cfg_lock held?

ice_start_vfs() only holds pf->vfs.table_lock (see the
lockdep_assert_held(&pf->vfs.table_lock) at the top of the function). Both
existing callers of ice_eswitch_detach_vf() hold vf->cfg_lock across it:

drivers/net/ethernet/intel/ice/ice_sriov.c:ice_free_vfs() {
	ice_for_each_vf(pf, bkt, vf) {
		mutex_lock(&vf->cfg_lock);

		ice_eswitch_detach_vf(pf, vf);
	...
}

and ice_reset_all_vfs() in ice_vf_lib.c does the same.

cfg_lock rather than table_lock is what serializes VF reconfiguration:
ice_vc_process_vf_msg() in virt/virtchnl.c takes only
mutex_lock(&vf->cfg_lock) before dispatching through vf->virtchnl_ops, and
the ndo handlers ice_set_vf_mac(), ice_set_vf_trust() and
ice_set_vf_port_vlan() take cfg_lock and then call ice_reset_vf(), which
reaches ice_eswitch_update_repr().

Since pci_enable_sriov() has already run by the time ice_start_vfs() is
called, and ice_sriov_configure() does not take rtnl, can the following
interleave?

CPU0 (sysfs sriov_numvfs, teardown loop, no cfg_lock)
ice_eswitch_detach_vf()
  ice_eswitch_detach()
    xa_erase(&pf->eswitch.reprs, repr->id);
    ice_repr_destroy(repr);   /* free_netdev()/kfree() */

CPU1 (ip link set dev ... vf N trust on, cfg_lock only)
ice_reset_vf()
  ice_eswitch_update_repr() {
	repr = xa_load(&pf->eswitch.reprs, *repr_id);
	if (!repr)
		return;

	repr->src_vsi = vsi;
	repr->dst->u.port_info.port_id = vsi->vsi_num;

	if (repr->br_port)
		repr->br_port->vsi = vsi;
  }

Does this write through a freed struct ice_repr? The VFs this loop walks
still have ICE_VF_STATE_INIT set and ICE_VF_STATE_DIS clear, so
ice_check_vf_ready_for_cfg() succeeds on the concurrent path; unlike
ice_free_vfs(), the new loop never sets ICE_VF_STATE_DIS.

The same unlocked window also has ice_repr_rem_vf() calling
ice_virtchnl_set_dflt_ops(repr->vf) while ice_vc_process_vf_msg() reads
vf->virtchnl_ops under cfg_lock.

[Severity: High]
This isn't a bug introduced by this patch, but it adds one more instance of
it: ice_eswitch_detach_vf() takes the devlink instance lock internally,

drivers/net/ethernet/intel/ice/ice_eswitch.c:ice_eswitch_detach_vf() {
	...
	devl_lock(devlink);
	ice_eswitch_detach(pf, repr);
	devl_unlock(devlink);
}

so this call establishes table_lock -> devl_lock, the same order that
ice_eswitch_attach_vf() in this function and ice_eswitch_detach_vf() in
ice_free_vfs() already use.

The reverse order exists in ice_tear_down_devlink_rate_tree():

drivers/net/ethernet/intel/ice/devlink/devlink.c {
	devl_lock(devlink);
	mutex_lock(&pf->vfs.table_lock);
	ice_for_each_vf(pf, bkt, vf) {
	...
}

which is reached from ice_setup_tc_mqprio_qdisc() in ice_main.c and from
ice_pf_dcb_cfg() in ice_dcb_lib.c, neither of which holds devl_lock
already and neither of which is excluded while switchdev/SR-IOV is active.

Can this deadlock?

CPU0: write to sriov_numvfs -> ice_ena_vfs() -> ice_start_vfs() rollback
      holds pf->vfs.table_lock, blocks on devl_lock

CPU1: tc qdisc ... mqprio hw 1 mode channel, or a DCB reconfiguration
      holds devl_lock, blocks on pf->vfs.table_lock

ice_sriov_configure() runs under the PCI sysfs device_lock and takes no
rtnl, while the TC/DCB paths run under rtnl, so the two sides do not seem
to be mutually exclusive. Would it make sense to converge on one hierarchy
here, for example acquiring devl_lock outside table_lock in ice_ena_vfs()
and using lock-held attach/detach helpers?

>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
>  		it_cnt--;

[Severity: Medium]
This is a pre-existing issue, but since the loop is being made symmetric
with ice_free_vfs(), does this loop also need to return the VF MSI-X
window?

ice_init_vf_vsi_res() reserves it:

	vf->first_vector_idx = ice_virt_get_irqs(pf, vf->num_msix);
	if (vf->first_vector_idx < 0)
		return -ENOMEM;

ice_virt_get_irqs() does bitmap_set() on the PF-wide
pf->virt_irq_tracker.bm, and the only release helper,
ice_virt_free_irqs(), is not called anywhere on this failure path: not in
this teardown loop, not at the release_vsi label of
ice_init_vf_vsi_res(), not in the ice_eswitch_attach_vf() failure branch,
and not in the caller, where err_unroll_vf_entries -> ice_free_vf_entries()
-> ice_put_vf() -> ice_sriov_free_vf() only does mutex_destroy() and
kfree_rcu().

ice_free_vfs() pairs the two calls the new loop now half-mirrors:

		ice_eswitch_detach_vf(pf, vf);
		ice_dis_vf_qs(vf);
		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);

The tracker bitmap is allocated once per PF in
ice_init_virt_irq_tracker() and freed only in
ice_deinit_virt_irq_tracker(), and ice_set_per_vf_res() sizes VFs from
pf->virt_irq_tracker.num_entries rather than from the number of free bits.
Does each failed "echo N > sriov_numvfs" therefore leak
num_vfs * num_msix_per_vf entries of the VF MSI-X range until
ice_virt_get_irqs() starts returning an error and SR-IOV can no longer be
enabled without a driver reload?

Note also that ice_dis_vf_mappings() clears VPINT_ALLOC/VPINT_ALLOC_PCI and
re-points GLINT_VECT2FUNC of exactly those vectors back at the PF, so the
hardware mapping and the software bookkeeping end up disagreeing.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921031616.3390259-1-xiaolinkui%40126.com
