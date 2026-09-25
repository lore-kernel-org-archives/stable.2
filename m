Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9448F836;
	Fri, 25 Sep 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340255; cv=none; b=jhGP/F6yr/ARdhCwmxZ/gecTdYuqhp5fALaitIMZafaL0J5pcWFBwQ/hM9tPFFcnCGaYnnh8BFONHzeOK6fdxOsCdXhNS4nsGiLwHfLTWeHWJurar5Rb/B3AkTzI94yuQA6/CTYOllz8M2YUtgZiuKSwAPXKFLUqX6XtWNX8Zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340255; c=relaxed/simple;
	bh=KYZJVMlJVqrfjo8bnVDozgWGFCzuHx0/eNlNH2Obn1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTdNgGRo/BUNaf4r0QaObAqohH9lDivf1jgEaXBsTJ3lau/0cmlunbmIHRcrZdpjDNp3ypUz81xosEsHLsAjxtBhBRITUW0kaK9DuXFhKEldpODMSQ9CYRjXCEDVf3cXpa3Oj2UHWdbeL3dMSRoEA58JqleFSniuEB8HEt8gTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VCEfkl+/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VCEfkl+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9y
	ecaw7HXdwQALYRJ85nDXe95I6nFrjvjNkvYy7Mb08=; b=VCEfkl+/v7O181YRgh
	MwkMxwgy8GGZpzPXIjwxFfvvASx46NWEfqsvLdru+21AHm0XSVOzVEGN3fEiop/X
	rtw9vM7wI7xehEd1oiR7pbK90XA6FrbFeHXQNrNXUOZPjFKeKbH78/5i+98wGabh
	RJgFOROjANV9AZf47sPZaiSEQ=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3l8p2bLZqMEjpBA--.27791S4;
	Fri, 25 Sep 2026 20:43:37 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] iio: accel: adxl372: reject devices without match data
Date: Fri, 25 Sep 2026 20:43:29 +0800
Message-Id: <20260925124332.2090895-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925124332.2090895-1-yaojiale02@163.com>
References: <20260925124332.2090895-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3l8p2bLZqMEjpBA--.27791S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1fuw4UZrW5uryfJFb_yoW8JFW7pF
	Z8GFyYkry3WF4DK3yUJr1UAa4Ygr15t34rW3WkW3Za9F4rury8WFyagFyrKryrKFWSkF9F
	qayDZryUWFn5Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pCjg9QUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhqBu2q2bHpy9AAA3i

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

adxl372_spi_probe() passes the result to adxl372_probe(), which
dereferences chip_info to set the IIO device name and capabilities,
causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data in the SPI frontend.

Fixes: 23d742859a2d ("iio: accel: adxl372: introduce chip_info structure")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/accel/adxl372_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 128e148c4e96..d54544d6df6f 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -25,6 +25,8 @@ static int adxl372_spi_probe(struct spi_device *spi)
 	struct regmap *regmap;
 
 	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODATA;
 
 	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
 	if (IS_ERR(regmap))
-- 
2.34.1

