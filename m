Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869299;
	b=SMxH50j6J2wIJk5eTXBo8RngnU2kKOpgi6BZy/BJT+uL8S3tolprD1rY5JU/lQ1kdOLq
	 Lw6aRoQMwywQdtjdGumbsnsuks8qnkX+AfJvWQOz942+IkRlxY8dTmU15QQpwkcRR5nB9
	 A0OIVcmWd0TLbLQNtMrcvyot9kJDYhyRYsa3BYyDQq0VKX2NA+gOHKmactN1f3FSJrLEa
	 MK2xJc5fv4Qfuo6eBISR8CvDsbRLBY4OWxNQeEBy0PknIFI3szd3BHPKSoW6H2yEK4HYK
	 u85lkEr48h0VocdzFPC8rxy42e3nzQ6TpL04xPeGZPx058iCngnGqkLtAfbV0cj2vUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
	b=qsjy3JpxgGPfq80P+g1puOr+InNUJCJ7dLVr5ZDyGidvSXAszCG9xrw3mzXT2IGb1JLf
	 F6JIj+NKfN3x5y7Xuw11ls7B79CARHF2AB3vHnI876V8ylrv5CknIhnxUTKHhGtEU6/9T
	 14BlWyKlTA3d1oz33SKChuJSOqjdv+AWzCBvqYU6nUsEf1EHHzCNLpAdh9rsX4dBi7pA0
	 Se+9HXx/L/Y7ypMScRGWXhr6BVw7ysSVmf2Jyj8fC/jKRXj5kZpyZmTrbjWuR2L2v6cKH
	 cE2fK85PfNLaFEulKB/VMbfsDwUi0gred8jYHxzpqLLOMAF7gTOz0xer/y2TDkmzz2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiXNKing;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C552606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C552606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiXNKing
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67db8985419so2427239d50.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869298; x=1795474098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
        b=IiXNKingPriUTAV8ay/gm81l0sS/gFH1loXiJBYR6J8KGZweXPHVJ8W9aNx4+ivJq4
         KLjxhGWfMUIA8UOElTq0tHtR0naPyZBpuOSmOzPQkPveHY7nwvCSCxt+djbuymNG65g5
         bg1l0AHbuyYk9yghtSIkhe7uWfa2KRhCVjTzI3VQT4TNnSXr4E9oXbT0Wf7epLu9MXu2
         LgQulTcheNGGG9XIix/4QZdZWsu4V36NnAABmT/t9wtRp+NPT0TohhqjIzOOrgmqo+99
         dGrSOYH9ViP/yC2ecuiLZB/7oAaxBsbEwLje5JsT8XCU4Zo1CZKH0e18+X4uUApzJCwn
         HNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869298; x=1795474098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
        b=ubhd4L0jIGvFZyK1NxRZZm9PL5G2VHMdJsmozFgmIa93FkTutoK4vrhVO2LL654+Lc
         mkb8XNlFmxwOwYMflsuHqbob9IPazP/TwyoIuVBddobgi+TE1itw9s7IT4dcp+EwKa8Z
         sy7y/P7WZI8BPLdp2T06Xlo8jUIV66NGBfo6c3G4ydZP2tljnk2oPPQTsBVxMMOKFtWS
         /3JtFD2ZI+AhYMAVMOiVc4FTd4i41pnGFe0mvUwhxGPMuKm67H1/GemGpKG+7fkaZMds
         MYnxO8pgdV1DjxIDgsQs5oBWg/eQp9IsNGhOj4hHECvGr5oLT7tuOoweaIOpl2gUv139
         rEhQ==
X-Forwarded-Encrypted: i=1; AL+hErGoQju/AjoJV7N0ya2brRuk19jPjQQ8oRIxzMeJfG4rWdeyASxkVVTSHhFtK0/FUpsxDeTU2TE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+pcMN5mLb3qt8tzSTlB5a6deg2g5ubNJTacDQ6l+RuOaS4+UT
	pBCZmuDBgpTKuE8t4485ar6R0vowIWoVeWUDBWdynP1fubRCVMusYv40
X-Gm-Gg: AZFdTZdV+5Inw7wQIq3CXP7TdVrBnFArTSazcIqrKoMHOIwYa3uidkNHLXn7xNGbeFT
	LBxmTMcW8gGRbVoKIyBHQANQe/liyBqNO5RfmhAW6tVQJlFSvR+BPbDWLhooIoDcWhtWMkxETbz
	TkB5HyVTjNu5WdqBhqIDO2D5azrfGTpCOTo/mENOxnvMkWmjfZgdldP92gP3Y3BQ8E6oLEL9quc
	TXqo6J18A8dbR9dLukYRUVnW3hPl/wYXmR0hBsTNfyfSf4oYkJEZfc8iYSWYDYCpEK80bMcXv9M
	etpmrjJp8jc2qMTVDY4jhFyDlsDpoPFDq2+U2uA670SXziczOI2eUbee2AF0JjK/J5LhSf4N/AM
	SfXq9gVk/TDDlikapG+HTfOF826RYqlik+FfXPX1UZ0KFLnM7yh1P6T3VlrOgKxjcWg7FeLXIoa
	qDyYka21WVnwiIeawTUThHy3/aZZ8iOECsCVCbMxhLafqUc6LD/sMclDcjFSk40V+Fro9lSnXCn
	MXp/4kIVQgHz23mDiV/tkgjNkfl3l581Hrg4ib4w6tNgpPd1sRWtlPF5sgHRXHJHXhU7uO+8bU/
	fI7dWqmD0dYe31lppkUadzFRqPHi0rwZawXqOigcYos6/2k4yA9UujagBLJT1xinKfwDDxWSe/P
	Gco9kq/xnHbvoLIUzQYsaqnY=
X-Received: by 2002:a05:690e:a49:b0:67d:a8db:2821 with SMTP id 956f58d0204a3-67da8db2967mr3475909d50.103.1794869297941;
        Mon, 16 Nov 2026 14:48:17 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:17 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free on removal
Date: Mon, 16 Nov 2026 19:48:01 -0300
Message-ID: <20261116224803.61154-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116224803.61154-1-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
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

The LRADC trigger is devm-allocated against the IIO device, but it is
manually unregistered after iio_device_unregister(). The latter deletes
the IIO device and releases its managed resources, freeing the trigger
before mxs_lradc_adc_trigger_remove() accesses it.

Since commit 699fb50d9903 ("drivers: base: Free devm resources when
unregistering a device"), device_del() releases managed resources.
Consequently, iio_device_unregister() drops the trigger's allocation
reference before the driver unregisters it.

On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:

  echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind

reports a slab-use-after-free in device_release_driver_internal().

Allocate the managed trigger against the platform device instead. This
matches the trigger device's parent and keeps the allocation alive until
the platform driver's remove callback has unregistered the trigger.

Cc: stable@vger.kernel.org
Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v3:
- Newly introduced. After Sashiko's feedback in v3:
https://sashiko.dev/#/patchset/20261110141934.42490-1-festevam@gmail.com?part=2
I ran KASAN and spotted this new issue.

 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..64dd3a9995ff 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 	struct iio_trigger *trig;
 	struct mxs_lradc_adc *adc = iio_priv(iio);
 
-	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
+	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
 				      iio_device_id(iio));
 	if (!trig)
 		return -ENOMEM;
-- 
2.43.0

