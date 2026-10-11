Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAD329E46
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736802; cv=none; b=rSQ/m81hAvouBkSUqvn0aS1QzVoYS2Gwskx4y5OaS8EoPbf6gDy9XfwSDZCkoWhOJsd3xYZPjXCOyhdHkzNzAEyxo3X0OWxNCocKAhf2sfqlf08K0ZC34BS1jjp00eS4dMh7xUwiyIQrLomZGzFZOyhKFsod9a6eenQ6MI9pGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736802; c=relaxed/simple;
	bh=EhMBg/s6MnYlerlCrlEH8yhUL0K+RB5H1t9NeJh8E90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s55L8WzCdRX+B7o12gX6rW1RCOOXA7MfkFUCR+coiwnSl30DXseznE33GLn7ZnxS76o7XWvn1sLpJswAvi60s6LyIbioRlkvnwL0J4PDCh0Osy6f06Vf5kY1I1wF5BjirBjSwECygV2Jg74rCIN1RiscycXiVkE/G1nXnIIHlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzkgIWtD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzkgIWtD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a02718da81so8568035e9.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791736799; x=1792341599; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cjm6k42dOyLFIbxGk3oDRyKuVo/hFB0pF5yZpJn1l/s=;
        b=fzkgIWtDzSJHcoAEsOgTFoG3s6RmIXgu8OzOsEezkawmiSN//BheWRm1ofTHRtWP8J
         lPOsBuqvcRYxVRydIz+sxfsbchs00e4XjyODgipbazgZo5HRCEI7Qw/StaZyGW2NDfgW
         PlxqlS40e6FIXTaRNxUYToU04D5HECwup44LArHlQCXcAWVdyNxrOMkkO8hXqJxn8erK
         p4/8/wWyiYzlDXUU5aPHta9rKGcGgL55V24RH6fgV0ZlRVxbfCqrmF9RhSs5+1a8kLrA
         5kcza9HAk3PSWMWV1uD9W62YSgs6FkfiVY1ZNCnfNddB4E1wFrkXliMT1jUpuVZ4tgWd
         nWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736799; x=1792341599;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Cjm6k42dOyLFIbxGk3oDRyKuVo/hFB0pF5yZpJn1l/s=;
        b=hr4WJlw7kLprhwMcEwfQoGRxBEsJWQdouuHVH0KLHhIryxZ/Z929TpiLd70CNUsmc4
         8u1YbhOzZNBNm+N3u6c7ZG/fsTRROIkjdIJl8VSbL06zTXRgI0kSMCb6nuwOoc9BchmV
         sRMmnebb39tTXf5/3eguu4Rt0w8RlFV6LSUax+mW24HWBsJKdmeofT/FJ1gvzbHwDj5R
         mj+C4pF/Mk1GGLCUrxQNiFCbVpfcwpprq/zDY/jOqqnJkwAO/on/OrzfWNRCZ7gItErW
         PPd/frlerC08gabsnGh+EyVjSxFqwBo5g9oe9KrsDDextp6NvJ0x6iSr/VO9Yo8zK4zv
         PGnA==
X-Forwarded-Encrypted: i=1; AKwUvBxB4isvTtzqNgmt7Bdsa9TO7AqyxQNckXVN3DdkUjjn3CzKClhKLrDwWUCx3LftFMs8CBlcHUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2ABT7anb9kH/aEbU78rM0AwBsp+lSLb7HIosP1mJrgvggVgRb
	IF8nMgJ6d2ZpyWzW+fj5r7V4FBWmvM2TGkxaZsVhN9HVbtodCh4NfY+Q
X-Gm-Gg: AYBFou1+RbP5TQpGQxBGgxxWu/ZHhHwauyTPwGXjPP7jDeiUWRgCQhyQ6DCqw1X3XEr
	93D4JT2CWBEsmK2lG1Xk2KLFWNz4eFyt6zUKB5HZ7EjCbokXyBu/o6I6MteMrQUGofeFNIvwWsa
	jQREot4a5RIzs77+pkpGRiRueDNdENMeBXv8ZpJri4LbGxae+eFdwnKqF4dx5Lv5h2yk2h/TU5Q
	c8RivL0OVLp02qGmN7IbDaGz3ixt+yQ4EcWb5xq2IN2WSBTg7CJGA+xM3hDsgg5toooEr1fepLy
	hvqfmE99zBxC6sLvBzlnlQ1TywArAMhezXbeT/2Eiyu0eZqvy50VG2Ip4QKoYbcKifCzM10hmVu
	XadihLQOrVuRYJ3GEGN68Y+TgGDvB1/FwA8RlByYKMRB0gtxBUQhdMr8OUgDbOO+GYkJORd6P6O
	1Mfr5XYtblEIzmCYVsYSeOaCapnI3EysWmG98L4mxhpk8jK5KlqkJ9KBsaeUgQxm969VBHTWPVU
	w3JJ/uSaQ29/2P9lVf0fl/DsxrWvSJ3cA1QUilIOTkcB0OREMVkYAcl9CF1s5fuPkbWJLc/jkbN
	7KMk+zeK/6ZrwhDiDJR9G10yksNfUT1EN2CRVDGKIWkNL99Gu5ErDY1xY5PUgqa0LWanhtE2dMq
	jQd9CbEdBY3jc9QZMq1O/4ltnfK7c/4QhyrP9wjpClxcuGhA=
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr138567585e9.9.1791736799033;
        Sun, 11 Oct 2026 09:39:59 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm307874315e9.6.2026.10.11.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:39:58 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 11 Oct 2026 17:53:01 +0200
Subject: [PATCH] iio: gyro: mpu3050: add missing trigger cleanup on remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0ND3dyCUmMDUwPdtMwKXUMT00Rz8xRTIyPLJCWgjoKiVKAw2LTo2Np
 aAMP5/C9dAAAA
X-Change-ID: 20261011-mpu3050-fix-145a77d5229b
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dingisoul <dingiso.kernel@gmail.com>, stable@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791736798; l=1616;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=EhMBg/s6MnYlerlCrlEH8yhUL0K+RB5H1t9NeJh8E90=;
 b=hOSERUJHDV8gdQDBWCvJ8tQg2SVgtaw/Z8hNODJJld+FchhkOoytB/lOhmQWQj+bQDJHG/Mew
 WJkl/KqFv+5Bht20X9dkEFZ8DBHbM0TKYF8XsX4i2YG9ct2Sr0WsOr7
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The mpu3050_trigger_probe() function registers a trigger but
mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
to clean it up, causing a use-after-free bug.

Add the missing iio_trigger_unregister() function.

Reported-by: Dingisoul <dingiso.kernel@gmail.com>
Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011c63..096fd0dc608e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1260,6 +1260,8 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
 	if (irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);
@@ -1278,6 +1280,8 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261011-mpu3050-fix-145a77d5229b

Best regards,
-- 
Joshua Crofts

