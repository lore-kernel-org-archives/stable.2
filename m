Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FF36495F;
	Fri, 25 Sep 2026 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341108; cv=none; b=NEd3vQvSqsEd0DwvZcjQAGzWi7HqD9oqQ+0N5tnEnezBagMRnh+WNYu3vm5ANu0Uw6ApYPG9HixM/yDRdmql/rgEFQ+/zSmQIL8tls3uzDnEx8sQ8UpnNJ1aTbPsKKMLaRQGmeocAfkX4AKrdwWUC6u5Xmm7KEL0SnEag/7ZmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341108; c=relaxed/simple;
	bh=JDAQJyiC7YeCYZHCyezL/VjzYHBQbtFEYhZXzW2D1/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmF5FgtKtlnQjO6BLxNV6DQY1V4gMzJrTYfi2JhREwrW1//mMhVzfRanc3fTDUGy0gzUGYD2OpBBY7igoSwe/uk0YCZ/o4wvwqkxcYx1asIsHhhqAg/BYeApqtTbflnd5RDGT/lmNVO5L9nhr4eNBEI0npXg/QOeM4hQmpz2ShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sqz+VnK1; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sqz+VnK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hr
	var9ms2CLILUqPU2E68sQCBkXDl1Ad+NmZigrC4Mg=; b=Sqz+VnK12mXLS/3/1J
	BoGDM0hZudXYbYcX3Z2IfwjxGDqLxjDu5ovfwi7MLR/AhBNZG9f3uTyC1t1VADcw
	1dOkLgTlVazcPU6GAfdi2/c63+otumEz1IMScARm1glooAhd5HxVSbkxq/AOvMM6
	Xj9cqlHX06kC0EbFOVN6ymmfc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S3;
	Fri, 25 Sep 2026 20:57:59 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/9] iio: adc: ad7192: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:39 +0800
Message-Id: <20260925125754.2162337-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF4rWrWDKFykArWrZrb_yoW8Gr1xpF
	WjkF9Y9rWUGF1xGr4DGa4UCFy5uF13C3yrKFykuasa9ryFkr1UZryIga4Sqr1rKFWFka4D
	trW7tr18W3WkCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1CJLUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhdZk2q2b9ev9QAA3t

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
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d8f5886fcf69..8bd810546311 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1406,6 +1406,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.34.1

