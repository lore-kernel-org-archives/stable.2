Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222B4B95A7;
	Wed, 16 Sep 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574946; cv=none; b=tp4nSxoKOvLFRb9sLonzu1Dv0pAkvMWnxjqqPG4jFMlCTzfcuLznp6I8CJ3+Nh3gbir4CMLQsu0ByhQuRct+83zcUgJ81GTnrmOCZoNrJAQLk4z5uI8QrUBtlqykP8ZXnTWP2JxkfoxZDGC0QZlpbUn/ECAEwniKQTejGZH1Utw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574946; c=relaxed/simple;
	bh=aOAzLBemtDEVner3olmKp65yEHb839k83EdPnNjDn78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZUULtuNriBDp1P/dEceb3eb0vnb+rxcGhrvjlX+EyEBkf0f7zJ2nBNHHT7C04q3VrRpFrAO7SsbFLuAOemJA2lesK32ipZJRElP2BwEW1h2IO+jHnLnBp7sQrjfjjszlIseE2QIVaFMzmS57s3W6d4aYujuFq9Y9YtUL4/cZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXiEIUv6pqXmRtCA--.21767S2;
	Thu, 17 Sep 2026 00:08:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dan@dlrobertson.com,
	dlechner@baylibre.com,
	jagathjog1996@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: bma400: Fix trigger reference leak in bma400_probe()
Date: Wed, 16 Sep 2026 16:08:25 +0000
Message-Id: <20260916160825.2082355-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXiEIUv6pqXmRtCA--.21767S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1DKry5XFW7Ary3GFWrAFb_yoW8Xr1fpF
	WkCFWYkrW5Cr4kZr4qvF1jkFyUKa13trWxGw48A3ZF9398XrZ0qryYvFWS9w1kCFWUCFWU
	tF95JryruFW09F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUblAp5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2qqpVhAygAAs3

Move indio_dev->trig = iio_trigger_get(data->trig) after the
devm_request_threaded_irq() and triggered buffer setup succeed. If
either fails before INDIO_BUFFER_TRIGGERED is set, the IIO core does
not put the trigger reference in iio_dev_release(), leaking it.

Fixes: ffe0ab6a9698 ("iio: accel: bma400: Add triggered buffer support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/accel/bma400_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 05f72707f830..a5889b67585e 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1783,7 +1783,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
 			return dev_err_probe(data->dev, ret,
 					     "iio trigger register fail\n");
 
-		indio_dev->trig = iio_trigger_get(data->trig);
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						&bma400_interrupt,
 						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -1799,6 +1798,9 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
 		return dev_err_probe(data->dev, ret,
 				     "iio triggered buffer setup failed\n");
 
+	if (irq > 0)
+		indio_dev->trig = iio_trigger_get(data->trig);
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(bma400_probe, "IIO_BMA400");
-- 
2.34.1

