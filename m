Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED331AA9B;
	Tue, 23 Jun 2026 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233078; cv=none; b=NBYnQx+H1/pv1RZhshPPdbxJSbXq0117v11qRzrAztZ5Y1p+L6BQpxwt1bSEYWcjEQtgSGyserefvC6NPHybkhfZezbKNT2KvZzlUcjb7TTrgCmR5uP1siUhhJu7abulUThn+Su6WhoDtzHlkuAeIyOrblmH/UfH7hMVSRrIYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233078; c=relaxed/simple;
	bh=6SAVyQlrsSRNRMeAbGgF+sVjoaioeWif8dG3D2ESsyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LsB11A92YBCnvGxx6tBWYoiW+gJy2b1Be5eZzqL3FDtxspA+T1MrFIDDGt5aFrFEojvUBiGq1UMkXyLq0F/EpFLUvuxPmmwU8lxSfhzuU83Hh1HQtgElf+f5R1bv0sP0WnjSMjpfcEuX68g0CNISYZtO3fTuFiEHQotpmrm1YcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im8D+SzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im8D+SzY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B59ABC2BCC6;
	Tue, 23 Jun 2026 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782233077;
	bh=6SAVyQlrsSRNRMeAbGgF+sVjoaioeWif8dG3D2ESsyQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=im8D+SzY/BfwUaAVrKg/Q3NgN6UH98OWdiA/dopLCnvbZo79hQYr1tM6hOH0FeZLA
	 Cq8lXhqdG98vhgw/4mzzs6a6Or/wVnKvUojYxHz/OldAPI9V64trgGyRm/DP6vmnN4
	 yN7Ct3LXSEO7oHUu6zL6L9nWlKRmWwj1338W3z/0dSgfd/gpqj1lhnZANSykfNN41z
	 v5MllE/6f/+FF+FI68EMT5312I3SMGKqjIISzaDIYQUvm3CAIOA5N5m3uLPwFAtkp6
	 Q78q7snQyWBnUz36PZqm4l40CzzsidkieUMZzTVFzADUK0H1vpCbTLDMysp1O6r8Pn
	 +pHZARZs/3AuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F35CD98F2;
	Tue, 23 Jun 2026 16:44:37 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 23 Jun 2026 18:44:22 +0200
Subject: [PATCH] iio: imu: inv_icm42600: fix timestamping by limiting FIFO
 reading
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-inv-icm42600-fix-watermark-fifo-reading-v1-1-f3f5694a818a@tdk.com>
X-B4-Tracking: v=1; b=H4sIAOW3OmoC/yXN0QrCMAyF4VcZuTZQa63iq8guYpfOKOsknVMYe
 3ejXn5w+M8ClVW4wqlZQHmWKmMxbDcNpCuVnlE6M3jno4t+h1JmlDQEo8Msb3zRxDqQ3k15RGX
 qpPQYfUiU3dEd9gGs9lC29e/p3P5dn5cbp+mbh3X9ACkT4EqLAAAA
X-Change-ID: 20260623-inv-icm42600-fix-watermark-fifo-reading-624caf080754
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782233076; l=6594;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=3ssvSfe95gYTtmZ+Ylkig8dkoYCsEu/3jrM6HnnCLEs=;
 b=C3WPzPI1kzun7KRJUGlHPK1Y/sND95/Y9cpUsm1S8n5dtocdhTWgKyMihRQwP6sH4Tyq+rHxX
 4/BB2mc+8IqBO/1ydz5o/bIfyeh/F7MRpjd4Nnu9KA+xW/CK+hkX1i2
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Timestamps are made by measuring the chip clock using the watermark
interrupts. If we read more than watermark samples as done today, we
are reducing the period between interrupts and distort the period
measurement. Fix that by reading only watermark samples in the
interrupt case.

Better watermark computation using gcd and store watermark value for
FIFO reading.

Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 68 +++++++++-------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  1 +
 2 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 68a395758031..0972294da227 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/gcd.h>
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -182,25 +183,18 @@ static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
  *
  * FIFO watermark threshold is computed based on the required watermark values
  * set for gyro and accel sensors. Since watermark is all about acceptable data
