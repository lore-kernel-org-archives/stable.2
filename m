Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA049E15F;
	Thu,  8 Oct 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464341; cv=none; b=oQtLrUP2Aq++0UMkxUVcwR+/QQ3G4ORudXH4z0XeFCJBSQ6c21iHCJzW63uwQxYZc+e/wZ0lQbyVb8Ibu1SnO2ZlPkmR88Ijz1vNoVlEgAAGbsSYbm+1Rr88NfcsVmYfN42XGKLlKfRxhLub2CewpzJ7aS5T0U6k0LpXj1KcLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464341; c=relaxed/simple;
	bh=WEGyYYtVqaSgmldqzmrhn0+VY7E/dikvQBeW6WSpwVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPolUInMFrmAVLxvperpf6m6Tu/O72NmLB/Ej1d2TeenlBXmqySMfcH3NJMvYe82W/XoLXQEJPtHJgZC0BtGR78hJLNc8sQqQfQ/XTK/p58MBuOkfMgrFLxrPKVOZHbjuz9op/CbiFbxhpNOGdft1/YwZOWabuJic/2UhxjACKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jO4yRh+f; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jO4yRh+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ah
	VlIdyB2pGt2fs06BKIwmR0kp8M62CgCW63wZLTG2A=; b=jO4yRh+fjuK5C8rkAz
	qpP0X7vUNu8tufZChwjsZz8adIQBSym68vNUi3sJvpgyDn15d6wzj8WKQyVhZax5
	m0uK9CbmzbuKdx5WVyIWnTt4mnHphW/mfLzawDMPGFgJIuoChLDKHCgiUh82M9oL
	oVr+Pjjsx867rPowaNpuD6vBk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v8NWk8dqh6CpBA--.7046S3;
	Thu, 08 Oct 2026 20:58:00 +0800 (CST)
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
Subject: [PATCH iwl-net v3 1/3] ice: attach and detach VF representors outside of vf->cfg_lock
Date: Thu,  8 Oct 2026 20:57:52 +0800
Message-Id: <20261008125754.3520773-2-xiaolinkui@126.com>
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
X-CM-TRANSID:PykvCgD3v8NWk8dqh6CpBA--.7046S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW8Cr43Aw1fGw4DAr4fKrg_yoW7ZFWDpa
	yvqFy5Krn5Xa1xW3y5uw48Zrn8uayrKFy5Gr1xGF4Fkan8Gr17Zry3Kay2qry8G397AFya
	yF4Durn5uFZ8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1JP_UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRiHXmrHk1hkdgAA3c

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_free_vfs() and ice_reset_all_vfs() call ice_eswitch_detach_vf()
and ice_eswitch_attach_vf() with vf->cfg_lock held. Both take the
devlink instance lock and then register or unregister the representor
netdev, which takes RTNL. That gives

	cfg_lock -> devlink instance lock -> RTNL

while three other paths take cfg_lock with RTNL already held:

  - __ice_set_vf_mac(), from ndo_set_vf_mac()
  - ice_set_vf_port_vlan(), from ndo_set_vf_vlan()
  - ice_repr_ethtool_reset(), via ice_reset_vf() with
    ICE_VF_RESET_LOCK

which is the opposite order, RTNL -> cfg_lock. An "ip link set ... vf
N mac" on one CPU against "echo 0 > sriov_numvfs" or a PF reset on
another can therefore deadlock.

Move the detach and the attach outside of cfg_lock. Representors are
created and removed under pf->vfs.table_lock only, which both callers
already hold, and ice_start_vfs() attaches without cfg_lock too.
Nothing that the detach reads is torn down by moving it: repr->src_vsi
still points at the VF VSI, which is only released later, under
cfg_lock.

