Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551A39021A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811059; cv=none; b=BTJykV8lvYZEdxojVQpjZ+Trn0hL6IjeuVsJCeTB4OAhmIHPlmERYcLUPyVfxudlUARGaRLezssq+mjmOJK2uVTqXULIlgAo3DsDwbW80bpkmzosaGathkjKMYUL6Jx7B9RrL4p98Y8u4OBweOEXFWYlDw0LB1dBxIysg+Cd9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811059; c=relaxed/simple;
	bh=Yc/E1ZueODyJzIu2jJLVO9r0MhaEVbLNog9RNKQrI3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeY0P2zgk0xoE5SXq9uTB30UMrC+1Db2m/P2fnht/tmHJgZ0wM8TjjQgxHRjgzui0D+1X0pdS702slbOUzWH19kW/1bJ7RHGSwn4PzLfGErJW5T0wOpGWJUWdt0KD0DUEVaXYehdsl/a3z91xZxddF4MIiIw1gR0iyazgatboVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bowrv7s1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bowrv7s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7236D1F0089B;
	Mon, 12 Oct 2026 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811058;
	bh=xM3d72cNv5eVNRqqhRTnbo/Px/MLX7fFnaG+bFWgRCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bowrv7s1YtgaG3cRsPOVXR3ptf15ZHb4Hx4D4iDqrWD+an2k7TS4/uN/FZqEzk2gb
	 OJDuwJDv/n1qIZUBR96VPMCcFP8WPMMbiKalPla+qFNNXmgDcW/Gl7fM0VqqvmxGVg
	 3jZ/zwe0P6A4OSKltwmyQp/kM/6ugYU3D/wFtrm/Tgcg3sLOy7WPIpTnXLfCAwNZgc
	 QdDJpPL6eOk3I6W501AH5r3ui6oLIC1huRw18SPgOEqkrrP+5GaWhZ1UmvPomOYFw9
	 cyjpEHea7OLQx8qmWB5jWqQZM4SPy5Cwb9IYFEl6Q57e1JM2dEcF24+e4ri28PZvfi
	 T4/AAu34F5sgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hengyu Liang <hengyul@cs.unc.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands
Date: Mon, 12 Oct 2026 09:17:36 -0400
Message-ID: <20261012131548.4072228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101213-giggly-chevy-f33f@gregkh>
References: <2026101213-giggly-chevy-f33f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

[ Upstream commit bc8ce2cea5f77c4bd1a5184705e300e83546c0c4 ]

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
[ sashal: Adjusted completion context to retain ata_qc_done() followed by return instead of ata_scsi_qc_done() and deferred scheduling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 14e68ca9784b7..c780a7f157389 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3018,8 +3018,14 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
 			qc->dev->sdev->locked = 0;
 
-		if (!cmd->result)
-			cmd->result = SAM_STAT_CHECK_CONDITION;
+		/*
+		 * Report CHECK CONDITION unless the command was terminated
+		 * with a host byte set. Only set the status byte, so that the
+		 * SCSI midlayer internal byte, which scsi_check_sense() may
+		 * have set from the sense data, is preserved.
+		 */
+		if (get_host_byte(cmd) == DID_OK)
+			set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
 		ata_qc_done(qc);
 		return;
 	}
-- 
2.53.0

