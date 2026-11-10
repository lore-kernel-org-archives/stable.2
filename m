Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312854;
	b=Qnr9Zm1Z0ZKjv04T9QqQf2AKwwCVX/amBExvUa2NZTzVuxHsREKGT/GqW1yoN7qwTIRM
	 DOnuCvQCm1Ur3XbViN6uDpAh15KwGbfXRP4HTjT8vidmUjH1Wb/coWl07bwVgwrvate/4
	 Xlj4TR0XDqgmXCoKaEcYJiu69rj+527inmB15p/m72v61pdJCmnpdquTf+Q+PvSVOMaUD
	 GH3EQmLMXMK+Z/yvFomEzuLGkE99jYPCxOol9mM2pz8MoLnf3qXNxBOhrRemq0b5vj1gn
	 Cg/uBfG0AWH93Y2V7YbhPdK1NSwlOo9zGpeqOYGEgu3KwqNpqfdcp7OgRXatIr0anLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WwdoXVZqma93bgmM6Rb1PXJWLyhy9RqoQVisftR80wc=;
	b=03Su/4JXCTnJsWfChVT12iOSUCNUfHmdhJgaCPyEf5CdDMiiRIKdASIFsjDv0n5TJlBo
	 5zwyMAnxO2v17SQgpvCZlMUk+8YdDiD/7gkanAcgTGpXS+ksH67IqcTcqj3fzbFMNRyfN
	 TPgg0W+XmhG67wUpzMdlbDnnB+nFH7MSvySF0OS5t412jAbbBtQ8a+Gk6GwFx49SDd+Tm
	 V6XhWADukn8CZSwqoyHwcJ52QN2+jtUK+Y6NK7czuc66Rr8QldeD+sdciGPaguZBmWH35
	 QA/UYEyNZT+mGzFbiBN5KJpue6acC1fZZD9LLr7RBOiOUgRiC2JVPHmbFwaplI+IGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Joh5igkl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B1606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Joh5igkl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65881F008A3;
	Tue, 10 Nov 2026 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312853;
	bh=WwdoXVZqma93bgmM6Rb1PXJWLyhy9RqoQVisftR80wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Joh5igklCgO946I1Qb0IhzanPOjOH6F9zjb8MJw5A7UVfUN5QFh1AwNgcxeQTigM2
	 xtRKwCQNrjut+h/U/Jx62Ot9KITUZz8lpMf9lGivNtNJVhgadcrAHTkU2M1YElD3S4
	 S1JGYOEIeK2ZnTEr5MuPC4X3DR9l+GfHgU3vVH9OFKcDij4HsxuQpfzqmmw1jGjPTn
	 i4+pzVe3lCQAYlaH0+bDwixTIsbcTNlcHQ0+3fZu16z5QlnACLtK2CFvNSuZkmFWSf
	 avfPLUiETz/W6RaN6yvBFq5jJG6gJY7o1fWtMYlHldsmGocsBrIMaodq7lFkbLs/6t
	 MtIYxyPicOWhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] crypto: omap - Include internal/engine.h
Date: Tue, 10 Nov 2026 07:14:07 -0500
Message-ID: <20261110121355.981467-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121355.981467-1-sashal@kernel.org>
References: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
 <20261110121355.981467-1-sashal@kernel.org>
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
index d6fb8676f6cc0..ad0d8db086db2 100644
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

