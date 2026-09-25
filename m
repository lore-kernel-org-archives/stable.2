Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3D3D9058
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359538; cv=none; b=jaWZHEABk+RjZ0QD9VaNeSY/XoX4hMXaAHy1hpNHOQSL+yugMQopWlet+j2pTtkKWJhTNDC966QT30TSZAx+/p7fmoPEXIhQL0al/SOcDHv1DrntS5GIoJ+xxJU3BTu2BFYid+nCaYQ0zZqIIZUH2//Qvz87CvLxiv9bdtDNMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359538; c=relaxed/simple;
	bh=lMGhkIGkhdp1109tyrRUkjRi4JrBbeNAjPYgqHVt81M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m83PMlrHWrBw2lpGzEr4sgnG3I0OQl+lNdBq7nI+WiqhrfBj47Qk28OoOcGjHlRVuW3tfL6wjnruPZKDNyIs2477Mzd2B1L1Pv1u/L8wBym92sCe/W9jErMM+a+lrHiG0EIQvfWoPFLO5E+X2lCqfv0IET/rE4S8V589YIr8f5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be; spf=none smtp.mailfrom=inspiral.be; dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b=pWOVdx1F; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=inspiral.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b="pWOVdx1F"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso12683415e9.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inspiral-be.20251104.gappssmtp.com; s=20251104; t=1790359534; x=1790964334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wu0Jjqe90OxmnT4TB+nVVElv4K9/XpKew2FI5VhX/FU=;
        b=pWOVdx1Fb3UzX0QHjhZU9qH9mMntuFzzBQmC7R7gkSEYxM6LleXXfBKZBGHdEc+O1T
         FyTvsVRKgif/1dVpjfFe7agORcDhIL+TBoAGsentdqRPdg2WPuEL900EMOtofLSZdF2S
         OZVLc14NQnt+Sa04tIf/y4hp3kBLszm22FDy+9gE6aPITQfk7yhBKB0Tbm+JU1GOVNOK
         EUizmvFbS6pvLFG4FZVL0n4/hv87n8HY0FeEXwz2mCC/wEHJt9kFMd+88SYi9T63+wKw
         cL7CvspMFWHNniq0452j1FyvdWgfMO23THZcxzEN6Vme7UcJCLKq5yl2TVqLruGBRAqU
         N7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359534; x=1790964334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wu0Jjqe90OxmnT4TB+nVVElv4K9/XpKew2FI5VhX/FU=;
        b=ujqpqeAqMD3n/bTPL62skPgMdZaanIrxHbrPVEnqWm8pL4iURybxJWsa3xuve6HGuj
         R0CQL3bHMDc1pHZQAQ78wn4Ngq5vYrOLdDckgeh3BXcQSbMSzL8WNyrB6r51hGMcEWp9
         BsL6dKFROScxwaRaTi1xf2kagjJaoX7VAdQOjp8yT+65qSSKeZJ2erPA5gwsqtRKWUWw
         VtjM9ZtV+MW+7wKVZJ7w+2NGshCwtTBexboG+oQitzQ1TL3xVireISRrnG326Wtwoft6
         jjJxF2w7md7Z0g1Ywc7JnKrPA8Y0/Xq9HmBBDjiJBIC4kPikWzqjicW7JShJEGCr/tRm
         ExNQ==
X-Gm-Message-State: AFuF++kuDqYHTv0FH1tlc2HVbwKh1IbVzj19aMpZKBDsmMhebtWyN2e3
	QWWs0ZfXa52KtYxkI06+H9tX7bBul1vHTDzCtBvOAqqBvTBGSbb0AQxnYKwTrprDChhxYbx9W+N
	PWlSS
