Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CC369224;
	Mon, 28 Sep 2026 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578497; cv=none; b=bKTYzienIj/55dKfw9GKpYy53l8mdanMMuSODjqUIm/Yrp+HS+D1+vXtRD/k58UGjgxt2otujAOpLsQ7rw2oPj/KIC2sV47l8qkNEo5NcleXoXBJW2bs4KD1iukFABlOJ2C3yIEohHBhIHT9NayIH4bLa0vzvnhPwcoQFDKnh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578497; c=relaxed/simple;
	bh=v0Qx0SVkWY4El4gyQblcQ7YByqNzQoPYAWg0Vjn8pto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StP4zlgf8ayYWz8OPMgxVHU+aeDnDDM+CKo6ZKtszrNr1AZUtaZUH7IsmqB+0GUK6LbOeqMbkbUwNgQoLXR5GzzRZHyUykx1INqI1yqkDWh6/4RCqOXw0XCYPT7w/JisNGJsPVfqlLlGJ4Lmkth4lD6NTwjQhXv4PYDJ9pqIZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iMvs9S9u; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iMvs9S9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tj
	uFWS1aagbpSLzq2GUkwsYPzV+6jqR8uoRndtikMxo=; b=iMvs9S9ue/eMQaf7fZ
	CAGc/m7/nd+JcrnaKa8IJtVOB4KH6Tc0RLysMI0wUBEUEnFhba+1Mn97OvXR2c9B
	xjljVh3/KEJvSRbgYFcnbenpwmO+Ts2eFq91jp73cOAqKduKFyzLtDHMQbMh12vg
	mywnGQPRwdYrDocudV9czPUgk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD31_vUDrpqqwJlAg--.52624S3;
	Mon, 28 Sep 2026 14:53:11 +0800 (CST)
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
Subject: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when ice_start_vfs() fails
Date: Mon, 28 Sep 2026 14:53:06 +0800
Message-Id: <20260928065306.1514795-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD31_vUDrpqqwJlAg--.52624S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw48ZFyxZw15WFWDtw4UXFb_yoWrGryxpr
	Wqqr15Kr4kJF48WrZ7Ww1UZFn5uaySqFW8ury0g3Zakrs8Ar1UtF1Utr12y3W8C397Ca1a
	vw4q9w1rZr1DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uy5lnUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBcC2Gq6DteZhAAA3N

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_init_vf_vsi_res() reserves the VF MSI-X window with
ice_virt_get_irqs(), which does bitmap_set() on the PF-wide
pf->virt_irq_tracker.bm, but nothing hands that window back when VF
creation fails. ice_virt_free_irqs() is not called anywhere on this
failure path: not from the release_vsi label of ice_init_vf_vsi_res(),
not from the ice_eswitch_attach_vf() failure branch, and not from the
teardown loop of ice_start_vfs(), which only undoes the queue mappings
and the VF VSI. The caller does not help either, because
err_unroll_vf_entries -> ice_free_vf_entries() -> ice_put_vf() ->
ice_sriov_free_vf() only does mutex_destroy() and kfree_rcu().

The tracker is allocated once per PF in ice_init_virt_irq_tracker() and
freed only in ice_deinit_virt_irq_tracker(), and ice_set_per_vf_res()
sizes the VFs from pf->virt_irq_tracker.num_entries rather than from the
number of free bits. So each failed "echo N > sriov_numvfs" leaks the
window reserved for every VF that got as far as ice_init_vf_vsi_res(),
and once the tracker is exhausted ice_virt_get_irqs() keeps returning
-ENOENT, which means SR-IOV cannot be enabled again without reloading
the driver. The hardware and the software bookkeeping also end up
disagreeing, because ice_dis_vf_mappings() clears
VPINT_ALLOC/VPINT_ALLOC_PCI and re-points GLINT_VECT2FUNC of exactly
those vectors back at the PF.

Return the window on the failure paths, in the order ice_free_vfs()
uses: ice_virt_free_irqs() after ice_eswitch_detach_vf() in the teardown
loop, and right after the VF VSI is released in the two branches that
fail before the loop can reach that VF.

The missing release is older than this change: the teardown loop has
never returned the window. It turns into an accumulating leak because
the tracker is now PF-wide and outlives a single SR-IOV enable.

Fixes: a203163274a4 ("ice: simplify VF MSI-X managing")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v2:
- New patch. Returns the VF MSI-X window that ice_init_vf_vsi_res() reserves
  when ice_start_vfs() fails. The missing release is older than the
  representor bug that patch 1/2 fixes, so it stays a separate patch.
  (Sashiko AI review)

 drivers/net/ethernet/intel/ice/ice_sriov.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 95abc6704820..df84dbe12cba 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -446,8 +446,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 		return -ENOMEM;
 
 	vsi = ice_vf_vsi_setup(vf);
-	if (!vsi)
-		return -ENOMEM;
+	if (!vsi) {
+		err = -ENOMEM;
+		goto free_irqs;
+	}
 
 	err = ice_vf_init_host_cfg(vf, vsi);
 	if (err)
@@ -457,6 +459,9 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 
 release_vsi:
 	ice_vf_vsi_release(vf);
+free_irqs:
+	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
+
 	return err;
 }
 
@@ -490,6 +495,8 @@ static int ice_start_vfs(struct ice_pf *pf)
 				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
 					vf->vf_id, retval);
 				ice_vf_vsi_release(vf);
+				ice_virt_free_irqs(pf, vf->first_vector_idx,
+						   vf->num_msix);
 				goto teardown;
 			}
 		}
@@ -511,6 +518,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 		mutex_lock(&vf->cfg_lock);
 
 		ice_eswitch_detach_vf(pf, vf);
+		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
 		mutex_unlock(&vf->cfg_lock);
-- 
2.25.1

