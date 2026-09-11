Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14003515C5
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149805; cv=none; b=oDUuePhecmz/0S00ggk9Skn/WEofUEpbivL0X0tI0L6KnYLrBE15j92b9y13ITEVfVX8MxzwB9uUWjdlS0kSUdbOoq6nmLNDHgz+LvAP/KCvEz+BJCT8K+RleQpbIHp1z2v5M8wQh4pNISbW3VA/Voqu5Y+i+LzQBbLxNbfmTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149805; c=relaxed/simple;
	bh=0wqMiCyyGWdU4joxWy5FeojM+jEWb8w6RJ9OjEU3L4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/A6WfSdqS0p6I1bX8Ogim6TLfICwky45eXNdHWrexI9eqydpwcU2A3gc+xoXkoQDiy9HCXcFne6jXPBahsU6WXe/HpAvjvQP9n7cOobo0dSNNo5qGJneBQtNP5pVCbbuKgkDI4qcpdU+ctXdlLE5TfncUtBODszkh4dpQr7KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKGHS5st; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKGHS5st"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD01F00893;
	Fri, 11 Sep 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149803;
	bh=/hE+Dl0qwoZFpjBm04spjsGg1TorwSA0nbtXyyUgS0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKGHS5stT80L7d5lDj/SysW+e3SMnq7WVst3TM5yfta3Aa37fi7U1p69+WZ6D2q89
	 iLazNScWhgcxyw0ntLteND4NPnpYANkL1jcGeKaUkGY/PaORqSydBkvqXK327JDArM
	 XU9jfZVRNRor+eC5U+UhTiCnG3H6fIKBOFuaNir1aFVSmc+IxI8hkJq06mi511RTff
	 4L4MeaIscJX97KOkzA/MnaG6XQPejnr1Ru7V/FD04jCDJQNT4/bz9wJXLiMlM+3xIh
	 3dxWjVp3oWrkeSRThFe8WDwvHT5F8wL88UsN/SwpTy5VAiV7vL59LmOyICjySJiBGL
	 2DMR99eMXtojA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity
Date: Fri, 11 Sep 2026 14:03:21 -0400
Message-ID: <20260911180321.1292428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090902-filtrate-overeager-c2b9@gregkh>
References: <2026090902-filtrate-overeager-c2b9@gregkh>
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
index b736575e2d9fc..84b90a112317e 100644
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

