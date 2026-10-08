Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41849B5CF;
	Thu,  8 Oct 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464343; cv=none; b=UmK5rM/sgAwcCVDF5M3UkgWI4w53UODRLjSCA7zXc3jWok6rGsdiWyHB+EHXVUNsajdDehkuh8rUHkqciMHM1e9IUOkF3KT5o7nNiPUQQEEM1F+jwlIKaZ1U5GXo8v9TZlE/EwexNPJJtmrBSdptUXzIJkq6cWOD2rdDtlfU6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464343; c=relaxed/simple;
	bh=rCigx8a4A/FzB28rUqArVg+9PREV2MC53TKeMRh89i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBLUHw7aDhpTRE9VFV32pmzz5uqncQRq5iMGI5CIurrEXbW2m0DJafmKofFFeophpN3SFl8Nt3soluIF9GwpsRQt6q/eyHfNhtRebTRl9ei/FUdo1/wOnndXGsObWh/TLS0JraxzIyqgXyh6LPxnULvOh+fBNkIv5ZA8nbFiVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Br3kibwO; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Br3kibwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TG
	ZAMLTLMJ/U9F3xyOxtk6/R8MPsbxMjndAIpvxkZWw=; b=Br3kibwOVh9aVODxn3
	aAB0sRSF0FR3IM53DYdBHaogS34SFGvaYUxGWh66hHdYTFGxTK4VUGZXIsPNnaO5
	hpOxGvbMBTmWE0ap+nAdWddHiB7y1Yr2jX2ME1a7ijUPi+uIItOpIfWPUcbxJGJG
	gahZvJx3I5hCLqyvSQsBO/w7M=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S4;
	Thu, 08 Oct 2026 20:58:02 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v3 2/3] ice: detach the VF representor when ice_start_vfs() fails
Date: Thu,  8 Oct 2026 20:57:53 +0800
Message-Id: <20261008125754.3520773-3-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008125754.3520773-1-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3v8NWk8dqh6CpBA--.7046S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtry3JF1DtFyrJrW3Gr4rKrg_yoW7Ww4UpF
	Wvqw1rKr1DXF1agw43uw48u34Uua4rKFW5Gr1xGr4rCan8Cr95Xr48K3429Fy8C3s7AFya
	vr4q9rn5u34DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9IDcUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRqHXmrHk1pkhQAA3v

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_start_vfs() attaches every VF it brings up to the eswitch with
ice_eswitch_attach_vf(), but the teardown path only undoes the queue
mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
VFs that were attached before the failure, and the caller,
ice_ena_vfs(), goes straight to ice_free_vf_entries(), which drops the
last reference on every VF.

The port representors created for those VFs therefore outlive the
failed VF creation:

  - the representor netdev stays registered and its devlink port stays
    allocated, so both leak;

  - repr->vf keeps pointing at the struct ice_vf that ice_put_vf() has
    just freed through ice_sriov_free_vf(), and repr->src_vsi keeps
    pointing at the VF VSI that ice_vf_vsi_release() tore down, so any
    later use of a leftover netdev, for example
    ice_eswitch_stop_all_tx_queues() walking pf->eswitch.reprs during a
    PF reset, dereferences freed memory;

  - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
    ice_virtchnl_set_repr_ops(), are never handed back to
    ice_virtchnl_set_dflt_ops();

  - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach()
    never calls ice_eswitch_disable_switchdev().
    pf->eswitch.is_running stays true with the bridge offloads and the
    devlink rate topology still up, and ice_eswitch_release_env() is
    skipped, leaving the uplink VSI in the switchdev configuration that
    ice_eswitch_setup_env() gave it: local loopback enabled, Rx
    filtering disabled and the default VSI steering removed.

Detach the representor in the teardown loop the way ice_free_vfs()
does, ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
Every VF the teardown loop walks completed ice_eswitch_attach_vf()
successfully, and ice_eswitch_detach_vf() already returns early for a
VF without a representor, so no extra condition is needed.

The detach runs outside of vf->cfg_lock, the way the previous patch
leaves it in ice_free_vfs() and ice_reset_all_vfs(): taking the
devlink instance lock and then RTNL under cfg_lock is the wrong way
round against the ndo_set_vf_mac(), ndo_set_vf_vlan() and representor
ethtool reset paths. The rest of the loop body still runs under
cfg_lock, as in ice_free_vfs().

The VF is marked disabled first, because nothing else keeps a reset
away here. ICE_VF_DIS in pf->state is only set once ice_ena_vfs()
succeeds, and ice_sriov_configure() runs under the PCI device lock
rather than RTNL, so ICE_VF_STATE_DIS is what makes
ice_check_vf_ready_for_cfg() reject __ice_set_vf_mac() and
ice_set_vf_port_vlan(). Setting it under cfg_lock also waits out an
ice_reset_vf() that is already running, which would otherwise reach
ice_eswitch_update_repr() on a destroyed representor.
ice_vc_process_vf_msg() tests the same bit before it reads
vf->virtchnl_ops, which ice_repr_rem_vf() restores.

Found by code inspection of the VF setup and teardown error paths. It
was not triggered and no stack trace or error message was observed.
Compile-tested only, not run on hardware.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Detach the representor outside vf->cfg_lock instead of under it, as Przemek
  suggested, and mark the VF disabled under cfg_lock before the detach so that
  an ice_reset_vf() that is already past its own readiness check cannot reach
  ice_eswitch_update_repr() while the representor goes away.
  (Przemek Kitszel, Sashiko AI review)
- Include how the issue was found, that it has not been triggered, and that the
  change is compile tested only, as netdev-bot asked for.
- Not carrying over the Reviewed-by tags from Tomasz Lichwala and
  Aleksandr Loktionov, as the code changed after their reviews.
 drivers/net/ethernet/intel/ice/ice_sriov.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 471c1e29a865..470aec8849b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -520,8 +520,27 @@ static int ice_start_vfs(struct ice_pf *pf)
 		if (it_cnt == 0)
 			break;
 
+		/* Mark the VF disabled before its representor and its VSI go
+		 * away, the way ice_free_vfs() does, and take cfg_lock
+		 * around it to wait out an ice_reset_vf() already in
+		 * progress. pf->state has no ICE_VF_DIS on this path and the
+		 * loop leaves ICE_VF_STATE_INIT set, so without the bit a
+		 * concurrent ice_reset_vf() would pass ice_is_vf_disabled()
+		 * and reach ice_eswitch_update_repr() on a destroyed
+		 * representor, or trip WARN_ON(!vsi) in ice_dis_vf_mappings().
+		 */
+		mutex_lock(&vf->cfg_lock);
+		set_bit(ICE_VF_STATE_DIS, vf->vf_states);
+		mutex_unlock(&vf->cfg_lock);
+
+		/* detach outside of cfg_lock, see ice_free_vfs() */
+		ice_eswitch_detach_vf(pf, vf);
+
+		mutex_lock(&vf->cfg_lock);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
+		mutex_unlock(&vf->cfg_lock);
+
 		it_cnt--;
 	}
 
-- 
2.25.1

