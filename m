Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2249E128;
	Fri, 25 Sep 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341111; cv=none; b=q+1xXnQFhxUKvJNK/TZvSyI3rsxe3lg9rZdngZi/F0/53I+xBAu+Jfa9wbwMLPx4smTv0qgEeO1wLJqtylFJ9ry2Ov1bPYzCqbnhr4dKxkUJPVTIMi9o7opxC8bzrAhDYzSQI1qQSQKixiy4qeK/DtwOlRHtL0PqgAwjZ0drmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341111; c=relaxed/simple;
	bh=O76mNZ2wkvNEqIG1GzgONVOSWQLTBNeqNB7hToscR9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQdiEwPVpiZlgCI/WtdMDQD4/fmifZlpWuMjMiyhG6Wj/hlkyDWguvlP/RUiU1Onx2PnS3A7Gzci8SbFO51O562Tyk3W4hG5Ea9N/i43tPwHgsRalsE4xrAU6cC6ZEwopv9MchC5SwoxeBsYnS5U2bAxLNmt4fA6z+Tm9NXy8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mp1dZJEr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mp1dZJEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4Q
	qz2/0CCP9m1HgUWpanFEn4lYQPD/5TUZ3jIsrFpuQ=; b=mp1dZJErQGnhZWxNHX
	HWLOZ/vV54yu+QP/I6DIlSPL80AK6jK5bPYSh4Iv/y2NLMCCrlLhNeSfnm3wdQc5
	2sK6qhR4sJh1Ik4AjCZGyA34u703I6t2kW1+J52HPU9GeY/w4u74YCdLXOZNZi/L
	kecKoL8JVn1TNvGfEAmOu9EaI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S6;
	Fri, 25 Sep 2026 20:58:03 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Ramona Bolboaca <ramona.bolboaca@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/9] iio: adc: max11205: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:42 +0800
Message-Id: <20260925125754.2162337-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125754.2162337-1-yaojiale02@163.com>
References: <20260925125754.2162337-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1xGr43CFy5urW8Crg_yoW8Jw13pF
	WjkF90kry5CF47Gw4DGa4jkFy5J3Z0ya1fKa4Sgw1v9rW5CFyUZryIga4FqryrtFWrCa4q
	yF47Jr1rWas7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEAhL5UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRtalGq2b9ubLwAA3E

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

max11205_probe() immediately dereferences the returned chip information
to set the IIO device name, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the chip information.

Fixes: bf3c855be801 ("iio: adc: max11205: simplify with spi_get_device_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/max11205.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
index 63b6561dcf47..53ac2f4f383e 100644
--- a/drivers/iio/adc/max11205.c
+++ b/drivers/iio/adc/max11205.c
@@ -117,6 +117,8 @@ static int max11205_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
 
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.34.1

