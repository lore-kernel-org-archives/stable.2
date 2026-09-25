Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60049C4D8;
	Fri, 25 Sep 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340262; cv=none; b=Xlz2BfMCY5QsBCc4TY4XGO3JuBzKrW4Thp1HdazdFp+2H7wpBvFAvdaAdu/cHy9G2sY59PEzNkabd5QjJsix67ojuEWT/i6NUFjB9WV1NpG2/gKn2noiZ0S4G/CYwGbvBCMdb9lNpQGmwMKpcnfOYIUGVKfsTLACe56D6TI0aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340262; c=relaxed/simple;
	bh=+G+ofJVzMofLSfEH3ebb+vcMWH1OiBm1lDo+9TXzigk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XW/gGnB5xtarMO/B9VTqvaiRi6c4ZaeKE3l0qgDqR0YeU5DDgjETySg9qArPBFSlZUus9j/KXLXmuRxzUrTxBEIkhCVRT44CWshDMQZz/lNnyw7QXBQF4nk94E98cNpETlw4WKLvEY1Vo/Q8HwSE+uvkQEeIZcmO5efeXVBorac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P6vk3v08; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P6vk3v08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Td
	ETXxCT+5MKSGr3pbsPvmVhPAjTDZA0JKEQFMPnYak=; b=P6vk3v08RlckleJ+p1
	S3Pn4jjt5PakS7Lf51cYHcam2IfAU/YBf7uqj86MX2kd0zo5NmFaUgJLGLwBA3ye
	aGHSgUZ/UhCmB2l6JhLsrA5SX74DbbAqA/4EtwzHWAyzmoB0J+MBiaeFu5bc1K7A
	B/ydfjMS0Air1CEhKtsoTjbgo=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3l8p2bLZqMEjpBA--.27791S6;
	Fri, 25 Sep 2026 20:43:41 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] iio: accel: sca3000: reject devices without match data
Date: Fri, 25 Sep 2026 20:43:31 +0800
Message-Id: <20260925124332.2090895-5-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgC3l8p2bLZqMEjpBA--.27791S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw15uF1kGw43Kr1DGF1fXrb_yoW8JF47pF
	ZrKF90kryfXF4xGr4DW34UZFy5uws8C3WrK3W8KwnY9rWrCFyYvrySga4rtr18KayrC340
	qFnrCF4UWa1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEiSdLUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x2CvGq2bH3jFQAA33

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

sca3000_probe() immediately dereferences the returned chip information
to set the IIO device name and channel layout, causing a NULL pointer
dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the chip information.

Fixes: d6ae9f202f61 ("iio: sca3000: simplify with spi_get_device_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/accel/sca3000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index a92a563f6a4b..0d5ed244a663 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1462,6 +1462,8 @@ static int sca3000_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->lock);
 	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODATA;
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &sca3000_info;
-- 
2.34.1

