Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A293839B9;
	Fri, 16 Oct 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142896; cv=none; b=ZVxEo4seSI7OZ7dbmpUsU650cYPhfNSzYf18qHn/wkaRW4YiA5nNwsQqnPhVDDmygIp22H9ubNaTWps5YqSzsu/F4LkbdkOZK3olLDag2JrLCMXFEfzLr0+aB1sTvxVNePQec9ZT7eNjOndFljamHGxHZ8+ei0IdrVic8JxfPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142896; c=relaxed/simple;
	bh=O8EzWkRY9GPpWnqvt/d2y63gAUzryhAbls7IYsd4m2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IZP46JjngKsVzNbhyP6v2Z2Bw7yfsksmcWl1vnXuO6Oorl/ZT/qrqHRAusAVkIxWQwvsVO36Xi8cGBk78mTfSU4tkpjh6e7NrpsNqRBM4XAwm9truTi0P82pPyuWrHIc7P/KjBSrPVq/8oR+yQ8pSNK70NSRp/EyIve8p6X7tBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMgp0ldA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMgp0ldA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC5E3C2BCF4;
	Fri, 16 Oct 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792142895;
	bh=O8EzWkRY9GPpWnqvt/d2y63gAUzryhAbls7IYsd4m2I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kMgp0ldA2ljVQLud1NF1X5X9ZBW7oLlrmWkSuC70Ai2Us6L7pjZSHC1zQOi+Sip4O
	 b2vb3eperJeSnT9Xj8wUbcJsShPC+2zZTuZIdNPb0Y/WdEopFlhl9B0U8eyrqpEo7Q
	 3hGrCK61y4ZVEQliBtwD9rS2fBb26bv8NlyLi5teCwCEFgzRnJIQuwLZgeUAt7Sg/Z
	 XizzdmvxFVgHno23V6NfGKS968jhS180KecM+uQ1c08gr498dCldTRWsPFDfFr6O0Z
	 PEK5fyyXzbgYOfezjxbwv8qs5ogOAHVjg+cjZGUFnWsJAS6SoUUzQUVIUpkIDjZfaE
	 1Q9MPJccve5aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB3CC6B38;
	Fri, 16 Oct 2026 09:28:15 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 16 Oct 2026 11:28:10 +0200
Subject: [PATCH] iio: imu: inv_icm42600: fix parsing of all FIFO frames for
 odr change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v1-1-b2bb168a0551@tdk.com>
X-B4-Tracking: v=1; b=H4sIACnu0WoC/y2NywrDIBBFfyXMugMqwT5+pXShZtJOiVo0kUDIv
 3f6WB64554NKhWmCpdug0KNK+ckoA8dhIdLd0IehMEoY7XSFpkzclyQU0MOsTdWKRx5xTwU/Cv
 UKM2yQDdNOBYXqeKxd2cdvDk540HeX4XE+pavtx/XxT8pzJ8c7Psbaa1E+JsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142894; l=2638;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=mthJVu3yvQ/aiwC2gREI5bwnos0GxqzQ3JPuLLO8oCE=;
 b=vspxgMJ4OPyXFjfW8dElWS/AAOjfAwgW/FRtsy3k3YnmXL8F6MR5l911OVHJ0r++GhPxWTur0
 tzVB+lJDn2dCu28xbhsECQPYZGhgxp/A9pZQ8eU+d6SN+UOXQldCOtp
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 2bf9fc29d7d2..f25ddb23975f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -532,20 +532,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
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
 
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
 						st->timestamp.accel);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
+	ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -572,18 +572,18 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
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
 
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
+	ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
+	if (ret)
+		return ret;
 
 	return 0;
 }

---
base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
change-id: 20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-74a91cb28a2b

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


