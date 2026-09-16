Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A750C28D;
	Wed, 16 Sep 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576135; cv=none; b=AWHccbECOGSiMICQMxnPcGn6QwyqOHJ+BHEhucletG8p07Zor8u5Ry+4ho5JUh6aOF+pg6k91VFhzHhvv6HXb3Bu6W2XXaXOghGGtINmGE4WyJRS1HP3QZWiSLIt/iTbB2h9Ol6DaHAz6ork5MI8F2oDKYsU+H8+T9HOrjmiq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576135; c=relaxed/simple;
	bh=5c13c6br1VNb439OxYGRCvv0YyDfGn/CnZe7LkB6p38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Viaozca6wPAf2k7JgsW1uuffsIGFJ6OvJz155FmxGWVHyR4Nv1zF2fDeMzc9FC3oCW1g9akjtQRHyeIsLD2nUrJ6boHW+AHpMwyuaHJDqa3rFOgsTPcPBd0VJklyw23QqcOI/WjQ+c8aNSHPsswkZ0fO5mQogfcmhWjprDcne0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnTzq9w6pqt6htCA--.21920S2;
	Thu, 17 Sep 2026 00:28:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	tomasz.duszynski@octakon.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: chemical: scd30: Fix trigger reference leak in scd30_setup_trigger()
Date: Wed, 16 Sep 2026 16:28:17 +0000
Message-Id: <20260916162817.2083674-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnTzq9w6pqt6htCA--.21920S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GF1kKrWDJFy3Cw4DArb_yoW8try5pF
	Z7CFWYyryUXr48JF4kZr1kCryrtFZIqFWfKr48uas2v3s8ZwnYgr1agrWaqw48CFW8W34U
	XFZ5Wrn5CFWIyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqpO9KqwAAso

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
devm_request_threaded_irq() in scd30_setup_trigger(), or of triggered
buffer setup in scd30_probe(), returns before that mode is set and
leaks the reference acquired for indio_dev->trig. Take the reference
after the IRQ request succeeds and set up the trigger after the
buffer so that only failures with the mode already set follow the
iio_trigger_get().

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/chemical/scd30_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..dc56291e1892 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -644,8 +644,6 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(trig);
-
 	/*
 	 * Interrupt is enabled just before taking a fresh measurement
 	 * and disabled afterwards. This means we need to ensure it is not
@@ -659,6 +657,8 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq\n");
 
+	indio_dev->trig = iio_trigger_get(trig);
+
 	return 0;
 }
 
@@ -710,16 +710,16 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to reset device\n");
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd30_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	if (state->irq > 0) {
 		ret = scd30_setup_trigger(indio_dev);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to setup trigger\n");
 	}
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd30_trigger_handler, NULL);
-	if (ret)
-		return ret;
-
 	ret = scd30_command_read(state, CMD_FW_VERSION, &val);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read firmware version\n");
-- 
2.34.1

