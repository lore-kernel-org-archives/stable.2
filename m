Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7F331EB5;
	Thu, 23 Jul 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818500; cv=none; b=j9POY2kqWbq0LS+yE/fsI7VTus+G3jSgjkbl49rANg4At08zaVqi+/OREzmg8qO8iGEfrjbnoQ9N6qrM0GIIjLxXvK/K60DtEl/AMMecKT1Uqp7nb0SxwvXZUXIhkPps/78CTaJ6Sv5Le4umAp192QsQ0ykGfveyd/6F35LZJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818500; c=relaxed/simple;
	bh=S0UPwI+qNafbxH0+cfLPgcRWYhwre3WjWDdImXSQk5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAJgZYkJ92B1TqzCXM/FHgmUh1hgOHxnQgX/c6cvTiB34VSS5Dl6P+uLhfVK4BLYS58onqdLe2KnRbmuUI8rT9VkygGgaoemFMDazUxdlfStqbHqjZs/n9TB+S9MExtNMxp2KP0WNU5Ncqd7cfgzgIHBev8WYIXZmcWS1reyxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAn4304K2JqxYoyAA--.41419S3;
	Thu, 23 Jul 2026 22:54:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAH7DQ4K2Jq7bKIAg--.26003S2;
	Thu, 23 Jul 2026 22:54:48 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Anda-Maria Nicolae <anda-maria.nicolae@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: rt9455: quiesce delayed work before teardown
Date: Thu, 23 Jul 2026 14:53:52 +0000
Message-Id: <20260723145352.8865-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAH7DQ4K2Jq7bKIAg--.26003S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?5t62XgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyomITnwFG6g42sAra1j49ltrLZ0dLuTRtrYmPbf3QFS58O
	aAEeMJvjqHrXkzQAMuGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxurW3AF45Cw47try7GFWUJrc_yoWrWr17pr
	ZYkF93Jw4UGF4IgFZIqF47uF1rCr4DtryUCrWxX3y7A3Z3Jr9Fqw18KFy09F1rXF93Aw42
	vr4Yqay8ZF10krbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The threaded IRQ handler can queue pwr_rdy_work,
max_charging_time_work and batt_presence_work.  pwr_rdy_work and
batt_presence_work can also queue max_charging_time_work, while
batt_presence_work can requeue itself.

rt9455_remove() cancels max_charging_time_work before
batt_presence_work.  The latter can therefore queue
max_charging_time_work after it has already been cancelled:

  rt9455_remove()                   workqueue
    cancel pwr_rdy_work
    cancel max_charging_time_work
                                      batt_presence_work queues
                                        max_charging_time_work
    cancel batt_presence_work
    return
    devres frees rt9455_info
                                      max_charging_time_work dereferences
                                        rt9455_info

The IRQ also remains registered until devres cleanup and can queue more
work after any of the cancellation calls.  If rt9455_hw_init() fails
after the IRQ has been requested, probe returns without cancelling work
that may already have been queued.  A pending callback can then access
rt9455_info after it has been freed.

Explicitly free the managed IRQ before cancelling the delayed works in
both paths.  This waits for the threaded handler and prevents it from
queuing more work.  Cancel pwr_rdy_work and batt_presence_work before
max_charging_time_work because both can queue the latter.

This issue was found by an in-house static analysis tool.

Fixes: e86d69dd786e ("power_supply: Add support for Richtek RT9455 battery charger")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/power/supply/rt9455_charger.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 7045d2908148..3c64591b5934 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1582,6 +1582,17 @@ static const struct regmap_config rt9455_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+static void rt9455_cancel_all_delayed_works(struct rt9455_info *info)
+{
+	/*
+	 * Both pwr_rdy_work and batt_presence_work can queue
+	 * max_charging_time_work, so cancel them first.
+	 */
+	cancel_delayed_work_sync(&info->pwr_rdy_work);
+	cancel_delayed_work_sync(&info->batt_presence_work);
+	cancel_delayed_work_sync(&info->max_charging_time_work);
+}
+
 static int rt9455_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -1684,11 +1695,15 @@ static int rt9455_probe(struct i2c_client *client)
 	ret = rt9455_hw_init(info, ichrg, ieoc_percentage, mivr, iaicr);
 	if (ret) {
 		dev_err(dev, "Failed to set charger to its default values\n");
-		goto put_usb_notifier;
+		goto free_irq_and_drain;
 	}
 
 	return 0;
 
+free_irq_and_drain:
+	/* Stop new work before draining work queued during probe. */
+	devm_free_irq(dev, client->irq, info);
+	rt9455_cancel_all_delayed_works(info);
 put_usb_notifier:
 #if IS_ENABLED(CONFIG_USB_PHY)
 	if (info->nb.notifier_call)  {
@@ -1704,6 +1719,10 @@ static void rt9455_remove(struct i2c_client *client)
 	int ret;
 	struct rt9455_info *info = i2c_get_clientdata(client);
 
+	/* Stop the IRQ handler from queuing work during teardown. */
+	devm_free_irq(&client->dev, client->irq, info);
+	rt9455_cancel_all_delayed_works(info);
+
 	ret = rt9455_register_reset(info);
 	if (ret)
 		dev_err(&info->client->dev, "Failed to set charger to its default values\n");
@@ -1712,10 +1731,6 @@ static void rt9455_remove(struct i2c_client *client)
 	if (info->nb.notifier_call)
 		usb_unregister_notifier(info->usb_phy, &info->nb);
 #endif
-
-	cancel_delayed_work_sync(&info->pwr_rdy_work);
-	cancel_delayed_work_sync(&info->max_charging_time_work);
-	cancel_delayed_work_sync(&info->batt_presence_work);
 }
 
 static const struct i2c_device_id rt9455_i2c_id_table[] = {
-- 
2.34.1

