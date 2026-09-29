Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D653559E1;
	Tue, 29 Sep 2026 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675411; cv=none; b=NsCfYP6lFrAgGCaXsQfYrpNiZEUIarpLZeDWCVExELz0H0KJSeRGHekrNAQh9Nu/EOEQL+/qbwD+ER0WG8sqlHTt7fjTO0DVzvNgsAkbAOjQxv4xKdpFuh43iDAaMlQwfdofLlIdDBKSVzI59Eug0Kv4nGdJvX/1LcTXwiUybNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675411; c=relaxed/simple;
	bh=yAYCbIiQcRn8/kObl3S+3BLjEcqsgCjQ+ptO2YGYeRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePSv+nvfCL6MVZZX6I2e2iIB/rhRS8SWtTO/J+BVp1GJH6fTq6k/reEaazBSQNcwanGAGL46UZcGKG4q25/QmNCsCULn1B6gAK3R1Z3hTPQLvRQEh05rqlqLVw5af6ysLsA6YW/I6fjkvrW7sBG7fYTSPayEudZjF4NPgoPfnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3kT68ibtqCEVGAQ--.287S3;
	Tue, 29 Sep 2026 17:49:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with UTF8SMTPA id zi_KCgAHiZ+8ibtqrZIUAA--.38864S2;
	Tue, 29 Sep 2026 17:49:48 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linusw@kernel.org,
	brgl@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	songl@zju.edu.cn,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v3] gpio: mpsse: fix race when arming the IRQ poll worker
Date: Tue, 29 Sep 2026 09:36:46 +0000
Message-Id: <20260929093646.18419-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAHiZ+8ibtqrZIUAA--.38864S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?NZNojgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnbpwaw7gRjzR7embn8Pa6gcYp8VY04oJ52CCtY4IcEkz7Q9faqdF111zRRE/A5gXJdwi
	3eTxn5v9Gp9ctZyEkCzwVWyu4/BhoK61R29ZB6TE
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1fKFW8CrWkXr45Kr4rZwc_yoWrCF13pF
	Z0grn5Grs5JryS9FnxuF47ur98uws3Jry7WryxWw4fZr4a9r90ya9YvryY9F1UuFyvkF1Y
	yrs0grZ7KFZrA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I_M3UUUUU==

gpio_mpsse_irq_enable() arms the poll worker before publishing it:
schedule_work() runs before the worker is added to priv->workers. If
gpio_mpsse_disconnect() walks the list in that window it misses the
worker, and once disconnect returns, the USB core frees mpsse_priv
while the orphaned gpio_mpsse_poll() work keeps accessing it, causing
a use-after-free.

Fix this by publishing and arming the worker in one irq_spin
critical section. Teardown walks the same list under irq_spin, so a
worker found on the list is guaranteed to be armed, and
cancel_work_sync() handles it whether it is queued or running.

A worker armed after the disconnect walk would still be missed, so
also set a new priv->dying flag under irq_spin before the teardown
walk, and check it in the same critical section, freeing it via
kfree_rcu() instead when the device is going away, since kfree()
would be called with the IRQ core's raw spinlock held and may sleep
on PREEMPT_RT. schedule_work() is safe to call with irq_spin held,
and the next probe gets a fresh mpsse_priv, so the flag never needs
to be cleared.

This issue was found by an in-house static analysis tool.

Fixes: 179ef1127d7a ("gpio: mpsse: ensure worker is torn down")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

Changes in v2, responding to feedback from Bartosz Golaszewski:

 - Rework the worker disposal to be PREEMPT_RT-safe: v1 called
   kfree() under priv->irq_spin with the IRQ descriptor's raw
   spinlock also held (found by Sashiko, relayed by Bartosz); free
   the never-published worker with kfree_rcu() instead.
 - Recheck the pre-existing GFP_NOWAIT allocation in this irqchip
   callback: no change needed.

Changes in v3: expand the comment above the deferred free, reword the
commit message and add this changelog; no functional change since v2.

v1: https://lore.kernel.org/linux-gpio/20260923030855.410109-1-fanwu01@zju.edu.cn/
v2: https://lore.kernel.org/linux-gpio/20260928112546.631440-1-fanwu01@zju.edu.cn/
 drivers/gpio/gpio-mpsse.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index a859deab2..5ce822c0d 100644
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
@@ -525,10 +528,24 @@ static void gpio_mpsse_irq_enable(struct irq_data *irqd)
 		worker->priv = priv;
 		INIT_LIST_HEAD(&worker->list);
 		INIT_WORK(&worker->work, gpio_mpsse_poll);
-		schedule_work(&worker->work);
 
-		scoped_guard(raw_spinlock_irqsave, &priv->irq_spin)
+		scoped_guard(raw_spinlock_irqsave, &priv->irq_spin) {
+			if (atomic_read(&priv->dying)) {
+				/*
+				 * Cannot kfree() here: this callback
+				 * runs with the IRQ descriptor's raw
+				 * spinlock held and kfree() may sleep
+				 * on PREEMPT_RT. The worker is not
+				 * yet published, so the deferred free
+				 * is unobservable.
+				 */
+				kfree_rcu(worker, rcu);
+				return;
+			}
+
 			list_add(&worker->list, &priv->workers);
+			schedule_work(&worker->work);
+		}
 	}
 }
 
@@ -704,6 +721,9 @@ static void gpio_mpsse_disconnect(struct usb_interface *intf)
 {
 	struct mpsse_priv *priv = usb_get_intfdata(intf);
 
+	scoped_guard(raw_spinlock_irqsave, &priv->irq_spin)
+		atomic_set(&priv->dying, 1);
+
 	/*
 	 * Lock prevents double-free of worker from here and the teardown
 	 * step at the beginning of gpio_mpsse_poll

-- 
2.34.1

