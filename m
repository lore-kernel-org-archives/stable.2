Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121F376BC1;
	Fri,  4 Sep 2026 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504606; cv=none; b=mypY2QjXxBYfwe5SX62P0XY5hh/IiZfFNyOHzD54LbdideYZ8JXTiDPPUTbd9H/M9Rv4XZDfImoi8R+Yyxb3REu3bh8IpGbyNIS/WuTYgms+zRu9i3S1hvJ4hlIKxE+CD6VaJ7xI+G0LctxpqIVwXVoc8noC23MdDxvYXlFIZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504606; c=relaxed/simple;
	bh=XG8zevKKubilijGzARFrK+wZJ1uU9YsdUIYe59odJps=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=S2EJ/jHopPAqKdc/N/QQ0Hv9RmdRaAfD26P3qU8rHdkpvZ8HjvYLQc4UZdfAXLLw7wkpvQzM0/SHgn/jFvjiQaTPLPfwUfVbRiHd+YBBApYedtnCQ/VeMlFgI2nOsioLX0bdWOfoHR4xHORm+gGpicmzd/d9/J0L4Ilk7Zh7s/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=XsGnl3xa; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="XsGnl3xa"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1788503689; h=from:to:date:message-id:subject;
	bh=TF7TNrOM0H21WevzHpDbSS/wqGFD8yi5wizZnlHpXCQ=;
	b=XsGnl3xaywfNZwxCUgyL3M4v/zaVWhO1Y5LbmUlC0BTvmToGG38E9jmeFI3npmbhI1UTruSkNSH
	VUTgh5SkSM0j42J5oeIwUS8MFEIqXAd6XLpnD9iWG9taTJ0oCTLtVikMWjqWE2cPq1AIchVNrFlnW
	U5PiZCf3ZP4JVzCYOfGr3i5VbM1hhF3eCpqmc/7c73JnwKkRpwNeE42Xv/rfPC0jQ74R0nuw2UeZd
	3uTqDWPIuJy7+2eFcvCQXm4IdcPrBuHKrndBY/JhxW7VdCOuda3twgBynbjySYZIl/0Ehwz8XEAjH
	/FkHMQ+TIvK6EMIGRugs1KUDf8/h1ar0Jm5g==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 4 Sep
 2026 11:34:49 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 4 Sep 2026 11:34:49 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 4 Sep 2026 11:34:49 +0500
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
Subject: [PATCH v3 2/3] mfd: tps65217: Check return value when masking
 interrupt sources
Thread-Topic: [PATCH v3 2/3] mfd: tps65217: Check return value when masking
 interrupt sources
Thread-Index: AQHdPDd8bCcAcABogkaeMpPT11PJfA==
Date: Fri, 4 Sep 2026 06:34:49 +0000
Message-ID: <20260904063439.69881-3-r.zhambakiev@prosoftsystems.ru>
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
2.55.0
