Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41593C5552;
	Thu,  2 Jul 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990011; cv=none; b=hXv53VrIwQXH6P+1r6FrpVICwe9m6eTpKR8JfgYrotW0LQb+CrhDaxlw7yoyiw69ZoPcqeHJwl31erX2x0LALPImAspoL5henboD2nvXKs0BP7quH7y+b5GTrD+G/B3NQI/F185lJOF4G+zNxqr5wdD1vUySchJeStmGy9PhuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990011; c=relaxed/simple;
	bh=L6oSNd7GV2jSHo+ihp6kJpgSCebZhaMLZbUN60878YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmSGZzG7X5o60Vt38j3gzrYutFR2hQFd7TIWU6gbE0ZCyYN3CjJZijwUarZK8pKGfTt+Y2IenAiXGiFmx9FnxnrovHFaciLYbodYgUKajdhf8D9iv+wDvf+AChPJtW19J7qxPOEiDkKGsjNG2Z82+Eed4yOEu6N2SkGSiZZu+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4saC8TG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4saC8TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E071F00A3A;
	Thu,  2 Jul 2026 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782990010;
	bh=7MolXIuFQCcEw6yux0O93RhUgjvcHpLOfWblU4nHW8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M4saC8TGyDNXTA7KlOHsOvkKlsAD8GBzg79vkpl/DWdjiQ9C7w64kdmfWICTyTHmH
	 9fLU6qs/pfhcGkwLbwuNWW04yxgGNV4GIjAW0rjVdhFfhEoreAoALkFndSUbb0bkjA
	 xjxlkI2LYmLEBrKoOsbHfDVJbFqjrjkRdBV+0y3SXsQmUcnAP4gwWMGleO4te/HJda
	 ZW6xY4xmf97O6vCWNszcEPiTiYZSN6zaatTpbq2PheTZoGvegkvDrLConTYI86Vhko
	 jELoleQycA5HVfB0rSunEKmYVPEBneww1nBkkeK6nFT7d6dhU8FiHb5wAfxdcnuv1q
	 pFNVUQk4j9tmQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
Date: Thu,  2 Jul 2026 12:59:58 +0200
Message-ID: <20260702105956.2058733-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702105956.2058733-4-cassel@kernel.org>
References: <20260702105956.2058733-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4442; i=cassel@kernel.org; h=from:subject; bh=L6oSNd7GV2jSHo+ihp6kJpgSCebZhaMLZbUN60878YM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLcXNb8ZVd4avNSMGLeiZCDpVtWs0Xur3DOydJ+vuZE8 EnmAy/iO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRlj6GP7zfFkZKV002XFkn t1i1s+thk+q39pdt+VWi3pWnJH/HlzIyXN3/2nxrrs77W084Hv371XOrMsnViPVxT2mCvpHvPts HfAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_write_same_xlat() translates a SCSI WRITE SAME command with the
UNMAP bit set into an ATA DATA SET MANAGEMENT TRIM command.  The TRIM
descriptor is built by ata_format_dsm_trim_descr() into the 2048-byte
ata_scsi_rbuf staging buffer, and the number of bytes copied is compared
against the logical sector size by the caller:

	size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
	if (size != len)		/* len == sdp->sector_size */
		goto invalid_param_len;

ata_format_dsm_trim_descr() clamps the copy length to ATA_SCSI_RBUF_SIZE
(2048).  On a device whose logical sector size exceeds that (e.g. a 4Kn
device, where sector_size == 4096) the function can never return more than
2048, while the caller expects it to return sector_size.  The comparison
therefore always fails, so every TRIM is rejected with "Parameter list
length error" and WARN_ON() splats on each attempt.  TRIM / discard is
thus completely broken on such devices.

The descriptor was incorrectly sized from the logical sector size.  A DSM
TRIM payload is a list of 512-byte pages, each holding up to
ATA_MAX_TRIM_RNUM (64) LBA Range Entries, and is independent of the logical
sector size.  The Block Limits VPD page already advertises a single such
page as the maximum WRITE SAME length (65535 * ATA_MAX_TRIM_RNUM logical
blocks), so the block layer never sends a request that needs more than one
page.

Emit exactly one 512-byte page, independent of the logical sector size,
and transfer only that page (COUNT == 1).  For a 512-byte-sector device
this is unchanged; devices with larger logical sectors now work instead of
failing every TRIM.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Fixes: ef2d7392c4ec ("libata: SCT Write Same / DSM Trim")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d54ec1631e9a..429b03a08071 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3447,17 +3447,13 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
 					u64 sector, u32 count)
 {
-	struct scsi_device *sdp = cmd->device;
-	size_t len = sdp->sector_size;
+	size_t len = ATA_SECT_SIZE;
 	size_t r;
 	__le64 *buf;
 	u32 i = 0;
 	unsigned long flags;
 
-	WARN_ON(len > ATA_SCSI_RBUF_SIZE);
-
-	if (len > ATA_SCSI_RBUF_SIZE)
-		len = ATA_SCSI_RBUF_SIZE;
+	BUILD_BUG_ON(ATA_SECT_SIZE > ATA_SCSI_RBUF_SIZE);
 
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 	buf = ((void *)ata_scsi_rbuf);
@@ -3492,13 +3488,11 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct scsi_cmnd *scmd = qc->scsicmd;
-	struct scsi_device *sdp = scmd->device;
-	size_t len = sdp->sector_size;
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
 	u64 block;
 	u32 n_block;
-	const u32 trmax = len >> 3;
+	const u32 trmax = ATA_MAX_TRIM_RNUM;
 	u32 size;
 	u16 fp;
 	u8 bp = 0xff;
@@ -3542,13 +3536,13 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param_len;
 
 	/*
-	 * size must match sector size in bytes
-	 * For DATA SET MANAGEMENT TRIM in ACS-2 nsect (aka count)
-	 * is defined as number of 512 byte blocks to be transferred.
+	 * The TRIM descriptor is a single 512-byte page, which is the maximum
+	 * WRITE SAME length advertised in the Block Limits VPD page. For DATA
+	 * SET MANAGEMENT TRIM the COUNT field (aka nsect) is the number of
+	 * 512-byte blocks to be transferred.
 	 */
-
 	size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
-	if (size != len)
+	if (size != ATA_SECT_SIZE)
 		goto invalid_param_len;
 
 	if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
@@ -3574,6 +3568,12 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		     ATA_TFLAG_WRITE;
 
 	ata_qc_set_pc_nbytes(qc);
+	/*
+	 * The DSM TRIM payload is a single 512-byte page, which may be smaller
+	 * than the WRITE SAME data-out buffer (one logical block); only
+	 * transfer that page so the length matches the COUNT field.
+	 */
+	qc->nbytes = size;
 
 	return 0;
 
-- 
2.55.0

