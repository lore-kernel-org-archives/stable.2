Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E64611C9;
	Mon, 14 Sep 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389841; cv=none; b=n8/wleDtVa+tr3zFusjwWN3qoNtPV9ESZ38nFgdJ6LyrSPq7qdWTJpSSdSKg0TQhZrh5o6n9bHiNK0NcOGZxzypSCxsmQfjeS/BA7Da2MKJvrOxuhE2D6eOMPyUI1XwB1xKqOnfJju0ugPXvtWdsFRh6jEYtohxaHweoKOzPOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389841; c=relaxed/simple;
	bh=wuQkeS/vHKuwE6gpcjcIiinNVpp8teX6wpx7XsfVAkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R4lDV4HmjYmfc5Jdogql0aZjYx7EgEipM5f2AaoYxgv8gVuEqFdxPCph0MFMXYy6mNSZWNmLrFdWWdke4u0nj4L423hqFAv+Uai25mIz00OSE7OnM6cR/Ejfpg44O1LVFiWYKVgo2on2lAc2Mkm0dhdwwscloNbZXOuxlRIJ9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6lirPXO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6lirPXO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E245BC2BCB8;
	Mon, 14 Sep 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789389841;
	bh=wuQkeS/vHKuwE6gpcjcIiinNVpp8teX6wpx7XsfVAkg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=A6lirPXOg4/FZ9FaVIbdmH9+OS/2ug5wKUI1S7FWKKbeiYvR908nwPQsT/9a+AW/r
	 Neg8qAl7jgbNXMsF6I1H+ipLlUuZSGLRmUjOY/EUfHwOOx8w0ZC2pz7FAzVH4KuCHc
	 wNWlk/tiHFEMeRibFf1XGEV4IhOvmsm2gwMLVZ8ozrFEvq8fckSPrH0MpyCSlBV+ur
	 J9YWCTHJc+s0gdvxWjRp7LDBxQD5bXpNXwJnsHqetPpGGy61z338uisnjrRZp2Fdp5
	 +xWzjJ6LJgwDyKO/Ikc4mSADeDQLfE3f+zrQHT9o9TWhemdi2kBwKqLEQx45bPHdNC
	 JZQvR2iIjXzSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F7FC88E50;
	Mon, 14 Sep 2026 12:44:00 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 14 Sep 2026 14:43:42 +0200
Subject: [PATCH] iio: imu: inv_icm42600: force accel odr change when
 switching power mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-iio-imu-inv-icm42600-fix-odr-change-event-issue-when-switching-power-mode-v1-1-9bbe0cb3eb07@tdk.com>
X-B4-Tracking: v=1; b=H4sIAP3rp2oC/y2O2w6CMBBEf4Xss5O0eAH9FeODtgusCS3pcjEh/
 Lv18ngmmZmzknISVroUKyWeRSWGDHZXkOvuoWWIz0ylKU/mbC1EIqSfIGGGuP6QY4NGXog+4V/
 hmcMIUZ0YS8cBusjoOgkthrhwQh89o7Z7X9WmavjoKP8NifPO1+V6+7FOjye78SNA2/YG6h5RM
 K0AAAA=
X-Change-ID: 20260911-iio-imu-inv-icm42600-fix-odr-change-event-issue-when-switching-power-mode-813d7807fe5c
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789389839; l=4187;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=WBL1h1VZ++TsPLXkm1zUr0D3bZ+XYIOH2ftsXG9Um3A=;
 b=g550qyeV5zMce1PI/8k/dzj6ckSaQV+QAP0LJwN9RRmGTb6Vq0JQ3Z0QfCo6IMGBwNuX1qyaP
 LBAeeLvog/cAdKjQYiNcB73sUghEhah2aBKE3etDEgkpELpbfiV8uXK
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When accel must switch from low-power mode to low-noise due to a change in
ODR, there is an hardware bug that sometimes prevent the ODR change flag
to be set in the FIFO header. If this happens, the driver is stuck waiting
for the ODR change flag that is never happening.

Fix this by using accel_force_odr flag set when switching mode for forcing
apply of ODR change. Do the apply after parsing FIFO data to let the flag
do the job if it is here.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 9 ++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 9 +++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index f6c7c84c7e45..e56943931b6a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -179,6 +179,7 @@ struct inv_icm42600_state {
 	struct {
 		s64 gyro;
 		s64 accel;
+		bool accel_force_odr;
 	} timestamp;
 	struct inv_icm42600_apex apex;
 	struct inv_icm42600_fifo fifo;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 65d29de8ecf9..cc8c074777c9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1236,9 +1236,11 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			return size;
 
 		/* update odr */
-		if (odr & INV_ICM42600_SENSOR_ACCEL)
+		if (odr & INV_ICM42600_SENSOR_ACCEL) {
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
+			st->timestamp.accel_force_odr = false;
+		}
 
 		/* skip packet if no accel data or data is invalid */
 		if (accel == NULL || !inv_icm42600_fifo_is_data_valid(accel))
@@ -1251,5 +1253,10 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
 	}
 
+	if (st->timestamp.accel_force_odr) {
+		inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+		st->timestamp.accel_force_odr = false;
+	}
+
 	return 0;
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index ded45dfe46a2..2bf9fc29d7d2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -384,6 +384,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+	if (sensor == INV_ICM42600_SENSOR_ACCEL)
+		st->timestamp.accel_force_odr = false;
 
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index be8cbecdd92e..cd2e53416f5b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -325,6 +325,15 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 		break;
 	}
 
+	/*
+	 * If we change mode from low-power to low-noise because of odr,
+	 * we need to force odr change.
+	 */
+	if (oldconf->mode == INV_ICM42600_SENSOR_MODE_LOW_POWER &&
+	    conf->mode == INV_ICM42600_SENSOR_MODE_LOW_NOISE &&
+	    conf->odr != oldconf->odr)
+		st->timestamp.accel_force_odr = true;
+
 	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
 	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
 		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |

---
base-commit: a7c07602e00596a45de8a4a700af96392953ed38
change-id: 20260911-iio-imu-inv-icm42600-fix-odr-change-event-issue-when-switching-power-mode-813d7807fe5c

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


