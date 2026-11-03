Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724571;
	b=Z03XJeDchPlce0A9cdIkvEjvgXj4LBrPEjETc7itBJA7H9zuJwBPDTaDtH/YIW3bSVKP
	 ei9o3RneXgd6AlDfpldgPQ1lnNTyaUoTLHGfWg6C5HxXdHDpqyLtEWj5+h6OwQyG8KoG8
	 sxgeUnbR0iu5rpSFcP1Mg8GdiaXYee3tKhnVs0Q6hsaeFLL22Qf0CPezOGArlN46Rh5/9
	 E/EOnL/VJYQOuUqP3A8XeiEX1jeBS7leyrIr20IyLZYLG7QxjIkWq6ty0YrOnZxQQLIQp
	 bGTzfreJ5JOgBxPgodBdqgWGYOD1iNYBdN0ZqfFKacwXBQzeTFDDdFhQdf7LPlCx6Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724571;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=5dGb8WXTIZvpvRNeR8lBF+8mxozMxifiVbHhgx0PdyY=;
	b=sTnnyR7teJsjDaa9C2qVGUMNUydxva7dz/IVxYg1dZiaeATILVumceBYgi2m1lltvkXw
	 XkVtwHclrNPCsJhN34jRBXhb8jLRsdATVXj07WspJFuL59ztehzWwP+qMvpypkkywdgUZ
	 MrkcaKNko+Yqouku158SPOK1QRhHUi/bfvawYHjOGf6Bsd2y132j66eG6F/6eiqq0MSL+
	 09Vc7/nQCTtQyJj4Eh9v2xi8fRJ0ewAnNVGVcg2q5DFYZqAflGdxPJV5UBAmb9/vYCD4N
	 6TUM6wdOPz19kRCYPhg4ht87Orcum8PfQvt/aDQ7HEuljmIFA+9axRWgYvIhhUZ4NBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MIwJML6Z;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E2606A335
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB2E2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MIwJML6Z
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BA7D1C49F46;
	Tue,  3 Nov 2026 16:50:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 150F76046C;
	Tue,  3 Nov 2026 16:49:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28C0D10328C5E;
	Tue,  3 Nov 2026 17:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5dGb8WXTIZvpvRNeR8lBF+8mxozMxifiVbHhgx0PdyY=;
	b=MIwJML6ZrlML9gz4Da6Q/pl+r7yvzkdB1t99vQCrz9KcnpBFz6rKO4/9fh/7X8eejWR3En
	C3YsFzJs/+s0kA7YGKSralaozX2IWSwrEtAMNWLlcmU1xChHsX5L6rrKONeeAei7H7Xywk
	RRP2mVeed8iMRMHRhS07fIAQXPGlBj7hD5N4enabnNV3CiMKjnaHdBoobtNQtmw7WTDTld
	6rhbW+Vsze5lLum/0OTl0e18R0x3Ex0aQq330KScu9UyzZJSA/v9hrFVfnwOaI9TamqqtY
	/gvUMDEsnvBBfPlXeAlFDIQ+ZjXiuS/2Az8m/J+BggJQog6bag0vcYCx0XnyeA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Subject: [PATCH v5 0/9] Congatec Board Controller: Add storage devices
 support
Date: Tue, 03 Nov 2026 17:49:08 +0100
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QzW7CMAwH8FdBOS+VnTT94MR7TDukqQNRSwNJ6
 QaId19aJLaJw7hEciL//nauLFJwFNl6dWWBJhedH1Kh3lbM7PSwJe7aVDMBooASS262jeFOGB5
 HH3R6b1OXocjj6XDwYeSNJCoNaSkFsMQcAln3tUS8f9zrQMdTShrvl2xPMeolab2acxBECbWUU
 GSiQlHUiiPviTYdhYH6zIftDD+3ScAcRA6ZQCyrgkvehcs5XkZvs85fev8ZO7fxMWbHk+6N3++
 zdLB5qp2b9zkv/zDhMtaycgX5/ytPyIFbamWlEIoSzabxfuzd8OAn8YtEfIEUiZRkdV1XBGTVM
 yl/yPolUiZS1XmjpG2MIv1M5g8SAcQLZJ5IanJBYLG1qv5L3m63bzDq4x5hAgAA
X-Change-ID: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

In this v5, I re-ordered a bit the patches to fix I2C bus names first.
I also made an error message more user friendly.

Lee, this series conflicts with some other ongoing patches series:
- mfd: Assorted resource lifetime, teardown, and error-handling fixes [1]
- mfd: Constify mfd_cell arrays [2]

