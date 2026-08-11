Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93533BCD15;
	Tue, 11 Aug 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464929; cv=none; b=Y8TA1eYSkAPGtNMDtxcx8csvv+0+2TVlMmuRVhtMD0SYZ6UUBnajLzrCfLLjqvcLB1T5qdAMBZ9Hq8g3hGvfCRRpFbEzZ36+oYobz09QvT/KtC2DlgWXUG6A84PgUWtntl/9KsbZVQWxNE1XppXEusbo9rL8SwUNePL3K4xTLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464929; c=relaxed/simple;
	bh=mGbZ1GW0jaDBHaStQ08vsvP8mgvL/kVAeAh3oXcwYBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a6pHamdy+ZKGdcZ0oSZSYrTXQJfHo2xZ+V4onVnslH+TobwbISGo8oWFC7JcAgE5ul1BSn6g2bm2mF2TTbvmXZJaYosWHetVp2H7BZJTk3ksVRVtvLFnHkI4J2pa9cvLMicmPEJLmlfiX4SV5FD+5gOyM80uuhR8Lq2VnzAAVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JMfXITWB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JMfXITWB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 277161A1570;
	Tue, 11 Aug 2026 16:15:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E139B6033C;
	Tue, 11 Aug 2026 16:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C88C611C48FAB;
	Tue, 11 Aug 2026 18:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786464920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gdJP/zHnkNl7Ej8I/X0I5yEKNU4m3rUyi6cTL8dO6+I=;
	b=JMfXITWB/zBXYYPqWoM0mcr7XMisMMFK++GK4yeDTnGSOQCxUlYBEhYK6RPxyKfV7b3IB8
	FWY5+EuzkM2vElpG43byKgoVOJ5y6Amjx4Oi4V8oUiIkWLniM6EuF30AK3TsAiqDCd1dBg
	dzjdkN5FO+Voa/zQn1dm6MYfVgeTf8nK4eYwdhAvDlPZ9kfxH3UUMZuiDbpMLAYJJJdJWT
	FAHLCUmNrf7RBEA/SFjAhgQjT0u4qJ+M1+OEOj+rkvxCFqPryM/yqcTSTAra+Qi45PDh9b
	gEzVq9clC6IvApi4lGxQmMjJXuB7DDKXdLdvKmbWlFjGb+70cnxHG9z+qEMd/g==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Subject: [PATCH v2 0/5] Congatec Board Controller: Add storage devices
 support
Date: Tue, 11 Aug 2026 18:15:01 +0200
Message-Id: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBBFf4V07Zg+lBpX/odhAcMAkyjFthAN4
 d8tsHDp8tzJvWdmEcgzBXHNZuFp4sCuT6APmcCu7FsCrhMLLXUurbKAbYXAGiFE58t0r1MLKUA
 Yh8H5CJUhskilMVqKNDN4avi9Ke7Fzp5eYzLFX9jxOvfZ3pjUmu7Gizz9N04KJDRUm8tZydwqv
 FXOxQf3R3RPUSzL8gXEZObx5wAAAA==
X-Change-ID: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Second iteration and nothing fancy, I just fixed a typo in CGBC BIOS EEPROM
label, and added a patch to make cgbc_devs (MFD cells) const in MFD driver.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
Changes in v2:
- i2c: fix typo in CGBC BIOS EEPROM labeli.
- mfd: make cgbc_devs const
- Link to v1: https://patch.msgid.link/20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com

To: Thomas Richard <thomas.richard@bootlin.com>
To: Lee Jones <lee@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Werner Gartner <Werner.Gartner@congatec.com>
Cc: mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org

---
Thomas Richard (congatec GmbH) (5):
      mfd: cgbc: Fix use of negative error code as valid session handle
      mfd: cgbc: Make cgbc_devs const
      i2c: cgbc: Add virtual I2C bus support
      mfd: cgbc: Add virtual I2C bus support
      i2c: cgbc: Add virtual storage devices on the virtual I2C bus

 drivers/i2c/busses/i2c-cgbc.c | 174 ++++++++++++++++++++++++++++++++++++++++--
 drivers/mfd/cgbc-core.c       |   9 ++-
 2 files changed, 175 insertions(+), 8 deletions(-)
---
base-commit: 498c377a1ca412502649484c7b1788d5d328fc85
change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320

Best regards,
--  
Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

