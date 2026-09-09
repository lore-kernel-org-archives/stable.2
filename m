Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC35437E5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953054; cv=none; b=g2qXEepQg8SP9j0XpZU1ZOln/EV4/17o6afq6vPlShJjsW0TQT1MXakOkgRGj7GnVHoVAPygjXApIWJR1QlOH51aXZfCJ2tLuTQgY4aJ1vpmFrhp/IV1wnNsNxLQWesgn8ljHnPHm9U6bUElZiyKy0o7LsALt0k/t37aMRg36Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953054; c=relaxed/simple;
	bh=ae6WbHVpkOf4jj8xtLeopQcGB2tXWwObUOoK35N+hwM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O4sm7XdyPrQTMgrvKy2dqtOx5AeHmWGRxiY3NZS6FmkcgdFPL0nhcOXuclo6VzSyKZDbcDZkhspr4pGRPsEkyFm44Zk6icCROtmKVV0e8FS/qUfl4PBd1onPcIJAnDMnSWAVFoo6tno49Wa7yNUamLXN0dD2/7ahxP4qo4g4mEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNq9wN28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNq9wN28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1639B1F00A3A;
	Wed,  9 Sep 2026 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953052;
	bh=p00A0nK9vG4QVd3YJQxR+GywvLcpLWafpEdlDU/YpXc=;
	h=Subject:To:Cc:From:Date;
	b=VNq9wN28HUchuqvtPnfmnVsFvy13CtgkkA8xu1MhxjsrKLlHIOAcRD5cekU2hnylY
	 sNFizkuuI05wOKbkdkHcc7WlPXEt+Izvg9RFmBzKFSkdnJw2cBjqRS7IdO4FdEcpnn
	 z1o/BhEv/c23D4TuqtB5uxArkd0mEcf1quM6YEr8=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap" failed to apply to 6.18-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:15:12 +0200
Message-ID: <2026090912-discard-kept-a3d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 878613ecb5a36db26859c4fd83daf9283a334fa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090912-discard-kept-a3d7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

