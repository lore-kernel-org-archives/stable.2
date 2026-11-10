Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313050;
	b=YhbNhez7hybaQCyYkEHEJKT1SCL82Bys9UoZVgAcMVIfx7mmdpJOpy8wAYESkvkZFBcC
	 P89Ys2gDoQ4GEoClybDeEnsojEbvFBXV67f4oIiLbYkNyy5zpSFmUGelaLNtndk+Q68PB
	 Wc92zP7imi2kBx85QBeJ7PGL4/cLhqU2gBC00BpIJN3xhIoOSKxFd8CGme4uarOKYEag0
	 o7+t+qjfI9HLv0+kdukTcXa/TtvR/aB1OZRUSkVck+SujJDThugHOs4KXolPOYjeHK+kx
	 SkhlnbI8DT59BrcFFJ9EbR5IVXVI7HRahRhKPVUYIzZ357yPUhRFb4LgbRNuKGf3qUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WBxQQnWqn8xpSa4uWOtz9x2P6f57tQ3RLc9we7BAdhQ=;
	b=RgqZS+CV7HFGzsBqBsYsjKJNSOJkeymiSxRf0keXYXeYnLbvKjuT3MUVm5r/8yWOvxsw
	 oh18zlkQcn2opGMrg2caDy/LVbJ/zbSP2Oa397GaL0PmGFR/qqSRKzPSG7cFFNm+DQFBn
	 k1MVZaObA9MYPeYhoPuEMKBkoXrdh6n+AqUR8FxPrYWXAbr9ZEwfEmUEtIy4vowb1F4m6
	 WtVwII7dhSzZ6LjBWDZMZUtc+3pMbvreyGIENgABhpxN878HS/lxNPII8hMqYsHBmzebC
	 H7mS3lhwDCRhTSBGsKmlmjwBJAfPe2ZudbLHJAchcVV7QIS16cIFO63r40+Eq9NNh1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NK3I2VcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NK3I2VcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712B61F008A1;
	Tue, 10 Nov 2026 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313050;
	bh=WBxQQnWqn8xpSa4uWOtz9x2P6f57tQ3RLc9we7BAdhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NK3I2VcYSOogF1sbryB8LOlzpj8g+JzVGZ2W2GZO0fj1ppGx+9XHegrSO78MR5rRL
	 COZmYhKfC9h/TFaEeTIIwpNTK3kF+zTj0Mr3Qcs4OYTcI/QXY7b54LZNRED4Ywqv8s
	 wc4HS9pAXETeQPi1ozKatTjCwZSFkKbrKsuxeZPAl85Jb1p+ZgM8gcVM67TnoX5dnn
	 0fqqeBmNXwZpZU950+nMJzrw31+m9l8/pbTa4hnTi/D6bbYFlbavFGPrhEfWRCv9vw
	 /kQqwfGPrFeeqxf/f9Yk85kszloSfZOQtW7WppveGZWNhLQeIA6TXTI7zlhv9OEKtC
	 fU/GptqSaPewQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
Date: Tue, 10 Nov 2026 07:17:27 -0500
Message-ID: <20261110121716.1065395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051802-failed-6.12-7f7a119a370e@kernel.org>
References: <20261107051802-failed-6.12-7f7a119a370e@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0309e66abea141f3ec339b064b8f8b8003d2a634 ]

This reverts commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8.

The added code is currently a dead code. Moreover, the driver is not
designed to have any defaults effectively making driver data a mandatory
information to work with. Taking all together, revert unneeded change.

Discussion at #1 concluded in agreeing a new policy on this for IIO.

Link: https://lore.kernel.org/linux-iio/20260217080514.1288115-1-andriy.shevchenko@linux.intel.com/ #1
Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 7f7a119a370e ("iio: adc: ad7192: reject devices without match data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 6fe32f866765b..02328b9115756 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1394,9 +1394,6 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
-	if (!st->chip_info)
-		return -ENODEV;
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.53.0

