Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344B36495F;
	Fri, 25 Sep 2026 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341122; cv=none; b=DITTfeqFhuZVhLou6L+1Jcdtb+Ao8EKJRAVhVV4m1UiHC8BnoNJcr2rGJdhrDn9oO18T52tpZ97QAvCdx4huf5teqXsvbSP7/mJsfSDcK3HBN1u9Fg21Bi3SgDvGlDPzbuasmv9Rrd78cjUuI1S5U7c8XUKCi/w57HAnKF24XGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341122; c=relaxed/simple;
	bh=PMBusrt/X5GxMNlOpUDknGejVzx+Jo2gkbr/UNWtgUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gPmMggFcwSAlHMw8viEhADc3LGtmHGVofWqigT/IYPaH1wx1x+WkfLAsCAY3ywdViXa+FJmSygD/5DeqzV912v3JBJ1+hvDQQNqa9Ft1roU24Z8yz+SDf8HFjvnfJ5HNNtpJh9yf+5qqRJFdQrkeFGQP2iGpGVurQl8uH1jd6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VzOl980M; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VzOl980M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h2
	slgHf/UIdbc3u+1f6E7BNZeF3PWHrBK/2JYeSn2sM=; b=VzOl980M1jmtsyELMm
	w/x0xGrXSGKzTiOnkWWEghLi4qm4Isrf4+Nlje1T7upWiNaSvM2QKFvuPP7wAwlX
	Sp0BYqQ9y2QcGM0Yn3wGSqUf7XaPcqARIF1P5kEZaBXQDWmuVi5gJ79NbHgtzt97
	Go4c7vf+S+GOmylArnq+evAJM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S11;
	Fri, 25 Sep 2026 20:58:13 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 9/9] iio: adc: ti-ads7950: validate SPI match data
Date: Fri, 25 Sep 2026 20:57:47 +0800
Message-Id: <20260925125754.2162337-10-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF17CF43tF1kXF13urg_yoW8XF1UpF
	WDKF909ryUWFnxKa1kuw1qkFWrAFs8tayYgFWxW3Wa9w4rZ34YvryFga43tw15tFWFganF
	qF17Ar1rWF18uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvApnUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AVdl2q2b+Un8AAA3+

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ti_ads7950_probe() also obtains the IIO device name by dereferencing the
result of spi_get_device_id(), which is NULL on the same override path.
The probe can therefore crash before dereferencing the chip information.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data and use the always available SPI
modalias for the IIO device name.

Fixes: ff0843ceb1fb ("iio: adc: ti-ads7950: remove chip_info[]")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/ti-ads7950.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index d27c1f2885fd..0d5708e0b831 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -527,8 +527,10 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -ENODATA;
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = spi->modalias;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = info->channels;
 	indio_dev->num_channels = info->num_channels;
-- 
2.34.1

