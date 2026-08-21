Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA9416102;
	Fri, 21 Aug 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298845; cv=none; b=T4h1HwvlHaG3pyoL8AeXOI9BefWw8H+EKnxk7JVd+5g3qqOS3hcSJibYe+uBH8jUbekbHHd7dDpUWQ1w9cm3f4kA7W6qoDZF9TbFn9jnD+ijEVrlPFh4Ckwr+Q9IScAKT4a/eI8dZsa0+taAQnhWvZThggaVZrbXX2bg3RLBw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298845; c=relaxed/simple;
	bh=REikZi9pApQc2ARh0zVtJvBm/nk2VLJbOUcBU7Yp5aM=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=OQ84bEhTVPMbFN45WzNRCo5LJOrXPZf0L8AMqX7zafJnSzgOSKOm/0d6KRiH+OvbMlGb/BG6T2RiMR+VmGi7T6Y2v7ZEcF6qSUetreoikdgmGtoidgNaYQjzWCOe52S3aXtx6+qr173wv/y9VpO8d7U2tnJgXwj8+UE/jVYpd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=CLrB8vzP; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="CLrB8vzP"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1787298837; h=from:to:date:message-id:subject;
	bh=ToqiBpcLxa4O7isOlNvqkO5oOViLjOPDY5eP115sBvo=;
	b=CLrB8vzPs37lxh0k651iHUk3jQ1oT5GIHdBDF5tgLcsXhwP7sMYj/CzbZeW/sUyLfK1fVL6VjKR
	u/CbdC/55TDRrdXw4ZXtyuAiKwYeicWTP9AKcz4mtFEVmi1j4rko0zXp7tXQEv0VG3yxcLyyOK2JM
	5HFep1C4qeN1Mj+FJ/0N4zJuxkYlmXcZM5XnXHfldg3Gsy6KjuXuCQfL7hdE/O3YlRxAiMvgDm8GB
	+ybkKZB3SDzkvenSc5SD9O6ts5azAuYYBNkriuQLcaWCrdvTm6jXPkDMcM3GOqzO7SsKgb4wcz1JG
	0WiR/tFrevYQeyL/1qylh9jC1OxE7Gd5viSg==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 21 Aug
 2026 12:53:57 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 21 Aug 2026 12:53:58 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 21 Aug 2026 12:53:58 +0500
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
Subject: [PATCH 1/2] mfd: tps65217: Fix NULL pointer dereference on IRQ init
 failure
Thread-Topic: [PATCH 1/2] mfd: tps65217: Fix NULL pointer dereference on IRQ
 init failure
Thread-Index: AQHdMUI4ieVoIMKZ+UiKarSj4WzOxg==
Date: Fri, 21 Aug 2026 07:53:58 +0000
Message-ID: <20260821075331.131315-2-r.zhambakiev@prosoftsystems.ru>
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

tps65217_probe() ignores the return value of tps65217_irq_init(), so
when the irq domain creation fails the probe still completes and the
driver ends up bound with a NULL tps->irq_domain. Unloading the
module then makes tps65217_remove() call irq_domain_remove() on the
NULL pointer and oops the kernel. On top of that, irq_find_mapping()
may fall back to the default irq domain and dispose of mappings that
belong to other interrupt controllers.

Check the return value and abort the probe on failure so the error
is reported and no inconsistent state is left for removal.

Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/mfd/tps65217.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index c240fac0ede7..2d04d9e0ae29 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -333,7 +333,9 @@ static int tps65217_probe(struct i2c_client *client)
 	}
=20
 	if (client->irq) {
-		tps65217_irq_init(tps, client->irq);
+		ret =3D tps65217_irq_init(tps, client->irq);
+		if (ret)
+			return ret;
 	} else {
 		int i;
=20
--=20
2.53.0
