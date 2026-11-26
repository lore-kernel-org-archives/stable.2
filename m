Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712307;
	b=t4tx5ukVhdux+t4ywXU35zFsgJ/x7X2ZQYuwTVRKeB8x6VmlyduTSsB+j/abm0vZpDaM
	 gxrEAiD5DaL44y6FD41TQeFKBdn4YsECk2in3Sg59ap2/4sbYJgyjDO2yaHeKxEW+nQmk
	 9KV4WY4ydi1Ajg+wMjthMd+PK8cQ35bNDlh2nM5fZyDGeELfSLaVMfZeVUShzZw2ZFx3i
	 VXd46oaJkfDYKzb1tjTI/7WJ+tv5hXeq6oMHvOOUk5k7jBn3uOGaDhDmP2PCb5oTgsIDL
	 Kfa4jAWh9qvjYiydtMC0HiJnXcHYFcangh0u26PD24SPamo5t5I/PrYDaFOV/17jX3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712307;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SFkjeMH9cRbO7tleN2+mKlOYaTgd0ZrzzzD7v7mG4FY=;
	b=TzJNkEoJD1HLRv3OjWOQ4TacxbeGN4R5+A41j0MWvcKrvGikXaTr62EYsqaf//hDwjUP
	 N4mdKSUX9uvRo0RxdqBiIe2DcOSHjpQNLKsEf7tK76WaYrmN6IGhS0ew6aaX+GVF2T//X
	 784PXyuYmbzy5if3o7HrZheiwY39yNbzzmjf10nqO03Xm7EOxZYDaIHs99bYYymHocMmA
	 038sotAoL6rv1nZ5PWJ7PkHWbXxUZO5mZRsMJ1t3uKVnjCaWZtSTMXoptM88ql1BMSGPF
	 apu6tZhNQN5GvaYhMnQWUfxqP68lfcQoTTEwFnvkn5XwADazGJsshNkVA4Ht6+2ruWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0VAEDfQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CC606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0VAEDfQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0068F1F000C0;
	Thu, 26 Nov 2026 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712306;
	bh=SFkjeMH9cRbO7tleN2+mKlOYaTgd0ZrzzzD7v7mG4FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P0VAEDfQd+KMAUromVxfCcCMZRhwNFeJFxJzid+Nlsdk6TKzLIuiUYNJ0OFyL0fPD
	 DBvYIi7xJOWa2eJz96y1/JMugVMjQAgg23X9tQ0qkIJgjEeidV/wc0LsX9jhwB1Vzq
	 d4SdTwIiymy3mYkQmSMHvUgCNUwBUBWbvIN9xv3kCyLAvcVGn3Qm2JtJystc+MAixp
	 R6MpLkmMJHVQj7huZcwuvZ5nnc+EhXU8zMYUPT2hxMapZGdJQoboX6JUgRVsIUYb5O
	 l7swYakpa4QqZhst5OWNFR0ZSW9dUt5NO7/6+g0ZFMtPkDNwZ8rYKnnCAO0y2ZeiTY
	 qxayMx9n5VjmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: imu: inv_icm42600: fix parsing of all FIFO frames for odr change
Date: Thu, 26 Nov 2026 11:58:24 -0500
Message-ID: <20261126165818.2674164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-eggbeater-lapdog-fece@gregkh>
References: <2026112558-eggbeater-lapdog-fece@gregkh>
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

