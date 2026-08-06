Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE413A1681;
	Thu,  6 Aug 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026371; cv=none; b=Ar8k902WeisyOrD4lsrC2gdJC0vKOkBZXasVVmuD3Rde7LYmhFGuTDCuP2tLgj9qHQuSzQOMHVgi+nT6ia6o4xZuGkTTwHZgbHc23U67NBuDAhiUBzj79DD2B9CyIrPjiYvN2jA3R3EfRu8xARoJ+FVcESH3nx3NrA4o5+ujEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026371; c=relaxed/simple;
	bh=vsnQGrCtSQHrmNe/dDqEW8tEKy71s9aGW1grYIAMuMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gLNLpxXg0IYZpUxTZGToCGzXNDA977ILCPeMPdEHnQiLenEo676wpwF/BXMOVTNf2NYqRUMeyFll0Y2bEgA4suNS+F0XjY24OKwB31XHkXse8NUFNYYAVRVVbxJbpSCKY2WlUlgvxdBrpAW7KuViQgeZgn1m+xN7Ewu2SRiuWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3ITd1mXRqIHRuAA--.29787S3;
	Thu, 06 Aug 2026 22:25:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAH7DR1mXRq4Z30Ag--.63343S2;
	Thu, 06 Aug 2026 22:25:57 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: trigger: cancel reenable_work before freeing trigger
Date: Thu,  6 Aug 2026 14:25:02 +0000
Message-Id: <20260806142502.475394-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAH7DR1mXRq4Z30Ag--.63343S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?kQrq7AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwp5qb4W9IdGa10RfZ4Bq7yZAdnnwQ712zH62S7o6QEEw56
	yZzxATIQDkFVcObaW+yp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tFy3GrWUuFW5KFW7WF1ktFc_yoW8GFWxpF
	sakrWDKFWDXa1xta17uw18WFyfJan8t3yUKrW093sFg390ya48K34Ivr4UX348Jr4UXF4a
	vFZrXFs8KFsrZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

iio_trigger_notify_done_atomic() defers ->reenable() into
trig->reenable_work on the system workqueue, and the worker dereferences
the owning trigger through container_of().  Nothing cancels this work
before iio_trig_release() frees the trigger, so a worker armed by the
last in-flight IRQ can outlive the free and touch freed memory.

Cancel it at the top of iio_trig_release(), which every free path
reaches through the device core's final put_device().

Found by an in-house static analysis tool.

Fixes: 9020ef659885 ("iio: trigger: Fix a scheduling whilst atomic issue seen on tsc2046")
Cc: stable@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/iio/industrialio-trigger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..68e92eac2b77 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -509,6 +509,8 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
+	cancel_work_sync(&trig->reenable_work);
+
 	if (trig->subirq_base) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
-- 
2.34.1

