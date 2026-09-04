Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D9396572;
	Fri,  4 Sep 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504601; cv=none; b=TlaPsqOUCWDxDp5Iw0o/KWXat2kjdw0JQIeUo93Qoo8a45Y4Ed+X2biiGl4FBuYHY6BrhkhO5R3mSDIydmW7bN+xEHS+zSUzeUNBvjV77GzOGwh9uReI4lLu9SxHp+ogOqPr8ohJgD9W1qQZtvLHkvIROGAgHppu9wsuGivulo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504601; c=relaxed/simple;
	bh=xvZeHBDKdV6/TZSpNv5Ns7nmBbj3y9I6Bif9TWMVti4=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=l+JcgLuM4sZO8xnYMCp8mkeTZSXSpuaUYV56pqJMSyJEHHfPjgSnm8rF2QMUtHtKnnrMM/azMSIf7h+0QI7Ornawsq4gmuxKDBwEyihetr9+7uDPZVSCSvtBRSkgQqamLVSZF/TfkWeRiPnV3o2zI8gkH0RrweJkOVJ2DHst4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=qMYl40ts; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="qMYl40ts"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1788503688; h=from:to:date:message-id:subject;
	bh=ngNsvu/evNzZxw5zWOYO9JfbmAS0BwgmROUZjM7iK/I=;
	b=qMYl40tszCO9liF9sgqEirGtQGtXtVXWH4SJ1XyvLzFK5DiFJXL8G3k7v3vT7mb6CEUmnvPou9U
	gSDQdpmPsAjkyCqcoRTouf7tMmrPOpID/TpF7OjabbVKluXuEHvG+HqWnA4WsRTKqcuhG/7awCO94
	udZluzXaLsT8Fws5J7YmBR+zpgcXE0Bu2N6z8L2QLbF5q7GhDKxhjA4VcIhSd97fMoWhUrHi8WYs9
	ZcJdqT5hFDUSQtv+sV8IDE8n+sLisaAoQy7+7fw62wdIqYw3/WIAn57sSJNkbjSPLf7XKNDeEaNgO
	D5gfPY12S8fFoCK+wSfEidEAhrmlanT2l0CQ==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 4 Sep
 2026 11:34:48 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 4 Sep 2026 11:34:48 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Fri, 4 Sep 2026 11:34:48 +0500
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
Subject: [PATCH v3 1/3] mfd: tps65217: Fix NULL pointer dereference on IRQ
 init failure
Thread-Topic: [PATCH v3 1/3] mfd: tps65217: Fix NULL pointer dereference on
 IRQ init failure
Thread-Index: AQHdPDd7F9hvd/831ECQWCXVj/bP8g==
Date: Fri, 4 Sep 2026 06:34:48 +0000
Message-ID: <20260904063439.69881-2-r.zhambakiev@prosoftsystems.ru>
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
2.55.0
