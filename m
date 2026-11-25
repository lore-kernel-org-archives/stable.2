Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619654;
	b=PhCnCuG5gDLV9enWMAfyVuVbzeqKAnGT6loXuKwhIWdMVJiaioe5A5wnj7d7iTNLvqF7
	 5n9lnLXAtGL9jDaZ/cptLBlHaiHh4QqjKdCWHAKZqQp99rWbh3MCEwCyoSVg5rHONr59T
	 lQsu9hdADSwChTG2FttJBJvuxEVkI90lFrehMwGE/OCQODEtKS/b/4IbAsaip6EhJgiNX
	 u38Dd3mVDTpVc4REZ6NFsdVHmL+q4q2/qz52K74e6VwDqZ32SLINAyCjg/fxTHMfFHjUW
	 DhxSVuShgbH0ccA+irckbIR3kTuQMHPADvFpdlDC8IoSBdvm67EyIfi86ySpBfz3nYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KtwXHyDWSLLgEgiAcpqw3B3ai5TKSir/mQ9j+ucSLOg=;
	b=Y3gWNfchAQWSIzsGtyOV1aWedOsOpYzEcRwAVN7dWEYuz2IjXMKZKnhCPiXHNi16n8H3
	 3sFEaxxlzhCsrXtGOMpZRIoBCK+w56diAzrT5W3CLHRlwpd5bBMo+tI3gn0qT5FVKmpXf
	 +Wp01ZD7+e2Tzj7tp2GMHuRU4kRnlyZ45sya9mWuaN3jwPKjOrCYQw+bF07+kTwT+YOjo
	 QeEw6VjuOsigAkWCxKgUpM9/L6+vFRDa6RBSXyPWWJFV8R4Xjw4VDlWdij/OLWPrNMsnx
	 c6JPJ9WXCq+gOQQxDGz+ZUzpNiAY9BO5IxsN+vtHzHbsKV0TLnkLBOg3GoVJ5b4G/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJuQb3Xq;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964D606A336
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4964D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJuQb3Xq
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9496577d4c4so657305285a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619653; x=1796224453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtwXHyDWSLLgEgiAcpqw3B3ai5TKSir/mQ9j+ucSLOg=;
        b=FJuQb3Xq+HRCLSa5zbLOi+fKzlY/v10QJWwtlAK6/eX/+vLD+oSPTAZcTMSfc4PtI7
         w4Llv+vYJxxoN7VS93YdBazhCWVJPeX1HfA4UE538rqqPyQX3P1ozquvYWPMB+LHnxsl
         HcJSjGJOfRuAr3kf8uCiTinlf37lYBI+P89nUc3JWeL/f8ebhLa2hU+EPOprsf0GwP0i
         ElJI3LdX7uNd3BTlFkVSeOxuFxDz3GJqcom6Rb95+o6PcbNTjAmn5rAFGunEgxH39Sx3
         hYOa3gNjwhGrl+QRRYPRzc83DX2PH74ZzJaSK8HkQSRrBI6GRFojmtBxrFwOQqq10y6Q
         bVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619653; x=1796224453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtwXHyDWSLLgEgiAcpqw3B3ai5TKSir/mQ9j+ucSLOg=;
        b=sZFIYGQPYilUpssHXcom1U7o/aIxM1E97zgadBdg7K8oFVHaqZJe8jMObKeCYTZRiC
         O1v7hc/FqZL56fViw6a1shYawZ1/w7kzWzpZPJfi/4v0fYRWyTDGghHNlY5UMNMBOlrB
         MbM9KX4jYVyUi2aEsGT3YofoJ0/h5nEqDYXANirwKLbmJw7NyhOt9Cr5/zJ3UFKFmm7P
         Miu4eukA9wvhp9XPspJ7LDdQzGAhoQ6EnuEI/tZzd6rwgWVHYSK5OGVq0qJUfsxHyhJY
         fOE0yFwY+l3lQteYQBv2nRqi12MUyMj4raCLVm61A8T/cAfKVCy8CMNiuAr1c+odNlSI
         IfeA==
X-Gm-Message-State: APuU4Z9BWzmxRIHwbGZ6pQ3GNEatDrRd8vXeYe49EuzVKG0Kjg5I795O
	YVbqDpjos7ELgwKZbuN5n/frgVoS1uXN8XhrrgjLngqm69TyeAvcxZ/j+9YPTx6K
