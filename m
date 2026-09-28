Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDE49159C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590699; cv=none; b=ULMa9xKL8mPAGb+9WN05BrF2sNU7pLclBFk5N2bX4m7BZGS2LnNfm20TT5GavarL60To+tN1wSPrnqhVG81S17dA1KQuGBvo4aAaZo2wBxQBCqJz2748pjW5zw/5ZUY4hBBH6y1vi6alYcsuP83dWxPB+H2cTpyV5i5opWSsyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590699; c=relaxed/simple;
	bh=E1MhPQWSrLfY4VBaK8XBPOI9ZWR+ICi7Yfd3dmhR3H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4wMhHPHNmYnCbq44OIil9VqSfE/iKCxRfcSj9uG5KjLid1JVsE8HOpXPisjvjMq42H2zMjXeq0X2873f+uxWryocOQ6TCLgAy5j6f0a8hfBjHivj92oMFuLbchZ8s2gxIOPnfIkXH8XfyGHDP4wBExcVbIxGgDgRY7l8oJ9zXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSRBLZI4; arc=none smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSRBLZI4"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a6502b74abso20327711fa.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790590695; x=1791195495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XFXRt7k2N0Gwq06pxPx7MFAt+Ag+XYY7IlLvDigbagU=;
        b=BSRBLZI4WfL9aKG5uCht0B6xmygi1InhX1icWY3RtNFmp+LpS2rLKOkLWUXPRdYc0N
         vKg9x5p0WJvfE5VlbgPpoNGQ1nLtM6sb+pGAAz8XU0JNmfv0lpZ9dIiWCUHeUZfQl7Rs
         oEuHT65qnM9VYrBu1kPqhDThYFfvN3k8WJkAw9USgqsVdE+yiZ864gYI3fteR3lLLKpE
         6s3Pp/LES+cEtCfaFbvXonQ9RURrLsabmye8oModrO6Hhhf7dIaZRx9SChyhQyy2Z30B
         a2wTVTdCrMqh1Zfyfwfd9xdOt3mSzrW3gGo6pPFq4cucxQj7MajVoWHgmkv11r4ZzZv1
         +pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590695; x=1791195495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XFXRt7k2N0Gwq06pxPx7MFAt+Ag+XYY7IlLvDigbagU=;
        b=v+Cjg2hE/Aqk13h551i/+eN8iSEFCQd3I1TFUy8jBwJnkIBfbkygOAuylEHCx31eJc
         GH8fzLC11yzMe5vgi/5Pb3f0I5JFGJ2CKaJqPeonrNkbDe0//od4GieE/qnGoeGfigvF
         4BQ3lJn2pmoua4AtnHWH2ZUgKuXqM5eI/Y3mIPscpcqjePUMjTWpj5FLaBqC8auLmtFT
         HeU1kCeXxDm+kdkg0IVtfquga9BYmdxz24xi91MY8UJbHfBv8ehMetRr8tDbnJL1dUnC
         WfFG3vbpNq/K34ZrL79wOC7XOJJNAOSrnOCPqfABKK4mVMVBexeSJFa+ovQiWrrx4/2S
         pc3g==
X-Forwarded-Encrypted: i=1; AKwUvByrsR2HY2XISMulb7Rien7KcqAvZy+8INLJR6Q12i4hmAyuredO5QSH4FpGEtHJWKnfl1+bWsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9PsNXAzEEK8b4voSN9x7DquK3DJ7NlU3KJy2QS3CYbuID+PD3
	XcSjLYV/6CSnSGRh/KdCH9pW7uD2nudpSqIOsm0frLdenIn+UAlr+ZQf
X-Gm-Gg: AYBFou313xIa/Yoonq1zLl6K7TTvAYuOY4AftRN65xbzQG/F/RBVvigOAUGqFPBagpx
	xjEf65iB0tiogcfb78HXOJ4mykb7kDv3I5RhnCKwV75YxrZo2DIqWSGUVbZhs3uqC2E+849uqrz
	TWM7amYCYaf0lCL9hDkLIrMtsAr2u7l2sqCfNUzrckSnM0z2lFGz4DnC2GPgK1rCWRMqGZ/eFOz
	eNRpA5zE4HNlz/0l829638v0UydWG4LkbkSGpLv37HXxx/qY0/qIp9ArUsKKT23G0QTJ2lg4Gyz
	TvNCjJr0JHVU3ZbisWTO1o2RDGO2vzb+4yXv8oLAz9cp6YbxihnQr3CUPIcg+CmefSsE4682hh7
	KkppPY54HZE6aGbBRM+d6KUg6ka/djG9huhFVxKXgErSrG3RrvsBxa1/vMCl6xBJrR3hvGTbhFl
	CTKyOgyX7xFzAxq7aKxGKfVuPWIoa6vHuxvgM40H1wq80/pY/HfGk0UcLLd/5kyPA+k/DjH671E
	psqIflRufuuc6IYWF8Aq41+ViMg1xEaGmv615Pp4iE1N3Ob7L4dDm43QG4GdESesapZbQ==
