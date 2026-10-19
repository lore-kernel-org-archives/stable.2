Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409529992B;
	Mon, 19 Oct 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417057; cv=none; b=d5vjMxE4H4GTQ7Y9Y3NaJkln5TpGP9Nv8zmHrxQ86Ep5ws7erVmdlwItsAPMLJUs53bdknUqCIkBht20KQIccFLOVAcuEFrV8Ok9i8DfEXBjlVVZAjS9RathJuecJXaPm0r3SMWnn5G71Tc7+6czItTg2j1+4Kah3hPPVwXM3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417057; c=relaxed/simple;
	bh=yoDuwaoTWLvDt97OblECL52QxBpB44G9LCtIekhYmag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FTcXCt5uaUFdWgTB2gCN1/QAmdSQWlh9zUedfoyH5v6rTOU1xA8ymn1OxbF0h+bL5uT2mUtZaFp21Igvd4ujbttmQm+FwY+XUW4evZjMXS5tBzEUqImxmr913ztE7ZckaTlPLaQE9j53nFA9QOO8pCvHn85G3dbIgDGFGAr2N7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAoVD4YU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAoVD4YU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAC3CC2BCF4;
	Mon, 19 Oct 2026 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792417056;
	bh=yoDuwaoTWLvDt97OblECL52QxBpB44G9LCtIekhYmag=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BAoVD4YUPJ+RnmRP5Jri3wJBrh5QkILdiPfL9FzrAvzyXJg1fIl+p18QWm4iKlyvw
	 bYapei2/j7LV8A+1C1Y1s7pzTlnqnhEPu9UmVJpemCR2mj+PGHsuFHO7o8qnrEIeG8
	 1O7IBQhNoYy3T65blvT8vrdY1zZMmCURwfEDUPkZeeorEUKP/+Ci5BT3JMRg0uhPXQ
	 niKEkUxuQLJ7dlasIkzaT43p2Ec5PfsNcNRoxIRSlMbYch0xKddynwX/VCnNhEO6D3
	 TQEiBwuaFUTNBVzTSBGa3k5xInHC76XNMgtHykxejFXPKbJCAQx7UKSJkSGApqC9L4
	 yf8OPLi+gCT9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDD9CCF2DE;
	Mon, 19 Oct 2026 13:37:36 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 19 Oct 2026 15:37:33 +0200
Subject: [PATCH v2] iio: imu: inv_icm42600: fix parsing of all FIFO frames
 for odr change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261019-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v2-1-d72a69c327ff@tdk.com>
X-B4-Tracking: v=1; b=H4sIABwd1moC/6WOTQ6CMBBGr0K6dkzbAKIr72FYtGWUUUpNWxoN4
 e4W9AYuX/K+n5kF9ISBnYqZeUwUyI0Z5K5gplfjDYG6zExyWQsuaiByQHYCGhOQsaWsOYcrvcB
 1Hn4RTDjGbIAaBrh6ZTHAoVRHYbRslNQstz895tS2fGm/HCZ9RxPXudXoKUTn39u1JFbv/xdJg
 AAttRZ1o3hViXPsHnvjLGuXZfkAOQ2nmw4BAAA=
X-Change-ID: 20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-74a91cb28a2b
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792417055; l=3281;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=kD1/ng0GS6kPMK14Mq3qWLm6q2zMJ+jIcdvPt6Xp/Vo=;
 b=DAWMDcOLqRRr7iqC6DWTped4J4M9UNqklDYVqXiraMEK1fslvlmpH7O4i+UCorQ2C3UCeS0Cw
 dxi5AoZlxs/CjA0LPxi0W3PhIz2XivYnxoetCD1fkKagTl2fqN8/MlJ
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

For getting all odr change events, we need to parse all FIFO frames
in each iio device. Fix this correctly by sending effectively all
frames to all iio devices.

Previously only batches of frames containing a matching sensor event
were sent to the corresponding iio device.

Fixes: f670d4d34773 ("iio: imu: inv_icm42600: fix odr change not caught in certain cases")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Add blank line and direct return at end of functions.
- Link to v1: https://patch.msgid.link/20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v1-1-b2bb168a0551@tdk.com

To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 24 +++++++++-------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 2bf9fc29d7d2..5bff2a3a44bc 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -532,22 +532,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		ts = &gyro_st->ts;
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
 		ts = &accel_st->ts;
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
@@ -572,20 +570,18 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	if (st->fifo.nb.gyro > 0) {
 		ts = &gyro_st->ts;
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
 		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
 
-	return 0;
+	return inv_icm42600_accel_parse_fifo(st->indio_accel);
 }
 
 int inv_icm42600_buffer_init(struct inv_icm42600_state *st)

---
base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
change-id: 20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-74a91cb28a2b

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


