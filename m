Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592092;
	b=J5Y7VYBF5blP1InN80wXgOMRYFrSBukUrAmaXo4b30WM0NnScKipNKX988qk4Zc2mT+E
	 HgQDSNKin3BUstcZrZx/HWVtNxmUIvkFljoWImZ57fNqm1PDJxDCeT/HRAGpkKAZ07vZr
	 lQ2vEAIDuHG9jeYihAwFoWROQ1vu+85JxH6GIZgJ2Xjcne0YxrEOMFksCIEAfuUMUbyEC
	 YKi8YBTdonorzhEQYU7xLuJ7zXuOiqw1kcOgpWoKSN+qB9NIghWt4DYpqQvUSxnOdA89S
	 bIrPiozXZnkYQ7mnyfPYCn4a4bv/wp2xGABzA56fUpeYohaLsSYFjCKCC2tzxbq7+nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592092;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=RYWbLdh+qur8lJ1AToVWbjudcC0EowlHfIDHxAsQAA4=;
	b=BkvkLxk629nvlCa3KDGM3y7ScGF71vmPisoNTn9u/xkcCD8XIrMPkzm5FAmng0o+CU7u
	 4pJ9NFRQuSe6RTG1Di6mOasgu33V+z85QwIRahXRqQRwehQ/27FPTsfxp9qfXSDqpd+PT
	 SPmeRL11EQS9RIEykb60xqyG3awND86N9ST4VBW72ji3brOxU49hH+GL0o6Tq95x/eTXJ
	 gNQ1gPX33RuVkQOotfEf7XGGZy9eXeOilEKOwNqPK7kgxuZkPkIywcbbjCkZzDRTZ+1pm
	 UCzl/McARz8JqgxPwoLaY9KDXJd8os2mIwQRjchPyTeLnSbPpOqURDQ6j0qC/fx6lag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=jodiz1T8;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA860776C3;
	Fri, 13 Nov 2026 17:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9FA860776C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=jodiz1T8
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4VC48B2z52SFy;
	Sat, 14 Nov 2026 01:48:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592083;
	bh=vF8cKrEZ7BVGW+IWVV5AmiTocYYyLSBwGGrTkDvJ4c4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=jodiz1T8WhNttSqF40eHbV11MIz9vjoeQXlIqMm6VhxFuO/Ea/e9ESjIrMPDnvdct
	 GbmNGF/F4iKSvMAaD36o1RJGvQoGb8IckQ/tU71KvvYDbLeDhPRco3LAPgJBoAJpgi
	 7gSegASKd3zzqmO9opKbwlILnY765TzpiF8rIQUF4WMMwcguASykCciZCCn33I6G8Y
	 P3HV/CZbeP+caaICPilUTRcjPgJXcUswVC2ldO4if+5tit5YBeAJJ1j5XtjkiRVIJT
	 gkqF2nRJyUllkDDsX7xbuwr1NdzkUDAWtgVRHn334zPW8swD0r1EOr5MrF/KmV3vXr
	 uXudvvWnuq2dg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ADHlwsW088135;
	Sat, 14 Nov 2026 01:47:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:48:02 +0800 (CST)
X-Zmail-TransId: 2afc6af74d52841-0e78e
X-Mailer: Zmail v1.0
Message-ID: <20261114014802439etUmn-1GSedbXpMuHdUzC@zte.com.cn>
In-Reply-To: <20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn>
References: 20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn
Date: Sat, 14 Nov 2026 01:48:02 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDIvNF0gYXRhOiBsaWJhdGEtc2NzaTogcmVqZWN0IHVuc3VwcG9ydGVkIEFUQS0zMiBzZXJ2aWNlIGFjdGlvbnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADHlwsW088135
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 01:48:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74D53.000/4jR4VC48B2z52SFy

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
