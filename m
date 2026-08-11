Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6C304976
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414556; cv=none; b=E+8mnQK7mgbadnCYa5Ul1MZYs4Fvu2MZMbnJe8TvO5Io3DgiQ5aJeOywFW1Rtec/BszqqalQUqysHYYycBldfZZzB0r5jZaH2DN/Lq6fh+TO95f45npyz57hJpAw+Go5sNXblCTFeiABtJkCXGkVarkScMnCyH+/oydOZNXewng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414556; c=relaxed/simple;
	bh=UNyXLF5Jc0fa7OF9SVwgn/YQhiAg7QDOIv4uA7ZLmBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxjg0pwWhOb7fENNidCUSS5lHBnfAR0YzpeqeBEIDXCTH7HAfNJvxlEeoVelfSvAfLkP+b7rY8XOAB/IhBtFX73ZrSkEjBeXj4S6Ls0J9UQY/qGeRZWQdPlga7hmvzU3mjdTT+Fa1oW2Ulau68DyzZV4yIpI1qd5cXG8y0u/5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLdGPkQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLdGPkQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F021F00A3F;
	Tue, 11 Aug 2026 02:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786414554;
	bh=sWHmHOoyj3KTc9P4LKk/uvwdr8zoIzDLNDxvu9L5KsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLdGPkQI4JL/wgMMcSpcU0ujxRTlvp6iRaGEZ/3Eo5NGdqrEQ1yfg5iE4MMpgA/z5
	 b7yoYg4W/PwXsfTLzuYi+ZizgJZYHH3PUi75IA9dluIP7Y3MkaBW5WlnyOOydf7F5l
	 545oCWRFcDY0fyp+bmmTMGGf37Qq9Ct67fDu0/D3m3FQuEM+kNNZWwrUyOhzG5ZA1b
	 sNGeIdgunXERRngAyNbdQ1DmiXCYmA6Srxr1FE9j3I9hLU22fZZXJsCtc9tmRnr3n5
	 xpJ6w3Ex3RBnhMcWgTrM0cC3yPzhTYVderj5sUiJ2EUNq8oE9YLZZMwfx/9o9Nx4eJ
	 5qUkEZE9Tvdkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ata: libata-scsi: schedule deferred atapi command
Date: Mon, 10 Aug 2026 22:15:51 -0400
Message-ID: <20260811021551.113715-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811021551.113715-1-sashal@kernel.org>
References: <2026080550-emerald-confidant-d0ad@gregkh>
 <20260811021551.113715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit e7468b3f9b404ac7c1329ef07c146c3356dfbd01 ]

Modify atapi_qc_complete() to call ata_scsi_schedule_deferred_qc() to
ensure that any deferred queued command can execute. This is similar to
ata_scsi_qc_complete() function for regular ATA devices.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4caa8bb75560c..aa456c11ea054 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3002,6 +3002,7 @@ static void atapi_fixup_inquiry(struct scsi_cmnd *cmd)
 
 static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
@@ -3031,12 +3032,12 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
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
@@ -3044,6 +3045,9 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		atapi_fixup_inquiry(cmd);
 
 	ata_scsi_qc_done(qc, true, SAM_STAT_GOOD);
+
+schedule_deferred:
+	ata_scsi_schedule_deferred_qc(link);
 }
 /**
  *	atapi_xlat - Initialize PACKET taskfile
-- 
2.53.0

