Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A426299
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784956260; cv=none; b=Kk9pXwM2ZtwgCz83MRsYJpfvhCABLGOqme/G6zU0QHVN6aV7uBsNQQYornMKsu6lCAR4ApyMVefV6heTenSYA5DN728LnrYmhgxwZ2iy+bhtRE8NDK5vTSoCiImvt8E5fIfO7TdqtyW1auiJ1VHQ6fkBi5KpaJcRY7Ct52HgpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784956260; c=relaxed/simple;
	bh=JeHX5wCK+eWh2x0vBH8Tjole6M5Zvb/8/2HLBL9CW3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mNt/Jlbko/y6vCfFJKFo5raFm+Rt0Nd2kEtjtJ0245/d3kEOpL1yceb+hQ3v0A/XZhZIRrXLwla9Puu88kv87H4hosRXS8CNehwsvwYZZ7kVqLVAnj86YhIzvMxVKyycOw/HYUjio+O2963cJLCVrbQNAB9jEmpqxeq6FirhIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmvguw+u; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmvguw+u"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca80d708489so766569a12.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784956258; x=1785561058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYNr122iGMgO/EI6gg3d5n1DYFQvFWkuT6oNTUvaAfU=;
        b=kmvguw+uK1aFYCb/duCY9/KxDHWwbZ9XTv2fAsA0lldRnU3defio8wJChlXfsQdqr4
         9gSHgUxFmllZ2hLn3KAE7FMz2UkqBo74bFIuxFAsYSfx4ofCcXm6vM9ok33wb95vuNyE
         m+rNdqJD5d71s9nKmj1mQbkhysJGy5I6VgHTkS2D5BZz9Zn9Ufl3N505XFsA8vUMo4KI
         uCQPSdjBi0+enqVp1D3Bj/37tnukj5Zkou5Csul/3U9CzI/lOylPYjuHX9Yys9Sc3hoM
         0YWrFgzCNnzLRviffJ/uFM1FuodIEDTk50CdLJI2KSHhF7+hiWRiziDXLCMHvNyes7A1
         HL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784956258; x=1785561058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYNr122iGMgO/EI6gg3d5n1DYFQvFWkuT6oNTUvaAfU=;
        b=DiNm985mugPHDuvHDzMY6TdG94vvjZJ7RV7gOuBzjRy+wADwWduGMhIEAmP3BrHAk9
         5ADekU71JvN22BQjd2Nq3VV99T/1ucZCMW1a8xug+zhN8mfbt+qpS6EDG29QQYwykKwa
         XINHa5zQIOi8mLf04pqCI8YziVlpGjlvPJXnVKc5Zp40m22M8DZOxTx528swGOwI+pWN
         icv9Z7K5qJrd91Yo6FhdWDhvbIjK6Tvcvxt6hm76jxJ4Rc6B3S0rXk86gCQ12CM9EJbf
         oM6yf+31zDHMB8gKs/Y6F2qhRdu7l/6pFTdjkoD2f8v6nydSKSw5Ihv0t9/tjF19jBjE
         CI/Q==
X-Forwarded-Encrypted: i=1; AHgh+RryJeugqqMovOP8USZcOvL5/csYHxhy0gsCqPwV1zbuzpypVkF1LGQgQir/VMxtIsXGiRekgT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnBbOGFaqGLXNlyqqmC3cF2R1SG3wLzcz2MHE9dPNpMjRpMUZ
	x5k3QDA1bseknsR/IzAoUFkHuKeOUI9x2Qv9ax6H32pauVPL0YpfflcJ
X-Gm-Gg: AR+sD10Fvl+Cwx6R/vEviJHe+fl1nlfwTe0G1rD7MQL0yRysgJA+sRac/7SOZxSQqQw
	Tz+oqkjzQMSKx285Arl0ina6dsBmhQK9gIUb7hHosU3jWjBg3T9MLvszsLjdrCmIAxz4J1PZJYa
	D7lLvuxHoMYGsCfUtG90/OJUYL/SdR5Z36ulbbgWxYFQAX41uU1fj7HgB3pB62uw2G6AB9Ii/GA
	0Txq+ZwdB2jeLFpgm4YE1N32/ONgCDsadSOHGEprqfNstUlIvrURMqqQFds7dpaKEUTZJC7jTFP
	XoZYE6NMIXdpkuTu9LL4mxivLz07zrAMDJsHH/4Z0TXvK64aUjCmgH+aEo4e56Op9BMX6uCoop1
	qInOq09GqcY0f5WIq/NQZJ3sI08r2zOGFiaE64+Djm1WeUCkfA1SHZ4oMgvtA6sEC+P0VhSAtQv
	jNu7FvagDgVBRs6oGq4zEZVSnPRZwQxT6Xph5oCz9QJp3QNv/w8r33AtnrvfbD4ts=
X-Received: by 2002:a05:6a21:6b8c:b0:3c3:8315:80b6 with SMTP id adf61e73a8af0-3c67267e948mr3145679637.32.1784956258481;
        Fri, 24 Jul 2026 22:10:58 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([36.255.90.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm9263154eec.2.2026.07.24.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 22:10:57 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH] iio: light: apds9306: fix PM reference leak in apds9306_read_data()
Date: Sat, 25 Jul 2026 05:10:48 +0000
Message-Id: <20260725051048.5616-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apds9306_read_data() calls pm_runtime_resume_and_get() but several
error paths return directly without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference and preventing the device from
autosuspending.

Add a goto label before pm_runtime_put_autosuspend() and use it on
all error paths after a successful pm_runtime_resume_and_get().

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/light/apds9306.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..014db7a1787e 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -475,19 +475,21 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	ret = regmap_field_read(rf->int_src, &int_src);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
-	if (intg_time < 0)
-		return intg_time;
+	if (intg_time < 0) {
+		ret = intg_time;
+		goto out_pm_put;
+	}
 
 	/* Whichever is greater - integration time period or sampling period. */
 	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
@@ -510,7 +512,7 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 						  APDS9306_ALS_INT_STAT_MASK)),
 				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
 	/* If we reach here before the interrupt handler we push an event */
 	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
@@ -530,14 +532,15 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
 	if (ret) {
 		dev_err_ratelimited(dev, "read data failed\n");
-		return ret;
+		goto out_pm_put;
 	}
 
 	*val = get_unaligned_le24(&buff);
 
+out_pm_put:
 	pm_runtime_put_autosuspend(data->dev);
 
-	return 0;
+	return ret;
 }
 
 static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)
-- 
2.34.1

