Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E542369224
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139151; cv=none; b=BUpTVf/9eTqRUlbfU6pQ0kFOaZJEzqTz8uGaS9n5R6ZJKZCzJRd6sdHV4yRu+6lTUkte835Xi+IPrhqrVKZYDVJLyHbFsQnj5bmbx1VKRV50Cge5NB7ApHs3P+Zq3FyO+TItSerf35tWuJ4zqX87bI1iNvGBlon/qZy528paWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139151; c=relaxed/simple;
	bh=HQHrT98dwFyVxogByBgQIkdhjgKCXLrHnJPgcMP+mlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BK0PV60EFPKiG7WwCRneX6jkU/91jtg+bWl5yUKNtfH4tovrwb/hQAUzTHmHyXJPDJkzVkw1kmKaHVwNwSp0mh3kKOQKjw0v/HfWzaS1Ppqtj7FPU+VKg14zq5yfbkdq/ZSMsguzbMImueGm1ocbLtYiIp30zK39Plx4mzsIXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ9nniCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ9nniCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910641F000FF;
	Fri, 11 Sep 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139150;
	bh=f0ff0H4Gn/iQgyg/8+J0V3kt/I6qdi+k49pCCdGSnrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJ9nniCWTdBLZkgYMy4oGVEVlzkvVlDf4CEfh0EY5efONb2eUF0NslR4/7soemTOC
	 sa5ZS/hTq4xY+X/mOmzWhvw6SSfXO9gfvqddFmxPIsjNhwxqoPVpaHwtLv/OYGjwy0
	 pgaYG4ieP+kEpaNwG9pQRmaaMlZhuGcP68TdWDHInaUcDhOBpPpdmLaaOqiymoEqLO
	 oGPgCKolWYEhov0UywsGruuxKWskg5dRWEdJyjtflUzlhe+Qljny8AvaIXsCUHeppX
	 nJnnJ53YbrvAVNPBszNuR0wsMbCf6jhcXUBWQYNVBcfNNjck7EFwTyabkrjvNG+iHX
	 ANNb/eYqd2S/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size
Date: Fri, 11 Sep 2026 11:05:47 -0400
Message-ID: <20260911150547.1033717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090912-flagman-reanalyze-3438@gregkh>
References: <2026090912-flagman-reanalyze-3438@gregkh>
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
[ Adjusted guard placement in qla25xx_ctrlvp_iocb() to match the older initialization order. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 6 ++++++
 drivers/scsi/qla2xxx/qla_mid.c  | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 0b41e8a066026..ede18c7c07b6a 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3828,6 +3828,12 @@ qla25xx_ctrlvp_iocb(srb_t *sp, struct vp_ctrl_entry_24xx *vce)
 	 */
 	map = (sp->u.iocb_cmd.u.ctrlvp.vp_index - 1) / 8;
 	pos = (sp->u.iocb_cmd.u.ctrlvp.vp_index - 1) & 7;
+	if (map >= ARRAY_SIZE(vce->vp_idx_map)) {
+		ql_log(ql_log_warn, sp->vha, 0x307c,
+		       "ctrlvp: vp_index %u exceeds vp_idx_map capacity\n",
+		       sp->u.iocb_cmd.u.ctrlvp.vp_index);
+		return;
+	}
 	vce->vp_idx_map[map] |= 1 << pos;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 9946899dd83b8..a0b7f2077e99f 100644
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
+	if (vp_index > sizeof_field(struct vp_ctrl_entry_24xx, vp_idx_map) * 8)
+		return QLA_PARAMETER_ERROR;
+
 	/* ref: INIT */
 	sp = qla2x00_get_sp(base_vha, NULL, GFP_KERNEL);
 	if (!sp)
-- 
2.53.0

