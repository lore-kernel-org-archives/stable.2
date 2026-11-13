Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592599;
	b=xJ/SgxcDNFG456X7g1Ijlb4SzErzaHSSyHPv3plZ9p1onq/O+e8uAxxLzzHwisiL54/o
	 4J9SWXhrik4g+9TaDeXHV/eNNPXvJBmlyv0bCxulwZpQxJOy8l0a4vguLUHZ8jumK4FS1
	 zSNM/Nl4tNR59fExZXloQ3ahaK9l2k5NMF7uxnRfg4dfBeeS+50Wi1a+DVjdsQ+Gq/uZQ
	 d7v4309kQpJQhWaw8g3jmIqC98S2BNFqvA6nq2Z+7wzrtod6Ba6YTLkpealatBUQDRtHn
	 PofkOt2pf7MLTfrVW/rlxSgDvueXbM+pShcwA8DU9ffc3kQ+aN1tLxTPX28OUdVSU8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=luWOr6xS+R3vZ28ewZawhTBe+Y1Jl6ucuuH1WbWGmmA=;
	b=0cMt4v7ja/lhQzqH330BQsAvhr23RDOHHmsfpGIGaCao35XBnAHTsQqG2C4sOiKbKkN3
	 l7FBqfeZb7v1DyrnWSEm1UvdDvT+nj0oLFWyLzWIRZGRwZdbnzLoENxU6dwQxMNOA2vHf
	 QxC6swofTLNcEPwmI/IsFlGSG+edjb78u91qKDirqiKpR7MEVMZSOxKPpnd1UVKzsKOEb
	 mxwS2yQMHkxjyOer8lE91GQoPsEa5QSonzEt8rN59tOMNxtHxDqJKQEQsCD8OBnjyVfMc
	 YK+vQTdfRJE/0NEDHCSUSwn+M9wvFLSpSfGQJwmbzekXlVWD4rdwxe3e69/KkKS9Hiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=R2hWF5UP;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA3606B215;
	Fri, 13 Nov 2026 17:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCA3606B215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=R2hWF5UP
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4h522Drz8XrrX;
	Sat, 14 Nov 2026 01:56:37 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592597;
	bh=E78CL541WXooalmHbBNGVhXB1Hme7eTmT9e3QtsHgyE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=R2hWF5UPgGPmQE5lZ/7kLdG0rVcTneVdQCRxmxsB7vIPgcBMQzBLlz7Bk+YR+n1sj
	 15zfAGCWJh8mG5F2Gij6XKqwupGB9QdcvZ6U5e7vOMxWDd90iTezhNryKB64MJQwNi
	 blwY3ntR+LG7qNnwdssKjc85tYG6hm5GINWljE8HKU4qGaMAKC97xD6qIH9O5Z63DV
	 iyY7SnFZWsO2XexaLqo9Hy7Xd48lOH91DygAZ+HoFnS6d82nGRZz8UCKDd7C6rjsKW
	 28+wrdClWtiKu4pd4KuxMceADuA0Mbeq/zRlCAdeNbZxqcUadJPdpXzsAVgKUINyoJ
	 AqIWwZw5VNXNQ==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ADHuTMv067394;
	Sat, 14 Nov 2026 01:56:29 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:56:33 +0800 (CST)
X-Zmail-TransId: 2afc6af74f5139b-162e0
X-Mailer: Zmail v1.0
Message-ID: <20261114015633289UnNV4mqcLd9M7QXi1NBhp@zte.com.cn>
In-Reply-To: <20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn>
References: 20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn
Date: Sat, 14 Nov 2026 01:56:33 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCB2NCA0LzRdIGF0YTogbGliYXRhLXNjc2k6IGZpeCByZW1haW5pbmcgcGFzc3RocnUgZmllbGQgcG9pbnRlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADHuTMv067394
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 01:56:37 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74F55.000/4jR4h522Drz8XrrX

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Several error paths in ata_scsi_pass_thru() report field pointers for
the 12- or 16-byte CDB when rejecting a 32-byte CDB. Initiators then
receive INVALID FIELD IN CDB sense data pointing at an unrelated byte.
READ/WRITE LONG also reports PROTOCOL when its sector count is invalid.

