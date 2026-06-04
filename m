Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500E23D2B1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616981; cv=none; b=Qrvhnl5X0F7Hk3koB+sZtpcABovAF/WRIARw8RP456z8yOUn5s9wk8DbFjzUKzsFaUcsH1dBZ2pDiVNaKz40UWuYSHdBDd7KlRt0Ox9EZ8J2s3pFfy9ixgzcdRm54yB2EqzUz6D4RRt7k1V0eY3FhuVtTlsJBJ7AeZj1kNkdAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616981; c=relaxed/simple;
	bh=+whGo6ZIDIz8BUU7OxntGw4icXzKoi3EBmNyNHpp2Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbfDvsn5RddvzvLCd4NH/svtlrCfwMNYReGpG6aAGn2/vhXPf/dI7x6q1qQR4Inq/VFNywr2xrPxcrKfq5y8YG7FZQbVI0KfhnxZFl7ndpHs5djSe7+ESzIqG/Cta+cefyP7QJliAvMbvT6hk3pCKGZeDitMii/StejZ28ekwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kvytv2an; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kvytv2an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5815E1F00893;
	Thu,  4 Jun 2026 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616980;
	bh=XB9gs2JbWkb0blcNCyuEBzv8mSgI+42BYzx60emjoaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kvytv2anteH9riwBUsga+dATzeq4LN6dCKcy9wfYqk+YEzspvxucPZi7w7YAG7tlf
	 3gumoAbagVB3H/66NjoP+wB4BbVpJRpQeO8iZYwLYPqUEu0JQTz6QPUhnw/mRIH1Qw
	 fWac6+2cZzv/6L1N2RmxPwPjdSx65mzIv1iOn9mOW3ZwWRhEUc49Fy2rUW2W1ouLZQ
	 pKeaulEeB861mvFASJfCrdv5iHciyZpXVf0yoQTkprF6E1N3l83wBHRtv59Xzk5jF0
	 DXrXMsXg1Q4od4yuKp90hY/nIl67rKheoEEP/3JndCm9abZoCsQQEuEl2+gAlTGCq2
	 BaOChce5b8pRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: gyro: adis16260: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 19:49:37 -0400
Message-ID: <20260604234937.2471947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060454-applause-magnify-a2fc@gregkh>
References: <2026060454-applause-magnify-a2fc@gregkh>
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
index 1e45d93de5b7ca..27f5ee4148ff30 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -293,6 +293,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		mutex_lock(&adis->state_lock);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
-- 
2.53.0

