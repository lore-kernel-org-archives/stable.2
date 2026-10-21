Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584992;
	b=d8iYrQO9QtKwC3OYgE00jn1U3j9qRu8RCfLQ7NrvHpPLXeRP9uwQMxE3b71dIa9GByI0
	 EElXwz7vti8+9CNZfci9Co1cFZBocCqP0pllVtqb2GW2IrP/L79BRYZ2U1YslcbSR6kv1
	 wcqNV5U2Y7U1Ltnf/fFNOCHxcYMK+AmH+SaBWkXbor3JF/DHxhClGHU+Ez3rnmWDAYhSD
	 2BSsVyxTxTuQBMqsZdyxlWnuo5f57JT/2+cjtkZaDZjQmQPPlvbdiQmeuwqccMzTxfXWG
	 Jf1BTWkjMQ7un3XjOUbg/xDV5z9qL8JDEf/fMe2+mq1bZzBR4VM1/4OWppVkD7qf8WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=47JPxnKtn88z3FWrX9k+DRLaFxM6US7BskZPlDapUxU=;
	b=gLSQEsiOm40TLyGhmiIwyTgnyomIz05u3etOCyReAHDgLnm8Jwr/vxwZ3MK5EFwGTdbc
	 hIPIJaKroUpL9opSWBruaNsPo/oI3blTuzUDU90Qv2kYTinDoCzPjeIrAWWsK9RHt4hmn
	 HtJbqnWtk+M//gbqoPQmc3PZLHh0RtwjDtD4RQ16kIaUSBj3FvPidI/ytHC8GIQcc1PLx
	 38veuN6i36GNEDQE+hBEid4ad811oCG2OkBNTpdTx1MMDXQLnytVe+OCvfuMxLiS5Nt9b
	 zxstXWtCAM5WckBXs2KjrNfhq+hp06C9cD7HJqtSHHoFCAjK9ncqQm3vMPzZ6sQUGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HTiFI/gR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F8606A319;
	Wed, 21 Oct 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTiFI/gR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC531F000C4;
	Wed, 21 Oct 2026 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584992;
	bh=47JPxnKtn88z3FWrX9k+DRLaFxM6US7BskZPlDapUxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HTiFI/gRAcXJTgd7xuiXoBfiPSvqelwO/3RGk7rZqNg9NEI06XjAWsSMka1CZWFeq
	 Oda3v69dDUnNcFSn8LTRVg06ujoNhH5JZH7FgG7PKjMckKMz+LYx2GrGH/+pOMTloO
	 wsR6Ov/rFgIamo696hV23UrspCuwcexBH9nSoEST4GbaxoZTRXmgHgLv+GEBff7E/C
	 iknsZ3pM2HH7E+6p4sf5mZNYPYOJhx8tUz2LAoKTxb1Fz4tNNesUL4l8Oq9r6FnIYh
	 UZ8Gb467kxSKG6wa3kG9sO95Pwvm3ZaeElzfUDeYRBYYJaNnabtu6gta6/T3O4gJ4o
	 CFmpji5cAy1jA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	AnilKumar Ch <anilkumar@ti.com>,
	Milo Kim <woogyom.kim@gmail.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 24/28] mfd: tps65217: Manage IRQ domain teardown via devres
Date: Wed, 21 Oct 2026 12:09:46 +0000
Message-ID: <20261021121245.3111563-24-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

tps65217_irq_init() creates tps->irq_domain with an unmanaged call and
requests the parent interrupt via devm_request_threaded_irq(), while
tps65217_remove() manually disposes mappings and removes
tps->irq_domain.  Because tps65217_remove() executes before devres
teardown, the IRQ domain is destroyed while tps65217_irq_thread() and
child MFD devices are still active, allowing a concurrent interrupt to
dereference a freed or NULL domain.  Furthermore, if probe fails after
irq_domain_create_linear() or if tps65217_irq_init() fails, the IRQ
domain is leaked, and if the device is probed without an interrupt
(client->irq == 0), tps65217_remove() unconditionally passes a NULL
tps->irq_domain to irq_domain_remove().

Register a devres action to tear down the IRQ domain in
tps65217_irq_init() prior to devm_request_threaded_irq(), propagate
errors from tps65217_irq_init() in tps65217_probe(), and drop
tps65217_remove().

Fixes: 40a50f8b307d ("mfd: tps65217: Fix page fault on unloading modules")
Closes: https://sashiko.dev/#/bug/linux-7e358c08-6d75-48be-87d2-35dc037ea953
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/tps65217.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index c240fac0ede7..a1e9b9e22d82 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -146,6 +146,21 @@ static const struct irq_domain_ops tps65217_irq_domain_ops = {
 	.map = tps65217_irq_map,
 };
 
+static void tps65217_irq_exit(void *data)
+{
+	struct tps65217 *tps = data;
+	unsigned int virq;
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
 static int tps65217_irq_init(struct tps65217 *tps, int irq)
 {
 	int ret;
@@ -165,6 +180,10 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 		return -ENOMEM;
 	}
 
+	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_exit, tps);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
 					tps65217_irq_thread, IRQF_ONESHOT,
 					"tps65217-irq", tps);
@@ -333,7 +352,9 @@ static int tps65217_probe(struct i2c_client *client)
 	}
 
 	if (client->irq) {
-		tps65217_irq_init(tps, client->irq);
+		ret = tps65217_irq_init(tps, client->irq);
+		if (ret)
+			return ret;
 	} else {
 		int i;
 
@@ -373,22 +394,6 @@ static int tps65217_probe(struct i2c_client *client)
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
@@ -402,7 +407,6 @@ static struct i2c_driver tps65217_driver = {
 	},
 	.id_table	= tps65217_id_table,
 	.probe		= tps65217_probe,
-	.remove		= tps65217_remove,
 };
 
 static int __init tps65217_init(void)
-- 
2.56.0.218.g1ec904b173-goog

