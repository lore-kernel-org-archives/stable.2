Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464089;
	b=X1e6hK0L9x29hoN/HR/JBZN9l5Z9wRe8fEaCUYL/PC+xJJGxmiVPBouY5gzCROWyuc4x
	 lFPPNzWglq83q4mTkLvGnaPvPuRYbI0LZqj0n8qnP6SWv30ifK+2gwGDsrw+ehCieeYvF
	 Pngt81mHl3X9lt1NzS2BxpQErsqoTCfJ/uoEr+c9wpO6+KJLBVaWaSDK+8J47JsvkiyvY
	 vHrdkoYjYOGQ8xHEK2Dn9b0W6rjeN4p/ALUs69eSrIuJOOlW82WALjvD1XMFVPXETrAEG
	 ATUdeGs91HQ32RfSAwts+zZEDadfBDN4S1pDHXfkpRVlP6Htj2FgkIMtG63OZbL9nlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vl/t1brpFMEqqKOGGmlaPM+Jlj8aMd6VrhVMqs5Y1sI=;
	b=XMAFxx75cTjjnIUA6+Mh7MScTEHCzHc1DjWX9VVciwVnA0W3VKob8wZyyoFieH3Ez5EZ
	 LgPw/Wb7B+6bDkT4EgVYmXKKMsKaNEGDEL/Ey4Jmt5u1XyaqwwpwEztQHkrFsk+N/7WRc
	 qAAbo6B/wcpGHGxUCo1vLxzBtFfloTyOCcWvGXfxZTn9D9FD/r3x0/dtxWZffSehn3GOR
	 H5m8bg82tMHJztSfAO1sMZDtFA1LWRkI8ZYIQVzANYsVbvTs3/k6LWJnqvC9PJi0rGa4Z
	 VG3N3uZqsReVqGFF0MSwnkkfGAPULk3rkOUi9TbNtISFkMOBPC3SM+5EmT+hqBF2K9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4gI3hLf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54C606A32A;
	Mon, 23 Nov 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4gI3hLf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEA51F000CF;
	Mon, 23 Nov 2026 20:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464088;
	bh=vl/t1brpFMEqqKOGGmlaPM+Jlj8aMd6VrhVMqs5Y1sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F4gI3hLfvNc3b0wrKuaNdvmdjMGsV7POsgDblFgG3X/crY4xXOgFQ/Ec3IhdF/bIo
	 JJsblR0u4kiGYLRQwATlPnIaXCc+wtlWNhMrdN1CYc97LDXaFiayDnepXJwyGNsb9V
	 n9yYlN2+4dmtUk15SNBR20NChWpS7v5v01dCDEs0tDsRBnhLDUFqmURxyfKlffNxpl
	 PyIbRADTxT7hBhqcYnn99gem0a/jBIPWhZp2NQ1ZJLoZIJOmnjrSJkeFdh139z+N5r
	 9JavKWgY4vTejMW4W8Mr0bUzGq3jtz2ww9SqaXC0CTCJr8C07oFIum8bQYDH6QeK9n
	 H2k2Qxs7kC1eA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	"George G. Davis" <gdavis@mvista.com>,
	or <source@mvista.com>,
	Johan Hovold <johan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] rtc: omap: prevent NULL and dangling pointer dereferences in power-off path
Date: Mon, 23 Nov 2026 19:59:20 +0000
Message-ID: <20261123200012.502284-10-lee@kernel.org>
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

omap_rtc_remove() only clears the global omap_rtc_power_off_rtc pointer
if pm_power_off still equals omap_rtc_power_off.  If another driver
overwrote pm_power_off after probe, unbinding the RTC leaves
omap_rtc_power_off_rtc pointing to freed memory.  Furthermore,
omap_rtc_power_off_program() is exported and called directly from
am33xx_rtc_only_idle() during suspend without checking whether
omap_rtc_power_off_rtc is NULL, causing a NULL pointer dereference if
omap_rtc_power_off_rtc was never assigned or was cleared on unbind.

Always clear omap_rtc_power_off_rtc when removing the matching RTC
instance, and return -ENODEV from omap_rtc_power_off_program() when
omap_rtc_power_off_rtc is NULL.

Fixes: 222a12fca604 ("rtc: omap: add support for pmic_power_en")
Closes: https://sashiko.dev/#/bug/linux-97b795c5-f68f-4228-948f-547a106c6775
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-omap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 3c978edd6c2c..156444fab916 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -416,6 +416,9 @@ int omap_rtc_power_off_program(void)
 	int seconds;
 	u32 val;
 
+	if (!rtc)
+		return -ENODEV;
+
 	rtc->type->unlock(rtc);
 	/* enable pmic_power_en control */
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
@@ -481,17 +484,19 @@ EXPORT_SYMBOL(omap_rtc_power_off_program);
  */
 static void omap_rtc_power_off(void)
 {
+	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	u32 val;
 
-	omap_rtc_power_off_program();
+	if (omap_rtc_power_off_program())
+		return;
 
 	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
-	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
-	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
+	rtc->type->unlock(rtc);
+	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
 	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
 			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
-	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
-	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
+	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
+	rtc->type->lock(rtc);
 
 	/*
 	 * Wait for alarm to trigger (within one second) and external PMIC to
@@ -913,9 +918,9 @@ static void omap_rtc_remove(struct platform_device *pdev)
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
 	u8 reg;
 
-	if (pm_power_off == omap_rtc_power_off &&
-			omap_rtc_power_off_rtc == rtc) {
-		pm_power_off = NULL;
+	if (omap_rtc_power_off_rtc == rtc) {
+		if (pm_power_off == omap_rtc_power_off)
+			pm_power_off = NULL;
 		omap_rtc_power_off_rtc = NULL;
 	}
 
-- 
2.56.1.750.gf70dc682cf-goog

