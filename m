Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817602;
	b=ERuXlChThfoR4THZ9jR7IoQcQbMsbiwrTPYWUt1UhKc8kjVHX+a9Fd/htYSkpVwI7iHg
	 HYnlcfWZbB0bfmPHKd6FeIsPB8geqURIl2OXIiyIiSw3g/7RWjhOcsSkMVpSNhl/S586d
	 eNiNosw29u0ToTasBCmVi0k1imIYEN07qU8lNcY/+Y3lQanLn48BXQL4kL8oAgiFrDdCS
	 8c6JCKnueK/Shr/yrhsbGMk0IeXHv8r4w71wJTyerl9uMdRSfG6uaUAhK1/V9gdL2CVft
	 vwvh9o3kOsV3MFQjqeugBDUm4+dcD1OCgxTxaBZwiqVnr5wbdxHisIHByYa/kg4n9fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OLKZrOm6jdEcHH7I6hb2j6zTe/nROTdmF2ea7AaGN+4=;
	b=owGS0Nxva7IX+UxptnjY1l5KK9Wr9HFlO/EpWvj5vtr8Ib6Be9fSKNwx9RRSyp62MMXk
	 vtyPvSlim5Jj1CjIbc8hfHpzT27OwfulHGW7ag06I/p6mb4EHWIcr9eNQgVI1qOc+nAC0
	 NXZrIeP6ICyhZkIPsdbdyvz/7TqutSpC8V9c6fwUaC1MNG+webe7uo11oavFtpvJo3wdT
	 IHl9HYPPBHoZRD6+jX55/J6meihw+eJc6Lkc47VUXQrq0a8+EObL34mstBgb1sm0IkPKo
	 /eHSaRVSNXJXCFRgIEHBbjzCCHBcqYH9kT12N6268Lrf6YedqSd/sLgt1sXXx6ci0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9DRevod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274E606EEA0;
	Wed,  4 Nov 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9DRevod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7159C1F00A15;
	Wed,  4 Nov 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817602;
	bh=OLKZrOm6jdEcHH7I6hb2j6zTe/nROTdmF2ea7AaGN+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9DRevod4gGNgHJmbCYAxb8e7QqfBRMPf0bdS29bvOFlGcNzBgUiv7gKfscF0N+SE
	 zD4GyL0t43ZB6BX/u4JYjwh0sKQab3+e6fUT46XkR4pZ9ZJgV/3jQExGI8ZrIq8JCL
	 C0OrYgT0dpbctochsxL0ij1f5KCO5faCrTDRCwAFNubvvqSDkbJcOcNIQeghACyGyV
	 MDw7H4rIa/sj7RRyNXQPhnRe21/VqUgZsZMYZR7gZy9QB8z4Va7i6FYbDWOyAsJKvj
	 M88PEZewmdMJFgAS0RioN49imDjYzmM4C7Q1gKKV5ZcJkJo+feXhf2XPCl35L1ZaHh
	 gVCZEUVLc0qRg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Kiran Gunda <quic_kgunda@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Heidelberg <david@ixit.cz>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 3/6] backlight: qcom-wled: Cancel delayed work on probe failure
Date: Wed,  4 Nov 2026 18:39:04 +0000
Message-ID: <20261104183935.1214630-4-lee@kernel.org>
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

If a short interrupt fires after wled_configure_short_irq() has
registered the interrupt handler, wled_short_irq_handler() calls
wled_module_enable(), which schedules wled->ovp_work.

If wled_probe() subsequently fails during
devm_backlight_device_register(), devres frees the wled structure while
wled->ovp_work remains pending, leading to a use-after-free when
wled_ovp_work() executes.

Configure the OVP interrupt first, then initialise wled->ovp_work via
devm_delayed_work_autocancel() before requesting the short interrupt.
This ensures that on teardown devres frees the short interrupt first,
cancels any pending wled->ovp_work while wled->ovp_irq is still valid,
and finally frees the OVP interrupt and wled structure.

Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Closes: https://sashiko.dev/#/bug/linux-ca2e48a2-f511-44b8-a7d4-866f360bf107
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

 drivers/video/backlight/qcom-wled.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index ca350f320e17..f8f41e1d6ccf 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
 #include <linux/kernel.h>
@@ -1784,8 +1785,6 @@ static int wled_probe(struct platform_device *pdev)
 		break;
 	}
 
-	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
-
 	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
@@ -1800,14 +1799,19 @@ static int wled_probe(struct platform_device *pdev)
 
 	wled->brightness = rc;
 
-	rc = wled_configure_short_irq(wled, pdev);
-	if (rc < 0)
-		return rc;
-
 	rc = wled_configure_ovp_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
+	rc = devm_delayed_work_autocancel(&pdev->dev, &wled->ovp_work,
+					  wled_ovp_work);
+	if (rc)
+		return rc;
+
+	rc = wled_configure_short_irq(wled, pdev);
+	if (rc < 0)
+		return rc;
+
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = wled->brightness ?: val;
-- 
2.56.0.385.gac671c819a-goog

