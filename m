Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411289;
	b=WtCmTdsHXHMtOnB35R22wPreLfiJIaIBqRr1gy7FSaxKPyPzIJhCC/Wg9StahL1/nFFz
	 MH6BOyjHIfLZfvQKx7rPNTiSmoSABJnyD+SiGeHIgRXBHpCvdKTXb0WUCS8GQb/YAvwjB
	 1ARXQUqQ5p5LzgjNMRsHvDmXVNMuBY201M4rWfzN7ziANH+DDcP7TZ2G+98J25aHnhhCP
	 9+bl3xXC52CkhAIoiNX4g0SGVcK0VnVlXbgOtWzwdrwOIx9RTwE1fW2dHbeSjYILyW88b
	 sUV2KfnQ2+4J18v9GyVdjMcc5unU9mRO+6u8swlP0b8FHvo8HaWYxvR0zz1lEvFZHUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1ww1Hl7OpTZ/eEGS+/UwBOxJASWOEaj+HPWrDITND3o=;
	b=wgkUtFAX1rIq+w8yJSWeK811I0oktp5+rXYx4dU2yAiyZjyazcPPPWSlR7OiArALj5Bc
	 tSFkrGIgWvM48q5i6ofUFe7+3BQ0kWabLZwvtuqhl73cMD23Z62XdtB7ABDGtF3aZaq4+
	 vulCk4VxcIWEQbjsWli1h8AIFyuTnOORl/jQtQtLlTtx//XalrQme7a9/4oBmt/FWep4s
	 IdMixuZ1bejSUfsXxh/fQbS9DjH8F/L2NRM2MFOaZIqm/4Ss8C9HgKyoQgV+LiJ7aBXZk
	 5VoHzx9Bmk48ADIYjAWuiI55H5tqRJGQGoOBxFkQu/1en1mayMh+qwZaf2wXDr0MZrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCUv+1oR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B521606A33E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCUv+1oR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C941F00A09;
	Wed, 11 Nov 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411289;
	bh=1ww1Hl7OpTZ/eEGS+/UwBOxJASWOEaj+HPWrDITND3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCUv+1oRZVgE7TvSvQ6P6K00gXW/HU9ZqPOfs8s6GHAu6Cd+FQVh84EhZI/skvPlt
	 olw6NwU1hEYYIbEnrItuInDSKgoMMC8xfXgy1Ukw+kJiBkjB8Oc98K6i0NYRx1f8L2
	 /Iz8L8De3qfqV3Obd8EtOgeBwCNpUxmLU/DAWA6lM/VW+IjbcL1PqnilrwePF3fmRC
	 NfeOaxGe4eYIhaD5B1x9yDrfc5ptPCzUwjuXMEPWxPRPtKzizYCvYNNXERkYLOPsfp
	 MEQyLlMQ5n4P8HJ/5nsaCZQM4ru6p/lmDQe8V3V3Fh8b5sILKO2Th2XzII5DZIEkTj
	 U0jkjIZztf6AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mfd: tps65217: Use devres for IRQ domain and wake teardown
Date: Wed, 11 Nov 2026 10:34:47 -0500
Message-ID: <20261111153428.2659663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060701-failed-5.15-cffd44d2d895@kernel.org>
References: <20261107060701-failed-5.15-cffd44d2d895@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

[ Upstream commit cffd44d2d89524e2dda6adc7b0dd59363be1c8e6 ]

Removing the parent device used to tear the IRQ domain down in
tps65217_remove() before the MFD children are unbound: the i2c core
only releases the parent's devres after the remove callback returns,
whereas devm_mfd_add_devices() registered its own devres action which
unbinds the children. Children that requested interrupts from the
domain (e.g. tps65217-charger) therefore call free_irq() on virtual
IRQs whose descriptors have already been disposed. With
CONFIG_SPARSE_IRQ free_irq() then returns early without stopping the
threaded handler, leaking the irqaction, the IRQ kthread and a module
reference.

Register the domain teardown as a devres action right after the domain
is created instead. Devres actions are released in reverse order of
registration, so the MFD children release their IRQs first, then the
parent interrupt is freed and its thread stopped, and only then is the
domain torn down. The same ordering covers probe failure, which no
longer needs manual cleanup, and the remove callback can be dropped
entirely.

Balance the enable_irq_wake() in tps65217_irq_init() by registering
disable_irq_wake() as a devres action as well. Only do so when
enabling actually succeeded, since the parent chip may not support
setting wake-up.

Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
Link: https://patch.msgid.link/20261002113624.178588-4-r.zhambakiev@prosoftsystems.ru
Signed-off-by: Lee Jones <lee@kernel.org>
[ sashal: adapted cleanup changes to the older I2C callback API and GNU89 variable declaration rules. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65217.c | 60 ++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index e11d325967c3d..2f5d9177d6718 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -155,6 +155,32 @@ static const struct irq_domain_ops tps65217_irq_domain_ops = {
 	.map = tps65217_irq_map,
 };
 
+static void tps65217_irq_cleanup(void *data)
+{
+	struct tps65217 *tps = data;
+	unsigned int virq;
+	int i;
+
+	if (!tps->irq_domain)
+		return;
+
+	for (i = 0; i < TPS65217_NUM_IRQ; i++) {
+		virq = irq_find_mapping(tps->irq_domain, i);
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(tps->irq_domain);
+	tps->irq_domain = NULL;
+}
+
+static void tps65217_irq_wake_disable(void *data)
+{
+	unsigned long irq = (unsigned long)data;
+
+	disable_irq_wake(irq);
+}
+
 static int tps65217_irq_init(struct tps65217 *tps, int irq)
 {
 	int ret;
@@ -178,6 +204,10 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 		return -ENOMEM;
 	}
 
+	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_cleanup, tps);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
 					tps65217_irq_thread, IRQF_ONESHOT,
 					"tps65217-irq", tps);
@@ -187,7 +217,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 		return ret;
 	}
 
-	enable_irq_wake(irq);
+	ret = enable_irq_wake(irq);
+	if (ret) {
+		dev_warn(tps->dev, "failed to enable IRQ wake: %d\n", ret);
+		return 0;
+	}
+
+	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_wake_disable,
+				       (void *)(unsigned long)irq);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -388,24 +427,6 @@ static int tps65217_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int tps65217_remove(struct i2c_client *client)
-{
-	struct tps65217 *tps = i2c_get_clientdata(client);
-	unsigned int virq;
-	int i;
-
-	for (i = 0; i < TPS65217_NUM_IRQ; i++) {
-		virq = irq_find_mapping(tps->irq_domain, i);
-		if (virq)
-			irq_dispose_mapping(virq);
-	}
-
-	irq_domain_remove(tps->irq_domain);
-	tps->irq_domain = NULL;
-
-	return 0;
-}
-
 static const struct i2c_device_id tps65217_id_table[] = {
 	{"tps65217", TPS65217},
 	{ /* sentinel */ }
@@ -419,7 +440,6 @@ static struct i2c_driver tps65217_driver = {
 	},
 	.id_table	= tps65217_id_table,
 	.probe_new	= tps65217_probe,
-	.remove		= tps65217_remove,
 };
 
 static int __init tps65217_init(void)
-- 
2.53.0

