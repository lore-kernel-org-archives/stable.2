Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464053;
	b=qA1raB1qS3rgSX+En3pHXnOd3ckrrcurNtZ8Jxeyi9HKuntN018BtkGQF0HfvyW/fjDZ
	 3zqHHQ/n6NdHtvVI8lq60jHeeLc7QPEOm/IgGFifrnqMU8S6hkxiUdb79fMCG7ssq4bKn
	 4hThYa5zFBmzSDTXJpNe8OYrbE+bW892071biM9rKM0c/aWr8vJHXCQNFOJDbfLPfdEue
	 0aTLQ14nodtaH+alf7EnDYjFPK/ZWzSpKXUsTwUOhFdLTvRfZS8Zh1IU5od+uxASHhK/F
	 mX2O/UbrSQ5ucUBqm4vNyHDqWKklfQO6n8XRRCDvF5DevRaI+ygSs1sAwWYna/3dKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qozd99YJL3twZkc7ZAMBOzgl0FRKu2ucmAwQ2ZlTus0=;
	b=LAELZalpGDicu3vUuWqes9FfrtazoS2Eli0ANH2BmJIIgowBXRLok8N8GbAr2I0gM8a6
	 XSjiHuvtTrLsIGMPFgsa6achAQGaUwufVdwfaChAwfHGQiFqw1YujC94Fwa0pVJs/bY8+
	 qD0CrHL/hHdANpDiDS5FsGKeeBLk8Ca34/C3E2ZS/ILoICpHCcsuFKbXypOwtMzoOnr+b
	 DToKkICUpSXL+pkVssB32knFTU09tMxDbUISZ1gykVuJ/OgCHcrwctO7jdLtpC0yhISuv
	 cR+Lko97Ml+Lv/DCkPsM9vF8Uet6k6/b4vdjYOSDB44tFQaDiVenq/cL86it8ngaSAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYHm082z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6245606A31E;
	Mon, 23 Nov 2026 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYHm082z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131C11F000C6;
	Mon, 23 Nov 2026 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464053;
	bh=Qozd99YJL3twZkc7ZAMBOzgl0FRKu2ucmAwQ2ZlTus0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WYHm082zhWJIwclD18bOJ6iEVJef349LSS+IlN48u0wOCrtnXzWSw1pwYJk7V96Wz
	 2pEdZ7dTEkmQeQOhe6lTK59xEVuAjCcHn6G+70vPieCfxitL/ZbV50LHXu3x5VapOf
	 8XZQxXUEWVzcOP5F8UbvbPlRMzf6aYbqcyRgemF5GFeH+6n5L9Ys4L6qg/0LcZj4/J
	 dpMwqpi0rKqyyKjSL5Prae7yTjExzzQyoOjdJfS+DRvxMqjG6mUvYDJWfG9XYkhzZM
	 2HDDPoOGcMzJtXAp9fB0SKe6LM/MG5Lqll4oCFHXjSfECsiW9j/cb1kKpYSE86oooS
	 /qy6R9ouw2lgg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Domen Puncer <domen.puncer@telargo.com>,
	John Rigby <jcrigby@gmail.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] rtc: mpc5121: get interrupts via platform_get_irq()
Date: Mon, 23 Nov 2026 19:59:15 +0000
Message-ID: <20261123200012.502284-5-lee@kernel.org>
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

mpc5121_rtc_probe() maps its interrupts with irq_of_parse_and_map() and
requests them via devm_request_irq(), while the probe error paths and
mpc5121_rtc_remove() explicitly call irq_dispose_mapping().  This tears
down and frees the IRQ descriptors before devres runs free_irq(),
operating on destroyed IRQ descriptors and leaking irqaction entries.
It also passes IRQ 0 to devm_request_irq() when irq_of_parse_and_map()
fails.

Obtain both interrupts via platform_get_irq(), propagate negative error
codes directly, and drop the manual irq_dispose_mapping() calls.

Fixes: d53d4ae981d0 ("rtc: mpc5121: simplify probe")
Closes: https://sashiko.dev/#/bug/linux-3fc27b53-f5d6-493d-a3c3-2af748b44f7e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-mpc5121.c | 41 ++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index e1cef77c1a0e..331851378e8a 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -72,8 +71,8 @@ struct mpc5121_rtc_regs {
 };
 
 struct mpc5121_rtc_data {
-	unsigned irq;
-	unsigned irq_periodic;
+	int irq;
+	int irq_periodic;
 	struct mpc5121_rtc_regs __iomem *regs;
 	struct rtc_device *rtc;
 	struct rtc_wkalrm wkalarm;
@@ -307,30 +306,34 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 
 	platform_set_drvdata(op, rtc);
 
-	rtc->irq = irq_of_parse_and_map(op->dev.of_node, 1);
+	rtc->irq = platform_get_irq(op, 1);
+	if (rtc->irq < 0)
+		return rtc->irq;
+
 	err = devm_request_irq(&op->dev, rtc->irq, mpc5121_rtc_handler, 0,
 			       "mpc5121-rtc", &op->dev);
 	if (err) {
 		dev_err(&op->dev, "%s: could not request irq: %i\n",
 							__func__, rtc->irq);
-		goto out_dispose;
+		return err;
 	}
 
-	rtc->irq_periodic = irq_of_parse_and_map(op->dev.of_node, 0);
+	rtc->irq_periodic = platform_get_irq(op, 0);
+	if (rtc->irq_periodic < 0)
+		return rtc->irq_periodic;
+
 	err = devm_request_irq(&op->dev, rtc->irq_periodic,
 			       mpc5121_rtc_handler_upd, 0, "mpc5121-rtc_upd",
 			       &op->dev);
 	if (err) {
 		dev_err(&op->dev, "%s: could not request irq: %i\n",
 						__func__, rtc->irq_periodic);
-		goto out_dispose2;
+		return err;
 	}
 
 	rtc->rtc = devm_rtc_allocate_device(&op->dev);
-	if (IS_ERR(rtc->rtc)) {
-		err = PTR_ERR(rtc->rtc);
-		goto out_dispose2;
-	}
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
 
 	rtc->rtc->ops = &mpc5200_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtc->features);
@@ -356,18 +359,7 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 		rtc->rtc->range_max = U32_MAX;
 	}
 
-	err = devm_rtc_register_device(rtc->rtc);
-	if (err)
-		goto out_dispose2;
-
-	return 0;
-
-out_dispose2:
-	irq_dispose_mapping(rtc->irq_periodic);
-out_dispose:
-	irq_dispose_mapping(rtc->irq);
-
-	return err;
+	return devm_rtc_register_device(rtc->rtc);
 }
 
 static void mpc5121_rtc_remove(struct platform_device *op)
@@ -378,9 +370,6 @@ static void mpc5121_rtc_remove(struct platform_device *op)
 	/* disable interrupt, so there are no nasty surprises */
 	out_8(&regs->alm_enable, 0);
 	out_8(&regs->int_enable, in_8(&regs->int_enable) & ~0x1);
-
-	irq_dispose_mapping(rtc->irq);
-	irq_dispose_mapping(rtc->irq_periodic);
 }
 
 #ifdef CONFIG_OF
-- 
2.56.1.750.gf70dc682cf-goog

