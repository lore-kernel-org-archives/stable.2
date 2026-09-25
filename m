Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCF49CF4C;
	Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341113; cv=none; b=bqhWhY9iIVaTT4dXvyonecXKXVawe/96xmFoYqyM6ww9aRUK3ctJjuF0ipjeJa6cCET1TfDjg/2DGwC3zD8qmzREy4BigdadcTSohih92Fb4VsPWiqx3PwJA7R1jwyDvC4ZsniNfGmEj6oN6mqey773O2gVMxlWz0MfHRKdWLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341113; c=relaxed/simple;
	bh=20nZlJlRZ+hM/V20z5sQNKLaQ/NqV629aP1OLakwxCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3BIUL7bAubA1zYEafJmwgNCmJkd5vTNBh97EYpYb4LsfGzeOC9s6M5S/94/UpeJCnn9aR8o+CgQCyfS2nK8WuG3FlNotssi6C++xEaMFU5/igCC+KIEnifYyZ0WUIoFquGT819TknCdrWHn9NAtQ4RPdi8/1xGqh7DBQ4QVK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qKb0FX7K; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qKb0FX7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1Z
	HdYK2PD/eG616NMBDURw4a3sncC0H/ADrARb5zQUw=; b=qKb0FX7K4HaDacAGmU
	5rmdU3Y1MG+ls/JNm4FKoR4krn7rYGNqmiQzucfrqX8QB6im3aHbXm3JFSAABWB0
	r2+SilFccGog6mtgmYHJF2k1b8Mo44J7h5BDNb79z88TjG/GAkdhwNXPQrLZQI9+
	hiWk9xCbUwWU23JkEq5Y+RiIY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S4;
	Fri, 25 Sep 2026 20:58:00 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guillaume Stols <gstols@baylibre.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/9] iio: adc: ad7606: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:40 +0800
Message-Id: <20260925125754.2162337-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1xXF1fXFWfur4kJFb_yoW8Xr1xpF
	sYgFyFkrW8GF4Uuw1kJryqyFyakrs8Gw4Yg3WUKasru3y5AFyUWr4Igasakr1ftFWrJas8
	tFy7Jr1rWFyDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKNt7tUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xlalGq2b9kfaAAA3l

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ad7606_spi_probe() dereferences the returned bus information to pass
the chip information and bus operations to the core, causing a NULL
pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before entering the core.

Fixes: bc69e9fffde4 ("iio: adc: ad7606: Add compatibility to fw_nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/ad7606_spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 1ebdfb8580ab..8c479fa50a23 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -456,7 +456,11 @@ static const struct ad7606_bus_info ad7616_bus_info = {
 
 static int ad7606_spi_probe(struct spi_device *spi)
 {
-	const struct ad7606_bus_info *bus_info = spi_get_device_match_data(spi);
+	const struct ad7606_bus_info *bus_info;
+
+	bus_info = spi_get_device_match_data(spi);
+	if (!bus_info)
+		return -ENODATA;
 
 	return ad7606_probe(&spi->dev, spi->irq, NULL,
 			    bus_info->chip_info, bus_info->bops);
-- 
2.34.1

