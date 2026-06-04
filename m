Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05928175A9D
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594684; cv=none; b=hFWHxz60GFDr5g5q9bcYDL1ghHfZNxEdase97Mdgu6lpEjKmJEk2KK9IoHuxSFHNYCH9GMElaJOCW6gVBRQV+vQolwuZwuCnSyURNQHqXFg9HjaNuKFAZCw/MI/JJBTGKEaD1ekbtlHBOWgcSi2tIxr43mbjhvGfDzb/5TLUFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594684; c=relaxed/simple;
	bh=DP5QKEa5OTO/GcqTuXAuenvGAc8AfP8+9vDUuNsPL9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnFg/9iKF7fiuo1wKs0tRB4PA06XwV4YdlkijBCljorn8tIQnQRM4S2DSrfaqVl9Xash2v1/new6lwSWDfj+ZHUlQr18sfbsQtho+7bSGGoYSe16rhzHs53OIIMtyPv4JEZI721cZNsuk1DWUnyoKmtzbj+ClLC+m9GO+I2ghgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLyoNHY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLyoNHY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36351F00893;
	Thu,  4 Jun 2026 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594681;
	bh=rspJbaKTGnsIrbiIL5OuUMnojs+SAz55acJ+n0f6BmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JLyoNHY5epluTlJccRxLRv5UCCyQ6uMalipfkm4KUb4JDetP7fiVZ0y3F3tp8ro1P
	 aqxY2W+S2zWAKYPfsianzNUdEZH09RwkYWnmhpRNcExLkXnSocUuCuOGAfct7s1raS
	 KEwtuAJKw6ppwlS9dGtOtQzWyNBB/0owUTpJyYlVs31GdUG9cZfMpdX59gdXwFJQFO
	 qDg5LNpPnNEAiZ2QCZ1YPSEyHqXH/ZR8+bJZadQMbXLt/kWdJ7d9Pd0ZEWTQ+F/heS
	 bbuxpJSqwDW/t/2BYcprsi1ciqfN4tu0nL90Qd/YSjbQ8kI+QosSc4sOhSAJyZuBQO
	 J7q0ayQ0mF7sQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: gyro: adis16260: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 13:37:58 -0400
Message-ID: <20260604173758.25903-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060452-maturing-stimulate-cb92@gregkh>
References: <2026060452-maturing-stimulate-cb92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 761e8b489e6cf166c574034b70637f8a7eadd0ee ]

Add a validation check for the sampling frequency value before using it
as a divisor. A user writing zero to the sampling_frequency sysfs
attribute triggers a division by zero in the kernel.

Fixes: 089a41985c6c ("staging: iio: adis16260 digital gyro driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/gyro/adis16260.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 112d635b7dfd3d..ffa7555ed4b54d 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -288,6 +288,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		adis_dev_lock(adis);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
-- 
2.53.0

