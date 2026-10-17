Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED03B38B8
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214386; cv=none; b=h+vZ0mj02nJfV5yg1T+ZT7BThQw7qv24BVWGxpPeDxCcGmQJrlZp+xBqF5MelVMIkaO+uxZHU/CtarT3xMWhlEH5AhBtkhqPobGqJm23xBlWCUYaTPfMj5ky3jANA2rFXDcXZBawRxt77rMqTIp9VoB8QuwenMd7sqbZSrhcs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214386; c=relaxed/simple;
	bh=gXw+7TLfwGKFNKp/KJZijwrd5UKSHlNDKFQXo0yS+uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1bvI0gCApoQ8A18tu9Eg6lX8yNz8TBCQNFnN0J5NnDIdewAEL9R1+ZQvzX/9dpVtLwFZ+z9gycOkuNwElobqUv2hPiNPBSEmk0UsK+CIyjV7DeUaq8i9oO8vKXlZojO1XiUve3L7P7seHXwOFCk3g6YgWLTDNZIuDeX/YOjV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX9WQObf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX9WQObf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso4173635e9.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214383; x=1792819183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LHcXjNkmsuk5TeKHntdBtjC9h0fmxosoVJ6Kahrwto=;
        b=FX9WQObfhOmxAA2cvIjLLoUklxaCKX/HIYaincyp8wlWq/t0jXptO+s8CFJxOAu5yD
         SpgjwF+G/isbSOTi+RO/Trzyn/rWbP4HBx6CektOst/cdt/NE8GaB3nV24MWH6GOy2Bt
         +FXRFjcBEt3Pbl2QtD8bUAfhGUSv3UQuMLYttYWrftfELF+CBCgagOJdCzoaQ9GdHX/U
         kSJNuT2xg8iQnd2fMYeLpIC0RVCtrSjlnptUD2QXw3dfl205VRszu9kAtZIcPhyw0yNT
         8aV+U4H94kFxfdCSUyUamCZOFOko8ZsCz0WRVbcJIpwL7etzU5q3RP7kkqhkndsv4qBz
         CgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214383; x=1792819183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LHcXjNkmsuk5TeKHntdBtjC9h0fmxosoVJ6Kahrwto=;
        b=iWCPpbHR6zITWV7rarLx1EpylR7xhOzPLuFXSvNX22/nAxSRpmbhlNiS4O/lckHxf+
         HBKTovt3vXfrL+eBQUZAX5kSs9KOcgY2zs3H3hZKAJa+5tGiQuLd1552C8UoHC6A+b5V
         LOygxHfDIeI9RQI78bg6lp4g2v/ITqr3HPiRK5/KizmQEZQFlw9pSFFpSHzQ+dnftBI5
         BE+vKdfQBOlo994s7JvbGK/TA73f3i7rd8weZOG+CK1wXbfzV2Vl2dL+v8XIl6PwViny
         btTktM97/zsOQPA1XMsIgzu2n+nwJY2BwjLtWmLxeaHhYf5jGQDnMbGIR707Drth7ysw
         gCag==
X-Forwarded-Encrypted: i=1; AKwUvBzeJc70T7MZVJvEk1c6CeV1+9uilIDi3m+lUhA8SW2QNbTInl9dwc8MNBRRIoXrp8fa10LeVgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnvg1zw7MMFTqzENe4mnjyVAxW2UGKbeqBcfiv+85BMPUbSjh/
	GSMqzgCClj7040ujOp51DMCIUx8pwUesK+7GkDGOir5Mp4/cQ8aTbPr0
X-Gm-Gg: AYBFou3O+xv/T2lZzYiKCteDylSwngAqSWIrC9/yG4M8bgU0sn6Fucgx90yEXaL5fDO
	6ofIamfQR7/METb42nPaTJsfRsz0iz8QASjKmufi6cjvqR8xmjn33s2+iGc3pu53rQJT8rPJy3e
	FSGDAPlmvspgUyaT4Lrhn6NFqpvNFc4c1CCPykErQbTfME/KMw930DpytBgCwjiYLHOiSjEUfN1
	4ftTyVMZiSgNapE4nrRMyI9vAO06eWZFo5mq6XY8B2WdWlVuBpricCUOxK1oivhoGpQQitfoNzL
	pM9X/IJph9x4kyz1FnZtVBG0lyNXJcevVGhe65XwOQbztYlCoSiJPO4RMzoFkZKDQhJfZjXVKb7
	6DEfUjQeggkbVKFV5t5gBL1YhgchVpSAy/W/d8YZwwZx6pkkxRNABNcrJNmNyHemeLR4kKty+7D
	RPOlnthG2Wi+J8VxZwwqjrO2j2iU+haRr3jSW4MItipwbE2KrGIHuRbH14Z/cb1E181z60TQr8u
	MmPRRByLIqi36rMQk2/hAAiRrIPAY1SRoDzCFlrF8JeaGEF4GxgDJH/dcDN9W72ivLSmYX31i0a
	T4ssblQsYI+CJ0kNgTXXsTlRLEj1hiOGeKZgAM927koUdoWPuO8q5kf7KmHMmJk87C7CF2cjXDV
	BNmOa6Qh+Fven1R4Uq4/yHhcEaCehThcMQuabFWhGcuAlmiPNCTFhunGf4cexyNarF5LTgGAg
X-Received: by 2002:a05:600c:4e50:b0:4a1:76c9:5408 with SMTP id 5b1f17b1804b1-4a1d7600190mr43042945e9.11.1792214383002;
        Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
Received: from [10.200.7.52] (109-81-110-105.rct.o2.cz. [109.81.110.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm16432585e9.2.2026.10.16.22.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:19:42 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 17 Oct 2026 07:19:20 +0200
Subject: [PATCH v3 1/2] iio: gyro: mpu3050: fail probe() on trigger
 registration failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261017-mpu3050-fix-v3-1-d6f29f335a2b@gmail.com>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
In-Reply-To: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792214381; l=1394;
 i=joshua.crofts1@gmail.com; s=20261015; h=from:subject:message-id;
 bh=gXw+7TLfwGKFNKp/KJZijwrd5UKSHlNDKFQXo0yS+uM=;
 b=mHpAFkWrfA2yHnFAXyecRF0dHDXXg+N36a08VbYhPaR87pLuFUd+4j7PO9AkSaIrj6R/h/CJR
 6dxR+T2totYAKjlGrKSnwj7gvYY0lmuQosTz6vmzPr+n0wT0ZBdEO0O
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The current implementation lets mpu3050_common_probe() continue on trigger
registration failure, causing the device to operate in an odd polling mode
and making resource management harder.

Jump to the error handling logic if the trigger failed to register.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011c63..879caf3b729c 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1231,8 +1231,10 @@ int mpu3050_common_probe(struct device *dev,
 	/* Check if we have an assigned IRQ to use as trigger */
 	if (irq) {
 		ret = mpu3050_trigger_probe(indio_dev, irq);
-		if (ret)
+		if (ret) {
 			dev_err(dev, "failed to register trigger\n");
+			goto err_cleanup_buffer;
+		}
 	}
 
 	/* Enable runtime PM */
@@ -1262,6 +1264,7 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_disable(dev);
 	if (irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
+err_cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
 	mpu3050_power_down(mpu3050);

-- 
2.56.0

