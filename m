Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0B3E1693
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933716; cv=none; b=RBrTmpaojixLcLBwEvFmyIotrpg0XW9SOLGrHQzUzqzV5Anuy2/v3Jchk3GqtG3z4agcoMjQCvCi/gRCBg7dEFykedSdL1YGNQIkF7+5Gnak2zWNNkmflYRtChQgtuGJGzrbkCHZbwaR/t8+L8KyFC2Z8599Rw/4dqPqfdq289s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933716; c=relaxed/simple;
	bh=0tAhE4IxFx91F3oEYjTm6ajNyfPU/CrBLoLk7eRtFC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hei1ZocLwNqTgvwH3RGy5vHCFVHQ6i6ZRBkWZRbQx205MWl/XkzLykr3tXYvNgK9Fu/LiPSNuPCwJMpGV59t8jUQoKNx4SVQ/lDyvth23rCRO5I8ImpWwDnaSdlIjRfJNUUQEhZXcM3sxveJ9nJx3y+9NR6ApE4kP3tuyfdWGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1jebpaD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1jebpaD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475417f010dso707742f8f.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933712; x=1783538512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm57qUnAiYiyWGREIrTrj6/T+W1rZdq98MsMwMCVRHo=;
        b=k1jebpaDC8NvnQFWQStK6Zdlv0R72tG4x2NuaiJ4EKTihiMUe3XEpJXSR+YlCXkgDR
         Lxbzq8o07Xmhnh9UlDA6COvAn2Tr3ySEE5gc70OqOQibG2TWibCb8UZBFYGPlME+QtDV
         X3YD+iEmmXk0HulBT0+AP69YZ96O9/eq0fHol4tDq7iF1qLjTmXD61DzuDrbMZj2Zk6P
         wBB/FhRR85fUHSgup+J5S47MQhF1ti6XPyd97DF1ru+HjqPMiM4Fa91Ly+JiAdZ4ubu3
         uGEMo0/GVVlyMCYWg4ddobGf4Aj6XNmikl2UIZmLsi46fipamcUs1VjVWVO04jr3Tzh3
         +9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933712; x=1783538512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gm57qUnAiYiyWGREIrTrj6/T+W1rZdq98MsMwMCVRHo=;
        b=gExFWDaTHYYHkHw/fvErKjJw25/4TZnhFOV1v8FaTfPsdkzvfJRxj0QVK24juWIBC8
         RUAzHMI0zHJSJFw5BynOjajp1Ht1t7SAH2gAfX1k9qrl6vvP4pEkNJEKq2DDrnqG3m6V
         KgU4qKtRHtkUcBz4YP2b53QEJJYSFOYsgG4gBfJtpvI+JMes4jYIaETUYDtlaV5JPdXW
         ggIaqjqWEMHK5YQ5Em+Lg/8YX1jw589yRP5LU0mmn8krI5Rt/0A5bFcbC5Abj40kmJcZ
         QTTpKhS/0qaeGgCINgNrdCGmJPag9t2vM75xJ+2b1MqHM/C8y/za4s+WWNi3bmhv3BLo
         IyOg==
X-Forwarded-Encrypted: i=1; AHgh+RrUVP5vcH2o2U8GgQvn4QytfoYzhstUNd0PRluFO+4RPXulsqirnhwWw0/tO1Is2RIf12ur2tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWZ0cS/do1nj0ZryQ4W1ns9ZzLrdRzLpDjNrl38chhTWpSGRB
	fN+ioIJvdlk6X3JzcXGuhiOkX+g6fxV0krv0kckGzXc09qh7UfHtUyNg
X-Gm-Gg: AfdE7ckBL6lFStC/BDqsq7ZyqGI8DaCnj3wufQRXhSCWxpfoYFIsZgFO0e9P6eqYQt8
	y4KkbnPjDhn+mGejBUiZaO6qucmBPfrg3+SUNj21zjr3pgFZAHWgmQw4bsRCZB5StuaTL0DUQYH
	0mmp+717MfgshUG1qfmuBOIispPQydGhWRjU8YQG+ltRLnU/JqzZP+8sTrqAjUDeujyzg4p3L/3
	5rjOWnqEhASOXysjAi+KlLKNoSAS+XMHoA2Km4byYioSemO2PrJWHjOTvLhkgjJXeCNaNQs9EQt
	JG3UJBBJ2nNPO18BVZtjoNYfD8NMshsIeBCv7FA5Psy4T5ofMThrwlSOgYspViPM86RmxrR6Ff3
	wAWiyX7MQC/Y1l/EDeWZxlsMWB7vYMWPr0A4oimJk/dwKzBjRh2A3tmSPHGMYJypSzV0211zV1R
	qaW5hF/JFdQcin/VzWnbSzCSiui0CSrb0EPB523TeP8s8xnXg6+vxKSFAEp4GWMon7OzLmM7tjo
	xTvCAQsTA+I4CsuAwURgGGJyYf1ZxVCgy4j107uNnzmDgUZ4+7F/nU5XCOC6y8pwzNVTSbl+pYh
	iOjZEKJv9pk5EkQL139VBVns6mjanPwsbXMN/ZPu9fcEgXufJFP6ymOe9GrJjVBJ9Q==
X-Received: by 2002:a05:6000:310a:b0:475:f0f0:9ef9 with SMTP id ffacd0b85a97d-4775956884emr4457814f8f.48.1782933711497;
        Wed, 01 Jul 2026 12:21:51 -0700 (PDT)
Received: from [192.168.71.52] (cst2-160-240.cust.vodafone.cz. [31.30.160.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm2081838f8f.16.2026.07.01.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:21:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 01 Jul 2026 21:21:46 +0200
Subject: [PATCH 1/2] iio: adc: ad4130: add missing `select
 IIO_TRIGGERED_BUFFER` to Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-add-adc-kconfig-deps-v1-1-b9708d74f426@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782933709; l=713;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=0tAhE4IxFx91F3oEYjTm6ajNyfPU/CrBLoLk7eRtFC8=;
 b=8FAGCHKaTwAmKYj6/hWcONs4fAwKNfg6nzntO8CAVOpaEtsydIChSRpgTPZMFQNAxN2ThlNSY
 qgH5oFyKJqgA0T8wfEmUkuljhQCdGm3nK4T7UvnQpaFde3Kuq2R7jR1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry is missing a `select IIO_TRIGGERED_BUFFER` parameter,
causing potential build failures.

Fixes: ec98c3b50157 ("iio: adc: ad4130: add new supported parts")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 441e5c660716..b1437e6b02fd 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -109,6 +109,7 @@ config AD4130
 	depends on SPI
 	depends on GPIOLIB
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
 	select REGMAP_SPI
 	depends on COMMON_CLK

-- 
2.54.0

