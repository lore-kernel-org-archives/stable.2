Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17524189DD
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385429; cv=none; b=tYoJ7Do2ax/JGJrle/rUxKC+FBAMlU8TM5rb27kjWNQ9dCcgXB4B2hQA+DgoSku1HO/Iw36vzO9FYCsvISGs4xqA9e3LJLkl6o8SUhXXfNfrjPYPKsWIecuO9zFnBOK+LHLMRrQz1L4tP877nBEGZ9na9pJu1uw1rCT6JEW+JbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385429; c=relaxed/simple;
	bh=TU4JVaasjIZd7t0vMZCemM1pDk02dJBmznDPukWE0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfQR27IXCB37v/UykAK8ZUXYlGJi6YP9x+sT8EiErN1LN6zYmRcRPNI5eVioApPbfoG8ouB820uBU9lpcWH+Nkxr/FBhFjANI0K/9n4PKBa8j0QqhvB0trTLdmSsZCzI8CTP+6TCgVt0jS+RftHXYSo4L/QU2lYTIScrpm40Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS+J8FA3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS+J8FA3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1818738a91.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385427; x=1789990227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sGBFxtH4+r2rt8dp4hP7icwkPNITskDS+AT0z1/Kycg=;
        b=kS+J8FA3sUzINznR+8mcJ+oSicZQ/HpXqAY9Aty9xANNw+Ep3USg8Ys0H2RkVbotPp
         7VLpfqcR4aEpH0KrD1PBgZCv/LMR8ABEb3tZeWlOu4BcUE0QYqQSMdxEhJsiQ+l+W4ff
         peUrRZnhqIp2u/tKJeqMm57pfX1TzZR7mqUElqAyPKaO5TBaaIdWyCb6vreuI1kk/9yR
         JPn4lTe1iB0T0T2JWydjhPSDastJ0FgNKy7jRUZtLF78wFSvKLae3o/W0WLIdjAV3PCi
         +b8xAqqYNq8qycYrQc3A/FUKer9rGpJPAOfWe2eYBa6YCfEw1icKckeeue+OhEVHsK1c
         GsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385427; x=1789990227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sGBFxtH4+r2rt8dp4hP7icwkPNITskDS+AT0z1/Kycg=;
        b=XXow0kxTLLJy/bz0vws9WBCgEsMoLyJG9OuwmDT7/eOdJT+VnE3ulH+kpNE8RlKXAt
         /vBiW3NejxUUgZDbKGsX7OyySL4O9gO0UCC2WauEc4K+y7y8cGFPzPoKRjB9OTwufYNQ
         xDg1wIh9cPmBBx0iXt5//XtvTOrPVjlwebcjCyGLPPGilb07nhoKQpOLql3mXgn4V1Kd
         4ZJOu5CFgkt4R+CjtzcUChXl4zsEXOGbSX1quh5U3zaoFJ1DTfESLmMm3lGDQru5f9Nz
         t+PmPh5OwJF2mmGYQCMjmArmhD+nJ189biKf13JURtN3uwMrAsupAmvWAvRt6tyj7vIw
         aF8g==
X-Gm-Message-State: AFuF++n5QZIiZogG65vAcCTUuQb17DIu/nJMDnEenGM67njFPp5ib2ZJ
	hxZyaVsZ7NEAkJHDajsMePLxedN1p2G7s5mP19qNZPbYJdEkknbRn6Om
X-Gm-Gg: AYBFou1g8/jL+bo/L9LE2ThmcvcBr3QoMBlGX+Xi8gCU/YNPIfZVb6v8gbw3COR6mjp
	COhgFCevSSUnARqsCeiXnsLDuVnh3ckr5g2NYIEzyOLTMMeq5cHozj3o5ZLDNwIo61UYKYCs5E6
	a+ObSUD08WW4LDGeOFwwHjCl5/dGzvvbjRupobjYCEju2dhi6CkJW6VwTk2+yHcxVXg7B2b5WI2
	eTFMN53Zsvp255N++7Y7l3OygyB68HVCqy9MjItABgWUUUi3tZxlleSL/gLavJcqk2qYDOhTkzj
	OO5GoOf2hX08r0DiShJACpZvjKyD0OOSJQbcnyI3VcA0uwWAvYCEif5hWtZW6oW++ii0cukIBut
	YT/VnXD8FiER2bM03KNtEZcTu0WnPKUvg9wlnEHUpJwP80gMyLnDFI5d3FueC29NgC3etDIa5du
	jKpBWFQ92Io2BYVnOeb9OUV9PpENj8fdNzPY/XcVamEwIzHFjOH8H4Kr17MXMJAqs1vQ==
X-Received: by 2002:a17:90b:3ec8:b0:39d:e43c:5a0f with SMTP id 98e67ed59e1d1-39dec059046mr4410018a91.14.1789385426686;
        Mon, 14 Sep 2026 04:30:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39db996bde4sm14562532a91.7.2026.09.14.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:30:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: accel: mma9553: disable autosuspend on remove
Date: Mon, 14 Sep 2026 19:30:12 +0800
Message-ID: <20260914113012.1688043-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mma9553_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 40cb761306d6 ("iio: add driver for Freescale MMA9553")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/accel/mma9553.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 8e7aaac89d47..5a36d415a837 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1136,6 +1136,7 @@ static void mma9553_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
+	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.43.0

