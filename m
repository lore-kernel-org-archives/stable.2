Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A841D102;
	Fri, 31 Jul 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508629; cv=none; b=IU8rAeut517YAZPjDT9CuNDYmss9tP1C4+rXW4qFCSzONIpYLIXWPjXt8UDU0J3SsS1qJI5D9Jvr1l00OOoyNnUsVfBaXBPe0WfeIMnGrhVElO0R/qsiivmYPL6XycUfc4zrHFnjA/7rDmJKVEpZQNlsJ8Ar4to78MtetK4RyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508629; c=relaxed/simple;
	bh=vjnXK6e/+zs+rtt3t+EiPCrC7Uppk9/6Fja90aK7H3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ppHzZ1ZfwO6N6yfm/Rj7yvjue/hRhjFgYRhB7V8Ehx/UIXB2mbH6TvP0NkM+ZHG2Bw6Ad8wW5JlX/4cWUizNAGQcqEcutkQCE29t5abqJZzSYd+IuP+LYwGPA8L1DubA0rVxcMyuwtgSq3GvRiFtCOD6B3G45YJrJpozwSiMS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDHoX4Ls2xqQj1UAA--.8037S3;
	Fri, 31 Jul 2026 22:37:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCHiaMKs2xqlOZcAw--.50299S2;
	Fri, 31 Jul 2026 22:36:58 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	laurentiu.palcu@intel.com,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] power: supply: bq24257: fix use-after-free on remove
Date: Fri, 31 Jul 2026 14:35:54 +0000
Message-Id: <20260731143554.334179-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCHiaMKs2xqlOZcAw--.50299S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?wPs6qAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBEXEjcR45dYs2uGwFfNb8p3BvjsVFH5IA1/nmqcZr4X+QVd
	1O1BJuJDoz2Owor9xTip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tr47tryxXw17Gw1kGr4rWFX_yoW8JFW5pr
	Z5CF90krWUJFW2ya1vvanrCFyrCFy5A347CFWxKw15A3ZxJr4Utryj9FsxWry3ArW8ZF4S
	9FnIqFW0vry5CrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

The STAT-pin interrupt is devm-managed, so it stays armed until the devm
cleanup that runs after remove() returns. remove() cancels
bq->iilimit_setup_work while the handler can still fire; the threaded
handler reschedules that work and dereferences bq, so the work runs
against freed memory once devm frees bq.

Call devm_free_irq() before canceling the work so the handler is quiesced
and cannot reschedule it after the cancel.

Found by static analysis.

Fixes: 2219a935963e ("power_supply: Add TI BQ24257 charger driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/power/supply/bq24257_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 72f1bfea8d..b9110d5fe2 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1064,6 +1064,7 @@ static void bq24257_remove(struct i2c_client *client)
 {
 	struct bq24257_device *bq = i2c_get_clientdata(client);
 
+	devm_free_irq(&client->dev, client->irq, bq);
 	if (bq->iilimit_autoset_enable)
 		cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
-- 
2.34.1

