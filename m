Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050178;
	b=FU8yGJ0eSo2QelXsnLnIxoPfjQjSnxNtm9W7bemDYjFUYml1BoQensH2vospIZrZTg/p
	 t+YFFIrm0jTh7e9R8ORQDBiprBarkrgdQMPKMVuOZKp6LWGmk5KWkhMIs2q7vcFFlPx0I
	 PpHz6zyVsUrdMsL2A6HIiO5CjDlZlDZ7P/fFywA4OMAqNXha1+vZ3Efzz2KcM7UBrdMY6
	 d2ESJyxVxaTemeq83CjTSVCC1wx2acxaTz/yasCg1bsriLYlu7VPqxwPu3YGFXbWbCLkr
	 kmXFEP5o151Yra95MVcY6EqLwGqfjyUTHg5vkEbRPmeFyLLLrVZkbSh339Aj9N9+rfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050178;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z0N7N6dIuN+95qhg0Dla0jZHAD5R7S2EyoBPJ8IAC3Q=;
	b=rNmTwtCJ3PY+GVJzvVXYQU4aFBvC+jllDhfQcu+sCqx6oSwSLIAhwtXFiyiNRt1bBXPP
	 smTWgBFx9tCbsfOXhZtooYW8KP+WWTW5HMjuc2wP+Q8WUhMdQoclZy0q91/E/BcXnqmI+
	 Og6OsQ250CyV9RJnZwv3jLtU+Gs6M7EotjjR+FWv4yOw4yvWiWxntByKAnca/dNUFSFmv
	 g44NixVS+d4des9ED6jeSn9SQHAIpeWf2OSRMUJh+7vouzEqMMUNbF+0SoRw0YGIshezl
	 7GgFtIeF/2RTrU6qd7SbbAcorr4oCZHLqdCtm5NESgq1TlL/rbU302ifWaF6NgUn2qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVa6Axdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVa6Axdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADB71F0089F;
	Sat,  7 Nov 2026 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050177;
	bh=Z0N7N6dIuN+95qhg0Dla0jZHAD5R7S2EyoBPJ8IAC3Q=;
	h=From:To:Cc:Subject:Date;
	b=MVa6Axdfd7QBe2JCnCW/STbWawsxuBigVC0NjrEOry83z4POBWLvj45UXug/WeJ2S
	 xTuKCaY7ypbC9s4UQEMnVXOMwhjNbBEYzXYYLXagRg0xXvnR8NHTKenZwbSzpl6ENc
	 +gX0FQ2+Jl+gSp9w15//4ia1lpmOurIDf6kmjlJ4z9Gh3u2uIZ8UIgsv735lbz+2rr
	 A7SEj0ktRSWKHgbrG3nX1qTkzfgZCGCIoTk6Lko0KX2Sz2Y0mly3hf/eKbvOAbc2rW
	 ILleVzL0BOkdsI17t5VVQiqesup4oPDarQPqB7n4OAOwywYdkUM760R/Ez4IUT8VFt
	 sHOqRZJe8iE6g==
From: Sasha Levin <sashal@kernel.org>
To: jean-baptiste.maneyrol@tdk.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: force accel odr change when switching power mode" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:16 -0500
Message-ID: <20261107061615-failed-5.10-d52047d84963@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d52047d84963e5cf7c8ad502e0adf003fb0669de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061615-failed-5.10-d52047d84963@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




