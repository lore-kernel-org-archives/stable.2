Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7E2D12EE;
	Fri,  2 Oct 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939586; cv=none; b=LADRSfPzzSqh5N57Zq9XbnLa0k2DjpeXy7rm5cwtEJOX9o9K27nKWZ6+GVVK4+7eUYMHGvAFfhswxbDLixOG5uK0StCNo4ALHogaaNBRR+R712QLLlZdWgRG954+qYmHBmwnN0BOqDIY32ioWv0H1Gsj3hdtX1A20wchSmXfvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939586; c=relaxed/simple;
	bh=QE9Harzci5RFmrQqWEVp2gt5x43gSxsW3S3yRSOjdP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VgMyJuReuPSwULAf61jl9DYuPkLTGjX5b5PJPF8Jws6rXNiWNMAo9hB0ATplhEyCotwKLT/LQTCPLXZXx056hjy2b/6yhXpa9bsq5e6JlWKvMgeXRJywLzm9SO7bNlYxPon3kSLwMXnBtdsJSVTdAH3qexT24pJpCPJr9C7uIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wWMAd2g8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wWMAd2g8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A06C44E41109;
	Fri,  2 Oct 2026 11:13:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72DE7603DC;
	Fri,  2 Oct 2026 11:13:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6048103282FC;
	Fri,  2 Oct 2026 13:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XvO1BNYN19Nln6gJEDYgUUR3tRUXH8L0avT4inZ0dLk=;
	b=wWMAd2g8z9gt2dPZ2FydFzSM3OjCIl1K/8oy7NtjdzgA3btUv+vccQR07K8TnYTGCP8FW2
	gurcx/ADKoEEZGBfHW49dqF847Wusc6XolnOBFB+lwKUZrDOhh/ZmZDQc4cnbYc17rJOQ/
	iglxvLlFOTn79Eh5HLN5fiVUv89QafljPeeUb1lWGXqmZppmIYWDqYABQQk3Jat15YTMP/
	14TFzwSv/bKdhiD4SA1r6FedmO/K8fPXYpEHgBB4d8n+EmzkPcKVAFDcghpwno6xCsrli/
	uRPtKKNey9bC0cVYWCSQlszcOZrCCLcnzvy0qr96w/d6VFGSQAWCpDtnQFY3HQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Subject: [PATCH v4 0/9] Congatec Board Controller: Add storage devices
 support
Date: Fri, 02 Oct 2026 13:12:38 +0200
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTQ6CMBAF4KuQrq3pDxVw5T2Mi3aYQhOl2CLRG
 O5u0YUaF7J8M5nvzZ1EDA4j2WZ3EnB00fkuhXyVEWh11yB1dcpEMLFhBS8oNAaoE0Dj4INO+zp
 dAUYaL33vw0CNRCwAtZSCkcT0Aa27Piv2h1cOeL6kpuE9bN3M3Z5vjHyevhpLlv9vHDll1GItS
 8XZpuCwM94PR9etwZ/IzI/ig+R8ASkSKdHqqiqRoVW/pHyT1SJSJlJVuVHSGlCov8lpmh7SK60
 HjQEAAA==
X-Change-ID: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

In this v4, I moved struct cgbc_i2c_platform_data definition into MFD CGBC
header file (was in linux/platform_data/). And now MFD_CELL_NAME macros is
used.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
Changes in v4:
- Fix struct cgbc_i2c_platform_data comment (kernel-doc warning)
- Move struct cgbc_i2c_platform_data from linux/platform_data/i2c-cgbc.h to
  linux/mfd/cgbc.h
- Use MFD_CELL_NAME macros.
- Link to v3: https://patch.msgid.link/20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com

Changes in v3:
- rebased on v7.3-rc2
- use PLATFORM_DEVID_AUTO for child devices
- move I2C bus and I2C device definition in the MFD driver
- Link to v2: https://patch.msgid.link/20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com

Changes in v2:
- i2c: fix typo in CGBC BIOS EEPROM label.
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
Thomas Richard (congatec GmbH) (9):
      mfd: cgbc: Fix use of negative error code as valid session handle
      mfd: cgbc: Add I2C platform data
      i2c: cgbc: Use plateform data to get bus ID and adapter name
      mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device registration
      mfd: cgbc: Use real I2C bus names
      i2c: cgbc: Add support for fixed frequency buses
      mfd: cgbc: Add virtual I2C bus support
      mfd: cgbc: Add virtual storage devices on the virtual I2C bus
      i2c: cgbc: Register known I2C devices on the bus

 drivers/i2c/busses/i2c-cgbc.c | 108 ++++++++++++------------
 drivers/mfd/cgbc-core.c       | 186 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/cgbc.h      |  16 ++++
 3 files changed, 243 insertions(+), 67 deletions(-)
---
base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320

Best regards,
--  
Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