X-Gm-Gg: AYBFou2MeUsGOG58PH+UPE0YKxlNX89ydUkqbbvaS29L8mCPITLCjDBHVXsW5fjAwnI
	AkUx4AXttjGyIq+QtLzykyv42+UZYp/Hm/jA2Dalk6u0z4se5suL1Il8jzuMsCEzrpWePfVUHY4
	ZW13qY9GRp6PAYLCz3oKl9giIlTn8z3o3UB9rHogEDH020zBmcLHHH+RUb/7cIngvwtNRZBJXit
	WsrR2cOK6zpa0fG3fYwZyC/I54EO152SjPJKot0ehd3cpLd3QrkpePTOk2werOP5BrXhw3yTtMD
	whL1kpAI1zl9FBNZgXLi5cltUs73nKjAj5pUeZfKcPTPi4dU5j6Rffsm+ByW5bfY/J59IZC1P/i
	HS/FmC+j4H76cnEdP6nkQHBgXrw64YMpQFeRhgCZOz7YkOtiMAwCnPvgFOOyXuE1ph+1WptoqPp
	HxS82IDcULdK+eEXpOzTS493SkZu/NMgx9FZe3LEqVHfCo/ImMWvSmdLOs88RhI96P3mBhNAaya
	nw1cgRkxjxtQzC6NyGq1hcAeyFvR3GIQzh48ZpvKh1C+5Gs
X-Received: by 2002:a05:600c:1d99:b0:49e:6c27:d093 with SMTP id 5b1f17b1804b1-49fe7b739f4mr105445465e9.15.1790359534601;
        Fri, 25 Sep 2026 11:05:34 -0700 (PDT)
Received: from vger.localdomain (178-119-186-126.access.telenet.be. [178.119.186.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm165106255e9.6.2026.09.25.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:05:34 -0700 (PDT)
From: Tom Verdonck <tom.verdonck@inspiral.be>
To: tom.verdonck@inspiral.be
Cc: stable@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check
Date: Fri, 25 Sep 2026 20:04:45 +0200
Message-ID: <525fa49d8c50922344fa53e22be5e6133c9bbb62.1790358356.git.tom.verdonck@inspiral.be>
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

tmp108 records a one-shot deadline in ->ready_time at probe (and resume)
and, on every temperature read, refuses the read with -EAGAIN while
time_before(jiffies, ready_time) is true, in order to skip the initial
conversion.

->ready_time is an unsigned long compared with time_before(), whose
signed difference is only meaningful while the two values are within
LONG_MAX jiffies of each other. Because ->ready_time is set once and
never refreshed, jiffies keeps advancing away from it, and after 2^31
jiffies the difference flips sign. On a 32-bit HZ=100 kernel that
happens ~248.5 days after boot: time_before() then permanently reports
"not ready" and the driver returns -EAGAIN on every read, without ever
touching the sensor, until the next reboot. The continuous-mode path,
which sets ->ready_time to jiffies with no added conversion delay, wraps
the same way.

Store the deadline as a 64-bit jiffies value and compare it with
get_jiffies_64()/time_before64(), which does not wrap in any practical
uptime.

Fixes: 66e1c9171339 ("hwmon: Add Texas Instruments TMP108 temperature sensor driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 9fa31bd66ff6..91d20a1ce112 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -78,7 +78,7 @@
 struct tmp108 {
 	struct regmap *regmap;
 	u16 orig_config;
-	unsigned long ready_time;
+	u64 ready_time;
 	const struct tmp108_params *params;
 };
 
@@ -138,7 +138,7 @@ static int tmp108_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp108->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp108->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n",
 				__func__);
 			return -EAGAIN;
@@ -477,7 +477,7 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 		return err;
 	}
 
-	tmp108->ready_time = jiffies;
+	tmp108->ready_time = get_jiffies_64();
 	if ((tmp108->orig_config & TMP108_CONF_MODE_MASK) ==
 	    TMP108_MODE_SHUTDOWN)
 		tmp108->ready_time +=
@@ -528,7 +528,7 @@ static int tmp108_resume(struct device *dev)
 
 	err = regmap_update_bits(tmp108->regmap, TMP108_REG_CONF,
 				 TMP108_CONF_MODE_MASK, TMP108_MODE_CONTINUOUS);
-	tmp108->ready_time = jiffies +
+	tmp108->ready_time = get_jiffies_64() +
 			     msecs_to_jiffies(TMP108_CONVERSION_TIME_MS);
 	return err;
 }
-- 
2.53.0

