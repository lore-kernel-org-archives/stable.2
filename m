Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4759B68E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161356; cv=none; b=TWi7IWxWkNHy9t/GlytRARz6RQWm3adxDCC5n2wYEGdKl4qIjstsV1vTGGssi/4cAXE/zbpv3ANqmgSEUwplDsKkYDyi73AqZC7LsqDxGmjV9cTWTXi/NL9bwZw2/U86UWmMmxr/rUxIsg4lMXyqUOkc/frB9g3zHC0I03WVA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161356; c=relaxed/simple;
	bh=zO1N0+Yo0DcUvrKy/Mw68ijECxHJx3cD2BmDHq/znjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJct6T5yydV3ydth/k+QBKHvLlldAgQwbgMf+IIvWJ7IcQtT1isgGf6hyOwlzeuxIrj+JcYsjmiEwOfS5wBhg551QZ91nR4b4Y9h2QvhwiFdiUI4Qru68Vja10dtxvHj2uzphlgSOgEWdAbPyHv9x2UxBUKuOySEh+iQ3i4Xxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxyWEk3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxyWEk3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621F81F000FF;
	Fri, 11 Sep 2026 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161353;
	bh=OsJUSDMUPyuryRNrGvG8fRTlja7UlT496BYcRN+LmlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cxyWEk3cPVQurgkKiT0rHsn/kq9AAtSYVO3CT7hVDFGRFjJjYMuZnstKXT7NCtHmb
	 bXGz015y1VC3MhY3woHXa8VjqnEvttW1IvD1ykWiqmOp5BVzrTGnQYYtC5icSFp01z
	 EXSI5UBw8l41SJ/hkSvtPSdxcuwIwmNCzi38Evu3M3aNBjIzO4YvQUM7zCca5liPpZ
	 6Oc1afLpZrorXATL7lqq3iJLBHgrE6XAwo1J+lzUYcWk/xzsEwEujWJKA1LLU+v4zo
	 4lCTPwEorORPzttDRGgBzaGgDUdF1ZXP3bUkn8gM9h/qTw6V2dbmhJ55Jrn8x3yMe/
	 tjG7YiCSzKwjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] scsi: qla2xxx: Update VP control IOCB handling for 29xx series
Date: Fri, 11 Sep 2026 17:15:49 -0400
Message-ID: <20260911211551.1533083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-grout-chitchat-b447@gregkh>
References: <2026090904-grout-chitchat-b447@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit d681a3315dffe87513ed87e11456b33e21dcfd65 ]

Update VP control IOCB command and response handling to support the 29xx
series adapters, which use the 128-byte vp_ctrl_entry_24xx_ext layout.

Change the qla25xx_ctrlvp_iocb() and qla_ctrlvp_completed() function
signatures from typed struct pointers to void *, since callers already
pass a generic ring-slot pointer.  Both the standard 64-byte
vp_ctrl_entry_24xx and the 128-byte vp_ctrl_entry_24xx_ext are
layout-identical for every field touched in these helpers (entry_type,
handle, entry_count, command, vp_count, vp_idx_map, entry_status,
comp_status, vp_idx_failed), so a single struct vp_ctrl_entry_24xx *
view handles both adapter families without an IS_QLA29XX() branch.

Add a BUILD_BUG_ON size check for the extended structure.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-36-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Stable-dep-of: 2ac6a829843c ("scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 23 ++++++++++++++++-------
 drivers/scsi/qla2xxx/qla_isr.c  | 13 +++++++++----
 drivers/scsi/qla2xxx/qla_os.c   |  1 +
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 1752a62031710..54ff66d6f6508 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3698,22 +3698,31 @@ qla_nvme_ls(srb_t *sp, struct pt_ls4_request *cmd_pkt)
 }
 
 static void
-qla25xx_ctrlvp_iocb(srb_t *sp, struct vp_ctrl_entry_24xx *vce)
+qla25xx_ctrlvp_iocb(srb_t *sp, void *pkt)
 {
+	/*
+	 * vp_ctrl_entry_24xx_ext is layout-identical to vp_ctrl_entry_24xx
+	 * for all fields touched here (entry_type, handle, entry_count,
+	 * command, vp_count, vp_idx_map) -- they all sit at the same
+	 * offsets and types in both structs, and the ext layout merely
+	 * tacks on flags/id/hopct/reserved at offset 32+.  So no
+	 * IS_QLA29XX(ha) dispatch is needed on the issue path.
+	 */
+	struct vp_ctrl_entry_24xx *vce = pkt;
 	int map, pos;
 
-	vce->entry_type = VP_CTRL_IOCB_TYPE;
-	vce->handle = sp->handle;
-	vce->entry_count = 1;
-	vce->command = cpu_to_le16(sp->u.iocb_cmd.u.ctrlvp.cmd);
-	vce->vp_count = cpu_to_le16(1);
-
 	/*
 	 * index map in firmware starts with 1; decrement index
 	 * this is ok as we never use index 0
 	 */
 	map = (sp->u.iocb_cmd.u.ctrlvp.vp_index - 1) / 8;
 	pos = (sp->u.iocb_cmd.u.ctrlvp.vp_index - 1) & 7;
+
+	vce->entry_type = VP_CTRL_IOCB_TYPE;
+	vce->handle = sp->handle;
+	vce->entry_count = 1;
+	vce->command = cpu_to_le16(sp->u.iocb_cmd.u.ctrlvp.cmd);
+	vce->vp_count = cpu_to_le16(1);
 	vce->vp_idx_map[map] |= 1 << pos;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 0efc9ba98104e..1bea78808324e 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2408,13 +2408,19 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
 }
 
 static void qla_ctrlvp_completed(scsi_qla_host_t *vha, struct req_que *req,
-    struct vp_ctrl_entry_24xx *vce)
+				 void *pkt)
 {
 	const char func[] = "CTRLVP-IOCB";
+	/*
+	 * vp_ctrl_entry_24xx_ext overlays vp_ctrl_entry_24xx for all
+	 * fields read here (entry_status, comp_status, vp_idx_failed),
+	 * so the read goes through one struct vp_ctrl_entry_24xx * view.
+	 */
+	struct vp_ctrl_entry_24xx *vce = pkt;
 	srb_t *sp;
 	int rval = QLA_SUCCESS;
 
-	sp = qla2x00_get_sp_from_handle(vha, func, req, vce);
+	sp = qla2x00_get_sp_from_handle(vha, func, req, pkt);
 	if (!sp)
 		return;
 
@@ -3535,8 +3541,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 			    (struct mbx_24xx_entry *)pkt);
 			break;
 		case VP_CTRL_IOCB_TYPE:
-			qla_ctrlvp_completed(vha, rsp->req,
-			    (struct vp_ctrl_entry_24xx *)pkt);
+			qla_ctrlvp_completed(vha, rsp->req, pkt);
 			break;
 		case PUREX_IOCB_TYPE:
 			purex_entry = (void *)pkt;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 552227a65855e..6882b34bf5848 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7869,6 +7869,7 @@ qla2x00_module_init(void)
 	BUILD_BUG_ON(sizeof(struct vf_evfp_entry_24xx) != 56);
 	BUILD_BUG_ON(sizeof(struct vp_config_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(struct vp_ctrl_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct vp_ctrl_entry_24xx_ext) != 128);
 	BUILD_BUG_ON(sizeof(struct vp_rpt_id_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(sts21_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(sts22_entry_t) != 64);
-- 
2.53.0

