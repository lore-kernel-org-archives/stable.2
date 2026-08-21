Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F648B395;
	Fri, 21 Aug 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315861; cv=none; b=aC7KJJKs2WPdvhPxdAc64p1A8qN1jaostFzVbz0Qcnmk3UcrGwo+UiSmsd3ds7cDdBAVr96L1JYq26AsC7aai1ANredAQQZK5CcC0KCH2akRdtZ5hbvWzXuUGKFnrh1gIVzErUaPgq5iNRZ9PNXwBzwV/GQfDdC8aiRejMHxE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315861; c=relaxed/simple;
	bh=e/Fa50/CummRDlZ7sImJGXsTgN4omMdAiv7P7B2ZML0=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=pQsc7/qr8chMulW/JHaSVJzh3NRCIfsZEo1NqKvSB0fOPPFKRZXbIO41yh4R/+lT2qrOrx6xqr+ws9KBX92tvq8unm/yLxsk/h9dVQYsEdLhHqcJjsVnq/fvezdRkixJ57StwH1vZQwEpUw1bydjFf9VwDX67LMWlCAqbuxCtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=BQAqCoK6; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="BQAqCoK6"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1787315843; h=from:to:date:message-id:subject;
	bh=XYkyw36GshbqiHeczuFbIPvlMKBtrATsFchm2ZRpZBM=;
	b=BQAqCoK6bwNnYn8+4hhjZDH2ly6HStnDEBY7UrK1ib4S3rvflRabqUB9sLvRNKacJ9FVLXXnD3I
	7TBVZGRnmy+4UKkXK1hMiKLMZw3Wew4dqW/Qz2Crf3zk/HaY2/+XdCOoJC9CXE4DCEHXpvlt9yEY4
	BTuxAI2w0V4EwPD6PUzpqRJ2WK1X6tGAwTqn9lJIzxVS5qxlmotqWBe4pKN6s9mevNrbub7sF8t5x
	oHcmpb6jlGDets/qAaXUhe0M2JyBOuoMN2VQ5hsNimKnFoRaeXJ1A+pT3+ywqejfS10oz7RL792eT
	cSoM2EX9n1ki0pxS1JiIol+1LSMibQm6vQkw==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 21 Aug
 2026 17:37:23 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 21 Aug 2026 17:37:23 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 21 Aug 2026 17:37:23 +0500
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
Subject: [PATCH v2 3/4] mfd: tps65217: Fix irq_domain leak and use-after-free
 on probe failure
Thread-Topic: [PATCH v2 3/4] mfd: tps65217: Fix irq_domain leak and
 use-after-free on probe failure
Thread-Index: AQHdMWnQ81P9a6OqRkmKvYx9IGH1Rg==
Date: Fri, 21 Aug 2026 12:37:23 +0000
Message-ID: <20260821123712.260443-4-r.zhambakiev@prosoftsystems.ru>
References: <20260821123712.260443-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20260821123712.260443-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

If tps65217_probe() fails after the irq_domain has been created, the
domain is never removed. The tps65217 structure is freed by devres,
leaving the globally registered irq_domain with its host_data pointing
to freed memory, which would trigger a use-after-free if the domain is
ever looked up again, and leaks the domain otherwise.

Move the chip revision read ahead of the IRQ initialization so that
child devices are only probed once the chip has been validated, and
add a cleanup helper that disposes the IRQ mappings and removes the
irq_domain. Call it from the devm_request_threaded_irq() error path in
tps65217_irq_init() and from the devm_mfd_add_devices() error path in
tps65217_probe().

Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/mfd/tps65217.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 9a1528456ffc..d535d140c2e9 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -146,6 +146,24 @@ static const struct irq_domain_ops tps65217_irq_domain=
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
 static int tps65217_irq_init(struct tps65217 *tps, int irq)
 {
 	int ret;
@@ -176,6 +194,7 @@ static int tps65217_irq_init(struct tps65217 *tps, int =
irq)
 	if (ret) {
 		dev_err(tps->dev, "Failed to request IRQ %d: %d\n",
 			irq, ret);
+		tps65217_irq_cleanup(tps);
 		return ret;
 	}
=20
@@ -337,6 +356,13 @@ static int tps65217_probe(struct i2c_client *client)
 		return ret;
 	}
=20
+	ret =3D tps65217_reg_read(tps, TPS65217_REG_CHIPID, &version);
+	if (ret < 0) {
+		dev_err(tps->dev, "Failed to read revision register: %d\n",
+			ret);
+		return ret;
+	}
+
 	if (client->irq) {
 		ret =3D tps65217_irq_init(tps, client->irq);
 		if (ret)
@@ -354,13 +380,7 @@ static int tps65217_probe(struct i2c_client *client)
 				   tps->irq_domain);
 	if (ret < 0) {
 		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
-		return ret;
-	}
-
-	ret =3D tps65217_reg_read(tps, TPS65217_REG_CHIPID, &version);
-	if (ret < 0) {
-		dev_err(tps->dev, "Failed to read revision register: %d\n",
-			ret);
+		tps65217_irq_cleanup(tps);
 		return ret;
 	}
=20
--=20
2.53.0
