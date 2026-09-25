Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978449E5C3;
	Fri, 25 Sep 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341142; cv=none; b=dTxOYmi/hFo/YAttQKRQbv0HXBsX8MfzIrK85tGbHQaK3BJyUDfi7NlnmUJXatL/4uYkS8JKlfmQ30nM1gcIs6YqQTbvylKKEGcAzNRPPwS97/rM1P8QdLvcyyfcXxtOFd6pDlPX+C23D+3M8mHeyICrcaVxGXM8AcTqZV0Ay1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341142; c=relaxed/simple;
	bh=uLpXrdIWIYKze0BCF9SAOKWoGx8qGzV5fV6XnJyN1wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chfXCtsmHx0NVzNkD7u8NgaCg/lc8PhnxlWgG8cudoIdS5DPzH+z/oSZfwTPtcAJzHdlKPnShzBe7q+SXXcYicyB4ObelzxH/6JCW1JF+T4D8NH6jXwgcq8l1ALgMAbvK0iuRreZxRsmEeonQEGRwHTIXDyX5IrE4GBtY3xTMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cmpCH+US; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cmpCH+US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=B7
	bLhgAT/Xf+twxn2tzH5WND84rczf5HIYQ0f/XoAI4=; b=cmpCH+USuYQX0vyA5s
	DxjeuS//UFG9GhTZZCCZhZJXEeI5OiXFsfC/8feOpTVSwaLx1dK8Ete93FEdpZ7Q
	foiJ+y3MeMLpnoRb1NoTMGgF2FZYBEemSE9YjjhnCky/mFHYCwhDEUaPBsboK+yY
	IBBngzp4eaUFCr3cFyBnctGHo=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S10;
	Fri, 25 Sep 2026 20:58:11 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	David Jander <david@protonic.nl>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/9] iio: adc: ti-ads131m02: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:46 +0800
Message-Id: <20260925125754.2162337-9-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF1rWFWfGF4rtw15WrWfXwb_yoW8Jr48pF
	Z09FyYkryUCF42kr4kW3429a45X3Z8Ka1YgF48J3ZY9r45CryqvryUt3Wxt34rJFZYg3Zr
	try7KF109FW8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEb4SfUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQNclmq2b+ObxAAA3L

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ads131m_probe() immediately dereferences the returned configuration to
initialize the IIO device, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the configuration.

Fixes: 4aa91223fd6c ("iio: adc: Add TI ADS131M0x ADC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/ti-ads131m02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads131m02.c b/drivers/iio/adc/ti-ads131m02.c
index 2f8f75c8216b..7ecfb27fd7ef 100644
--- a/drivers/iio/adc/ti-ads131m02.c
+++ b/drivers/iio/adc/ti-ads131m02.c
@@ -897,6 +897,8 @@ static int ads131m_probe(struct spi_device *spi)
 	indio_dev->info = &ads131m_info;
 
 	config = spi_get_device_match_data(spi);
+	if (!config)
+		return -ENODATA;
 
 	priv->config = config;
 	indio_dev->name = config->name;
-- 
2.34.1

