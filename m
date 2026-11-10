Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293767;
	b=evsboCpHK87QBzJ1TWjFFV1rHKX/zGIdgqdlCR/ub2hJn1WEXAfd9ah4/x9fs1YRp6lP
	 QOdR8cFtSwuM+5zOUFsTXBae5zzCFtwkerD6gzmWrH9EeGdBv8sGe7MND+P/yOLpda0EV
	 +shJEXRx9zZ9FwpuM86htEUezu9HFv0nGQt5AsEGyq+YkDhza5c4meyzBM7Lnn/Tx9UYx
	 OGa9QjPURdWGjb7cLMz2ArkhXqqUq0xVgBHUV2SsrCeTp8VTHtkZwbDpsD2Jx7RZnadmT
	 yV69ihhGlx65IEQkvY71QP2jCsCRgoKd94JFL0yvxMPykrv8N6Fl2w/dS1Vpla+BRMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293767;
	h=DMARC-Filter:DKIM-Signature:To:Cc:Date:From:X-Mailer:X-Original-From:
	 Subject:Message-Id:Content-Transfer-Encoding:Content-Type:
	 Mime-Version:X-Lms-Return-Path;
	bh=YdS7iUKm1Rlen3jLwOvTBC9s+zk2kucax3Pxu1vhOAA=;
	b=0mCW3bdljnXZ8KrDgCU3oLiq9xiaggpXvH8i182cEHP4yubsj4h22/04eSYQO1rM/4zZ
	 RA8Tt23TWzi73IbXtKO8yg7qB9JEdooKJKf+Wpxs5/53ev6ZxrJ0iy6WN/ixG2DhmE3KT
	 +MgqcjKP3RYTwFQ5iEAXo+ljNo9+nhhy/f+eKaaJPxKFLxMO1/1DmI89daQX1KJSnGIeg
	 l47BNs2YlvOhwJoBjvPYfsgCT9Hw7F+LIHW8ArXDK4lKnaElkrtnzjAJ0WzG3HKVuz9MI
	 GuvkkPFvmPsWWgkHiHx0aUnPiG4WmmIxfpOI1DrSnRj5tHkLcg7ibMUHpafbqpe0s0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=UjFj4lBu;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0010B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=UjFj4lBu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794293761; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YdS7iUKm1Rlen3jLwOvTBC9s+zk2kucax3Pxu1vhOAA=;
 b=UjFj4lBulSoa0oNQRjwmG2pBvwCmrIr00gdMEGUBww+luMy36lBzMnm7jZwR8RIMuCiF27
 2ogsYLV/tTkvQSRZ7hq64XM1yAIJLSqlu+DczaH+rweqDWQjYDZxNMVI1fjhtEoeFWosZf
 z6AZdpA7OM2uIphjzOZ+VXNxRZpQ6cVITtJf7fF3wzMx2sqXZEvi4NAct0hjvDONAshC6n
 h/QBKhvukDFEPIpbq2FiUKfhpE2Wlm51HcpyFNjJ6lSiRgVrsn/w/zjgHfNijL/o/V1Vm0
 cAbYY1EpWPAhgnSe6qHsU13+hwlVRXv4U2g5EVvShyRiAMpJLH2o+lZDyNZGYQ==
To: <stable@vger.kernel.org>
Cc: <cassel@kernel.org>, <dlemoal@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Tue, 10 Nov 2026 14:55:41 +0800
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Subject: [PATCH 6.18.y] ata: libata-scsi: reject data-in commands with a data-out buffer
Message-Id: <20261110065541.46631-1-zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26af2bfff+2b7644+vger.kernel.org+zhaogongyi@bytedance.com>

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
index c780a7f..95944ff 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1977,6 +1977,18 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
@@ -2008,6 +2020,12 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
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
@@ -3065,6 +3083,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
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
