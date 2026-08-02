Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3535237180
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697635; cv=none; b=m/kJnKbfYaxM/dYZw6KcxvqqvNTcAsdTwj0awBPNM0mGspJo4ldlcUWiDKb+oxVV8Faz70O2Vv4VK3yjSw6wFtgDjCFF7xd74TxC2mF3d+DI/UXPICCyYDQTcokNLHcEVK5UsuBZmz7PrGAYRwONRtPZj2a62lG/oDacOHlhVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697635; c=relaxed/simple;
	bh=qBxSFoCzQaqnh+On9GpKXj78dp0yTwBTfmfH4W/cnM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVWmvZNjJnX2XgxzhUukn38TMEqXkcJXrYmxAiuKZFGEFkBKSt+xBS0I6c1w6z/V+9fAnrIDhXpNnyaXFefrjSz3JWAzYUb+OKgc5WgaBd6PEFx3OHe05OJZycYtmiigbzvwjDi/Bzeah4CIjwRe68CrUE5TDEV4GXrbeRZT4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSRXLVgy; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSRXLVgy"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1432414a12.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785697633; x=1786302433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCRPNpaghBi1odlqwrDxT5domUb3WMfvy7ws3EyQGHE=;
        b=DSRXLVgyYmooOir9KKr8ndTRH4M70NDF42u7YiITjkDPKKIe242AW8+Xn9AKZi7WZU
         1yA+NJBsWEEKckqIr+ge+CN80irHl8z9y1OSEvtQ8M4kliOSlhhPWrKxQOKHanFGhckV
         lBIexM5xaHWBLQRKzNM/MAX2elomwNwCTvajRujKpVxxW2GhmSdgTiM3O4VHNX+Ot5v5
         5AUTflMec7k1f1+fEuyn9P71hVOK+NK5Nepjkm04PTTF5WCH9lGJ2AYBgmqpXduifhF2
         nkfo6HuDESI1OPpVPE+OpbLPT5U185uM7gtIP+DELmW2roS22U6CUC5rXXbn3hQYCKGt
         6nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785697633; x=1786302433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCRPNpaghBi1odlqwrDxT5domUb3WMfvy7ws3EyQGHE=;
        b=mko/T4AcWx6vW+Nc8vqXbOKvFLJaJe1fn46I1EVb1sehuWCgEVHEroWAtXDpbdCrOG
         CEhjHrQlM0ZXoUxI91Jk2qWq28uDfV3Eom64SyDWbWAhHnKOasLISKh6zcXuhzZzhKxv
         Oc+EX7vmBrnFFwWfYxs7TfUK34FSUIPq89GMLlDMtdm1OKdtFtQy1T/tm2kxXHLg+j5s
         LUx6qzDAtY688+yCJsj7XfSEy3kCeN1+hodEizGSSo6fKR9SjHAqbOa1U9nmHMYnQuqM
         dToDtc1I1qRNJhL+xBdscgT42XmJb0sF2Qvcwi5IhXBDqceyLpYYpni78OW2TIiPsE6i
         x+FA==
X-Forwarded-Encrypted: i=1; AHgh+RpQsHR5QNtrx2cEI1D+fceKJiLw8f/QM2OQ0P+2hSjG+4Bn/Ck1lUl0SYZ0U62b8drY4xSGrzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+nboycbMrdPj5d3bkySxO0MvJfz6W0KiLvDfFwDOi8vEZvbE
	iKxI3e02uSWVZFuLqMgQ0i18PCL9mqLS407WH82J0VO9aqNjPmLgRGnL
X-Gm-Gg: AR+sD11/XILTTp9gZm+5j8DA09bWni3JVCnuHi4kyW+ufLdhGKOt1gQD1SARFY0YKwX
	kprMNdLVph7Tu0vePEQvih5wuSwgUH16/bdyh+WMy/NzzLydvPafDF3y620ZSbLGpB6lzqB8hBZ
	GcGQZMEiIvr4S4rdJJ2EJjkug6/gcQ4jKcXgPfsd6WZQp9/k5mDrabpGFXQHJcmkgZ6lDT4SnPx
	Kg64KSElHx55hyOr7cY0y4Qhc5Rbr5bKkfMXXahTastGY1544YhN/YrpY3WluJDXDnbnYYkNTzg
	9oobPxLL0Xe/jkGmyB14oSrrDPGYyXt4/Ft52NqAYn+Rm8PMRDLI800UKIFgzcri+lRcn5Ydsrp
	AIEvuIgECXbO7TIP5tIaTCuwkNUszt3dl6b1Uo9N1xQ03lYcRREaZ15p50cBUbNmguewT06+G2z
	DkT7BlNwH6ZZyNkiDgEreDWNphhB2KMrbpHVbKSoKN4ouApqFF4crfL+m7cEq8gDTn3tEYkm8eY
	CvD/NNZMrXPWpeyaL+30TfJbfR7Ujq5LRQNx7w=
X-Received: by 2002:a05:6a21:700a:b0:3b3:241f:66c6 with SMTP id adf61e73a8af0-3c92a830f9bmr7094838637.26.1785697633053;
        Sun, 02 Aug 2026 12:07:13 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([36.255.90.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm23531153c88.2.2026.08.02.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:07:11 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	subhajit.ghosh@tweaklogic.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v2] iio: light: apds9306: fix PM reference leak in apds9306_read_data()
Date: Sun,  2 Aug 2026 19:07:01 +0000
Message-Id: <20260802190701.10685-1-mokshpanicker.7@gmail.com>
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

Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() to
automatically handle runtime PM reference release on all return paths.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
Changes in v2:
 - Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR()
   instead of goto pattern as suggested by Jonathan Cameron

 drivers/iio/light/apds9306.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..d582bda4d847 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -469,9 +469,9 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	int status = 0;
 	u8 buff[3];
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret)
-		return ret;
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
@@ -535,8 +535,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_put_autosuspend(data->dev);
-
 	return 0;
 }
 
-- 
2.34.1

