Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511445;
	b=zSzzlJbJmiWsLMjk/yk0c5oZo8KOWc59+uW7sWYSBp4DeKOlDD0USxTZQKrSQ4HOC6Rd
	 ZnaidZBAgK6NkAtP6oaCslUY9wA5eYED2yxut3Lk/1JQTdIgikCMeasuVXQrkiNohmyqH
	 NpPRX0Gvk/tHwfN9yD6VbMTiVu1DDvBcLMfci2s/GI6o8dXwTnYMCTA//Djhkrjq3E2yl
	 +dFXyw24JfnEIl9CzfUmf75yJfqWpV92kCwxO7oaQ9SFXWIDVBiS+ZAUZJYIojimIMMID
	 e1gKSLx2Ox/AwJ7zOWKfQf4KuMDpohluM2aK0oemH3lUY+6I952T8mB//es/rMDqXuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yUsPMfI898FWLLgta0g0lTJQqLkwN13wBnF+5PDzMVY=;
	b=YYUf3mfP8UEaqPIUxBNoA0KnzpsdIE/t+jVqX1FjHbjTKHameUX2Zn0svHPjUO3tAOUI
	 trIjMwuPQsOyY+Q9sV/5FlOXvfSAHkxd8mxI9ioJAxQ0btigA6yMF9gSogB95LJZ3qy50
	 r5l7vi7qUSyew7/pFhmOXqOugfs8fM3MzI6NM/Xzm7ulgHtH62tiSzKG5cCNQZ04eRezy
	 DA2c0SnYVLqBngDn1fNyk+5i9AYx4AsSei86Wfib/tP23dd+hAK8kkHVG5Or5+POOx/tP
	 3gQmVIlW6vbpkErIuJQ49SWUdDryx3LPOmZ7oQhyFOXwr/BEN2iUOrYoEkMKFxXdr1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVLFixiL;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5901606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5901606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVLFixiL
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so1749309a91.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795511444; x=1796116244; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yUsPMfI898FWLLgta0g0lTJQqLkwN13wBnF+5PDzMVY=;
        b=CVLFixiLDyElBqWh9sFUDLHVDzjWEiOXbLSrnWLShHiUzEKxDPKzk7Il8UbYRSZBZ6
         g+WxrRdk0i6SVW9W7/Oeob8WkNmxuyV5IdmcMWY9z/lWVcklBdZk14JRQmnp+vrUgQsm
         NrWoIA+ZKKTYW6m/74dbxlnoz/d2+AtnCe/aJ6ayDogxcCzo+rg7yVNgvbsml+Ghc2xH
         IYhkhetwSyU3v9vFMWHCgx0m1skFSbKBhvn54s1MpJ8xBCFtXgn0FlIMPvzNFQzBah2D
         E8TjtMf7v8juUxRex6HsqgpTqmud7i1z9eiXVohk08v7F/5n1ksWWESE6InXFu0N6glA
         T1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511444; x=1796116244;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yUsPMfI898FWLLgta0g0lTJQqLkwN13wBnF+5PDzMVY=;
        b=fA6s2HUqSMvlF+wRq1WVZWVcU/K4Ljlzmi6DvN6XtQYEFxOhTTTsxY42F/2Iwcox9e
         jCnMIuSNSl2Axb6iZNiKjgrrUNk1WBnFnd+kFW+jJ3/2DBlj25MwJHEzbc7XpMhCxQZv
         rSUXgUd3JZ4lf3Hy13OtPaSdl3OJX3sYGSSlbxiUVc19T/IC74V4c26ePvRaKoCoR1ZM
         mslWN1IwyeiW0xT0iW/tiiKbxCpK3ysSTTOrn0Mh1NEqgTmEZlFFvv6bbelWI6KJIO4Q
         XGHR0m8AW/k9Gq9pviGpzQWLjHz0cgaXTB/F7t9JBq3LZ4p7ziw1Tsj6mpMoHP3jPQOc
         4iHg==
X-Forwarded-Encrypted: i=1; AL+hErEcfvWVrw/N5RNURclH1qcm2EsYO47IA2oaExo1lDM1bArbXzkscvoyxdybf9iJ2Fbn2KnRF50=@vger.kernel.org
X-Gm-Message-State: APuU4Z//kE+0lSg4mQfA6tsJXVYvkLTPwGiDte+GZXMirwsBbWEUZSfr
	RkFYEmPF7DQ35J2rJ2Pudv7kjojdPodi3fZ4tWvN02NmBJLZjjKIYG8a
