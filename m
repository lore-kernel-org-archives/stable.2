Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954351357E;
	Wed, 16 Sep 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576044; cv=none; b=AGbuXV91N+SHrxmL0bHu5JHGyhFtR4dGf05eB91MznBBRw+BJBoo++kNC3HZPv8D9LMbAyrrDHQ/pzPwTRqy5qM6cN8oefx7vrDeiSZS+teiYelrRl2AFA56xjagcbTKy20/KWn27PfSfAQh02Lt0ScCXHXwGw1R7hBf3yqoaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576044; c=relaxed/simple;
	bh=18qSghsd4oFLTLNoXIdxtY0t3dPvtnegnVBCOHbmr/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IMijlnd/ItbtqHZWeu4QH4yUgy2CUOH36m1Ue2M9t1MP+I4QE/NZZRSvt+RNzv5K5LOFFns/Eba+UXLA2l0Lj4TZ5BZZL7FYUHlTsZ7U7kyYUhfJ1F0fe8tGR4+5NlE5UF1zjsrM5MRSNPDspep/BmuBoaZoAJVoxyjECX+XKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj1aw6pqiqNtCA--.21368S2;
	Thu, 17 Sep 2026 00:27:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	gustavograzs@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: chemical: ens160: Fix trigger reference leak in ens160_setup_trigger()
Date: Wed, 16 Sep 2026 16:26:38 +0000
Message-Id: <20260916162638.2083538-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj1aw6pqiqNtCA--.21368S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rKFykKrWxtr4DAw1rXrb_yoW8Kw18pa
	n7GFWYyFyUXrn7Aws7Zr1kCFy3tFn7trWrXw48Zas2v3s8Aw1jkryaqrWaqws5CFW8ZayU
	JrZ5JryrCFW7ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5d
	gADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqpVhIsQAAsJ

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
devm_request_irq() in ens160_setup_trigger(), or of chip init or
triggered buffer setup in devm_ens160_core_probe(), returns before
that mode is set and leaks the reference acquired for indio_dev->trig.
Request the IRQ before taking the reference and set up the trigger
after the triggered buffer so that only failures with the mode
already set follow the iio_trigger_get().

Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/chemical/ens160_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index bbc96c4c6283..d2f56e4483ba 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -314,14 +314,13 @@ static int ens160_setup_trigger(struct iio_dev *indio_dev, int irq)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(trig);
-
 	ret = devm_request_irq(dev, irq, iio_trigger_generic_data_rdy_poll,
-			       IRQF_NO_THREAD, indio_dev->name,
-			       indio_dev->trig);
+			       IRQF_NO_THREAD, indio_dev->name, trig);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq\n");
 
+	indio_dev->trig = iio_trigger_get(trig);
+
 	return 0;
 }
 
@@ -345,13 +344,6 @@ int devm_ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->channels = ens160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
 
-	if (irq > 0) {
-		ret = ens160_setup_trigger(indio_dev, irq);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to setup trigger\n");
-	}
-
 	ret = ens160_chip_init(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "chip initialization failed\n");
@@ -364,6 +356,13 @@ int devm_ens160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (ret)
 		return ret;
 
+	if (irq > 0) {
+		ret = ens160_setup_trigger(indio_dev, irq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup trigger\n");
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(devm_ens160_core_probe, "IIO_ENS160");
-- 
2.34.1

