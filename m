Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609470;
	b=qfg72LjtE6YfzVhK1xEbCzPRFngrRMGzbKAPPsSVXcbr9XpptRmYWFu7duGVP2ACcxt8
	 YbY7fCQPhdPVJCPnUtXmr6Ww4+xFj7XHzuxkrmwxGb92h16S6GhuA99sRMl7ELJUoDpFP
	 WprWL204YvHqiaHTKG10AeyK4VoGvwiDXYhSJFYAV4wQjyVpDMmk8qJ4Uf79wUYwHNANR
	 RzIBCSQpsFRmzMAdOGkCiv4/1zbs6tCYivAyRZ7VXbe/Qp1Gz5fAljNcxkzkcT0fVSUy/
	 yj1HTGUz17d2ajd7ql1inNJ3HxYZhxkq8GUYXju/WUCmx3tTEMoE41OgzcQWFaaP+Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609470;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BURExK7vNrHTobqP13WbXIWkYE/ZxACqJBHL+Zxdtwk=;
	b=j1jXeqaPv9ZvKX1vzv0BgOh8k2p/trTf3HleJp4Up23JID+SByQkSBQgtJREucD99Iqp
	 ObS7Q2ZEfRAaQAg1fHu105jJxfQZE92UFz41UHIARyHAo//s1Om3xoUN7jI3zKlEw/MJg
	 hxu7MUcaAbhNKfGFH1MRyDFuXZq1CrLctwhoHAZXrhhyhIgwCkwfEyxwOUInh2z/BJSvN
	 oKjKqRm2J9SCLdIO7SqTdzdvqSQQ8q1GW/1kTImH+n5kaYKuDbpgI5nWxA/irwr9QMjXp
	 MrJXTv6pOpvur2WuF8KRLannSWIOPNtK8rrYZdW1/yxfRnSDWbvlfK570/5K7c5V5OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aEXgV6Md;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507C606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aEXgV6Md
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BD61F000C0;
	Wed, 25 Nov 2026 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609469;
	bh=BURExK7vNrHTobqP13WbXIWkYE/ZxACqJBHL+Zxdtwk=;
	h=Subject:To:Cc:From:Date;
	b=aEXgV6MdwnpAQ5iae59fteNWMXQIVF2WVDCJe54csgerYwWk4rHz4zHzIyj4o+ifu
	 0RGFwLL6I1FH0zqlngq8LY7GXfD3daplHvFqmINokJLs01qjd7IbXFiB8mjzrUM6dY
	 OgXmzLk2CWCwhu+Gm6yoLDFyoyVvDNeBnDqtLv5w=
Subject: FAILED: patch "[PATCH] iio: imu: inv_mpu6050: fix swapped accel and gyro startup" failed to apply to 6.6-stable tree
To: kapoorarnav43@gmail.com,jean-baptiste.maneyrol@tdk.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:22:17 +0100
Message-ID: <2026112517-barrel-nylon-c582@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3a5e2ca34cadd9d5993064884aa5b9c4f6d71dff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112517-barrel-nylon-c582@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a5e2ca34cadd9d5993064884aa5b9c4f6d71dff Mon Sep 17 00:00:00 2001
From: Arnav Kapoor <kapoorarnav43@gmail.com>
Date: Sun, 11 Oct 2026 10:27:04 +0530
Subject: [PATCH] iio: imu: inv_mpu6050: fix swapped accel and gyro startup
 times

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

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 1614f49be66c..7265a3c3de05 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -150,7 +150,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -159,7 +162,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -168,7 +174,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -177,7 +186,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -186,7 +198,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -195,7 +210,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -204,7 +222,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -213,7 +234,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -222,7 +246,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -231,7 +258,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -240,7 +270,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -249,7 +282,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -258,7 +294,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -267,7 +306,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
@@ -276,7 +318,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_ICM20690_ACCEL_STARTUP_TIME,
+			.gyro = INV_ICM20690_GYRO_STARTUP_TIME,
+		},
 	},
 	{	.whoami = INV_IAM20380_WHOAMI_VALUE,
 		.name = "IAM20380",
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
 	{
 		.whoami = INV_IAM20680_WHOAMI_VALUE,
@@ -293,7 +341,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
 		.whoami = INV_IAM20680HP_WHOAMI_VALUE,
@@ -302,7 +353,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
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
 		.whoami = INV_IAM20680HT_WHOAMI_VALUE,
@@ -311,7 +365,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
-		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+		.startup_time = {
+			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
+			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
+		},
 	},
 };
 

