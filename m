Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894D49E145;
	Fri, 25 Sep 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341252; cv=none; b=PIb+1gDceZW7Ezis/5banY86uCcovoHX+bxLHiGKQm/lif5rMmoMdtHS7MRqQ5Gh0FPmy/VWuUrv+4OD1VstRe2+ulh2izhDvcgqoXKsQdgfs3ebBZtgeDldG1Ook+kXGvaSgSS2csXfMO8MGcmz2ZuWmkv/84Rr+V6PzegpTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341252; c=relaxed/simple;
	bh=+nsd19O0IGxNaWLL7pTlfjT5jDNXR6MQWz0WmqGua68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C06FwT6nyFwADodQOr7A2o+6LjtFd+o+xRmBWuzYKUBW0+kzRB+1S/cq4MBZUJ85JyF9swq6H6kdmsc4fi10pV66Ygu0CUQ0+Rh52qlj4PpqupP0kiLKxRsTcvvMrjIuUk4IOgNPqOcJcv+sWfGs8+HXoGwHRBg1EQhuUtASYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q8AkbQho; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q8AkbQho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LV
	3bkyLz81TkY90a89eHH4W25TChOkupguJavIs8Sus=; b=Q8AkbQhodop8tOwmx1
	ztwl99PfwMerd2sNU4zAWNIHgK11z+7WhOlxwNMJsbua0bWY1eb9azzhidcgYfwa
	QLGgqnPbDRdoW/qUyUjLKsRg0IteisZ1OVbpEN5AL/SBaRMN2UCfIC2dyfHB8qou
	wBwEX/RUV2kiFydK01xrVgiLY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S8;
	Fri, 25 Sep 2026 20:58:05 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/9] iio: adc: ti-adc128s052: validate SPI match data
Date: Fri, 25 Sep 2026 20:57:44 +0800
Message-Id: <20260925125754.2162337-7-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15Gw4rArW3ZFWDCF48JFb_yoW8Ww1kpF
	WDWFy5ury7WF9xKF48W34jkFy5Ga1Yyw1Fga4kW3Z09w4rZrWFvryrK3Wftw1YkFZ3u3Wj
	qFWxZr18WF1xZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRa0P-UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR1blWq2b92bXgAA31

SPI driver_override allows a device to bind to this driver without
matching either the firmware tables or SPI device ID table. In that
case, spi_get_device_match_data() returns NULL.

adc128_probe() also obtains the IIO device name by dereferencing the
result of spi_get_device_id(), which is NULL on the same override path.
The probe can therefore crash before it reaches the match data access.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data and use the always available SPI
modalias for the IIO device name.

Fixes: d5f0da0c6972 ("iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/ti-adc128s052.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 1899813c1aee..f9a995ff403e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -195,12 +195,14 @@ static int adc128_probe(struct spi_device *spi)
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	config = spi_get_device_match_data(spi);
+	if (!config)
+		return -ENODATA;
+
+	indio_dev->name = spi->modalias;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc128_info;
 
-	config = spi_get_device_match_data(spi);
-
 	indio_dev->channels = config->channels;
 	indio_dev->num_channels = config->num_channels;
 
-- 
2.34.1

