Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C140A93E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923174; cv=none; b=rPBk1anKYjKlY+IbizTk5AmXyZmIRPPRRV2VajonlGLPOx/JU+3fkM4l/Jr2tnb4czog/NjYgzfrzCK3T9OQwWaP9I4CSE7mMAaN1rmDjzfNGGLdWO6axFZwVXbB5/wLeJGw75Vh6P9Gv5LtQzilKaIFS4Oj7GhaEhDCBHTSJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923174; c=relaxed/simple;
	bh=4kMaIrnsTrd50WaiqMin8DFMekf30vwYxT8FojDRiNU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S+5yxhHO3w5yOgqDOupJ6v3anOLvwSEcurysLujAQ2WLvMFK/efiDa3YMjXo/Ewj8SV4tSQqnmhcTPdvNTGFjl1PeliFk2LsvuX/NofASgYCsMbowpwL0sSWbrw5kecDBKRzYgobTzA0M7psyjURYDv9Skd8bGw54A/vKHdgjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQKy7O4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQKy7O4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138401F000E9;
	Wed,  5 Aug 2026 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923173;
	bh=5+jrkj2PYGnVZkKgLJuHyLWqGbYaVvzrgAkBuSHPTek=;
	h=Subject:To:Cc:From:Date;
	b=AQKy7O4AO9LxjoQGrEtY24tMNU5JQn5POmvg1HOBB1dXoLuhCQxCXfc8xUmQQTtqa
	 USnpsndRrnfOOTprGzboCc4dmxgw19Ba5sD3ji7wQ/vcp74BLpzUL+EnuSD2+fTrYt
	 faSvQHMBlFRiM3azXQZ+U3/FGevMSXCVJrL/ksjw=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: schedule deferred atapi command" failed to apply to 6.18-stable tree
To: dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:45:50 +0200
Message-ID: <2026080550-flaring-quickstep-e60d@gregkh>
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
git cherry-pick -x e7468b3f9b404ac7c1329ef07c146c3356dfbd01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080550-flaring-quickstep-e60d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7468b3f9b404ac7c1329ef07c146c3356dfbd01 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Thu, 23 Jul 2026 07:42:26 +0900
Subject: [PATCH] ata: libata-scsi: schedule deferred atapi command

Modify atapi_qc_complete() to call ata_scsi_schedule_deferred_qc() to
ensure that any deferred queued command can execute. This is similar to
ata_scsi_qc_complete() function for regular ATA devices.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 02b04de925f9..cd64787c4772 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2993,6 +2993,7 @@ static void atapi_fixup_inquiry(struct scsi_cmnd *cmd)
 
 static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
@@ -3022,12 +3023,12 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 			ata_scsi_qc_done(qc, false, 0);
 		else
 			ata_scsi_qc_done(qc, true, SAM_STAT_CHECK_CONDITION);
-		return;
+		goto schedule_deferred;
 	}
 
 	if (cmd->result) {
 		ata_scsi_qc_done(qc, false, 0);
-		return;
+		goto schedule_deferred;
 	}
 
 	/* successful completion path */
@@ -3035,6 +3036,9 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		atapi_fixup_inquiry(cmd);
 
 	ata_scsi_qc_done(qc, true, SAM_STAT_GOOD);
+
+schedule_deferred:
+	ata_scsi_schedule_deferred_qc(link);
 }
 /**
  *	atapi_xlat - Initialize PACKET taskfile

