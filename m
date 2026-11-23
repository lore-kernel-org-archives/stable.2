Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464082;
	b=xxhnECNHLoUxC4KFiS07HcsIO1O356i4AhjaKmTMWKQTfbhjGnByP6rr+JjH5ZSPr9/S
	 rAUrCkn5CAZJh24I/mUOfV0cUW5eKb4l1RcO66yHjK9nhYTNvKd6dP6P3hnmaao/cMh/e
	 T/R9hWmGNMnd7z093QI1drzCqejtO5aLt6aG5ogPEWdrJEDDHEY17Am37dXEXbtRedeg+
	 8BzRtTkXTThE6Qxcj6cpzoqVeXK0ALeRumr7yUqIYK0DQvpkNmX/HZuaXjPMX8zF+vuqk
	 hJ18tabNLXdMtO1OWCyLI80fgLA6uRh4X/U+j9rA+WpOUzI7nr4kc3o/Z944E0qdVXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kK2B8/scONiVfNFi55kihDK4ofM9j7KVLp2zW3E/5wI=;
	b=jDLjLn6xcs8WiX2NARxpwC7Mm6TgNyqghT6pT4JqLG6LAOoil9xmFKQvjtcHNk3BQpTW
	 JPUXQvbHcHv1eLwpdum2lMkPwjvQN/3QVq7ybuC203Xc7ZJWe11sP8J6TpuuHK3/gyC0m
	 FTueuVfIMDovIcTXd4RtgdtiNBBIRaT+AGdM7hV9PE3atSt3amUpDC3vre7CcXQ0L7kzP
	 QWoUg0lM4O45F8iTf/H60jfZEoCz4Ic3bMDCZuySAFEUJRh+Uafw1WQYv7rrIf4ZPwc47
	 1PkXL3FAd8GWWCBj4D+KGmEkOqnLxDymcAgFS76jKI7NvfKCxClere6N5Jq54ftuq/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aw0xQaj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D172606A31F;
	Mon, 23 Nov 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aw0xQaj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673D91F000D0;
	Mon, 23 Nov 2026 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464082;
	bh=kK2B8/scONiVfNFi55kihDK4ofM9j7KVLp2zW3E/5wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aw0xQaj9r4DiFSn6aNI3iE2pRQsGjObrX35hBvXo8jTyqCsgpNOLGV+3vFrYNsDsE
	 a0/PVIM9+wC3XJm7dBvqvL3YUXU9dfwD0R9/J65jOn8yZNsVKA90Fsr3G8N+wisAKq
	 k1pObfLvmO0By5L8swZXuPfRAR+jgG0pbYuSP9ETSPOZUkaqX2kr7iTznklKnlzsAb
	 f74V7GjNuSfGr5tKLDnKP0CUBnvuquk1yJoEBGhqp7ojKPx5WePofuELuWj1CYSSGA
	 eYPmXddE+nF4Tb/dEWeXMe1RXDGBlgbAiR3r4xRwXlNeIaVT6krABFQp55oxrh1gcX
	 WwpRUhq6fLOjQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Joshua Kinard <linux@kumba.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Imre Kaloz <kaloz@kernel.org>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] rtc: ds1685: check driver data for NULL in ds1685_rtc_poweroff()
Date: Mon, 23 Nov 2026 19:59:19 +0000
Message-ID: <20261123200012.502284-9-lee@kernel.org>
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

ip32_poweroff() invokes ds1685_rtc_poweroff() with the static
ip32_rtc_device platform device.  If ds1685_rtc_probe() previously
failed or the device was unbound, platform_get_drvdata() returns NULL
even though pdev is non-NULL, causing a NULL pointer dereference at
rtc->irq_num instead of entering the intended fallback spin loop.

Verify that platform_get_drvdata() is non-NULL alongside pdev before
dereferencing rtc.

Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
Closes: https://sashiko.dev/#/bug/linux-0a1838c9-65d2-4d1c-bc21-35a6a2582144
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-ds1685.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index f27d6ae4f783..c577adf8414d 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1370,14 +1370,12 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 	struct ds1685_priv *rtc;
 
 	/* Check for valid RTC data, else, spin forever. */
-	if (unlikely(!pdev)) {
+	rtc = pdev ? platform_get_drvdata(pdev) : NULL;
+	if (unlikely(!rtc)) {
 		pr_emerg("platform device data not available, spinning forever ...\n");
 		while(1);
 		unreachable();
 	} else {
-		/* Get the rtc data. */
-		rtc = platform_get_drvdata(pdev);
-
 		/*
 		 * Disable our IRQ.  We're powering down, so we're not
 		 * going to worry about cleaning up.  Most of that should
-- 
2.56.1.750.gf70dc682cf-goog

