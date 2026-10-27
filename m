Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082017;
	b=sYeC7BbHi7ZtCh5MqEfTSU7PdfJoM6L3msSqZzbKVRgIBU1ONbhThCZTJ1WEHtyjr8aa
	 9vPFR64Ha1diM+/wVm5VKQI0TtQVhSezyPz6RMHmv6qu5Jhou4+BdW4dRP22MfeBObVKj
	 /E6BSBXpwPTia4VcUxSt3OH6b9DC0GoZi4S+DDncZn+x2XkA79nxgqQ9PrugpQd6eeFZT
	 u8HdlcZQ+7Ay5QmtxVrP+5pfY2N3ZiRaVSv1OALNOdQ1ToZZ9GhQwR29BXwrXmdtM3JxB
	 NWHXZyVa+QOGXzlcMY3/yB7cbj6pWfZ3ZrcGC06QdX5R3dh5AOsFqGq5VhEmxUQQWQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082017;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=D0qXlGYkhUaQu3BXG9i/Wn1oOUp7K31Eb/rzZABKwDo=;
	b=jcJ+dJFaui1rbhfDmuyfKgrZEHuizrs0gA5IRciqpg480pBfIWyTLCk9BKVBM0USR/tn
	 KgUxoBHIJeYE9wi4IbOagNMr4okSHyhHTTby7II8nQt6Q7JZq6w9W3umhdfO/6EUmS1LL
	 ToVMtNnBsFTY9TJSs83AZMzJdeAf1SJwYL89ekOVCfIlvADLRmepyPJyVYwie/u9reRC5
	 U3wlrAzEIxNrjkwaOHc2EPaYVgwS5utXWI0H1eGOoMfZWbwDmdoyQanGgPINdabjNKnFg
	 dxD5XC4QOGn9EGAgQa6lgj3fnTgDrsbvEh359QJYRu3l3BnDKVTKg4yWAl86Dxtlvlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jPtPxjwi;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97D606A31A;
	Tue, 27 Oct 2026 06:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E97D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jPtPxjwi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=D0
	qXlGYkhUaQu3BXG9i/Wn1oOUp7K31Eb/rzZABKwDo=; b=jPtPxjwit2x6XTQZmt
	H8aym7fgDWaGtCJgvhC30wG1UnHokG3JB2oZKyUpwfhzkypFXzrGIjbvvPV2GivA
	csiQWOCodYfH0No5IYc7p7obxUPbf91YK7x3tDT9f8+RL0ux70uny7omAIv+L6SR
	hufP28m5bhSe2b22u3dCd9xgk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3bweXQuBqPxjOCw--.9144S2;
	Tue, 27 Oct 2026 14:20:08 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] regulator: core: flush deferred disables before suspend
Date: Tue, 27 Oct 2026 14:20:07 +0800
Message-Id: <20261027062007.2226548-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3bweXQuBqPxjOCw--.9144S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DJF45Zr48Jw4UJr4ktFb_yoW5uFykpr
	W5XFZayr48uFyIva1Ykr47t3WYqrs7t397Zr97K3y3C3W3JF1xJF4kAry5ZF1kArykJrnF
	yryDAw4kC3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMpBhUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRiJw2rgQphRUAAA3O

regulator_disable_deferred() can leave hardware access pending while the
system enters suspend. Allowing that work to run during device suspend can
access a regulator after its backing bus has been suspended.

Moving deferred disables to a freezable workqueue is not sufficient.
DAPM uses deferred disables while suspending audio devices, and work queued
after the workqueue is frozen would leave the supply enabled until resume.

Mark the regulator core as suspending in the PM prepare phase. Flush each
regulator's pending disable work before device suspend starts. Process new
deferred-disable requests synchronously until PM completes. Synchronize
the transition with the regulator lock so a request racing with prepare
is either flushed or handled synchronously.

Fixes: da07ecd93b19 ("regulator: Implement deferred disable support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/regulator/core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 14422cfe80e2..160c588fbdd3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -44,6 +44,7 @@ static LIST_HEAD(regulator_ena_gpio_list);
 static LIST_HEAD(regulator_supply_alias_list);
 static LIST_HEAD(regulator_coupler_list);
 static bool has_full_constraints;
+static bool regulator_suspending;
 
 static const struct bus_type regulator_bus;
 
@@ -3463,10 +3464,15 @@ int regulator_disable_deferred(struct regulator *regulator, int ms)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 
-	if (!ms)
+	if (!ms || READ_ONCE(regulator_suspending))
 		return regulator_disable(regulator);
 
 	regulator_lock(rdev);
+	if (unlikely(READ_ONCE(regulator_suspending))) {
+		regulator_unlock(rdev);
+		return regulator_disable(regulator);
+	}
+
 	regulator->deferred_disables++;
 	mod_delayed_work(system_power_efficient_wq, &rdev->disable_work,
 			 msecs_to_jiffies(ms));
@@ -6327,6 +6333,24 @@ void regulator_unregister(struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
 #ifdef CONFIG_SUSPEND
+static int regulator_prepare(struct device *dev)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	regulator_lock(rdev);
+	WRITE_ONCE(regulator_suspending, true);
+	regulator_unlock(rdev);
+
+	flush_delayed_work(&rdev->disable_work);
+
+	return 0;
+}
+
+static void regulator_complete(struct device *dev)
+{
+	WRITE_ONCE(regulator_suspending, false);
+}
+
 /**
  * regulator_suspend - prepare regulators for system wide suspend
  * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
@@ -6380,6 +6404,8 @@ static int regulator_resume(struct device *dev)
 }
 #else /* !CONFIG_SUSPEND */
 
+#define regulator_prepare	NULL
+#define regulator_complete	NULL
 #define regulator_suspend	NULL
 #define regulator_resume	NULL
 
@@ -6387,6 +6413,8 @@ static int regulator_resume(struct device *dev)
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
+	.prepare	= regulator_prepare,
+	.complete	= regulator_complete,
 	.suspend	= regulator_suspend,
 	.resume		= regulator_resume,
 };
-- 
2.34.1

