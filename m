Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619874;
	b=HYBKFlB+STCsgAQVrV4q64m2j87pD4l0U9dctuvws/6kR76yxreii9rQrr8CLh2Xl29r
	 TgkWdWgtY7nxaOz0EeWbexK796UevqI2N2gcF2JxYKaTtXDytp0VLitvxc7JaPQcdXn+q
	 SrnDcf/BvaaY3SnIkJYIDQCpAGxAIwH5Bjoul6q3YA9UEELp3AbDcA2ZDSOpBrhI35jZ+
	 lL3sI06gvo1mjZZHy97ryobtxDAnpJix+xqqtE7Kack4xjolFUV34k19V/Vx68L9urBya
	 pp7HrCJYq3yWjlfja1/MyChnrbC4X0n3PXEHsO8XwazpSN/Ex13swFG2fLyNfLBPUvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m1CG7tDNyU5z797BTkR9NTR5RLGcfyKPpvkNFfSMWP0=;
	b=M/HtnYgsAgo4sYmGZB5rvaPEQXFLWUfQgraif7auIlEgDCNxgFMJ44WTewVtLADVjg9l
	 IEsehLbU9/X8ck/yrFG9A7H9q+fFw5UmUJAbC1WSiLtnfA7r6cXGLzJq62INdbwivc0ar
	 Gz/7W2GyI8WwjhYN22LaosqZYpJ87ruWZnufORV7s+6eYW4aYdbxLIJ1RRZ4UKKULdPq6
	 crr8+a6bAe1Ut1n8A4KFZZDA/Aa7s+htuqg1IhQ2jPxFp1FxgCZNcO92LfVv15wAlR0FE
	 U5U1Yru9G4lriTESbHliTcE638+TS17MHfoKYq3JZRmzm9HGj77yUl8zWlsnEgowwRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s99iEQWP;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A9606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103A9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s99iEQWP
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9495d543c42so598048985a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619873; x=1796224673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1CG7tDNyU5z797BTkR9NTR5RLGcfyKPpvkNFfSMWP0=;
        b=s99iEQWPakK8jn3aqdYTgJZqW+ypybADPR/LRMxM92MdVg0e/0lSRENrbDJ3n6u77Y
         4uwvEBIHnFH2Y5KdaZsNSpRNM+BvzjNaxV3FazHKMkA+6dNInPeZ81zDjnFld4t0GwEB
         5mWYAkOYrJk7LwDgghu8p8iOOyaZybZfcr+MEoImovC+qAgS8Mro7JFNAPF6BI6rvCm3
         yIu2bf2p2x+koViFNwnUr0jX8J184JIaNfYaRgteNQeBwb+WrsINhDdlkzVeo/NhW8DT
         fVDtOyKVA9/Gk1jBepxQj56GFhxHmozRF/ExW4jDEtsBM5RnFfp24rHyeH9siw+M7Spm
         SchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619873; x=1796224673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m1CG7tDNyU5z797BTkR9NTR5RLGcfyKPpvkNFfSMWP0=;
        b=jl0BP+cM8F5Iw3ysBSeNc3Ou1leJwhSsqBIt3Ly7ZDtRcnAoIEKx1Wzchwm9ez48Ce
         nr/lT4uKZaq3AH/583AGB8jmLGDXXaEb8TTyqd3leLGG6r4nFJKgeG/kzlGRxWiLhx1m
         Lgw2LnWN0faAKb8AvkO6BWo8/7FEDiGk1/7nYZoktoIE42z9Epfqiji2OUkCHa4zeJLq
         xAwj6Ggh9wJvd4vaUC8ZmnmQJCZU5RL2HTVIHstv/bHhvrbMseHsM8ZwYsg4/8YmWrP2
         MDOo5JT3I0j1lpr25qZ2SiI/QeJ5MjfcGAp+JgHjGGMxKA9FeaOwSiYb8hVHtr3P5Lqj
         O0Bg==
X-Gm-Message-State: APuU4Z+XygVwCW1X/aHTI1HDDg7jLRAJToS84022NF/sBj0J96ByVJiZ
	VF3UVnf+5MFU42mc7BG3RkPHHNm2VVjrXZmThrnTZMQHCiA+4LqWGDMmKwuf9Jo3
X-Gm-Gg: AZFdTZcy0MyRxyEILimYfg75mhl0VjRzSPR4Y7yJ90DpUmM1LaTzjvD4KwwD8Yb8gz4
	HJB+2rb3J86bUQKt3aFCm1vEN7FOC/Z1fRpID5Gc0p4x+9creL0YFJCz79CpvGBgqZSJsM/1Y1a
	c5/+AkjACX8eGLCpxK0TwrsJKdvXtjS+Ta7/tRLTR49Q5s+vkbGZd7lCuMA5kixbfOWzZ3ob+aX
	lMxz7BdZbPoLjgdXTRq88AT3t0PZNGeRydXXEiHmWMmv5ZeMZHya7sDj9h0h1czsrx4ByVM12AX
	QMS7XPm0N0T1sj4K7RpA4zd2v7XGeVWQ0oB58+c7+wjlAAczwhB5TPHD6EjDHGAnXmYE8hGylyz
	yLOmI1nEykqf25VPL/7YOna1QqpfDgXSeHBIhjeDPnrMigdXHYk4Z6iWEXn4ZJCOXWHChBSpzxX
	8fChyxdtyJmBmL6dQ+fMshOOAuQdSLpIKn+ZiMeKsIKKqamEh/p6tSkhYtj4Kb9RcoDjDTrkD+Z
	QVV0pKYbLkO+072zYEP77pqm7E+9nVDeuj6/8R+OVRWEGhWPKlZMbqzUKeRqxxp2j9yKxNvslVu
	aTisP8jCMK1r/9/UBTyj6iCZuB0wHVR6Ed7Iw3GOtnbGzVpTpCdWXjldpJF3FlP7lEijafPN4d9
	/7MCKlKDEwjvYrBGEqCHzXEfvh/jI6vPtSfLJPME9bY9cLZ9gJEErBOr5GPHOwxL8OrN6QnXXjv
	clhxYZutVX5azfQtBnCmqsZOq4Uy7k6/ay0Hmi4wcvWQ==
X-Received: by 2002:a05:620a:4551:b0:949:5c62:e779 with SMTP id af79cd13be357-949ba954fe8mr3104772985a.26.1795619872939;
        Wed, 25 Nov 2026 07:17:52 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb424fa6sm1314861185a.40.2026.11.25.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:17:52 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.12.y] iio: imu: inv_mpu6050: fix swapped accel and gyro startup times
Date: Wed, 25 Nov 2026 20:47:46 +0530
Message-ID: <20261125151747.343007-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-fondling-grappling-bcd4@gregkh>
References: <2026112517-fondling-grappling-bcd4@gregkh>
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
[ This tree has no IAM20380, IAM20680HP or IAM20680HT entries; the 16
entries it has are converted the same way. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 80 +++++++++++++++++-----
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6afc78810820..24b70d728372 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -149,7 +149,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -158,7 +161,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -167,7 +173,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -176,7 +185,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -185,7 +197,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -194,7 +209,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -203,7 +221,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -212,7 +233,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -221,7 +245,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -230,7 +257,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -239,7 +269,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -248,7 +281,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
 		.whoami = INV_ICM20600_WHOAMI_VALUE,
@@ -257,7 +293,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
@@ -266,7 +305,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -275,7 +317,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -284,7 +329,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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

