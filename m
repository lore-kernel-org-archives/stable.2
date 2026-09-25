Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554348C8DC;
	Fri, 25 Sep 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340258; cv=none; b=Prz0leOdj5A7At+FVBgCJZTJFmfcBA/5pw2ttTqIrmpEPYD+6qAY5TBxu0NlEVI/PqGRsQ9TWPBxGAuf7aETSgyJMle++SWib/dm5uFQeH705KW/NU/9WL8T82h1D69b8ORyMZMhMReLFCnq4rNa4AaOY3FwqXI9ypJjF8IjQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340258; c=relaxed/simple;
	bh=RBijhV41TzlK9cIST/77ohsXgZes5kbKi9Dv8jk4nas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7/o4dqZmESGV43XINchK41BsTubwkZbYux608DcJqMnFEfNgzyGpXhgIRdseertqRYQvVkq5HWvvGLNkKcKdQvEZr4VRHaj3uqwsg1ozlbcswGcRZhHJkKcO40sjwpFX4ECXhZJnYBfs8fVkWKb/592NQi0fwFa/EMUuDP35a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jTJ80xc9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jTJ80xc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nd
	EkGXTs/HRnYNfBCufePMLL5D5GM0t3vwd9Mf6u6XA=; b=jTJ80xc9mbZeIk2s3O
	FLiL0IRgwgrZzx2mSMI2pVaCpnDbykusnNrmBskoVxm9nXI6o+ve14KsMeHSVnfM
	bba6mznFVKsoOPHSnpLwfaLNUqTwBVeFzC5NS7oeF3epWpJE3WoNrzoUwpA7Ie8o
	CpT5jeu/8KI1eXQFZUWd2WuEs=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3l8p2bLZqMEjpBA--.27791S3;
	Fri, 25 Sep 2026 20:43:36 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Lucas Stankus <lucas.p.stankus@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] iio: accel: adxl313: reject devices without match data
Date: Fri, 25 Sep 2026 20:43:28 +0800
Message-Id: <20260925124332.2090895-2-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgC3l8p2bLZqMEjpBA--.27791S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF1rWFWfGF4rtr1DZrW5Wrg_yoW8JF13pF
	ZruFyYkr9xJF4kt3y7Ww1jva45Wa1rt3yfK3W8J3Za9r4ruryUJryagas5GFy8tay5AFW2
	va9rXF18W3Wqvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEAwIJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhiBu2q2bHhy3wAA3J

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

adxl313_spi_probe() dereferences chip_data to select the regmap
configuration, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before selecting the configuration.

Fixes: d6e3ee74d16f ("iio: accel: adxl313: simplify with spi_get_device_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/accel/adxl313_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index a61295de104f..0f0da44461f7 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -79,6 +79,8 @@ static int adxl313_spi_probe(struct spi_device *spi)
 		return ret;
 
 	chip_data = spi_get_device_match_data(spi);
+	if (!chip_data)
+		return -ENODATA;
 
 	regmap = devm_regmap_init_spi(spi,
 				      &adxl31x_spi_regmap_config[chip_data->type]);
-- 
2.34.1

