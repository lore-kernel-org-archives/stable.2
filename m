Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81C489FDA;
	Fri,  2 Oct 2026 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941031; cv=none; b=NYmXOwG2CE3IUzkZ2NJfWMtqgLHAbn+vR8LpBh97EN5y9x5xYOZyLWIo5AyU6P5FNqprP7dRjw4/h3tndwto8ZSI/ilsoWP2LkjTEwqEqNzjCWtcL0AJ0/aNDkXCi+LSndUCaLwBPKgu98rmvkoYlGZnxQYJ+ygdnK3R1gvGues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941031; c=relaxed/simple;
	bh=NaCYkI1G00trYByaw0uaM0k2sapodaZXCkiFMsMTx5U=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=Gro7UWoula2bVsd+1xVVtQMmjmOMcdJaRXxYNc0KnAMHDVSRpnaWCl4hYr6Dp+1SmQDel2W5ShM5cddOm/hRGiGdkLIJqB2hxLPaI7RUBm6RnaVGvfijdwMDKFaBkW4/hHKE0Pv6+FjTGSp6mJCXZZMsTSnUCpRjHNtonfvlbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=qFN0WXtp; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="qFN0WXtp"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790941019; h=from:to:date:message-id:subject;
	bh=fCeavswF5BlvSCbN1CBFz4/UXgQcSMaa2MR0ZFcoCHM=;
	b=qFN0WXtpjHPb2XqtiV7XGHhuKVqv+MlH9ND5FTHeeBZgbW7KawaHtobpLRdzD5i040JYm4q2ZsD
	+e3y59/FKddkDyPsEJjjglBu3t6pY61a7DS1DSfIKd5/o3WtORYhuQ4QHmEcg61FMnZ59L/tuYPYB
	RnHv3LDMohhOS7DvKTGK3QYefKC3it7netP/cLgIdERmQ57QcBaJ2XCLLSDbo2a/skmngbNugVl0H
	rVmKnRrJ1XbVcsTPbFoyDvjrA8DNoq/oiiGu1HkCSMHRF4iL9IQOOInEFFevfUT4SIN5FJZNgleWC
	pAC7+ckierGt9wxk+XHdusH6KDM2sXSeBx0A==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 2 Oct
 2026 16:36:58 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 2 Oct 2026 16:36:54 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 2 Oct 2026
 16:36:54 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, Lee Jones <lee@kernel.org>, Grygorii Strashko
	<grygorii.strashko@ti.com>, Marcin Niestroj <m.niestroj@grinn-global.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v5 3/3] mfd: tps65217: Use devres for IRQ domain and wake
 teardown
Thread-Topic: [PATCH v5 3/3] mfd: tps65217: Use devres for IRQ domain and wake
 teardown
Thread-Index: AQHdUmJTAnguTHBVGUmMf3OuSsgVsw==
Date: Fri, 2 Oct 2026 11:36:54 +0000
Message-ID: <20261002113624.178588-4-r.zhambakiev@prosoftsystems.ru>
References: <20261002113624.178588-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261002113624.178588-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

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
---
 drivers/mfd/tps65217.c | 57 +++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index ee640e3fcf7b..569c28c8b20f 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -146,6 +146,31 @@ static const struct irq_domain_ops tps65217_irq_domain=
_ops =3D {
 	.map =3D tps65217_irq_map,
 };
=20
+static void tps65217_irq_cleanup(void *data)
+{
+	struct tps65217 *tps =3D data;
+	unsigned int virq;
+
+	if (!tps->irq_domain)
+		return;
+
+	for (int i =3D 0; i < TPS65217_NUM_IRQ; i++) {
+		virq =3D irq_find_mapping(tps->irq_domain, i);
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(tps->irq_domain);
+	tps->irq_domain =3D NULL;
+}
+
+static void tps65217_irq_wake_disable(void *data)
+{
+	unsigned long irq =3D (unsigned long)data;
+
+	disable_irq_wake(irq);
+}
+
 static int tps65217_irq_init(struct tps65217 *tps, int irq)
 {
 	int ret;
@@ -169,6 +194,10 @@ static int tps65217_irq_init(struct tps65217 *tps, int=
 irq)
 		return -ENOMEM;
 	}
=20
+	ret =3D devm_add_action_or_reset(tps->dev, tps65217_irq_cleanup, tps);
+	if (ret)
+		return ret;
+
 	ret =3D devm_request_threaded_irq(tps->dev, irq, NULL,
 					tps65217_irq_thread, IRQF_ONESHOT,
 					"tps65217-irq", tps);
@@ -178,7 +207,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int=
 irq)
 		return ret;
 	}
=20
-	enable_irq_wake(irq);
+	ret =3D enable_irq_wake(irq);
+	if (ret) {
+		dev_warn(tps->dev, "failed to enable IRQ wake: %d\n", ret);
+		return 0;
+	}
+
+	ret =3D devm_add_action_or_reset(tps->dev, tps65217_irq_wake_disable,
+				       (void *)(unsigned long)irq);
+	if (ret)
+		return ret;
=20
 	return 0;
 }
@@ -379,22 +417,6 @@ static int tps65217_probe(struct i2c_client *client)
 	return 0;
 }
=20
-static void tps65217_remove(struct i2c_client *client)
-{
-	struct tps65217 *tps =3D i2c_get_clientdata(client);
-	unsigned int virq;
-	int i;
-
-	for (i =3D 0; i < TPS65217_NUM_IRQ; i++) {
-		virq =3D irq_find_mapping(tps->irq_domain, i);
-		if (virq)
-			irq_dispose_mapping(virq);
-	}
-
-	irq_domain_remove(tps->irq_domain);
-	tps->irq_domain =3D NULL;
-}
-
 static const struct i2c_device_id tps65217_id_table[] =3D {
 	{"tps65217", TPS65217},
 	{ /* sentinel */ }
@@ -408,7 +430,6 @@ static struct i2c_driver tps65217_driver =3D {
 	},
 	.id_table	=3D tps65217_id_table,
 	.probe		=3D tps65217_probe,
-	.remove		=3D tps65217_remove,
 };
=20
 static int __init tps65217_init(void)
--=20
2.53.0
