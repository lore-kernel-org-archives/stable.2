Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817624;
	b=R5CvYjsXUEV4QCNElGBVD/a3LqvFlDV9V9OcSPMAhoQrtJmpLq03LuuN++DclrBhpId8
	 Lj3B9MHyn0U0vNNtYu7XkMbE+qFPfcYIh7ugeKH9a51SW+G6xiwPN3ZI2rk0mXzekHGEV
	 Usgr3IOGsrXmYkRT4NbT+hy5xYObn47kSKEan/TDXNUEiLSF/GcRSn9+zvXDmhlx0E9jJ
	 iAZeC5rofwcIXlU/IAzrN/7B4NwZiAsrxZDh5dPvIPw0Km5Jb/sWC8Al+EohI9ixvWm8h
	 aNtq7g/7ME4QXLz0i9OWHlu/HIG5xJcpvjfigp1T+gH3n+AOUmk2NmG4EYvOUqSHaAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=50rGR9cXkJVQg5CMtsd6DUV43765lQnsvly1XxdMTMQ=;
	b=CQdBAWeJuwwwv4z3SmpbNi62KCzMA/UWh+xqum5TtdyJMTHSdB7L9WDhV/a5R6RgCR7j
	 tLmNEHEEGAF2STxrxh9/Rv6pze9Puvj0gZD+CEFxiP+i8PhawpWNqSQN9mybAAQOwYjcQ
	 NgCsW0OHSbqf8GYQMORJQyzLk+B+IlUkhH8mgAVErM7qTqCK3jNN/Ncy2DMakSfGW5L0S
	 JjA9FKXHmFfn9kjQrBjepU4UMyNrErBeh4Jvb2gp0rgeWoBkreluJkLDZ8QtMVIIXdSu2
	 Kkrqp6Z9ySZTjkyMnKNqag8SL67Pg9s/QG8BhTRiIwxceYT9TF86XvGScgbQFMmYkSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YH0owmrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0225606D839;
	Wed,  4 Nov 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YH0owmrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962011F000C1;
	Wed,  4 Nov 2026 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817623;
	bh=50rGR9cXkJVQg5CMtsd6DUV43765lQnsvly1XxdMTMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YH0owmrtK0BSOY0x3Udi9bIcHuJ5NxapbuTyxP+I4SQv3U/IqGFPZfunwyQHccvbC
	 8Injk0sgWFwIYXNaH3xgJ4T/UtI/pjC6BMRogOAvegaVXG1Ruiv2aK1o9yzCpQylvJ
	 /JELR22lVcTufOn255egMd3KW7pbt2pmeEvXNFOGfEMkKFqEe+Lu3QMzMNIc2B7phe
	 XkutnkQQSYtdvzRpwMq4jLxMb1QJgBVeAm7LfBMBK+bE7zpOsdWSEz8X6BJL15buFv
	 IzS3amhkb7hmfVgn+zB7hnroZpF7YW3wdR9TXovqhzgNm2CNBdYn94DslCSlNm4ouF
	 DJU1y1fIa6mGg==
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
Subject: [PATCH 6/6] backlight: qcom-wled: Avoid AB-BA deadlock in wled_module_enable()
Date: Wed,  4 Nov 2026 18:39:07 +0000
Message-ID: <20261104183935.1214630-7-lee@kernel.org>
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

When disabling the WLED module (for example from wled_update_status() or
wled_short_irq_handler()), the caller holds wled->lock and invokes
wled_module_enable(wled, false), which calls disable_irq(wled->ovp_irq)
and blocks waiting for any executing OVP threaded interrupt handler to
complete.

If wled_ovp_irq_handler() is concurrently executing, it attempts to
acquire wled->lock before running wled_auto_string_detection(),
resulting in an AB-BA deadlock between wled->lock and IRQ completion.

Use disable_irq_nosync() instead of disable_irq() in
wled_module_enable() so that the OVP interrupt is masked without
synchronously waiting for the threaded handler while holding wled->lock.
Because wled_ovp_irq_handler() may already be waiting on wled->lock when
the module is disabled, verify under wled->lock that the module is still
enabled and not disabled by a short before running
wled_auto_string_detection().

Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Closes: https://sashiko.dev/#/bug/linux-3afa151c-7b8f-432c-8f85-8c43a83b964a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

 drivers/video/backlight/qcom-wled.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 06300d403f8f..6c0f631cc975 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -367,7 +367,7 @@ static int wled_module_enable(struct wled *wled, int val)
 			schedule_delayed_work(&wled->ovp_work, HZ / 100);
 		} else {
 			if (!cancel_delayed_work_sync(&wled->ovp_work))
-				disable_irq(wled->ovp_irq);
+				disable_irq_nosync(wled->ovp_irq);
 		}
 	}
 
@@ -919,8 +919,15 @@ static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
 	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
 		if (wled->wled_auto_detection_required &&
 		    wled->wled_auto_detection_required(wled)) {
+			u32 val;
+
 			mutex_lock(&wled->lock);
-			wled_auto_string_detection(wled);
+			if (!wled->disabled_by_short) {
+				rc = regmap_read(wled->regmap, wled->ctrl_addr +
+						 WLED3_CTRL_REG_MOD_EN, &val);
+				if (!rc && (val & WLED3_CTRL_REG_MOD_EN_MASK))
+					wled_auto_string_detection(wled);
+			}
 			mutex_unlock(&wled->lock);
 		}
 	}
-- 
2.56.0.385.gac671c819a-goog

