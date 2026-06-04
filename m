Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3C30C17A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600683; cv=none; b=qs9bo28dnRpPg6IFiW1zG/mvBwHqTvJJ5wtVNaMJvtLO55SKuyMsUT3hZFKOynDYea7GolCa4DdPduTYEsfcdgdRGIxiZ6fvWKhN0vE3Y3fcPloMfeY+OV2ZgP5+saeXSByNtJTQNG0d2JOBs8miWs6NA02eEqgXD+NpvYBMW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600683; c=relaxed/simple;
	bh=OxLwykBTu8Yd6I47WLYPR1kFp4z+5Tf3ljYPLDgg+ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trU6TtA1WcW/Vu3H6bNF5cDnSeQT6SNjdTDrf7VFoNfmFVADbQVZR76m+A26PpQLxV8IwH3/GZs2zkM5UzkWPn7gIOzqx4muQkNwW9vYYane1kg/vTAJgqBlZbBbImsVUJn20lvV1jM2AcWcKHYycie7vLTJ6W2E2GEgyq6/oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csEns+un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csEns+un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD9F1F00893;
	Thu,  4 Jun 2026 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600682;
	bh=tytR7LLD0Fth+qmMp3o7yinfG6Mp8k+aw1Iqv6rof5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csEns+unj3DmnjXEHz1zS+zr1dALWXGNCXYsaXKT5I7FUrhgx6SzX069If6AyZ32b
	 T1CLj2VjyazINlsU+6C/y0axrjyzqEa7EynwPs1neDutn8dNkGk1NMBULzieEc/9Qq
	 ktMe2jvKOVHgANh+u6+/uwg4XT/0urepJBaXbFWpydHG0AGZPKg/BvCWYi5hbcMgyO
	 vQ0kuwJv0eHjuY6Stp7X1pTPTbpJz9RuBKuRrQEVQFWbv0aOyZwy3p2Lry4jU/TH2G
	 p4rYj2zTsQhbYSBpYZcDy+yDuNwL2VB/ncy+3AdO2xEcTZ+GnRM1ft3vRDpDCp1sJp
	 QVA4JMFmJLSBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: gyro: adis16260: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 15:17:52 -0400
Message-ID: <20260604191752.743368-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060453-definite-discolor-7a9f@gregkh>
References: <2026060453-definite-discolor-7a9f@gregkh>
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
index eaf57bd339edd5..36130446c82f2d 100644
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

