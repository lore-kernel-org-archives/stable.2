Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8A4C33F3;
	Wed, 16 Sep 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577167; cv=none; b=M77ytmhL9sIfU3iiXa45kn8BSaERkYKLxRIqC7KFjjV4oJrNzXzv/zFLasnOG9jAGRwFEmuJ9ylyoOCuO4r5SWS2VlT57FJEhLKIk8Y5wi6iZjc/SYtNHf4ctBboTU2qm+Qg5SZVCl4mU1w1Kus4NYZMmTu3yabFaBQGNpU1jB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577167; c=relaxed/simple;
	bh=rnbHyBuhnp7MEutDcD2qgrXwiTP6PhSbte/VmXfYH9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6Ofp10WCccVBMqc3uiiziFF0bmnw9JtpYRvzqaKFhkQfdObj+x5xcDvMWcFtaB1FBUSgfKzoyUOS2Ax75pL3AnkzuTeZ7zDNVdrEMnc+3XABp4G40F18m7VwvLBL+bgSGCSinMxtpq7RQuLcrlPMoIafAg3VhVrZi+EPKK3EEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnUDu5x6pqFOZtCA--.22059S2;
	Thu, 17 Sep 2026 00:45:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy@kernel.org
Cc: apokusinski01@gmail.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: temperature: tmp006: Fix trigger reference leak in tmp006_probe()
Date: Wed, 16 Sep 2026 16:45:17 +0000
Message-Id: <20260916164517.2084799-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnUDu5x6pqFOZtCA--.22059S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47ZFW7tF43uF1rWF17ZFb_yoW8GF1fpF
	sakayjyFW5trs7Ja1kZ3Z09a4avanxXrWUGr48A3s2va9xJa1YkFyYvFWFqF1IkrW8WrWj
	gr1UtFWF9r4jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2qqpO9STQAAsX

The reference taken with iio_trigger_get() is only dropped by
iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
devm_request_irq() or of triggered buffer setup returns before that
mode is set and leaks the reference acquired for indio_dev->trig.
Take the reference only after the triggered buffer setup succeeds.

Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iio/temperature/tmp006.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index d8d8c8936d17..06303ce72bfb 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -354,8 +354,6 @@ static int tmp006_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		indio_dev->trig = iio_trigger_get(data->drdy_trig);
-
 		ret = devm_request_irq(&client->dev, client->irq,
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_NO_THREAD, "tmp006_irq",
@@ -369,6 +367,9 @@ static int tmp006_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (data->drdy_trig)
+		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.34.1

