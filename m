Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC80511E6F;
	Thu,  3 Sep 2026 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464242; cv=none; b=QuHbFT99eSF+lRybxDkmY2ioSOK9NApW8k3Eg8blb2vSaAsVza/su+nPk5+xlX/BCtKOwUgNQcVk/vchXbTSHFGTwvMeXvogvh0VAafjEdxvRgoI4wV7JarmNAfQm9yLIlAiw8BDGYlag59D6D1Ix4pA8lXbk9uyO87g/VWUSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464242; c=relaxed/simple;
	bh=rGTB/itmqwEZSAvCeCcxIqgOm5URRbEnVgHmYN5B5rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LT3fEhoRtEZk0YcB8kQ/mISIu6Jh4ofM1K9SW6IFV/ngba+ONFwFtstu/cAPu1Ab8LsPosv4DuJX7vAJYC/lmpUWCv0WjrvYUeP4Sot3ncu4KXh3M3AzKFX3IfdExiuqzUzbJqfn3hU/7F5cAy7SR4osIE9+CzxC5PMGOxAlEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFOCNA6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFOCNA6m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 927EDC2BCB8;
	Thu,  3 Sep 2026 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788464240;
	bh=rGTB/itmqwEZSAvCeCcxIqgOm5URRbEnVgHmYN5B5rI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EFOCNA6mKyEBH/hiGZBXa7gua3O+B7jvv5sd7s+O9zBUB+sArSM9LJHgX/+Ta+N4i
	 ZDNtdb7qbNaWdUVm7Mrsq/3l9YoR6oOpsQCb2s3QsA6vDg9GnwAV7ntMlixc4i/gCC
	 /pN0sBoR79LYg84dsONjqLjzlx2Jul28Lkq9j5kfNJpSfARc14at+5I0nd28yd3NCV
	 iRK8EzEhkBAUc+seRnF2JDvJRJBqpwmBwfAZhlxpYzGgo/fPFy3q4z1NnukzZ9qRdX
	 EqRSV5F0SUJItoVVAp5EpSvCyHqEFVk+EOXrGHhzu+n+vEE1KcMAZ9aoGJlhNymlkK
	 80XeFadxygGmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C7C624D7;
	Thu,  3 Sep 2026 19:37:20 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Sep 2026 21:37:13 +0200
Subject: [PATCH] iio: imu: inv_icm42600: fix odr change not caught in
 certain cases
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-iio-imu-inv-icm42600-fix-odr-change-never-caught-v1-1-029c5f1cbce2@tdk.com>
X-B4-Tracking: v=1; b=H4sIAGjMmWoC/y2NwQqDMBBEf0X23IU0tYr9leIhJquuYFISEwriv
 3fbenzDzLwdEkWmBI9qh0iFEwcvcL1UYGfjJ0J2wqCVblSnbsgckNeM7AuyXWuJFY78xuAinhN
 PhQRMnuYNB9foutV346gFuX1FkvpP+ez/nPKwkN2+HjiOD6/NEpOUAAAA
X-Change-ID: 20260903-iio-imu-inv-icm42600-fix-odr-change-never-caught-bd624725ade7
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788464239; l=2940;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=m60S/Iw6rtSEbJaApo5jUI0iF3VazngX65yETOcKHwE=;
 b=w9aaIbjDwjHyWh2vnYmdg7uSe/Z5FtSOJUuNtoDF944JZ7VLjbzR5zlMVdP5tnpRYSzShiv5R
 +pdmEs+el5vAuIShf+0fdu1LFJ0Ik6SZJe0qKkWiulg7tZuj16H8296
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When using both accel and gyro with different frequencies, the ODR
change flag in the FIFO header can be sometime in a packet with
invalid data. Since we are ignoring these packets, we miss the ODR
change and any further change are blocked until sensor is turned off.

Fix this by moving the packet data validity check after the ODR change
flag check.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 8 ++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 3197081a808a..65d29de8ecf9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1235,15 +1235,15 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 		if (size <= 0)
 			return size;
 
-		/* skip packet if no accel data or data is invalid */
-		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel))
-			continue;
-
 		/* update odr */
 		if (odr & INV_ICM42600_SENSOR_ACCEL)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
+		/* skip packet if no accel data or data is invalid */
+		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel))
+			continue;
+
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9de5c383665f..4e20d61d897b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -816,15 +816,15 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 		if (size <= 0)
 			return size;
 
-		/* skip packet if no gyro data or data is invalid */
-		if (gyro == NULL || !inv_icm42600_fifo_is_data_valid(gyro))
-			continue;
-
 		/* update odr */
 		if (odr & INV_ICM42600_SENSOR_GYRO)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
+		/* skip packet if no gyro data or data is invalid */
+		if (gyro == NULL || !inv_icm42600_fifo_is_data_valid(gyro))
+			continue;
+
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;

---
base-commit: 183f05a300eab41e4578337eac59335730dfebf9
change-id: 20260903-iio-imu-inv-icm42600-fix-odr-change-never-caught-bd624725ade7

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