To make your life easier I rebased this series on top of them. Please let
me know if you want to proceed in an other way. 

[1] https://lore.kernel.org/all/20261027093306.2812695-1-lee@kernel.org/
[2] https://lore.kernel.org/all/20261030071137.100954-3-krzysztof.kozlowski@oss.qualcomm.com/

Best Regards,
Thomas

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
Changes in v5:
- mfd: fix error message in case we fail to get session handle.
- fix I2C bus names earlier in the series.
- Link to v4: https://patch.msgid.link/20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com

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
      i2c: cgbc: Use real I2C bus names
      mfd: cgbc: Add I2C platform data
      i2c: cgbc: Use plateform data to get bus ID and adapter name
      mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device registration
      i2c: cgbc: Add support for fixed frequency buses
      mfd: cgbc: Add virtual I2C bus support
      mfd: cgbc: Add virtual storage devices on the virtual I2C bus
      i2c: cgbc: Register known I2C devices on the bus

 drivers/i2c/busses/i2c-cgbc.c | 108 ++++++++++++------------
 drivers/mfd/cgbc-core.c       | 187 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/cgbc.h      |  16 ++++
 3 files changed, 244 insertions(+), 67 deletions(-)
---
base-commit: d3dfdb6b429a5b99bfd47176bf07cad0956f14ed
change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
prerequisite-message-id: 20261027093306.2812695-1-lee@kernel.org
prerequisite-patch-id: 7d50ed21b2d5d1bb25290d19c46b4668073feddf
prerequisite-patch-id: 45cdf12f5527ab86a560ba98c02cc447bf6eee4e
prerequisite-patch-id: 6148da531ee7713f8afb7bec90fb3f548b562d28
prerequisite-patch-id: fb0c30c409ef451192973c417a0585f989f8917b
prerequisite-patch-id: 8403fcd8efcd44138f139767624773fa654a5a2f
prerequisite-patch-id: 434546741519ecd3032e19f3acf2c5370e9a454c
prerequisite-patch-id: 29540ca5739d6f6f3e2d3fe5b87893ad31f6c3ee
prerequisite-patch-id: a33adadb2e2efe82d2a14417c1c35c579bf212d0
prerequisite-patch-id: dd53f1e6db35d71b51061dad45de28dde9ebc70f
prerequisite-patch-id: 85a1da1285d64ce3fc78c8ae7969fbb0dc7c3cd7
prerequisite-patch-id: e9b952ebc380d058ac2144771c780a0b08c3b7c3
prerequisite-patch-id: 1f0dcc7a8c5df7ae1c8bfb5a1c8f62b441704286
prerequisite-patch-id: 077a4ef70d74321711e2efd4e016e01a1d41c818
prerequisite-patch-id: 4dcd6cc156bb6ba43684605972fb179557a3891e
prerequisite-patch-id: 62e87491674feaae09327a99a5ff1b4ed368f221
prerequisite-patch-id: ab1eac435fd40cdb3d9a8d453a12852a105f57c4
prerequisite-patch-id: 1cbcc3b666db27cbe9f3fa6c6ead2f49a0d459da
prerequisite-patch-id: ecb566a7bea44600e9d7e9617e280c994773e3dd
prerequisite-patch-id: 20e295db85a31587d342471a3c341615c8eb0fd7
prerequisite-patch-id: 06118bf6e5affc234e7edbdb5c0aae9b05412b33
prerequisite-patch-id: 17afeb13c5012348feee8eb739ff058e84ed2df8
prerequisite-patch-id: 27693bdeffbc7a0a295c165912b89af5ca3264aa
prerequisite-patch-id: 8313fe2293eaf0e69ffd2f0017e18fde64ca68f7
prerequisite-patch-id: fc53af34353efecb4490087ed066ccb256a74695
prerequisite-patch-id: 02ad8a3b1fddb4f4e806939d36ae642c01004c36
prerequisite-patch-id: 7b9b8460613f4240492ffe11ee7ee0e6c0b6ded8
prerequisite-patch-id: 699c068a32ac9d3171e7a494fb2ca5522045779a
prerequisite-message-id: 20261030140240.211786-3-krzysztof.kozlowski@oss.qualcomm.com
prerequisite-patch-id: f6cf975bf90acb029fa985ecd659b59076fdc0cd
prerequisite-patch-id: 4f16ad80662de796ae1454904c938e7e85115fbd

Best regards,
--  
Best Regards,
Thomas Richard

