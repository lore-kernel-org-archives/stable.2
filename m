Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F043976A4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140522; cv=none; b=HKQuvM6JSK840Q/OXKxnLO+v2OlpsYHNypgkZ3cJtcLMspRPCSEE3rxHF+P3L0cOb6ulORLqh3Li9ujw5Vzna8Ub8D7xjbc8jz1Qs70eGt+zkE5qcuKKU3TSAZ2CuqjFQx6cgEkoodPPNyCyUs4YixJFJvqOtsBxT1yHTSBmdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140522; c=relaxed/simple;
	bh=ef1rOxRFhxgWr35uz3Zzh7dk01I7S5XF0WAoH2ITNd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDmAgBZF+jdZn+nTlh47qgkYiMWwI24KGxocKLT4z7+kI++vOHsI56QqyyDc5nBCU5jgI9y5JQ83hRQ4jS4rQ2cj1UxYDoPS2lUQ9S5+MZ4snSSB/0l8N3wZEXMYxuhif4ZqMPGVlJZNks3ERHcELPJAufEEh9OCsCB3/JgeppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDGLNJSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDGLNJSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC2C1F000FF;
	Fri, 11 Sep 2026 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140520;
	bh=Vj7kCtsdU9lY78ukdpy88OLlOnb7XnDok5N21tm9xa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDGLNJSBsbl6dfm6XArPsxVsLBbCQXDf5mFbAbJQy6KVdpanOQeEFeXCJWFZHxRgh
	 DKbwxgn3x2BpoWbsZRvL/OSzBO3g0u4dWBq7DzpOVTMBYGoOUrHJafHQVxXAdtUh2P
	 Hqbjzd+ozd+EqEYwqS6P9qQVWTbFSsMsZtZ9YKtG+hRO2KiBB+kaqy4Xh+9jmQIdgT
	 t1f8MtGbZFrQG9jU2pYMDnHVwQjfK0diOuxvOGGzpUWGPa/fA0Bzru/G7US3hYg9WG
	 sKn+0ecN1d/8nU2h5Omw9FPL5WyIST2tHOgbgCmPWLWWuI9HHcs92BZXzE2WirX3t1
	 xEzdQ0OglqkJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: qla2xxx: Skip vport under deletion in report ID acquisition
Date: Fri, 11 Sep 2026 11:28:38 -0400
Message-ID: <20260911152838.1078361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090950-mower-implement-8f2f@gregkh>
References: <2026090950-mower-implement-8f2f@gregkh>
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
index 3b78c04feabdf..5376f04797c1f 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4147,6 +4147,8 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 			spin_lock_irqsave(&ha->vport_slock, flags);
 			list_for_each_entry(vp, &ha->vp_list, list) {
 				if (rptid_entry->vp_idx == vp->vp_idx) {
+					if (test_bit(VPORT_DELETE, &vp->dpc_flags))
+						break;
 					found = 1;
 					atomic_inc(&vp->vref_count);
 					break;
-- 
2.53.0

