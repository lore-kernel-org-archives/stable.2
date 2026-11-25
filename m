Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619673;
	b=koxIXoM6TtF9LScwCxJiXv3tzB5BCXUBWhpEJMDjzf99nq6Aui7iyxdk7HpRuR11I9Aq
	 b1VCsDPlQQ7EWJ0fdhfSF+39YXjngsz6qa1anpYQFFIn3akTeslB7yvMV0aShwqRMN21N
	 mrhaXkX23RGgddjMdv+m/ZeuHdwqr2xhSAVU3OsAr1jQnYxhOm10VKma4ljulSKlwFRYo
	 z5g8im+qrF1DxF82MAeOEWdfw+2U04CZiGFsajI3pH8Nn/0OVtCbddbsMZj/qBrOokZUr
	 nYJusum7QC5bhiSgiAN/RTpDv+Zbf+Z583x1NWUdRQ0LmB27I8z6lk2DjIpRftj34YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NOf6ZLnHiaJ5mUUxj1TZ2mg5X07wZqSgGuOHhlfGjrA=;
	b=gpxmWm4EZmaXdQswODI/qRBTnsQMUw7YjkPj5DURj5FQf6iSziHH6rl9CpxH+IyixBdL
	 8MZnul4UXOs8F90EE+mla3+DL/MFVDFwTcTRd3CQCkI866SAHOVKUt5zI8ZJqZ1k1oDDe
	 5BHKvGFyijiWlixJOLaXTOjzRVq9JAe3+Y41IbuS+H3EYoJzhwatPqeQ6AFam7AbY21oY
	 7KR8/mU6oq9k9QN8TKWZlarsSqOdzokCln0yY6KkMbk2GTQp1MRE9Z1Va74QLcwvMVzMf
	 RlD6rA/0RwotuQLYX/zokJPcZdknjnPUaV3ebkiG7RJJyPhbptUonEluyw0UCaLRveg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ro18k2pA;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5C606A6A1
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F5C606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ro18k2pA
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-537548b811aso48920961cf.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619671; x=1796224471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOf6ZLnHiaJ5mUUxj1TZ2mg5X07wZqSgGuOHhlfGjrA=;
        b=Ro18k2pA2lbmHdi43VefrD9JN9E/NHpup5y2Nwa3nCBp9yvyEjZD/0/p4M48d+b+v9
         G3ZhuGEaR9h5XPlgrxGCQCJ1wM+grxhWMpQXSDcRJ30BpWdIt1pZulKMqSjgYvd6BGtW
         GVRUcTP0o8oCt5PuHdxbxfoJInD60XE5+nbK5fbCNJFUM8vdjZQR9mm6BKWyIPnnfSRu
         7vdirRkNWjKEdiEpdLAPmX92KVa8fBJXlO1gAxjwjeYnkL+vPEt4ySnstyDpOE2NCFP2
         WZLWy7LjYVn6HB3IE0uviaSIAgXHdAlXA9VfHDQccVThfa6M5T64wvEBsEtfxQ2yjnFV
         UnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619671; x=1796224471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOf6ZLnHiaJ5mUUxj1TZ2mg5X07wZqSgGuOHhlfGjrA=;
        b=PWjclfYaJsyFa2HgN/DX/89ROouJyUeG4EV2KGkgzZunzoFIOhPbmPAFR2yqyCne2I
         xesAM3hudjAm96ElD4uokdPPZ2q0zmqDseFgWkRbvafRYTuiGyP56zxm6E2WfN/0fDJZ
         8ewnpb2b7fY5l/O7dIItDvihttAanvLWFAoJjQxeP2tdPLqSMgl0sX99hoABhJlMj+1r
         KgnCTvzNoR0WL/dSRgeAkmL7z6pnP+mHfZXutHBgnBneTpfcNzr4/ZZYXdPulUHg+YSB
         rbFzJ3fVMzVRpJL0qnlGfcpnmQt5d1w8dP9sv5eagryggINpaskroEjXStV2d3bp62AD
         IzEA==
X-Gm-Message-State: APuU4Z+NkL4Jexn95L2fzshH5+vBkFv5RSI/M4SXTOtUg4l4g6NQzYji
	5bjdsN8EzRzQ5MhS4UBwCHrOM8FhttFEXm4/Xj72nWw4BZxeEp/fP9UTH/mDKkcu
X-Gm-Gg: AZFdTZeYdHMLxCVs/OReeCdQrPSKpI678H5EUOqqRI35L0Onje2bQZT4C4BRaG3gaFK
	4eEr5RuXEyPW8VvlDktGOmliY6eaddum2BribpNty7ksrfzfVACKF8CERzE9AtO3Fy8cqKNhpwS
	AgPLz7RgVTxXYucUSCqwDZHqCK3Aa9GxQQxZsVrMsuFhq5vBMpv6QAcDGZCuBdiiMN5+FWZadLK
	d9+ifQM1iKIPtICKk2WTFCSQLckH7Ho/shtjWPkO0gNQjSNCnk3QMW2l6IYIeHMWPiATenfkzWa
	GRQBdjJt79/fjg27/88ddKrSOxjT2QYx7NQVHLBhIJUcuC9aLX2UHsShnms/OlQtsF2BexAF2Jp
	EaYiqWKIu++/2dOjNMnJmXD6+DMPqReP1xxDaIn1aTxqBvwrEpy7iiJE0auIVU9VgvalcxopfZL
	asAUng+ft75gle6LV+YvWMz1sN8Qdz1J/PujEVLM/FWLBD05L37m3GCZOg/gYqRWzPhGdlYUXuP
	JiMXGBOtWElth5cYJO/rkwoujas1S6/wNHaxP9nbmmayqfMR5ojwCzDfJJw+P9LmSUQ4ZM1AqvP
	cU1BGwj8KUqJa518+38BFEOo24XBg2ZFIYsw1k6bIwibVVvcQ0Vtq/ufSN0PKxW/dn2qLHZYXI+
	Bz+Swrsl3+Y40hY6KhMdBUT9ysWlpbbvs62vy2MXI9Bn5la2KfQnThN2aqhfGXjpDUaGVKAw7wn
	Ie8tbIiM7hfBeQa9h3K8oLHTeJz4xc3oqcE8GYFxORFg==
X-Received: by 2002:a05:620a:40cd:b0:949:5c62:e775 with SMTP id af79cd13be357-949ba9b991fmr3378680585a.15.1795619671104;
        Wed, 25 Nov 2026 07:14:31 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a0c18267esm78362285a.4.2026.11.25.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:14:30 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 5.15.y] iio: imu: inv_mpu6050: fix swapped accel and gyro startup times
Date: Wed, 25 Nov 2026 20:44:23 +0530
Message-ID: <20261125151425.342214-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-eternal-joyfully-573d@gregkh>
References: <2026112518-eternal-joyfully-573d@gregkh>
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
[ This tree has no ICM20608D, ICM20600, IAM20380, IAM20680HP or
IAM20680HT entries; the 14 entries it has are converted the same way. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 70 +++++++++++++++++-----
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b79304e16af5..83978dcb870e 100644
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
 		.whoami = INV_ICM20609_WHOAMI_VALUE,
@@ -227,7 +254,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
@@ -245,7 +278,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -254,7 +290,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -263,7 +302,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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

