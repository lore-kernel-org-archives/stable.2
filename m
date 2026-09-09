Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6F3D5666
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953201; cv=none; b=OiYW97pCjHb1VE4gMbqMidFYQJLyPQcLPIWX1EWTukMC0MZNPkNMSfofWX/qI6pdikdvTJD40pLCEMHeVWTtUmdAxNJ6tYxVsoQVuF5uFMDNYuX8EFzWeb1QjLkX2glD5cZx+1ClK4ZW8YO4lxe7IlHgKk1WZWnnFV3conJIqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953201; c=relaxed/simple;
	bh=FNMGrK4PwfQIrO0gMXI5UyExfB9lr6L8tlvZSWTIJs8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qf9tltyJ7MVkt2ExerHWXALhb82p5/bPNnhK6iwfQ5HwAM4vT+BhDfzlk2GIa6fLxxo7Nkn/FEqfiUHFfNxFG0D9QMEj7R513CvAxFO221muTeMevWYeqmUFln7Z/j6UgxOCkBRi4JYoyvQ4JPqhlmaChgUUbLcxlFRF/aIEKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YgOvvbhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YgOvvbhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36711F00A3A;
	Wed,  9 Sep 2026 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953200;
	bh=sgoge252vouQRv6okkEg/hFLrW6bgL5hDx/gb7GjBFo=;
	h=Subject:To:Cc:From:Date;
	b=YgOvvbhuJEhfuHsDb1bp23Xe1pe1FhFIYv0tlHwdE21k0dItrD/9+IuaAj6wDVfQ9
	 RaSIl4vzU2zizilPzhQx1iVVap+JxfwnK9T85okuxmvIMmp9izjldL8sjQG1OOJvot
	 NV9aA0dZTVnz0T3bPd/8h0NyF5jEycKKIlW6C+iE=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap" failed to apply to 5.15-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:19:03 +0200
Message-ID: <2026090903-chug-retype-8098@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2ac6a829843cf3df522d19e091276109b94c4c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090903-chug-retype-8098@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ac6a829843cf3df522d19e091276109b94c4c7a Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:24 +0530
Subject: [PATCH] scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap
 capacity

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

diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index b29abcc7f74f..98bc4a57b59b 100644
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
index e6b499245794..5788c7e53d8f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4412,6 +4412,19 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
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
 				qlt_config_nvram_with_fw_version(vha);
 				qla2x00_get_resource_cnts(vha);
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 33bfc61d8165..4ad23d206add 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -996,7 +996,7 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	 * (16-byte) vp_idx_map bitmap, so vp_index must fit within it even
 	 * if firmware advertises more NPIV vports.
 	 */
-	if (vp_index > sizeof_field(struct vp_ctrl_entry_24xx, vp_idx_map) * 8)
+	if (vp_index > VP_CTRL_IDX_MAP_BITS)
 		return QLA_PARAMETER_ERROR;
 
 	/* ref: INIT */

