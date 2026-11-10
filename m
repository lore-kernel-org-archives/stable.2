Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319603;
	b=nZjI13z/XwV1IyeYKibRJrz3lQ6v484CB3LjDfyGscrc5lMX7yq4mUjaLg5OYbporngA
	 Ogbw5ET32sP0ax8RhdMquy5oSNRK1hKW72CX2s5SAGIJE1I2GWVavVCKK7pW+R11Te5fT
	 itNnb4RvTaXUM2kKEWRU4+cAAa9fhJHmx734nQyEr6WOMQnruo87AJWSiUEjRVJ3I4T5s
	 ebTP2QXxPe3FECpweLNbHKj/EgbZiQm+pwjQnYvyGoHjUF7JRJtMUv2ayh9Lf2aMWnxBG
	 KBReszHszgIOdjKEKwjYC7CVNJ5sbQkQOoI9d7lMFV1m4y1MCZoK8y5fluNbPZSELKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mUm1U1mfS3plgfuRtQy4BZXsl/qzEmiEF5YRhDDp1mc=;
	b=lHwYVWM6012Wq7z6pKarL5r/E4xbEvUqPWgvN89wEiVOvPvNg9nlUV8VYieJ28fzTeHy
	 hLXi/FpWh32jugvcUshfIwR/fpFo8rOToVHcish3O/+eAupueHr5yDChn45RA+WGRpjdv
	 Lb251j+ORHXBIOPsU6wbDer0FEMIv1bMS520omGmg84vZ2YCm8gS5PCLgtKiOTXEKnHdn
	 H2j/h37Z6pOMBBUWks4lHEQiMz5gq6HFQr+Wurx7mPnJirfPXL2NejO4zecp39xYOmHKP
	 N+VCaEH4qMmhuez7fvYhVnd8b1U7QN6w0PzjWp/rNMztRN4ufwR5827cflsW6GmZOsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYZ6w9DG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C04606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYZ6w9DG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC07C1F0089F;
	Tue, 10 Nov 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319602;
	bh=mUm1U1mfS3plgfuRtQy4BZXsl/qzEmiEF5YRhDDp1mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYZ6w9DGaKpB/4tNP5dTqexUX2KKzKoOBUEdUUBmHuNuVPFoeUsE/ED39g+3vwwqF
	 71PcMlaIgd1sb4uZ+DkdN9Q39QDGwIrigjm2E4q1BOPttqLXG6BtenFwHjtCqzv2Tf
	 A6Srgupmnd/xhEGn5MHPNUh6m29XwmQJ719WAyVP6C0ZNz+BSDW4ks8uTLjb5TzqQJ
	 UNmvBa/pH6a7dIr2xXsFhT1Hr1+cYQZeZbZHMhQ/3HgH1koVfOW7/hVyr9FbE1Gac9
	 Po++rSLruW+jt9hneX0l4CJUqBAfHlY8SMtJ/Rz/L2UFpnd6geuEArCOG6gKNk/6gk
	 YWUFdynW8kkBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: dac: mcp4821: reject devices without match data
Date: Tue, 10 Nov 2026 09:06:40 -0500
Message-ID: <20261110140617.1821399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050728-failed-6.18-6ac1faf4de61@kernel.org>
References: <20261107050728-failed-6.18-6ac1faf4de61@kernel.org>
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

[ Upstream commit 6ac1faf4de61dcf27ffe8f2c25d96fe5f4b2886d ]

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but mcp4821_probe() dereferences the result while configuring the IIO
device.

Reject devices without match data before using the chip information.

Fixes: cdf3ecb0d8d0 ("iio: dac: driver for MCP4821")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adjusted context due to missing configurable-gain initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/mcp4821.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 748bdca9a964d..daaebf175fedb 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -172,9 +172,13 @@ static const struct iio_info mcp4821_info = {
 
 static int mcp4821_probe(struct spi_device *spi)
 {
+	const struct mcp4821_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct mcp4821_state *state;
-	const struct mcp4821_chip_info *info;
+
+	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -ENODATA;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
 	if (indio_dev == NULL)
@@ -183,7 +187,6 @@ static int mcp4821_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 
-	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.53.0

