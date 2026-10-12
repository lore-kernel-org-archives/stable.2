Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F3472F91
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805591; cv=none; b=KFRzaVfQNu5JuKKJgUODCLZI91a7+N5hmaZileHnDyjizri6MAKjw3OVax0RquZBFtzbQ0u54mIOeKGCvttjRMM4f07VbK5lUp183lI1TxlosL7gFnlotYz9ygpL2rScYhRSBWgoJcmYnlqVcHpks4tQ5vLFmfZ30f5okSm2fGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805591; c=relaxed/simple;
	bh=p2qSVksJGutfNI1Byl2JEjvE6vPXDxZBq/b2rnciXU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmvcMIaB4Ry+ukDiv5FnM0dnmKwe9727annkFVv7mTBos9iGp/owonAZwuirZ4r4S8/8jvjrUv81NMOjtMUsF0PM9JdZNMTOADPtT9uUTMmGzv0+khRViozczrBoHo7tRrhlQE/pwLtitkCUfPHFpnL/6/twdNsSNd2Ie1QsrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klxsqf+Y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klxsqf+Y"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c315869241fso254677866b.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805588; x=1792410388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+gwZ0DMzJEgahDwJFnmqTiV0Gz8uFM1qeX8U/J7If8=;
        b=Klxsqf+YoQ8h62nB80mHitvB3FZRF4lL9qjdcvTW6aZhYVuVaJPTW+T621vJ8EVECs
         OjD4e756AG1yMBgaVyeoJZwhjQAWy42k/dEDtelIu1eYXFtEubtdHCOwHVRXGAqZfffd
         uY9qGTOaoRkpoDGIL0LWqHe/OLas7F3VsKq9QQ4mX1e3gdTqDLoeQ9ZA2N/n8pD3Dw5Q
         Vk0ZsXS0QkQ0pYzExf2pyG+92kBgJ0qx64SJ2C6HqSOa8IhihkDEfojCYlVtOHtN3aEv
         orAyxmHEhRUMo2d53ZhGJgjZHxIUCF2Nm/8BwfuPbyJD7f+mQceIgWd4o73OEBRL+dtx
         70vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805588; x=1792410388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+gwZ0DMzJEgahDwJFnmqTiV0Gz8uFM1qeX8U/J7If8=;
        b=dBPlp4Q+rsaMGK2ujffo6diI7VlyDJf1KELh6l3cbQPpWy1Ywjm4x2i3FxOwCgbOT1
         8QcHAkK2bVyeH9JSbNxrba5G2ANzJw42NSZdieqXislxKvQoccMheVI/JmKWi4NyLZhW
         1uIq401x3fOSHavA357bBEUquy8KSXUZfwVoOhDVd2B7/QXGmu/YOwjtesm8HSAVKcT8
         vWxxXGn0UxWHBhXkxrhaSqETItiDshGXrM+r2wuRUokkcUTtJF4NVwg50tR35x+N1pgW
         cFJho7xTkdkCdQYg6gUCxi5+6Lvt2lVvtkUgLjlmIvVgI5IX5tGORMRfB6FJc7FRhgQM
         bDdA==
X-Forwarded-Encrypted: i=1; AKwUvByBRpmlzN1vHlHaXl940QkBonaoSrUXhUwXoimVLHxOOqWLFzHe91sACyldOM0p3aFOG71u5T0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIc9qKirTdkl8fOfLhK1fBrkiEsJhIjMk0bv3ODCOQNj6P/bez0
	EaSdKnvphwFKERV4AU2hY1lrcbgvyOjSdx+ule4B+Hq36BAhk9OGAA+7
X-Gm-Gg: AYBFou1EzwRCsFCg4Iygs6TCuVyMTuoiSaVFs8sFAhr8D36ZfpyTffI9a0rfoDp3jQU
	Iw44e4C7PkRWnugUPNwxiFoHxjDkyklvMsuCx5HrUyaCNllvGzClxy4FLFBW26xEkZfIVkkTPHa
	eBY4AGfSqKBl+ZPFCNF0xoWpfOQ8P7XA3p3C7mdV2I8vtMZRZLx3D0TUjd+SnA9jng0x9Sdq0bA
	dm6I8YhehRIlKNUIOs3rxjLhv6JCOKB1AAC6Iu1KGD6MfHu6ewkGFF/h7mfCUGZgi3jAUgQ3jlI
	V1ipfK73h3fZRED3N7zrO3SD/PmRsVuaBAfsTtXtLmu285rPiqNdh52uiK8qTNvyI0SAyCBPZwM
	N2R7hyNqZu7DI0OZxLBfbOOLpluNgOk3tFql/jszsRK1vxxj/Dw6blajvHHhmVkB1WChtlOH3DY
	y/oh0v8u8O26N9nZsrF4MBqOxa61gsL9mHFr4tIVGFhCl0M/RGxdzf3Ph/+ow9asHWzOQusSu3J
	U4MotIOfFwt6YwtzXjbk+Kf/F49KDhLNc3heV+EzCNMgv2Vn3uwZ6RJ7aNgUfnLR3NtWJPN8o1v
	Gd12HtsNJqucpQIUZBteQR0=
