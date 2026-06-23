Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E3384CEE;
	Tue, 23 Jun 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224543; cv=none; b=akbaEbkHWAuOngqApOPppl8KX+TvpkqHD+5B0KiwoGEr0gydNyGfaeN4QehbFaeexaNbqR1BTK7uDweXPN4+7FbTXzkf85iwS+e2D3RZF0LTss+JSlP/fPn8Vws7KUvAxwaulb4rXpq02dDpc8E9V+T+XCUSpv6iWsX2iWMvFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224543; c=relaxed/simple;
	bh=Pns2t7isW4RCFxxk1wQn9nVVZeXZt7jt9DQaH295GLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lrs8+D1hD/z9UOT0DV4IMgIFVP549GWrW5mnSgvcEswgnNMJXAD/ACIZGVAziDTq3q1kjA5R/RhV1EGLEC0KmBkchH2fjteLFN4pLHvA5mdsAPtUwz85kO37nkCxWkzgejrKmtQV4fnt2VsRSVESqBnvbxOmVWt7dT/AOgZnvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqynbePo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqynbePo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE97BC2BCB8;
	Tue, 23 Jun 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782224542;
	bh=Pns2t7isW4RCFxxk1wQn9nVVZeXZt7jt9DQaH295GLQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oqynbePo3+Qc+S0WAz4o9dVtuUICGNGmaRDhufmYJIPIGvZsS8sw6Qw+o0hyRpguk
	 eDrWZBX/+74t2PE31Me+uZPjHdFEJvyUhuC8d5MQ15PKWYuEoXTvaWFyJhCUAm/r49
	 xnIzem8cDgCNH6PXTsC7hjs/WiYyXS3utMtXDOeBKlDEteIjnjWyYty8EsKzTsJrou
	 +QEirj/VSn2lZqCV7WxI87u/KMqyvNflj0WrDFMyVkLKXx+OJXY5zd+NwHrmvUf03i
	 Mdt50+x25NmL77NxQi6WI3Po0vhUq711r3QHW6eVx4TxCoEOTu4wnGALPM/fTvv9Xn
	 vjMXPFK6X96cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E486CDB47C;
	Tue, 23 Jun 2026 14:22:22 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 23 Jun 2026 16:22:15 +0200
Subject: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
X-B4-Tracking: v=1; b=H4sIAJaWOmoC/yXNywrCMBCF4Vcps3YgbUqJvoq4iNNRR82FJBah9
 N0ddfnB4T8rVC7CFQ7dCoUXqZKiot91QDcfr4wyq2Eww2SmwaLEBYXCqDR4kTc2CVybDxnpmei
 BWYNpxr3trXXejY4saC0X1vXv6Xj6u77Od6b2zcO2fQBspTfIiwAAAA==
X-Change-ID: 20260623-inv-icm42600-fix-timestamp-clock-period-931338a848c3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782224541; l=2300;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=Pdi02nqbDQa7TGG6wvznAl8hOcvaYmTiUhks6dkcg2U=;
 b=xm8GSodRL9WngRPi2+R0IR6mKTwL9ZUkIpZsxO7Je5OQs03vmaxPnB45pRotaI8WLJR+bWPuS
 Z4vgx1huc2uAHhxa6MmgMmOjwRgItr9xK7WZdUHMYk15a8WOj8v8KY0
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Clock period value is used for computing periods of sampling. There is
no need for it to be higher than the maximum odr, otherwise we are
losing precision in the computation for nothing.

Switch clock period value to maximum odr period (8kHz).

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 4 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 532d5fdffaf8..7df920ef3cf0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1170,10 +1170,10 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	accel_st->filter = INV_ICM42600_FILTER_AVG_16X;
 
 	/*
-	 * clock period is 32kHz (31250ns)
+	 * clock period is 8kHz (125000ns)
 	 * jitter is +/- 2% (20 per mille)
 	 */
-	ts_chip.clock_period = 31250;
+	ts_chip.clock_period = 125000;
 	ts_chip.jitter = 20;
 	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 11339ddf1da3..a18dcac93929 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -755,10 +755,10 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	}
 
 	/*
-	 * clock period is 32kHz (31250ns)
+	 * clock period is 8kHz (125000ns)
 	 * jitter is +/- 2% (20 per mille)
 	 */
-	ts_chip.clock_period = 31250;
+	ts_chip.clock_period = 125000;
 	ts_chip.jitter = 20;
 	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);

---
base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
change-id: 20260623-inv-icm42600-fix-timestamp-clock-period-931338a848c3

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


