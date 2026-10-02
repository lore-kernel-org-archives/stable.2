Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C47486E67;
	Fri,  2 Oct 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941024; cv=none; b=Yv8ue4823Rm4oNLFh3sq1uSwPECXCylq+JCw+dMXWABBxrmkzK91nO6P8inWsoBD9FFkBwB+o/TaGLqq9N9WEW7OW8ZfI1/7cUjn4Jf+DJMw2g2yVGSshvdv8LLbtSR7LdyLRyILmAnarkEoOu+GKpo9IEaU3c/1cFKHckn/3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941024; c=relaxed/simple;
	bh=EDvQQPM4NXFJxheRWHtlfaJepcn9e1uFAUjhCilE6GY=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=pwOYHwDq6EpgJmWASRqw2Usfg36JeB/TrfEZauczWZGvo+HV31cdGPSQep+iKBwbAAU3aPci0HicFbJOdW/MU/Mzuahi2vjyHrDOky6b4uZe+Fn6mXhvTX3qL8DhrF6DYg39Ocg53Us2VTF7FO5YUFMH9pLXZg1Eqp9Th5XzC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=nQL/I+pe; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="nQL/I+pe"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790941016; h=from:to:date:message-id:subject;
	bh=q5DGoGch0eP9pgkA7a+3UVKIBNQSk0tdO3CJEoh/R8w=;
	b=nQL/I+peDboOq2QEbWsfDSG7mdkhleCo9Lp0T123bCfJ86dDK2gAY4g/tuRBPKDVVup3ieGXtL3
	hzJ1A+kCuLiSJxm+D549x0k58ZagCgILShYZj/CAU88NOUMHwXVkl189LJgCmy1AyKZl5Dz0178hX
	Q18jZNTC5/QCNuhVci0bzrGlcDxkSQqdxSnroXb3Gqg8RQe+tFaUeeIrYkhAIy3JMZTgkpBXcPUWP
	acEJfEx8F/lPRwPUqFsfpuR5THdOfpTSzAI+VNd1Dyrhd/tYrEdOMx+mwOOMXHg1Sx21ulP30DQ75
	B2fum8xn9Av4bQRUxJwmaSkdIJunUTiRFgyw==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 2 Oct
 2026 16:36:56 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 2 Oct 2026 16:36:52 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 2 Oct 2026
 16:36:52 +0500
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
Subject: [PATCH v5 1/3] mfd: tps65217: Fix NULL pointer dereference on IRQ
 init failure
Thread-Topic: [PATCH v5 1/3] mfd: tps65217: Fix NULL pointer dereference on
 IRQ init failure
Thread-Index: AQHdUmJR97n2I+gJs0eRHsxfJjMdow==
Date: Fri, 2 Oct 2026 11:36:52 +0000
Message-ID: <20261002113624.178588-2-r.zhambakiev@prosoftsystems.ru>
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