X-Received: by 2002:a17:907:97d6:b0:c2e:4065:52a9 with SMTP id a640c23a62f3a-c31aa03d8c8mr892455466b.49.1791805588056;
        Mon, 12 Oct 2026 04:46:28 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c34d011dfccsm118669266b.42.2026.10.12.04.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:46:27 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
X-Google-Original-From: Paulius Zaleckas <paulius.zaleckas@ui.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] iio: pressure: dps310: fix overflow in the pressure compensation
Date: Mon, 12 Oct 2026 14:45:47 +0300
Message-ID: <20261012114550.1680054-2-paulius.zaleckas@ui.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
References: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>

dps310_calculate_pressure() sums the compensation polynomial as
p^n * c / kP^n fractions in s64. The raw pressure scales with kP, which
goes up to 7864320, so p^3 * c30 overflows at most oversampling rates
near sea level, kP^3 wraps negative at 4x and 8x, and the remainders
overflow when scaled by 10^9. The c30 term is then lost: at about
1006 hPa the pressure reads about 20 Pa low at oversampling 2, 4, 8, 64
and 128, and hundreds of Pa off towards the ends of the 300-1200 hPa
range.

Evaluate the polynomial in Q20 fixed point instead. The linear c10 and
c01 terms are still divided exactly, the higher order terms use the
scaled raw values. Over 300-1200 hPa and every oversampling rate the
result is within 1 Pa of the floating point formula.

Tested on a register compatible Zilltek ZTS8032 (support added later in
this series) at about 1007 hPa, against the datasheet formula evaluated
from the raw and coefficient registers. A vendor driver with the same
algebra read 13-20 Pa low at oversampling 2, 4, 8, 64 and 128; with this
series every rate is within 1 Pa. Not tested on a DPS310.

Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 83 ++++++++++++++---------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..3bc690cc8609 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -660,71 +660,56 @@ static int dps310_write_raw(struct iio_dev *iio,
 	}
 }
 
+/* Fraction bits of the fixed point pressure compensation */
+#define DPS310_Q	20
+#define DPS310_Q_ONE	(1LL << DPS310_Q)
+
+static s64 dps310_mul_q(s64 a, s64 b)
+{
+	return (a * b) >> DPS310_Q;
+}
+
 static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	__must_hold(&data->lock)
 {
-	int i;
 	int rc;
-	int kpi;
-	int kti;
-	s64 rem = 0ULL;
-	s64 pressure = 0ULL;
+	int kp;
+	int kt;
+	s64 pressure;
 	s64 p;
 	s64 t;
-	s64 denoms[7];
-	s64 nums[7];
-	s64 rems[7];
-	s64 kp;
-	s64 kt;
+	s64 ps;
+	s64 ts;
+	s64 x2;
+	s64 x3;
 
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
 	p = (s64)data->pressure_raw;
 	t = (s64)data->temp_raw;
 
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
-
-	pressure += div_s64(rem, 1000000000LL);
+	/*
+	 * Section 4.9.1 of the DPS310 spec in fixed point. Dividing p^3 * c30
+	 * by kP^3 directly overflows s64 at most oversampling rates.
+	 */
+	ps = div_s64(p * DPS310_Q_ONE, kp);
+	ts = div_s64(t * DPS310_Q_ONE, kt);
+	x2 = dps310_mul_q(ps, ps);
+	x3 = dps310_mul_q(x2, ps);
+
+	pressure = data->c00 * DPS310_Q_ONE;
+	pressure += div_s64(p * data->c10 * DPS310_Q_ONE, kp);
+	pressure += div_s64(t * data->c01 * DPS310_Q_ONE, kt);
+	pressure += dps310_mul_q(data->c11 * ps, ts);
+	pressure += data->c20 * x2 + data->c30 * x3;
+	pressure += dps310_mul_q(data->c21 * x2, ts);
+	pressure >>= DPS310_Q;
 	if (pressure < 0LL)
 		return -ERANGE;
 
-- 
2.55.0

