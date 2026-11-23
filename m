Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464075;
	b=ZraJjAft6xCJpMQlVwKSTi8nHu6lg2pcSG0mgqULSgpRDWdF76cPVvqOHiGz5pR1VKxA
	 m4WE5y2csE/Nwu4wEbzvH7UuA2JapsGMAFI+mZ0zBFTOeLCzWkWIIzaxgNfVBJzHa/6BS
	 U7XRWEkeJk6oAHVssVNWnetYXe9H3cpiIfgp4wdUfeYOa95pKEGdE+IgBeuR+DZcoi/JI
	 QNg4SRV6ZqtQhf3wxs9QE++ObhzbuGkp1WX57IM1QrUELJM/7/Wz6rdclpHJ+h5JOQJJ4
	 uNLSJhJXS3Kuo2d9//qfuNQ0Df5ccbEx7dQd5TagL4WvlShGAQC6/VwycIYl8m7WAig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JNW9jAUBmXvkOgGI+ui/EiNQfjcu4cOJrlbko1e1Y0A=;
	b=bLe7Xt0dX3VKcGNu3e71ugX5FJHmHsLeNla57scdkkzDx/JNtlfHsSQRgJUxodqewyOE
	 hiGH90Z0h8ORdxFBgGaGuLMNn52WEThPL9gAR4qULAtlyLOMOYA4U1wXuTbuwwRjRcIjP
	 p1eJyxhkDYixapYljUaA7gdokxjMeDFS6EIWEIBtfXMWEq+WoteE2IhO7UYhB+ya3Y3ru
	 KBoQXXQpnxZ/0qwPvYz4WjOUZHlzHgmIEu9tjIzlY/9WuMcW8UeTRr1aIFtdX/lobfNsN
	 6niAcxuvveP5LimoDhXTQ12SorO9HCtLkMFYaLCUNvK8DXxfZsk6wnMIomWyR0TKogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsotbfrG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82728606A321;
	Mon, 23 Nov 2026 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsotbfrG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFDE1F000D0;
	Mon, 23 Nov 2026 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464075;
	bh=JNW9jAUBmXvkOgGI+ui/EiNQfjcu4cOJrlbko1e1Y0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsotbfrGeOlzM3LXOZvq1dVrlbv5kwj3v85bUIAAIMeo+wzSth6qdDRqmpFlY/oug
	 UggUto/JhbjRG2UgcvsyhhCTbVUJrFobLH4eXANobdoA0wZSdtrPU02P0nAJSyzE2J
	 Woej5Mi+nenM6kse0X0MWzGH0kRBJdf6DXjG2mMb/N/2AgReT5QPaYViN4Gou+pweB
	 neGUbC2VCcUZBIVTWzBZVq4TsZDC/ZVkr2oK2jGR8hJK9WHCDt5XYed4zTvfQwN2zR
	 CkoT89q9DI/KM2ESiAZEOGVY0x+HnPt1YZVnupjz7F358vrWGRalBGWvxrwVaJMOuA
	 ETPH8ESNo7S5Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Hartley <peter.hartley@sigmatel.com>,
	dmitry pervushin <dpervushin@embeddedalley.com>,
	Wolfram Sang <kernel@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] rtc: stmp3xxx: unregister child watchdog platform device on unbind
Date: Mon, 23 Nov 2026 19:59:18 +0000
Message-ID: <20261123200012.502284-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123200012.502284-1-lee@kernel.org>
References: <20261123200012.502284-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

stmp3xxx_wdt_register() creates and registers the child
"stmp3xxx_rtc_wdt" platform device without tracking or unregistering it
when the parent RTC driver unbinds, and also assigns static wdt_pdata
directly to dev.platform_data where platform_device_release() passes it
to kfree().  After unbind, devres unmaps rtc_data->io and frees
rtc_data while the parent drvdata is cleared, so subsequent watchdog
operations or reboot notifications invoking stmp3xxx_wdt_set_timeout()
dereference torn-down parent state.

Register the child platform device via platform_device_register_data()
so its platform data is heap-allocated, and tie
platform_device_unregister() to the parent device with
devm_add_action_or_reset() so the watchdog device is torn down before
parent resources are released.

Fixes: 1a71fb84fda6 ("rtc: stmp3xxx: add wdt-accessor function")
Closes: https://sashiko.dev/#/bug/linux-4ddbfe9c-a03c-4a01-a3ce-357545121630
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-stmp3xxx.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index d79e282e3817..a5281b519540 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -92,24 +92,29 @@ static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
 	}
 }
 
-static struct stmp3xxx_wdt_pdata wdt_pdata = {
+static const struct stmp3xxx_wdt_pdata wdt_pdata = {
 	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
 };
 
+static void stmp3xxx_wdt_unregister(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 {
-	int rc = -1;
-	struct platform_device *wdt_pdev =
-		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
-
-	if (wdt_pdev) {
-		wdt_pdev->dev.parent = &rtc_pdev->dev;
-		wdt_pdev->dev.platform_data = &wdt_pdata;
-		rc = platform_device_add(wdt_pdev);
-		if (rc)
-			platform_device_put(wdt_pdev);
-	}
+	struct platform_device *wdt_pdev;
+	int rc;
 
+	wdt_pdev = platform_device_register_data(&rtc_pdev->dev,
+						 "stmp3xxx_rtc_wdt",
+						 rtc_pdev->id, &wdt_pdata,
+						 sizeof(wdt_pdata));
+	rc = PTR_ERR_OR_ZERO(wdt_pdev);
+	if (!rc)
+		rc = devm_add_action_or_reset(&rtc_pdev->dev,
+					      stmp3xxx_wdt_unregister,
+					      wdt_pdev);
 	if (rc)
 		dev_err(&rtc_pdev->dev,
 			"failed to register stmp3xxx_rtc_wdt\n");
-- 
2.56.1.750.gf70dc682cf-goog

