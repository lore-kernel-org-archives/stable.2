Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83B357CFE;
	Fri,  4 Sep 2026 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503767; cv=none; b=aoQJDAbqfIJR3tJygyFB/PToPtrK3mhAFtkFPtF81BVraidfpnueE6tw3WJy4d4J9yhCdt7iGTai5Cnc6XqkiraGuzFEczrFH5ZjnfEE0Z5wLBo8oylE6IGFAFYPy96Kp1m+8fYpGMbju4Un3VsG3/kwgiTQ5HU5TDAh1okJ3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503767; c=relaxed/simple;
	bh=Sr5z2khyE7oxPP8N1SJ67rnrsXky8jvMj7M8fTXvjgM=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=IBb3QvOjTkOflSjCmDWsCZ/Gbo/4RzTptI6Pu8tB5aMf17SQuO3DAav5y8Lx51F7O6HwVXDHnGKY6Q6w8i70JtYBZATXtsLsq3Jd80xKTGK1OmXRwFby+74mNgW+vDb6ITymu4ekMs4NSZoZKgOI6oc8DG2bxWXW4UrGtVkY5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=aFySTzou; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="aFySTzou"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1788503692; h=from:to:date:message-id:subject;
	bh=Xb2AMWxTPtB43313I9f0fpt4Huw3RGfytDf9R/zyYIc=;
	b=aFySTzouKlw4mOWq9su+gnpjGu+jnbl3OSMkYI/CSSQMXyQequHRX8VpVoOWBxpUTPLS4wEL5mb
	E8JQOTT8a/030WRub9HK+UY7ayy003g50BW8KypxEEL/Cbp1kTXPiOWGXSuRDq5vSnacrOtpLussf
	1oSgfWrlEwpWXXp2x6M9a+zM3J6dppdCkTJ+u5+pSs+Cycql3b1Vvk5J7570yWEcXdfFAIRax0dVn
	ibAu9L9Ih48WZZrdoSlKvmOL5PH5J6VfLW4yy9HIVh07/MLtSLDAK9vKvloayI8xU1XdKyXtmPrqn
	FnFdfsfb6cGyrrvhYDGLkg1XfFhEU9ksN8mg==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 4 Sep
 2026 11:34:51 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 4 Sep 2026 11:34:52 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 4 Sep 2026 11:34:52 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, Lee Jones <lee@kernel.org>, Marcin Niestroj
	<m.niestroj@grinn-global.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v3 3/3] mfd: tps65217: Use devres for IRQ domain and wake
 teardown
Thread-Topic: [PATCH v3 3/3] mfd: tps65217: Use devres for IRQ domain and wake
 teardown
Thread-Index: AQHdPDd9oXVGJ4sCjkm3Fq1ZVn5vTQ==
Date: Fri, 4 Sep 2026 06:34:52 +0000
Message-ID: <20260904063439.69881-4-r.zhambakiev@prosoftsystems.ru>
References: <20260904063439.69881-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20260904063439.69881-1-r.zhambakiev@prosoftsystems.ru>
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
 drivers/mfd/tps65217.c | 68 +++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 9a1528456ffc..2d799b60c79b 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -146,6 +146,36 @@ static const struct irq_domain_ops tps65217_irq_domain=
_ops =3D {
 	.map =3D tps65217_irq_map,
 };
=20
+static void tps65217_irq_cleanup(struct tps65217 *tps)
+{
+	unsigned int virq;
+	int i;
+
+	if (!tps->irq_domain)
+		return;
+
+	for (i =3D 0; i < TPS65217_NUM_IRQ; i++) {
+		virq =3D irq_find_mapping(tps->irq_domain, i);
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(tps->irq_domain);
+	tps->irq_domain =3D NULL;
+}
+
+static void tps65217_domain_release(void *data)
+{
+	struct tps65217 *tps =3D data;
+
+	tps65217_irq_cleanup(tps);
+}
+
+static void tps65217_irq_wake_disable(void *data)
+{
+	disable_irq_wake((unsigned int)(unsigned long)data);
+}
+
 static int tps65217_irq_init(struct tps65217 *tps, int irq)
 {
 	int ret;
@@ -170,6 +200,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int=
 irq)
 		return -ENOMEM;
 	}
=20
+	/*
+	 * Devres actions are released in reverse order of registration,
+	 * so the domain is torn down after the parent interrupt and the
+	 * MFD children, which are registered later in probe, have
+	 * released their IRQs.
+	 */
+	ret =3D devm_add_action_or_reset(tps->dev, tps65217_domain_release, tps);
+	if (ret)
+		return ret;
+
 	ret =3D devm_request_threaded_irq(tps->dev, irq, NULL,
 					tps65217_irq_thread, IRQF_ONESHOT,
 					"tps65217-irq", tps);
@@ -179,7 +219,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int=
 irq)
 		return ret;
 	}
=20
-	enable_irq_wake(irq);
+	ret =3D enable_irq_wake(irq);
+	if (ret) {
+		dev_warn(tps->dev, "failed to enable IRQ wake: %d\n", ret);
+	} else {
+		ret =3D devm_add_action_or_reset(tps->dev,
+				tps65217_irq_wake_disable,
+				(void *)(unsigned long)irq);
+		if (ret)
+			return ret;
+	}
=20
 	return 0;
 }
@@ -380,22 +429,6 @@ static int tps65217_probe(struct i2c_client *client)
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
@@ -409,7 +442,6 @@ static struct i2c_driver tps65217_driver =3D {
 	},
 	.id_table	=3D tps65217_id_table,
 	.probe		=3D tps65217_probe,
-	.remove		=3D tps65217_remove,
 };
=20
 static int __init tps65217_init(void)
--=20
2.55.0
