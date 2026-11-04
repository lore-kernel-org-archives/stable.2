Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817610;
	b=BywIWsFlS2rOLgjhaynEMN/At0IhbD1BMFHvIVmJOgWSGpx8JiGoJZ1+bAOPlcpjofR4
	 cY8diNMd0yUHwlL3KtMJJDSfzkrZk7CwR6LO+WcQ3Im6AKMP6jKTOYc07071l9UnJD/xZ
	 N8zvdE/dRhAzwBZGgjoTfbdGtoJHQ8eboqhQZ5c73YjJA5C78FBWDkPzmnseHEFPrHO5g
	 2f51cl47VD0lPZxjKW44Y8lP9qbc7WHQrdCDvrTKCUj23+XplcSNqk8V3sPk1pY46/E5l
	 O6RckjFd//8CNdQr+oWW5+wosgUpsJoFqNwcsYp2Yys1s6SJFvdaWjuYKxYIaRn4+qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H7DSvpNWecmlcUmyBezUt7JthYYHvuN+cydUO7lef+0=;
	b=wbn56q00lchRmxbM8X0iYVOx7T5sagq3omyyiTx/Wli+d9lUON4QGPAcMkb4ss4mR9e6
	 5AqeVsG/4vuwY1OEgGD26bE5Oi5PXw7k1FgRkDZubUjq1jMkssvqUYwfRuOHnJ7XYUgp4
	 PR4grA27PfisJgN6PpUW4UsNbAx2xy9C8P1NNGQlRRbbEOq/2nayeS6bgfzLdGf5DcGk4
	 1IpG4tQF8hcadkt3v6CxGy0JmRUL2mS5R5gg+jG7QCIqhXPa5tJXD2fgUxf5EX7+gV5/W
	 2s7r7Rn4fpKn1gwIiVlICmS8D1Jvs9sOxE2TGSf469G4rAzkCxkaJL7/2d9P+u3rJhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGgeVRNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B6606D815;
	Wed,  4 Nov 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGgeVRNU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ED51F0093A;
	Wed,  4 Nov 2026 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817609;
	bh=H7DSvpNWecmlcUmyBezUt7JthYYHvuN+cydUO7lef+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGgeVRNUTDiNmBuhXhrk3Qy6fy3EOCR9Hb6nmzrUWw/XuqWbdYJzljEEOZobjoJYM
	 21md2l0cg7uD09SBcgLqm1yBXHaXzb8WamTQ/R1BYoVtKojf0PmP7VAweJPsp0re0a
	 bgB2q3Ic0s5/z5+RFCyg8MtKCU8Lxiib0OPAgDeoTuJQB+p9G7QIrDInHXJNzpOaCj
	 p1NW/3qmH3amxm/YIr1iOa71QF4pSXTYpGQMjzelBw18jYU4JMFjS8JY1zEmX8z/SR
	 B4f5HhT6Q01h3IjzKsY+uXdiPErX6FO/965W3LS/C6DZPtq2TxpHYK9X/K7zNoy6Ek
	 HTFZGxaYegX3w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Kiran Gunda <quic_kgunda@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Heidelberg <david@ixit.cz>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 4/6] backlight: qcom-wled: Manage teardown via devres and remove wled_remove()
Date: Wed,  4 Nov 2026 18:39:05 +0000
Message-ID: <20261104183935.1214630-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104183935.1214630-1-lee@kernel.org>
References: <20261104183935.1214630-1-lee@kernel.org>
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

wled_remove() currently runs before devres tears down the backlight
device and threaded interrupts, resulting in two teardown bugs:

1. mutex_destroy(&wled->lock) and cancel_delayed_work_sync(&wled->ovp_work)
   execute while the backlight device registered via
   devm_backlight_device_register() and the short interrupt requested
   via devm_request_threaded_irq() are still active.  A concurrent sysfs
   brightness update or short interrupt during unbind can acquire the
   destroyed mutex and re-schedule wled->ovp_work before devres frees
   the wled structure.

2. disable_irq(wled->short_irq) and disable_irq(wled->ovp_irq) are
   called unconditionally even when the optional "short" or "ovp"
   interrupts are absent from the Device Tree (-ENXIO) or unused (0 on
   WLED3), passing invalid IRQ numbers to disable_irq(), despite both
   interrupts already being managed by devm_request_threaded_irq().

Initialise wled->lock with devm_mutex_init() and remove wled_remove()
so that devres tears down the backlight device, short interrupt,
delayed work, OVP interrupt, mutex, and driver data in reverse
registration order.

Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Closes: https://sashiko.dev/#/bug/linux-51cd5e35-3cae-4e4c-986b-7261263507cd
Closes: https://sashiko.dev/#/bug/linux-44e5ed80-c35c-4786-8bf8-9ee955967d0b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

 drivers/video/backlight/qcom-wled.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index f8f41e1d6ccf..8d4d7fe5e84d 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1732,7 +1732,6 @@ static int wled_probe(struct platform_device *pdev)
 
 	wled->regmap = regmap;
 	wled->dev = &pdev->dev;
-	platform_set_drvdata(pdev, wled);
 
 	wled->version = (uintptr_t)of_device_get_match_data(&pdev->dev);
 	if (!wled->version) {
@@ -1740,7 +1739,10 @@ static int wled_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mutex_init(&wled->lock);
+	rc = devm_mutex_init(&pdev->dev, &wled->lock);
+	if (rc)
+		return rc;
+
 	rc = wled_configure(wled);
 	if (rc)
 		return rc;
@@ -1822,16 +1824,6 @@ static int wled_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(bl);
 };
 
-static void wled_remove(struct platform_device *pdev)
-{
-	struct wled *wled = platform_get_drvdata(pdev);
-
-	mutex_destroy(&wled->lock);
-	cancel_delayed_work_sync(&wled->ovp_work);
-	disable_irq(wled->short_irq);
-	disable_irq(wled->ovp_irq);
-}
-
 static const struct of_device_id wled_match_table[] = {
 	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
 	{ .compatible = "qcom,pmi8950-wled", .data = (void *)4 },
@@ -1846,7 +1838,6 @@ MODULE_DEVICE_TABLE(of, wled_match_table);
 
 static struct platform_driver wled_driver = {
 	.probe = wled_probe,
-	.remove = wled_remove,
 	.driver	= {
 		.name = "qcom,wled",
 		.of_match_table	= wled_match_table,
-- 
2.56.0.385.gac671c819a-goog

