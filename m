Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049167;
	b=VY8RKtrP6Peg8FoKoTjkJ9JuNf7mvQqy33kRxeWyawOA85+dhfE4AX0vOGiVesYI3+Os
	 chXBRayNGzQ5AOZyfK/HYlia4+e+Y3U1eaGdh6A0tAQ5xg9d3/KefhTWE+lMIoBDflNTN
	 Sjfljp7HsywGUVbjsFU3JfXq6pp0hKmsQj/PUNi08pNe82gxOXb/pFLc1NCVipQNks4n4
	 H/cxRB+0RGWEHA5rgcQ3z2SQr24XXJMZPQIs1yTrvHTSmCLxjAMOx5znkJ9JR4XaBKsgo
	 rkl4U642H5PqrXW6gmebZYs6kbs2p8vracboX4nuErjBursODtblPaSq44DtgM0vrOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049167;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TCHgaqcyiOyCfgzbKzxr68S9vOb5bJQ8MVbQ+X0z42U=;
	b=nJ6hpiSAF5gVDYxfEzEQuvsTexYJwoJRoxXkNsBb3p6U3wuyg+osbPcKpixDmmRNoISn
	 zT/D2vG+qThZ7BJ32eFqyWL/HK8G1Ctw1GKk3scuCMJnTwchBYIJIjg+2TI8j39s0thvu
	 uUDQIKqG7MxnjGrn8TlqQJP01NNrLQRGtX1M8l3VfQDQa3U2ErOLFLmSDz0Nx6M3+lVDI
	 QtOKX6aBHv+U7u6hbIUQNRWcrePR36SbTCwH9Ca/b+hSNRbDYIIQdzscQ6lte2xrsseGV
	 fXcOgvxqQRKgAQUyD//WXifOPCtCVAQ0F022iX1KIn+0BYoTURzpnYqmX+RHnuxw30g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaKQWglO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE13606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaKQWglO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1D21F0089F;
	Sat,  7 Nov 2026 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049166;
	bh=TCHgaqcyiOyCfgzbKzxr68S9vOb5bJQ8MVbQ+X0z42U=;
	h=From:To:Cc:Subject:Date;
	b=CaKQWglOxIbgEFqZ8n9VTZpNkNvQ1GhjAY7OXEjIrnspNu4a3WHbM9C0+BaogN2hP
	 g4J3VcexAs01OQEBaAWEI/eDU7gLhtYD9VKDHUyctliRuh2GYIya3mo0VOIrZkBoS9
	 /gyrXE0dQDsvVsd9hRrJwVYM0GFVLrE5Lc3sI+GsA+FhSGMERCufI+Ez3OkF3JKgKl
	 jKN70ElC8EY/iCdVtmDr9p+LopyxR7d3ZgsNx4vX45/Lw3B52p2r3EqjRCMd5L3dmm
	 8xTj6/lwynacg3ep+49tCeEnZZNVFpBpr/W6Ql0EkwtaEyquffHIzdvwwNJfNx71Bx
	 CA/r/xPC84z+A==
From: Sasha Levin <sashal@kernel.org>
To: jean-baptiste.maneyrol@tdk.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: force accel odr change when switching power mode" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:25 -0500
Message-ID: <20261107055924-failed-5.15-d52047d84963@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d52047d84963e5cf7c8ad502e0adf003fb0669de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055924-failed-5.15-d52047d84963@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d52047d84963e5cf7c8ad502e0adf003fb0669de Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Mon, 14 Sep 2026 14:43:42 +0200
Subject: [PATCH] iio: imu: inv_icm42600: force accel odr change when switching
 power mode

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
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 9 ++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 9 +++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index f6c7c84c7e45f..e56943931b6a0 100644
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
index 65d29de8ecf9c..cc8c074777c9d 100644
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
index ded45dfe46a25..2bf9fc29d7d29 100644
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
index be8cbecdd92e4..cd2e53416f5b1 100644
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
-- 
2.53.0




