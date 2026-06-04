Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586B37997E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599443; cv=none; b=W2USoP3WhTmWtKTc1IJMcty8De16voU0v5N7IMCyCVl3z+Gjco1uwgrtb/b0c1971onvdJTo8axU2rKtkLoumMhT5TZMhZ6xJYprq3SBUJak3phgTJ1uVZIyRUK1Yg9j/MwaRwBSNwsJwdCEHdbKLf3mElOTmbzujo4iOFY6FzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599443; c=relaxed/simple;
	bh=OxLwykBTu8Yd6I47WLYPR1kFp4z+5Tf3ljYPLDgg+ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUawrA/1ZLBBnsZilUznSYS1m40uEaV6r9o0MVzEFS9SX12Me9qAooR0KL4jhgBgjp8xbeYQ6ohsnvon8ZgZRoe1qPWgd1NmyXJ1Bkd6bsFvHGyxRBeYeaOwot/ZRfCbM/SnF9w3QTMrAAULEFn1duhQKsW4h8r51ch8mkSdqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H95Qqktn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H95Qqktn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3907F1F00893;
	Thu,  4 Jun 2026 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780599442;
	bh=tytR7LLD0Fth+qmMp3o7yinfG6Mp8k+aw1Iqv6rof5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H95QqktnsrrBKWHhLGmtZ7T04iqG6+ojv8Mi7k2n6gJ6yD20KRdnGvtSl39lP/Lue
	 S9PQx6VH9HVgVfiwebVVJdvwh42uID/aAYaB8AEZmP1OfPonZGOqfzHhesiG50kUpy
	 SsqphqDCIBaEGEBNOV9oaxO5aDDNUTdt0gSad6g/UpP6gpbs1wudbl4QsquZOMFmK5
	 HuxxIvGJ9jSRQES//39YjpOypKdCDSiWflrLg8BQHMS9ah/DunbfJ66uYtElXcIuFg
	 kCK14ZMAO/fr2OBmOReEL4wOAD+EDOdv2LR+AY5tFm3KQW2d0uODSZNc8SHhBEoDfY
	 rVX/YLnb69RBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: gyro: adis16260: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 14:57:19 -0400
Message-ID: <20260604185720.605937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060452-spectrum-purchase-6074@gregkh>
References: <2026060452-spectrum-purchase-6074@gregkh>
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

