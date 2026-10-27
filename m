Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082380;
	b=jefogaAs9OToKoqP5b2mMsDWQ6P+809PERm2VeY7xj4+NdwLVYqaO3zK7gBj1UR4CWZJ
	 U6ufllAbXX4OwZDiWfsKXyzZeQ6c33wZ7BXMQriekYUvk93h9SFWX2MPRYBFYURuXmhU5
	 HCB1GOrr89Al2l1JsfAbaxL1mRoOuh5L3pOf9SIeECtk6qkAOlJkX+iQFBkJS97iFJfFI
	 uBJ8IWwzUObrTFZfen3m9+cg6Hi6dlhUtDdb1CGLLF9VoLwe0DS1Ntl30oUjgY4zHsqN5
	 kZsuRCuKHTvDSW5XM8TNCzLjj5ONpHI1nN3pREbACoZqQn2V+/2p7e8o6D/eTIsV7yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082380;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=V9ApAIzeT+M/XO21y1Qv5W9e8U1mznozVnK/qq4x5Q0=;
	b=KQMGdBC9ZSzJ50NoGVr7gH4gJnnWBfL9ByeUBHrhsYuy7MgeMlFVwN6SituBbsN5FE38
	 L74zYz3m9MN1PbPg7QHMDEG+ZcchlEHhyk3rVBaOEtjGEh91t8rNJFtPpMJlX2llqI8oh
	 gTUu323EQNFkqndza905QWOuYPYOTArHGrhbrDleZX3Lb2DM4p8YAdcnVMCrcTBDSljf4
	 I7ClCDb+eOMSp3k51JZGYS7xuGusVJ0frQLHMZa8GrfEcnQU+WGKw7CsesNRGkZ0VqfxY
	 edClfY1LqxeOFzxJlwNv7ifOPnAw6bVKauC5eCDPLSFn+3KxpayrmTeeqlxKfKApRwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jDAFmca7;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91617606A320;
	Tue, 27 Oct 2026 06:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91617606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jDAFmca7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=V9
	ApAIzeT+M/XO21y1Qv5W9e8U1mznozVnK/qq4x5Q0=; b=jDAFmca7cnW3+Z5ITV
	pvcqXp66Nk3FMD+ePqJFCXoY9if4twOkyHCVlxlMxVcELxeLqb8Zum1o6GQUbyo7
	opsrP4KmVhQmEg3UilQ5n22MpOUrmvWoPToTjEj0nBCxF014ycQxJALsx361NcOc
	z66rVe/9ZLWfUg17dq8my6paA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3v77+Q+BqYq0mCw--.52012S2;
	Tue, 27 Oct 2026 14:26:06 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] regulator: core: flush deferred disables before suspend
Date: Tue, 27 Oct 2026 14:26:05 +0800
Message-Id: <20261027062605.2233921-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3v77+Q+BqYq0mCw--.52012S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DJF45Zr48Jw4UJr4ktFb_yoWrJF17pr
	W5XrZayr48uFyIva1Ykr47t3WYqr4kt397Zr97K3y3C3W3JF1xJF4vyry5ZF1kArykJwnF
	yrWDAw4kC3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNvttUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8ADjHmrgRAA7cQAA3J

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
Changes in v2:
- Flush pending disables during PM prepare instead of freezing the work.
- Process new deferred disables synchronously until PM completes.
- Synchronize requests racing with PM prepare using the regulator lock.

Link to v1: https://lore.kernel.org/all/20261016100522.2582557-2-yaojiale02@163.com/
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

