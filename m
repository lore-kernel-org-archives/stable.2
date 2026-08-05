Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FD407CDA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923172; cv=none; b=GlgeIenWjrkllnOs0+QQKzZhNKEMrvQf2hWAay0KFZajMzO5nBRd5Ch/N/9ISn7vc4d6BYIzhj4JdwthEJOALKrBk73pQpKkoSsLj7JEHaqtawwclc4vGN78U/2Gdb9G681im2WF8zmRKbMamavkJogRSN5MlMg5pgfhiY2Yu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923172; c=relaxed/simple;
	bh=iu8xWUE5pFOW+LqOHoyu5V+OJUPbefkHNQLHo4cCCfk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h7P34Gzz1r0utD7lhOhaFu0Y1aHP/xtcFfm8Dd8ZdS6iRxfOREo1tiFTjkAwil10DSHgAHr3ThRg1bRtBD1M7IygC/2jeadjF8qu+2MOgjCMZu1k0o44NY0MPAoAOtIvMmrWRb89MoJv6pHOFKkG3kyQdYZgyKYqtt4Bx0OHPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s5HP+aQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s5HP+aQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3AD1F000E9;
	Wed,  5 Aug 2026 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923170;
	bh=q8mf38i1VpQdLDjJwZ8QNZAbvlFTFBvn9+kPkuD0wMg=;
	h=Subject:To:Cc:From:Date;
	b=s5HP+aQswmuPKTBA2GWsnHHN6Wrp0K9DMmr3wcNbb5NoKxssvQpTbh74ncO3IHo+O
	 uyYk7pR+m5FT4vf/m2c28KZ5rEa8stbsIghy5PqgHbau/4eXgNWTJttnMU/M5LGc5p
	 lGYozKLQas22Q7mGYGr12Zal9PcIV0krZoeBYkXs=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: schedule deferred atapi command" failed to apply to 6.12-stable tree
To: dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:45:50 +0200
Message-ID: <2026080550-emerald-confidant-d0ad@gregkh>
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
git cherry-pick -x e7468b3f9b404ac7c1329ef07c146c3356dfbd01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080550-emerald-confidant-d0ad@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

