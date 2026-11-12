Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492086;
	b=a1hY2lL/r2OTcZIMdDkbfKeXlhlTwUNwiAUqxFRPB75DLonQ3EhK/w8szYUea3Ldshzb
	 CWNkNdzO4fMH65lP6zmxdY9P8cCI4vobKcAy7XP1p/X4EeFuSmRfeQ+ki7mi05JA7fK6E
	 BGA/zCLLp2cM5rEoFxGXg7ofmdyT+ndxAISsFIPdEbxnKiUnTLdfY3MRkmbkUoJrA9MFz
	 3KmJlbe64CpXCWmvECkJyUnyjdivFb9LzwdnT3SYgYWifQCojzuJVCDZgVUWTi/vK1g6U
	 lQy59WcXcf+mxEegvGAthFfTrIgPde7ggVffIKnyauaviLBYjakGN2TAS6T0xt+4fZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Ec1f8mm2E/OEep93Z5iuf6ZKx13Ba8rPrGSqXzZRQwg=;
	b=y0WU1RZ6iDO4plVswb8n9TrMaBgbg2nqTfu/rq00Fn2MjZyePmW/48z3bibGxDgxX41N
	 MdFF2xHE4e0eArOgfxptId61xLYNyosVmPLYndvPgSLoWPy6hEC+ECJ0pO5PdbPZ944nb
	 bLG8eB2Z48lFCmj0b0fn0DaCCsPsF0Lxt4c8UHp8MzV3AreMAvpes+z3Losh/B9PVsfn4
	 BSWpFD5udz/cj5OiN8uj7swrVSyMlSrgJS+FcrBhh4eacbm+noEkoPILiUAG69e6yRZe2
	 TigYimIx26GQcS/ZYjK4e3amO+X9dW42mbDJMriyRFmYDlW+vBEyGa+dR5wQ74EFXUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=IJ9ZIqmF;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787160A3837;
	Thu, 12 Nov 2026 14:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1787160A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=IJ9ZIqmF
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMW74VFbz8XrrX;
	Thu, 12 Nov 2026 22:01:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492083;
	bh=ke4k+17lC/3JhYXvGAAXghOgJdr7SUqcVwaz+yo+r8E=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=IJ9ZIqmF7g6ljafC/6y+jssjMUj18k2RxYaHPdvvO7TY5AxGqd5puzXEz6lhyVrrd
	 PoY+y4FiaXFimyOtog/ASDLuJ8Wj5dOMKFT+seRYuTz9Tne9K4qfS1Bj1keqWZML/c
	 3np8IRu6jWpbrHhwyTlWY8gcXOtCa1FtWI1KbKe0uZ8wCRsN2RYVcGJM0CtgRhHE9p
	 hKaJW/YDjauNnh4PPcxlDLJgX85mvtecp3D3b1t5X7Fa5yfQOjf5IiuEvp1JBV96HO
	 So2isttjpBP0O8lbWvQ2tlDDi7LMDOR3h8UyagL7TN6J1zsdEMa25H4mKow1khgSp0
	 8DCZfV4lSr8iw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6ACE1IWF036951;
	Thu, 12 Nov 2026 22:01:18 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:21 +0800 (CST)
X-Zmail-TransId: 2afb6af5c6b1b87-d5305
X-Mailer: Zmail v1.0
Message-ID: <20261112220121378caZJpnCPmheSAmKX1Hl8g@zte.com.cn>
In-Reply-To: <20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn>
References: 20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn
Date: Thu, 12 Nov 2026 22:01:21 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDIvNF0gYXRhOiBsaWJhdGEtc2NzaTogcmVqZWN0IHVuc3VwcG9ydGVkIEFUQS0zMiBzZXJ2aWNlIGFjdGlvbnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACE1IWF036951
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:01:23 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6B3.000/4jQMW74VFbz8XrrX

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_scsi_var_len_cdb_xlat() returns 1 for an unsupported service action
without setting sense data. ata_scsi_translate() then completes the
command with the SCSI result still zero, reporting SAM_STAT_GOOD even
though no ATA command was issued and no data was transferred.

Set ILLEGAL REQUEST/INVALID FIELD IN CDB before returning, with the
field pointer referring to the SERVICE ACTION field at byte 8.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v3:
- Code unchanged; retain the Damien Le Moal Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261111223130666omUZ0JoWtfZjRFRrWPse8@zte.com.cn/

Changes in v2:
- No code changes; regenerate against the series base and keep the
  Reviewed-by tag.
v1: https://lore.kernel.org/all/20261104221102824qAKUWNkiSgZ1yRnQM8hI9@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiled
the translation functions verbatim with SCSI/device stubs. For service
action 0x1234, completion changed from result 0 to ILLEGAL REQUEST,
INVALID FIELD IN CDB; the invalid-field helper received field pointer 8.
A valid ATA_32 service action remained accepted.

 drivers/ata/libata-scsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0bc147cf4c0fa50c7d5b84029b7fb1a548c6f1a3..2491e90fb1a5ec6e83234a07eef5342055875937 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -5032,7 +5032,13 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	if (sa == ATA_32)
 		return ata_scsi_pass_thru(qc);
 
-	/* unsupported service action */
+	/*
+	 * Unsupported service action.  Set the sense data explicitly, as
+	 * returning 1 without it makes ata_scsi_translate() complete the
+	 * command with the SCSI result still zero, that is, with
+	 * SAM_STAT_GOOD.
+	 */
+	ata_scsi_set_invalid_field(qc->dev, scmd, 8, 0xff);
 	return 1;
 }
