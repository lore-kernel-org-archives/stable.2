Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619895;
	b=b58Nk8+Od+pBxcyLWqaFcLMLXJ3XO9s9mycGf+g1H3IaJN77EHLX0VFXSGuxQM7jzS4i
	 U6Lf03DBftVl+jFcGNCvrkXnpb1WEJZUQ/Dkzb9IyyJ9KVUcsk2U3lCo6SvuVCC6Tddt+
	 kerejkNxVrUnkPXF9Ffd7dTHEw7WZ1747X8XhhUqQNSiv+nU1NEuD+6CJhC1VGOJSGqEf
	 jgXAGT3iGT7uwWKjxW3lBdI2ygWq2pGV2tTB5qKWCsKN6sAhrOZCUpIeoxrgzaRo/I9f/
	 MWxYIL2eUWBLGIBTqZlmz5QkKJLhDsIbsOc2Q6zUvfgA5kB398wosjRR2ntfXKm/Scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9v3KGObS3I4qmCXXeaq33Sk2gaD4E0N82i03n+h6Igw=;
	b=t9C90T0QEYRDA+Hhu4+0kUjSM1Lkg5JPTARupY2kJGmNy4QPRkfxwtXZk1JptC5AhvTZ
	 qr5+ShZIlHDhRsJ3BeiqN4KSR4Y77/PjnjEzLfaQExqAD4W509/7FuRS0ENngfayBfNs3
	 g8Yfvek+fyTf58/nCxhYP/WM1OLUZMfDvlAV4X3jSQMtcL9L29Ubkg3UBMQQ/yD75RF75
	 1fPSLlOllPsM5iAzCeQO6xa24j1WDKrOW8zT45pZiM5pE4LqiZQBlSQgjUBCQZoXvQClM
	 bgmilNbt0FlHgOsRnpr5Vhfl6K65W6Ys6mKvoPlwvIi6CNZzSSwUQblS46M44fX+32A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qlDEiflK;
	arc=none smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91685606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91685606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qlDEiflK
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3adff684a52so48036671fa.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619894; x=1796224694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9v3KGObS3I4qmCXXeaq33Sk2gaD4E0N82i03n+h6Igw=;
        b=qlDEiflKUetv+4QYYL/mYdkoS+iEeG+DUNHlgb5S/T43X+SjRjP11S3HdqL44CbcNn
         90/+ASGub/use9y6AKu3o2q+yVPjcuJCvWCa4L9RMoSisGcCCjsKSQbq7MEBsGE863Vh
         mBsySexR8epsSZPrQJEF7Tt+zEmvOluImMYIDzjkcMymwbkOA+cFVffotgVBfAdzM1Op
         sGqx16iMaIgDycX7HTMgwZ5ev6mLrJqNKdjSAUtsuU1VFJMEgkH+xsiXgkehyvvENVU4
         XS7meC1Yt9HbgJDY3tmdgHAtwamcY4EKwYOThItuSmTERUt61ilRNfrt+rnvzQ6z7xNN
         SyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619894; x=1796224694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9v3KGObS3I4qmCXXeaq33Sk2gaD4E0N82i03n+h6Igw=;
        b=sfGcpzwUkbK96z/Oo4Q7vRNDaRgZtYxCUgE8NT0NFT1iPp5+VchwbVxHssCnsjJ/9e
         dtaWJ9yWuaQETAzyjg7/v0Rvxk3dtsVW+/D5MawEeJO7Rc4jyPVhj8M4hML/rC1VMSB0
         g7yppE6bAaAw8B9DS8PX6W9+SsKc41f2ctVcu4odgrSBpMLSsmDJm2MXBGlyJE+P/2/z
         ySvq9dm9Cth6Tyy27bQ5RNwyG2lvF15+ylAqh21C80Y4JI2HPJgCMU+UdYaRkESJ+9Y1
         l3NvZovMAXIwdTLPA2+0bJesGMm0Dg6S+pnlskbEwzpVOlMVtLfBcoZQzwWxKZ75s7VG
         gOdw==
X-Gm-Message-State: APuU4Z+2XFCJFIp92m39ojAycv0lMnNB7nfPsEXGqtDxptszxv0DvK2d
	ToYUPPXaTuYbelUF9C17+k0vtQX4ojC3M9oF/KWVEjwO8U9aLFiGM7QSgcimLLAE
X-Gm-Gg: AZFdTZd2T1i0XehLDvqlJQUcTBh2HcmCMaq6Jlvvr9JhPqt/v5IIjByGbN+5V2z2Hgi
	K0qI3PQCmTHIaf07S9V7S7Whaboavm8gVzdIVPmEg2/+NKoR5hKUeiZ2YN4YjKFK893BXfV3xwR
	Da2BqgzhdjLfLdFZ5StpaYBD6E//oB9Ef7mR4mYwekFynnQtLA9/+LZvdG0l1KS57kESRtMxSlu
	aTBTn8YPbaUQCeD2f7+/IXFG1rzIGk+qjvJlauQ7o9csxV4j6I98M6eyfIF6eRIYZDOg34SbxhW
	jSxmqqoDrjr2jw3YeegCt6+FYOW28Pesj1wQ8QCaCx9iw9GQbhwegEJfnKYUSy5BxtHbwy8vw2R
	+AcgKopo+vkjUpqT5iwjaiBtibYfgZcOBqehAxsb4ozDtigq1573Ljf7AWjUwFSUJ1qMpjf5mqq
	sTEGnujHEhbzlFLeURSIxjzQuhja7uU5fRbR5dqb0LYoTBtWUuxVbNl5r0cyBAQGU1U3kDfCmDA
	vsWEHdEc7lMZ0yRoyiahbPsZ5xtIR7Hl0+G+iZK/7Px28+VOxu/dT7eznyqKt9M9CtoJtH6y31f
	9sby+KQheNSJ9IeEacnMMjiujpCpRD6giEObP8QlxqKNLuacp93P7TS0wyvcVL+wUzzuMo9uuVy
	nLmvGas7TCVH2jEytPi5rs0jDCz6KqxenP1sodiLlenbOgB0DCX+cmbJs+UsVG6AzDWtEuo+Vqf
	h1GRcXDPWyI6367iZpZb5fTd4kP93V36fomajd9bKP5w==
X-Received: by 2002:a05:651c:a16b:b0:3ad:fcf7:950f with SMTP id 38308e7fff4ca-3ae7b7ce4dbmr46308491fa.13.1795619893330;
        Wed, 25 Nov 2026 07:18:13 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805253acsm52479311fa.22.2026.11.25.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:18:13 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.6.y] iio: imu: inv_mpu6050: fix swapped accel and gyro startup times
Date: Wed, 25 Nov 2026 20:48:03 +0530
Message-ID: <20261125151805.343087-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-barrel-nylon-c582@gregkh>
References: <2026112517-barrel-nylon-c582@gregkh>
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
index a9a5fb266ef1..8faf39987d35 100644
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
 		.whoami = INV_ICM20600_WHOAMI_VALUE,
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
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
@@ -263,7 +302,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -272,7 +314,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -281,7 +326,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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

