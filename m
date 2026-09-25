Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560249CF5D;
	Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341113; cv=none; b=aitbkWKzqPy6K4y44QZ1qfuOPGoI3wePElBC9ZDyWFz5KuN8DGmf3BURproCGHRJKVlFtJsYs60HYXoJWbiQL6kSBO/vnqXaa1Y5/GVI2/vDl+f6sfy3ghXIvcxfGDW7XwOWZkX8NTxyRFV/iawhfr3VaHtd208JlgPLwcRIy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341113; c=relaxed/simple;
	bh=b4kBdUbyF4UpYDE6btBex/pjn9wQ/sLWnunBIDGuvF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdT5oUUcTSUlKg+vuk20yAgTLm+T/g3wnsd4ZcQlxFPFEGQ42ysNEdB6/oCTML20xo5MoB7jflXhAA9dpA32dTQVO31T/5g5eeJYWeq+CKKMc9L9hnQl51v/JmnprMeyc0W/uctXfXMCFfOa5lKB7HRWgc8I7XaGzWLwtAQr5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Goq6CGjA; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Goq6CGjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ze
	dvJ/b3BoAJml92wS/XbkJSp+pc4GtzqACMYBKMYvU=; b=Goq6CGjAK4cyFgBqNT
	rLP1ojEhmbEOuP1MY2OnWdiOAI9NshYd2yXeKNqeNnpipodtaduwbBQ554cLdl1k
	ceLad0uh5FckFhmvBiqNjb4mAgcFSh5S9HSoFWZqzqvdrNQ8bvxnDRpBFuQ1ksY3
	40NGixjRXQRCyUiqSLH5m2s4k=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S9;
	Fri, 25 Sep 2026 20:58:06 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Kurt Borja <kuurtb@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/9] iio: adc: ti-ads1018: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:45 +0800
Message-Id: <20260925125754.2162337-8-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF4rWrWDKFykuF4rZrb_yoW8XFyxpF
	Z8WF90krWUKF129w48XasrCFy5uF15uw1FgFW0g3Wa9r4rAr1YvF17trySyw1rAFWrua42
	vr1jvr15W3W8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pECJP_UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x9blWq2b98f0AAA3d

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ads1018_spi_probe() immediately dereferences the returned chip
information to initialize the IIO device, causing a NULL pointer
dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before allocating the IIO device.

Fixes: bf0bba486b5b ("iio: adc: Add ti-ads1018 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/ti-ads1018.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
index d9ec4a8d7ce5..8f2d03eee77b 100644
--- a/drivers/iio/adc/ti-ads1018.c
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -624,12 +624,16 @@ static int ads1018_trigger_setup(struct iio_dev *indio_dev)
 
 static int ads1018_spi_probe(struct spi_device *spi)
 {
-	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);
+	const struct ads1018_chip_info *info;
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ads1018 *ads1018;
 	int ret;
 
+	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -ENODATA;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ads1018));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.34.1

