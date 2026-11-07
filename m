Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048592;
	b=bp+6f3cZX4KBdRbg/EtHJmM4xKocVATH64q9HK4v7Cfp70/wd3vMwNXL7erAdsNu3ayK
	 0jfYCeKyE+t00SX9eXY8T4Tpl5Kj2bToPZG1wxeUtAdma/a/wkaE5vhSQNLpGL2u9CPVj
	 GsheTR+saGbvPFw0KITN2jheRjyndi791PT8y4/x2rzY3rRqmlXHty/4CshexmU6j82A5
	 DY4rjR1T2a/rGpKILtjbopHjDB2PamseB4VS1seczWLnnFvaEhstSvnnkqMXerToR39+w
	 AQQ5uZ/rAdC4puJ01EwoObHsb6u1qunh7F4YMOfIYuKfLocOqqaFKYzJ692AmzBttHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hKaBmfiosnJ4ZgyTESymXDHBUIcUzj1NXfyBcc/TPWU=;
	b=myvgsBRKbU15dtoQzhk/WnoGbS4/hkxRBTw4fhO7ON0ns1ip3Bcri/ANmv1a2aAG3l9m
	 x7q+og47bueaHQIdbKR4xV5Q4uTKYCpbAZc4NHaneeu3mqmHIlOEprH/mqLoFT79Rzyzu
	 YXyfPtYkZSyUr7lWoBBYYSB4lQnpJ7WEI8DBTBzHsnzOHiM1q98tasjB2+fHeZmtVTcdk
	 O1caCz/Xu26rvS2L1kl8kJW/tKKOBMO/L1s+B6UpyU0alVKAS+/KAnTanpQo9j+vCp+z+
	 O/rx+7FNPPhXx/XucsJFB+KILareik4ozR99Gyi1r+NUQkGOIcjbfhzCjVhxr9PheqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPtcimgg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A846606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPtcimgg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D031F008A4;
	Sat,  7 Nov 2026 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048592;
	bh=hKaBmfiosnJ4ZgyTESymXDHBUIcUzj1NXfyBcc/TPWU=;
	h=From:To:Cc:Subject:Date;
	b=lPtcimggYf29UqzJZFPk9hvZkIs7d9iFQWl+Qrx2y6GYrHzIup6kdMLPBuDQL+DK0
	 ctWxIxVMDkgM4FoEtrmPXq+v52OZqIFkPaGuv0mGIvj1amY2IlMKRW04vrJXagf1wt
	 YUlX6YaBWWJNycndLcO5j7S2FrZjJHfvlmilPdNYgUectvwp41KX39JckUG5MgBGG4
	 6kv4KuZtvylFSK2nn8/hKCMwhYwHA+1nvE9Eg/E9x7tNZMfBO+ZpwZrP8k0rKtdmap
	 KJxcKQXp99bgEfjN4UnSh/i4TlJW+SBL0f53Z55lRbt4YxAvKt3nF1q2VSCMa6gBxz
	 NBv5Qd4yaTkCw==
From: Sasha Levin <sashal@kernel.org>
To: r.zhambakiev@prosoftsystems.ru,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: tps65217: Use devres for IRQ domain and wake teardown" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:50 -0500
Message-ID: <20261107054950-failed-6.1-cffd44d2d895@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cffd44d2d89524e2dda6adc7b0dd59363be1c8e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054950-failed-6.1-cffd44d2d895@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cffd44d2d89524e2dda6adc7b0dd59363be1c8e6 Mon Sep 17 00:00:00 2001
From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
Date: Fri, 2 Oct 2026 11:36:54 +0000
Subject: [PATCH] mfd: tps65217: Use devres for IRQ domain and wake teardown

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
---
 drivers/mfd/tps65217.c | 57 +++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index ee640e3fcf7b4..569c28c8b20f5 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -146,6 +146,31 @@ static const struct irq_domain_ops tps65217_irq_domain_ops = {
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
@@ -169,6 +194,10 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 		return -ENOMEM;
 	}
 
+	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_cleanup, tps);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
 					tps65217_irq_thread, IRQF_ONESHOT,
 					"tps65217-irq", tps);
@@ -178,7 +207,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
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
@@ -379,22 +417,6 @@ static int tps65217_probe(struct i2c_client *client)
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
@@ -408,7 +430,6 @@ static struct i2c_driver tps65217_driver = {
 	},
 	.id_table	= tps65217_id_table,
 	.probe		= tps65217_probe,
-	.remove		= tps65217_remove,
 };
 
 static int __init tps65217_init(void)
-- 
2.53.0




