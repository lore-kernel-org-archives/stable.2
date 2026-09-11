Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EF399019
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140524; cv=none; b=POPEU25WIJAHZLkOvFuUAm8z7NPNU89iRIlqYEezYLubXOYKGejwpBdEU6gHgEeToQ4zdmk/lJVYR4/AtKBCiyEKmN/fQhV+pCeRIHyH0OBdAC/HOjx4gYhI55PomnCY364fZSW7jDgsFige/rwL+utsNUeTOXLQhqFNKqr0ors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140524; c=relaxed/simple;
	bh=W5A82+lXN0GRGOohWYkQG0NqeQ1EspSzuyxmUiVkme0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8NGk2088tHHYN5onBE4TwVE1aVmUY3xl0IXn8xhH2UGiQtjSpi5kyYYpE5FL+g1liz6Z+AsvaQK239tsjQ5sNf8OrlcIWG8pCIubs9usxY2M1hXmtWJXXqfF2ky8oBptCoS91SFPBfuQWdQjrtnyTYkPYhtWBhs12uI6tFacmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz94r2+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz94r2+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880F81F000FF;
	Fri, 11 Sep 2026 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140523;
	bh=L0ZbVl0LHQclE0/cqp+QMnFWsPQjEBp+ybgHOdSqBZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oz94r2+3L9wz9rAT++c8V9Avv/7t/+FvB6TmHGnA/xxHNENkjcsy29y/tC8xH++vJ
	 UvPnIy3/9RMGCfwoEI6E6/pXKC5eunZC3KX6zkBtdwAIjRKA0LX9Y0sijhnRPqPDRm
	 dqk+m7NxXrVmxp8ISAcsOy6nlsufg3CI+EdJJ4xYFQjHX4un33XodZ6qD5MarlvOVg
	 lvOFslyftdSjHK3D+UB7c1GVnRJZgHFtiEpBm+FrtzEGxc67SdrDkzEMOkkBwNCRcK
	 3QiuzLtkEZtrU0z5Ie4ckEas9fY0mQY8atDLsAT58DAF+m0lpDUoOk0U0bAF4t9Cer
	 AnKr+bXQk3XTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size
Date: Fri, 11 Sep 2026 11:28:40 -0400
Message-ID: <20260911152841.1078441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090913-chess-wrinkly-8139@gregkh>
References: <2026090913-chess-wrinkly-8139@gregkh>
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
index 7bccd525ee19b..800c1885050fd 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3826,6 +3826,12 @@ qla25xx_ctrlvp_iocb(srb_t *sp, struct vp_ctrl_entry_24xx *vce)
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
index 79e4319bbbd28..a552b8dea4833 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -966,6 +966,14 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
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

