Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293690;
	b=oKkQw7/ePZ6aJr8UUeCQtHCpK82uSTO7hk0vUbgLxp5ZboF7R8pE4KmLzWkogm0LJLaO
	 HmWLWVF/L4AZ3d69lHrfeEoQHJzE1XzvX65Do0mhWIcWMBR48zcyS8NfZvKYGFUEPhjwI
	 VUyrseIiLr3/Lvh6YhxkaEc7P1fWYka2tgC0i/ksvZMwNXjMgncLXkvm9Hv9o/nkBWZKx
	 eNCp7xhmalfXTjGn5dE00n7232nn1WjDd+ksKA77KdF8iBEstG8z4MTxtjhs4fp8wJ+x5
	 1a1Zas4wqXMBJtObkYyJgW5UNGVGqJdtjqfLu880ZTzuw6+QbTlnaeuTOQDPfQ53Xrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293690;
	h=DMARC-Filter:DKIM-Signature:To:Mime-Version:X-Lms-Return-Path:
	 Subject:X-Original-From:From:Content-Transfer-Encoding:Cc:Date:
	 Message-Id:X-Mailer:Content-Type;
	bh=Udri3NUNj6s1Pul0NrwZRQXTDB94EPtWXLDDQCFvQ+8=;
	b=d/iQdTDx4CEKtuX7IUebpBQNFU8ggp9ORsqEYgxSTHCPTVKf1jNbanAD2/qfCNsURfi4
	 UuYRGZ06mEdEzJbl/Gd1GsKswzn0Q76S6aNsEpgKMHco1wKQKVx7RgGRro5HolHV/9r8n
	 /1CjImzivPFWjw17D0VD+tqPObcN2S490cB3HQtgJZd1/w4Ta8b2o16NsiPLYd3LY4YLR
	 ibfwBF/la7y6DFN29TrfuegFK75fzCo5e5efUAf1uWWdEKANoNkdPTLMni4X/3b2p5NfT
	 KpZlIuqwvkNOYbK7o8Yp9hIHz2rFv/VjxIKEdV9FQTR0MeiYyvZKD5BVP1pmqA4wfpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b="SwOuEN/L";
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=SwOuEN/L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794293683; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Udri3NUNj6s1Pul0NrwZRQXTDB94EPtWXLDDQCFvQ+8=;
 b=SwOuEN/L58Kqix23fZDp7JouMZNK6leeQ5kYbYQKV2hiVO3qD+bWNhfkkDUWz/zkerDfAn
 8tg0aapWoadk19pvg7MQV5r7H5253XySqs85DgADI8BjB3oSfHkJKcZASh0ecmjpGo2+Pe
 ibOCdY9ZPPvaMWjM3cB0830umV8b2biFJzz2TPLKc/LJc4pMoVgbuTT5a22g72nncHfODi
 4+RxIfxxRb5D2pQDyXU+5U5Up1x9OtIeUhw37+R0zx2dGATDwXOBoZd9BT+EkYG7JaWWnu
 pBOYs+9IhRUUYHQDe/pqvRaiePNBb8YnYrCYoxe9S0/KeJ9PYjIYQNTkD8Ry9w==
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
X-Lms-Return-Path: <lba+26af2bfb1+4332f1+vger.kernel.org+zhaogongyi@bytedance.com>
Subject: [PATCH 5.15.y] ata: libata-scsi: reject data-in commands with a data-out buffer
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <cassel@kernel.org>, <dlemoal@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Tue, 10 Nov 2026 14:54:23 +0800
Message-Id: <20261110065423.46020-1-zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
index 7ec130c..2e69ccc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1766,6 +1766,18 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
@@ -1802,6 +1814,12 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
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
@@ -2629,6 +2647,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
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
