Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313378;
	b=3q4gwPdc6jo/22HAqTbcKkLKrsbcWc7c/9jc+Z8EqwDxlCrfEU6eEWk2xdJc/lp9Sldi
	 x3EUefRBomcCyHWEPb5L9Zv4Ej/EUE6goDe2ZljTNvlwNrkYEi5i3+d9h7BIShK2srbja
	 Gb+3B/U13ENgMF0P66n277ERWscrGteHttQtUjgva/zTBA6V5ltXvO9KwCmnPKms1kLvN
	 UZqZm6A7DMoYPe6Xy4tTTWcyHc7DSKxvesmlT8J1D+ILMZMKdA/+aeYBwa3n86Hr95iQs
	 vVBDFYsN9L6UCU9CMJJzlhfMp6dYCjyuFSdHe/zp6n81eb+39bneWyq9DX8I0I9CYcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PnxRg/+kMILYpdFo9Wpw2TXAaNajKc7Fs90y2D/DHiM=;
	b=muHDS9Kw7k4FMdXQdptCBbqDCLjMgP3vCcqtuh0HMqDoSWlx02PUlOh7Hy6GGeCRIql0
	 t8NgzLIISNlc3ve1QNuOPOHWpxQgJYk+6lfW0l4HmU2lUgmBm5scRARX7LAQ4gdTph7Ro
	 U+QNp2Ce0NQwq6vBPMTT1l8ToWhgfv61o7Aio/wDuDXucdFnVhE9JPhtClR56btGOQBQ2
	 3VFGK5BQLRNQ4egoKAeShYsD6SviiKu9C/APHdOF9SW0Yx8GU56wCy2KejPbsTS1b9M/J
	 acwk+qdIcuKKH5RgZ/pCybULIE0ENsCN1EzhKIUmH+q1iF8SDOyNI//wmcVFqKQXpyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLePCMc+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2859606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLePCMc+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3051F008A2;
	Tue, 10 Nov 2026 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313377;
	bh=PnxRg/+kMILYpdFo9Wpw2TXAaNajKc7Fs90y2D/DHiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLePCMc+4MGHCDONN4ejzNQorjN+dFCei4BfvmVjiB+vwYoRd/qaCwo2K4/6Aqfb6
	 J340NxOczpM8qUmBgERvUWBqCkZT2hEb3I6d47EciYgS+HfyQFG+T38e+GhcYYUcjp
	 p1KWIc5d+jCMa3EeAu2W0hluifCczU0272isMd4kL0fk8CTHlVQcoE7ISqwYtYmJ0B
	 P3oBUob5jZitCCk0hhMbNK7I1uzhZSKZbHird2YdX0Q2HCWmYUdxNi4Q0mmkj1nyBu
	 rjqpNjk7vm/C/mPx23afGejVWFZNZ9IirUTA60gL6ZRcPVAu4OgpVSt4V5avf45+1u
	 86Zfs8CCrwisg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: adc: ad7192: reject devices without match data
Date: Tue, 10 Nov 2026 07:22:55 -0500
Message-ID: <20261110122248.1149789-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122248.1149789-1-sashal@kernel.org>
References: <20261107053031-failed-6.6-7f7a119a370e@kernel.org>
 <20261110122248.1149789-1-sashal@kernel.org>
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

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3 ]

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ad7192_probe() immediately dereferences the returned chip information
to initialize the IIO device, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the chip information.

Fixes: c3708c829a06 ("iio: adc: ad7192: Convert from of specific to fwnode property handling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index ecaf87af539b0..63aa6008e9cc1 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1039,6 +1039,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret / 1000;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.53.0