X-Received: by 2002:a2e:be2a:0:b0:3a5:f044:fcbf with SMTP id 38308e7fff4ca-3a63c2ff078mr34722581fa.25.1790590694744;
        Mon, 28 Sep 2026 03:18:14 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a64c30617esm27613471fa.26.2026.09.28.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:18:14 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] iio: pressure: dps310: fix overflow in pressure compensation
Date: Mon, 28 Sep 2026 13:18:03 +0300
Message-ID: <20260928101803.547005-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
and pressure comes out about 150 Pa low on a DPS310 here.

Use Horner form, dividing by scale factor at each step. Overflow then
needs a raw value far outside sensor range and returns -ERANGE.

Checked against datasheet formula at all eight ratios.

Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Based on iio/testing, since the buffer series reworked this function.
Can send a version for fixes-togreg if you prefer.

 drivers/iio/pressure/dps310.c | 94 +++++++++++++++--------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..a22c8b9860af 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
@@ -660,75 +661,58 @@ static int dps310_write_raw(struct iio_dev *iio,
 	}
 }
 
+/* Fixed point one for the compensation fractions */
+#define DPS310_CALC_ONE		((s64)BIT_ULL(20))
+
+/* *acc = (*acc + coef) * raw / k, with coef scaled to match *acc */
+static bool dps310_horner_step(s64 *acc, s32 coef, s64 raw, s64 k)
+{
+	s64 prod;
+
+	if (check_mul_overflow(*acc + coef * DPS310_CALC_ONE, raw, &prod))
+		return false;
+
+	*acc = div64_s64(prod, k);
+
+	return true;
+}
+
 static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	__must_hold(&data->lock)
 {
-	int i;
+	s64 p = data->pressure_raw;
+	s64 t = data->temp_raw;
+	s64 prs = 0;
+	s64 tmp = 0;
+	s64 pressure;
+	int kp, kt;
 	int rc;
-	int kpi;
-	int kti;
-	s64 rem = 0ULL;
-	s64 pressure = 0ULL;
-	s64 p;
-	s64 t;
-	s64 denoms[7];
-	s64 nums[7];
-	s64 rems[7];
-	s64 kp;
-	s64 kt;
 
-	rc = dps310_get_pres_k(data, &kpi);
+	rc = dps310_get_pres_k(data, &kp);
 	if (rc)
 		return rc;
 
-	rc = dps310_get_temp_k(data, &kti);
+	rc = dps310_get_temp_k(data, &kt);
 	if (rc)
 		return rc;
 
-	kp = (s64)kpi;
-	kt = (s64)kti;
-
-	p = (s64)data->pressure_raw;
-	t = (s64)data->temp_raw;
-
-	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
-	nums[0] = (s64)data->c00;
-	denoms[0] = 1LL;
-	nums[1] = p * (s64)data->c10;
-	denoms[1] = kp;
-	nums[2] = p * p * (s64)data->c20;
-	denoms[2] = kp * kp;
-	nums[3] = p * p * p * (s64)data->c30;
-	denoms[3] = kp * kp * kp;
-	nums[4] = t * (s64)data->c01;
-	denoms[4] = kt;
-	nums[5] = t * p * (s64)data->c11;
-	denoms[5] = kp * kt;
-	nums[6] = t * p * p * (s64)data->c21;
-	denoms[6] = kp * kp * kt;
-
-	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
-	for (i = 0; i < 7; ++i) {
-		u64 irem;
-
-		if (nums[i] < 0LL) {
-			pressure -= div64_u64_rem(-nums[i], denoms[i], &irem);
-			rems[i] = -irem;
-		} else {
-			pressure += div64_u64_rem(nums[i], denoms[i], &irem);
-			rems[i] = (s64)irem;
-		}
-	}
-
-	/* Increase precision and calculate the remainder sum */
-	for (i = 0; i < 7; ++i)
-		rem += div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
+	/*
+	 * Section 4.9.1 of the DPS310 spec in Horner form. Multiplying the raw
+	 * powers out first overflows s64 at every oversampling ratio but 16.
+	 */
+	if (!dps310_horner_step(&prs, data->c30, p, kp) ||
+	    !dps310_horner_step(&prs, data->c20, p, kp) ||
+	    !dps310_horner_step(&prs, data->c10, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c21, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c11, p, kp) ||
+	    !dps310_horner_step(&tmp, data->c01, t, kt))
+		return -ERANGE;
 
-	pressure += div_s64(rem, 1000000000LL);
-	if (pressure < 0LL)
+	pressure = data->c00 + div64_s64(prs + tmp, DPS310_CALC_ONE);
+	if (pressure < 0)
 		return -ERANGE;
 
-	*val = (int)min_t(s64, pressure, INT_MAX);
+	*val = min_t(s64, pressure, INT_MAX);
 
 	return 0;
 }

base-commit: 873ba60d7f2e52a171845ca290cf366878864b1e
-- 
2.43.0

