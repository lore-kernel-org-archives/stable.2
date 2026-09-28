Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5F35201A;
	Mon, 28 Sep 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578456; cv=none; b=SgxJneJ3iLh9tCttHNtFtwAWs16TrQZxLIjdkIvBMtU6tKxxXFx8oet6sdOcCaX42p4+aW0V6TopawPF32pBhWaG2clA0B3pWcc7Ys/1J+AnRxjGSWHLOXO9+I0JRfskxa4XSFGv9MV5ZsfSIgiB4qDfR/a6w1dTVV/KinxPuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578456; c=relaxed/simple;
	bh=cRExvY2q6wNGMLVPNVeTX9GRZLTpul82LoyBRLUpfsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzSzwxKmBUdD1PmwxU83ICxpFlld/4qY9J4HGOYag9WaoeFXvpHJ9r9xd34ctcwmhcHtVYjRdf1D+sYN2S22nZnkqZaB3367WcTYk08GVr13wP/J8FnjfhpwHBynOi4FmOnBLLdKggtcLT42cnVDA6InJnupRB6bog0oB/3rKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=eujclBaq; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="eujclBaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ku
	A+RcV6eslsXCX6SwCHb49hYoGv+BR5GuVAEXcnzck=; b=eujclBaqLDFH1WUKVI
	hhv7WRE9uH+OWmw/99oAMSS21v65hJZys6JPQ/IJ2ypXIa/nsQj3FwwhxUh4afzg
	TBhT6B1Tbh+EsXY2ngAE3lTG35RH/I9peGp09qXr07A7kdrDN0u4OLtmUSJvIxM/
	0Hw/FCrSVjIYW7G67yHt0Xg2Q=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD31_vUDrpqqwJlAg--.52624S2;
	Mon, 28 Sep 2026 14:53:08 +0800 (CST)
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
Subject: [PATCH iwl-net v2 1/2] ice: detach the VF representor when ice_start_vfs() fails
Date: Mon, 28 Sep 2026 14:53:05 +0800
Message-Id: <20260928065306.1514795-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD31_vUDrpqqwJlAg--.52624S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy7Jw4kAF4DZF45GF17ZFb_yoWrAr15pr
	WkXa4rGr4kJF1agw4Uua18u34F9a4rCFWagr1jkw1fCF45Gr9Ykr4UKry2vF18C39rC3Wa
	vr4q9rn5u34DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiiDUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBQC2Gq6DtSq6QAA3v

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_start_vfs() attaches every VF it brings up to the eswitch with
ice_eswitch_attach_vf(), but the teardown path only undoes the queue
mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
VFs that were attached before the failure, and the caller, ice_ena_vfs(),
goes straight to ice_free_vf_entries(), which drops its reference to
every VF.

The port representors created for those VFs therefore outlive the
failed VF creation:

  - the representor netdev stays registered and its devlink port stays
    registered too. That port is embedded in struct ice_vf, so it ends
    up pointing into the memory that ice_sriov_free_vf() releases;

  - repr->vf keeps pointing at the freed struct ice_vf, and repr->src_vsi
    at the VF VSI that ice_vf_vsi_release() tore down. The leftover
    netdev is still visible to the user, so even a plain
    "ip -s link show" of it reaches ice_repr_get_stats64(), which calls
    repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
    reads repr->src_vsi through ice_update_eth_stats();

  - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
    ice_virtchnl_set_repr_ops(), are never handed back to
    ice_virtchnl_set_dflt_ops();

  - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach() never
    calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running stays
    true, with the bridge offloads and the devlink rate topology still
    up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
    left in the switchdev configuration that ice_eswitch_setup_env()
    gave it.

Detach the representor in the teardown loop the way ice_free_vfs() does,
ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
Every VF the teardown loop walks completed ice_eswitch_attach_vf()
successfully, and ice_eswitch_detach_vf() already returns early for a VF
without a representor, so no extra condition is needed.

Hold vf->cfg_lock across the teardown of each VF as well, like
ice_free_vfs() does. The VFs unwound here are the ones that already
reached set_bit(ICE_VF_STATE_INIT), which is exactly what
ice_check_vf_ready_for_cfg() checks, so a host administrator can still
run "ip link set dev <pf> vf N ..." and a VF can still send a mailbox
message while the loop walks them. Both paths take cfg_lock and then run
ice_reset_vf(), which gets to ice_eswitch_update_repr() and writes
through the representor that is being freed, or reach
ice_vc_process_vf_msg() reading vf->virtchnl_ops while
ice_virtchnl_set_dflt_ops() hands them back.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v1:
- Link: https://lore.kernel.org/netdev/20260921031616.3390259-1-xiaolinkui@126.com/

Changes in v2:
- Hold vf->cfg_lock across the teardown of each VF, the way ice_free_vfs()
  does, so that a concurrent VF reconfiguration cannot walk through the
  representor and the virtchnl ops that are being torn down.
  (Sashiko AI review)
- Patch 2/2 is new and returns the VF MSI-X window that the same failure path
  reserves. That is a separate, pre-existing bug, so it is not folded in here.
  (Sashiko AI review)
- Not carrying over the Reviewed-by from Aleksandr Loktionov, as the code
  changed after his review.

 drivers/net/ethernet/intel/ice/ice_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..95abc6704820 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -508,8 +508,13 @@ static int ice_start_vfs(struct ice_pf *pf)
 		if (it_cnt == 0)
 			break;
 
+		mutex_lock(&vf->cfg_lock);
+
+		ice_eswitch_detach_vf(pf, vf);
 		ice_dis_vf_mappings(vf);
 		ice_vf_vsi_release(vf);
+		mutex_unlock(&vf->cfg_lock);
+
 		it_cnt--;
 	}
 
-- 
2.25.1

