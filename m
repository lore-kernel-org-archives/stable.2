Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C153ED1E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953057; cv=none; b=D5pDOh73QoXXABn3d58KZPT3zCviOgn69BrYMkukyzQIuR3EBRH+7WNLOCshJ3FLDfrhEpXjYN9IoTdz7YPRHyfJsId4inOO1x4wJdOVh7z0U6QnTM/nN8i1aif8pL+csgHR8ygMlqu3N7WWXItnlWBLmF7/nGkbTJEOiONw/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953057; c=relaxed/simple;
	bh=pDLHYBV4kYuE7BPqWyNpYwlJPX75VKRuEAKwYpR1Wx8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GeHl/h5uK/IQg12wY+trTAzaPBT7PcjbRVnu1WzczPH7TxaW9FQU2POdMuE7nBm2eDs9M2jy61d9ya4sbkmfQvWGucuQq7iwpe81WtrE5ePnBVjx7E7zMPGvrhVrLLJJ+VcjJ01aLm+nA2PiGdGibtNHzzJWpyyfnROKCf/4Op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0KXMgx/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0KXMgx/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24431F00A3A;
	Wed,  9 Sep 2026 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953055;
	bh=1FLNbyMNV2C/AmljKDTJ7P6mf+Zx20I0GxkFRYpop8k=;
	h=Subject:To:Cc:From:Date;
	b=0KXMgx/DecQdaiegkjNo7+zhfyVBqNrAiY5nveUKDTNneRX4MieAeU76hhiTvB6g+
	 VyUcAIEb56L8Bsr4PqC9UbuP0Kcjn2uSLjmL56hmCNZcHP6c1WllpKVi4AJN1qEuqv
	 N0iyW54acH2w2UTLoce9VOIeVcEhLBOX79pG3z70=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap" failed to apply to 6.1-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:15:13 +0200
Message-ID: <2026090913-chess-wrinkly-8139@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 878613ecb5a36db26859c4fd83daf9283a334fa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090913-chess-wrinkly-8139@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 878613ecb5a36db26859c4fd83daf9283a334fa2 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 23 Jul 2026 10:34:05 +0530
Subject: [PATCH] scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap
 size

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

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 8bd7c94d7c7c..c4595626c16b 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -4126,6 +4126,12 @@ qla25xx_ctrlvp_iocb(srb_t *sp, void *pkt)
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
index 7072af5b4217..b7d9c1a53f3c 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -987,6 +987,14 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
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

