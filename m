Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933674;
	b=fImXawWa48SDRk3pj4r1ff1+JEVTKmXuAEpTXIzMo9bEUn22qg8i2+b9JV5pz7yW9CdT
	 BhPbP/FANHD2mqOkmi58919S5JLbpUN0/B+r3HGLMpmdQiwy7y0YrI7XJCYt4Wjj/zBoW
	 W49wfK3BpFogS69P9wRWTWuImFy2oBKGvig49K2CVAp9CnpZagn6JN25J40R3kooFUIXe
	 ASpWmFhZdIdQebLxrqbGIzv7quFJTzgbH4nWXUF3yb/j+J+z2+LxiRSsGvZB66JQQ82MW
	 KfL0b25lBRmnXVpkO8fyCv7BEQYBul5qEbRr5zirInt+moijeGrHutcNMeH4TjDzyXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=90tqLU86x8uPgNkZ3M8c35wZTssp+3W/NAEXjTs3QHI=;
	b=a9zh4lgqVJCXcWqysdE1ASoowF4pMoFX5jvnLMgdIW4tgPGtE1ZcduhicyLDZH30lggG
	 5GCIxhYSRepZIecwlNS+frhDn6lZfgF13K6cQDFCpqp6aSZ3OWTZRnbyHadWOPLbHJEwc
	 MuFEfxMCCgcQXAP2a6nNsWn6cqpOGpaV/ZLsq+HdvEa1VTj4eFAJs3n0AqTjRPl15anU1
	 9+HxUWE2oox0MbtIwSo6zfGy8U1oKDBIjcO+/OjDiMgpyf9wiGYhYhd/6Clt5/JEMafED
	 aA6+Dzw4MHBoO6XFX0hW4NLbILQNE29pCaXQgynQ63Yv44Gtiyj6KOfsnedR7kENsUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9VzhQsn;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C84606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C84606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9VzhQsn
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso95231a12.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793933673; x=1794538473; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=90tqLU86x8uPgNkZ3M8c35wZTssp+3W/NAEXjTs3QHI=;
        b=J9VzhQsnOv6RIbhU77HDWuMUwIFM6fngkdIBg0eHbc32Ey8nLNaaHLFVeLmGpBfJ+I
         qHPyGW1GaMmXOhiB90h1UQ24qPEX+thrKf/2sYjBq/0783aXZKnFtNovs9Wkz0OkBxVf
         IQ3H7dinIosNHpYr+NFa2ZtfIS0JWsFRPE5SY49SmXDaTQ1rF93zKnruiYDGo4J6jI6Y
         4B7UFXlejivGFFqJfrGXRSatfkJCBsv/EL4+126VfKs758G6QKm/zhyph3+Dy9HvAsnK
         dB4kTbbqOFyVwm4MlG6kZ9Ob1Tqt0td0bSSb6xYIxs+Ko9XpULbrPRw5m1zvaPaQuW0l
         p31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793933673; x=1794538473;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=90tqLU86x8uPgNkZ3M8c35wZTssp+3W/NAEXjTs3QHI=;
        b=aNRvE/E5DO+KpNg84YaXkekOKq/Q/fLoysQfiBFo0oppNEoNaehaHDbDiRYzQvAmxC
         X0cFIuzE72ElBjFFPpppbz7A9Kli/I7E+9oApEzykszde7Orp0l9SIWYFOSgOrV4dKXg
         3gTnPCKV3QESAV7BGXAR+yieN2u9F4JAFqh/QQ5kr+ddkgogMm5FepQKiJHZXVX+1gDA
         j6niAJRUewbTRg/xpz6pc461rtSuTTvhOfKYopjh0VbhAigyvkNUiqu/1FDoCSvaCfnK
         PCKvyJgKj14hCGFZYu5jm8Qa446dmVGQ5YfrUtN7b5glUwrkNClDvAz8aDa/GBNngf9w
         RxVQ==
X-Gm-Message-State: APuU4Z9BE3HZHVsixpVlrFuesVu2QfsGzpVZJ1P11b/8LHRJDXEtkfIJ
	B2x/ygdLe7G613JqNkr5VU2YD1g58waS+ck2OxBjhdq12RlgR8w4LCcr
X-Gm-Gg: AYBFou027Ub5oM81/ryUn82POJtoHaapd13iNPfkIdrlXDA2bgnMp/eE+NFb/FttdZI
	P/x646dI9Ovr4YLcM2hmKcew/0YDA7stvY1C3x3j3CZXIi49fEvsTw3/gfjL5oXjuykzzkP9x8X
	kksiuNF5UgVMexg13EBQxcdF1dJG4+ij5yJUJSN4VjBXhsHCkqDC7JtpF2CupYaE77BtditgZZx
	BZegNIy2gzgLN0uHUVZaqylziqbTFQJS3Sjb0iRtkbi6YjfszERcKrJldvbYjqeOseR9LFbuC4J
	9GG9aQwSsSLx5nHmGG/rAq5J2H1AuCvrz5rj9uB04wbsdtN7GyoQV/JLLJVLGDpJfT1QWaQ7uYy
	mR/PEu3Vqa757FB/6sLyQaxrzDkXEEsOU6hXDSGsA0W8hAgCKg6QppM2YiEh4G6kmJJZwu8Zd+i
	fMKjNxBM/TCQlj/+H1uegMQK0yV38TFXxE0pHZKOoDl/QJ/QLip7bEjEjrPL43cwp4FlfWooWvs
	rojdTkZBpN6flVGpMZbproCOk2ds53QnsY3vMkdDm9bvT8MAI2Ig2cPcYORnxX6L+7VxV0p2XSE
	uJQp4/MMWUNt
