Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156390;
	b=DoDoqAisUgltJSxvsQFHyrAN9qGJpt5nPDNQYOo9lX+Gq/C6GVA9af3AaftqmWxwXRRJ
	 Sem9ikDPjLWaTd5+0VhItW3lr/co2NPMNf4PSH1aUwUfr2ifl3J2DHWqap8Vob7+rdXpa
	 I4rg7aF5THS2QPzlnCQ2y26djjgTT3+vbREygJI2n6wm2rP+zwh5J0PcSDW08a3FUAV1u
	 QzQrSZgF4E5h/4MWD+qY5L1mzRC9FxYNNhpkB1XJCsxE2CATlnpoZHCwZ2Mlh9+xblHZ4
	 HJOVb3AAKGbHNBxLCq8UdEd/NZ6gdX1X0AtWtI4ESVtfXJYGqqfriH8Mpwk8XwjJ5LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zmhLt1fcIW49TsxftipVDOrL5MaEf1i51ozTS3vuQE0=;
	b=ZOmQfaNhZbj614L5ScL/FtXWNYdbowuvZUR65ki9Gy2eOSqWh2JzuqEPXgGqkP9KfxC6
	 B9fDEHnWA9DO6a2cIp2RP0QQKU+7AEfa6ueVl+E8imj82QgcGyaEt8SZDAhIeNglvFWu7
	 pQlJCAgBXg7BKyCmNAmaCa3HCD8ZbA4IyAElxU/dXbbRpLeiUQM/wU6rnFSelo6fRZ3e9
	 bUaJ+LC+Oz08uGY13MvzWwplBYIMUjG+LW3OR6R7aShHlUejd5ydgIFGcPZT9Z1bQlXyT
	 4WqqIIOgjgoXKGbpmmSAXF6Vczpv2L9qbBKPnCtUpThieAXz/0BXquS8+QaX7KVIOpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiXxZ5B2;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBA606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCBA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiXxZ5B2
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso900581eec.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156390; x=1793761190; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zmhLt1fcIW49TsxftipVDOrL5MaEf1i51ozTS3vuQE0=;
        b=tiXxZ5B23CrDdxwaxzsxnGEx/Tmy+ieUOR5s3xjD47whazeW89JHVTusEC3WEyH3sH
         sDVk/oaCL0wMEI25vEUyDqxLEGKyk2I+ox1vbPuaiMB6FEGn4xWsfPEfGrtIFkH4AJl1
         4DQrTs7V83Z9e+MtmJQGvhT5q5OpIoQTwhoAyqeOx+HDaixt5Cmr+3oLxYm06nVeVh6D
         x6MnAVJ9wJdA6pfjTd2ixEaxL40VpD04BiUPh9KynHYksDjwcia6elBYNQPLous61f4r
         kKISIi/84w/YC6qThME4mO6oKSbkMRzjkcGDbma0TSbjB9VNaWZVPciibd7ffMXdNS6y
         YWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156390; x=1793761190;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zmhLt1fcIW49TsxftipVDOrL5MaEf1i51ozTS3vuQE0=;
        b=gwmaNqTni3lSC1KGw2cusRdIr3EcTvRcINh0UsBAx2ojNAbwZ8vKO013UI6cSpRmaZ
         TKDvwqTEIGenKMg0O/Z0+lTbs/YyTBViqpmkCY+MTKHb/wyxxcvnWfKgVA1cG627Dp6k
         1BGF05rifriAACRdUKRd5UdkI34tCUg1tLKBK6EvRbr2gYBjDkOfmHKbF9C3BETeEEap
         5BxsAktHcaPmjKz1exvc1BYDgA1c/b/WncpBZlQj2gOSoDpEKy0liVdwVsK6keehjFyv
         Yna4fmL25Xt5ZML4/k/iO8bE84f1+7LbqXmAD9JtMpQ+rLiyILsmRsVk6Gv8Nd4jal9T
         A49g==
X-Forwarded-Encrypted: i=1; AKwUvBxxYhTS3QGFvZO1U2XoQ1Mgkex0cWModVc8e4la+HGhoTzfPXSrNzkwpBdto6TnOOsQFNOlL8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhgB5M2U6/MDNw2aQyn5aGNJZB6DlOz8c9tQZZb2I4GXBH9oXO
	w39l9dWqoLYGNdhq0HLA6NiBSbMsGhxKMrV37pWSPXQvYYl8afKCH/JJ
