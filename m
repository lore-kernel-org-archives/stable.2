Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E47525A77;
	Wed, 16 Sep 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575715; cv=none; b=MWQO0RCPv2fRCFsifCBs1ba5InwbO1qBfGRyqcaWN322brUpDSyqWwEsokjaPZaHCyeeVn4GhQV+xtB6DiX/TURpT7YgpAdD920rjQXcchGMI41/gMtgCZoNeHZaL+Tlu/hX2yBFEb6QPLmx4Q3DLa2W9coFte135yrcdZt7b1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575715; c=relaxed/simple;
	bh=X72K8yI4FtHqgPJl+jZS7K3JRhvak6JU+coWihSZ9OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNwv0yZA6tC3GxUu89KwkMw+Qtj5VOBO8f+PEvtiT3LGbafpGKij2lKwNRe+2VbyCzdxG/bxi7yLbsbC6sw/gjzefRqCAjU0OhMcDpqLz7N9Wiqi/Uobf+boNvIR38Cdr5FgK9i8lwc8Pful0qiQ2FlNDDKZq0L5F78bpK+Y9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXgDoWwqpqaJBtCA--.44387S2;
	Thu, 17 Sep 2026 00:21:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	tomislav.denis@avl.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads131e08: Fix trigger reference leak in ads131e08_probe()
Date: Wed, 16 Sep 2026 16:21:14 +0000
Message-Id: <20260916162114.2083166-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXgDoWwqpqaJBtCA--.44387S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryDArWDury5GFWrAFb_yoW8Grykpa
	nagFnIyFyDGr18AF4kZw17Ca4ava15tr48CFW8ZasI93y5ZFyY9r1jvr4Yvw1kAFW0g3y7
	Jr1fAr18CF40vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	UPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2qqpO9HSgABsH

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
devm_iio_triggered_buffer_setup() fails before setting that mode, the
reference acquired for indio_dev->trig leaks. Move the
iio_trigger_get() after the buffer setup succeeds.

Fixes: d935eddd2799 ("iio: adc: Add driver for Texas Instruments ADS131E0x ADC family")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/ti-ads131e08.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index a585621b0bc3..d976214504c3 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -851,8 +851,6 @@ static int ads131e08_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	indio_dev->trig = iio_trigger_get(st->trig);
-
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 		NULL, &ads131e08_trigger_handler, NULL);
 	if (ret) {
@@ -860,6 +858,8 @@ static int ads131e08_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	indio_dev->trig = iio_trigger_get(st->trig);
+
 	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
 	if (!IS_ERR(st->vref_reg)) {
 		ret = regulator_enable(st->vref_reg);
-- 
2.34.1

