Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550E59C974
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161358; cv=none; b=gc97ir/yojafgYk3sHi2NywKEsD70CPewwjAQU9rOr1hm85lilgxTVkTvJ82ltT3o59oscNVsVJiczsr4AaSfxjz+E1H9MLLfhM9vOan+YA7afKkMIwNz7h4u+5Wk54325YSuVqjsTYveJLk8fQ4EMlzh4OKpHKEEyRlS++OsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161358; c=relaxed/simple;
	bh=rqTH3gBNlhc1LUybLKzAhyq4XhWKNhONkFc2bpdB8eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSvrwuoaszlgkgrrEYm6v+WA2l/EicBTGhZVhpyTm+5VmDI5Jl2MW+jI5AysgoXgIFArSY4YYvEczBbieeQDWcg6txyJZXZnuG5zgRWKXYo4lxEn96fV1y1bzoI9G/6WcmZGr51fTyl5uizUpIhO6aI1jGtpgR1GB32ZNTopwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCRMg9U2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCRMg9U2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B561F0089B;
	Fri, 11 Sep 2026 21:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161354;
	bh=KhE5tMB9iOmxPBpyxhMeGIU5B97kcoYf+w14BDo/rqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCRMg9U21P/Z2uh+OfVkWBrmlxMI32SPxjId/SOml+ki4TQ9tIh/U4eSj2kmJAnXq
	 nOr1TW8OWA3jFdw7LSezGtVtVgrFd0oAA4KrwMhBpymAweSQL3/LicycEoeUIdZgjX
	 00O3otMEUgXe/E/MtYLVVtNbUxFc9SFy33JmTOu7wi4IUxSQyIgqrI8qyjkz3BwSF7
	 jOQ5F/MDYjAfFDVUFap2iKsiwI0pE5lTWSdwm+1DsHxa7n1YHoCYsrC1rHtgTLPpG1
	 qivLMiF0aeoBtstO5raDs5zz82W19Ku86rCH1gn0B88466TuIkzCmBQR5/h94fxzaR
	 4qSNpkXj0XxvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity
Date: Fri, 11 Sep 2026 17:15:51 -0400
Message-ID: <20260911211551.1533083-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911211551.1533083-1-sashal@kernel.org>
References: <2026090904-grout-chitchat-b447@gregkh>
 <20260911211551.1533083-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_fw.h   |  4 ++++
 drivers/scsi/qla2xxx/qla_init.c | 13 +++++++++++++
 drivers/scsi/qla2xxx/qla_mid.c  |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index 12b689e328834..a03dee211e4c9 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -1414,6 +1414,10 @@ struct vp_ctrl_entry_24xx {
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
index 4a057748ba175..69ca9a2a17b48 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3910,6 +3910,19 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
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
index 5bde2414b1cd8..1b2c3d3470fe4 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -958,7 +958,7 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	 * (16-byte) vp_idx_map bitmap, so vp_index must fit within it even
 	 * if firmware advertises more NPIV vports.
 	 */
-	if (vp_index > sizeof_field(struct vp_ctrl_entry_24xx, vp_idx_map) * 8)
+	if (vp_index > VP_CTRL_IDX_MAP_BITS)
 		return QLA_PARAMETER_ERROR;
 
 	/* ref: INIT */
-- 
2.53.0

