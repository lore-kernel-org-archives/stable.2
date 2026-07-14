Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DE36C9D0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998293; cv=none; b=T+SKJZiePzMc6c3FfayHzEiR3O4I0uTjuXBcaLYLA9pZ1bCEvllSjunhoS0aUefvY4DElq9WkS2o/qmBsY+e4jGQIn+E4aYfhoZsw/7TrvoUSyB0XAYVfvzPUlCx03OQh4fxGCPkg9fL9y40X+Qv6ACFuR3Wlytxw17vtCcyrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998293; c=relaxed/simple;
	bh=9RbLRQMZql5Lt7z1oh2E2OHkRciPuAclCTf2LORCa54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcsqRhOBFLS/Sx6xAApSi8h5Mlbe+HTuOx0VHsOKG8iyOEs7dKt6JtSV6i9wr7JUscvbnXAZmEAuN82O1OsqXY07bOgb9gdA+m69djaofvgwm00qpT0n1Td4PNUOmT1JjVy5+VJ0+inUdi5xkK/DoStjCtRse4BXQ45ui8T83CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHNt3+9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHNt3+9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB371F00A3D;
	Tue, 14 Jul 2026 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998292;
	bh=LMQs3cc1unC7Dwc7Hww/S3+KHB/9X74jNTlJq0GU+Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EHNt3+9P76kRnMI9gtClKZLSKuOAlJSPECWiIDpZek3gYAVI0SxB2t1ZVlvmq69H9
	 eNnSHIBxHBJWos9AUf9/fS1yzMou9KR4KbG1By/bUpJIu21uOZvuLmwh70oXO6nObK
	 EJ+MQvU0PT30RYLC3J8979X1xLGicfyi8nzGOhPg5CXswebgUZsrKCg8er+ZgHDr7N
	 fT/x9RBWCwPRboFhQIcI+M4J1O2GmXgu71qVtfAvlxj5SN3PumAznfdCNnQYwu2oXp
	 i08Cf3K96ifyo4i3la3MDRCENMuxh+sI4XDTl/0IHXxhLnEhkIO62TEVZGg2LiX3co
	 //JreS4Og5jIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 8/8] iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading
Date: Mon, 13 Jul 2026 23:04:44 -0400
Message-ID: <20260714030444.2382550-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714030444.2382550-1-sashal@kernel.org>
References: <2026071317-litmus-defame-e23c@gregkh>
 <20260714030444.2382550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit affe3f077d7a4eeb25937f5323ff059a54b4712c ]

Timestamps are made by measuring the chip clock using the watermark
interrupts. If we read more than watermark samples as done today, we
are reducing the period between interrupts and distort the time
measurement. Fix that by reading only watermark samples in the
interrupt case.

Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 9 +++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index f05b4d840c5b5c..cb4520b184b01b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -257,6 +257,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 
 	/* compute watermark value in bytes */
 	wm_size = watermark * packet_size;
+	st->fifo.watermark.value = watermark;
 
 	/* changing FIFO watermark requires to turn off watermark interrupt */
 	ret = regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
@@ -476,11 +477,10 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
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
@@ -592,6 +592,7 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 
 	st->fifo.watermark.eff_gyro = 1;
 	st->fifo.watermark.eff_accel = 1;
+	st->fifo.watermark.value = 1;
 
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index 567b0d49baae45..9e77952019e7c3 100644
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
-- 
2.53.0

