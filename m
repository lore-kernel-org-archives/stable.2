Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743974C2264;
	Thu, 17 Sep 2026 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641272; cv=none; b=PoPdKTWYYi7/YeXCzT0qr47gA6e8OgEOX6/lw0C0xIqOx4BZ3FTcZyqzXvqiVdfSVhpb/fJc8TH7unYMzDGqYSNcSo6IhXtk/SsVoq7D78l6lKBrE49DLKBqh9T7+VaLiPfOpgOFGZNVnh3ES+kekdlB7W9M/ke/HHBCeMF4ZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641272; c=relaxed/simple;
	bh=SlbmVcyKluXQZa94Vx0faY5/XwBAe7c+q7v4s8ZbJ6M=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=gL5ZykemFVreX7EURj0yyHWUwRoepE1K4jGDXjyJQaTV0FkXDgoUq9atpYqGtGhSxD1EH1WTqqjGh7Ge9GpVssAZdo9F9rwTY8jBSmqn5kz37Drzy1GQRHKs/UcOdqZg7/tOfKOe2He75iJtmcaK9ETUWOm7fVUk11Xn59AFzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=GzXg24+i; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="GzXg24+i"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1789641237; h=from:to:date:message-id:subject;
	bh=9i41YP6YKQ0XrCrYgugZtRgKOBXpPuMajk3GxJ8Jlqc=;
	b=GzXg24+iquMUWSRemvcSKKPOYL3qUexrHZjhQ1kWDJv3zEW3WnDArFYToqDUh4dUQXWvX7c36xX
	fvE/TDvSPcVtIn01I/TCV2+14Mr61tHaMPD08pWDLyfXpSGO0JJKj5VnZJxCJgXPRWVHJeZvxkrxI
	SHvlyh83y0F9AAFrYD6tfEAH+MG5fmvUAbSi301k/LeJBGWfSUPBE4ntTFcbo3o1OXm6TROnxZI3v
	DURAx6XXjdHMeCgeUBlphBDf3a0OqRlJzEK/JF37nrCl7kvAYkPaOT/9uTOZL4wOqpQfLASvT2F23
	+OwZF/dVclkSPcy75zIWCimgSLg+nY3cUYkA==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Thu, 17 Sep
 2026 15:33:56 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 17 Sep 2026 15:33:56 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Thu, 17 Sep
 2026 15:33:56 +0500
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
Subject: [PATCH v4 2/3] mfd: tps65217: Check return value when masking
 interrupt sources
Thread-Topic: [PATCH v4 2/3] mfd: tps65217: Check return value when masking
 interrupt sources
Thread-Index: AQHdRpAKPZuvbfcdOEiS/29Hcxv2lQ==
Date: Thu, 17 Sep 2026 10:33:55 +0000
Message-ID: <20260917103312.92624-3-r.zhambakiev@prosoftsystems.ru>
References: <20260917103312.92624-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20260917103312.92624-1-r.zhambakiev@prosoftsystems.ru>
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
 drivers/mfd/tps65217.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 2d04d9e0ae29..ee640e3fcf7b 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -155,8 +155,12 @@ static int tps65217_irq_init(struct tps65217 *tps, int=
 irq)
=20
 	/* Mask all interrupt sources */
 	tps->irq_mask =3D TPS65217_INT_MASK;
-	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
-			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
+	ret =3D tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
+				TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
+	if (ret) {
+		dev_err(tps->dev, "Failed to mask interrupt sources: %d\n", ret);
+		return ret;
+	}
=20
 	tps->irq_domain =3D irq_domain_create_linear(dev_fwnode(tps->dev), TPS652=
17_NUM_IRQ,
 						   &tps65217_irq_domain_ops, tps);
--=20
2.53.0
