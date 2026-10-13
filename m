Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399703F104F;
	Tue, 13 Oct 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899947; cv=none; b=ptRj7LjWg2G/SLdcd118R2KlB/mtFUK8cgQWqRDqpO066vY3C1poy/3bz6yU9WwoDiCRriVTchpHe+HBYXLD0FA2wlYg4kq5v+AmuTlzV7sSIpOcGq/kRZf6X5UtkrrxK/x67jE+/DXYDpqCubYUN/rcZBDAUPXDm9NtwUpaDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899947; c=relaxed/simple;
	bh=yjgNvB44tAwksIgWsZz+Lz06Io3rRVtLbxErqnPAPzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RguW5IlH0r+CA3f08iLzYgES2pfNyN8RK8djG1XrSj3qrGzUj+wlcyqGyFa023MXP/mTWClt+af8e5h2qeCZZB3dfFGo9DVW5doQbcTAY+Lpj6/R0SRwATArT2dzbPvq3NlKG0vu5SLyMw/hF7Ijo04HCg0Cm30CIZMGWMC9Zno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cyig1wnQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cyig1wnQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 423B9C653F0;
	Tue, 13 Oct 2026 14:00:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AFB3260362;
	Tue, 13 Oct 2026 13:59:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD1EE11D713D2;
	Tue, 13 Oct 2026 15:59:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791899943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C9LXSDfYW5jVDhepa8ckaUcaVU4p7hDqlXynHWjrKEw=;
	b=cyig1wnQS/pMrizFR8hr23gjjXJy0demLnRtJNOqqHXKYx+FMjNTsZBUbcXNT8YAezwZ3k
	7gSoQMJE7iGsdXGHrZDC2ij1uoIMttk+Ag4RIcexSbNeRQcY3chO5N5CH6H3QdX+OlIRnS
	eFVUGCbK39YLkS1sSrK8MHaR3LGPlWXjtR2suYCb3oM1fYsufvhj+F5Bw7VCJ/DaLfPHFC
	xOcxVIWfc4CMHBJWKg3uyl9UOw+O83wREx1/1Ag9r2D6xJR2t+iofzF1Vq6wuMaL51SDIj
	7fVl54FiDy09vYGpCvswWn+2bat0ch6iNVnaq2uRN0HJdl5a+uYq6VWblt5DkQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 13 Oct 2026 15:58:45 +0200
Subject: [PATCH v4 1/6] watchdog: w83627hf_wdt: Fix watchdog identity
 truncation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-w83627hf_wdt-improvements-v4-1-b6f6b60a9566@bootlin.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791899939; l=1250;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=yjgNvB44tAwksIgWsZz+Lz06Io3rRVtLbxErqnPAPzo=;
 b=eg8mEEVHeQ6xMsh6ukbD/JBVtoCZi8VtEz8/pF69zg83XJ7Ux1Js3Shqod2K7wDxH8zxudyd+
 Wj7v5uks6PCDTff8Rv68k0ok2+Wz0zlSN5LQStRs29dFINU/BNwfP5G
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The identity field in struct watchdog_info is only 32 bytes in size, but
the identity could be at most 33 bytes in this driver, resulting in
truncation.
Remove the "Watchdog" suffix, as this is implied that the device is a
watchdog if a user request his identity.

Cc: <stable@vger.kernel.org>
Fixes: 3d6757a640f8 ("watchdog: w83627hf_wdt: Report the probed chip name via WDIOC_GETSUPPORT")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610080027.3OsJDwfo-lkp@intel.com/
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index db77599e43a0..0fc7648ef337 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -525,7 +525,7 @@ static int __init wdt_init(void)
 	pr_info("WDT driver for %s Super I/O chip initialising\n",
 		chip_name[chip]);
 
-	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
+	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s",
 		 chip_name[chip]);
 
 	watchdog_init_timeout(&wdt_dev, timeout, NULL);

-- 
2.56.0

