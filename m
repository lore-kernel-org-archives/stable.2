Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663293EFFC5;
	Tue, 13 Oct 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899948; cv=none; b=DHBUmfDhNKWES9jGtbgDA+bSTsVC77OYk0xGWRdQ9Tl+7jpqHGpG4SOkbIX/UotcL4Vbg500P6Wv3BxPWu4MnRO0THcdr3A1c0C383k3a5HERDb+G11ZyCxOGMn6NYEcfls0ESk5Si/DxvSp6DQUQYltO3kLfSOWFrk6JmaYYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899948; c=relaxed/simple;
	bh=NsUHpMxl4NkTSHZSxfS8SVA+Rz9xHptJX789zPkhPas=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DYcf758ZxKm9F6sCBaxOkYHszupSiMVRaOUT3NTN3w4dWqKoKV845XGnhNUatszZEG4JGJ701z/b2RLJS1oqJm+l3AnUtGAg/dbYXbUwOdP5KmpH5GRSk8vuqEMq4vSql3dvhbtt4MHsLMu3cL7NKki2OoXKuJsa1iF4N69U/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0FTig4P2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0FTig4P2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B1A974E41209;
	Tue, 13 Oct 2026 13:59:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7DD4060362;
	Tue, 13 Oct 2026 13:59:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6848911D71517;
	Tue, 13 Oct 2026 15:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791899942; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=otWPwuub5RVGq1GwYfCrckp7FEKuw4brFHMlBadgbSU=;
	b=0FTig4P2YutSzqlGHe2yTEn+MBSjo+CyzVN4riV4QL/xpTD6hcNIxW5LGrpLpcSGJWZeFk
	e6RnZ2GAoGwDE60Qy1/yKuU9rlrghEeXkFqN96h/h9DzhVHeg7Fz1af7+bEdc5eT0L2XOI
	tSyopvj77ltgnrZPiMnEWKXzPVwfHWdekp/T7peqq/MRy/M27gmNXt7A1wyi/tkcKqrOrR
	FJX0q1a5xnyUECZFvbKZH0A4Y0D1fsPq2MxNVLE0RpkP9e6F7zI3yatD/sOIQZ+L5ALvXr
	VMrXshIK82SUIwPBMl5+v5xniDWnIA7eGsKKE1fgSl6r4Q9ZXGIReG2QwsjMNw==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v4 0/6] watchdog: w83627hf_wdt: Convert driver to the
 driver model and add minute support
Date: Tue, 13 Oct 2026 15:58:44 +0200
Message-Id: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WRy07DMBBFfyXyGiN74mdW/AdCyHbG1IgkJXFTU
 NV/x2kq1AipLK80c+Zc+0QmHBNOpKlOZMQ5TWnoSxAPFQk7178hTW3JBBgopnlNj6ZWoHfx9dh
 mmrr9OMzYYZ8n6h3USnCpW4Wk7O9HjOnrwn5+WfN08O8Y8gK8Toz4eShH8zpGvJuQhqHrUm4qB
 gajDVahVdzqYmCMDiwyCwKE0hascQ4NuZVtqlWVya1qH7LioFpqHePKRx1srZpZkEVtl6Y8jN+
 XV5j5xWSlgLhTeOaUUc09iigtxjo++WHIH6l/LA0WqStD/scQaB33Ag1YvWEsbjPc+qh7LCis8
 gXSgVOBAfxl1b8sztjdbnVhGQTtJTfSStyyzufzDxWkdYA7AgAA
X-Change-ID: 20260713-w83627hf_wdt-improvements-ba2364157d6e
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791899939; l=3913;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=NsUHpMxl4NkTSHZSxfS8SVA+Rz9xHptJX789zPkhPas=;
 b=YM4JcAAFCxl0Jtnl00UG4/uP3uvAscS8vs9xDB3x0HRwffyIjVeqj4h5//psQZDxoIK17nvWg
 YqF+DwflyXVC7ICZLSUlVneP2QRaeJ6880OUFr7TOZmomhgxeYR7ulr
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This series aims to improve driver readability and convert it to the
Linux driver model by means of a platform driver.
Furthermore, support for minute-based counting has been added to allow
timeout values longer than 255 seconds. When setting a timeout value
that is not a multiple of 60 seconds, the value is rounded up to the
nearest multiple.

Notes:

  - PATCH #2: I could not introduce a macro for each hard-coded value in
    this driver, since some datasheets are not available (to my
    knowledge) on the internet.

  - PATCH #7: I have moved the code that refreshes or stops the watchdog
    timer out of the w83627hf_init() function and into the wdt_probe()
    function. Keeping it there would have led to code duplication.

    Since the timer has a granularity of at most one second, this does
    not introduce an unexpected reboot: the timer cannot expire in
    between, as at most a few milliseconds would have elapsed (the
    margin is < 1s anyway).

This series was tested on a x86-64 board featuring a Nuvoton NCT6126
Super I/O chip.

Best regards,

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Changes in v4:
- Squashed last commit into patch #2.
- Applied suggestions of Tzung-Bi.
- Added one commit in the beginning of the series, fixing an issue
  reported by the kernel test robot that is present in an older commit.
- Link to v3: https://patch.msgid.link/20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com

Changes in v3:

- Drop the platform device resource for the Super I/O configuration port:
  claiming the shared 0x2e/0x4e port could break concurrent
  request_muxed_region() users on module unload (Sashiko). The port
  address is now passed via platform data together with the
  configuration keys.
- Patches 5 and 6 are merged into "Store Super I/O configurations in platform data".
- Validate platform_get_device_id() and platform_data in probe before
  use.
- struct watchdog_device parent member is now assigned to pdev device
  instance.
- Re-parent this series on 7.3-rc5.
- Remove the dependency in the cover letter since it was merged.

- Link to v2: https://patch.msgid.link/20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com

Changes in v2:
- Initialize res stack variable in PATCH #5.
- Reworded PATCH #1. Describe the introduction of BIT().
- Remove the usage in PATCH #8 of goto in error path.
- Dropped PATCH #9. Squashed with PATCH #2.
- Link to v1: https://patch.msgid.link/20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com

---
Paul Louvel (6):
      watchdog: w83627hf_wdt: Fix watchdog identity truncation
      watchdog: w83627hf_wdt: Replace magic numbers with descriptive macros
      watchdog: w83627hf_wdt: Convert to platform driver model
      watchdog: w83627hf_wdt: Move register offsets into driver data
      watchdog: w83627hf_wdt: Store Super I/O configurations in platform data
      watchdog: w83627hf_wdt: Add minute mode counting

 drivers/watchdog/w83627hf_wdt.c | 467 +++++++++++++++++++++++++---------------
 1 file changed, 299 insertions(+), 168 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260713-w83627hf_wdt-improvements-ba2364157d6e
prerequisite-change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936:v4
prerequisite-patch-id: 1162062ebf31e7c2c70ff52b79118b67b00c396b
prerequisite-patch-id: 9638243b3ade2a4e9c3e94664343b235e5cb806d
prerequisite-patch-id: 73803f726f2fab91516b429f79a59c2d3a574cfe

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

