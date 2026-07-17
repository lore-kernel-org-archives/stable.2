Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FBD40096B;
	Fri, 17 Jul 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297855; cv=pass; b=AFfvCuo0E7oxpLy47II328x6VOhaHtqOAgiUlsuDXxWKRyDCMtgYOP4Ao2UKheYCFT8VDMFm21cvDlWshbjfaKg7PVT458PUO1BZjdn4A8LxWT2105ghvVnQuMVygxW5G6Sv0AAkurOLKO4g9TKo10/zplHx8sGFNoRIq8Rjmcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297855; c=relaxed/simple;
	bh=1NzIq33Rk1skyMOZjZs6TKz7uab11yLglT40Ls7rp+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boppgymDBAaw0DYHAVZrAwmbEG3kEN95NNT7+NtrA71WcTVSN9be633Bcthsn62tP/31/g1mudI4lrCCOt7AsRDkOsJ2LGwoatFHPN6ffO5vuHSrVit3i7B1RLJDkTSdBFTbGj0U9MJLXQX1RVmkQQY6XHx2OqoRKFLJRjpTKOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=IovFTTOd; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="IovFTTOd"
ARC-Seal: i=1; a=rsa-sha256; t=1784297826; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CDkMTTxuUuk7SF1KddlgIXqNWa+X+ryUZ6W7ZBjtxo2+tVrR8KCgP9NZPYzos+A7cA7MVkWBHliKgNl1v2IL3m+8NWaAH1CJ0Nm1fSJMP3fMugyZ1HtCUyGuB161uveZoGaRcrkaziS2TMdHTJi4/Cqi8fBjvEDmZ5emCh2GTy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784297826; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=epmNXjS7d94Ny0G3QrInR/+5Mb0BLlrxlvJkC02EnzE=; 
	b=lxVfX2xUkWcVskpBJpSlIB/adeVtQFT4Q/gi1No48Zvh2n4F2/PtLd905EcLQV0qeSQPzM9Kb1nHAOGn5qKOeGJu4E/VrK2VAI40GaUcieNPecHI9CO8Cqsh77Ga1wMnsUNNhi6y3p+R1dfrF30U6Dbm3Sj861nCoGV5Sq0/X9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784297826;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=epmNXjS7d94Ny0G3QrInR/+5Mb0BLlrxlvJkC02EnzE=;
	b=IovFTTOdduyuOxDCRlNJ6SZVMU99gB64Zo1SoVFAAIsF7eiDSryxPaP9nNl/sjpl
	SUsYKCICECArOdFUQdKF3wUYlI2WO2xKACFSd2KkW+Ysf6eiWwVSQRmTHKN+KEUbhBg
	k9RjqdlDBdQKK7p0oVVV8V40jCbL0UOaFp3cP0JI=
Received: by mx.zohomail.com with SMTPS id 1784297824078494.6809075628678;
	Fri, 17 Jul 2026 07:17:04 -0700 (PDT)
From: Yo'av Moshe <linux@yoavmoshe.com>
To: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yo'av Moshe <linux@yoavmoshe.com>
Subject: [PATCH] ARM: imx: Fix suspend/resume crash with Clang CFI
Date: Fri, 17 Jul 2026 16:16:48 +0200
Message-ID: <20260717141648.1007059-1-linux@yoavmoshe.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Relocated suspend code in OCRAM lacks compiler-generated CFI type
signatures. When CONFIG_CFI=y is active, the indirect call to
imx6_suspend_in_ocram_fn triggers a strict CFI violation panic.

Annotate imx6q_suspend_finish with __nocfi to bypass CFI checking
for this specific indirect call.

Cc: stable@vger.kernel.org
Signed-off-by: Yo'av Moshe <linux@yoavmoshe.com>
---
Tested on a Kobo Clara HD (i.MX6SLL SoC) running postmarketOS edge. 
Before this patch, suspending the device caused an immediate silent 
hang requiring a hard-reboot. With this patch applied, suspend and 
resume work successfully.

 arch/arm/mach-imx/pm-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index a671ca498..d9b0c1803 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -360,7 +360,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 	return 0;
 }
 
-static int imx6q_suspend_finish(unsigned long val)
+static int __nocfi imx6q_suspend_finish(unsigned long val)
 {
 	if (!imx6_suspend_in_ocram_fn) {
 		cpu_do_idle();
-- 
2.55.0

