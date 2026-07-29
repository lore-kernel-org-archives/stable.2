Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF847FB1E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328100; cv=none; b=ApMvPfJAR6MSZjh6O7jdErTKBt2Z4ddp7tEwWBoWGEuC7Z0GSeCxzkHdI8MHGJ5UrcB+MNt0dgeLKHreFGmyOTiSZ00lhgyDEFUP7CoiCgj18ODrEhfYbruuhzafdN7zmt1q17lb5QNYFz+paaHq8Pv7klA3AnUd8F3osEy94IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328100; c=relaxed/simple;
	bh=zu4+wloyKNWWz05nKOYLB56UokY6DFjHpoC2BlyTlpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qe4NrnjcwYZqDV+ecPVQH90zEFh4y+PVCGEJgjFNrpzlp+zBw/wLHcsSnUqGK8Oc/WzkkRUSQFZJz4UqN70TLwJwTWm4NvG7xnUvgWMWD1QDc2jTatavZBa+OQDRuWgK9y/vULVYt0GGALE8MOl27f99VFg4AQS5zz4EgNOFZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JiSopqkI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JiSopqkI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8B07F4E40FD4;
	Wed, 29 Jul 2026 12:28:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50AD56039A;
	Wed, 29 Jul 2026 12:28:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B472111C14DD4;
	Wed, 29 Jul 2026 14:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785328082; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=S42A0IMZbRThn5sDb6eVJo1awHUkhesBTha5FG+fLBE=;
	b=JiSopqkILWgrj750Ycx2GdgBNXzbYs21FoRaQhWz66MPhl/zKRiC/R3Y+lEI9Eo3IBaW7e
	f0iXaLba5+V7md6lbzNKVr1EVllIir9zfpBVn67MxNgeI9Q1i5GBIlUtSF9b2B0H815O6z
	viA3+Y7HYBG7KemGnPcOwcHhv66jIdm1AEJ1fj50W6eXZVA5lnKSF4WXvz9mopxehnuQdM
	Lc0alMGeC/VC1FGWQDJpJGvGhgheoHnc//HB6kWJ8eqf+QoZjCuMN6zFDyUEuOBY9w+yxI
	4q7cAPAEdCWbZNiVBStPo1b01kLsGNz9aGjJiu2Gv9BJa2QMVjb2dKOL08LSog==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Subject: [PATCH 0/3] mmc: sdhci_am654: Fix DDR50 mode for cards without
 tuning support
Date: Wed, 29 Jul 2026 14:25:41 +0200
Message-Id: <20260729-am654-sdhci-v1-0-7568108e4b9a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyML3cRcM1MT3eKUjORMXQtTA0uTFBNTi6TEVCWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgA6/BVGbwAAAA==
X-Change-ID: 20260728-am654-sdhci-85094d458bae
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=zu4+wloyKNWWz05nKOYLB56UokY6DFjHpoC2BlyTlpA=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqafHPLu64X/b6zDXINovnjLgRKYGJaZsje2chy
 K3MKfW08JKJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamnxzwAKCRAGvnxbVl7J
 RcCQEACQDhGAX67xuuAFF1Es5FsclGuyhR8IwUhfzV6pAN63RpDBzdeUk7UhBrgYB76rGI95O3B
 KClxCCoHUITnslGCN3/rNOJAKCE+hOrG6FjY7CBLS2YgWWxe+/Jzh1pkiC4vfR3CDZlG700NTH6
 v+fZxeGz7Zq4su/mMtYowzcX6uJeEKyHlSlrFtCWv84Dty5h2CNN5/Sct0BGtwmA+YC2oZxmkeH
 KOabjl1jm61lHsyu0pwWYyaeaRrRCpwzd6DqivcqQ2kXBrtTRxj16vTE3v8fs9LeCvbzoIcR9N2
 XYEe9cNm0EecXcZZXLagqk8gICNzPlAcW+O6FiaDRGOpQwUzrZ2DIXRWXFfH+G/d2HBPXJeQQ2X
 yXS0nYzp4OWRBvQYk9erFXsK8stmZWsm3VGdYw1dmncTfmwHNbw2dnroi1E2OKR6L2IKertWBD4
 W3M7L/gUXWXhfxBIAR3AIQwGeNwaipOYR6kVmHcpzZhTsNrEowoDblBN4mMccNH0aD/JeuETN28
 euHt8ieKQQFDCEKmACFW5WWOoXmaOjZBEJ8jsxVGm3KGEOFIytCrln0Srt1QVhSOU+bjLVW9tdr
 qdBxslMTBzzWGDUiFJCf4+V/v7emaeYAIacjETQuCQfq6OnxaLIHrvW5ji2s67QpIM5eiEfvFhO
 4yGS8zFPiSZ8efg==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

DDR50 mode is not required to support the tuning command CMD19 by the
eMMC/SD specification, meaning that calibration may fail on cards that
do not implement it. This series fixes three issues discovered when
using such cards:

  - Patch 1 ensures the command/data line reset is always performed
    after tuning, even on failure, preventing stale data in the
    controller buffer.

  - Patch 2 clears the ITAPDLY enable and delay values on tuning
    failure so that leftover calibration values do not interfere with
    subsequent I/O.

  - Patch 3 falls back to the DT-provided itap delay value for DDR50
    when tuning fails in this mode, making a best-effort attempt at a
    known-good delay being programmed.

Together these changes make DDR50 functional on TI J721E SoCs with
cards that lack CMD19 tuning support.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Diogo Ivo (Schneider Electric) (3):
      mmc: sdhci_am654: Reset command and data lines on failed tuning
      mmc: sdhci_am654: Clear ITAPDLY on tuning failure
      mmc: sdhci_am654: Fallback to DT-provided itap delay on DDR50 tuning failure

 drivers/mmc/host/sdhci_am654.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)
---
base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
change-id: 20260728-am654-sdhci-85094d458bae

Best regards,
--  
Diogo Ivo <diogo.ivo@bootlin.com>

