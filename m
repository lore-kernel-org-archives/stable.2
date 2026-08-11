Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20153AAF54;
	Tue, 11 Aug 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463803; cv=none; b=gIf34Pu5YW3vbR+7e2y37oGFN37A97hCYP3fmPOXXZGXeRIWiDf8y21zc2XPmJWoj51uoCQHntwbGYiGVWUbFzRINDdjX5smzQgzYPh4WJhwlaCfcJ1GG8COkeUVUqo64krfudwvxWG8sy0Xyyfmcge2OljDOBbkEunuJVC9jO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463803; c=relaxed/simple;
	bh=WrrRLj75rY4yiM2BByxRB0PLnCPuLb2NaC62bEEr33U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ea5fNb+w4lSqV+uZ4PV7C4Yi0GMjzKM73zq+sSGB5c5Lg5NtWtf+ICoGR9ckcKR25RVjmFsS/nQqd2B0EN1O63pNSjpzhTT1exVDtD1RHWZ4L3J7Q+Nd2oYenk7K+50hraw7EhaE82+SSNm7/DKjVcrdnRsow6P46jHYvxgglIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oxMhnriF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oxMhnriF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD86B1A1568;
	Tue, 11 Aug 2026 15:56:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 886F46033C;
	Tue, 11 Aug 2026 15:56:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D713F11C48F35;
	Tue, 11 Aug 2026 17:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786463792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sUAApDZy3TlhNssmNMcIyrNULeU6ZVOdmp1OkjzAjKo=;
	b=oxMhnriFxidKy7FBTEfY3kg0UBi9PtHQY6bNLRlOisFm6gPyq0htsBUXu25gLORpFEEsGS
	UUezthrqAQtAkI9mGsEwqeykCp1l5G8Gy9jnzRUQrdKZEtvbbFQS3tziAYDFt/4yH/zwT+
	EOKfSeGCvAck19dB9/rjCdB8aKhIh9nfhQP/QHb0/EPdhQTLsM/C0xtUq33uxkPY7c2E9J
	i3HhHL7p25hLZC5/AZAWDGEcQypQ+h942TFKQCV/8dUsflb6Jjuuz7lQUXtGFOWU6FXDKW
	LieqxAM3uTQiCdSFFZ1EIo5ywRuGVuHF8AuZJ1GXAgVY2cQT8YLnaNcQdFQ7Jg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 11 Aug 2026 17:56:23 +0200
Subject: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW wait
 interruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LSwqAMAwA0atI1gbaIvVzFXEhbdRs2pKACuLdL
 S4fwzygJEwKU/OA0MnKOVXYtoFwrGkn5FgNzjhvBmuxkGhGuS7c+CZFY32I0bnRdz3Uqwj9oU7
 z8r4fI5qHn2EAAAA=
X-Change-ID: 20260811-perso-rww-fixes-016cdd229647
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

All the parallel locking helpers (spi_nor_prep_and_lock(),
spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
spi_nor_prep() then wait with a killable sleep. If the sleep gets
killed, we leave the controller in its prepared state.

Call ->unprepare() in these cases.

Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads while writes")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/spi-nor/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8bc117b46e02..250e996284f9 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1346,6 +1346,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_exclusive(nor));
 
+	if (ret)
+		spi_nor_unprep(nor);
+
 	return ret;
 }
 
@@ -1417,6 +1420,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_pe(nor, start, len));
 
+	if (ret)
+		spi_nor_unprep(nor);
+
 	return ret;
 }
 
@@ -1490,6 +1496,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_rd(nor, start, len));
 
+	if (ret)
+		spi_nor_unprep(nor);
+
 	return ret;
 }
 

---
base-commit: db5f6418501f9795a96026b764d747179a231b2b
change-id: 20260811-perso-rww-fixes-016cdd229647

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

