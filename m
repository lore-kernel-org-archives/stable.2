Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5534514744
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902424; cv=none; b=FWqLBmWTkeJihQCoRslyuZSJX/lPLfHvriRhjqCoY8AfpvxIHqFbDNdb/XfhjsR91Sh7GS9m/R36oXIK9v1UOZM3dVgpYkmjynUtBwYkRBtQf6HnC66WC7SMVArfxdsCyKYBhfXdu3bTs2iZ196QWoYFbnTkRuoW955mP4cQxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902424; c=relaxed/simple;
	bh=kUxVa5mGjgd3Hwbquj61TOyvRjlHlIbwg1qSJUSNsZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxIgHICey6eJCEQ68a5uV61hsCVC+nAG3xPkvw9RN9Xmuv/V09SJRWWArauY8/YP6Xq7xkDsz4DKrwC7aEm8KuZJeTY6leNwAGHWlv3us8AeTW0qmuaQrbdZPLIk0O0HlPpq+unDmqC9iZEqn8M9I7Bw61l1k+OtQuF056hpXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUdbCzpG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUdbCzpG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so24176785e9.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902420; x=1792507220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+dcTjNdpl6sXOUJMEgViEWWx4Hbq5B7m0gg3ou9K64=;
        b=JUdbCzpGr9iiCG2hIh2ePKqwJAsecubVQ+FqoYeRnDzjwDraryHs1+4NJmImZosUzq
         UtXLIzEflFlc2+mUXk7sA8gfb8Q7FyiP/uACK2VV4H/4qQgbgn+21cyis76rQELq03d0
         /g7PaOLzLsstioL1whpnBtq9ufPI1c/JOY8y1Rz1lXS7iV69dbZiw6wa2t+PxcjpHiSH
         eJgZUAmo6I+fPW6eTJpDDpExRN7kGL6f7+ueQYPYWQQSpzmZwQAui0AUlWimk7/pS4eC
         zda/p0A/9DzHx28noJQ2C85uwEqsA/gzY+KZr3U/8EJybBjRdmLBM/Xd+uutbHdVCI4I
         B0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902420; x=1792507220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+dcTjNdpl6sXOUJMEgViEWWx4Hbq5B7m0gg3ou9K64=;
        b=VbnKLkIkzLozTLgsaxTSnFjNw2r1Y+Qb4R2yuD997J+fjAwhF5NL2iKczNcd8PuHDp
         bCpK/BAiTzdRKQwM8ayZmR4lVgXjLwRbp/d+2649ngKEXKx/t8CwtFIMkkL4lrEZ9ERZ
         7LUB3NdpvW44KEYJMsjAo2LrOfP7hfMd7h+its0fSCYsdIjSPhoiIVaR9pWdOgTkTp30
         WOn7pDGEulssWVwoaFYdi2DaT5qU1VeU9jlRcTyeUxb8v+AWEng2SutdNk/wN1lwv/dO
         6RtrubzO4mFn9GxTpgeYDMkHBGJvaPoiiiZWUjiZbyFf7Rr1wn0RZlrNizDifVUSMn9G
         cjTg==
X-Forwarded-Encrypted: i=1; AKwUvBy3SILx3ILvkUqdaP1ZU9F0Kl0EDvUBfiu7fjO7dTy0ftVNog//+2Oj5166RUM+KDyZI5rqODg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT97hqe74WnFKA+FYtQ80LHgRVE4cTbHIclWcT7w7ji6GjJBa2
	PeO5a4YeGWTohmPqJbmgFJ200BFQNjVhP45WvwsJPTX6THurp7qyqvBy
