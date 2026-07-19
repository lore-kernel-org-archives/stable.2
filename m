Received: from mx1.tpz.ru (mx1.tpz.ru [109.236.72.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB01D0DEE;
	Sun, 19 Jul 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.236.72.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466536; cv=none; b=D1FhEaaHXnwPZ3anfvlHbla1ceXZhGfwKmKOaTEiIYFbB9yqiYLYKqTjHgjUV4wYqWdqedP+xFwTpc/GEmJVp+WHkKfSe3L0cZleIRr+o3Mp2BhbW1cVCTh+g7TLD8d8VVh5Fl72h3oZduuizxpxktpbd5bHVZnVKpW5s2ykHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466536; c=relaxed/simple;
	bh=0QBEEJZJXwWWiI6pc0XkdI6WtoL1QXxmlBmUw0OkEWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMeRO5/bCS0LjoJHVEZ4Mz6GFe/mZKsiM0Bey3MWBil0e5E5CG8vyfpEX2v0XPniRvzNrzI53/n6uOLPaJ2935gCtVY/RUikazJGMLI6knjmMAD5KEFWQehD1OkXldpMCSUaIpnS582c/wOjQGOORYBBJcUnBOHgP3k/V1QvSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru; spf=pass smtp.mailfrom=tpz.ru; arc=none smtp.client-ip=109.236.72.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mx1.tpz.ru (Postfix) with ESMTPSA id 4h33qy3KY3zvQpX;
	Sun, 19 Jul 2026 16:08:46 +0300 (MSK)
From: Ilya Krutskih <devsec@tpz.ru>
To: Olli Salonen <olli.salonen@iki.fi>
Cc: Ilya Krutskih <devsec@tpz.ru>,
	lvc-patches@linuxtesting.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: tda18250: fix possible integer overflow
Date: Sun, 19 Jul 2026 13:08:35 +0000
Message-ID: <20260719130836.80047-1-devsec@tpz.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integer overflow may occur, when variable exp equals to zero. Result
of shift 1 << (exp - 1) may then leads to undefined behavior.

Fixes: 148abd3b5b14 ("media: tda18250: support for new silicon tuner")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
 drivers/media/tuners/tda18250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/tda18250.c b/drivers/media/tuners/tda18250.c
index 8a5781b966ee..d1d97da05215 100644
--- a/drivers/media/tuners/tda18250.c
+++ b/drivers/media/tuners/tda18250.c
@@ -440,8 +440,8 @@ static int tda18250_pll_calc(struct dvb_frontend *fe, u8 *rdiv,
 		goto err;
 
 	exp = (uval & 0x70) >> 4;
-	if (exp > 5)
-		exp = 0;
+	if (exp == 0 || exp > 5)
+		exp = 1;
 	lopd = 1 << (exp - 1);
 	scale = uval & 0x0f;
 	fvco = lopd * scale * ((c->frequency / 1000) + dev->if_frequency);
-- 
2.43.0

