Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592093;
	b=sNdX5oNLatP+kBtxB4pAeIU3cZTc/XlPmhmO7ZJOFsnGt5u0OH+yTYMz/jl89wfoFfI1
	 wSk6IEgUgW0pWxafURpYTnzLhFUvEx0zwGv8EdiIuO6/sUzJtqIWnWMyM6pTnbKAFFi5b
	 Wn5itSW2gdgVErCS1vyGwCOP4Xmnc7FxM4oFAgqKJQuJbU7KtnXPN4WlLnVwleL/7773X
	 pEKarOf0BBHff/HwVpOFS3iSOegaS6fJsV/ukpUV9ZZ6l9YlonoIV+vZpRpN5pW4r8+In
	 /bqOLKwAvpVFmk4Mq08QIwR5oLy9q2Mkq0eR0JZRGkngBQm2hFWGKesO4hkW36eeMlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=vCR8WcZJeppmYgaHmqaRJ4J2KTAdxAIhRyZKmuC0DSY=;
	b=fSdLcfwa872lhM9jC4kWfMjwuEyJ6My8HxGMHjdkN8i0iahwrUgRZbo1obsTD6xKnltE
	 Sa3jkNQogUQm6agojsmuJQu4VtdejZfBRDCeU4hjxeJgs2ka0R9WXISlLgPCM7RSf71Jp
	 0GCABib8RP/eTEMu5yiXZwJaQLg5bQJsqu/IX6aHZaedpJi7Xl3ABg5YrBjOVLeFWXRVO
	 JTsAHpVvW3gxYGQlvdr5DV+Bo2C4e1/Dc/sscYfBrOy+35ktBtI7VSGADEXiw3JGE+np0
	 vMTVoHWTneBoSo/X9Z0zMO+bFQ3tWO6dPz97u6KpCF5U/cK4V5fyihNqZy8mkwCgSJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Zo9XC07l;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5160776CF;
	Fri, 13 Nov 2026 17:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF5160776CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Zo9XC07l
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4VD6Mykz52SG2;
	Sat, 14 Nov 2026 01:48:04 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592084;
	bh=oI4yZZyQLBORK+4fJhw2TQ6SzMTob/7ulPJAej3ylUs=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Zo9XC07lCiAj+4K90MOuS1LmeojHIbI/sAShCfjhdhnlnU/3NUI7Rp1JWPMw7IVxD
	 EQwNZfJiU6uT4regNaN1IWMDH3XNj439Pqlxwd3S9ufnAJbzk30H7ZlvwYRCKXRTpd
	 fYBM8wmoxwd7euMcFS4JIXMv5yXaU+/Qkdls8hToWub2DAVepFgM4Rm1T+Y1iNBFNb
	 AlWDSEiyvO2xVhPVLN97G8S+VHeZuooY/7++g/UtITbj+zfNQpiH0ihLwyFKmWsOHv
	 6k04TcIPfGXDsM2s8daG4b4fakEsEuUnBk2n4PHVE1PcyzL0psKS85SG6Bs/ltTM4q
	 pVp+3H4GpVZbw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6ADHlxA5060083;
	Sat, 14 Nov 2026 01:48:00 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:48:03 +0800 (CST)
X-Zmail-TransId: 2afb6af74d53836-0c785
X-Mailer: Zmail v1.0
Message-ID: <20261114014803857Bi1TV3JcmPJhHLNxcl72A@zte.com.cn>
In-Reply-To: <20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn>
References: 20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn
Date: Sat, 14 Nov 2026 01:48:03 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDMvNF0gYXRhOiBsaWJhdGEtc2NzaTogZ2VuZXJhdGUgU0FUIHNlbnNlIGRhdGEgZm9yIEFUQSBQQVNTLVRIUk9VR0goMzIp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADHlxA5060083
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 01:48:04 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74D54.001/4jR4VD6Mykz52SG2

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
Changes in v4:
- Code and commit message unchanged; retain Damien Le Moal's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261112220122679csrHZJU28_17KSmt_fom7@zte.com.cn/

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
index e2847fb32e78b93fd0c8fd3b57e78ae3b17654b6..374918eae53ef4cb082bccd903773f06e6c55fa1 100644
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