X-Gm-Gg: AYBFou2ixPVtyO6didHcLoNhmoMJ5jEKteiBzKC+bo/w3H0ek4J7Q291lMH38zPDIaQ
	sKF4kGoUr8K8KW123Ng4U+EFTXAo7tKK0UguvYY/AhywgAihf9ThiT6xWxbDzXAHE0jbaVPKy9J
	+EphpZTqTUq7Lez4jwK6cDK+FvT11H3vAd6Tv4VuAzt8jITm9pZEbXUEBoj4mxedbWMWR3kW/mv
	G07dW1d877Zj2cTnyX4cvVXpnQ96jWgsNwx22bp8Ofs3R/Oxap/I/QuvqQmkAU7RdbDx5TKOxbn
	K6ULKp6c0wNe0Ka5pXpHt/ndlsrprLkyh9UHFnJvb6taHKQ4VV/wB02mKJTk9tJAYNHOXMuiQdy
	UiltYkRQhrZhTqaU/d0QEJRxTMOsywx//xIEaweBlQxIlmc2yTr1vGZb9SWmkaVVGNHzcPCalKM
	kxRseKIv4vECFafsr2CAv/M4ihOi35pwG57KxGRzEITbw3JX4kPa30xDIZYI+2X5SikbqhdNRBw
	d2BDwbsczFom0Gacozg2WvdBd3AHC6UL2YRiiPWmIq9yDtOx8GHoA+XFEtOjMOrMZpGyjwgGN2g
	4l9PzR+RCZNaAFnZdf7ee/GNiYo=
X-Received: by 2002:a05:7300:c88:b0:369:eec1:1d7e with SMTP id 5a478bee46e88-36a2011245fmr2678360eec.11.1793156389380;
        Tue, 27 Oct 2026 19:59:49 -0700 (PDT)
Received: from [127.0.1.1] ([2406:da16:4ab:8700:3d3b:2065:9087:3429])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bddb7sm1377850eec.3.2026.10.27.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:59:49 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
Date: Wed, 28 Oct 2026 10:59:26 +0800
Subject: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered buffer
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA1l4WoC/yXMSwqEMBBF0a1IjS1IgvjprYiDREuthqikogji3
 ju2wwPv3QuEApPAJ7sg0MHC65Kg8wz62S4TIQ/JYJQptTI1Os+mUjjyiZE9SbR+w6K2uilc2Qx
 OQ7pugdLgn22717K7L/XxacF9/wCHtErLeAAAAA==
X-Change-ID: 20261028-bmi270-fix-timestamp-48a194b69db1
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Liu Yufei <lyf98405@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793156377; l=2048;
 i=lyf98405@gmail.com; s=20261028; h=from:subject:message-id;
 bh=A/1srCpfd1UGOdpJgwH+wipqcVfWHT5hKzmppz1xS28=;
 b=zes8qii00NcuE45PPu4stJ4xIYMjnHPkeaU4SW86Z6Tts6kgcxp+jNZYZKP+DQD8HFWvEzC4v
 ZVUz4JILlhbAuqBUFmVzhyVSvWcFzX6BPQDuPVG3/de4T6fhpBDmLe2
X-Developer-Key: i=lyf98405@gmail.com; a=ed25519;
 pk=lc+pS6pGKgsSIrWd9Plh5gs4dnZRQT6qkyv+hvAy7hs=

When the device's own data ready trigger is used, the trigger is
polled with iio_trigger_poll_nested() from the threaded IRQ handler.
In that path the pollfunc top half, iio_pollfunc_store_time(), is
never run, so pf->timestamp is left at zero and every sample pushed
to the buffer carries a zero timestamp.

Take the timestamp in the trigger handler itself and drop the top
half, so that a valid timestamp is provided for all triggers.

Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interrupt trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index fbcf6bb87acc..40ed1ee5ac58 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -840,6 +840,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi270_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
 	guard(mutex)(&data->mutex);
@@ -852,7 +853,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+					   timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
@@ -1630,8 +1631,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bmi270_trigger_handler, NULL);
 	if (ret)
 		return ret;

---
base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
change-id: 20261028-bmi270-fix-timestamp-48a194b69db1

Best regards,
--  
Liu Yufei <lyf98405@gmail.com>

