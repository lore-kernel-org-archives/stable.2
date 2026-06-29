Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE193B8BD1
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732653; cv=none; b=rUKjdmQX7iRfwR0+PJGwZwbQ8+Ha4LyB1rEsTgIAdDvvfDFmjPDqo77Hqkf6YhC9L/p+QwHaN8xDEk0iKvTJb1lckMNLtWxWTYe5Vi4V3yPPVuUPsaL6r48p45AEhJw4SHN5ZKy5X81KSGI9wai175pXL3OVIUZUAeBEFAR9TLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732653; c=relaxed/simple;
	bh=QSUEAP+Nd4pVoltuzLogp/stpR4Z7CG0NdMEnz186bQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XuhNd0iqLcITIOtBsMAAzJOfF8qDmVOJsDzuzb6MMomiXtAAe4s/tj12jiTahnSLUe0Y+p8eXRLdOH4Rq5j779HshaVOQhpr3mfBFfyDoyg1xjNLp3eCFVsdte/XXmH8VrRCA0hvsc4iRSbr5TS/GVc/1FB0SbOwkvI7ATEPp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hcfVZ8MU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hcfVZ8MU"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso802144e87.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782732649; x=1783337449; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOxj6jhWQaC4bW6qpCLMl5ChGw244cUlmVoMPEl8HCI=;
        b=hcfVZ8MUninAnlFVPrjo0AcaKWagp+SjW0Jw/gOs6nfTWgOMw2M2KldkQeaeYqXoP9
         d1oaUZn3pHfDIdm0NxTQbo+n03Lv3FNLeVXcoTyV6NIwW3uA0d3bMi2TQjiFeKSeukRg
         RwTftMntGEBTdJLiTgdgDHKcoFt4fCmoZsDkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782732649; x=1783337449;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOxj6jhWQaC4bW6qpCLMl5ChGw244cUlmVoMPEl8HCI=;
        b=HCCq9dfeuS0POeEjzgg7+C0KbK4tehIdN2xu90qFDqpaRkwzhO6gymOreMCF825lKu
         DFoqdEjPYs9psFOCg7jMBGKSnRts5kqFc8WFDd6jAif/Wc3OkVth4rn5EQbvCrs6mZhp
         wkzEWqTOMpILg82PQHMWHmmptM8hgjlg1oS8dlCCdMD24VDMn+VoQbjgKmM8G2MCjvdf
         ndDwOQZIZlW32mvplhoxOW0kMAaIJv275Me4pxaO6tvtct868C6V1guy5S5QhtawG93h
         yfFFab5Et6MSCozBoY1kqLAh/J7tBKWEhso1oFuspWDexvHoiQ0t0jncvX9Ucb/qRKsh
         5ADg==
X-Forwarded-Encrypted: i=1; AHgh+RrtCvFFOSmCkT9vGkleI2PKAQOtlfYoCNpNpadF4oyfEMCEhRTgEVK3lk/E148iWEVYZopdKJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCgL291/9w6R4phJGqoUHXdDMtGyr5jmIOMtWE2Yse+6SaWgV
	hN7m+2pVONLSJLm4h8x/eIt3e/zLOA3ejovZT2rUv05yakNLxOnfCkFt/YopycInYw==
X-Gm-Gg: AfdE7cmNxDG2xm0JkVGxAwlBfIEZLL1V73SozdHnEfWfMkr8dBC4uFC5J3Z/LhQS6bU
	OufjEKSFJTSuMLRfU5ZtvMWIxlGCGZXJnu6aamF41gwFPL281WwrVYYiRsbuYPHveEEk5wWOXGE
	B1iWUe3sRrygYboVgf6IScOLW/aDFP1llH0N96d8jU+JIJS2Vs4+6jRo+fkJjYhx1tW+EPYGD2e
	teC8lyw5s9x/qXSQ+pxXwyFL0Yyks9DmDfb/H9azeQbRfOvBILUYG6V6yJxnLqoeLPamGHYZtTO
	l775Fh4vevJwdZg82WOEIgVDf3TI+p48VjduG4aYgmg/+LXtOYSFIiuA0T374aDr3t0O7rmvw5s
	8Mq0wmJ0hg/ljodFL1pGFskXStdQSmRBUqMZl8MIxtmwWxzWEHIVoKW7/tly1LiWd7ShrT+lZqB
	57IMmOoVBftLYTetM5wtz+Z7sAKL+HCQW3lKB8xdS2MNsUDly0X3OLNzd4A8nqA5WlRyNaRjCjx
	TQ6fAM=
