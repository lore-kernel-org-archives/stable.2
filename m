Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187571;
	b=phq5oHV8Vaz707njLp7bHQGFRPsv6zesAhTZPEUDlORwTELWTeREO34waDMY6tuhMCL8
	 +mkUOyZb5WxF9mJSjfOb0HC87fkIepTlOkEW2Qe9EZX/7LpA3Qh9mdyR+hfUX/iI14YYq
	 6YP/jV2YvDbrfIJcZiviBU+IHaOt+dGZ5Z6BzQsNP/ieJfbPMX529LEQdYCvVeGTJNZf3
	 FDpXLKILdyB6S6/aaqKkFOTeAMGcsG9NMf6ekEp6p00qE9vqBHom4gqDBMdZl8M1dDE8x
	 jqX63FNWpwgap+kdeJfl1yQZgP/psipRjxUHfPbelLS0lWCKLUahW5Gg0Le5wVLgpwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187571;
	h=DMARC-Filter:DKIM-Signature:To:Cc:Date:Mime-Version:References:
	 X-Original-From:From:Content-Type:Subject:Message-Id:X-Mailer:
	 In-Reply-To:X-Lms-Return-Path:Content-Transfer-Encoding;
	bh=N8AoCKZvvK133MhCYQj3502MyrqrutxmSZ+xIyFehZg=;
	b=3kKZPINGkPAeQv3ouoN+vjSg9S+yaPs/aDhdI7ctUemriLdJNbpdM6v0VErWaolYYX4X
	 82z8ODqU/19/t9jRkmbmecZWkiBQZcqk8gFX2jhTeb+rEjp6zt0r+tF4ry7HrL9Wmawyo
	 8Um0+D6eaYkNY21QixopDEI3Q7cAWnFJm4vxxg/JpC6Eo7mthiklPZVuQ4pSLMd/ItrFH
	 WE7y+s07r1N7mpmvNVXx+lB1nlVnxaJXUqZjwEfsM8b2lXj3auL6UwJkWUKKyrqbv+Tkt
	 iOHJOlTTvC4Mk2OBKU7jiGcXtEHzUnjO2cA3ZeC+36upOHVb9wmrvpQhMlWOyAQR0uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=S4sijXbp;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E76606A320
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E76606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=S4sijXbp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793187564; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=N8AoCKZvvK133MhCYQj3502MyrqrutxmSZ+xIyFehZg=;
 b=S4sijXbpLGH7GkiCwJoSQnxQXYhxhUYwlvouJtkWPTMFB1XswAaCy0Lu4sQONm0G8Pb42g
 OHxgK06Wo32cD/DGWJ/o2tOvvBnmUnEnPLom3toy3mQ1XS3b43T1YATWV1QhBdV//EUS6C
 xksmSQ6EX0eVgjK4+pJgObuIdqinaIPJ62Vm1hz8EAxxucthvOEnQ+xZzsDMg1Z+qW7f4x
 ZRlC9l0xzS1RYAMSRZI69Z3tQnnR1VFT4tYe8a6kE8Y5nB7ap9GKf1BpH5WpsCM+6JwHoO
 uDPNMEzRajAtgfjTWZ0YYr1wa94xML4Kzpp5JowrQQFBvLry8PsBzAb+vYHk9Q==
To: "Damien Le Moal" <dlemoal@kernel.org>, 
	"Niklas Cassel" <cassel@kernel.org>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>, <stable@vger.kernel.org>
Date: Wed, 28 Oct 2026 19:39:03 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2] ata: libata-scsi: reject data-in commands with a data-out buffer
Message-Id: <20261028113903.19569-1-zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261027090809.94126-1-zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26ae1deeb+e964b8+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit

ata_scsi_rbuf_fill() copies simulated data-in replies to the SCSI
scatterlist without checking the request direction. SG_IO can supply a
data-in CDB with DMA_TO_DEVICE, in which case the pages may have been
pinned without write access. In the reported case, copying the reply
into the shared zero page caused a kernel page fault.

Translated commands can reach the same kind of mismatch. In particular,
the ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers rewrite
the receive buffer, including when the device aborts the command.
Checking the direction only in ata_scsi_rbuf_fill() leaves those paths
unprotected.

Reject DMA_TO_DEVICE requests in the simulated-command path. After
translation, reject a DMA_TO_DEVICE request whose ATA taskfile performs
a data-in transfer, before issuing it to the device. Return ILLEGAL
REQUEST / INVALID FIELD IN CDB for both cases.

The original reproducer panicked in ata_scsi_rbuf_fill() on all four
runs with the unpatched kernel. With this patch applied, it completed
without a crash. A diagnostic run confirmed CHECK CONDITION with
ILLEGAL REQUEST / INVALID FIELD IN CDB.

Built an x86_64 defconfig kernel from the current Linus tree and booted it
in QEMU with an ata_piix disk. Normal INQUIRY and READ(10) SG_IO requests
succeeded. Each command declared as SG_DXFER_TO_DEV returned CHECK
CONDITION with ILLEGAL REQUEST / INVALID FIELD IN CDB. No kernel
warnings or oopses appeared. ZBC IN and GET PHYSICAL ELEMENT STATUS
were checked by code inspection; the test disk does not support them.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance.com
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Changes since v1:
  - Rebase on Linus' tree and use INVALID_FIELD_IN_CDB with the current
    ata_scsi_set_sense() signature.
  - Reject mismatched translated data-in commands before issuing them,
    as suggested by Niklas Cassel.
  - Remove the deprecated Assisted-by trailer.

 drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb0331..a5170a36a 100644
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
+		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
+				   INVALID_FIELD_IN_CDB);
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
+		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
+				   INVALID_FIELD_IN_CDB);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-- 
2.39.5 (Apple Git-154)
