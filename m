Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407502;
	b=Fr/vs571exKUeSHF14PwCY0SYU10j4gdCV1bP2pFKL7FK2cKXCht+O7ILAurQv7dyjLT
	 V7+PFPt26inrL/dxusRzcihUf3bIkmfC5WstPa5xh5H+orSNxLcOsOC+3Xp91uKRHpvXY
	 5RKbZSvmzhcDusB2KQ2RAfOyynAQv6M/2H8AWq/BjDbDrPmVyX4kun+tV1gU5YrvAQP1b
	 ubqR8+QlZC4+3gUWngCgTFpL1U0a7XiYLmkRDpVAdDN45CSgVbMnwQhJQBk0aEWVnVBf4
	 b2xx7d4APDueCh/GZinxGdfF+pofN64smvKr9tkUpUqOtlz81pD0XuCD6Op+/spbsGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407502;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Ku6PvA8anI4VizW9ORSubjedAc9yhlNyiGfPL92kmpQ=;
	b=29+g0QWF3rimBzsKiHQt+25wZqz9DcJc5rBavhs5chf2sCL9OxJR+d35bE+7ENXheglD
	 tg6Zsa2+/+Vsh4D3cTN4CRP5/rgIfXRyIzVZZgFx0z6vDcNfc8ZZmTtmFQnTB9CZz7wWn
	 jIcqwMFgX86GMfk/6aKQVvbUEMq4fXChIxqmeHkLJJRsaTYSP4QrL09b39egEaMwoWtAr
	 mLdJrFvoPw3zdce1vQWxLbf6L77FoExK1a8RPJM1AOPL/9ADJOqo3ArQ67t1mil802ODd
	 cHbp6cGZXDdSCRnfX6mnHgFIvxbrJ9hzVRlzTKvkp8D7s5Ku/5bgKZux2PHFulvfIHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=CNsQLDfq;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3660A2610;
	Wed, 11 Nov 2026 14:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78E3660A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=CNsQLDfq
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmDV4VH1z4yjjF;
	Wed, 11 Nov 2026 22:31:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794407498;
	bh=6caPsKqXCgBq3tXaG00x236Z0t7ou43QCDHPtPKWJJ8=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=CNsQLDfqnLc4MFkjfHq4jccF5SVM7fRIARjm33PiiMoUxJZq5RRfNDha4jJB9MJit
	 40ubiatgp+mJ62N77kIaqZgHBJSpkbqstIrHXXi0zmhlwaJPjxUhLiwHNpcoiCLdcg
	 ShVNzFxI+0iLSY/xmEj/LRRC2f2A0msfMA4BMh1VcSgt9fHhPr7hhQV8ssTM4PxHfQ
	 5JQ9jWE4M/VVvp51KJxFPWD4PTyK4CkGQieK4l+AcRqtyxF5YWxLWBvGrpdSpDD53Q
	 QGmFd9NYNucSByPsqWOWYkJEKUtqM+ssEQqVsNpoP5ycAppJarmHssP2fhRXIQXlyX
	 jH3D3fXByXPiA==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6ABEVUrF057227;
	Wed, 11 Nov 2026 22:31:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:31:31 +0800 (CST)
X-Zmail-TransId: 2afb6af47c43d4a-53c43
X-Mailer: Zmail v1.0
Message-ID: <202611112231319337i08AK7ZzIXm9DYFhmtXx@zte.com.cn>
In-Reply-To: <20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn>
References: 20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn
Date: Wed, 11 Nov 2026 22:31:31 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNF0gYXRhOiBsaWJhdGEtc2NzaTogZ2VuZXJhdGUgU0FUIHNlbnNlIGRhdGEgZm9yIEFUQSBQQVNTLVRIUk9VR0goMzIp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ABEVUrF057227
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 22:31:38 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47C4A.001/4jPmDV4VH1z4yjjF

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_scsi_qc_complete() only recognizes ATA PASS-THROUGH(12) and (16).
The 32-byte form takes the ordinary completion path, so CK_COND is
ignored and errors lack the ATA Status Return descriptor. Successful
commands with CK_COND set therefore complete GOOD instead of returning
CHECK CONDITION with the ATA register values.

Recognize ATA PASS-THROUGH(32) by its service action and read CK_COND
from byte 11 instead of byte 2, which belongs to the variable-length
CDB header.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2 (Niklas Cassel):
- Move the unrelated invalid-PROTOCOL hunk to patch 1; this patch only
  changes the completion path.
- Regenerate with git format-patch so the index matches the diff.
- Keep the Reviewed-by tag; apart from the moved hunk this patch is
  unchanged from v1.
v1: https://lore.kernel.org/all/202611042211545962bhKeo8yjWPGFgya4g6LG@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiled
ata_scsi_qc_complete() verbatim with sense/completion stubs. For ATA_32,
CK_COND in byte 11 now selected pass-through sense and CHECK CONDITION;
CK_COND clear remained GOOD. Error and preexisting-sense paths selected
the pass-through helpers, and byte 2 did not act as CK_COND. The short
CDB paths and unsupported service-action control were also checked.

 drivers/ata/libata-scsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3fffa2617339fb7aa8a9035bbd88258794e1bf63..645899c2625424c7e305c7a2d426cdcc217dde43 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1888,9 +1888,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
+	u16 cdb_offset = cdb[0] == VARIABLE_LENGTH_CMD ? 9 : 0;
 	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
-	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
-	bool is_ck_cond_request = cdb[2] & 0x20;
+	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12 ||
+		(cdb[0] == VARIABLE_LENGTH_CMD &&
+		 get_unaligned_be16(&cdb[8]) == ATA_32);
+	bool is_ck_cond_request = cdb[2 + cdb_offset] & 0x20;
 	bool is_error = qc->err_mask != 0;
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
