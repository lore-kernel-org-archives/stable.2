Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293727;
	b=sM6Vz9ozY9P4tg3zH4nKN+kwVdgdPQUCSdHMm8UU3mfYRMbjBd/Pz0JRd5iGOeQMszyw
	 UtsYFWRyY1CWep8wA3P0ek9xjCOJrmEjulWwsp6u0yPhqiwL28HhThqefWNWIiym4uvOe
	 QHnNYgfvQB6lYPNJSt66kkEin4+EGsXbiUsAwoalPYAHsZjhLv73eCbWxfs5vq/t7FTOM
	 sMOE/Qyz1Kp/exxLhimixm+kKPJM1VnbwboVVFL7gTRgnRXFZMNpOzxLZYYYlJobZLJNo
	 U9pdrPC3WiPmh/IayWoMcGiSMdeypzvbvc5RuNxGt++NyNZWPo8TwhU7CdhVvBZFG1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293727;
	h=DMARC-Filter:DKIM-Signature:X-Lms-Return-Path:
	 Content-Transfer-Encoding:Message-Id:X-Mailer:Cc:From:Subject:
	 X-Original-From:To:Mime-Version:Content-Type:Date;
	bh=bAPR6xWOaXrdQZcHpY5giLacUwZLTgwdsMAnSbKH910=;
	b=ZPkt0bapKIu7Kw7d01jCcrHtdO4lrZTfwehnZjTBTxRUfOPRZ1iPGWyGsFtykAWawvvV
	 ZaODmobZF1JdsHDqUM/WChpT/9SqtdNouw8FFcOpbDIvmLK5Ghd/I/0QqOn7flPEyKDcF
	 ruYOCf++E1eqsrp6JDEgbrQbm9ML2qfkEqbrCtz4UJdSfu+qaX7+OrAK0/6OBiMQF7+iq
	 tDHQmLnyjG9cCSYK2fhpAuf9hFsCgSnw5at+Sz6/LI3UrnfBbYH56Uh9F9luDOGfTD8Yg
	 9n9HxZSwXIuAuKTzASRGyi0YdY8jo0Dhm8nwieXy2NPRK7dB0lE6pJy5n+hHpPlJDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=oiF4ZIdz;
	arc=none smtp.remote-ip=209.127.230.113
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C02606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=oiF4ZIdz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794293721; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bAPR6xWOaXrdQZcHpY5giLacUwZLTgwdsMAnSbKH910=;
 b=oiF4ZIdzHNihDxVAD5pkfIz9+6ODouI5ucX0W3s3V1rEt8tZFDETvoWHnV9a+BiR19JqJX
 aYshj9JcBrtcX1RvnLlyUEzOFnt0u8dWq/xkVM4p9Vwe/wZPR2qoaREv276NfgYwdOy90R
 czRrF7XzPkoshuNm/0Fql+3zzyWeCRaWGSY1UIMBwrUhrDK86Xvw23lduZ/yYzvy2C4dtr
 zx5eYFfnyO0Nx2kT71p/lUnVNs1nYwK74+0ZHqUEN7g2sNru1CpKFpuxvvrW4txHCe0PL0
 IAgxrpHQ4sBWRweK2OmAZGHGenpbaHzn2VXpI7Tv5VKtBzGi5lRsSUxLA8d9iQ==
X-Lms-Return-Path: <lba+26af2bfd8+96046c+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Message-Id: <20261110065503.46538-1-zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Cc: <cassel@kernel.org>, <dlemoal@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH 6.6.y] ata: libata-scsi: reject data-in commands with a data-out buffer
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 14:55:03 +0800

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
index 4b6b4ea..f8dd2d9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1836,6 +1836,18 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
@@ -1872,6 +1884,12 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
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
@@ -2747,6 +2765,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
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
