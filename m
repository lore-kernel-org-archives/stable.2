Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFF3BC68A
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359538; cv=none; b=fDuYfkFous7EbCLvO1/RMPMJAcFu7dxnxBIE69tfI6y8LVaXSwrl0KI73mTARumetXU29MA/jcEHDUjJk+sUn+Idh+UbsxuXQcB6Jq25P+XSp/OPwiz6YIXYBp8TBNjmCFO+X4fi9zfLrPAxaPVoTINzTnX4R8OEMlsGgBBEj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359538; c=relaxed/simple;
	bh=/RXIEdBfSd8D6osEYZ1YidMBoUc4bIY9Xc3UHnj34Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXi/7bK7qmWIU+4xyQiGcfI4JWWByAKB+4Z3r/iKBrHwrjpsHy+bBLUXYMDu7rscoIYwcO78dlY7SKViqdbALJHn1+MxXhntPQtIKqHfjrtfdKZOmZLefAsprv79pqNobywP0wsK0oqpjndUMTJLCNTtXfkaTDnU2K1YRF9N4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be; spf=none smtp.mailfrom=inspiral.be; dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b=bx2G2+1t; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=inspiral.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b="bx2G2+1t"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so11936775e9.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inspiral-be.20251104.gappssmtp.com; s=20251104; t=1790359534; x=1790964334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGzeXfDrgiYqRCtYgTkGIXW4Hfhn589xMj/GX/7sOpA=;
        b=bx2G2+1twRX1rWmKnRjUmwp7iRolmfMTTSIuF6LDo9DzWOrfihuRUE+9luT6N4KrdN
         CvRtPtGzxyEZzJVtWyJ+S5ATc3BtCLP1Rin2UxGcKF6ZGux0vmh+YF92jRiJlRB8IYy6
         +/uh6s5nrKg/kXtfseAbOcKSQV3uFf2f4PZuSPZsa5Iss/+zccpIR79uj2bM8OtgXglF
         NMa9RW25HHySZDorEAmL5lW64Fa3+BfqCo2udyn7I/pI2IAYv0kQQ49Ov4M5emnbs5nb
         JRifH7vSwH8uCE3seIOKjub1TxRzk3RhXoGgowEoUFQFOzkSASuEQVAYoh6pqPITVqfa
         Xnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359534; x=1790964334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YGzeXfDrgiYqRCtYgTkGIXW4Hfhn589xMj/GX/7sOpA=;
        b=IZIVEcwZL46xpD3ATmTgTAHbNNe4Bosboa+Hk8fyN8QqtzW/tYcEa6vF2ZzUqTTIV3
         FFiP1kO5lwpL3QTlfPebrcqSInUl+zI1JTsXZl0LjcgA4iWWAbq2AlAMKZLriKxXgv4Z
         W6kDW/vHTVqbJ/UIYMnlbKvfg+nYZ1Q/eqpakxZaLdz1wsF3FyFqkg8ZrXFG1sdwhf7Q
         SyS8Fa43TeitzywHoTMVhA4fpHcvJqIRXuoTHuDJKO1/WAmZ4WRVGDptlpvuwVlAuJu8
         pXsqPG3i1JHpqWpyDXkmYTLbcaYndQojwlb28mD+vLjdrPx2bFnyXal4S3Mg/S2QcEjz
         Uh8Q==
X-Gm-Message-State: AFuF++nfjoml682zcLy2hhpAF9a+q9nVAfcKzoq9ZjGBjjIBqQ3sXu+L
	slJbptXXV1MLbXYirU8OBI8pR8wcBI7OoHUWvzXPZ6fhLSq7Z6phLPK0CVgPWm5S3WqO+B7X8Ne
	I2Eze
