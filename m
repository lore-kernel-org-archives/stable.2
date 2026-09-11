Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598C3B7B6B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146989; cv=none; b=W51AGeVieq6q6d0w0X1xpdrO0FPfyG2i2l0tHyf1gE4RT0McA49p4bRYBDxblvhHlbO6J8o/cEpcx9wCwZoA5RC0StVFkGKje/zKiSDdRTHzOy0rrhxTTNsPp7k9asBztCxSiW0jp+G01S4hXP/rW2TXl3igHfI1GNd8QMAXwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146989; c=relaxed/simple;
	bh=kTrA/05chCzv5kuna2Fcg2y6AbPviqZiM5hNskhDIMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtGWwlqppj5dN8+OIu9DpjdiMlmNMTyw50f7BXuJfl7zItHRPbCjzsGrMqUBrfCnafX3ez72SCyleo8BMEngsalGp53pP9dtB37KT0z5ReKV6O0g00paFBlo35TlGJ5SXZdLWUlX3Paa0z/8Efo0rPmngW2YcfhQNsavRypZDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdsYBGTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdsYBGTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C241F00898;
	Fri, 11 Sep 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146984;
	bh=Q1ZxtZHSVdyCJXGC1T/PF/oNUX6NLc3IUrA1GogpcYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdsYBGTm2ZVfTZeBsJCC20nq/viNdc7qw1mT6hF2xGGijt5TUHUmQGeNk8TuPGzh0
	 XdXSqg4Snn7GqaHF0Myy6THqHmD9odi7geYUhEhjY233XKpquapnKdsCRaPujL678b
	 dgx83l1/vgkSQ/Y5njzgPVjAa/NqpRG6TCbCav/c7DYCPD7M4tG1cCdsQ9SnVETfCl
	 iJmHE3RY8Ofcu292OeDO/f+fVHd/vSK/3hY69BONQceWMRq6IZK3bLE/sodITN8v8p
	 oDhb1JeLtk/VpTCw/XWYk4gwoQkdQjsjrfqhGK9IUrjuKSX4Dg9/lnTmoPa2XRc7iu
	 7o6nShjZP1x2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: qla2xxx: Skip vport under deletion in report ID acquisition
Date: Fri, 11 Sep 2026 13:16:22 -0400
Message-ID: <20260911171622.1219946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090950-aloft-buckle-b421@gregkh>
References: <2026090950-aloft-buckle-b421@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 23582731afa35031c94fadb71a4f3b4afd094649 ]

qla24xx_report_id_acquisition() format-1 handling walks ha->vp_list under
vport_slock, takes a vref_count on the matching vport and calls
qla_update_host_map() to register its port id.

A vport teardown via qla24xx_vport_delete() sets VPORT_DELETE, then
qla24xx_disable_vp() removes the vport from the host_map btree and zeroes
vha->d_id (RESET_AL_PA). The vport is only unlinked from vp_list later,
in qla24xx_deallocate_vp_id(), which clears vp_map[idx] (RESET_VP_IDX)
but does not touch host_map. In the window in between, report ID
acquisition can still find the vport on vp_list and call
qla_update_host_map(); with d_id already zeroed it takes the
btree_insert32() path and re-inserts the dying vport into host_map.
Nothing cleans that entry afterwards, so once scsi_host_put() frees the
vha a later host_map lookup dereferences freed memory.

Skip a vport that has VPORT_DELETE set before taking the reference, so it
is neither re-registered nor scheduled for DPC re-registration. This
mirrors the existing guard in qla2x00_alert_all_vps().

Fixes: 41dc529a4602 ("qla2xxx: Improve RSCN handling in driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-22-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ Adjusted context to use rptid_entry->vp_idx instead of the missing local vp_idx variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 41435e98092a8..3e5506b36f39f 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4145,6 +4145,8 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 			spin_lock_irqsave(&ha->vport_slock, flags);
 			list_for_each_entry(vp, &ha->vp_list, list) {
 				if (rptid_entry->vp_idx == vp->vp_idx) {
+					if (test_bit(VPORT_DELETE, &vp->dpc_flags))
+						break;
 					found = 1;
 					break;
 				}
-- 
2.53.0

