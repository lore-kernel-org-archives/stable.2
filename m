Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64075346A14
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967634; cv=none; b=HTvIaaU7MbzV0uPDk2/rj6Y9T51I2m929BSfxbHfnWtI4o6Pa7J52c5xaM1X87+L7qY7qaRUQ3AM5h7Eebu6R7duvu6lFsqS2BKwgQIsE+Zgwe786AUHvBRx4feOeZWjaUndWR6nwc8OB8jQ/PSChY5eHJ3bG8jqCvnHdB9ISGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967634; c=relaxed/simple;
	bh=BPKRsQaNpa8Fun6qebcrPNK8B4XOGggoDwzb2kPAbtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IObDyk8LPQMK88B8ECvdHtfIhZZ/Aog6zmOMUAUbD65EtFY+331OATJydL6OjjYEg8CUq5wVFdh6xYuM/X+lT4XWizhfaOpOrbSLrHV7Wbjs/QU6xdfg7n9rJjQwOjgtp+RkMZRIW49+eiJAAf3SxzGo9JgaIWlVowxWLga3TM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8PcKp2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8PcKp2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8441F00A3E;
	Mon, 13 Jul 2026 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967633;
	bh=FXjD4iuiW1IlUM2sTW6ivr926GCkXQWfFHSAH7s6DBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E8PcKp2OxAycyPZa/p7eEy0oQmZvWogFWUR/yzUjdsHAfsUmNQ71qBGca/LGm55Rz
	 0IYpLzoOwK4F3h19QD+U07VKO8a2n1X+BUmvsa7SlPxkZh2Dv3eJxc+1lGWKJl/Qq3
	 +80d27BmMXGmcrEQRcVaFbGVIL30XS8tUfRpI5wB5IVTG3wA58TuvSih1c93+puXjL
	 yBUxqT7Xt9p1R8KXB8fJ/Evaeb/C6IUYzEIetdKKVzhCFIAkhNswBbW3JhgpNnU21Z
	 6vIMhNnya7wfVf/KtekZWqIULpvYwFQt73WJgo5DYzBVk78s7lrAafSaiT81Nxs+Lt
	 mf4aQLJf15xig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading
Date: Mon, 13 Jul 2026 14:33:48 -0400
Message-ID: <20260713183348.1951183-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713183348.1951183-1-sashal@kernel.org>
References: <2026071317-seventeen-sedate-4f50@gregkh>
 <20260713183348.1951183-1-sashal@kernel.org>
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
index be123c2f41131a..bead30514297f2 100644
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
index ffca4da1e24936..88b8b9f780af3b 100644
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

