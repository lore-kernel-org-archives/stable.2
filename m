Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410482;
	b=VxVqn5AKo7FzjRbNoAy/VM3PMyObCprqpMk6zZ+NVj7XNL5nrdPbZT/Qoan6ZOK8Zh1a
	 a3AHP3P81O0+6TIuzrGn8O1InmyE97HNL3rZjqTjSJxaR/2vR3mKc2pV5xLKGgycMe2EE
	 97WOCRp7mrKnaHn4JTrOclt/zLlkKv+tftul2/1bPHaXvHKIHt7sphYtqcAqqggU9lJmu
	 6SYnr6e2LNvE8sQKOyDs2hAuo6R12A8LLd8bW93eVMA+xKwipAiHT6y8/oc1v1pmDXxsn
	 aXeYIm7C50eO1x4OrFSLP3Q7dIclT+sOeJfvAiCDMmhT+XsmiXG1sDa3NTZTafrCsfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wDBeU35xYugDYyZ5e7wTh65DQFtc6Cv5K6qQiWRep0k=;
	b=Fqpwyt7Xb1w7Tgj3r7tTwxBrd/tHV1zbKeJAN8Bz0VAWwYC0+IcnREHbak955AFgb695
	 Xs/eewmW8NU+3LioXQ7sPSNmPrJmo3HOMggboniKqfNdMurNdgI/Dts3yc6uhCAH2LG5O
	 i7Ff+X4KyoDdK0eo1HTvbkU+BSlRbuebm59iwTQWZ1rf89OBRsNV690sobcnkAXq4rVX9
	 //aUiRqJE1Uuid6iytZzJk4Ld1o6cvoFSSpgGcQ8vFF0UYAefRExd/+kEc64KQyCJz6+J
	 2rTOQYsj7dGdVcyIoIdHD+eF2lLLkKbfkyA9mKySTMfWAFr39PQDSLKieo/qhFVrluw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHWUkJ7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE848606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHWUkJ7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0731F00A05;
	Wed, 11 Nov 2026 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410482;
	bh=wDBeU35xYugDYyZ5e7wTh65DQFtc6Cv5K6qQiWRep0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CHWUkJ7T5W3aP2F/0bzAVJ48VcFycEIE/VOCMpRQq8SWRZxzv1k3+LiUYm6TtYtQd
	 sxQKf1gAhVhmlSaLcyGo9H/eWj2o1K8qRBmSYwcPRe9hHx8PC6q0p3y3kFyZxPc0eU
	 gVjijyAwKWUSbVDsEUOLkouDd6mkiLJAl/pvAqxegFO0fCGuAwyFTXpdm/AbTvQdHv
	 PDqDHqF99qGZrSSuTRClfnB06o4lpfwGF5PkN7gMUNr2SMFKu+Es0AIiaNOaaxuTD7
	 omLWWvT4qznPMHuBKBbqQy5B20JUb45B8G7EQ119yaNeko9+YNQISK2aAL0wKYtt1M
	 Uf51NIxFzU+nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mfd: tps65217: Use devres for IRQ domain and wake teardown
Date: Wed, 11 Nov 2026 10:21:20 -0500
Message-ID: <20261111152051.2607119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054950-failed-6.1-cffd44d2d895@kernel.org>
References: <20261107054950-failed-6.1-cffd44d2d895@kernel.org>
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
[ sashal: Adjusted driver registration context to retain .probe_new instead of .probe. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65217.c | 57 +++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 0d050693d296e..df645d3f4673e 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -147,6 +147,31 @@ static const struct irq_domain_ops tps65217_irq_domain_ops = {
 	.map = tps65217_irq_map,
 };
 
+static void tps65217_irq_cleanup(void *data)
+{
+	struct tps65217 *tps = data;
+	unsigned int virq;
+
+	if (!tps->irq_domain)
+		return;
+
+	for (int i = 0; i < TPS65217_NUM_IRQ; i++) {
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
@@ -170,6 +195,10 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 		return -ENOMEM;
 	}
 
+	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_cleanup, tps);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
 					tps65217_irq_thread, IRQF_ONESHOT,
 					"tps65217-irq", tps);
@@ -179,7 +208,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
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
@@ -380,22 +418,6 @@ static int tps65217_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void tps65217_remove(struct i2c_client *client)
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
-}
-
 static const struct i2c_device_id tps65217_id_table[] = {
 	{"tps65217", TPS65217},
 	{ /* sentinel */ }
@@ -409,7 +431,6 @@ static struct i2c_driver tps65217_driver = {
 	},
 	.id_table	= tps65217_id_table,
 	.probe_new	= tps65217_probe,
-	.remove		= tps65217_remove,
 };
 
 static int __init tps65217_init(void)
-- 
2.53.0