Use the PROTOCOL offset and record the FEATURES, SECTOR COUNT and
COMMAND offsets for each CDB format. Report SECTOR COUNT separately
from PROTOCOL when validating READ/WRITE LONG.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v4:
- Code and commit message unchanged; retain Damien Le Moal's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261112220124003NT-esXu4g2qMJ-uOMc-4G@zte.com.cn/

Changes in v3:
- Code unchanged; retain the Damien Le Moal Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261111223133188VjHq0FbmnzuEZWakS-EYD@zte.com.cn/

Changes in v2 (Niklas Cassel):
- Add a separate patch for the remaining PROTOCOL, FEATURES, COMMAND
  and READ/WRITE LONG sector-count field pointers.
v1: https://lore.kernel.org/all/20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiled
the translation functions verbatim with SCSI/device stubs. The rejected
32-byte DMA/NCQ and READ/WRITE LONG protocols passed field pointer 10 to
the invalid-field helper, SET FEATURES passed 21, and TPM passed 25.
Invalid READ/WRITE LONG sector counts passed 4, 6 and 23 for 12-, 16-
and 32-byte CDBs. These are helper arguments observed in the harness.

 drivers/ata/libata-scsi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 374918eae53ef4cb082bccd903773f06e6c55fa1..a5947bd591df8905e6b06f9851f75a46954f2c22 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3383,6 +3383,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
 	u16 fp;
+	u8 feature_offset, nsect_offset, command_offset;
 	u16 cdb_offset = 0;
 
 	/* 7Fh variable length cmd means a ata pass-thru(32) */
@@ -3443,6 +3444,9 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		tf->lbah = cdb[12];
 		tf->device = cdb[13];
 		tf->command = cdb[14];
+		feature_offset = 4;
+		nsect_offset = 6;
+		command_offset = 14;
 		break;
 	case ATA_12:
 		/*
@@ -3457,6 +3461,9 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		tf->lbah = cdb[7];
 		tf->device = cdb[8];
 		tf->command = cdb[9];
+		feature_offset = 3;
+		nsect_offset = 4;
+		command_offset = 9;
 		break;
 	default:
 		/*
@@ -3482,6 +3489,9 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		tf->device = cdb[24];
 		tf->command = cdb[25];
 		tf->auxiliary = get_unaligned_be32(&cdb[28]);
+		feature_offset = 21;
+		nsect_offset = 23;
+		command_offset = 25;
 		break;
 	}
 
@@ -3499,8 +3509,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	case ATA_CMD_READ_LONG_ONCE:
 	case ATA_CMD_WRITE_LONG:
 	case ATA_CMD_WRITE_LONG_ONCE:
-		if (tf->protocol != ATA_PROT_PIO || tf->nsect != 1) {
-			fp = 1;
+		if (tf->protocol != ATA_PROT_PIO) {
+			fp = 1 + cdb_offset;
+			goto invalid_fld;
+		}
+		if (tf->nsect != 1) {
+			fp = nsect_offset;
 			goto invalid_fld;
 		}
 		qc->sect_size = scsi_bufflen(scmd);
@@ -3566,13 +3580,13 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 
 	/* We may not issue DMA commands if no DMA mode is set */
 	if (tf->protocol == ATA_PROT_DMA && !ata_dma_enabled(dev)) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
 
 	/* We may not issue NCQ commands to devices not supporting NCQ */
 	if (ata_is_ncq(tf->protocol) && !ata_ncq_enabled(dev)) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
 
@@ -3615,7 +3629,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 */
 	if (tf->command == ATA_CMD_SET_FEATURES &&
 	    tf->feature == SETFEATURES_XFER) {
-		fp = (cdb[0] == ATA_16) ? 4 : 3;
+		fp = feature_offset;
 		goto invalid_fld;
 	}
 
@@ -3635,7 +3649,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 * can turn off TC features of their system.
 	 */
 	if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm) {
-		fp = (cdb[0] == ATA_16) ? 14 : 9;
+		fp = command_offset;
 		goto invalid_fld;
 	}
 
-- 
2.27.0
