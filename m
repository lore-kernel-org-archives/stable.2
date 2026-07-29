Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001C4D90BB;
	Wed, 29 Jul 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338599; cv=none; b=c2Jwf30JWLSo7U0y0CTgr2QBZI5XUwyd/rBsyyLbNvGsWXeSbpQNQq0Sx44nSC0yyl/C1/i2477yvgOvRX5q8sV8oTBbijCDSanzvKsjQrvzL+3/srkuG9jPy21qDFoRGCqAy+FJLPrxfk8xzzv/I5m/LqLkaWp1TYhPpU5mPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338599; c=relaxed/simple;
	bh=DtSRpaDqclNo6U2QeRpHGIfjJQ060yIsBqj5BnAVUds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgKuINrzIrtBrHNuEZrCP4VjoYdrt7mJq7+BncxG79+NaNDQp1mbU/uWCqOSWxP078fSLvNHgrecN06WEMdYsoqoWwEoT9T6gxf6PRKQ+pddFztI+BDZsAwnyQJfpOcNT5ERxkWofCt5aZfjoBJmalMcnbEJBKR0o5aJ6ZbNusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=sRYWlj6M; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=lKUuARmW; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="sRYWlj6M";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="lKUuARmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338595; bh=DtSRpaDqclNo6U2QeRpHGIfjJQ060yIsBqj5BnAVUds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRYWlj6M6VoMraMqgOj4ilZmrVqgQT+tzUWhplBwhzRwNqYSFH986e5996BnSuyRn
	 DWrUEGexbqnNmKZArA+rPGxZIx9l3eYFdkvgxeoP/P/Gm6UJ6sj7RN0EyY63BQ3Ocd
	 Wx8Ndp/uSq/Wj+lvCgGjpTyhoa/8dQVdYtJQ/dRDK1kQodEUVqR9vhiyUe5cRNE0Ml
	 WrTGKtMjoFEO/D0IQ6nN9uvHgFJYWjmopuIlD7r08yCSL65G6zn3Ce7b1zf8dLlq5W
	 lPnYJTT7BOhbvDoy8zy9Wt4+f4zUH1cv4RScpM7zrw+xg3r6Mov9Uq+bxx33U2xJzD
	 D2pfuKpaVQD+g==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 625F242530; Wed, 29 Jul 2026 16:23:15 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338593; bh=DtSRpaDqclNo6U2QeRpHGIfjJQ060yIsBqj5BnAVUds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKUuARmW0Vn7htby5uV2rHilrxDdlmglNPpjFcciCvKE0sDFwL24CQGjPWcgGDnQg
	 VYtNPwuAdaOxzMadtz4G7gQ2hYcOFE+StrRtpE7eeduvzY40xAkpoeTTMxTBTqvr14
	 rIdhE2Oko0L6gSgV1MwiggWxtceIW+Zw+B64AdHH7FGkSU+V8tiJCF6FmbwqivQs0Y
	 51jBvjP4YHuG9ldRxn+J9VHOSq23Rd7ZwqUNBleaXHdja+rE0auN05fGCEQkndmoek
	 J3oY0ITRGM1q82pxpUJktIJxOaRXFQZuygrudxWQEYuyYOPst6AE+QQRmf8zIpub2t
	 HldXKq00paMJQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 071BF4252C;
	Wed, 29 Jul 2026 16:23:13 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/15] media: meson-ir-tx: Ensure clock is disabled on unbind
Date: Wed, 29 Jul 2026 16:22:45 +0100
Message-ID: <0a0066a531aedbcb18620cac5897cb91c78a5188.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_prepare_enable() needs a call to clk_disable_unprepare() on
driver unbind. Make it devm managed.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index fded2c256f2a..e7bb107e6a84 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -288,8 +288,8 @@ static int meson_irtx_mod_clock_probe(struct meson_irtx *ir,
 	if (!np)
 		return -ENODEV;
 
-	clock = devm_clk_get(ir->dev, "xtal");
-	if (IS_ERR(clock) || clk_prepare_enable(clock))
+	clock = devm_clk_get_enabled(ir->dev, "xtal");
+	if (IS_ERR(clock))
 		return -ENODEV;
 
 	*clk_nr = IRB_MOD_XTAL3_CLK;
-- 
2.55.0

