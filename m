Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905D419FBB;
	Fri, 21 Aug 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298849; cv=none; b=RNkWm4k0HnloCBxXDBytyMsqLdoRUc6kfUDnzEAYcs2UhevrAxWCKbHPzT7jTPwrptaYA/d1n4N2xkwxej/qlDW/79HnsC9nYQV+z8By2kwybmeUbyxRL4X5tmPSVccf+OQcILxDbsqah0+GO4JPRfaRWnDg/n1QtZ/URrkzS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298849; c=relaxed/simple;
	bh=v9Uks2YX9bo6AmhoTDp/QPHUwX6o/1CJTfC/Z5FtFt8=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=JAzEIxkBRWqEgBQai7Mn/akMCLEERk9q+SETp6lBTk2Ay2FC+4pww523ajtmwdWhhTwFdweg0oRrtZ7l9CJkQH9vt7HJZbhW5GxswcCFRJAwqgDV2PbbQgfbxHnhf1aWwk7OALjiwtlNRg9VQpTFyepFpiJTdVFeoCJaMjr9+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=ohrtSkRO; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="ohrtSkRO"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1787298842; h=from:to:date:message-id:subject;
	bh=d80hrUiBWS9VMj9C77oH8JPtF3ywVPvFIRx5zJTX2u4=;
	b=ohrtSkRO3AjfnuG92xRF8lPJsqnSbhKORWGPolUTnWlDj9HrFFc6WgzuNPsGI0U7nFvjGKgWjLx
	5TAFJUAxhcoB6LaHMn2YHWFbujli9tyxyg2vSYUg0xnqncmlgmPMcO+13y5y+ih74p6cRQxSa6u11
	Lb82DKpr6jEJClSIFsDM7XvQFgbmHeeKGV63V3/eLSrgAnlPxWe19k9ljPDHO1GB02qq1ddjyv1Hz
	8szpd2RvO5n+LYw/p0rAbz4mHbPBmAdy5iO30BXDpTOC6xYroKM2GTWWoNSIENjLyAnqq+qAIuCfz
	bbQYjrsB5nJUdmJmnZydBnuYqiuSnUKCxt8Q==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 21 Aug
 2026 12:54:02 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 21 Aug 2026 12:54:03 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 21 Aug 2026 12:54:02 +0500
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
Subject: [PATCH 2/2] mfd: tps65217: Check return value when masking interrupt
 sources
Thread-Topic: [PATCH 2/2] mfd: tps65217: Check return value when masking
 interrupt sources
Thread-Index: AQHdMUI7Rk6iTnyhQ025GACpPton4A==
Date: Fri, 21 Aug 2026 07:54:02 +0000
Message-ID: <20260821075331.131315-3-r.zhambakiev@prosoftsystems.ru>
References: <20260821075331.131315-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20260821075331.131315-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

tps65217_irq_init() ignores the error returned by
tps65217_set_bits() when masking all interrupt sources. A failed
register write leaves the driver's software mask out of sync with the
hardware and may result in spurious interrupts.

Check the return value and propagate the error to the caller.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/mfd/tps65217.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 2d04d9e0ae29..9a1528456ffc 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -155,8 +155,13 @@ static int tps65217_irq_init(struct tps65217 *tps, int=
 irq)
=20
 	/* Mask all interrupt sources */
 	tps->irq_mask =3D TPS65217_INT_MASK;
-	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
-			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
+	ret =3D tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
+				TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
+	if (ret) {
+		dev_err(tps->dev, "Failed to mask interrupt sources: %d\n",
+			ret);
+		return ret;
+	}
=20
 	tps->irq_domain =3D irq_domain_create_linear(dev_fwnode(tps->dev), TPS652=
17_NUM_IRQ,
 						   &tps65217_irq_domain_ops, tps);
--=20
2.53.0
