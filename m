Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313360;
	b=QfJfiwd6GsXzoH53hp0tBlS8RyTxeyoisYP3q0IG09ZaS+g+RB6h4OWKE7s+ydsoJN1m
	 HIamn7diHtIMe7tNsFxcpS2xt2YMT0PaGgbQZ1+eCZwnQj9IsgZ0Aq6TTQRaZMgBDtKUl
	 sPXKAIZaFJ4Fp0XJ38vbcaiwH4DZMAO9sUVBhjVwKwh7wv29jBh0tmKkwb9TQJ8hPiLcw
	 jrV3/JAfYRw6iliAT8S8m8mWs6yFzgrQ1n3XOOUPcY/5N98sDnJd7gkEJ2z/+Iayeq/TN
	 8pRGKA9j6FgOHVM9hnTWGRg+oz1FAQXXMzf0TmthpUrXjDa/Qhn8C2gc1LpD1VxJoZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uBjobw+JJ0O4fCBO5TA8NHTbY8fCcxO38YKtRzx+uu4=;
	b=DuMaN3ziWoMELQjZVXCKVCcSNn/X4WFEA/QfwXqcTxNNL4gtVOOF2aj9maaCrlOirvRv
	 d3wdUFfXyFMo/dgzP3z3bqcHXs0Q+Z1eMQJFGnADMbgutai9NomCuNM2csw+XvWBPoAai
	 nSF96s6dHkYJaAYFRGgRUVJMLdyL0ILrRbfd8M7CRRgnh0FyI1oivFabdhHk52G2zCm4T
	 ATUOSvl5NuCgpF+pOusQ19vidG7O/SmkLBW/Qzu7KY5zaERY2+VGRbI2dC7rgEIstushh
	 e+vekqvVU+WZ7EuYlF9kA9UyjdM7dW1Kwys5tylbj26ZmS8NKZeUCKuCfyNzl8R4R3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FynRsCu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD7606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FynRsCu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4CD1F008A3;
	Tue, 10 Nov 2026 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313359;
	bh=uBjobw+JJ0O4fCBO5TA8NHTbY8fCcxO38YKtRzx+uu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FynRsCu3Htn1zPaSEDF4mbwisPnoS4gyRwfwamWLK/BDU2/x2H7v81j+APPioWZhg
	 DwvPDs2e6Z6qEnrdvplX946Au7tCQO25h3Jt5Y66c2NkXFvd9lmFCQUZif3hUh0G+N
	 Cm18G7cMRj5T/o8QmJulQtjvP+/u6wimjTtPMAOBk2rlDLbWfvtDU+rT0sLV+b6WJc
	 PF4ApKv2lNkRjPXA6H5yiCyZ/3V9QoeK6irBssUmToyDF0KCHuOXtKDMG/QWM++h9D
	 OBHdVUFLiAti2wwYnRN++LXOrrj9rCeCyy1YTUgU5at8htv/K3ipsIyxo1V3W2aCHO
	 t6tQ9SN9efrXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] crypto: omap - Include internal/engine.h
Date: Tue, 10 Nov 2026 07:22:33 -0500
Message-ID: <20261110122229.1112116-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122229.1112116-1-sashal@kernel.org>
References: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
 <20261110122229.1112116-1-sashal@kernel.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit b7b23ccbda5d956a8f605da35685ff5f53c0f3b9 ]

Inlucde internal/engine.h because this driver uses directly
accesses attributes inside struct crypto_engine.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 5d69ed4cd4f9 ("crypto: omap-des - fix crypto engine cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-aes.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 0b8a48137519b..3111b9bcd0259 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -13,28 +13,26 @@
 #define prn(num) pr_debug(#num "=%d\n", num)
 #define prx(num) pr_debug(#num "=%x\n", num)
 
+#include <crypto/aes.h>
+#include <crypto/gcm.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/engine.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
-#include <linux/pm_runtime.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/crypto.h>
-#include <linux/interrupt.h>
-#include <crypto/scatterwalk.h>
-#include <crypto/aes.h>
-#include <crypto/gcm.h>
-#include <crypto/engine.h>
-#include <crypto/internal/skcipher.h>
-#include <crypto/internal/aead.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
 
 #include "omap-crypto.h"
 #include "omap-aes.h"
-- 
2.53.0

