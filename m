Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407504;
	b=J+cYaIimGXgN4KuYWVxBR5TPaEmP5Wwx0B928WUHHopmhGCHXMyl2nG+oIcapyVi/4fn
	 dqEtf3i2vibfhWOTKHtE9rNHWi+VPQa/x+jlMTCrpnd+pYdBL0vSkrFF3RH4fzfVS926o
	 72GAB8vYv+zoyiiPxVe568vq1nP/QE4k4ryI3FEp6T3uhGEOKCkNIKpIEJTXgcyUQDinc
	 nEm29gq72imrCQeiYdBj8PnaoUYHVOOHVSfQhx4x93eh5U68sd9JXfjY8P3YXctarVg74
	 Deb1N+Dz5ZdtEvkao7pFTe+PR2VcM2jNqCCFAU9vX/k8itcw2Ke/tBsCaeMjqB0Ab9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407504;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=AfMlI3WfPqq8tKJdmFujBWQddYXZnTduVJGezxZ066c=;
	b=D7FVU/+zy3siFa4i4gvRYojn3oGTkKJpdQCh9YbCpDF/6rDSf1hAnzW0bzFMqzZdJgM9
	 wyPwWdfdJMQJxsPoPP4MBhyLwlHwWZQn4BqPBDstTP7fH+Ylvy/QT7vHzYpGJ//ZYp6ZZ
	 4fUkwIfMnmWco7zn2iDAQSV6qmShh0qFb9K1oOR429fmTtevpiyivr+QkhAh1LPdxXwji
	 meyetHGTV6qhH+pEr9meKhRsHELUsML+Klll6pMiXwEKjEXJpDu/vUFpaL/4bzSmbTTRa
	 hlf5nk4fmmEmY6ZP9KUlfqw33I3qKBETatUNHD9AJTxWJ7t+5VpyaaVvaK3aBQ6SSZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="cn2S/T3B";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9360A3806;
	Wed, 11 Nov 2026 14:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B9360A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=cn2S/T3B
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmDZ29dTz4yjjH;
	Wed, 11 Nov 2026 22:31:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794407502;
	bh=azTcS144VCtm1cmX8Y0OcBHPAttJzVsHThFAhZvd3uQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=cn2S/T3B6G0jADeZddXaIFRdZqpwX5Hmn8m+OR92UBT2mytcFKHRfTcssJ+3PDy7w
	 nNd6Z8g10lUn2EK0ysPkEyQ4uEXKg9kLX2YijnMEZxQwPkstzxLDd2qF4JJLMTjuXs
	 /6m2Q79RwemCkZ+1al1odKaX+n1arWBvtVKcpoqZYmx1MXu4W8xPqUf4GsGiMLoJ1O
	 kh9sbs0kMa7cUR8pjBcE+NAf30NGBypeXvs7ZJw+11eAOdKJrUMb56U1S+893DW4Oz
	 uEcH+QO1bPGZZ9uVsweHobvCbmiA/6S0RAVCoqImQscYEN0E1IrpbmCCBDsEEiXh7H
	 t92jqwRcilSsA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ABEVR3m089035;
	Wed, 11 Nov 2026 22:31:27 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:31:29 +0800 (CST)
X-Zmail-TransId: 2afc6af47c41ad9-519d4
X-Mailer: Zmail v1.0
Message-ID: <20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn>
In-Reply-To: <20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn>
References: 20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn
Date: Wed, 11 Nov 2026 22:31:29 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvNF0gYXRhOiBsaWJhdGEtc2NzaTogc2tpcCBNVUxUSVBMRV9DT1VOVCBmb3IgMzItYnl0ZSBwYXNzdGhydQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEVR3m089035
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:31:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47C4E.000/4jPmDZ29dTz4yjjH

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Reading byte 1 as
that field instead interprets the variable-length CDB CONTROL byte,
which can reject a non-multiple command or cause a spurious count
mismatch warning for READ/WRITE MULTIPLE.

Skip the CDB count checks for the 32-byte form while retaining the
check that multiple mode is enabled on the device. Also report byte 10
for an invalid PROTOCOL, where that field resides in a 32-byte CDB.
The 12- and 16-byte MULTIPLE_COUNT checks remain unchanged.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2 (Niklas Cassel):
- Skip the nonexistent MULTIPLE_COUNT field for the 32-byte CDB;
  preserve the device multiple-mode check and the short-CDB checks.
- Move the invalid-PROTOCOL field pointer fix here from patch 3.
- Regenerate with git format-patch; do not edit diff hunks or indexes.
- Do not carry the v1 Reviewed-by tag over the reworked code.
v1: https://lore.kernel.org/all/20261104220939917jqg8_alGN5sACGWq5M9D-@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiled
ata_scsi_pass_thru() verbatim with SCSI/device stubs. An invalid PROTOCOL
in a 32-byte CDB passed field pointer 1 to the invalid-field helper before
the fix and 10 afterwards. CONTROL-byte variations no longer caused
false rejection or multiple-count warnings. A device with multiple mode
disabled still rejected READ/WRITE MULTIPLE; short-CDB checks were kept.

 drivers/ata/libata-scsi.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb03312793ca94d81d8061a16c66e786c4cf3..227240514651ada8b5feb87a154833fb2cddf064 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3388,7 +3388,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 
 	tf->protocol = ata_scsi_map_proto(cdb[1 + cdb_offset]);
 	if (tf->protocol == ATA_PROT_UNKNOWN) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
 
@@ -3573,27 +3573,28 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 	}
 
-	/* sanity check for pio multi commands */
-	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
+	/* The 32-byte CDB has no MULTIPLE_COUNT field. */
+	if (cdb[0] != VARIABLE_LENGTH_CMD &&
+	    (cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
 		fp = 1;
 		goto invalid_fld;
 	}
 
 	if (is_multi_taskfile(tf)) {
-		unsigned int multi_count = 1 << (cdb[1] >> 5);
-
 		if (!dev->multi_count) {
 			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
 					   NO_ADDITIONAL_SENSE_INFORMATION);
 			return 1;
 		}
 
-		/* compare the passed through multi_count
-		 * with the cached multi_count of libata
-		 */
-		if (multi_count != dev->multi_count)
-			ata_dev_warn(dev, "invalid multi_count %u ignored\n",
-				     multi_count);
+		if (cdb[0] != VARIABLE_LENGTH_CMD) {
+			unsigned int multi_count = 1 << (cdb[1] >> 5);
+
+			/* Compare with the cached multiple count of libata. */
+			if (multi_count != dev->multi_count)
+				ata_dev_warn(dev, "invalid multi_count %u ignored\n",
+					     multi_count);
+		}
 	}
 
 	/*
