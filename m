Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464040;
	b=zDLWapvIbQgpyeIshM2mOkF6Wg36Whs9UUkNEmwmzp9TXUkJJBcuWkFX/l+wt/x9eAJQ
	 4BqjpmZKfqc8IvxVAUV1fGx8K/9bGDo476sm14/re0RplxR/dFKiS4+LM8QkXIjwU10qi
	 KDn9GNJLWsHmJO4CAFrAtYwbLCbuiUG+HB3cbTeRpeeI8NmyBLxCW9eRy7JOTZuJ45Zqj
	 D1Lq0aac40F0Co2NRv45gHSyCVD6OcMWK9j6knnwDuvxuyOZiA1EljdDQDz0tkB2cFf1H
	 bBo+if007I8BYxlEAs9ei4cXzD3TwXvpDmZMEd9c79z2UeCaWK0SMkRc7MTrA+NPLSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2XPrAVxeEBOl/91jeQU5k7j8fuWUtX0/F5/UrgSfTUQ=;
	b=GMuUbWve+n4PIwJvyyzHFZ5LIjxDaiCA01yR1kd/ZgmPB8v4uhaXI1TR6OMUaUUZo+g9
	 m8+K90TaKxGctwnjchGqlOv3S+HmmzJh5/sDyVrET60chMWZPOeOqa6dXWgDL7PC3kPkg
	 nHbl95CBIIqnbTkm/cHx29r6tywVa6dpTxC71TN5ZYmy4Z1/IWnvy34JnKtgz1o94NvXQ
	 PflksjFOXOcY4hHfWLv4LeCNQjoF122UWQwmVdhnnGNNReR2Furdyh0sNCXhMFFS0BBpZ
	 yMzH0BUFKPK0k60Y9X0lhTfMUZKh6Su6UyF4vJlZImIHllQZ6Zizid79nzV1ueBRuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTYRYfo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27B606A32D;
	Mon, 23 Nov 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTYRYfo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658591F000C0;
	Mon, 23 Nov 2026 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464040;
	bh=2XPrAVxeEBOl/91jeQU5k7j8fuWUtX0/F5/UrgSfTUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hTYRYfo2s+ByadcdVqp89uBh0lCXz0eBLSeSrCSF1ZVmkASs7w6m5Q26vD2aeqi5/
	 qI9Z2HsdhqYKBU9KV5P0TWFUdR5hnBEpzbsbHPm93QEssAbVsljnoboHXxTGJJEBCN
	 hrXf0ErfvA315/YeANd6Y+CRBA2xVxF4wy8WAsBE9nUWJYK2tZKR5bJbMPAh6zs/I2
	 i6JnClLwWrfegfB52TqFH3wDPYH4KJE7XF83gED+C3w2/F8yvucGAH2z1uWbKrBD2O
	 FznccK18Ksua6d1K1rRkmL1R9gh4zHUplB4pkag5FgunplTuiQHPYScyZzAQXFG26i
	 xdlPoo3TIoXqA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryan Brue <ryanbrue.dev@gmail.com>,
	"Tianping.Fang" <tianping.fang@mediatek.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] rtc: mt6397: handle non-DT platform device matching in probe
Date: Mon, 23 Nov 2026 19:59:13 +0000
Message-ID: <20261123200012.502284-3-lee@kernel.org>
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

The parent MediaTek PMIC MFD driver instantiates RTC platform
subdevices even when the optional RTC child Device Tree node is omitted,
and devices can also be bound via sysfs driver_override.  In those
cases, of_device_get_match_data() returns NULL, yet mtk_rtc_probe()
succeeds with rtc->data left NULL and mtk_rtc_write_trigger()
subsequently crashes when dereferencing rtc->data->wrtgr.

Provide a platform_device_id table covering the MediaTek PMIC RTC cells
and fall back to platform_get_device_id() when no OF match data is
present, returning -ENODEV if neither match path provides driver data.

Fixes: 29ee40091e27 ("rtc: mt6397: Add support for the MediaTek MT6358 RTC")
Closes: https://sashiko.dev/#/bug/linux-35993d35-d776-4f86-9bd2-42c6ee078f88
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-mt6397.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index ab402f9f85c3..c40644ae509a 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -343,6 +343,14 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	rtc->addr_base = res->start;
 
 	rtc->data = of_device_get_match_data(&pdev->dev);
+	if (!rtc->data) {
+		const struct platform_device_id *id = platform_get_device_id(pdev);
+
+		if (!id)
+			return -ENODEV;
+
+		rtc->data = (const struct mtk_rtc_data *)id->driver_data;
+	}
 
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0)
@@ -427,6 +435,16 @@ static const struct of_device_id mt6397_rtc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
 
+static const struct platform_device_id mt6397_rtc_id[] = {
+	{ "mt6323-rtc", (kernel_ulong_t)&mt6397_rtc_data },
+	{ "mt6357-rtc", (kernel_ulong_t)&mt6358_rtc_data },
+	{ "mt6358-rtc", (kernel_ulong_t)&mt6358_rtc_data },
+	{ "mt6359-rtc", (kernel_ulong_t)&mt6358_rtc_data },
+	{ "mt6397-rtc", (kernel_ulong_t)&mt6397_rtc_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mt6397_rtc_id);
+
 static struct platform_driver mtk_rtc_driver = {
 	.driver = {
 		.name = "mt6397-rtc",
@@ -434,6 +452,7 @@ static struct platform_driver mtk_rtc_driver = {
 		.pm = &mt6397_pm_ops,
 	},
 	.probe	= mtk_rtc_probe,
+	.id_table = mt6397_rtc_id,
 };
 
 module_platform_driver(mtk_rtc_driver);
-- 
2.56.1.750.gf70dc682cf-goog

