Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201A4A5C39;
	Mon, 28 Sep 2026 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594818; cv=none; b=UpK3QNLovkdAiUzjcZ0d0wF0lksN/VkvBQZyedwkMfzjtAPBrwt8cg1K5zUEO04MSOqvgJaYJ4ICDSfYpRzsc5L7HXVyoFInaG5RPsg+PQ9vmdP9230lkdE3U4kWd46p070YGauzCrAoeOWb772Ex6kVdjL3pSLWoFLSjfZTKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594818; c=relaxed/simple;
	bh=SqqSHpTVaFTGp7yew8wil1yGbcjDwt8M5trdScYW15k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSiOG5kfUhIjxBcXb2pT8RYkMrhd1CsQabshSSpEp3t/RTWZo6vDdIg8m+3TzP644xe5958BGH4W8siE9bvhK4wzU9ayd3b0RuRkSTMWoUAWNMa917OxJz4hu2FRpEUhx8icDCg9xA665fsDmny5y+JLl4gxfmP26rjVN3SrMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnYj30TrpqyExCAQ--.23692S3;
	Mon, 28 Sep 2026 19:26:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with UTF8SMTPA id zC_KCgA3jnz0TrpqupcSAA--.16008S2;
	Mon, 28 Sep 2026 19:26:44 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linusw@kernel.org,
	brgl@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	songl@zju.edu.cn,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] gpio: mpsse: fix race when arming the IRQ poll worker
Date: Mon, 28 Sep 2026 11:25:46 +0000
Message-Id: <20260928112546.631440-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgA3jnz0TrpqupcSAA--.16008S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?EQNgHQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVvLbuoOKy0xUR2OEh/Lyhmb2J4R14AQ5aua09c1TMHWWZNzjWtWAkItiV16dpR6RS7l
	FAOxNOXOfvatp8iSH8Sp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCrW3Aw1UXw48KFyxGFWkKrX_yoW5Xw4kpF
	ZxKw4rGrs5JryI9Fnxuay0vry5uws5Cry2ga4xWw4xXr4akr90ya4kGr98ZF15uFykCFnx
	Ar4DKr4xKFsxAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==

gpio_mpsse_irq_enable() schedules a poll worker before adding it to
priv->workers. gpio_mpsse_disconnect() can miss the worker while
tearing down the list, after which the worker can access freed priv.

Publish and schedule the worker while holding irq_spin. Set dying under
the same lock before disconnect tears down the list, so a worker created
after teardown starts is neither published nor scheduled. Use
kfree_rcu() for such a worker because irq_enable() runs with the IRQ
descriptor raw lock held.

This issue was found by an in-house static analysis tool.

Fixes: 179ef1127d7a ("gpio: mpsse: ensure worker is torn down")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpio/gpio-mpsse.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index a859deab2..958d74427 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -10,6 +10,7 @@
 #include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
 
@@ -24,6 +25,7 @@ struct mpsse_priv {
 	raw_spinlock_t irq_spin;     /* protects worker list */
 	atomic_t irq_type[16];	     /* pin -> edge detection type */
 	atomic_t irq_enabled;
+	atomic_t dying;		     /* no new workers after disconnect */
 	int id;
 
 	u8 gpio_outputs[2];	     /* Output states for GPIOs [L, H] */
@@ -46,6 +48,7 @@ struct mpsse_worker {
 	atomic_t       cancelled;
 	struct list_head    list;   /* linked list */
 	struct list_head destroy;   /* teardown linked list */
+	struct rcu_head      rcu;   /* deferred free for dying path */
 };
 
 struct bulk_desc {
@@ -525,10 +528,17 @@ static void gpio_mpsse_irq_enable(struct irq_data *irqd)
 		worker->priv = priv;
 		INIT_LIST_HEAD(&worker->list);
 		INIT_WORK(&worker->work, gpio_mpsse_poll);
-		schedule_work(&worker->work);
 
-		scoped_guard(raw_spinlock_irqsave, &priv->irq_spin)
+		scoped_guard(raw_spinlock_irqsave, &priv->irq_spin) {
+			if (atomic_read(&priv->dying)) {
+				/* irq_enable() runs under the IRQ descriptor raw lock. */
+				kfree_rcu(worker, rcu);
+				return;
+			}
+
 			list_add(&worker->list, &priv->workers);
+			schedule_work(&worker->work);
+		}
 	}
 }
 
@@ -704,6 +714,9 @@ static void gpio_mpsse_disconnect(struct usb_interface *intf)
 {
 	struct mpsse_priv *priv = usb_get_intfdata(intf);
 
+	scoped_guard(raw_spinlock_irqsave, &priv->irq_spin)
+		atomic_set(&priv->dying, 1);
+
 	/*
 	 * Lock prevents double-free of worker from here and the teardown
 	 * step at the beginning of gpio_mpsse_poll

