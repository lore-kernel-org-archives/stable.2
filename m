Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B937F8A0
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410634; cv=none; b=ScrDCZD4IgWD3v8zEeeYFWqbB5XMmMkwnQKqEPUHI5XYbzZN+Ror8i8wTqw5ps6MnMkOerv56UYx5TPomeA/1i20MV+rR7RkQ11p2MmoznjSHDJpzzn5+qVjRAo5206eK5InCYH3VdanUgCMDJVZqPNF7bVhUFKb72Oww36XcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410634; c=relaxed/simple;
	bh=1E3rAPrnWv3Kha8PzY+gDbe5c/UwiK1N1QegC76sKm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8zhIgfaw71zERpWV92drohEAF14xIPDlZk1qA5rW+t+7qTIjr3geHoI7hVhVYYVbJfbebLsU33tGWKie+JI/uanSbYN5JRJF/wG/ixjklf06jc0kc8kUhaMB8YGeqTX/bDT6qz1+snsO+VDI4AlL73R3BkE3R518Z9Nn07szpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAfpMCbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAfpMCbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719C21F00A3A;
	Tue, 11 Aug 2026 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786410632;
	bh=3cCZSAyrJAbyVXfYI3UB6UpQaPTprYf6a0AIMlDhqAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GAfpMCbf93BReON+ofe8Y5iPsq5E94tIjYSGwfsVtRGjFvcn+j7CWmhUkXXxzAbU/
	 I4gKqSI7TxyEPN4wvPBSnKeejHBnlYbqW8VuRKN1N8mR9/m3ytV7jOA0+EtXw+n7pS
	 p+6sE0Hk7N9fj77SgoCXFI9/TEj2eQMaOsfVVMwMbpDzQSn1KI8m1JbbBKHLdRB7Zo
	 YL7rUqLW/kuuexGNXHz5+ErVMgQ22yAw8bDzEi0H/N+5cqcM/1cY9JcVn/iN6FqGPF
	 4FVJ5DBs8E2sJCQfLJagCQ50pEdGMOzy5FsKRJCpgLEoPhrEsCCf90+Gi5nsgm77gK
	 AL+8G1By9zSNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ata: libata-scsi: schedule deferred atapi command
Date: Mon, 10 Aug 2026 21:10:28 -0400
Message-ID: <20260811011028.3739187-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811011028.3739187-1-sashal@kernel.org>
References: <2026080550-flaring-quickstep-e60d@gregkh>
 <20260811011028.3739187-1-sashal@kernel.org>
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
index 0445d8e920769..b85e17c813644 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2990,6 +2990,7 @@ static void atapi_fixup_inquiry(struct scsi_cmnd *cmd)
 
 static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
@@ -3019,12 +3020,12 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
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
@@ -3032,6 +3033,9 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
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

