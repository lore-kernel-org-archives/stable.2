Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712600;
	b=aW6JgVvRar/T4+PUzOokz3UsryuqwYTn6DHwHtPfQt8eM/vrPW2TjniwB3uljS7gkX7D
	 rwzchS1TlTddGfUrSyC+BrJMYsB4oJK6xHt64FxTk6Kj0RzBwQn2+9H0qmxVBz4MZz+nD
	 j2v+bagoMQLbyHF7R4BVbL8joua8NvFouQvOmwrR/kRM/JAu3GysQHgx+74SUiP2BsZLO
	 KOfo5/Ermgm9m1InKHsOlgoNaHuoYBBjxkZ3h5j/0mpfE9XtopfxMiK6L90JVc7Fk9DoD
	 6rWtreuYIMd2CSQcmiOrLC5bdU7AdGt4Ry6kLIfg1qjEW658WbBtAk6HOiYKY9+A4EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SFkjeMH9cRbO7tleN2+mKlOYaTgd0ZrzzzD7v7mG4FY=;
	b=pnzerZFRa3MLG8+2quX8EabnGxdh4M4hiX+MSxLFkPf6RTUob6RLgilH0bVSmRgPi+ZA
	 GAqWmtpUG06NnA+rd2TShSx+GJN+77nf+hvyI9K5B17aqcfcpy5CfO74kbKwGRI6EPOz9
	 NZSXFcmxtET7lhV9BpVTH5GYGHSTwVPqaCmvh1v63icjl6k2js64rrhH7SJ9lN+B+p1Rv
	 jvSETq+1aT4sguL+0mnmHf+YCVHLELXe2RcyS+ZAi6bxIHOLBfo0omFFHuaYYl5Ox+3G1
	 Ok0q8kE6D+oBx63IdUZoJ79mVwB+hXtdNKf/fUZTNWqC9Rkger3y+PCL3PeTQSxT/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3yDHaRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BB606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3yDHaRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1531F000C0;
	Thu, 26 Nov 2026 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712599;
	bh=SFkjeMH9cRbO7tleN2+mKlOYaTgd0ZrzzzD7v7mG4FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3yDHaRzxWuebyNJ5yoPVrRtsSjTAzm2iWoKrpQhJFUWg8IeFCDmtzOLPrajROE7p
	 mdwvj2TfB98Z5pXdnxXKJN5JFVKyaB+uuTnfoaTSw7eb1ysFjVrTRNWIGHM7bXlE7S
	 Cm9XumG11JppNrrTAtit9qpRwzMAOJ0gf/RX2wvdHsw+p/atB63ZtoXttwkb/wmj6Z
	 7ppjxjfmngfLPefVj8gkWi0D1oyq87TYaJFG+BUSKEpNCRd8WvxuMrV/aXdJhBewmB
	 YalezZTx02H6hy4rDRcVfTql5VHnSnX8XmZiMArJlMXJguHaRFpjyQJvl4SOetPqnd
	 vHrWcB7X6WnGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: imu: inv_icm42600: fix parsing of all FIFO frames for odr change
Date: Thu, 26 Nov 2026 12:03:18 -0500
Message-ID: <20261126170311.2700790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-churn-itinerary-e5f4@gregkh>
References: <2026112558-churn-itinerary-e5f4@gregkh>
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

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit 4a141623442888458d147f4e61fe47411c0e4e17 ]

For getting all odr change events, we need to parse all FIFO frames
in each iio device. Fix this correctly by sending effectively all
frames to all iio devices.

Previously only batches of frames containing a matching sensor event
were sent to the corresponding iio device.

Fixes: f670d4d34773 ("iio: imu: inv_icm42600: fix odr change not caught in certain cases")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index cb4520b184b01..9bb5fe639955e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -531,22 +531,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		ts = iio_priv(st->indio_gyro);
 		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
 						st->timestamp.gyro);
-		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
-		if (ret)
-			return ret;
 	}
 
+	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+	if (ret)
+		return ret;
+
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
 		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
 						st->timestamp.accel);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
 
-	return 0;
+	return inv_icm42600_accel_parse_fifo(st->indio_accel);
 }
 
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
@@ -569,20 +567,18 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	if (st->fifo.nb.gyro > 0) {
 		ts = iio_priv(st->indio_gyro);
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
-		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
-		if (ret)
-			return ret;
 	}
 
+	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+	if (ret)
+		return ret;
+
 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
 
-	return 0;
+	return inv_icm42600_accel_parse_fifo(st->indio_accel);
 }
 
 int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
-- 
2.53.0

