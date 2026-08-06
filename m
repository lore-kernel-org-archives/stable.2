Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6C37F8CB;
	Thu,  6 Aug 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023265; cv=none; b=o3NkXOf2r3egh79Gl9EmCiKTMarsEcqnBqDk/3QuxL33WI2Jh/k2BI54nMr9McGopGTcyzkPK54Wa/oP8ithQrPAwqg/EgEZXGKQjDhIO/0XEJ5s3y4jM2JUf7ej71KBAZDyd5u7p3Cb9chBKSal1KDIbpBfjbJ/JxZtEXsyk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023265; c=relaxed/simple;
	bh=rzDW+KrsvEk2Fd6tkNWh+6QdqtHMEql8C53bwYKVFbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQiSr8dall1wUVKgvBh1nG5rAySECtvMdHGu/4HN3vqk8dbwr3LcRDF+DoliJLPRVTQXOD/NbhPodzGD6FHrpDivWJh5jK1qy/yY/+pYrX1atwQ84gAWadKOjCc2sXFo6mlr5lCHqkohnLzjveXmEShNUdLWRmWL89AoWxuSTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHQH9KjXRq6kxuAA--.5031S3;
	Thu, 06 Aug 2026 21:34:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgD3idBJjXRqpI6cAw--.10593S2;
	Thu, 06 Aug 2026 21:34:01 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] iio: light: gp2ap020a00f: drain irq_work after free_irq
Date: Thu,  6 Aug 2026 13:29:23 +0000
Message-Id: <20260806132923.468833-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgD3idBJjXRqpI6cAw--.10593S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?lfkbHAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI18Th2eK5VvAmQWWJW1W/15G0Ib5M1TLFoBcQes49cO2hHS
	+iwQR8i9mgTulNDGFaKp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWrWFyxJrWDZr43KFW8Xwc_yoW8AFWUpF
	nxua9xuryvqF4I9r4Dua1xGFyIv3W7J34UCrWUuwnru398Ar1S9rySyF1rXF1xXrW8Xr42
	yFWvya9Ykrs8AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The threaded IRQ handler queues data->work through irq_work_queue() so
the trigger is polled from a per-CPU context.  free_irq() does not flush
an irq_work the handler already queued, so after gp2ap020a00f_remove()
returns that work may still run and call iio_trigger_poll() on data->trig,
which the devm cleanup has already freed, causing a use-after-free.

Add irq_work_sync(&data->work) after free_irq() in remove() and in the
probe error path, mirroring commit 78601726d4a5 ("iio: trigger: sysfs:
fix use-after-free on remove").

Found by an in-house static analysis tool, confirmed by manual review.

Fixes: bf29fbeaa13d ("iio: gp2ap020a00f: Add a driver for the device")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/iio/light/gp2ap020a00f.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..20d1aa9e99d7 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1560,6 +1560,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 	iio_trigger_unregister(data->trig);
 error_free_irq:
 	free_irq(client->irq, indio_dev);
+	irq_work_sync(&data->work);
 error_uninit_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_regulator_disable:
@@ -1582,6 +1583,7 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_trigger_unregister(data->trig);
 	free_irq(client->irq, indio_dev);
+	irq_work_sync(&data->work);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(data->vled_reg);
 }

