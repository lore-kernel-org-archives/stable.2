Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592086;
	b=G204X4CXd1DSVxs02tJqfr2zNHefcFzN5RYLdD/1iWu1665C3NWyxy2gn/RcJf6C2Pqi
	 u/sNYrL8pEjcJYKc6e+Z/Nn7+7HM/xqUt+CZE4I7hxy6vCjZBPhfU/sQqvOt/2G5yi5Pj
	 k6RdOYGbl1xZQ/sddCe2ejf3BUKbX02cERbY3AMHeaWeZ9Zi/bkYmAHescPZi+exN1DFx
	 3F8F64aM1FMFUTnVr1swOMgqhnDetf011dnaoDURO7ecNQMPM+JUQfTJ3J4Z0VNZbkj1l
	 3dLeXqxjYxJYLxBMfN2aD+al5UJBtQuNROIph9YO6xn1IkZSzpu1AUsJtb30zUfgbfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=UxAos6a8lt7m6kLZPUZliAQ2VNhadB0xpZbdvzr7aWo=;
	b=gF+euhvHS3lKozHWcGl0/Id6uXFrXtG3y+zjUk5A19aax9hAyKDnk5h89HpFQqIuAyb3
	 ajN2A5h83ObaFAgZNeDW64Wtm+sFjZDBFysW2ZpV6s78jHRkEwQ84Uid4xcxkvH2wQJj/
	 pFyEV6knNajlmqbyJrWBtI2sMIUVFYe0mlCC//DgVFgc6re8+MX2mb9w3Odk2524WdlTa
	 CucALagL/CxZspbCH/e+ljJoGsjogThXfCF1xqtYcQU3/WFAx17V/WTrjWl64kEQdpwiQ
	 WSrcUUyIXyEUN/l11GkzOzWKfwF3fPmeF0jAoU/EMMwGZ3TNLiD1F1/o2tiC+BVMIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=KLluE39z;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C70606ED84;
	Fri, 13 Nov 2026 17:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C70606ED84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=KLluE39z
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4VD1VGNz5BNS0;
	Sat, 14 Nov 2026 01:48:04 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592084;
	bh=Zg7cG0Fr7J5R3Fz6w33M2ez6e68CVrJIlkOKPGN908A=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=KLluE39zVSc/gtNCnNCIFsMVMFCQObK2sQ6O23DAsIv6TH4lVkAiAihSEa/X4gnjm
	 uhMBXLP6f8djrX8nwk5vUisMsJ8jS9rwydHpaDyaEbOrsvZ5lOh3Qn3QlWE2QyUtG0
	 e3zrh4/V4Z0koEPt64DRjL1Ly7XTZVdWbp2j7+XmP5Rbtl8NzjP1Z6fYW5wjrTa+3u
	 z9lLQo7wAKHAUOPi8RerXQ81LQDQR43fdQF/N/ikkUg00iilcsuZCT/uc1CydfcZ+E
	 LYhgpoIRifxbIiYsXrQVfqvPJQwfwrsO0fbMjKJx23VNmpUwoWfmkJ/85SY+CrnzdR
	 Snh2ux4EKaqKQ==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADHlwXw088136;
	Sat, 14 Nov 2026 01:47:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:48:01 +0800 (CST)
X-Zmail-TransId: 2af96af74d51470-083c3
X-Mailer: Zmail v1.0
Message-ID: <20261114014801031Y999WJfhmUrM7FRlZ-2Qf@zte.com.cn>
In-Reply-To: <20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn>
References: 20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn
Date: Sat, 14 Nov 2026 01:48:01 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDEvNF0gYXRhOiBsaWJhdGEtc2NzaTogcmVqZWN0IHJlc2VydmVkIGJpdHMgaW4gMzItYnl0ZSBwYXNzdGhydQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADHlwXw088136
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 01:48:04 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74D54.000/4jR4VD1VGNz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
including vendor-specific bits 7:6, but libata interprets bits 7:5 as
MULTIPLE_COUNT. This rejects non-multiple commands with those bits set
and can print spurious count mismatch warnings for multiple commands.
The reserved bits 7:5 of byte 10 are not checked.

Reject nonzero reserved bits in byte 10 with field pointer 10. Skip
the MULTIPLE_COUNT checks for the 32-byte form while retaining the
device multiple-mode check for READ/WRITE MULTIPLE commands. Also point
to byte 10 for invalid PROTOCOL. Keep the 12- and 16-byte count checks
unchanged.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v4 (Niklas Cassel and Damien Le Moal):
- Check byte 10 bits 7:5 and report fp=10. CONTROL byte 1 is not a
  MULTIPLE_COUNT field and its bits 7:6 are vendor specific.
- Skip the short-CDB MULTIPLE_COUNT check for ATA-32, retain support
  for READ/WRITE MULTIPLE, and correct the misleading comment.
- Split ata_dev_warn() after dev, as requested by Damien.
- Do not carry the v3 Reviewed-by tag across this behavioral change.

Changes in v3 (Damien Le Moal):
- Added a byte-1 bits 7:5 check with fp=1. This checked CONTROL
  instead of the reserved bits and is corrected in v4.
- Retained the short-CDB count and device multiple-mode checks.
- Updated the subject, description and CONTROL-byte test expectations.

Changes in v2 (Niklas Cassel):
- Skip the nonexistent MULTIPLE_COUNT field for the 32-byte CDB;
  preserve the device multiple-mode check and the short-CDB checks.
- Move the invalid-PROTOCOL field pointer fix here from patch 3.
- Regenerate with git format-patch; do not edit diff hunks or indexes.
- Do not carry the v1 Reviewed-by tag over the reworked code.

v3: https://lore.kernel.org/all/20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn/
v2: https://lore.kernel.org/all/20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn/
v1: https://lore.kernel.org/all/20261104220939917jqg8_alGN5sACGWq5M9D-@zte.com.cn/
Review: https://lore.kernel.org/all/avcujpOaXJPfjgxQ@ryzen/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiles
the translation and completion functions verbatim with SCSI/device
stubs. It crosses all 256 CONTROL values and all eight byte-10 high-bit
patterns for non-multiple and READ/WRITE MULTIPLE commands, checking
rejection with field pointer 10 and no CONTROL-based count warnings.
It also checks the device multiple-mode and 12-/16-byte count checks,
service actions, CK_COND and field pointers. Sense construction and
device access use stubs; this is not a kernel runtime test.

 drivers/ata/libata-scsi.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb03312793ca94d81d8061a16c66e786c4cf3..8d321197803a839d9586e9f1436d1fbe3f5383c6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3388,7 +3388,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 
 	tf->protocol = ata_scsi_map_proto(cdb[1 + cdb_offset]);
 	if (tf->protocol == ATA_PROT_UNKNOWN) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
 
@@ -3573,27 +3573,34 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 	}
 
-	/* sanity check for pio multi commands */
-	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
+	/* Sanity check for pio multi commands. */
+	if (cdb[0] == VARIABLE_LENGTH_CMD && (cdb[10] & 0xe0)) {
+		fp = 10;
+		goto invalid_fld;
+	}
+
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
+				ata_dev_warn(dev,
+					     "invalid multi_count %u ignored\n",
+					     multi_count);
+		}
 	}
 
 	/*
