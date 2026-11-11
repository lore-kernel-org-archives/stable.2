Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407507;
	b=Q2xI+dKs0TbQGzJIctl/iQLGf4Bdr611l349kAwtS8saOSxsqlNoMxAv34wEd5ASH9AN
	 LMb7UM1TThQR+gXmny2jrk6g8hdZbXfVkn14xvUaZ0cZ4xd81vvjpGlIp5xYo5z+CnRg2
	 FskcgcuGAFp1aieg6giytVTCpivRTCWmfkTb/J30XjYb+Egi7aKdasfjCZVYN8XhOO25B
	 SQKaQlw0A3VgUgyqyd3TsPlvpuNou9snwIexHiC5sVGblYXS6iMLJIKb5TqkA3ZtSNDrA
	 Go8ngKdH6mXOQ9BYkjRbWHRWa1oI+XmwFAHOdFRjWOr3mK6da6+ayoeJU1mCOYAE9Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407507;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=PBtKdIxwq4rIEZb17LLphjD6mE33r01sxM7o1nqk0NQ=;
	b=R/+8oL4qc/K+XZv7qtkTfI04FrCFMnckwr6BjWSwwyu5P2qrn55WLixBIly7+9yXpt4t
	 Fq6uWi+yHbwge/amwLYlWFj5eH1G3Ac/6PsH7GdcL+fLEeW3qIs26frHoxr3o1SBiXlgT
	 xWBRFCDsRjfRQY+dS6OgGOjN9PzvF97EJ7fQfLmenSg5VfYoh3YYpBws1TQvRYrGeg53J
	 sxNV6DlwwZJ829U0sNvhk5x0vm6d5cijXAN7uqOwNsyN/+xw4UjdGAutDUsodOS8+DFLY
	 AxCVjDDR92Iz3cGjvAcWCgoax606GRrK8zp6yyDVNT0nsfNMFMRf8l/OFuQDKj/trCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=xGBQkzOy;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E260A5BCF;
	Wed, 11 Nov 2026 14:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B4E260A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=xGBQkzOy
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmDd4ZgNz5BNRx;
	Wed, 11 Nov 2026 22:31:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794407505;
	bh=oBYcgWpLFWuaMipkGAF9+PgF9UGEluHWTZ4iLzdNLEI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=xGBQkzOym3og+F6wjDl+DzAvqN5qiryPWyYkGpnnX4Ie7DIIlHPl8Emp/BTBVLhyM
	 pzqpfVyqrdAcG4wq22fOJMbHIYjpPe8DLlb7ztJM/EzlIFRriIhkH68FB0Drnskt60
	 rt9Vr37wB6/yZw8RzZr3nbTzUvbNqyqn42Bk/8/c1TvLlRSt+D/Kn+yn1i5r9jD/6h
	 XkYZkdGCrlu1T3/yIkt1nwDVYHDAB22u/k1Xy4Ghm0PSDfYXg2BhFxOfh/C1teRKmX
	 W5K+fQ8JCouGff+8F6vcUpIocgIarv0BEWyuiizXHpYmPzO1eBfvEm3MTtsr6+LZ68
	 Smz+mqsBPdxDA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6ABEVVGl089040;
	Wed, 11 Nov 2026 22:31:31 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:31:33 +0800 (CST)
X-Zmail-TransId: 2af96af47c45de8-4ece6
X-Mailer: Zmail v1.0
Message-ID: <20261111223133188VjHq0FbmnzuEZWakS-EYD@zte.com.cn>
In-Reply-To: <20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn>
References: 20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn
Date: Wed, 11 Nov 2026 22:31:33 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDQvNF0gYXRhOiBsaWJhdGEtc2NzaTogZml4IHJlbWFpbmluZyBwYXNzdGhydSBmaWVsZCBwb2ludGVycw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEVVGl089040
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:31:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47C51.000/4jPmDd4ZgNz5BNRx

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
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
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
index 645899c2625424c7e305c7a2d426cdcc217dde43..a74527b4e12c73b8694104c9f9db58a5b2d43667 100644
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
 
@@ -3609,7 +3623,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 */
 	if (tf->command == ATA_CMD_SET_FEATURES &&
 	    tf->feature == SETFEATURES_XFER) {
-		fp = (cdb[0] == ATA_16) ? 4 : 3;
+		fp = feature_offset;
 		goto invalid_fld;
 	}
 
@@ -3629,7 +3643,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 * can turn off TC features of their system.
 	 */
 	if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm) {
-		fp = (cdb[0] == ATA_16) ? 14 : 9;
+		fp = command_offset;
 		goto invalid_fld;
 	}
