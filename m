Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592598;
	b=QnZKVfykB1tw+4lrja8z63VM+kk/7Lld+3KFN0IYkiiiHzm2ZpTRcbAc+2dSg19Gjqob
	 IWWkd/WYaWhgfC+3RBQa43bVjTe7dXjlU1Rdn+r+6QlNnTDgI7sMth3U9+v7K8WF6QQCg
	 C0w7axZhXkrcPJqKkY2ZsEoTEs6gJ9CITiI5sNxH/maAB91kG3gGzIO+rWspaWNfsdkv3
	 t+y0QHLIQA410XdysiJyb1miQtaXmkaTxQANNweeL/cAopI3i8/I9ymeR24bEaXyMzPcg
	 6juye8/koZrQ0vTCltYEiHyz0shq0V9EbfxcBG7wio/VcW0lPy0cw72WaJFB2DtIRmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592598;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=1jArcVD2zXLu7nIwu5fc5e4hQBQ9eNZl6bcyQU3clWI=;
	b=x5ZbFqWvw29gEm5DhkyEPxWVeDAINBYArn+GTkMdpDqY1cBVRDqt/+ueV8OnORblUYs8
	 6WmhlwnFFBBoPSycQuf3x22kOqc0CXS5MeU5PCaT1agXZ1BLf3T3vFAtWYBHxPdXvAuad
	 C6EAjX9+8dbTmJeV8jZNKHZyymHBe+PFCldARQ+R47r+7QzkQfe2g7dkOorxCJ3gXJ7X0
	 uUCDumVoNH5SNNJGyQ4pJ0hBs1d/h+npZtVlxUYRAPzDAkvr5PZmQ1r8AUc6fY8Ei33W8
	 0PVNEw2Lxy9j+ecdhdyju+h8FcigfLNLnKStxkmzM8x8gf7rKqqdv+rMeoig7pxTM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=BWfb1NTw;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F3606B213;
	Fri, 13 Nov 2026 17:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5F3606B213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=BWfb1NTw
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4h45klJz5BNRf;
	Sat, 14 Nov 2026 01:56:36 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592596;
	bh=K/u/yUdi2m6dk93ntxHCfaABwW9WEA6J2Tq9rcsx3UE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=BWfb1NTwudRa1LyAPre2ClgTzQPtPqpuTSYnCYQ92qcOYsIkJwCYqS3fIky56bmpo
	 S6hdwDws1NEBrDbWpK4kHuIC4If4E2Az+lyFXprQr9PC2zISTjdo7BlcnRP1AlUlKf
	 VR2Zyj0OqXwfus9XdHyN6r0d+O+fr1IQ2mMYks8lWGRJqwdn6SyWZCMyl858khXQeb
	 uFj5MRcN4kjvCQy7RtTREotBqA5MWKuehK46EjgyUXult7iaRFKnpfP+3BT5MvCGOI
	 yt7aUQR8sIjTfcRsgNIBHXbICcKL6KcW8mOE0PZUuw8mlqMLTmMjOIGCzd8WhKDcPw
	 OrZaZMHOOOJNA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6ADHuSuE067393;
	Sat, 14 Nov 2026 01:56:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:56:30 +0800 (CST)
X-Zmail-TransId: 2afc6af74f4e2b4-161f9
X-Mailer: Zmail v1.0
Message-ID: <20261114015630303OS2WiLVksNJwaEHon-qEE@zte.com.cn>
In-Reply-To: <20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn>
References: 20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn
Date: Sat, 14 Nov 2026 01:56:30 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCB2NCAyLzRdIGF0YTogbGliYXRhLXNjc2k6IHJlamVjdCB1bnN1cHBvcnRlZCBBVEEtMzIgc2VydmljZSBhY3Rpb25z?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADHuSuE067393
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 01:56:36 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74F54.000/4jR4h45klJz5BNRf

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
Changes in v4:
- Code and commit message unchanged; retain Damien Le Moal's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261112220121378caZJpnCPmheSAmKX1Hl8g@zte.com.cn/

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
index 8d321197803a839d9586e9f1436d1fbe3f5383c6..e2847fb32e78b93fd0c8fd3b57e78ae3b17654b6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -5034,7 +5034,13 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
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
 
-- 
2.27.0
