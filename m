Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355630F540;
	Tue, 18 Aug 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063309; cv=none; b=WZS4cS27kDXiqMr2deeGojNs4EG9X1Rau5sJf+oc9z2quc2BioIxdBatZbytmh92c5lalqfHaPAhMKTfZ+6QICqPgy+ZwH1eg0sPTHLM4JRwc+uWNNyEgBLVPC9Vu4QxO5tHWP3ih82c72Id79WCexb79FW6PEdYESrL+/HD66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063309; c=relaxed/simple;
	bh=BmJMDvIB5tZvlWW3RPhRyMRf5zBfwAa7UO+xuPD2i+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=blYwXCz1GbAbS11F0WiI1kR/q21+1ThicaLJtC9PpzzXj5hiW1b92UAmUGuETnd26MoDew7cfSRQ2UXC0ABbuNN1Sh9p0FpkyUS0HxVjupSisi6tprG0mXQS7okULTsnYTZeLwuBIeYzRP/EiQRnCltIUorXHE1c4/2PU6uONuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SI1eXrur; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SI1eXrur"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a6e04b0d;
	Tue, 18 Aug 2026 22:28:17 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] iio: admv1013: initialize callback mutex before registering notifier
Date: Tue, 18 Aug 2026 22:28:11 +0800
Message-Id: <20260818142811.2264343-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01545e65103a1kunmda569f1e1140f2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU9LVhpPGE9IGk5DQhoaH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SI1eXrurPfUxEb4nvj5ytcIYZWSHfzTHJG+o5/2Pn0M5ZajzC/LQAqOBAK3e0culp+DmLWSh2WM23vKUuetu/bPq8Sn5x2uHAR5MudqdkUhLpdo1tY2cyIANN0xj0YURjj0RFm1T0r/ZDvKBCnwpDAxBUn4CArr01zOcC+gzUAw=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=7Q9kKJLvsmdB2XcgcCutx5ITfkGMgdUqIVLVh9TwIaI=;
	h=date:mime-version:subject:message-id:from;

admv1013_probe() registers a clock notifier whose callback takes
st->lock on POST_RATE_CHANGE. Initialize the mutex before
devm_clk_notifier_register() so the callback cannot observe an
uninitialized lock during probe.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iio/frequency/admv1013.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index d8e8d541990f..932f094f2b04 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -594,12 +594,12 @@ static int admv1013_probe(struct spi_device *spi)
 				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
+	mutex_init(&st->lock);
+
 	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
 	if (ret)
 		return ret;
 
-	mutex_init(&st->lock);
-
 	ret = admv1013_init(st, vcm_uv);
 	if (ret) {
 		dev_err(&spi->dev, "admv1013 init failed\n");
-- 
2.34.1
