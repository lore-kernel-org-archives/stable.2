Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A249B45B;
	Wed, 16 Sep 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575594; cv=none; b=JLRqOnfuw74HZ1nsoeSBMaE+T0W8+0dG/XUDttFFVtRGt16Zv0iQeA6JIXO1j0tm0iTc5R8Xm5SPqGoAzPojkP6l2shx4PKV4hRDc1ZFsLNFJ7g/OUDNwifhTdVs9HIukHSzdqmtEFeF3FZV2bCEpzukZa9fvd0SdPP2rUm/gGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575594; c=relaxed/simple;
	bh=Fc1g539kKCUDo0+0IIAqXwtKGdEFXKiyW04U7sTQGOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRg+ILH05EgZSzhyMaDLR7QIZq9M8UahvO9o5hZ+VVqqU8CqArF/tx2z5Ck+cBhtD5bFdfILkE7gtAJOq82E0geM/JHav5F5cMmzrSlEFcRqy1DRtHASxhgwoeLiq+s2hIWG74V6OPf4BEttm8VWQjLzBsjnalC33YCSSlK6acA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0KhwapqlIltCA--.22145S2;
	Thu, 17 Sep 2026 00:19:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michael.Hennerich@analog.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	ramona.nechita@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: ad7779: Fix trigger reference leak in ad7779_setup_without_backend()
Date: Wed, 16 Sep 2026 16:19:17 +0000
Message-Id: <20260916161917.2083043-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0KhwapqlIltCA--.22145S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryDAF1DGrWrKw4UArb_yoW8GrWUpF
	sagr1DKFyqqF48tF4DZw1qkFySqanxtrW5CFW8ua4a93y5Zr1Y9F1Yqa42qr1UAF97WrWD
	Ar4xGrs8GrWjvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2qqok9PPwAAsT

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
devm_iio_triggered_buffer_setup() fails before setting that mode, the
reference acquired for indio_dev->trig leaks. Move the
iio_trigger_get() after the buffer setup succeeds.

Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/ad7779.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 695cc79e78da..76834275b1ca 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -850,8 +850,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
-
 	init_completion(&st->completion);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
@@ -861,6 +859,8 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 	if (ret)
 		return ret;
 
+	indio_dev->trig = iio_trigger_get(st->trig);
+
 	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
 				     AD7779_DCLK_CLK_DIV_MSK,
 				     FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
-- 
2.34.1

