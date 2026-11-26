Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711369;
	b=0g9XANlF+3oI106XKTQctxD+UCxv7lMVvrcn3G1jECOkYUQswE/jrWegb/H0kXtvjuas
	 2vXM6sGfBRs4F6rgOfoAfaE2VV7krRZVm0iCN4q4mqJd/gcpn1M0yopSqpaNqUknQCl/T
	 EGI0hANsU1bhgl7Iz6ThWf8jofDIMwfEHp5KmIQAqpC33/izfX0XBih3xf/k0r9sxOyw9
	 jgagyLrx9MB62Q2eAZjzwUgXUZfmAFlTBhjQx3TYZ7wni7BAIBL3z0pAagIwkgI+9X46M
	 oxfAOvQwjep6Mp6HQ8tTf7rWfmr4O9yWrPFagL56/OPTp8TxqvUOL9GZIgm+OtpCPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N1C/ljkAXej20vWrd3akV/oIqILEMQS6UkCY6YpWjww=;
	b=Qed+fRmFn8dgZPs0rd7ZyO3Tjn4H0qHV1RynyH4EYnSX5PBI8tqWEWANMWPHZEwU3CrM
	 HBv9fdoRYXT0cLOW4UZq+XIOLpMtwMFJAr4f+3XaCArfCD8dHkBXBnO6Pr1X/KKKxvj4S
	 3T62Vrg7YiYfsQyqlCzRrl5WrzKvTz1Tnh+88SOUMdDtAEoCXhqvkZq0J3B8JNHcbh0WV
	 FG3CWgRJZhAaXQTqhZ9FYxccI2HpVY+TTtdkVzpVRBvIZk/4jOlwWnxEuxZpTJ7KHyJqX
	 tWVpl/KIfh3YIV0QKrNy4IbjTnSlqU/C+mKPzvbUaMsuy3kMjtsVWH5daPxGTlG1O/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C/baKfwP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2EB606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C/baKfwP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8811F000C4;
	Thu, 26 Nov 2026 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711368;
	bh=N1C/ljkAXej20vWrd3akV/oIqILEMQS6UkCY6YpWjww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C/baKfwPOaa/IvuIYrK4PeyTzihI6sTEpvy5mhSfaKtSreCKda00Ui5VduUmZ0WFB
	 A5gpy4cAGgiu8+yj57UOFHGzGATZCYE6znqu39eHgplFdfCcuvN8zGSl+6kgFroPiW
	 fYh5nB2TJ8A/JFsaV3GOn9ur7jV7ZcK1Ft+4At/Gs28zvIl07zzv3bJQ5/h/TnDD0O
	 vE7JM7jajKf/eM7cgJ/aMvSZpJ83SA9ERtFZWTHgafXRJCNuItoRZ2HUQYMVUQj7ve
	 y4he3em983E9wrAlUQLrJXOfs0l7Uic4jro28JCld4AIe6A8utDWYw4SAJc5qTF8FF
	 /5WrMoHgyNT7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: imu: inv_icm42600: fix parsing of all FIFO frames for odr change
Date: Thu, 26 Nov 2026 11:42:46 -0500
Message-ID: <20261126164234.2636557-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-pouch-relatable-b991@gregkh>
References: <2026112557-pouch-relatable-b991@gregkh>
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
index bead30514297f..7bbe392010090 100644
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