X-Received: by 2002:a05:6512:a35a:b0:5ad:55f6:1ec3 with SMTP id 2adb3069b0e04-5aea944f191mr1546849e87.5.1782732648947;
        Mon, 29 Jun 2026 04:30:48 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aea2cffc04sm3597745e87.17.2026.06.29.04.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:30:45 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/9] media: Fix all missing cocci warnings
Date: Mon, 29 Jun 2026 11:30:41 +0000
Message-Id: <20260629-cocci-7-2-v1-0-5884c80ee3b6@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFXQmoC/x3MQQqAIBBA0avIrBvQiZS6SrQInWo2GgoRiHdPW
 j74/AqFs3CBRVXI/EiRFDvMoMBfezwZJXQDabLa0ow+eS/okNCFUZNxbCey0Ps78yHv/1q31j7
 Q8KBlWwAAAA==
X-Change-ID: 20260629-cocci-7-2-7d30217e6526
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, Bin Du <bin.du@amd.com>, 
 Nirujogi Pratap <pratap.nirujogi@amd.com>, 
 Sultan Alsawaf <sultan@kerneltoast.com>, 
 Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Abylay Ospan <aospan@amazon.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Bin Du <Bin.Du@amd.com>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

With the introduction of 7.2, cocci is triggering some new warnings in
our codebase. This series takes care of the new warnings and refloats an
old fix for dvb_frontend.

./platform/amd/isp4/isp4_subdev.c:394:6-25: WARNING: atomic_dec_and_test variation before object free at line 395.
./dvb-frontends/helene.c:1049:2-7: WARNING: invalid free of devm_ allocated data
./dvb-frontends/helene.c:1013:2-7: WARNING: invalid free of devm_ allocated data
./dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
./dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
./dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809
./test-drivers/vimc/vimc-sensor.c:107:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
./platform/qcom/iris/iris_vpu_buffer.c:703:13-15: WARNING opportunity for max()
./platform/qcom/iris/iris_vpu_buffer.c:583:23-25: WARNING opportunity for max()
./usb/em28xx/em28xx-cards.c:4085:2-3: Unneeded semicolon
./usb/em28xx/em28xx-core.c:635:2-3: Unneeded semicolon

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (9):
      media: em28xx-video: Remove unneeded semicolons
      media: iris: Replace ternary conditionals with max()
      media: vimc: Fix prototype of vimc_sensor_update_frame_timing
      media: vimc: Ensure that pixel_rate fits in 32 bits
      media: platform: amd: use refcount_t instead of atomic_t
      media: dvb-frontends/helene: Rename priv variable
      media: drivers/media/dvb-core: Split dvb_frontend_open()
      media: drivers/media/dvb-core: Refactor dvb_frontend_open locking
      media: drivers/media/dvb-core: CodeStyle for dvb_frontend_open()

 drivers/media/dvb-core/dvb_frontend.c              | 159 ++++++++++++---------
 drivers/media/dvb-frontends/helene.c               |  56 ++++----
 drivers/media/platform/amd/isp4/isp4_interface.c   |   4 +-
 drivers/media/platform/amd/isp4/isp4_interface.h   |   2 +-
 drivers/media/platform/amd/isp4/isp4_subdev.c      |   2 +-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c |   4 +-
 drivers/media/test-drivers/vimc/vimc-sensor.c      |  12 +-
 drivers/media/usb/em28xx/em28xx-cards.c            |   2 +-
 drivers/media/usb/em28xx/em28xx-core.c             |   2 +-
 9 files changed, 134 insertions(+), 109 deletions(-)
---
base-commit: 253355887a1ab0ac8f33b356c7c1140eee554d18
change-id: 20260629-cocci-7-2-7d30217e6526

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

