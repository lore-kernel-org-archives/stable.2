Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407502;
	b=3bcoTMcvu4cwrNXu1vKS/CF1VRR3LPx/3TIyNQLEV2u9e9JjwhTowKyBe5vF12i9Jbzj
	 PxMrkxrtrvp/CqQGze13Cz/iAjIFRzxLX38PL34wAd7nCnV315vWv0nXOeDftrZ5rpl8z
	 5wblEtyLbjwPakUDDLUegZvKxVS9Ic6DUEdlEPMI1sfiesegXsRidmjE0qCwxY70vMBjg
	 EGroXflcau6IW94GdgK9+0qdUelqPQnO/pXxMkbkhTFI7dpsToQdB4rLIAGaMluR5N6ZU
	 gupVHEnIthP75E9iogBlmOqomT27RCO5Hk0ACXP0dZ0nB9Ir0tgn/Vep5EyhRfcUOqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407502;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=qZDZuxhda9JFE9lFlRNWscv72CRMBaga3n+rnGubwk8=;
	b=be46d+7r6WHmftrQaKsbCxhZP7FevmildmuR6KORxepnCFrOPTYDAMf440P+FRqFDo5E
	 Z+eLTUYAOK0QYRtRpnJodY8IooVfkC4LnZ2hZ4/iccSNSWLOdm4XQccq3j3efdXP8/SJg
	 qcXyjPrhW1LMYubFhnt5IRy9L85WAaUsFcTd89vH9hRjqjr5p6AvIbC8hAUdSNQngyqvI
	 3NSMiHVsKT+16wI3KXlqgOmY5ZscGavhvbnjMr3tTrTDduIF0lJySdbSSM3wmSZkO/6Fk
	 eqSZcD7JtL7+DD65tFPBzCrHuPgbTtWDHuhkIWMILNIfx/+0qaOFDTnIx7vbRXajEuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=PBKGUXb3;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8C60A2611;
	Wed, 11 Nov 2026 14:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78E8C60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=PBKGUXb3
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmDV29d6z5BNRx;
	Wed, 11 Nov 2026 22:31:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794407498;
	bh=7OfLAPF6pu7h6kxQBFwMAL5ZiClxJ8f/Yl/56vP0i5o=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=PBKGUXb3+JoRLryUe3yrpn3Jx+5P4pWS82jwpKxCzX6qaHkD3WYM+BzacNZVxHgf0
	 qzqslDJJuCdWNM+ObJVT3lm2sa17nEPBfLMWmQ10Ts5bpSqbgJsftW2yJygb1/F0f7
	 gL35IH0XjruCOAC76pQdQPIPNXjveojirRFOfvPSzwOfB58iSc7QCw/e4VvFjUJUYV
	 kHJHMuZxgN28BXDaLuYBwi8NcVgkA5aWNa9QTYu6xpkxBkQCX/qQHHRHxp8mQb2bUQ
	 5LObDnNFHNCTjEQykZkL5MisuB90ID+1CDA+Z5hkRtUH84X2QMIH8ME9IWpYhMtA/U
	 HoMb98ydGENIg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ABEVRCb089033;
	Wed, 11 Nov 2026 22:31:27 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:31:30 +0800 (CST)
X-Zmail-TransId: 2afc6af47c42b2e-51a29
X-Mailer: Zmail v1.0
Message-ID: <20261111223130666omUZ0JoWtfZjRFRrWPse8@zte.com.cn>
In-Reply-To: <20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn>
References: 20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn
Date: Wed, 11 Nov 2026 22:31:30 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvNF0gYXRhOiBsaWJhdGEtc2NzaTogcmVqZWN0IHVuc3VwcG9ydGVkIEFUQS0zMiBzZXJ2aWNlIGFjdGlvbnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEVRCb089033
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:31:38 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47C4A.000/4jPmDV29d6z5BNRx

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
index 227240514651ada8b5feb87a154833fb2cddf064..3fffa2617339fb7aa8a9035bbd88258794e1bf63 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -5028,7 +5028,13 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
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
