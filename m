Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118049219A;
	Fri, 21 Aug 2026 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315866; cv=none; b=OjDtlYNle0bwb/n+SC/QzGktF1bb14Cy84AwNfnk38/N1wvp8mRfi/JSxnpe5hHuRZrcrCSsWALmNLIVQ+cyVxgQUsHofsO/lbN99nC4rH+rIj2c/vjAWvbYul6miqFJn3U36S9RDZWDehtCCcXQj76yy4MPsOraSbsniYd2K2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315866; c=relaxed/simple;
	bh=QQjm2GmHpBVqtboSSE+zHgs3EJOLNgHB8rTbdRvO7R0=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=SDQw07jLxx7XklzH0+1J0mvBMVkOFGEc3GI9lCST5zsJA+5O02jxFpF9xZbG81cct1G9pJJBP5Qp3zgce6rhilDuQeJpDvBn0ztIowRX+oDLc6N1380gewLG63O2GWE/xkLQd8hOvjsluEPRSXra3u0WlpfV2+ltYJYSSLmfnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=rRjLcQMb; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="rRjLcQMb"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1787315844; h=from:to:date:message-id:subject;
	bh=pVyg+sRmLUiXHUrQAB7im6I5hG/9jBXuIklitVVFzW4=;
	b=rRjLcQMb+M7y5EW5C6T6eOpEoVyXBuCvA/dKSafe4JjujDj0aM7n0tE0Za7C9GpWhJclCettgMy
	5Mj+Iga27mmAGa87JcUPYxRVhkwThNxqyS5ZbfilYVZ8tmvmPTvoMNcNALJtCHYjrQFW0f79YQ9jZ
	5cz+1v+OVtCje8dQRhDa7dw9sWF+pHH+lcArfeZqTqt6YdeZzHIEjBb1IGqDOmEEQwftdgKwSZMi/
	P1E+j4ECEbomC0FI5do9KX7z6fBmavjt30Tsq6YgyoVQQl4t5Z5qWDV/fkrj6PvJLZPWBOhYnD7Xm
	RzgRmCwIUtQGrH0jGWTZXNAgr3bUQNdd6WYA==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 21 Aug
 2026 17:37:24 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 21 Aug 2026 17:37:24 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 21 Aug 2026 17:37:24 +0500
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
Subject: [PATCH v2 4/4] mfd: tps65217: Fix NULL pointer dereference in remove
 callback
Thread-Topic: [PATCH v2 4/4] mfd: tps65217: Fix NULL pointer dereference in
 remove callback
Thread-Index: AQHdMWnRS8V7I03LlU+ecIp2Xsdc7Q==
Date: Fri, 21 Aug 2026 12:37:24 +0000
Message-ID: <20260821123712.260443-5-r.zhambakiev@prosoftsystems.ru>
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

When the device is probed without an interrupt, tps65217_irq_init() is
never called and tps->irq_domain remains NULL. The remove callback
still looks up IRQ mappings and calls irq_domain_remove(), which
dereferences the NULL domain and crashes the kernel. The mapping
lookup with a NULL domain falls back to the default IRQ domain and can
dispose mappings belonging to other devices.

Quiesce the parent interrupt before tearing down the domain: the
devres-managed interrupt is only freed after the remove callback
returns, so an interrupt firing in that window would run the threaded
handler with a NULL irq_domain. Also call disable_irq_wake() to balance
the enable_irq_wake() done in tps65217_irq_init().

Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/mfd/tps65217.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index d535d140c2e9..9f4afbaa6524 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -403,17 +403,20 @@ static int tps65217_probe(struct i2c_client *client)
 static void tps65217_remove(struct i2c_client *client)
 {
 	struct tps65217 *tps =3D i2c_get_clientdata(client);
-	unsigned int virq;
-	int i;
=20
-	for (i =3D 0; i < TPS65217_NUM_IRQ; i++) {
-		virq =3D irq_find_mapping(tps->irq_domain, i);
-		if (virq)
-			irq_dispose_mapping(virq);
-	}
+	if (!tps->irq_domain)
+		return;
=20
-	irq_domain_remove(tps->irq_domain);
-	tps->irq_domain =3D NULL;
+	/*
+	 * The interrupt is only freed by devres after this callback
+	 * returns, so make sure no handler can run while the domain
+	 * is being torn down.
+	 */
+	disable_irq(tps->irq);
+	synchronize_irq(tps->irq);
+	disable_irq_wake(tps->irq);
+
+	tps65217_irq_cleanup(tps);
 }
=20
 static const struct i2c_device_id tps65217_id_table[] =3D {
--=20
2.53.0
