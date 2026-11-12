Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492089;
	b=vx9PEQ/2g5JeoZqIGC+OAN7me49BlCxrAIzUfly8U8G0ptAdQyn3TyRFtp9TJiI4cAHN
	 znj/An2/+12k7jGj3NErnTQctF9B+LdFAiXnKh6V/Nd2dzm6/MRVSkG6JuP6NEVhUMQHk
	 HcHlhYl96I7XDZDyiKd9luNCAYfHPeKbklHl7WSHhQMq8YkbndSiCVjbugOxPvtt+mk6x
	 tTVwU5Q8WbANxoBtkt3Ka/QAvCWz/23+XSwvBHqDOQ0XbN4grzW1abYpjF7nk0UyrJHU9
	 7+uq8NJZ+3vLJ0R9ynkFGGHHISnRHLwlEGJs1RnbkZq/JJTvCyXBN6gLpV3LLNim0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492089;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=qSrrxlXSrvDW1CQp8qkLH5sycAw35jCLbIKk24p0C9E=;
	b=e+GP5cXYWbRHV0jbi8MqhkVdbMxH4XHtRKH2jgZVeb0k4IyIiLOA6kSVIm9IQunQHMPV
	 YghJbcfOjr5Mg+TCXL5eDogA7+LevCbij1i+LrBbTgu7RgC46CLe03ZOkXELQ30vpuP4F
	 uCYVztk67GJmWWGVom6lLmo+DLJ0hSEgpp5oRjKEzjCmJ4c++M7Y5f9u6yU04DwRfE1hL
	 wV0xiXnNQz2IMO8nGgFfvq5Ye51pyL2OgsdNPzVW2CyvtA10TvqcCbIjCpVGnYbUje/C4
	 DcahLwz40d+T6PEkJVDOFHeu2Z4YS0XQ2TvZJg9OlQdTj3qmezlbeQuWgN2traZaoeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Fkciihrv;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344960A5BD7;
	Thu, 12 Nov 2026 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9344960A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Fkciihrv
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMWC15kQz8XrrM;
	Thu, 12 Nov 2026 22:01:27 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492087;
	bh=9Kon7OtLP1/pYdGeNko2YWUcoBpKki3aQ1pnmPC37DI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Fkciihrvo/GuHkhLd12h013O7MAibcfyai9XW55MnVCvDjNm7VFJoX9v3ECUiGdQZ
	 RVt7uN6syUcvcv9llVXf5i539ml7O5x/+9NgHnKI8ETH43pgxldHVthYKp71KHPgC1
	 5TTevOI0QYXIW90lH+JhZ9V4e5C171oje8AoinJ2C0ABjTs0wEW0pFjLR6qqWcjKv7
	 Zw/dpXD4VV1fUeMqZ3vLkMtKx3u+Whfh/U6oUVpDmipRR+dIHRMbiezi1oWm6gIXZo
	 8c5+V3y7J2NythSkztqosoVIekXxDiiHCKlgk3jNrzSJeBGH/NUHyxSfVlCMAJVB67
	 wYX+wYWlUhqjg==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ACE1GuG045392;
	Thu, 12 Nov 2026 22:01:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:20 +0800 (CST)
X-Zmail-TransId: 2afb6af5c6b0b24-d52a2
X-Mailer: Zmail v1.0
Message-ID: <20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn>
In-Reply-To: <20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn>
References: 20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn
Date: Thu, 12 Nov 2026 22:01:20 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDEvNF0gYXRhOiBsaWJhdGEtc2NzaTogcmVqZWN0IHJlc2VydmVkIGJpdHMgaW4gMzItYnl0ZSBwYXNzdGhydQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ACE1GuG045392
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 22:01:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6B7.000/4jQMWC15kQz8XrrM

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
and bits 7:5 are reserved or obsolete. Interpreting these bits as a
multiple count can issue spurious count mismatch warnings for multiple
commands instead of rejecting the invalid CDB.

Reject nonzero byte 1 bits 7:5 with field pointer 1. Skip the CDB count
comparison for the 32-byte form while retaining the device multiple-mode
check. Also point to byte 10 for invalid PROTOCOL. The 12- and 16-byte
MULTIPLE_COUNT checks remain unchanged.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v3 (Damien Le Moal):
- Reject nonzero reserved/obsolete bits 7:5 of byte 1 with fp=1.
- Retain the short-CDB count and device multiple-mode checks.
- Update the subject, description and CONTROL-byte test expectations.
v2: https://lore.kernel.org/all/20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiles
ata_scsi_pass_thru() verbatim with SCSI/device stubs. All 256 CONTROL
values are checked for both non-multiple and multiple commands. Nonzero
bits 7:5 are rejected with field pointer 1; values with those bits clear
are accepted without count warnings. The device multiple-mode check and
12-/16-byte count checks still pass. Field pointers are observed helper
arguments; sense construction and device access use stubs.

 drivers/ata/libata-scsi.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb03312793ca94d81d8061a16c66e786c4cf3..0bc147cf4c0fa50c7d5b84029b7fb1a548c6f1a3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3388,7 +3388,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 
 	tf->protocol = ata_scsi_map_proto(cdb[1 + cdb_offset]);
 	if (tf->protocol == ATA_PROT_UNKNOWN) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
 
@@ -3573,27 +3573,32 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 	}
 
-	/* sanity check for pio multi commands */
+	/* Sanity check for pio multi commands (not supported with ATA 32). */
+	if (cdb[0] == VARIABLE_LENGTH_CMD && (cdb[1] & 0xe0)) {
+		fp = 1;
+		goto invalid_fld;
+	}
+
 	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
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
