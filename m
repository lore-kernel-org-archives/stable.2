Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492093;
	b=zU+p6cW66xBNcQm0E7R8+8RDCzEtrn0MsIftMQN07lIjg98h21TTu2viZegNf34WxC8s
	 7woGGCbIiX953gHKNM4wMBYnNZERz0SBXkf63D/tcJ9a/ca+ukcaX/b9ZRBUv3LNnnMJd
	 LKWmIPA/mOGmeXtCtm32Xm4wYW23OuiYDw6X7MxuQeoPsp09irork4y7DjKZnot0E8BGD
	 oq+NJtCkcyP16nKOzOyAHU63hwWDU2Rf3LHiLW9a0AVMJuSus40zVWOXrgv/6YA3Rv/IR
	 /tLS7Uydmk2KGquJrGhHvLamTorEoc++4ao7t6eZ+vE9qu/auHwOS88qFsalOIZ7cYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=pF4NYlRN1WELFGOqeaTpMGyTHMxjmieF05rdlgeoI5c=;
	b=xUYRWc3NdXXvjafak48QeO+UNo8792e8ztGB1q1nok9nUmKu7bwr9IOlCWfjvf4UpyHP
	 qAy/pK3HPX3t/ZobmUir675IaPxTl+lYU+L18WVhEC1Q2KgQN7NNnWZ8yRWN1ugMTGZYy
	 rdKnXcrTgXt62HWhmWsf0K3rt4cDaDi9TtQfMcO+p5TrEBjvQKIjU2u3JkKC9OlLAvkiW
	 xcvEDZurZmlG4O7aqYkFJN4Nf+n8HRVIMIbBHh86KvELXrU9O+Owwnh1FAfZgeyg/MTMP
	 BP9ooZJrR90TGzEX2pwUCxuVXid+EIoN+kcPzFaq68yHK+wXssji0YwIUUCF1ymxG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=XfFgaM58;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF960A5BFD;
	Thu, 12 Nov 2026 14:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFF960A5BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=XfFgaM58
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMW85kJGz58fdK;
	Thu, 12 Nov 2026 22:01:24 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492084;
	bh=J0jbSpKN8GiPo+JN8vOl9OapQjjEMrcfqSlMKhSszY0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=XfFgaM58D7/tO5HcJyn+czudkEL13+dBN6fX0EordD4oj+6aDohYDFIhb/3Ruf2eA
	 pCNFP6LjxQrfMxm0WqV78dwkEKpsTWFxvYeVT8lUYY9D/kwCpA9kE8jUemAqhmIkiD
	 65W87w4qm6OUOQy2v0QwR5A77tWC38rnIbJbqUnAT8eITkc5gGWTrJpqsAphOv+nG+
	 fhszF49xYzBUE0cjD//C3/gTE1r5XUmoHgaMXW5ROVSRhbUgbOe+VDxKr/+S3Q/VSS
	 N7uHc4c4W+mKhclMpKiPEsk6P/Vc6al8Ce4dZ3LeA1WZMVBI5s604G+3KV3h4gy8kj
	 E4ILAbVPjeK1Q==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6ACE1KQD036985;
	Thu, 12 Nov 2026 22:01:20 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:24 +0800 (CST)
X-Zmail-TransId: 2af96af5c6b45aa-cfd2d
X-Mailer: Zmail v1.0
Message-ID: <20261112220124003NT-esXu4g2qMJ-uOMc-4G@zte.com.cn>
In-Reply-To: <20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn>
References: 20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn
Date: Thu, 12 Nov 2026 22:01:24 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDQvNF0gYXRhOiBsaWJhdGEtc2NzaTogZml4IHJlbWFpbmluZyBwYXNzdGhydSBmaWVsZCBwb2ludGVycw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACE1KQD036985
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:01:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6B4.001/4jQMW85kJGz58fdK

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
index 8ee68937e884369beb4d7ad218612d28c5a080ff..c59e6567a108bbb353c08e921228eadbd231da63 100644
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
 
@@ -3613,7 +3627,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 */
 	if (tf->command == ATA_CMD_SET_FEATURES &&
 	    tf->feature == SETFEATURES_XFER) {
-		fp = (cdb[0] == ATA_16) ? 4 : 3;
+		fp = feature_offset;
 		goto invalid_fld;
 	}
 
@@ -3633,7 +3647,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 * can turn off TC features of their system.
 	 */
 	if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm) {
-		fp = (cdb[0] == ATA_16) ? 14 : 9;
+		fp = command_offset;
 		goto invalid_fld;
 	}
