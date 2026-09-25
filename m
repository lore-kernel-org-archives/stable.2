Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802449E14F;
	Fri, 25 Sep 2026 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341124; cv=none; b=CxXYaOIuUvBQWxzi1YwrW8QbPyTbYi4oiv5rnJYLVp/Prs6SqDP7W4P3X6GZZ705rP8P6GC2YScWGSNxYrO+nxYxhax62OfEYBoa0lc5Kpk3TXAAGfaHQ4i/zuJ1TnBt/C9cO5eyMZabq+e4ULg4DENaNzWsLDphwAqfw+28FF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341124; c=relaxed/simple;
	bh=9CGBtrww7WUWxjT0SFjocjCsJJDnoFecYtQ5JO3KwQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ld8vnUxNzfC4DUCE/tZ8NbOBP1ZO8zA3UGzP6ax10UzyjdaRPFZYtcRECV2ISgGQbFfBDbIj0WHEgjFJ5mk6lkDkpEkJkkvloMal1ke4WV8rsQ/TW9CYpUH0E7oCJvr/PvMl1+gdqtJMwzdhXo+eO2HIQjk1qxIz0uFrEjvQhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VjuY0rG4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VjuY0rG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nu
	QWnv+JoCbvNrdddh/SY/3Fqj5uWKvpcpIZX5KS3BI=; b=VjuY0rG4PERDOE8qZ6
	t3kKJIiCPYPFmAG/EK0Fhl2BUw7AKto4ZicMyxdJzx+cku3kKlsMrSDmCoRuJubq
	L165JDKOGpSV3XoiYrX8pRpXO8mA4WDdr0yEw2PxgT1y3C6pldFnIAvMzN4f9dX9
	rCYYW1hUUKcxDlvEiroxc+VzY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S5;
	Fri, 25 Sep 2026 20:58:02 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/9] iio: adc: ad7768-1: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:41 +0800
Message-Id: <20260925125754.2162337-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF1rWFWfGF4rKr1xKw18AFb_yoW8JryDpF
	4jqF98Cry5GF4rG3WUA34jkFy5Zan8Kw1Yg3WUGa4S9rs8Ar1UuryFkas5tr1xtFZ5GasF
	yr17Jry8W3W7CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRpalGq2b9qbGAAA3z

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ad7768_probe() later dereferences the returned chip information to
initialize the IIO channels and device name, causing a NULL pointer
dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before continuing the probe.

Fixes: fa087f5babbc ("iio: adc: ad7768-1: introduce chip info for future multidevice support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/ad7768-1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index e9060c1bbe6f..3972821c295a 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1829,6 +1829,9 @@ static int ad7768_probe(struct spi_device *spi)
 	}
 
 	st->chip = spi_get_device_match_data(spi);
+	if (!st->chip)
+		return -ENODATA;
+
 	st->spi = spi;
 
 	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
-- 
2.34.1

