Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5C49BD77
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149591; cv=none; b=FW58+6H7JRJNQFChzbDOtTy9/lrxwU/nFjmj0/R7P90pbep7ZoEBl37B/LgYBPAysNUtoxwNhuzooWw/fyFL7GB4uI6lXXlALMbY6UjGt0TABixsnJxajZzkrrtTb2tK9VgYFNscez+pb7OVQ/MLfv638/ZjcPmlZcwzBzKU++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149591; c=relaxed/simple;
	bh=MtNzLsR11jvBRo8VmerZ7qVfk6QZo6IMEcW3cqmkGzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dfefx+9zQ9WS75u/p7NLLSRfIBKB16/EBxe/aTQQrX1Rwc0j4ODTESMFx4AKt0+qfDpctMZ3kA3uIod1LDLVreCt3yHCRsb5O26KLctWJ4NR/XkzxzYG8FtXnAvTSs2aFDkbPwha5c0c+il1DOpfIHk5zQZn2yZUp32deqxMSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVuFHRap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVuFHRap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FD61F000FF;
	Fri, 11 Sep 2026 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149589;
	bh=JVp4058mGT2Qn/7Vdy4T51/KqQcIXK0B/8c/ARN/OoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVuFHRapf9ZE0+aERrO77FVQyoGdxlHQuMm3bvze77J4ps+iW1tBbBsnxA0meWb4u
	 yiU7xirh+y8/lPSSkzsK1fH8PnkKjzLRJZjr4ncKk72SzhbgITGW2VFNAGZeJAFRcx
	 ur9gwreegNVxgAi1AAbsrFggEWDB6Z6iod2wKQf0RL29H4Kmx5OXTtlT+4C2aK0zCA
	 NvS1huVqZ/03Unf3yR1DRce2XirgjxLJSfuCStS0XcBRpVrpF+obNyVSk014324Ti7
	 nkwW4ggIPwKMXwynycKmuCUK1sQdZ9mNT/1pavU9Gz0kjwqCBwvagNJnd88STBZu3n
	 vyvyNDIjtLJgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity
Date: Fri, 11 Sep 2026 13:59:47 -0400
Message-ID: <20260911175947.1288110-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090902-nape-morphing-bd71@gregkh>
References: <2026090902-nape-morphing-bd71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 2ac6a829843cf3df522d19e091276109b94c4c7a ]

ha->max_npiv_vports is taken from firmware (mcp->mb[11]) and only
constrained so that (max_npiv_vports + 1) is a multiple of
MIN_MULTI_ID_FABRIC, which permits values of 63, 127, 191 and 255.
NPIV vports are then allocated up to that count.

VP enable uses the VP_CONFIG IOCB, which addresses a vport through a
plain vp_index byte, so a vp_index beyond 128 is enabled without issue.
VP disable, however, uses the VP_CTRL IOCB, which selects target vports
through the fixed 128-bit vp_idx_map bitmap. qla24xx_control_vp()
rejects a vp_index past that bitmap and the IOCB builder cannot set a bit
beyond 127, yet qla24xx_vport_delete() frees the local state regardless.
A vport with vp_index > 128 can therefore be created and enabled but
never disabled, leaving it permanently active in firmware: a resource
leak.

Cap ha->max_npiv_vports at init to the vp_idx_map capacity so such
vports are never created. This collapses 191/255 to 127 (still
modulo-valid) and leaves the real-world 63/127 cases unaffected.

Fixes: 4d0ea24769c8 ("[SCSI] qla2xxx: Retrieve max-NPIV support capabilities from FW.")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-20-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ adapted the qla24xx_control_vp() hunk to include the prerequisite bounds-check block missing from this branch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_fw.h   |  4 ++++
 drivers/scsi/qla2xxx/qla_init.c | 13 +++++++++++++
 drivers/scsi/qla2xxx/qla_mid.c  |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index f307beed9d29d..e7ded95afb9a8 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -1442,6 +1442,10 @@ struct vp_ctrl_entry_24xx {
 	uint8_t reserved_5[24];
 };
 
+/* vp_idx_map is a 128-bit (16-byte) bitmap selecting target VPs. */
+#define VP_CTRL_IDX_MAP_BITS \
+	(sizeof_field(struct vp_ctrl_entry_24xx, vp_idx_map) * 8)
+
 /*
  * Modify Virtual Port Configuration IOCB
  */
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2ab1cecda8c75..3dfe5dfd5c3f2 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4374,6 +4374,19 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 					    MIN_MULTI_ID_FABRIC))
 						ha->max_npiv_vports =
 						    MIN_MULTI_ID_FABRIC - 1;
+
+					/*
+					 * The VP_CTRL IOCB selects target VPs
+					 * through the fixed vp_idx_map bitmap,
+					 * so a vp_index beyond it can be enabled
+					 * via VP_CONFIG but never disabled via
+					 * VP_CTRL, leaking the VP.  Cap the count
+					 * to the bitmap capacity.
+					 */
+					if (ha->max_npiv_vports >=
+					    VP_CTRL_IDX_MAP_BITS)
+						ha->max_npiv_vports =
+						    VP_CTRL_IDX_MAP_BITS - 1;
 				}
 				qla2x00_get_resource_cnts(vha);
 				qla_init_iocb_limit(vha);
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 9946899dd83b8..e85b4bec91d9b 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -957,6 +957,14 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	if (vp_index == 0 || vp_index >= ha->max_npiv_vports)
 		return QLA_PARAMETER_ERROR;
 
+	/*
+	 * The VP_CTRL IOCB selects the target VP through a fixed 128-bit
+	 * (16-byte) vp_idx_map bitmap, so vp_index must fit within it even
+	 * if firmware advertises more NPIV vports.
+	 */
+	if (vp_index > VP_CTRL_IDX_MAP_BITS)
+		return QLA_PARAMETER_ERROR;
+
 	/* ref: INIT */
 	sp = qla2x00_get_sp(base_vha, NULL, GFP_KERNEL);
 	if (!sp)
-- 
2.53.0

