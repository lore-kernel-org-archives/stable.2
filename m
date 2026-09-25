Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781949CF5B;
	Fri, 25 Sep 2026 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341116; cv=none; b=jqm+S5GVSZwaRBeoK/+liPKJN5SETQgpQZBjvMseuQIRqZ2nqOkO/6cw0JpOaawPfLG2yJNr6nYQg4cZSyY4XRWbJL3zVEH+nX16rUvor3VzTytaMYrCXUquganHPyCmk0t0gj9KxtDWcvn/w0d3NwshVRP15Fbwdvt/2dRNLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341116; c=relaxed/simple;
	bh=57tYp0TLSJHxhThmiTeQe+ieqtjqUMGmMlK0c6Kxs/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW2IKyu2/LFYntrEX4neg0aIF9VyP8xXHsS7PaTEViAzaIz57F6Cj9e9DL1p4ANm8FtX/aQqgg3/utGWcwMWbOwac+vtmpXOB5fbp6SdVc7fzwivnYlQJ91CnDkCOdbsV3sydvH+nA1D6FW/S/HQnDaeMHWyRQ/zEBY8BvNZjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GoHebnKA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GoHebnKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W3
	yNEQAsNbhh2UYFgRSQ0VWRs5gb36tIZxYhFCycHZ8=; b=GoHebnKA9nxMEu9LEo
	oFH7t42mcJP57LUJAvb1AO/Fjmc2H4rXurK0uW4v8pMZqXMBgQEbsFLOMUZbZwMc
	FmCN31GFaRGGsz/9xWDzuAlArwKC3EB/GkULOmFkL4JnRYv4BXxBnPSQc4W7d5h6
	7XCai21JmupBKcusNG3ijfwls=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S7;
	Fri, 25 Sep 2026 20:58:04 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/9] iio: adc: mcp3911: reject devices without match data
Date: Fri, 25 Sep 2026 20:57:43 +0800
Message-Id: <20260925125754.2162337-6-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1fWFyDKFyxXFyrWFg_yoW8JF4xpF
	WqgF9IkryDGa1fKF4fGw1UZay5Ka15J34F9FWxK3WF9rW5ArWruryIqasYqr18JFZakrZF
	qryIya48Wwn3uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pECD7fUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BxblWq2b9wnNwAA3d

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

mcp3911_probe() stores the result and later calls through chip->config
and accesses other chip-specific fields, causing a NULL pointer
dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before continuing the probe.

Fixes: 732ad34260d3 ("iio: adc: mcp3911: add support for the whole MCP39xx family")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/adc/mcp3911.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 797424f59f74..90167930f913 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -721,6 +721,8 @@ static int mcp3911_probe(struct spi_device *spi)
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 	adc->chip = spi_get_device_match_data(spi);
+	if (!adc->chip)
+		return -ENODATA;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
-- 
2.34.1

