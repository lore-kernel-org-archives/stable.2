Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0457538D65;
	Wed, 16 Sep 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575821; cv=none; b=IARBgw9AMkmYoJv48lkiHKUwWRYziCMW8juzITiwqeMvw6I6GTlTBAjcIz7me8x89BkKRS3Te2BulgANe4MG8PpDh9ggcTNOQopNti378a7iQtsTJJf33ziDiQyxRdQ1C4De5482nN83ZYZg3VIUQ9FYqqSZIJaN2sU/QTTKn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575821; c=relaxed/simple;
	bh=wsbX0wqYrqIuQowj/GmWlZ9MuP50EBhhX8bp7QOYJG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUcJV1j2BeJgZGBGi3qsAV4hY7uJPqisIviKyQgQAdP3J4229H4WiDL7tJAyQZEayjdlzKoWcU+TnPMGyrcjo27LZ/5DzknkGYmbr5u0eEAmvyvxkLVJGU3TLRLZ8ZHcOpBUdni96qnzLq3n/PDDqwOwkHYpO9Y08TGf9qf2WIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zl3wqpqg5VtCA--.21957S2;
	Thu, 17 Sep 2026 00:23:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michael.Hennerich@analog.com
Cc: andy@kernel.org,
	cosmin.tanislav@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413r: Fix trigger reference leak in ad74413r_probe()
Date: Wed, 16 Sep 2026 16:22:51 +0000
Message-Id: <20260916162251.2083286-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zl3wqpqg5VtCA--.21957S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47ZFW7Wr15CFW5Jr43ZFb_yoW8JFWDpa
	97GF4jyFy2qrWxJr4kZ3Wj9a43ZF43KrWruFWxZa4a9395Zw1Y9FyjgF43Zr15ZFW8ua1U
	XrWxJr4rCF4xZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2qqok9QuQAAsF

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Every failure
between trigger registration and the triggered buffer setup returns
before that mode is set and leaks the reference acquired for
indio_dev->trig. Move the iio_trigger_get() after the buffer setup
succeeds.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/addac/ad74413r.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index fe930ce5ee30..380900bf6772 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1397,7 +1397,6 @@ static int ad74413r_probe(struct spi_device *spi)
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad74413r_info;
-	indio_dev->trig = iio_trigger_get(st->trig);
 
 	ret = ad74413r_reset(st);
 	if (ret)
@@ -1467,6 +1466,8 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	indio_dev->trig = iio_trigger_get(st->trig);
+
 	return devm_iio_device_register(st->dev, indio_dev);
 }
 
-- 
2.34.1