X-Gm-Gg: AYBFou04bYH05h9MO0L2cmvGm6KzL8s4FcajL0SK2jxk3WWKv3hHG4LzkEeIscTgZbs
	ApxKmjD3c1ijAO0DIAXKFpa+j+dENwVIu1j96nW+AKQIrF+LX7L+GSQLpE5UoLAjg4BzEC9awFa
	HJ0huOwStecdXESyxxhHCxc0JzLfpdYons8XVKcOSFz+sHxqTbSUUuXf8tUk4kEXk6NLskBtEI7
	tNZ/HyM+OT60Er7tJoU7rHPEM3xEthSTCNDaxVJS6mgVve4Hn4b2F96VjZDAB4KNBOKq9jlFqC5
	PjUg/mhHz6CBL0U9AOGdKZnKwxtNmJqH7oDRuw4pML3H6V40JKT/xG/TFv5JaOtVq+5h82E/qfW
	g3lTgmNCcEnZwAnTk/fwLSFBMHvSYVkwhLjr02zG+3IjxVnZdTi0c5zrkFwIybjyJtB+FtixU4m
	EWSeT0uOaqeFoUGyoqoZDVlw5ytlBHgM7l9JXVVfdPEmKwHi3XHUbvffr7VygOPi1nuKKCamcbP
	TyHPBU8AaRM1QOvy/I70DOrb5PCJM1V
X-Received: by 2002:a05:600c:8b70:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a18e4a174amr246218995e9.7.1791902418613;
        Tue, 13 Oct 2026 07:40:18 -0700 (PDT)
Received: from mm-ntb-00805 (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6b3cbsm294892585e9.0.2026.10.13.07.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:40:18 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
Subject: [PATCH 1/4] iio: light: tsl2591: don't divide by zero
Date: Tue, 13 Oct 2026 16:39:40 +0200
Message-ID: <20261013143943.436816-2-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143943.436816-1-ciakval@gmail.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

The TSL2591 has two raw light channels - CH0 and CH1. The algorithm for
calculating illumination from the raw channels requires division by CH0
(which can be zero) and by "counts per lux" (CPL) value which is also zero
for (gain = LOW, integration time <= 400 ms).

Furthermore, the algorithm assumes CH0 > CH1, which can be violated in
almost complete darkness.

As a result, reading from 'in_illuminance_input' results in
division-by-zero whenever CH0 is 0 (complete darkness) or whenever the
parameters result in CPL being zero. This results in kernel oops on
x86_64 and in reading the value as 0 on arm64.

Fix that by:
- reporting CH0 <= CH1 as zero (catches also CH0 = 0)
- updating the lux algorithm to only do the division at the end

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable@vger.kernel.org
Reported-by: Martin Triska <martin.triska@mycroftmind.com>
Assisted-by: LLM
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index ef3ed9635a1e..f56d31404c25 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -362,6 +363,10 @@ static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
  * Scale values to get more representative value of lux i.e.
  * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
  *
+ * CPL is not computed on its own: at 1x gain it is below 1 for integration
+ * times under 500 ms, so the division by LUX DF is folded into the final
+ * division instead.
+ *
  * Channel 0 = IR + Visible
  * Channel 1 = IR only
  */
@@ -373,8 +378,10 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct tsl2591_als_settings *settings = &chip->als_settings;
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
-	int counts_per_lux, int_time_fval, gain_multi, lux;
+	int int_time_fval, gain_multi;
 	u16 als_ch0, als_ch1;
+	u64 lux;
+	u32 rem;
 	int ret;
 
 	ret = tsl2591_wait_adc_complete(chip);
@@ -410,23 +417,28 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
-		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
-		/* Calculate counts per lux value */
-		counts_per_lux = (int_time_fval * gain_multi) / TSL2591_LUX_COEFFICIENT;
+		/* No visible light, this also catches C0DATA == 0 */
+		if (als_ch0 <= als_ch1) {
+			*val = 0;
+			*val2 = 0;
+			break;
+		}
 
-		dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);
+		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
 
 		/* Calculate lux value */
-		lux = ((als_ch0 - als_ch1) *
-		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
+		lux = (u64)(als_ch0 - als_ch1) *
+		      (1000 - ((als_ch1 * 1000) / als_ch0)) *
+		      TSL2591_LUX_COEFFICIENT;
+		lux = div_u64(lux, int_time_fval * gain_multi);
 
-		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
+		dev_dbg(&client->dev, "Raw lux calculation: %llu\n", lux);
 
 		/* Divide by 1000 to get real lux value before scaling */
-		*val = lux / 1000;
+		*val = div_u64_rem(lux, 1000, &rem);
 
 		/* Get the decimal part of lux reading */
-		*val2 = (lux - (*val * 1000)) * 1000;
+		*val2 = rem * 1000;
 
 		break;
 	default:
-- 
2.53.0

