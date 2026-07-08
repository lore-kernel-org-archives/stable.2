Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D23BCD2E
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488863; cv=none; b=ioh9tMGDeBTsL4SCtLkdWd892N0wTEqx3oL6c9zKSUaURdB6GL4IwcFTaAnSqjtFFOEjqoinkAK8iU0IvNABzV50w6WM7spBxHrXze90TDtOvdVXfg37Pzd0jRWda133QggJlTgg0YHNBHBJDs411MSxh85VJRzv3hTRhVk5bFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488863; c=relaxed/simple;
	bh=YHDLftGTXkviSiCuA++kFBxR6Qc7YkPsAi1+MB3+5Kg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m37mdTfvSfSg0SCh5QfiVBVpUs+xMSM5RkoKDGUT09+aY89dF88/IHoIMI7ogSLGn0rwRjPtiGemLfcp7yLLzdjo+rWMP1IZJzZbJT0G9FyWQXtPk6kTh706mhUf1AK+exQysevg9R1zL8DjGMsM2CvSnhavQRlaKX0CPPhez2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHPlu4xJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHPlu4xJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c7902f47so1259055e9.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 22:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488860; x=1784093660; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hP4GuqRT5FtMAFHBUjU6kmy4KMyxCZiL8K3lKmV8f6g=;
        b=hHPlu4xJmZn/PeJoRHc//CvBkbul392JKMmJVzP/SdOEeUm1pulBYxMQhFnZ2YDDxq
         TmdEzINeB71gYIPi/HaLDLoFwt+o2xGNI3Wvj3gL7TWb2YZmN8mFy5BCDODiQvfb1wZV
         XYEMe+YygIWarhR/3y6+QUHp1TKwZBrHNjTZX0699jzDyfUqsmk/+uZ4Fb+gJpDii0cb
         EHo3WlE36JRYKgY+e4CU/rih1vkVJdzFffDz1dFxWHedubKq5n+EtkIRhHuYH6P0cqGa
         dZ+DOqX6Fnr+v1UtSBv3rHBRUnqOgFv9HAa6iksPKIkKLANq7wxxsXpMV7SdHmq4xRnd
         EkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488860; x=1784093660;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP4GuqRT5FtMAFHBUjU6kmy4KMyxCZiL8K3lKmV8f6g=;
        b=Ht6KHDq7IFDc07vM+cKtcsoqbhCdRM0Tu0LMxJ789KCTwrvUbLD7gEPUS4iUMk5ED2
         eophRRd1/leW4g3TYpE/zZIN9yiQwxvageSTwj8Y1SUNiZtuLijqaoV5vpacfWhGHacS
         k+ebXZVUtTFy4qSyRQEEeQ5lYWG8DBhxlOYTI6Z/IDNlnZiNtWixpPNbty8h2yi3vm0V
         3rmSDVBALTpzEjuNQIhuNLZ1BumZRxY9b2quTCou21s4R0zYkSJ1765me7XnGVrEKnH1
         HPHUIiAOhFwJ8dyOhtEwwsqb0tZGYE1eYz/6S2zjMI9hJyNn/tTVf9Tm6XbjifQPnC27
         6hUw==
X-Forwarded-Encrypted: i=1; AHgh+RqxbQB2yjTZcLAi0feFRqmpbhTutLMhu9Hoxkoagjt9DIdD6bnIJHIYxdLUAijiJiOM53O1tUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Uew7bF5FC7RiEDvkQQLuet8XpYKuKJpo2znJsgg9fnQUjsDf
	n4j+Vxca8CpNd7LuS0I+LnWMUwt6Pse60pA5fs02pOcLUPt9Yaph3f+F
X-Gm-Gg: AfdE7cllKcXw6MQdSvT0CkDJrGH6qy2mI7TL3nKdzK8BCWZYyIpWuf2GOT2YElWALVu
	MjMzWtvX3dYsaeKoyqLrBDNyuxKAsrRcYahsa1uvGYOpoxpqvhK5zE3Ok6+ykNDBuUDIQkHf3Ma
	THherytQPzGvJ7okG9RkxbdRQ8F7Kwl0YUIljciqVhBtcd62MgaGSGVXjxcFwuQZeP0X2TN0iTQ
	n36PDPE2AQH+CDcCFb3Y0GNSo/Z32Q7d8BhPJuKV0svkxoZlS46g3Stn0EhA2WlCEGOFDNghBJQ
	vE4Ktg0YRswadA7FLLsp1XnRueVdKXiCODceDE23LVgoHPxYgLoYPTzVGg/I6tG/IUdHhXmzT5M
	JSWSNt4BsX3J94v4+YLuWFR6KcIrER0NPn4Ula2oJ2l5tYJBO2sWTUnnNop4QuiPopgTGNEcC13
	9nxAwi19bmzm/y1ZMf/PfV1McxSEONuWWLscWiXvPY40e9Ag3BkrKnd32JOHvC0nYGD4+3AVGTd
	vXVDo+7pI20M9797AeR8R7jwxPCb9LqRVoKmze/0TI/5nlTlpxW8crZTSKo5Sm4H4/EptFedqZt
	MREqCXJiob7+B2mWejce2QYud/2twKf0ndgXA+a5pPdsTG/Dcj+wpA==
X-Received: by 2002:a05:600c:8b34:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493e685f1dbmr7597595e9.19.1783488859746;
        Tue, 07 Jul 2026 22:34:19 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e544837dsm35528415e9.0.2026.07.07.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:19 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Date: Wed, 08 Jul 2026 07:34:11 +0200
Message-Id: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBuwIMOuEi1MR5uFFg5EIN09a
 fkW/1cQKkwCS1eh0M3CZ24Y+g7cYXMkZN8Moxq1mtWM1ntMLMI5YqGY7IW7doMxdnJBB2jhVSj
 w80/X7X0/iHqVj2QAAAA=
X-Change-ID: 20260707-add-missing-regmap-b6c199a5cf6f
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488858; l=882;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=YHDLftGTXkviSiCuA++kFBxR6Qc7YkPsAi1+MB3+5Kg=;
 b=RGlh604wq8PDBvBXVLlP7OCpvztabJpNoNEs1/AR+UrZOVteZ2j5DyI1tw5nznqdMKV6XTi1X
 zLp4zZNBqtdD0pAqtW47dOnjBO8uSl4kVY9oy7nWTlX4lR7w+FvW19w
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
may result in a failure.

Steps to reproduce build failure:
1. Run `make allnoconfig`.
2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
3. Run `make .` and make will end with regmap-related errors.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (3):
      iio: adc: ad7380: add missing 'select REGMAP' to Kconfig
      iio: adc: max34408: add missing 'select REGMAP_I2C' to Kconfig
      iio: adc: max14001: add missing 'select REGMAP' to Kconfig

 drivers/iio/adc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
change-id: 20260707-add-missing-regmap-b6c199a5cf6f

Best regards,
-- 
Kind regards

CJD

