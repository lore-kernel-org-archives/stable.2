Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519747DD62;
	Thu,  2 Jul 2026 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986689; cv=none; b=KS9bSOZ+zTOOckSpy+ilEMporMX4kWV83jtNPnJlRQU1T8ttbT0aoxJANIpBOn3a3GifYsvYI1ZapLwHAcmVSa+ZBrD+NMaiqlPrldMpzlSr8kuNk8vLogrpGcrNrPMVi2aui6uQDvClfr31TtBAoHs7+nRqzZ7f5qC4kxu20Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986689; c=relaxed/simple;
	bh=L6oSNd7GV2jSHo+ihp6kJpgSCebZhaMLZbUN60878YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nranW1GWdzQuV5jWqR9+RacVh2ZghOJhXlX2trVd3UYQipN9VNQlhtjExUlye3MorQnekAoUvZwZxT0rpoX3x9AJPe+3dPxGzHTV7WqPfSFnj2Uc7RpVfX2Z75Nf+AJqzktolLWahFdlr4oH3nsWH0pSFAgJuHFEV/vVB1kblCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxDuEocg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxDuEocg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1E1F000E9;
	Thu,  2 Jul 2026 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986687;
	bh=7MolXIuFQCcEw6yux0O93RhUgjvcHpLOfWblU4nHW8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxDuEocgJ3cV0esalapJsMfCJ/kiZWX9cVhDXlDGWQ0SR0vF6ws8LmpClIDUtyMh3
	 Ex9APq6eEKQSCPIqd2NyNB/TvV6tD1GUve4U9Rf5o4b/GM3DOWEr2SiAXahg55jANW
	 NnYgsm2zHWsZMkrWeL6Rn+Hr7ZEIuYywI3z7CXD/hwx79FuMvKHcHoRqkjMYDlVeyf
	 hyxQQw4yCbDsfhW2uUkfMgQr5ui8NvP9/JGddpaWPvTdfxPhNRdycMIdvG3I7BK+m9
	 CrL9QwCqJZwkZfesnncX1BIR5O9ctRNafvKK64cxS7PM2WFjzeXdWZZ+J4e1NpOi3z
	 7Qzo7iXrcAxDQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shaun Tancheff <shaun@tancheff.com>,
	Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 1/2] ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
Date: Thu,  2 Jul 2026 12:04:12 +0200
Message-ID: <20260702100410.2039383-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702100410.2039383-4-cassel@kernel.org>
References: <20260702100410.2039383-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4442; i=cassel@kernel.org; h=from:subject; bh=L6oSNd7GV2jSHo+ihp6kJpgSCebZhaMLZbUN60878YM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLczOf/ZVd4avNSMGLeiZCDpVtWs0Xur3DOydJ+vuZE8 EnmAy/iO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARPWuG/4FZ0a762o15b/7q rXiYurlwwi+ro4pPSjWLCuZM22aw+jDDX6nLTX7+CpPO3zGcbqP1+fnqVrdb4gfcdqT+nfal739 kPRcA
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