Both callers raise ICE_VF_DIS in pf->state before entering the loop,
so a reset that starts after that leaves through ice_is_vf_disabled()
before it reaches ice_eswitch_update_repr(), and
ice_check_vf_ready_for_cfg() keeps the ndo handlers and the ethtool
reset away as well. ICE_VF_DIS does not cover a reset that is already
inside cfg_lock when the loop gets there, so take cfg_lock once before
the detach to wait that one out while its representor is still
attached. Without the wait it could xa_load() the representor that
ice_repr_destroy() is freeing, and that is free_netdev() + kfree(),
with no RCU grace period in between.

In ice_reset_all_vfs() the attach moves after mutex_unlock(), so the
"VSI rebuild failed" path still leaves the VF detached, exactly as it
did before.

Found by code inspection of the VF setup and teardown paths; the same
inversion has also been hit out of tree. It was not triggered here
and no stack trace was captured. Compile-tested only, not run on
hardware.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Fixes: c9663f79cd82 ("ice: adjust switchdev rebuild path")
Cc: stable@vger.kernel.org
Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- New patch. Move the ice_eswitch_detach_vf() and ice_eswitch_attach_vf() calls
  in ice_free_vfs() and ice_reset_all_vfs() out of vf->cfg_lock, which is where
  the inversion is: both take the devlink instance lock and then RTNL, while
  ndo_set_vf_mac(), ndo_set_vf_vlan() and the representor ethtool reset take
  vf->cfg_lock with RTNL already held.
  (Przemek Kitszel)
- Take cfg_lock once before the detach as well, so that a reset that is already
  inside the lock is waited out instead of being left with a window between the
  detach and the lock acquisition that follows it.
- Include how the issue was found, that it has not been triggered, and that the
  change is compile tested only, as netdev-bot asked for.
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 16 ++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..471c1e29a865 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -154,9 +154,21 @@ void ice_free_vfs(struct ice_pf *pf)
 	mutex_lock(&vfs->table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
+		/* Detach the representor before cfg_lock: it takes the
+		 * devlink instance lock and then RTNL, while
+		 * __ice_set_vf_mac(), ice_set_vf_port_vlan() and the
+		 * representor ethtool reset take cfg_lock under RTNL.
+		 * Take cfg_lock once ahead of it to wait out a reset that
+		 * is already inside the lock; ICE_VF_DIS, raised above,
+		 * keeps later ones out.
+		 */
 		mutex_lock(&vf->cfg_lock);
+		mutex_unlock(&vf->cfg_lock);
 
 		ice_eswitch_detach_vf(pf, vf);
+
+		mutex_lock(&vf->cfg_lock);
+
 		ice_dis_vf_qs(vf);
 		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index a54cb2b8d3c7..b91eec0adf51 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -789,9 +789,21 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 
 	/* free VF resources to begin resetting the VSI state */
 	ice_for_each_vf(pf, bkt, vf) {
+		/* Detach the representor before cfg_lock and attach it after
+		 * releasing it again: both take the devlink instance lock and
+		 * then RTNL, while __ice_set_vf_mac(), ice_set_vf_port_vlan()
+		 * and the representor ethtool reset take cfg_lock under RTNL.
+		 * Take cfg_lock once ahead of the detach to wait out a reset
+		 * that is already inside the lock; ICE_VF_DIS, raised above,
+		 * keeps later ones out.
+		 */
 		mutex_lock(&vf->cfg_lock);
+		mutex_unlock(&vf->cfg_lock);
 
 		ice_eswitch_detach_vf(pf, vf);
+
+		mutex_lock(&vf->cfg_lock);
+
 		vf->driver_caps = 0;
 		ice_vc_set_default_allowlist(vf);
 
@@ -812,10 +824,10 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		}
 		ice_vf_post_vsi_rebuild(vf);
 
+		mutex_unlock(&vf->cfg_lock);
+
 		if (ice_is_eswitch_mode_switchdev(pf))
 			ice_eswitch_attach_vf(pf, vf);
-
-		mutex_unlock(&vf->cfg_lock);
 	}
 
 	ice_flush(hw);
-- 
2.25.1

