Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776026;
	b=2oFLxGiFYZplcjI3wKMzliRrwinW6+jJAR41EmLM5SZ0Nozy3Q1jxHRIWhavrJHMxb2V
	 9gh3JZJ+lYAVXxCUy54fzBRPQGh+obivueLNtEUmsNYu14fKrydHQCuLbx2rapVZPicpm
	 59OJD544nOkyCVThBhONHm4lyTpZkSLevyIDt2OXPoTSCmwk37H6OhApIn+/WheGAqYsr
	 GG4qmE59OfCzl47cONEIuMT/ohkBDEz5FbhLvCe0wItpqm9Zk7oQnp4a/9uK/5cNr17ka
	 QXOmyC2VsYxara/i5UaOMUVct+9If0U4i5IzSmkE23apcYPLNmIHsGzP/r0sH3jrLUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2c6Rb/UBk4azewF8bkRw1dkEc/rmGwcJQDMivDwr1lA=;
	b=gSnM0yZI6vFJzwRL4tBmtYvmABz5kX3t/znEXZbmvlWrk6zdwl6OI7B5Ut0tq2GpA/c6
	 GXiKm8mRWqJbPHgRAUXXAYOAFmAvyHUqjZpKQsE31XluaMc4gdTQC4NUEyb8E6S4rIRTG
	 X2KX61pi0MQMYoI5+dQEZ/TIsLpAuzuZOIr7t/rgXCXQy3Xtm/1wsiJgkZJ8h1wRCwDrF
	 imhely2i0XmAW9LrmaglcBiFJNspch/JPoYqjsUGBbnGqyp5Dt2jZ4/KApaZ2x2HNnof8
	 G4izpT4OzOHcoUMu9GYkLq6uFtr2NwRFQmiNw1MNCfefNSGzw1NBxDZIuND78mEbz+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A3N0j4LT;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E80606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A3N0j4LT
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6bab377105dso6862983a12.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795776024; x=1796380824; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2c6Rb/UBk4azewF8bkRw1dkEc/rmGwcJQDMivDwr1lA=;
        b=A3N0j4LTDHB+nZov0bYOhdq+QD9ToDVXPLoAPfN5BMtkHjHrdYcQjXgk1TJD0C9Lgc
         a2hwnkkvaDX/A9qcpXX9L9KsQwIPdRndlaQygfgxukcPIwXzBG6JI5mkfuKCO05ubFOa
         JVflOniyJ2BLLDHn547HiucnguS0FXCkS9q0lsMWDbElJWYojSpxhnrumQG5q5wCjZU3
         NujxT4+wlFkXa8eqdfwC50bqCBWuEN5IVsySm+1l2M+8krTGtOju2WDK5PuwkXwtW+oU
         UVplpWpkZsHSUaCySe/IW6oegIM4eWFHgByQEwe0mK0rYsTKlDAoHUn2Cdy4oH4VhZw7
         ZA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776024; x=1796380824;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2c6Rb/UBk4azewF8bkRw1dkEc/rmGwcJQDMivDwr1lA=;
        b=Yi9gLyIpCwGfQC4AeXmU8YWm9vQTvYZuDmN5ZZiYWYfVyjREBYJxCs0x6FOI2QcKud
         PW1faOmWotakmJ4xaG818BgRS30pDfaxhous+odMyiL64PM953A5Lu4tL8g7TuobwRIv
         RZGPVPod/4+ZPYJYrSV8WK5+kK7kpaYCEs5n7iM/9hrMcEfVuNzyF8EscrqH3ifMVJ+D
         KQ3sx1/3ht5+lFz3vFXIEHJGYF6qsbwnka4j8jPxcUsNuCSHECRQ0K4BHCBaO5cIC4kF
         OGuJhZQxC/qZ/4637frlAnlKai5sOIbO6urDpPVQpiOSfsob+GZ37/8ZR6WZYNrYOsPd
         t6iw==
X-Forwarded-Encrypted: i=1; AL+hErF155Ecv+YTMovpHwfzbsVD/YeR/greGaVNmG8eeVdANJKvf0ty1o/Y9phcXaVCvo/CThrWGaw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jMJBXmL/cWKx/MwW2XsJkgQ2Z3XhSY+UKiAq4MQUsSaRInwo/
	SQkO3Dh9R02N5sd8lMgrlCRKUGh86YDogqXClkr6WlQZU0gufLNPpn9rJ/bZ3zJviDM=
