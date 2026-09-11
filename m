Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54159E34A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161356; cv=none; b=dRiK5r7sG5K4aLy9jSR8i8xoUrFcfOEVqJWBC3xWkN6ShjkzkJxN0UG9oqkbVzHJa1VQeCfPMvCrMRKZ5C9zyJhpVbb+wtLNkp4UgNRn+qYBPDItaNy2nHTExrXL63COhGLjCwOYvyzAMgOLz01e+rSOxXGhI7CK2GYmEJn/vus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161356; c=relaxed/simple;
	bh=5J1hnpXqcMK3/f0ZzLTvEpZFR46XeTSqSGZxBrP0Mu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHcNCp+/9SFF7AUlFYj9l4EXvzYGKR4v7nBkFlCoNJdEftSKHX4APTUZRttdbAAtT3VRI4wxbKbe8TNPtROIlsH2Nckt29k/rrraQDOtiXpNiTzxGDBPiJsK2cIAWLqMBjBqs++fNAuOxZbcyY4kq/W4h8e6pxCpjHPSb5vhVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcIr2+pM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcIr2+pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393291F00893;
	Fri, 11 Sep 2026 21:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161353;
	bh=VgT6VXp8HA4IspWieQu6ah2HEp09/odO7E73qR/6fnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OcIr2+pMctBeEWWqqVQlSoLA3JJWt0i6kUj9aMPpSpj2MTDzPVTRuptedHUHHHHHE
	 LDcOiA4BCPZWEzyBzIjCZ3NpEN1Z6ARSHCzknZEy9KM4a8v8sUM48GGDzfpHiJU330
	 N5IbRTsbeCFYz11/BUhljysJsotj4r2VR/JhdMiTQorY3Y8o/QBhva5blDH+89VH3/
	 j2AeCWrKKcCZc6NyYwLJqAakJI0+2tS0bEpZEulgJGyspuFkXf+4SEcdvQUhKkwjLJ
	 cZ6diqWb/YPmezmHHravL+A5jPpLhhlPqBn0dL2dhr8XZ7bvNLMcjEvEvalfk2hFOB
	 QWdMnUQJKW6SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size
Date: Fri, 11 Sep 2026 17:15:50 -0400
Message-ID: <20260911211551.1533083-2-sashal@kernel.org>
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

[ Upstream commit 878613ecb5a36db26859c4fd83daf9283a334fa2 ]

The VP control IOCB selects its target virtual port by setting one bit
in vp_idx_map, a fixed 16-byte (128-bit) array in both
vp_ctrl_entry_24xx and vp_ctrl_entry_24xx_ext. qla25xx_ctrlvp_iocb()
computes map = (vp_index - 1) / 8 and writes vce->vp_idx_map[map]
without checking that map stays within the array.

max_npiv_vports is taken from firmware and only sanitized to a
MIN_MULTI_ID_FABRIC-aligned boundary, so it can legitimately be 191 or
255, and qla24xx_control_vp() only rejects vp_index >= max_npiv_vports.
A vp_index above 128 therefore yields map >= 16 and an out-of-bounds
write of up to 16 bytes past vp_idx_map, corrupting the trailing IOCB
fields (or the adjacent request-ring slot on the 64-byte layout).

Reject a vp_index that cannot be represented in the IOCB bitmap in
qla24xx_control_vp(), and add a defensive ARRAY_SIZE() guard in
qla25xx_ctrlvp_iocb() before the write. Adapters that report the usual
63 or 127 NPIV vports are unaffected.

Fixes: 2853192e154b ("scsi: qla2xxx: Use IOCB path to submit Control VP MBX command")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-49-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

Backport notes for 5.10:
Retain both VP_CTRL bitmap bounds checks. Resolve the qla_mid.c context
conflict by adding the upstream ref: INIT comment before the existing
SRB allocation; the stable branch predates that comment. This also keeps
the context required by 2ac6a829843c without importing the newer SRB
lifetime changes or adding any functions.

Also remove the extended-IOCB size assertion inherited from the preceding
backport: 5.10 does not define struct vp_ctrl_entry_24xx_ext, so applying
sizeof to it prevents qla_os.c from building. The existing 64-byte IOCB
size assertion remains, and both bounds checks use that defined layout.

Stable-dep-of: 2ac6a829843c ("scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 6 ++++++
 drivers/scsi/qla2xxx/qla_mid.c  | 9 +++++++++
 drivers/scsi/qla2xxx/qla_os.c   | 1 -
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 54ff66d6f6508..65a808199bf55 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3723,6 +3723,12 @@ qla25xx_ctrlvp_iocb(srb_t *sp, void *pkt)
 	vce->entry_count = 1;
 	vce->command = cpu_to_le16(sp->u.iocb_cmd.u.ctrlvp.cmd);
 	vce->vp_count = cpu_to_le16(1);
+	if (map >= ARRAY_SIZE(vce->vp_idx_map)) {
+		ql_log(ql_log_warn, sp->vha, 0x307c,
+		       "ctrlvp: vp_index %u exceeds vp_idx_map capacity\n",
+		       sp->u.iocb_cmd.u.ctrlvp.vp_index);
+		return;
+	}
 	vce->vp_idx_map[map] |= 1 << pos;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 1a4a740e118a0..5bde2414b1cd8 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -953,6 +953,15 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	if (vp_index == 0 || vp_index >= ha->max_npiv_vports)
 		return QLA_PARAMETER_ERROR;
 
+	/*
+	 * The VP_CTRL IOCB selects the target VP through a fixed 128-bit
+	 * (16-byte) vp_idx_map bitmap, so vp_index must fit within it even
+	 * if firmware advertises more NPIV vports.
+	 */
+	if (vp_index > sizeof_field(struct vp_ctrl_entry_24xx, vp_idx_map) * 8)
+		return QLA_PARAMETER_ERROR;
+
+	/* ref: INIT */
 	sp = qla2x00_get_sp(base_vha, NULL, GFP_KERNEL);
 	if (!sp)
 		return rval;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 6882b34bf5848..552227a65855e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7869,7 +7869,6 @@ qla2x00_module_init(void)
 	BUILD_BUG_ON(sizeof(struct vf_evfp_entry_24xx) != 56);
 	BUILD_BUG_ON(sizeof(struct vp_config_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(struct vp_ctrl_entry_24xx) != 64);
-	BUILD_BUG_ON(sizeof(struct vp_ctrl_entry_24xx_ext) != 128);
 	BUILD_BUG_ON(sizeof(struct vp_rpt_id_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(sts21_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(sts22_entry_t) != 64);
-- 
2.53.0

