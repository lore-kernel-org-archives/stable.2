Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68692AD37;
	Sun,  2 Aug 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785655201; cv=none; b=H0yNaazyxsRUB2xWf0+zH+AQV4FRXOOgCuGvKJ4vVDFXQN+FaxNbphF3tWU1ttyRZVMCC5Mg90v6APwxK4MMMySkL/3Bx4xbQ3ynWsTXCcsT4KLhHztNyKPk1rCT6+2xvDw+HEXFOVGXEz/b9yWfTq46aHzEGx3oKDaEjA5xvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785655201; c=relaxed/simple;
	bh=93uv5jk6v/ieTBwy86ryR7DXv68TCIL2/fXflnPIvTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C44cbL9/YLKp+PBEyfc4kBrHo/al6BiWYCuefeIYIItiATHFRsmz0yTaJK9oZDWM3DJcOUe8q90JREFfZjMA7PhiM5thp8EPsCt6rFCj1TNigH3oemhR1XivoMiLAuK1jN8AOycVn/B5pl3a15RmT9a9sI6pnYSkfsYZTo4Pklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHgyiZ725qVNNZAA--.19066S3;
	Sun, 02 Aug 2026 15:19:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXijGZ725q9r3QAg--.53239S2;
	Sun, 02 Aug 2026 15:19:53 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jic23@kernel.org
Cc: mranostay@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF
Date: Sun,  2 Aug 2026 07:18:58 +0000
Message-Id: <20260802071858.430780-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXijGZ725q9r3QAg--.53239S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?oj6ajAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyFLp0gqdfrRoFLp/uDBcfxMLS/T6KhAij0CU/uQ6QPqT0m
	RWid1CAbc/R1tmRRnhKp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxuryrCr1rGrWkuF4fAw1kZwc_yoW5Aw4kpF
	Z09FWq9rWkXF10vr4DC3WjyFyayrnxGay7KwsIg3sFq3s0yr1F9F40kFyaqF15AFWkWF15
	ZrWrtrWDurs8AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The atlas driver requests its hardware data-ready IRQ with
devm_request_threaded_irq(); its threaded handler queues an irq_work,
atlas_work_handler(), that calls iio_trigger_poll(data->trig).

The IRQ is devm-managed, so free_irq() runs from the devres unwind after
atlas_remove() returns without flushing that irq_work.  Once a buffer is
enabled, conversion-complete IRQs keep firing and queueing it; a pending
irq_work can therefore run after the unwind has freed atlas_data/indio_dev
and the trigger, when atlas_work_handler() derives the atlas_data pointer
via container_of() and dereferences data->trig, a use-after-free.

Call iio_trigger_poll_nested() directly from the threaded handler instead
of bouncing through irq_work.  free_irq() then drains the threaded handler,
closing the window; other iio drivers with a threaded data-ready IRQ do the
same (e.g. bmi270).

This issue was found by an in-house static analysis tool.

Fixes: 7103b99b031c ("iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips")
Cc: stable@vger.kernel.org # v6.4+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

 drivers/iio/chemical/atlas-sensor.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/irq.h>
-#include <linux/irq_work.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
@@ -88,7 +87,6 @@ struct atlas_data {
 	struct iio_trigger *trig;
 	const struct atlas_device *chip;
 	struct regmap *regmap;
-	struct irq_work work;
 	unsigned int interrupt_enabled;
 	/* 96-bit data + 32-bit pad + 64-bit timestamp */
 	__be32 buffer[6] __aligned(8);
@@ -437,13 +435,6 @@ static const struct iio_buffer_setup_ops atlas_buffer_setup_ops = {
 	.predisable = atlas_buffer_predisable,
 };

-static void atlas_work_handler(struct irq_work *work)
-{
-	struct atlas_data *data = container_of(work, struct atlas_data, work);
-
-	iio_trigger_poll(data->trig);
-}
-
 static irqreturn_t atlas_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -470,7 +461,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct atlas_data *data = iio_priv(indio_dev);

-	irq_work_queue(&data->work);
+	iio_trigger_poll_nested(data->trig);

 	return IRQ_HANDLED;
 }
@@ -666,8 +657,6 @@ static int atlas_probe(struct i2c_client *client)
 		goto unregister_trigger;
 	}

-	init_irq_work(&data->work, atlas_work_handler);
-
 	if (client->irq > 0) {
 		/* interrupt pin toggles on new conversion */
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
--
2.43.0

