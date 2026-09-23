Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B092BE035;
	Wed, 23 Sep 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133007; cv=none; b=hwCLfdQQGyEvgUiJLUZypNFnBQnVhY4aobMB1hcEYDQ0Wq7td3TpG/DAct4Q8s0NCmNAZya2BR3QGgjSSonA3JT7cyD14cCWk8FmNq9rzmVv2/Hn1HXP/zDWS+kEJ/JCISPfYvDoYY+/Uirzq+W06Qg8GrR+duAAH6pWyPGDEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133007; c=relaxed/simple;
	bh=KBfwRrxQmXFx6cB+cPahj+jCcHBorjBdywUPAz9Bhtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oh7lR8S0IDGNmuGnyiB83vL4wdhFsDELbS8D3M1WjchYBH71ErnIHJDZcfsQe1n510IeiROLMoa79+l7GsT7fDqyAjRMmJ6/I1NX3931QZUj6REG0Ugvz1pwR3aEaBhHPi/uu0EyxitP4WLQd0YgO7agDPizEQd4ZeeKpUIE1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHIX7_QrNqtyMwAQ--.4618S3;
	Wed, 23 Sep 2026 11:09:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgC3_cH+QrNqRXGVBA--.63972S2;
	Wed, 23 Sep 2026 11:09:50 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] gpio: mpsse: fix race when arming the IRQ poll worker
Date: Wed, 23 Sep 2026 03:08:55 +0000
Message-Id: <20260923030855.410109-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgC3_cH+QrNqRXGVBA--.63972S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?C1GYSgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI05NtnwIq4RzbwzD0Du8Iyoqb96jW8/ZuSBCIlyq23hAcee
	JHp3dW57KwFrOHlVpGTN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1fKFW8CrWkXr45Kr4rZwc_yoW5GF43pF
	ZxKr1rGr4kJrySv3ZxuFy7uF98u39xAry7Ww1xWw4xur4YvFyYyrWrtryjvF1j9FykJFnI
	yrs8WrWxKFs3A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU2VWlDUUUU

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
walk, and check it in the same critical section, freeing the worker
instead when the device is going away. schedule_work() is safe to
call with irq_spin held, and the next probe gets a fresh mpsse_priv,
so the flag never needs to be cleared.

This issue was found by an in-house static analysis tool.

Fixes: 179ef1127d7a ("gpio: mpsse: ensure worker is torn down")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpio/gpio-mpsse.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index 12191aeb6566..9efa7dfc9332 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -24,6 +24,7 @@
 	raw_spinlock_t irq_spin;     /* protects worker list */
 	atomic_t irq_type[16];	     /* pin -> edge detection type */
 	atomic_t irq_enabled;
+	atomic_t dying;		     /* no new workers after disconnect */
 	int id;
 
 	u8 gpio_outputs[2];	     /* Output states for GPIOs [L, H] */
@@ -525,10 +526,16 @@
 		worker->priv = priv;
 		INIT_LIST_HEAD(&worker->list);
 		INIT_WORK(&worker->work, gpio_mpsse_poll);
-		schedule_work(&worker->work);
 
-		scoped_guard(raw_spinlock_irqsave, &priv->irq_spin)
+		scoped_guard(raw_spinlock_irqsave, &priv->irq_spin) {
+			if (atomic_read(&priv->dying)) {
+				kfree(worker);
+				return;
+			}
+
 			list_add(&worker->list, &priv->workers);
+			schedule_work(&worker->work);
+		}
 	}
 }
 
@@ -715,6 +722,9 @@
 {
 	struct mpsse_priv *priv = usb_get_intfdata(intf);
 
+	scoped_guard(raw_spinlock_irqsave, &priv->irq_spin)
+		atomic_set(&priv->dying, 1);
+
 	/*
 	 * Lock prevents double-free of worker from here and the teardown
 	 * step at the beginning of gpio_mpsse_poll

