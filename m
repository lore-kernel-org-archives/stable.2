Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273735E943
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991797; cv=none; b=Jh1r4aX9jOtq79eooltlTMh8nH9GGnS2AhkU2cV0Tnkn+wPmv8d4qMsOw5J+epbadwxoVI7yaLQUkEe0iGR1GD8yiMe3OGIRjzNc4G+/mTCQvoh6KR53bQiBW/q3bCgB5cQcfX8YZM8128ov6+QdsPnBZt7EomF60wloMNg24Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991797; c=relaxed/simple;
	bh=9RbLRQMZql5Lt7z1oh2E2OHkRciPuAclCTf2LORCa54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb1+6AslCB6zL3IQyLG6VENYQMJm0gjDG7qdZH9Yd2Ap1bqZwp9PMDr5MkZH254RgGtdRMy+tX8IX3ZvPLAv4pLeZpDT1SGk4ez3qH0x8KS2H/FyWSxJYbRQQzuSIaa1vybpc2X+c8Wz0bEvlId1ORxv04b3QQKe9jROSJ4wGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVJzjJzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVJzjJzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5703C1F00A3D;
	Tue, 14 Jul 2026 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991795;
	bh=LMQs3cc1unC7Dwc7Hww/S3+KHB/9X74jNTlJq0GU+Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bVJzjJzBDe0+2KX/eQpW0KExM1t2bEhjreSfzEMWhpPhXwVgX0DN4/EAwmF+oXufG
	 Rx1wM8KHWQFWiN4d4j2x+9Y+cOFlx8i5bYcy6WD27hV1udMmQLU37g5y67oTjogium
	 idjNyjNwqHIwKcZ9zWBADNunodf9fYI3z/RoXSDHRClmqTd8qUt1QGVSTtShEUwaz5
	 taQU08VNOrbzhagUrliIQJBIrSzCQBkgPF2oDdXu1NtuVL82VPb8F5GsjubqWiinuX
	 8UiFTJUiJvXBVyuFFeohZpWuhvzYPAxx3FjpLRkEZGwOGeTbhKDgRQKMwWb8ZIyhei
	 Sy0EzbQFf20EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 8/8] iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading
Date: Mon, 13 Jul 2026 21:16:27 -0400
Message-ID: <20260714011627.2188779-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714011627.2188779-1-sashal@kernel.org>
References: <2026071317-refill-huntress-d0e2@gregkh>
 <20260714011627.2188779-1-sashal@kernel.org>
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

