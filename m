Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735C37F75E
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856985; cv=none; b=dapooYXYzeMmI9fci1EH0UAdVsUoKfFN/Ab93B0HZS9vqwuh37XWnXg6oEwCqJirYPxwWQK9HYf2RMLNia/cfLHdPefqwlK7YdAB1Exp4h2pbctO2L2X7EP+nGy9VN3FQQUBpgkwDmaugtljjtMF5l2s39gYH0dvVZO5zszVCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856985; c=relaxed/simple;
	bh=uZLkviS9QmyqmkzlC2vpCWnrUAXnjRqFS/QqFxjAcpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQdyFwtfL0GQVaEF+WINb3+3qpLsAWfuOugmK6T4kL4tRaWgtzSWFp71zykFj9oIe8sxaLrBPuj35bmE+CcxBY+7j6KnEv/tt2ytYz1JsEUuMMmrlQtIiSMaYHXGUI2MGUAOsEldU7zS2BJo9XFlpBgXkE4JSxSuKLGgZBBSixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK4WMI0H; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK4WMI0H"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba390408cdso2655615e87.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790856978; x=1791461778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BOQEcKTFqrXxPW7y8AB8EeoE+mGeZaiim+yVKoEltBk=;
        b=QK4WMI0HCm+wk2M73TXZjGMWCl3OxXEq7CZNocry/fVvaT/SeoWIoYcqRaQOmYGOq5
         rlYm87hPW/OHUvNeY9k2yeFEkx6TovjBC/k/YcysdoowFHHeJ/Yg5NbwxL7MMw1CEqlp
         9gHlDmIWEd6/Dj5Pee1WxoYwEOv/j0+G7HR+anZ571IWxuaiBmtSTpZBUduEp4jaPf93
         MhurncmMZGn7gQx0yfGEcn4cp3s+9kCQ7yyLV6EZqo/TWfe+jk3/A+Xv8jFI3SGM1naB
         5yjCLTbs7heKI7WkHV69NyWwO9XoBdoQsW8vw8sPdNMK02osnU08i58blzj238Ygh4jA
         uTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856978; x=1791461778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOQEcKTFqrXxPW7y8AB8EeoE+mGeZaiim+yVKoEltBk=;
        b=s4mC0KBOYSuS7s2nYKRhsY1HUseuAgAbZtthqNN9k1UuuchXUJW4vnnsD49V8gI73e
         LRom3g3nupcws/00iC5WzR3eskuDfnBs63cYYFCAYCyxVRFS9++0mLM/qOe8P7n3T8Ys
         AnaT38DLc0m8NYf68cFMb3vpBHTLmuCeSOQwUFkBei5lMYBtUysFui3Qb+Ep3DR8Hwsm
         ekgDMtFQ7Wc5iftSn3fpSbzzQG18KRdxERveZ7uaKuoXpfNGpiJOI75r2YJE5TWJcVql
         bGV4q0d8by8fzpqLvksdo+/Hmo0SzSofHB6Z9T0lyZm45qY/25s+2mhI2Hh8XwYwCyEw
         S1LA==
X-Forwarded-Encrypted: i=1; AKwUvBzMF9dD1HJaQ/oV1LQhNcV75LdJGIXUJYIS6Tlym9MTFlz8hasvzy9V3nVe3x7mQNBgZRx/xeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs/ROEwNJBsnuG3xFrY/Kw7lvj67WGQvKJA86LB70FWMsMYOXE
	FsnIIS1Pz1AWoVY1Anr4SR+jMkhQrYj/+4BcjHuKGUkc3Q7GIVuynSQQ
X-Gm-Gg: AYBFou1dUflyq0MKd1TQqbPUKxXsDMv8z4BO9oeHmyrAK6AH/nvQgnKnduWq+5SSbN+
	B0CSAsTR7P7ZuKdjlDjr6rQCIFE/bdTN0SJ+PXkg+60LjFFh8VScH/ha4ImRmLxYVZbwW0Of4tM
	xqqDCMgTu3rNwclGVTLbpyYDPDNT3d4EvnireF2qzSJM3NauL0+0AC1rD8O19tBrg4SuxU+UjM7
	m0Vj3hkkHE/8LnTokOGCbk9dMzD9ZsDXRjWYcZZTR5yGMNDSArPXBzz+uNAtZFXqag8MpH5oFWJ
	+Q7ldSIiW/qlKoy2r0Y4ThnbOxtAqZb3Fs5wuV0uWAZRWoCExUF4fCrhcNKbCdAgq+t7ZzOx9Ae
	bD5KIYp5ssOW8PLIvy7J7plQkTC7icOMM2/yZcgPYSKFHH9KIhEv9xO4ApwXu6YlueC1CjrpnbO
	6/w4kif47B7p6tDzsxedFqcncyfxXfxeLkIUo7dhniy8paW+P/rv3p6gXNgvPIRu26Kv8KnHpY7
	StjgVhtpz6QTFyOqL1wiWZ0Kx2ZNCsbSb/t9nYvuMDxBq2YzF0bZiGEpaGE2KzjFAD7RA==
X-Received: by 2002:a05:6512:39c6:b0:5ba:3e13:f0dc with SMTP id 2adb3069b0e04-5ba402cc5f9mr2042087e87.5.1790856977717;
        Thu, 01 Oct 2026 05:16:17 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbf031sm695054e87.66.2026.10.01.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:16:17 -0700 (PDT)
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
Subject: [PATCH v3] iio: pressure: dps310: fix overflow in pressure compensation
Date: Thu,  1 Oct 2026 15:16:16 +0300
Message-ID: <20261001121616.109973-1-zoone.rupert@gmail.com>
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
v3: min_t() line left as in mainline (Andy), comment cut to one line
v2: (s64)BIT(20) instead of BIT_ULL(), min() instead of min_t() (Andy)
    https://lore.kernel.org/linux-iio/20260930085819.886339-1-zoone.rupert@gmail.com/
v1: https://lore.kernel.org/linux-iio/20260928101803.547005-1-zoone.rupert@gmail.com/

Based on iio/testing, since the buffer series reworked this function.
Can send a version for fixes-togreg if you prefer.

 drivers/iio/pressure/dps310.c | 89 ++++++++++++++---------------------
 1 file changed, 35 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..2682615b69bb 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
@@ -660,72 +661,52 @@ static int dps310_write_raw(struct iio_dev *iio,
 	}
 }
 
+/* Fixed point one for the compensation fractions */
+#define DPS310_CALC_ONE		((s64)BIT(20))
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
+	/* Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow */
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
 
 	*val = (int)min_t(s64, pressure, INT_MAX);

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.43.0

