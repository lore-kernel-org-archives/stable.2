Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492091;
	b=GK7GdQ8XX4QAGelbiTgvFNDp4OvTxk125h5BLPmG3xBHlwv8vWg/dWvXQdFLKbl3O1Nc
	 p2PZWrlMfDhUF4ftS17hAwmrbimEx5NMgvBUpGi7TbnRmSvbNZp5eGEtZv586Yv3uZXS1
	 JyAOIEfMh/UeBOOeE5Gnu9FXWZL/3kS6ZDz6VpKkpi70xArOR6REOonDC8nroKzrEi6do
	 g7PnYad173WwYzFK5x9sZ8frgIojzTkQ4hfYOlNa76w5NtU1dt2ZifXJOVT5/mCTjRwW7
	 fOK4fbQ65SPRFXOnOg3fEDUmp4Kct/HaVrDZSiSmRR6T3Wna1HRsVNnFC3a8HgXqAqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492091;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=qpWy8HCWSR0sa/eAfK/XviePDYIHsZVvhoo2sgpZsKU=;
	b=nSX5vUjDZRbpYYstdIpNu12rwpt4XBUA1zpwbV9kRHhl86iqSwfdYXxBt6tdqcAi/O9/
	 EchrU3rdjM5CykG0Lw3/eu3IJ36UQgEHLst9W+1Kv1859AezTO2lw0G9hcASB7dfyiv9y
	 d5eOnLSoAxZjPCQlbxJcY2+lf9wdGgxGXNn2In3b7VsU++MnUGxA9XKyu3e5Ku5VcV87b
	 dk8sM+aegmLxQCwwL7Xbnp+uxTTRUIGIi6CO92uFA2D3/B6RGz8kJUijOLCYTGzhWNlXE
	 j8OKygvoUvWrVAFqByuyaSjpLV+/TXo8G7amyuaiHrS7VgP1u2NWzotAvLuItJdKomw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uB0Ej9JY;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F9606A8B1;
	Thu, 12 Nov 2026 14:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053F9606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uB0Ej9JY
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMW82BDgz58fdJ;
	Thu, 12 Nov 2026 22:01:24 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492084;
	bh=SoCPix3SJoM9vNBx7ZY70/VYrCDAhK4F/OrFZJVxrIQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=uB0Ej9JYIKsTXloN0nZbF3fVxI//THIMreXYBEAA2G8vfaWjMhoJnIqpMBzxwY9wF
	 M5GS/MyMbho2W0fz6qOWba3ujv+dRNXap708oWH+ug+0/jDkIltCdS9SaJJ2OYTn+q
	 33hih3WRyyl4MAIzdyvk0lXlBICVp8xawF6XPG5rny+0Uc5fWLrMBjd7GMhBhSK0yJ
	 rbYu7LVHOmjNuenwUKCa+kPcJwp33J5JP7947e8Z8zPk2Sy9jzQfrFzC8Zo9Dz3UFF
	 vahAdjh5Dr1Xy9a6divoW3k/rogAfNVRaw+TxuxZEBtWdygeDePGkw1A5NeJfStWxg
	 bn++Tam00gENg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ACE1JAX036965;
	Thu, 12 Nov 2026 22:01:19 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:22 +0800 (CST)
X-Zmail-TransId: 2afc6af5c6b2a7b-d71f7
X-Mailer: Zmail v1.0
Message-ID: <20261112220122679csrHZJU28_17KSmt_fom7@zte.com.cn>
In-Reply-To: <20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn>
References: 20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn
Date: Thu, 12 Nov 2026 22:01:22 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDMvNF0gYXRhOiBsaWJhdGEtc2NzaTogZ2VuZXJhdGUgU0FUIHNlbnNlIGRhdGEgZm9yIEFUQSBQQVNTLVRIUk9VR0goMzIp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACE1JAX036965
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:01:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6B4.000/4jQMW82BDgz58fdJ

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
Changes in v3:
- Code unchanged; retain the Damien Le Moal Reviewed-by tag.
Previous version: https://lore.kernel.org/all/202611112231319337i08AK7ZzIXm9DYFhmtXx@zte.com.cn/

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
index 2491e90fb1a5ec6e83234a07eef5342055875937..8ee68937e884369beb4d7ad218612d28c5a080ff 100644
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