- * latency, use the smallest setting between the 2. It means choosing the
- * smallest latency but this is not as simple as choosing the smallest watermark
- * value. Latency depends on watermark and ODR. It requires several steps:
- * 1) compute gyro and accel latencies and choose the smallest value.
- * 2) adapt the choosen latency so that it is a multiple of both gyro and accel
- *    ones. Otherwise it is possible that you don't meet a requirement. (for
- *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
- *    value of 4 will not meet accel latency requirement because 6 is not a
- *    multiple of 4. You need to use the value 2.)
- * 3) Since all periods are multiple of each others, watermark is computed by
- *    dividing this computed latency by the smallest period, which corresponds
- *    to the FIFO frequency. Beware that this is only true because we are not
- *    using 500Hz frequency which is not a multiple of the others.
+ * latency, we need to use the biggest latency that is able to cope with accel
+ * gyro latencies. Using the shortest period and computing the gcd of the 2
+ * latencies will give the working result.
+ *
+ * Beware this is only working because we are not using the 500Hz frequency,
+ * resulting in FIFO having a fixed period.
  */
 int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 {
 	size_t packet_size, wm_size;
-	unsigned int wm_gyro, wm_accel, watermark;
-	u32 period_gyro, period_accel;
+	unsigned int wm_gyro, wm_accel;
+	u32 period_gyro, period_accel, period;
 	u32 latency_gyro, latency_accel, latency;
 	bool restore;
 	__le16 raw_wm;
@@ -222,32 +216,26 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 		return 0;
 
 	if (latency_gyro == 0) {
-		watermark = wm_accel;
-		st->fifo.watermark.eff_accel = wm_accel;
+		period = period_accel;
+		latency = latency_accel;
 	} else if (latency_accel == 0) {
-		watermark = wm_gyro;
-		st->fifo.watermark.eff_gyro = wm_gyro;
+		period = period_gyro;
+		latency = latency_gyro;
 	} else {
-		/* compute the smallest latency that is a multiple of both */
-		if (latency_gyro <= latency_accel)
-			latency = latency_gyro - (latency_accel % latency_gyro);
-		else
-			latency = latency_accel - (latency_gyro % latency_accel);
-		/* all this works because periods are multiple of each others */
-		watermark = latency / min(period_gyro, period_accel);
-		if (watermark < 1)
-			watermark = 1;
-		/* update effective watermark */
-		st->fifo.watermark.eff_gyro = latency / period_gyro;
-		if (st->fifo.watermark.eff_gyro < 1)
-			st->fifo.watermark.eff_gyro = 1;
-		st->fifo.watermark.eff_accel = latency / period_accel;
-		if (st->fifo.watermark.eff_accel < 1)
-			st->fifo.watermark.eff_accel = 1;
+		/* use the shortest period and the gcd of the latencies */
+		period = min(period_gyro, period_accel);
+		latency = gcd(latency_gyro, latency_accel);
 	}
 
+	/* update effective watemarks */
+	st->fifo.watermark.value = max(latency / period, 1);
+	if (wm_gyro)
+		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
+	if (wm_accel)
+		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
+
 	/* compute watermark value in bytes */
-	wm_size = watermark * packet_size;
+	wm_size = st->fifo.watermark.value * packet_size;
 
 	/* changing FIFO watermark requires to turn off watermark interrupt */
 	ret = regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
@@ -454,11 +442,10 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 	st->fifo.nb.accel = 0;
 	st->fifo.nb.total = 0;
 
-	/* compute maximum FIFO read size */
+	/* compute maximum FIFO read size (watermark for max = 0 interrupt case) */
 	if (max == 0)
-		max_count = sizeof(st->fifo.data);
-	else
-		max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
+		max = st->fifo.watermark.value;
+	max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
 
 	/* read FIFO count value */
 	raw_fifo_count = (__be16 *)st->buffer;
@@ -574,6 +561,7 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 
 	st->fifo.watermark.eff_gyro = 1;
 	st->fifo.watermark.eff_accel = 1;
+	st->fifo.watermark.value = 1;
 
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index ffca4da1e249..88b8b9f780af 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -34,6 +34,7 @@ struct inv_icm42600_fifo {
 		unsigned int accel;
 		unsigned int eff_gyro;
 		unsigned int eff_accel;
+		unsigned int value;
 	} watermark;
 	size_t count;
 	struct {

---
base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
change-id: 20260623-inv-icm42600-fix-watermark-fifo-reading-624caf080754

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