X-Received: by 2002:a17:90b:33cc:b0:3b0:9deb:d991 with SMTP id 98e67ed59e1d1-3b0db6d37famr1028274a91.35.1793933672424;
        Thu, 05 Nov 2026 18:54:32 -0800 (PST)
Received: from [127.0.1.1] ([2001:da8:7003:1001::9afd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d78b0a7fsm1416397a91.1.2026.11.05.18.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 18:54:31 -0800 (PST)
From: Liu Yufei <lyf98405@gmail.com>
Date: Fri, 06 Nov 2026 10:54:17 +0800
Subject: [PATCH v2] iio: imu: bmi270: fix zero timestamp in triggered
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-bmi270-fix-timestamp-v2-1-8a2547e1290b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFhB7WoC/4WNQQ6CMBBFr0K6dkzbIFBX3sOwaMsAYywlbSUaw
 t0teACXL3n//ZVFDISRXYuVBVwokp8yyFPB7KinAYG6zExyWQkuGzCOZM2hpzckchiTdjOUjRa
 qNJXqjGB5OgfMwpG9tz+OL/NAm/bWbowUkw+f43cRu/fnYhEgQCnL8dJj3XF7G5ym59l6x9pt2
 75Yl/4NygAAAA==
X-Change-ID: 20261028-bmi270-fix-timestamp-48a194b69db1
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Liu Yufei <lyf98405@gmail.com>, 
 Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793933668; l=5058;
 i=lyf98405@gmail.com; s=20261028; h=from:subject:message-id;
 bh=jKRzDzpw4unjTIDJEUmBiUJee47b0ww/w747ltWj1ug=;
 b=vU8F4NoJGveNnTpsgvPgAY3okd+wJQfBbRsotuhKuNbAdT0aRziVqdC9oEW4PpJTwNB0Ys1LC
 eXofg+RFUydBTWGN5FeoBzTFbbKPVG6epDOJipo4YAs1dEpb/ld0MAH
X-Developer-Key: i=lyf98405@gmail.com; a=ed25519;
 pk=lc+pS6pGKgsSIrWd9Plh5gs4dnZRQT6qkyv+hvAy7hs=

The BMI270's own trigger uses iio_trigger_poll_nested() from
the threaded IRQ handler, bypassing the pollfunc top half.
This leaves the buffer timestamp at zero or a stale value.

Capture the timestamp in the hard IRQ handler for the device's
own trigger. Preserve the pollfunc timestamp for ordinary
external triggers, and use the current IIO clock when a nested
external trigger has no timestamp. Clear the pollfunc timestamp
after processing.

Testing on Orange Pi Zero 2W reproduced 256 zero timestamps
with the original own trigger and 256 repeated stale timestamps
after switching from an ordinary to a nested external trigger.
With v2, 1280 samples across the tested trigger and restart
paths had no zero or non-increasing timestamps.

Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interrupt trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
Fix invalid BMI270 IIO buffer timestamps when the device's own
trigger uses iio_trigger_poll_nested(). This bypasses the
pollfunc top half, so its timestamp can remain zero or retain
an old value.

Capture the timestamp in the hard IRQ handler for the device's
own trigger. Keep pollfunc timestamps for ordinary external
triggers, and use the current IIO clock when a nested external
trigger has no timestamp. Clear the pollfunc timestamp after use.

Tested on Orange Pi Zero 2W (arm64, Linux 7.3.0), with a
physical BMI270 connected over I2C, using INT1 at 100 Hz.
The baseline produced 256/256 zero timestamps using its own
trigger, and 256/256 stale timestamps after switching an
external trigger from ordinary to nested polling.

With v2, 1,280 samples across own hardware triggering,
ordinary and nested external triggering, and stop/restart
tests had no zero, repeated, or decreasing timestamps.
External triggers were generated by a temporary test module;
sensor data was read from the physical BMI270.
---
Changes in v2:
- Capture the timestamp in the hard IRQ handler.
- Use the IRQ timestamp for the device's own trigger.
- Fall back to the current time when no pollfunc timestamp exists.
- Clear the pollfunc timestamp after processing.
- Link to v1: https://patch.msgid.link/20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com

To: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/imu/bmi270/bmi270_core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index fbcf6bb87acc..6b11e91eabff 100644
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
@@ -842,6 +853,13 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct bmi270_data *data = iio_priv(indio_dev);
 	int ret;
 
+	if (iio_trigger_using_own(indio_dev)) {
+		pf->timestamp = data->irq_timestamp;
+		data->irq_timestamp = 0;
+	} else if (!pf->timestamp) {
+		pf->timestamp = iio_get_time_ns(indio_dev);
+	}
+
 	guard(mutex)(&data->mutex);
 
 	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
@@ -854,6 +872,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   pf->timestamp);
 done:
+	pf->timestamp = 0;
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
@@ -1430,7 +1449,7 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
 	data->trig->ops = &bmi270_trigger_ops;
 	iio_trigger_set_drvdata(data->trig, data);
 
-	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+	ret = devm_request_threaded_irq(data->dev, irq, bmi270_irq_handler,
 					bmi270_irq_thread_handler,
 					IRQF_ONESHOT, "bmi270-int", indio_dev);
 	if (ret)

---
base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
change-id: 20261028-bmi270-fix-timestamp-48a194b69db1

Best regards,
--  
Liu Yufei <lyf98405@gmail.com>

