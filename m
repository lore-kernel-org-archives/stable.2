Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711871;
	b=ty0iGr9kkCns73H1AYxKmPqanzrjHAsdVVXJHRfdaKJrEsNnqez0aiebmVGy7Rg0HEpf
	 vRPg8BurHb5yQJZzv/en4/sFDSuwA8tPj4qxm/C41cummdlBLWuwxepTq1YpqSWkLAHD8
	 owBCbbStx8WGPkzW7pB2qTPUwTnmPpOgvJMTSi6h7AXgXcjgy2qJhXFY1TmR2M35DV9TB
	 X6UZDh4vWaSCAC/ikA4VUeNj+RuPcmTXsfDyCRuEPMzkDB8HfHwFeLlHSrLdR0+GfbhvP
	 f4dvrEQ2Lp6OPQAq3hCyMHeV8RZ+I/EVpkzitpVB5EeFwpcFHuiYlOTVYjKokQ5I4uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SFkjeMH9cRbO7tleN2+mKlOYaTgd0ZrzzzD7v7mG4FY=;
	b=JvMjjPeq72Yu/c5wA2e3IjBEHiU+e3fsxvKo+rXmBymxG15G/ER4cCVz8dBpIt93wa+F
	 GmCEp5P0GAEhatJC593I2KbjLoQBVSbOW2hw9Kyt0d//+bmwBpKvOqHHZ36vu2FlImnK8
	 ZUDcHdi1Uv1Yks/xtiRRtACUztKZiyI06p6h+Y4aInmK46sFANEl+QdaEeyMn33mD6Rss
	 9vSXit0BvGR+2MozsPCY9OPT/rpjWuLv2cvMRstwIPFM92lTg5SYvAdyA53iAXTEuMrqp
	 EIGM0L1Vbjj6LI3VBw8FBeHm771mayafT35DTDNBl4QI3/A9DxUokEP2wE5cePCLbew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qaj/62OA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2A606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qaj/62OA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B19D1F000D2;
	Thu, 26 Nov 2026 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711871;
	bh=SFkjeMH9cRbO7tleN2+mKlOYaTgd0ZrzzzD7v7mG4FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qaj/62OA+TWgwNf2Eq5X+FB70aQBBDfa/k+n3plHL3ghbTdRPASDxFRLfwGXmwlnh
	 JSpMKw4QHhShzrZ8Jg3HMMV0LG9lPaZBnxNYMTWimp0rFIeeGIzXWcWToL3cglxvFZ
	 j4CyD23tvfTAwxxmurc9w/x6i7ZO4vNDtgott5NepsAgEaXLwK64TegkvxoC7nXSUi
	 23BXuwGby9cqU4iwO+TjC217MWyXwH/YmFgWmKf1e1LGJsEuJ6UVUnVVg1BDvMzSyO
	 hkdVFzVzAhyeeEzFpqvtDGK0i4mLExq32V4tPNxwdxGY+8FAY26oEXd5ZNzFjx+14U
	 zDuF4EY3If12A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: imu: inv_icm42600: fix parsing of all FIFO frames for odr change
Date: Thu, 26 Nov 2026 11:51:09 -0500
Message-ID: <20261126165101.2654005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-lustiness-canning-81fb@gregkh>
References: <2026112557-lustiness-canning-81fb@gregkh>
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

