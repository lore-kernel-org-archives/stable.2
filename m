Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A581DDF0;
	Fri, 25 Sep 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340258; cv=none; b=s9GVTP4+K7dGVp1ShFcJQBbUDNVY9NKiUJA3z+NAldioXC7r7lnw8NBg0XrIm1zVSDm8C9byRpS8We+bZesVx+d7PBdTBSdOWdfglNFEOCX3WLIBQWRfxYC50GYSLBZVkwCQqbYCvmEC1B2vqA0dnoWodXk2tuL4+rrxgYgvPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340258; c=relaxed/simple;
	bh=CJFAQOkUzWgF+EC1cZLsrdUiZ0G3WvQSHEIij0xmplc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSyOrOh+OqnK2nAW08ZNYe8Uj+4LgFcSbCPoFUyDwKVT54YL8/wJ/3MyW1O30vN9NKQ2V7LhR5fNpz6001OVP6Szm3SzDva7vMcaY5jI6G/K6BDfVdo8jd5dgZhPzO+dPmnecX4jr8+mjNKGAD2CkpwG4a467TMILN7QTFSMsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oGJdHN66; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oGJdHN66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cn
	SU6GqQIeDCppBz4GkPyo+sahu/qVXUJGMn2TYQqfQ=; b=oGJdHN66e6d0b//37F
	kO6II7/W5g2tQyQjdnNC4m7vlZ4tVhXSn0FFK6eAkq0WZs0dMctoaveZH5PVTRrs
	7qfrgr3pYcJCdgKnS+L9D9dtXWKgyKPlyX8MkAotN9P7ZTiyxGf9P1n3/bJWAQmW
	lejSV+//hyxkygfI0QnP8Kvpc=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3l8p2bLZqMEjpBA--.27791S5;
	Fri, 25 Sep 2026 20:43:39 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] iio: accel: adxl380: reject devices without match data
Date: Fri, 25 Sep 2026 20:43:30 +0800
Message-Id: <20260925124332.2090895-4-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgC3l8p2bLZqMEjpBA--.27791S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF1rWFWfGF4rtF4kAr1kKrg_yoW8JF4rpF
	Z8GFyFkry3Wa1Ut3yUJryjva45Ww4rK3yFg3W8A3WF9rs5Zry5GF1agFyrGry8KFWrJFy2
	y39rXF18W3WDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRY2N_UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xuBu2q2bHvi9gAA3R

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

adxl380_spi_probe() passes the result to adxl380_probe(), which
dereferences chip_info to set the IIO device name and operations,
causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data in the SPI frontend.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/accel/adxl380_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_spi.c
index ae8467f4e6c0..8ffb3a8690a6 100644
--- a/drivers/iio/accel/adxl380_spi.c
+++ b/drivers/iio/accel/adxl380_spi.c
@@ -25,6 +25,8 @@ static int adxl380_spi_probe(struct spi_device *spi)
 	struct regmap *regmap;
 
 	chip_data = spi_get_device_match_data(spi);
+	if (!chip_data)
+		return -ENODATA;
 
 	regmap = devm_regmap_init_spi(spi, &adxl380_spi_regmap_config);
 	if (IS_ERR(regmap))
-- 
2.34.1

