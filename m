Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD948440A02
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469689; cv=none; b=W1zoAdzUZLjzidXV+RPdaGLupWzuX1NToNjNXrYElL/MMw7qxVvkqytrAPWkbgCk/mty077jBpAZgqWuX3IGp3J4u+U0WtsPx3y/zZ4fRgzx3Blr/nu1lyhKt1/hzBjTwrM8yKKPEu9mLuhiAoCzRO0Btm7jFjlpS1GS6X7fNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469689; c=relaxed/simple;
	bh=EkwA7aGDJfEGjmuteNX1FzlNd7OD3Fs0oBxnoz5r7wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcOrXNt4631WngWXxPCqc4RSDOSJQ/zXj1V5yLHYCS/fmWpuo2M2FAbx9HTqPvOe/RPfSh2UD3R30InoPlzl6o3Knf6HbYsWX8/a4zZ33F+icoUEeBTnQ3rCBjcTP5deeumwDcDEakRqjVKCHNu4vFYUjD61cqpp6geWlGTtJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyRb5afD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyRb5afD"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so400685a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469688; x=1789074488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9qMk88WNjm6tym9wKNjhsNjwQfstK6W3opdEkr+jUE=;
        b=hyRb5afDcndWjRrqjNfYef3ocGoANWp9JC4gtLq0qdTvITjYu+g0G4qgA6LBjXf+vl
         hxVpt7OVCKRTwDVt4UyM41FX7nSOejp859C1YiSdJmo6Q8H2Uu8u7aHkF3+aL9VYybDx
         ymOLzQQBh7LMGLgOvwu2Jngf7PPksVn7c1kae/zp2ZESaGPaai3WRp0wz7ogIsNa0+yq
         BM29J3xiu8twZx+fnzFA2zUL5TgO6XLBq+sVxU/1JpjVLFKn2x3cS1DJJ5i5Xraa5KM9
         gxMsYFyCQ8VSLChrTD85tvWlwV99hLROVG1s/Eo/zR0QF2D3YlxXQmvHjwcCJ4PXjDsc
         mBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469688; x=1789074488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9qMk88WNjm6tym9wKNjhsNjwQfstK6W3opdEkr+jUE=;
        b=jzv9gHMQ6pVkj893oH2K0wBdmzceKFDDR1m2NxGNnnNS1dKm86G+ivMajzTR/GZ8hD
         ciL9OwGpWmTGXgcPJMkFMcziaftIa4hPbMyQHSQ1MZfgEzD5jLuyDkWeo/z2Rmp5IeZ9
         BwpyvQGSg19tf++cPXOIZeLJey5XHfV4WUl2I694A9HIIwRcVycdnBnBur/+LZn2G4d+
         2y18+QIl1XwP7PMaA15mXVF+n5ZP9XZqZVWDtaF92W0SAlNyvuUwkqfesFau/5D2WKt7
         EQGnUryXh+yIMNUXvQS/lkZhPOzuYVxfwV6vSB/K0uD4sdAlW8H5YroMzx84EM89Ybg7
         9IIw==
X-Forwarded-Encrypted: i=1; AKwUvBzZOBX21PnYoInwwy+rBwPQM+0rdORgPx6t4AeGNYGjE/qK4PGGEp+5dydU917O/JpeF4lapQc=@vger.kernel.org
X-Gm-Message-State: AFuF++nFdzFNi4KkV/NtisC/0ajv8nDxr9ZJR8GjHxLjTK+bTNGFyjCz
	VnP82K1unyk87B0zYfbzDaIcF4uS3p5IgKvq6eyU5FNMNspPtQJn486z
X-Gm-Gg: AYBFou3DrlwPLXiNx3163wl6CZ/4SFsTra4garAkVtHKC74xkWpoAKz9zfgavFOAImU
	EDmCUH1oNx3bO64ZhlRvnaWTHd+ShyKkiwbMda4wMaE9e9CPwgeHWF9gOYWz0AG/M9dYb86dqo5
	xi8vBrC54bHwkH663C77uJX/2K1qI2SAuP/YTTk+0fJhwD69mAomS/hAT7q6aUNTVMawVWoQ4Lq
	XHFEaTd0fuHW9bkfjYGOWe7JZoDFZvIz16hnoxg5rym/gXnQeUkJaiFz3QBdppl2bWvHGv/XfsJ
	qzKuPNZtAH22j3QlxN58/+sCwxHjDPlWGbbxdv4DBVINKwxTJOIjDGj/in5Ui+E19xD+YOg6yhQ
	gSpEye2JdB6K0vr8y1AgEsqswL4A1nU9aGDsZAGCQ00RNrZ9XWQSK9snzYgeg3MhQ8CFeyTXhgb
	FWURFBvAJA0Vs6AJH9Ej+lQxCejeY5hq2wKCw+xwhQQrcUx38vb1BHhHwC+oLwxyo18hiqLxvMc
	hGQxJ0u08a+IrSS0B40IMAhSVEg9kaFKNI=
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr2193919a91.16.1788469687526;
        Thu, 03 Sep 2026 14:08:07 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.226.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39227sm7023324a91.9.2026.09.03.14.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:08:07 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH v2] Input: tca8418_keypad -  Add devm cleanup to disable interrupts on unload
Date: Fri,  4 Sep 2026 05:06:39 +0800
Message-Id: <20260903210639.22472-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903192942.21906-1-liangzhan5dev@gmail.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tca8418_configure() enables TCA8418 interrupts by writing the CFG
register.  If input_register_device() fails afterwards, probe returns
an error and devres releases the IRQ handler, but the hardware is
left with interrupts still enabled.

Fix it by registering a devm action that clears the CFG register
 when the device is released, disabling
all interrupts on both probe failure and driver unbind.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>

---
Changes in v2:
- Fixed typo: tca84818_write_byte -> tca8418_write_byte
- Fixed typo: tca8418_diable_hw -> tca8418_disable_hw
---
 drivers/input/keyboard/tca8418_keypad.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 36d4a7c38bb1..413b404a08ba 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -270,6 +270,20 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
 	return error;
 }
 
+static void tca8418_disable_hw(void *data)
+{
+	struct tca8418_keypad *keypad_data = data;
+	int error;
+
+	error = tca8418_write_byte(keypad_data, REG_CFG, 0);
+	if (error)
+		dev_warn(&keypad_data->client->dev, "unable to disable interrupts: %d\n", error);
+
+	error = tca8418_write_byte(keypad_data, REG_INT_STAT, 0xff);
+	if (error)
+		dev_warn(&keypad_data->client->dev, "unable to clear interrupt status: %d\n", error);
+}
+
 static int tca8418_keypad_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -356,6 +370,10 @@ static int tca8418_keypad_probe(struct i2c_client *client)
 	if (error < 0)
 		return error;
 
+	error = devm_add_action_or_reset(dev, tca8418_disable_hw, keypad_data);
+	if (error)
+		return error;
+
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
-- 
2.34.1

