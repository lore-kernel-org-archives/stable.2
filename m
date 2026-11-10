Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293747;
	b=QD1BKvvAifIia7IwfDj9vA19eTl6PnfZOqPCI2qWf2IL2+R/2hXaHdL2O4+L9ZRL/yxy
	 hfmsjNe2Bn2AFnsVo9I1GWzXnieKGZVxKkHFpl59Rct+o5EeFdX8if+FnUoOboYXM11t6
	 rZEfcUhjZkwiw1NaakWeTRh6rQUeAMSgqJCODXlUxO1t2LfD3mvUdaeZzDJp614EXpyot
	 rZfjLZ0RlxzmkMQ9yN2R/YiISEv3oihe13mAUIfq2BwvcFJdPisfHKI3DgS0kJPivmeeu
	 PtgEpdJwNEs27XEB4xML8w+ukBhv+tAr+B6WyjVl7aoaYJfc5h1apNyN+T+q20YhWsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293747;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Mime-Version:To:Message-Id:
	 X-Lms-Return-Path:Content-Type:Date:X-Original-From:
	 Content-Transfer-Encoding:Cc:X-Mailer;
	bh=P4T6NmMmUM6KPHyzaKp4oM83fRxkXvSZQXBy0Eyihfo=;
	b=UYX/2wRPrXAkBGikQJDtlWB+NeLBCWuZE++CAEiGGm+PPsSBI0qPIompp/0KJcbTpeRm
	 UkNCumhZNHe02BB2/nIvuN+KuwXrh7qHph8Z8U9+RHLEylyUpZf4sCb+EKLlXUgyWZywL
	 k7YiC20BRHLf7Ewv4EWMZzhbhxY2R7xMfLW+GTOv6BLSapmna/y80FYlynzXU4SQlEeg1
	 dXYwPIkmJQ57FxDnDAMSNnrnscvv4qWLydp8T0wzV3w47upOfnUnefBdy/33WcOVLLIZR
	 6DBngKmORHaHGRAN/EYL5yGrzUu/Th4hL3wg+soTjlza/Fcud8EuELm+a0JST1HaVMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=gm0Reos9;
	arc=none smtp.remote-ip=209.127.230.111
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 511DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=gm0Reos9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794293741; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=P4T6NmMmUM6KPHyzaKp4oM83fRxkXvSZQXBy0Eyihfo=;
 b=gm0Reos9N8uWkQv0l6GvTZ4sFVjuuk7zovZLCokhZK7DwykuBFjIwLzXbOGZek+cjPyXIh
 d4eXT5SmKIefX77r1AqyLu7OU1bS2uXC1MrenKtDe4lOkYxg6W0ZkqVhglMsgAxZchhN1E
 yZpiiqNMQV/Ihq0x4v5AJXyr2rUjePKSkuyYhp9UQB6fkms9qnAyM1rZxTMDIGL1zYCibz
 Of8cCWMkqxKSxXXKZRdJq8r/StSB9apbq8uGC/ZeP0gieNODGGhJu5yg3SswgCFimQMnZa
 ShgIH8pZ+MsAwWzds5rftb9arp792sQjeu9iOz7fQr4m19qP92k+nn8KMX1q6w==
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH 6.12.y] ata: libata-scsi: reject data-in commands with a data-out buffer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
To: <stable@vger.kernel.org>
Message-Id: <20261110065522.46573-1-zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26af2bfeb+14a9cd+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 14:55:22 +0800
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <cassel@kernel.org>, <dlemoal@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)

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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261104130638.37882-1-zhaogongyi@bytedance.com
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 drivers/ata/libata-scsi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d4f6d82..6b6ac82 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1989,6 +1989,18 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
@@ -2020,6 +2032,12 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	unsigned long flags;
 	unsigned int len;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
@@ -3077,6 +3095,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
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