X-Gm-Gg: AZFdTZfnubk82ADJYIbJ+lCfSsRpTD7rnMdw0ftCFGYJ26pdBxZa4oE6Jdz9kdzrMvd
	eB/7L777LHpix+8DRzhS8cFuR9Oeo8MNErLi5ik87ILWN0XGz4W0xQFOr9Qf3x3aCMIxwsQkZEx
	aBzE9+0yjB8k5TxwP1t2ac3Iv2NnIpqqLGhHvDLwrmSpU4GCUmVcEV34f7Dp+AlEcmtIZoyBV0G
	gVzU+Zi69gcdITZowDKxWM8bgkHynN+kE6gQp3mZIw/EBaUJ6+K0SoDiVT2m83xS090hAULdo0f
	Y3OanH+Ei4EBWSOlZmZqI4zgZK7sDgYzRRZd4fIKI//Bj1eVQmfL1HGrXxlCTfMtAMoTUggeE0E
	avoXV8ZB0wddSqhxjEzRt9KRHnI3D/uuKKBhqy5tpkbkK8tiI7LcDqOs8FSzXN2/lvwsqNOBpxv
	N9uL/jhF66GFYp+qGEsdNQo/1RCyO04gqD7HmVr5nLUIZ6cTeJiH9toZKzsOuLwbEjj//KCwc27
	9SCc+XcbjKTOaZGztGD3T/lQvdoTOcnF+bcMg6ZhtqMncVLGbXvy98yLmSV/drigxPY0gkrihJ8
	bdCVBbaerqWPWF4STK2q/ga5JAnGnpGk8yEKflpdVC9mAfV5zjdJ9YJGo+Qy
X-Received: by 2002:a17:90b:2516:b0:3b4:c9f8:abce with SMTP id 98e67ed59e1d1-3b4c9f8abe0mr1746956a91.35.1795511444107;
        Tue, 24 Nov 2026 01:10:44 -0800 (PST)
Received: from [127.0.1.1] ([112.6.227.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm8446914a91.0.2026.11.24.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:10:43 -0800 (PST)
From: Liu Yufei <lyf98405@gmail.com>
Date: Tue, 24 Nov 2026 17:10:07 +0800
Subject: [PATCH v3] iio: imu: bmi270: fix zero timestamp in triggered
 buffer
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
Message-Id: <20261124-bmi270-fix-timestamp-v3-1-6356a5467d5a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG5UBWsC/4WNyw7CIBQFf6VhLQawL1z5H8YF0Nv2GmkbqETT9
 N+FutCNcTnJnDkL8eAQPDlmC3EQ0OM4RDjsMmJ6NXRAsYlMBBMlZ6Km2qKoGG3xQWe04GdlJ5r
 Xistcl7LRnMTp5CAKW/Z8ebO/6yuYObWS0aOfR/fcfgNP3p+LwCmnUhoGRQtVw8ypswpvezNak
 i6C+EQ4K39ERIzUShR5BVxIpr8j67q+ALCBcrAPAQAA
X-Change-ID: 20261028-bmi270-fix-timestamp-48a194b69db1
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>, 
 stable@vger.kernel.org, Liu Yufei <lyf98405@gmail.com>
X-Mailer: b4 0.16.0

The BMI270's own trigger uses iio_trigger_poll_nested() from
the threaded IRQ handler, bypassing the pollfunc top half.
This leaves the buffer timestamp at zero or a stale value.

Capture the timestamp in the hard IRQ handler and use it when
the selected trigger is the BMI270's own trigger. For an
external trigger, take the timestamp in the threaded buffer
handler before reading the sensor. Drop the pollfunc top half
now that the buffer handler always supplies the timestamp.

On an Orange Pi Zero 2W, the original driver produced 256 zero
timestamps in 256 samples with the BMI270's own trigger.

Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interrupt trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
Changes in v3:
- Timestamp all external triggers in the threaded buffer handler.
- Drop the unused pollfunc top half and the timestamp resets.
- Match the selected trigger against the BMI270 trigger directly.
  Codex identified the shared-trigger case during review.
- Link to v2: https://patch.msgid.link/20261106-bmi270-fix-timestamp-v2-1-8a2547e1290b@gmail.com

Changes in v2:
- Capture the timestamp in the hard IRQ handler.
- Use the IRQ timestamp for the device's own trigger.
- Fall back to the current time when no pollfunc timestamp exists.
- Clear the pollfunc timestamp after processing.
- Link to v1: https://patch.msgid.link/20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com
---
 drivers/iio/imu/bmi270/bmi270_core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index fbcf6bb87acc..6983d80efee1 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -157,6 +157,7 @@ struct bmi270_data {
 	const struct bmi270_chip_info *chip_info;
 	enum bmi270_irq_pin irq_pin;
 	struct iio_trigger *trig;
+	s64 irq_timestamp;
 	 /* Protect device's private data from concurrent access */
 	struct mutex mutex;
 	bool steps_enabled;
@@ -755,6 +756,16 @@ static int bmi270_get_odr(struct bmi270_data *data, int chan_type, int *odr,
 	return -EINVAL;
 }
 
+static irqreturn_t bmi270_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bmi270_data *data = iio_priv(indio_dev);
+
+	data->irq_timestamp = iio_get_time_ns(indio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -840,8 +851,14 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi270_data *data = iio_priv(indio_dev);
+	s64 timestamp;
 	int ret;
 
+	if (indio_dev->trig == data->trig)
+		timestamp = data->irq_timestamp;
+	else
+		timestamp = iio_get_time_ns(indio_dev);
+
 	guard(mutex)(&data->mutex);
 
 	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
@@ -852,7 +869,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+					   timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
@@ -1430,7 +1447,7 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
 	data->trig->ops = &bmi270_trigger_ops;
 	iio_trigger_set_drvdata(data->trig, data);
 
-	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+	ret = devm_request_threaded_irq(data->dev, irq, bmi270_irq_handler,
 					bmi270_irq_thread_handler,
 					IRQF_ONESHOT, "bmi270-int", indio_dev);
 	if (ret)
@@ -1630,8 +1647,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
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

