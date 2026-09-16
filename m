Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440E51122B;
	Wed, 16 Sep 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575330; cv=none; b=ajPVgmvqUPY9YMuYUsGHHZ/OTtgFxbcdKCxNPjuCsMAWNDucbHXJSf17RZ6UIgZDv/f5kqgc9lqEgt0swuKUb5zBYxZ2DD0OXxyZQoi2f9xRRqezuIwqSYFHdvfDlUEP2lHMPbu8d5zVYLTnBNh3OKGzYJfnE9tsuIpJWROV4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575330; c=relaxed/simple;
	bh=ElMhvI81mHxcd0OH/PIRl5sxZRu/bgqaqH//V3yOZlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XljZhNL5tj+R6PabW1BbS+6XiuemY1Zelq5WcP5sVEsV3+ruSDx8qd9gtt7i7nXDn+l0bL1nX82a+PPMOy3O+cP/D5DJ3R5Sq8FGXg/bygmrFPRuwA6DyR9Aq3xdog1y4XTvM65CuE6MQwgJxDQNmVWbDP04hFdmZldm0SyTyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zmawKpqmHptCA--.21809S2;
	Thu, 17 Sep 2026 00:15:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michael.Hennerich@analog.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	stefan.popa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: ad7606: Fix trigger reference leak in ad7606_probe()
Date: Wed, 16 Sep 2026 16:14:54 +0000
Message-Id: <20260916161454.2082753-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zmawKpqmHptCA--.21809S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47ZFy7Xw1DGr1fKw1xKrg_yoW8Gr47pF
	s29FWjkrWYyr18AF4DZ3WUCFyjyan3KrWxuayUZasa93y5Zr1Y9F1Yva4Sgr18ZFWUX398
	XFZ3Jry8GFWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIMA2qqok9NWQAAsy

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
devm_request_threaded_irq() or triggered buffer setup fails, probe
returns before the mode is set and the trigger reference leaks. Move
the iio_trigger_get() after those setup steps succeed.

Fixes: cc49bd1652a4 ("staging: iio: adc: ad7606: Add support for threaded irq")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/ad7606.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d9271894f091..2deef474001b 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1638,8 +1638,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		if (ret)
 			return ret;
 
-		indio_dev->trig = iio_trigger_get(st->trig);
-
 		ret = devm_request_threaded_irq(dev, irq, NULL, &ad7606_interrupt,
 						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 						chip_info->name, indio_dev);
@@ -1652,6 +1650,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 						      &ad7606_buffer_ops);
 		if (ret)
 			return ret;
+
+		indio_dev->trig = iio_trigger_get(st->trig);
 	}
 
 	st->write_scale = ad7606_write_scale_hw;
-- 
2.34.1