X-Gm-Gg: AYBFou0Gh12ZO0/a7U/U1vhOf4smMelIkRQNWw9Xp8q7KlXWF0MNSR6w5cWrgCnGHHV
	7CWmSp+CmcD8fbvWoqS1nFW22Zg8l39KcwOJiMosydZqLA4SP1wGJyyJ3oZK6OvIhJRtX1AGSMi
	yiSeMfTcAIBRE8uedBUgRrtYeyVMKq6F4NXIxSHi5b3lIlu7FPpsQNk8qfPG739SuuYCQnlz/fg
	b0TVdnWhvPr3Qhv527alZGvzq/eGsWEH77GAfp7YDcwafcJfEC0eecjzsf5q3DOS2by1A44YN8L
	XY1keHycMNd3D5eGlEM27fi4EF8R+QMgjCyyv4fyB4RMoMBw7giwwwvPAbei0Y99zVrSJ+eioF7
	IjdavL4xDDWlBIYLX/7nXpOSJq5f9WRAM8U4WXcPMTUFvrmZuOt9kdMZAYjRRP2szE820AxgKCC
	jXwJqrN2iSJThTxdAepBgSFjz3T4Y6HGJomZIKsIK4SK0BCZQEAfH20OD7zoYgCRnrC7raHBNye
	JZSAiCgH8pfbHXi52qlYoLV9VMLhhjS173WYIo9xSZ6uZdv
X-Received: by 2002:a05:600c:6207:b0:49c:fc6c:be13 with SMTP id 5b1f17b1804b1-49fe66ff146mr122968685e9.25.1790359533676;
        Fri, 25 Sep 2026 11:05:33 -0700 (PDT)
Received: from vger.localdomain (178-119-186-126.access.telenet.be. [178.119.186.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm165106255e9.6.2026.09.25.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:05:33 -0700 (PDT)
From: Tom Verdonck <tom.verdonck@inspiral.be>
To: tom.verdonck@inspiral.be
Cc: stable@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
Date: Fri, 25 Sep 2026 20:04:44 +0200
Message-ID: <2952f070f82913aea96eec25d28008d3b9058656.1790358356.git.tom.verdonck@inspiral.be>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790358356.git.tom.verdonck@inspiral.be>
References: <cover.1790358356.git.tom.verdonck@inspiral.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tmp102 records a one-shot deadline in ->ready_time at probe (and resume)
and, on every temperature read, refuses the read with -EAGAIN while
time_before(jiffies, ready_time) is true, in order to skip the first
~35 ms conversion.

->ready_time is an unsigned long compared with time_before(), whose
signed difference is only meaningful while the two values are within
LONG_MAX jiffies of each other. Because ->ready_time is set once and
never refreshed, jiffies keeps advancing away from it, and after 2^31
jiffies the difference flips sign. On a 32-bit HZ=100 kernel that
happens ~248.5 days after boot: time_before() then permanently reports
"not ready" and the driver returns -EAGAIN on every read, without ever
touching the sensor, until the next reboot.

Store the deadline as a 64-bit jiffies value and compare it with
get_jiffies_64()/time_before64(), which does not wrap in any practical
uptime.

Fixes: 3d8f7a89a197 ("hwmon: (tmp102) Improve handling of initial read delay")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
---
 drivers/hwmon/tmp102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 50a8b050d8da..8c8463ddb6c4 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -58,7 +58,7 @@ struct tmp102 {
 	const char *label;
 	struct regmap *regmap;
 	u16 config_orig;
-	unsigned long ready_time;
+	u64 ready_time;
 	u16 sample_time;
 };
 
@@ -106,7 +106,7 @@ static int tmp102_read_temp(struct device *dev, u32 attr, long *val)
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp102->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp102->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
 			return -EAGAIN;
 		}
@@ -354,7 +354,7 @@ static int tmp102_probe(struct i2c_client *client)
 	 * Mark that we are not ready with data until the first
 	 * conversion is complete
 	 */
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 tmp102,
@@ -387,7 +387,7 @@ static int tmp102_resume(struct device *dev)
 	err = regmap_update_bits(tmp102->regmap, TMP102_CONF_REG,
 				 TMP102_CONF_SD, 0);
 
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	return err;
 }
-- 
2.53.0