X-Gm-Gg: AZFdTZehIf8M49P/j5S35rro/bZYfpgXJrhZqwTTwNl2J6/I1mDuTvT8GElYMhdKu7b
	KlYQyWHLJcwXlLImkUsc7wHSjJa0JmE8H5m4hOd6N6FyUrKBMwdciMq7GP+wwV4EqOX/bVG0t6Z
	q/gV31c2vD8L3k5yZmS4P5M1O1bQhwejxCBl8FVjsBfrqTPU31st+wYAzY6uBnq9ll3pWGV6tkA
	566yCM6V9SLIDko7Ls0SJPu2GA7LtCWzYT1iZ+Pkpd/u070a0r0jZ8HGWa8dZjeHUYeGJGpF2So
	sq8cbB6MnIYNMAhS/ni8AipgtmUUjvkQmgUyY6ljx9Vp9H3RkZCed+yjrDlXBRrBJVs5Vm1evYV
	5f1mypZkc3y5bzfq5fUFJz/m9/bwF6UiVbsFv+DXpGd1RwETzNkOAeo7YYfxbLXyhITldEjWdea
	vs3WdoT5hXFF1wuQWZNXXycMMRryYKhlQL+a1btEWx4Ja+dIpATh8o0oKZn028bx3hrJZtS3DWX
	b14zciFaLBk57G+d/2sKeQ5Ljw6fGXUMs6ODeCaetaa8EN/x8tI94V6det+3oQcntZNo2Mz2L8u
	OjWmq/Ni+3T/Un/rnddFhMDQmIviPYpkWqsOB72IYygIUID3MjQSyKxJ96ly6s0o9oWZRMt72bn
	K9Ujowih8OCCskIxi+g==
X-Received: by 2002:a05:6402:1492:b0:6b8:68fd:bf30 with SMTP id 4fb4d7f45d1cf-6ba37d5bf2dmr12996663a12.13.1795776024088;
        Fri, 27 Nov 2026 02:40:24 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb11ff543fsm3919199a12.2.2026.11.27.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:40:23 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] phy: samsung-ufs: fix gs101 OOB read and use counted
 config tables
Date: Fri, 27 Nov 2026 10:40:20 +0000
Message-Id: <20261127-gs101-ufs-phy-oob-v1-0-144b0e04c3a8@linaro.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABReCWsC/x3MSQqAMAxA0atI1gaaOiBeRVw4pG02VhoURby7x
 eVb/P+AchJW6IsHEp+iErcMKgtYwrR5RlmzwRrbEtkGvZIhPJziHm6MccbOVKaa2oZcPUPu9sR
 Orv85jO/7AcBI7qxjAAAA
X-Change-ID: 20261125-gs101-ufs-phy-oob-80303a651f4b
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Hi,

Booting a gs101 platform with generic KASAN enabled triggers a
global-out-of-bounds read during UFS PHY calibration because
tensor_gs101_pre_pwr_hs_config[] omits the END_UFS_PHY_CFG sentinel.

This series starts with the minimal fix suitable for backporting to
stable kernels, followed by two hardening patches to prevent missing
sentinels and out-of-bounds config table accesses in the future:

- Fix the global-out-of-bounds read on gs101 by adding the missing
  END_UFS_PHY_CFG terminator (tagged for stable).
- Embed the per-SoC config pointer arrays in struct
  samsung_ufs_phy_drvdata with fixed bounds and move them to .rodata.
- Replace END_UFS_PHY_CFG sentinel iteration with ARRAY_SIZE()-counted
  tables annotated with __counted_by_ptr().

On arm64 (non-debug build), the two refactor patches shrink
phy-exynos-ufs.o by 144 bytes overall (.text -160, .data -176,
.rodata +192).

Note that exynosautov9_ufs_phy.wait_for_cdr is never called (before or
after this series), because exynosautov9 defines neither a
CFG_POST_PWR_HS table nor hibern8 tables - this series preserves the
existing wait_for_cdr behaviour.

Tested on Pixel 6 (gs101) with generic KASAN and UBSAN_BOUNDS enabled,
including UFS hibern8 enter/exit cycles.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      phy: samsung: gs101-ufs: terminate pre_pwr_hs config
      phy: samsung-ufs: embed cfgs arrays in drvdata
      phy: samsung-ufs: use counted config tables

 drivers/phy/samsung/phy-exynos7-ufs.c        | 17 ++++------
 drivers/phy/samsung/phy-exynosautov9-ufs.c   | 14 +++-----
 drivers/phy/samsung/phy-exynosautov920-ufs.c | 25 +++++++--------
 drivers/phy/samsung/phy-fsd-ufs.c            | 23 ++++++-------
 drivers/phy/samsung/phy-gs101-ufs.c          | 26 ++++++---------
 drivers/phy/samsung/phy-samsung-ufs.c        | 48 ++++++++++++++--------------
 drivers/phy/samsung/phy-samsung-ufs.h        | 26 ++++++++++++---
 7 files changed, 87 insertions(+), 92 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261125-gs101-ufs-phy-oob-80303a651f4b

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

