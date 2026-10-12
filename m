Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CA40EBA9
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804798; cv=none; b=BzgEHJsKIEiengLFh81IgD20YFr/Mv6yigDTCTmPz8FfZE4sWpFdpZEh93scTzeYPR5n/BuW/obuQb4HNTvCOemYeBTc0/mFZwbCm2D71hBJLNPL+henjJY03Ue7qa7aJUa9P717WosD4wbdYJ6wrXM9QF80aLpPzuoJmUkjf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804798; c=relaxed/simple;
	bh=RVdLVOqEzQoxKhfLs8Ckiq4bfOiUYWBFXzFwQS17Ub4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C24KNZUncUfsaCucb/vX6CGuwLNZFWXClaJ2iyTtlqLG7jEUM3V2+RJhI2B7QV+5muOJw+M0MkRwOJRXjh+hNi2DuArxmob9Av7k9wiv4zvWUAfdk53J2bVKRFdOcLHNgeUlxLDorfM+K8xWgnEtDBlAIXk7v7Qd+YMC7iZowtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+gMVEaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+gMVEaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851771F0089B;
	Mon, 12 Oct 2026 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791804797;
	bh=f70HeLiylvwGnZAtW9V06sV7mDny6eWJL0OEicK7yzA=;
	h=Subject:To:Cc:From:Date;
	b=u+gMVEaHMTmN4t6XBxmxYIMVwMsiZIvZHU2s0TEu6aB1Lucip/u0+IdtEC+mAk/oo
	 +d5FbfVCe4g3yfcQDkVf+MwxcrtBRNnwndcrGK2HiWaBKZHlPQ81qCrXolO2OoA/qV
	 17wRY+4pFpbxfdA9HB9zb4nO4ZPYSvMx3W8NnB1Q=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: do not lose CHECK CONDITION for failed" failed to apply to 6.12-stable tree
To: hengyul@cs.unc.edu,cassel@kernel.org,dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:33:14 +0200
Message-ID: <2026101214-grumpily-cloning-5a44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bc8ce2cea5f77c4bd1a5184705e300e83546c0c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101214-grumpily-cloning-5a44@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc8ce2cea5f77c4bd1a5184705e300e83546c0c4 Mon Sep 17 00:00:00 2001
From: Hengyu Liang <hengyul@cs.unc.edu>
Date: Tue, 29 Sep 2026 12:41:35 -0400
Subject: [PATCH] ata: libata-scsi: do not lose CHECK CONDITION for failed
 ATAPI commands

Since commit 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands
on time out"), atapi_qc_complete() sets SAM_STAT_CHECK_CONDITION for a
failed command only if cmd->result is zero, so that the DID_TIME_OUT or
DID_REQUEUE host byte of a terminated command is preserved.

However, cmd->result can also be non-zero for a regular failed ATAPI
command completed through libata EH: ata_eh_analyze_tf() calls
ata_eh_decide_disposition(), that is, scsi_check_sense(), on the sense
data obtained with REQUEST SENSE, and scsi_check_sense() sets the SCSI
midlayer internal byte of the result for some sense codes, e.g.
SCSIML_STAT_TGT_FAILURE for ILLEGAL REQUEST with ASC 0x20 (INVALID
COMMAND OPERATION CODE) or 0x24 (INVALID FIELD IN CDB), or
SCSIML_STAT_MED_ERROR for MEDIUM ERROR with ASC 0x11 (UNRECOVERED READ
ERROR). For such commands, atapi_qc_complete() keeps the result as is and
the command completes with a GOOD status byte, even though it failed and
valid sense data is available.

As a result, passthrough users see these failed ATAPI commands as
successful. For example, with the emulated IDE CD-ROM drive of QEMU and
no medium loaded, a PLAY AUDIO MSF command issued with SG_IO completes
with status 0x00 (and no DRIVER_SENSE) instead of 0x02 (CHECK CONDITION)
with sense key ILLEGAL REQUEST, ASC/ASCQ 0x20/0x00, and the CDROM ioctls
CDROMPLAYTRKIND, CDROMSUBCHNL, CDROMPAUSE, CDROMRESUME, CDROMPLAYMSF and
CDROM_GET_MCN return 0 instead of -ENOMEDIUM or -EOPNOTSUPP.

Fix this by setting the status byte to SAM_STAT_CHECK_CONDITION whenever
the host byte is not set. Use set_status_byte() rather than overwriting
the whole result, so that the SCSI midlayer internal byte set by
scsi_check_sense() is preserved, as ata_scsi_qc_complete() already does
for ATA commands.

Fixes: 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands on time out")
Cc: stable@vger.kernel.org
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20260929164135.266708-1-hengyul@cs.unc.edu
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8f9aa97a519d..fb5517d51095 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3059,10 +3059,15 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
 			qc->dev->sdev->locked = 0;
 
-		if (cmd->result)
-			ata_scsi_qc_done(qc, false, 0);
-		else
-			ata_scsi_qc_done(qc, true, SAM_STAT_CHECK_CONDITION);
+		/*
+		 * Report CHECK CONDITION unless the command was terminated
+		 * with a host byte set. Only set the status byte, so that the
+		 * SCSI midlayer internal byte, which scsi_check_sense() may
+		 * have set from the sense data, is preserved.
+		 */
+		if (get_host_byte(cmd) == DID_OK)
+			set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
+		ata_scsi_qc_done(qc, false, 0);
 		goto schedule_deferred;
 	}
 

