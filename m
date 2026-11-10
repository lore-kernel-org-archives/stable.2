Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273020;
	b=VC+5M0K7Q2X8LT/g+qwQDoPhyrsu5dK3BUK3KQvpAAD8BumrirYP2VaXRAtywDF43rCY
	 1xgXPt3ghX9ym8GZikVcCtSuHCGC8X6pHzHKQ8hlrl+jMZws/Ej8sIDHC9q+Zna71lhjy
	 nrRI2XaG0wcY1MlQzr2ECnCsl/pXq0BiVleKYIY61HXZ4AupbqdeyqqVK2/9xwQGyX3dG
	 Pewn9oDYCofVZwRpKzQphzf5JlUAVjaNVYB/tW1yTI1YCiJgzOnwgOTxPg5J/oAdJtF3U
	 5KupsbnN/ztg+vy6hpyfkTbffihHaqkVf5BWHk/17H7v9TO1DWl+OJ0he5nPNct19Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=risxY7N2mhub1pIbOtzhz9hwrCdtINi+9jPuahOMAeY=;
	b=pa6ynNrT6Si4vtZ6PU5vVFKN+ADuLWMexv0h1giBljkgVbQh5lJ3hHjejUY1r2IqO20X
	 CkG8QlaXtsBntT6cRx3F7DPe1hAydBNW8Umo/XZAjNoxpL1t7Uv58WQ2CNSvvkYk4wLXF
	 yYG9rBxJOqgpxxhcM9q1qwZ2Iddnq1pxd+w80XWEoGQdzrD5pzq90ME5LpTon10kk6SMz
	 xRcGl2TFmnD+rY9zzEW8Z4x4eMgvRPclLz2VBL+pKqB+qoQ+VLlnSvKqFbvKZ7GIIQB5t
	 mZs3IxsVGSdXSmjevNQOfK7if8i8zT2FpB9Rku/Lqd8liAUF+vbVvR/5GURP2dQjtvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+6Yq7eX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F018606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+6Yq7eX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3BC1F0089F;
	Tue, 10 Nov 2026 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273019;
	bh=risxY7N2mhub1pIbOtzhz9hwrCdtINi+9jPuahOMAeY=;
	h=From:To:Cc:Subject:Date;
	b=C+6Yq7eX3REnFLOXJ51do8GLD221cOx7QIqIS/OiDrgldJ6eDGuXnQJY+fW0XU4+7
	 TVrXwiWlQVrO2Qf87XjFG3yIvTukQC04YoEVK7aFjWNMuJ8NH+RvfZeg//Mu0yjLfD
	 zqK+BKPmOtKwkalXWOHybBo3cgQewkLOcpMHERJVlf7Fp/YOTX0laX3oue61W2K+Mf
	 2DyZDGV825KE2tA1Md9tBvK9SsfflBSnpiQk0SX5z3xjBiNs0tHLe+2kFGKwLFYoj0
	 9hF44NPN1QnHhkaYE1BZfmB5LCaYQQWmArMaPCP2aBM0hSZ6jFpo1OI2WH/mxjFKvp
	 5eLbqjzElilsQ==
From: Sasha Levin <sashal@kernel.org>
To: zhaogongyi@bytedance.com,
	cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libata-scsi: reject data-in commands with a data-out buffer" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:10:18 -0500
Message-ID: <20261109201018-failed-6.12-a4845f077415@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a4845f077415ef32fe672c841e2fc58ae9e28273
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201018-failed-6.12-a4845f077415@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a4845f077415ef32fe672c841e2fc58ae9e28273 Mon Sep 17 00:00:00 2001
From: Zhao Gongyi <zhaogongyi@bytedance.com>
Date: Wed, 4 Nov 2026 21:06:38 +0800
Subject: [PATCH] ata: libata-scsi: reject data-in commands with a data-out
 buffer

SG_IO can submit a data-in SCSI command with DMA_TO_DEVICE. The
scatterlist can then contain pages pinned without write access.
ata_scsi_rbuf_fill() writes simulated replies to that scatterlist;
in the reported case, the copy tried to write the shared zero page
and faulted in the kernel.

The same mismatch can affect SG_IO commands translated by libata.
ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers can modify
the receive buffer even if the drive aborts the command. For ATAPI,
the successful INQUIRY completion also rewrites the buffer in
atapi_fixup_inquiry().

Reject these mismatched commands before the buffer is written or the
command is issued. Report ABORTED COMMAND / DATA IN BUFFER ERROR because
the CDB itself can be valid; the supplied transfer direction is wrong.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance.com
Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20261104130638.37882-1-zhaogongyi@bytedance.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b1d5d822a9a20..87a57495d2e4b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2048,6 +2048,19 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto done;
 
+	/*
+	 * A data-out request may contain pages pinned without write access.
+	 * Reject a translated data-in command before issuing it, since its
+	 * completion handler may write to the buffer even if the device fails.
+	 */
+	if (unlikely(cmd->sc_data_direction == DMA_TO_DEVICE &&
+		     ata_is_data(qc->tf.protocol) &&
+		     !(qc->tf.flags & ATA_TFLAG_WRITE))) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		goto done;
+	}
+
 	return ata_scsi_qc_issue(ap, qc);
 
 done:
@@ -2079,6 +2092,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	unsigned long flags;
 	unsigned int len;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
@@ -3173,6 +3193,14 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 	qc->complete_fn = atapi_qc_complete;
 
+	/* atapi_fixup_inquiry() writes to the buffer on successful completion. */
+	if (scmd->sc_data_direction == DMA_TO_DEVICE &&
+	    scmd->cmnd[0] == INQUIRY) {
+		ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		return 1;
+	}
+
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
-- 
2.53.0




