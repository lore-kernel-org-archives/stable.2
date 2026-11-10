Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313051;
	b=mymV2gnfWw23m4ekwu4x82KEqim/m0iP6rHmfkpokVZrwouSisrWF4i/eyFJQ0ec5uQq
	 ZJ70pCllAfhvbQ/6zMrvwiecSh5tnUOTcBqNkv/RUhH2b+VPvOtOkrnTJGvAVNDbswiIO
	 CBGz+MCAcDQcICNyGVCaE4vkJntjuAUajXJjIlLkmMBqW7/oefs5qPrv/UemsFyABFFCG
	 6G4BzhcXovvE/sCJg+WnpGF2Pi5oWxrK8Uctk6M0zrelwfEgQKFzi+VpktF+9l+8Rjn8y
	 683d0rsEnKb0N0IO/HdX88j6Cnwst9W0FAY5KicH9S4+teAtB+0kYkjG3rjQ4wM6a+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nbFtZ7gOB5j6qiRJZKzp5iNtdAtDCyFMPeRBpkaG3So=;
	b=ofU3gGu5+tn7j+Kjvzx7SZ+F30bgz7w6ufdN3nyDIy/4Wv+FL9Y49rjP8Yips/oyriKK
	 0BUBFOhG4vaUTaOt3kgANiGPLSYqqB9iiSF3fF9NxLe/8A0QEQt13OFjqNc8AxYu1TVaM
	 G5pgvJ3E0bLCy8WxItNpSQp1JNZpUzscia/iAjjeFBjRZrf9Ns/rg1v/KPavM0zJDgfO3
	 p6XYESl6KWDGgHEXZrTO7T75120AwnK7GmLrUpIQBA3q5TMV0YrcXMpK3A5VfbTKQf7tE
	 DRjAy4xmbSYz4okik+s7/pg4tXbEe/ByA2c52Ynhq243GNYMOlYpbCvJVeu09cdPYNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UTi/qhaY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A3606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTi/qhaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0271F008A3;
	Tue, 10 Nov 2026 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313050;
	bh=nbFtZ7gOB5j6qiRJZKzp5iNtdAtDCyFMPeRBpkaG3So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UTi/qhaYq6gstAHDsImEWBvlIuJqpqmwJFzFActFqzmnntTo3ETtvSQH+nBHN4iz2
	 VMzZLlRCnZI4ptUqBs8Z0L2cokGrEDH0l9zZR3ki3mWCRIT5FQ5GZKR+l34uB4AlaP
	 v1XLnLLEnW+1kX8GDiOcxEJPr2FsIMRNxVEDpxX00Aqsw7knPNEq/+04BCG5R73Qd9
	 tKnKaoLRM1EyJ+MrxV3VGghfpnOYEYL592dW3QezrFep0fodB1X+LrjKUB7KyR9hd8
	 /o2ZvtT8notHUjRNpL3QuLKUb1IwFWagq5rn1YJ+YMV5oOxVpmzrzT9n90njhHVFIU
	 z97IPl/DcP5hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: adc: ad7192: reject devices without match data
Date: Tue, 10 Nov 2026 07:17:28 -0500
Message-ID: <20261110121716.1065395-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121716.1065395-1-sashal@kernel.org>
References: <20261107051802-failed-6.12-7f7a119a370e@kernel.org>
 <20261110121716.1065395-1-sashal@kernel.org>
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
index 02328b9115756..ef8268ad353e0 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1394,6 +1394,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.53.0