X-Gm-Gg: AZFdTZcYN+hn7SIpPI9jm8dh8zU+KhfzAe7C16nKpxDRrQ/72izT2cBaBcx7m6xMPoq
	yjROH3oPTQWNKV2tI1qCKIuZdS23b3J35k/ZbcvCbfv1i3a/hGEMvxAFjnl8kZ0A4gqrPIbUjDK
	XiksxPt1WKfKuVDxRqXJThcADLf8Kb6DYxJKfSN5WDVLmDCysEVufu2BX7jmCl3KzyJ99c53R9F
	QBHIsG2sLQT3Kjjr5pNtbdkLrHsJC6/FfBxPsBxIkZPur72qzA2Ox/XzppJ0u30PefML++iUe3Q
	uZOdxkmTLsCRATQxbSVwY/FhRRJ2hfUYlJRZ7Dil2B5WTz29qnflEsBOld9rwqehAYqF4M7UsX4
	fjJl1SRGxRelRpSLuTJbittvl/+AD7hrBQOSiywddi/q0Cz7qEtsgxU8+CRUxxiOW4/NGt6fZ7C
	K4nz0KOFUCW6yOuDzm2QLMw6XLdHB8rmG98oY8f2bWQTDyai0SFmcEieibfxdaW3bubScZxn/L5
	GAGtfJM3aFagUuVXu4wGjZjw4LyDWmAA9yDwky5b0TTKpVbghEW5IgDpWfB4BPD5PpOeXcukCTK
	WDekYebWApUz/arQjUwuWzZHjUmvGL+Ves18V5bHEGoww2VhlAYWOYeiqxGGF8PjFyXDRZaN/G2
	gSe8YaYGoaUcNUCiShlcOLAwSQZ5qHaw2MzhF1yx1r+KGXOmpftXuIqwyUIgt98uVCm91gZ8ZuR
	fDosIWvSDey7/dhZ2g2/Y9RTnLgZpfHG8lAZPl9klAqw==
X-Received: by 2002:a05:620a:890c:b0:93f:eed:ea4f with SMTP id af79cd13be357-949bab3599fmr2711928885a.41.1795619652964;
        Wed, 25 Nov 2026 07:14:12 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3bec3dsm1330286485a.23.2026.11.25.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:14:12 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.1.y] iio: imu: inv_mpu6050: fix swapped accel and gyro startup times
Date: Wed, 25 Nov 2026 20:44:05 +0530
Message-ID: <20261125151407.342141-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-stamina-unsecured-16fe@gregkh>
References: <2026112518-stamina-unsecured-16fe@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3a5e2ca34cadd9d5993064884aa5b9c4f6d71dff upstream.

struct inv_mpu6050_hw declares startup_time as { accel, gyro }, but
every entry of hw_info[] initializes it positionally as
{ *_GYRO_STARTUP_TIME, *_ACCEL_STARTUP_TIME }, so the two values are
swapped for all chips.

inv_mpu6050_switch_engine() waits for startup_time.gyro after enabling
the gyroscope, so it waits for the accelerometer startup time instead,
e.g. 20 ms instead of 60 ms on MPU6050 and 20 ms instead of 100 ms on
ICM20602, and the first gyroscope samples can be read before the sensor
has settled. Enabling only the accelerometer waits longer than needed.

Use designated initializers, so each value is assigned to the member it
is named after.

Fixes: e46a36d92da0 ("Add startup time for each chip using inv_mpu6050 driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ This tree has no ICM20600, IAM20380, IAM20680HP or IAM20680HT entries;
the 15 entries it has are converted the same way. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 75 +++++++++++++++++-----
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index bd64a71817b2..0ba94b069302 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -146,7 +146,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
 		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
-		.startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6050_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6050_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU6500_WHOAMI_VALUE,
@@ -155,7 +158,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU6515_WHOAMI_VALUE,
@@ -164,7 +170,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU6880_WHOAMI_VALUE,
@@ -173,7 +182,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4096,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU6000_WHOAMI_VALUE,
@@ -182,7 +194,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
 		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
-		.startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6050_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6050_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU9150_WHOAMI_VALUE,
@@ -191,7 +206,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
 		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
-		.startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6050_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6050_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU9250_WHOAMI_VALUE,
@@ -200,7 +218,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_MPU9255_WHOAMI_VALUE,
@@ -209,7 +230,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_ICM20608_WHOAMI_VALUE,
@@ -218,7 +242,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_ICM20608D_WHOAMI_VALUE,
@@ -227,7 +254,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_ICM20609_WHOAMI_VALUE,
@@ -236,7 +266,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_ICM20689_WHOAMI_VALUE,
@@ -245,7 +278,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
@@ -254,7 +290,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 1008,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_ICM20602_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_ICM20602_ACCEL_STARTUP_TIME,
+			.gyro = INV_ICM20602_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_ICM20690_WHOAMI_VALUE,
@@ -263,7 +302,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_ICM20690_ACCEL_STARTUP_TIME,
+			.gyro = INV_ICM20690_GYRO_STARTUP_TIME,
+		},
 	},
 	{
 		.whoami = INV_IAM20680_WHOAMI_VALUE,
@@ -272,7 +314,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 512,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 };
 
-- 
2.53.0

