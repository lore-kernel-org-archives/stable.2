Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293716;
	b=QH8Gs6WQT7AYAZIf1XNh3ADbm3lJ2qG1XO63o0s3GZ/DeDmYtEPedJnPGMBxmUifpOB2
	 FH+h1Gx0GQoz7W2EiekaYEq0EqEGnRZ2aXUTw7+SznaJrBmgHsQ+KQLlBYmw8Hc+nO+Lg
	 sP2tj6cIb0PXfVkvlrWYHqgQWEw9+RS5JQX4VLXmyvYKd8fHqjD1Kykf9+aZ2C3TSqbbp
	 sYjPWIoXUCH5LwH3EiuSEL0D4vN3PzcEC4E3Nxnzgklm5qRPsaKLDYZwDDO8CFDy8cIoP
	 lmpU2NCLxkbaQ5kqeXIogWRwZsEgVPJA/DL8ldvdvkoWQooPvpO+KtiRTiZRq+o4QWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293716;
	h=DMARC-Filter:DKIM-Signature:To:Mime-Version:X-Lms-Return-Path:From:
	 Date:X-Original-From:Cc:Content-Transfer-Encoding:X-Mailer:Subject:
	 Message-Id:Content-Type;
	bh=W4Vv6xAH5fftGua5PU2aKr7s7xXExZ2LYx6GHi4wTmY=;
	b=lBSqEK2EnnCbGBumoO0AGrGS4SYLjWF91Ww24Ct8/eCovESxuvLL/1KxQ/HG2Oqe6+O9
	 I/ST/zyAsSF2AXXm3pVfDp3ACjrdiMiQ3KusTNcpnHTzfB+bg3Itb1ELeIXE79EXpbZwa
	 8Dzi8kewjjUv/Z0k4qw62LtqJF4TmwW7XKQpnuNnO2Q5w4KdxY/sKBuNswb88PsUPzjVb
	 Khb3cgZv8jQ7D50BOXIRG8q4EOBYlipfifGyGqXnkkKIOdd/Dng8oQuGe0JUyqY0QaAr9
	 JMHpL0GXv2R3OcIAu0Q51gdKUQylidztzv00Ul1e/iVlNTp6u2nC3z24AUatrMHYe3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=owIrI37z;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E404606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E404606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=owIrI37z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794293703; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=W4Vv6xAH5fftGua5PU2aKr7s7xXExZ2LYx6GHi4wTmY=;
 b=owIrI37zbKoYqbjXbt/t9Yl7Pcsi27bP2sEuRBE1PA0srSMv66PFbnXAE7uwLDoHXD8e7W
 8esmJIyRhilv7vIdq7uKQ83jq7FNPFVHC2WrIXR3tE53I713jQlKFzZXvzw/wPVAEYhA8S
 r6gNPW6g4eN427AaiAHW4w5dVV6ViYHjdpSKQWSTnKCRrBKjmJMyHP9yGRzI1Wyct+G5iy
 kfiIEdAk8sxwlA2vvvGHCPNNkvmNHXwZzUCSvj1BtMRp4pT7XZif3Zw1LiivCjDS7IdavO
 +Cr8SwLDWu8HfjQDy/ZZwoOrtj4nCnHY+o6IByIMlgPeo7Gtaqxfd3vq3cqFVA==
To: <stable@vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26af2bfc4+929a9f+vger.kernel.org+zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Tue, 10 Nov 2026 14:54:43 +0800
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: <cassel@kernel.org>, <dlemoal@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Subject: [PATCH 6.1.y] ata: libata-scsi: reject data-in commands with a data-out buffer
Message-Id: <20261110065443.46102-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8

[ Upstream commit a4845f077415ef32fe672c841e2fc58ae9e28273 ]

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

Backport notes: Use the older five-argument ata_scsi_set_sense()
interface and spell DATA IN BUFFER ERROR as ASC/ASCQ 0x4b/0x0a.
The older ata_scsi_rbuf_fill() takes struct ata_scsi_args;
get the device and command from args, and reject before copying.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261104130638.37882-1-zhaogongyi@bytedance.com
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 drivers/ata/libata-scsi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3a49511..e18a437 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1911,6 +1911,18 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		goto done;
+	}
+
 	return ata_scsi_qc_issue(ap, qc);
 
 done:
@@ -1947,6 +1959,12 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 	struct scsi_cmnd *cmd = args->cmd;
 	unsigned long flags;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(args->dev, cmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
@@ -2772,6 +2790,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 	qc->complete_fn = atapi_qc_complete;
 
+	/* atapi_fixup_inquiry() writes to the buffer on successful completion. */
+	if (scmd->sc_data_direction == DMA_TO_DEVICE &&
+	    scmd->cmnd[0] == INQUIRY) {
+		ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		return 1;
+	}
+
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
-- 
2.39.5 (Apple Git-154)
