Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162946;
	b=Wi0dG3eD3+a+LqNSG0ynt0UEvTDnsHnVMSaoe0mCnEWYnB0YbXkwwSaXp/JxyhdyETU5
	 Mfz0JZtEylPTgy/SS1dVtMyzFrXpT3KFB5SzwxC4UD6LzsSI81giI+YFF4UUbkyq36MGE
	 bo/cNB52rI0gpAIFVzNmXgiHB/AKemGq7OmlGQEujd/WOXk3+twOvMst5/y/xj+sVqdm1
	 c/+LWr/d3oAMOvLt26FSKPdvEOUvCnORZSUsOKCWhlHA/agSsMh5RC0s6p4KFzlKkxm3V
	 naYLilg+3IEbbLasTtACbYo2fx2cdGFF01+nvDwCMBi6ALYC6LKoFeFeGR3V4YrUoWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162946;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0/FspPtWk32Yz6fJ9tp1ss0MflUZ+O7T2fNm7vOg7sE=;
	b=w1udEE9nWaMy0KvEoIx6lSpDq2CFKuvYKh6iGx81IxZ5rwdolUUz6P1U6PkqcjCOBB/V
	 qAD/CjQLn36g0gnXShIlrLIalykae/ufwqxhFLfOGMEJA1YDbJFcRVfdjrF1Hai+lfBtt
	 H7SrfjWBgxxtxljOPH6cDAcu0zbMzqwBmrPnMrNCUzWOvW2cXC8tB1WJgr+YxsjvBdSIk
	 YmxqapC8U/tkiAoERhYoNWSt4CPsIHkfW+pdL4ZUuhN9PITDc+l4WzPO7/O3CUn+pCHlH
	 eU8ivyyOZn/3TiKDCNu5Nj071i0czCTlRwT//ZLGfKbhanX/HL2uVHSuinF/shUUUUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="iwb0cb/r";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B20606A325;
	Wed, 28 Oct 2026 04:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B20606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iwb0cb/r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0/
	FspPtWk32Yz6fJ9tp1ss0MflUZ+O7T2fNm7vOg7sE=; b=iwb0cb/r11h0+dGOSC
	02alDFGfhjYmuUVeNWnue40WjW5OLHyK+IKdaGazuz37xObiwuyBFlWLNgUo9KIC
	n18gC+eXgTxxFxIWKiOpnIn4TVoH4kV8if3pDXpuzDTidzFTbTPS6C7rzOAInMG4
	mn5NzNbHwgMJvSWMhQGmG4YHY=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S8;
	Wed, 28 Oct 2026 12:48:36 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6/6] watchdog: rdc321x: initialize device state before registration
Date: Wed, 28 Oct 2026 12:48:26 +0800
Message-Id: <20261028044828.96177-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF47Zr4fKr4xKr18Kry8Xwb_yoW8XF17pr
	4akasIyrWDWrW2qw47Ww1DWa4rCayIgw17AryUKw1fuFn8Gr45tFyFv3y8Ka1ktFZ3A3WU
	tF1UtrW8uayUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j70eQUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQTbFmrhfqRWBgAA3F

misc_register() exposes the watchdog before its lock, completion, and
timer are initialized. A userspace operation racing probe can therefore
use any of these objects before it is ready.

Finish initializing the watchdog state before registering the misc
device.

Fixes: b3e8f2c13ae9 ("[WATCHDOG] Add support for the built-int RDC R-321x SoC watchdog")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/watchdog/rdc321x_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 8955177072fa..a2520d8d5c90 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -233,12 +233,6 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
 	rdc321x_wdt_device.queue = 0;
 	rdc321x_wdt_device.default_ticks = ticks;
 
-	err = misc_register(&rdc321x_wdt_misc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "misc_register failed\n");
-		return err;
-	}
-
 	spin_lock_init(&rdc321x_wdt_device.lock);
 
 	/* Reset the watchdog */
@@ -251,6 +245,12 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
 
 	timer_setup(&rdc321x_wdt_device.timer, rdc321x_wdt_trigger, 0);
 
+	err = misc_register(&rdc321x_wdt_misc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "misc_register failed\n");
+		return err;
+	}
+
 	dev_info(&pdev->dev, "watchdog init success\n");
 
 	return 0;
-- 
2.34.1

