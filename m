Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF204C0415
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933718; cv=none; b=lzzA4sLNyQD0SfzuqbUBy3MoK+etQ0/9U8oCqtX+IcqJzoiz4XUDGE1AgNSSkUu4YVySRVlf1jSlITojZpm5LJR6S5IdN6gbiq9dLPqFy1V59ASkaRjhgZr1HagobaR2mOwhE+qBlbnXIlhgzCXEGfW08Drqwf7WG6V3H0WNfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933718; c=relaxed/simple;
	bh=ZrVUK7Zj6N1KP1R23c6/0Wh1JaKWO2Kf2XCkb8zt+wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruwCO+aCdFSws8PuGQW9xRT73iTPKgIUJtzkHBQeN+MuvVtAnTKqNIq59t3cmE81FTHyW3T5lphMqZGNLrhobYSAVTGAUCDX/tX5/YuGhp3Onycp7+ECpom8hbrcmB+6idPUFuTPOgEN4btx9ZA5qpQuab1ZSH7W9oo181b+CfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSvbwzhz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSvbwzhz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so1000999f8f.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933713; x=1783538513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfXtv/qlJgM1lCGYWsyy+YR9eQYYd+6+L4VNCpJsbs8=;
        b=PSvbwzhzx40+qCg/wa/eCNCqYT5VU+Rh0/xraRwm/3oronlgYatYP7RseGsDU4vKDt
         a+hkXXsUF1ywqk38guliDfRLiDwdWEOLGXuU77f7fpONl5Oy8Es1bIv5NeEPadBeuSZX
         t8khTy+lJlgNI21g/LhHyrMEjnGsCRTAwrRRaGilMmBs91UauWDDlFZ4wmDdfjylf5HW
         XqQEO0hMRU5Qmu7YGxnQzNJT8vDc3tgvqtlmeZ7r2MAqxx5/+JqfxdgUSXa+9Hsd7HOe
         2ahQlS4c7b178iBrtjjJF48vb64qFnRCwakhXjUjN5nvPiv1M2VU3Tu/jBzNvDcm6qFn
         11Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933713; x=1783538513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfXtv/qlJgM1lCGYWsyy+YR9eQYYd+6+L4VNCpJsbs8=;
        b=kG+asMX4gpsd6OmAtA3hUdqLj7X7vKidBwCvmLaw3K3wlNvJX1a1RidirQpQLB0xyo
         Hl0PVBP3PROz7Da3M1ARGUt2YHQwqWChRezZuUdr9GYcoWdUSbNf7qVDLnrAMdx1L+iE
         23X3n6ZKEXUmp4U7RxD158jiKDEGkgqd3MtqRtUUwS9C26oZIg1G32ctOoa2KSuibbza
         GM9IaflLlDbWur5UFjFs5YQKya0NYY7hNG3a3HoRq35DQ7Z9RdbmrwX/3hiCa8+BXx6/
         Hyr97K2JTrecWsGdSxLCezXd85Fmspi9Wmly5HaHXCdqy9lowhm6HGhjsg8yWCcFMkMh
         b6EA==
X-Forwarded-Encrypted: i=1; AHgh+RrOzSDSUdI7s5dia5Snd2qxxpjLg9xw9htbEA+a5siOUxaFSAv+LmvGDRxb4HaysQ9PRkQP4s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApCt/r9WkwcQMj4r/V+fWSjXmf86/J/NPraYV+jf4lAbRRe2Q
	8qqYctUtXG/vjTz83tuiFxy9jsFTtPoqvR8T7II9rpm8OSVqJXyYy8js
X-Gm-Gg: AfdE7clBUPWDnubCv1/6ByAC+v8gYbD2V7OgkzZ7ttZuW2GRCTJcViui5AdxkF8WBMj
	Yo3jAYqoz/WVIUdDZVaRFOhvpxcx9Iyx3r4txT/YKVJYbypxL0C8p/k7RbROR6yjhxhDPM411ra
	s8W5nBJdiyhuOx+3CAwX89ov3FD6LuCX+Ue7J1CPo08Y5eEgtnXZFD/M/uSk4VOgXMVpjy3hD5O
	jvD6G2X0YYwgpdzNaBpxlzt2CUp07QZNL/Pln6U/W5o6w4E5jiqxRCmpWUbWatCednkEpcpy7A5
	nfOxg63XNShLvxVvE3T+iSSUKIiUQaVJhKd1xuiwRVSyCcTVGXpHqldLwOurozLaCSZyNa7N1/W
	dPySC+X8voJls6q8VySOiHauZRwZ8YDMPw67/r3w41rFEgK5tEIQ48AFrnpLoyO2K3AqbNJ3kyw
	OaSBvh3jvcCwUFsy7RpFuHUCS4aAzQQCBHarHTagunoUoyKgHMbJhIfSh/vZnR0US3nVahMrZzf
	FbWh5hYlxsfbAFKmcdmgpjqXSaaxNnDE1lean7hOY5QliTOcOvrDR53LyLb5qdy7fXtpd9FxGra
	TX2JWv6L1g9VuYRs0EkMltMSMN3hBz2SWOCnmZVXLCMXlC6KfGbuzsg=
X-Received: by 2002:adf:ea82:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-4775be03177mr3789033f8f.37.1782933713282;
        Wed, 01 Jul 2026 12:21:53 -0700 (PDT)
Received: from [192.168.71.52] (cst2-160-240.cust.vodafone.cz. [31.30.160.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm2081838f8f.16.2026.07.01.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:21:52 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 01 Jul 2026 21:21:47 +0200
Subject: [PATCH 2/2] iio: adc: ad7779: add missing 'select
 IIO_TRIGGERED_BUFFER' to Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-add-adc-kconfig-deps-v1-2-b9708d74f426@gmail.com>
References: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
In-Reply-To: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jonathan Santos <Jonathan.Santos@analog.com>, 
 Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782933709; l=746;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=ZrVUK7Zj6N1KP1R23c6/0Wh1JaKWO2Kf2XCkb8zt+wE=;
 b=Ji9u+4oeSNAFqIlJi4djVclgX7CYD/lSiKslgxHIBpV/TPmePB3TOA7Y26HQRA38NC0dJzRTR
 AihUhHpsaHZDfN6qqYXFe6NsLniKV/iyfv+2XzPAX93SS6vT/R0lC+E
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the AD7779 is missing a
'select IIO_TRIGGERED_BUFFER' parameter, causing build failures.

Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b1437e6b02fd..878f8145406f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -454,6 +454,7 @@ config AD7779
 	depends on SPI
 	select CRC8
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD777X family

-- 
2.54.0

