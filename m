Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5913812C4
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926175; cv=none; b=Lc6yXLY3ZV4VyiZELgpB65WydlhVza/UzUZzztyMqxiiHyds29FfHbp+KK1aUApVAycVr8KK3W/SnqX78hrtmFXCkDchD8e3ldEdAJ0e0fZ6dXAnb75q3Zk8WBJPUrPhuaQZ4AxnN3g6guFniGecscHasuaiVlBcIlY734K+nVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926175; c=relaxed/simple;
	bh=FMRPN9Y76tIptyNi2JmzLZKW9dMV03aT18xaul3TjY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d4RfjuinHp+MLrHjocSnIAMg4mrp1hzO2ayAZc8KgLt+lKW7P2i+4DI2HMOpwGvQSPnz8Ol6E/jsDm/uiUGBvKkiEYAVXSW9eoLG4HfVG9rJ293kIAFTOb6/zjNCikUGh8hPPLi1SR8EJCBwZGvpZah6eaPbAcfMVUrdE1X076A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ecxuFXYU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ecxuFXYU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 21DB21A37D1;
	Mon,  8 Jun 2026 13:42:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E36025FFB7;
	Mon,  8 Jun 2026 13:42:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C035106A2943;
	Mon,  8 Jun 2026 15:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780926171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=UbKYuikAXlRTyfGisD/W3kGXaDtO/44JQg4hkKXoDZo=;
	b=ecxuFXYUIObuxlym46K5kGiamkqK4j/SUTNhFsiLfoF/AYUwTJXisIUuKlLtKDRxliEV7q
	Otb7wTEs++0I6V4P+8dEW8KI5nO4NdDZxu3W5qYVr0CdfItBVCTdCopo3v30MwrM+kXBXJ
	sdNuKTcTgd9vTIEghB9Ew21/6admKoL8EF6p160UwmDOZx9+hiIlg+pz7z06m6tUgF9M9V
	Oeq/nm0ojEUJhyusa28roFG7gTVpkzTdeRgOb1IZKej40hKPn4X9EcLBsEGCuIdgfJ7/44
	yOccoe46nAuUQ31QcTP3BgUmzR4mOOmxxZdwOwjQd7ATVbm32nfaVtfTGTMAdg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v3 0/2] nvmem: layouts: Add fixed-layout driver
Date: Mon, 08 Jun 2026 15:42:42 +0200
Message-Id: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLGJmoC/33N0QrCIBTG8VcZXndCbdroqveILpwemzBnuE0aY
 ++eBkHd7PL/HfidlYwYHY7kUq0kYnKjC0OO06EiulPDA8GZ3IRTLqmgNXg1dQ5nGJJHD9a90EC
 vljBPwGstbSMoba0kGXhGLPeC3+65OzdOIS6fX4mV9cuKPTYxYHC2EnWrkdHGXNsQpt4NRx08K
 XDiPxjbxzhQaJTmTBhTUyb/sW3b3q6lsMkTAQAA
X-Change-ID: 20260504-mathieu-nvmem-fixed-layout-24c6f8500bf6
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780926170; l=1421;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=FMRPN9Y76tIptyNi2JmzLZKW9dMV03aT18xaul3TjY4=;
 b=xiBXOncrwdb/MJICbP6DcuH/IUnlyuJS2bp2d+Le8QYFTb5W4hXcYUKFVEOG/KboPCnSziy7H
 nH/FaEODSV0CLjABVA9f1lsC/71BgPFg+stSmsFxD74ROQkgTCFHjnl
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v3:
- Fix device node pointer leakage
- Move nvmem_add_cells_from_dt() prototype to internals.h
- Enable fixed-layout as built-in by default
- Rebased on v7.1-rc7
- Link to v2: https://lore.kernel.org/r/20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com

Changes in v2:
- Fixed dependency on core layout code with CONFIG_NVMEM_LAYOUTS
- Make fixed layout optional
- Link to v1: https://lore.kernel.org/r/20260505-mathieu-nvmem-fixed-layout-v1-1-7f6ecbce108d@bootlin.com

---
Mathieu Dubois-Briand (2):
      nvmem: layouts: Add fixed-layout driver
      nvmem: layouts: Make the fixed-layout driver optional

 MAINTAINERS                          |  5 ++++
 drivers/nvmem/core.c                 | 24 ++-------------
 drivers/nvmem/internals.h            |  2 ++
 drivers/nvmem/layouts.c              | 11 -------
 drivers/nvmem/layouts/Kconfig        |  9 ++++++
 drivers/nvmem/layouts/Makefile       |  1 +
 drivers/nvmem/layouts/fixed-layout.c | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h       |  6 ++++
 8 files changed, 83 insertions(+), 33 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260504-mathieu-nvmem-fixed-layout-24c6f8500bf6

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

