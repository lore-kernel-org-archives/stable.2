Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411529;
	b=JtRvr4NvRzQZ58qAM+xbd365g8lah+RJpo+F469j2QMVqz/aTbViNp6bssHpD6mWS6Ql
	 /rDWSHzrFjsiWkBiDpk+eb5kwhf/rRn5FD/FkaicyNlU4niXla0lavm7gCr6qiQ16sTCL
	 ngnEyfId1lye25hnhYB/OD/gT/cUd+M5Lwds8n0CfKzbLL+cNYdkIUMmIbPVz28AK5GDr
	 u+EzKQ7J85OQhG3t2QiXgarHDg3Ev66XO/yGUUtHnP4nUnIsUUkfGc//GPegC3TcfujY6
	 wRrXryU7FEFnML4HsvUR2m+Vb5VNW5cgx3CzFWmZ3q6g5uRXOFwMTVih5xnOzxipb+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=36bxOPDe3wlnXvJDV8rnif/i4RQWosBUYAxyzTH6v4A=;
	b=2FnClzWEpXeY9bdJV/kodIf2hI+eB++8frhWer6K1ijPpR/L5/QuaQHbXAQvM358ki/g
	 f3MEBIR/RBRTn8bIbnsBaf+pegwr62SeWg+HXh2x8LR3tYNbp+YTRqNguTvBdCLX5/k6m
	 czaB3aa+fLyFuxgWIEqAkREseacHC/mzrNG+eQJfglCM/TcYfIh4bc97sxHWgVnMGpnnt
	 PKIA4I3GReCunJ7Gbon/RqYcVjvZOhiAqQY99Q6Ix1+Xlv/DIb0veFMsuIr8vcXPp3V2b
	 DVELW6wKjUO2Pv9hH2C5BE5Cm8TRd+ceZn0QlQaizVXzfMwXmyA/LLhI5Ie2popk1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xh84Dw5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D73606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xh84Dw5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562C41F00A07;
	Wed, 11 Nov 2026 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411528;
	bh=36bxOPDe3wlnXvJDV8rnif/i4RQWosBUYAxyzTH6v4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xh84Dw5j2eP6NpLPcZyrXrIifJE/ruF9jkNnZzvkjWvayqLUWu/ADQ/49xHlZw9uZ
	 vHRRCCX3ksX56uqOH9laXTkUvKPIpqhKzRrNlOgFw1P3QlLmXXwxA2QxwdmMkHHmlN
	 BRz90dITkmOAhods7FME6r104yuxpWzfv3aBKWoUJZBlnsALwW2jGw3zmhXrCNCNdn
	 RTE6oe/XMkYsOkt4x4RC1W5hQSk4MZlqC4I9WryK3TkxBh8Cj92zG2RVyRXLnByGTf
	 AxMEGHp4CI5SwDEJmFa3O8DGm7FkNEe7Yq6Uzn5vM6rWJ5ZkDBmroqqa6fCSqdOy+8
	 A6/eQK18nf35w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mfd: tps65217: Use devres for IRQ domain and wake teardown
Date: Wed, 11 Nov 2026 10:38:47 -0500
Message-ID: <20261111153828.2735139-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062359-failed-5.10-cffd44d2d895@kernel.org>
References: <20261107062359-failed-5.10-cffd44d2d895@kernel.org>
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
[ sashal: moved the loop variable declaration outside the for statement for compatibility with older C syntax ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65217.c | 60 ++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index ca81623a74389..43dbcdb7f35cc 100644
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

