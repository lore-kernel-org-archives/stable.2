Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB353009F6
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786181933; cv=none; b=Qvsu70vxyaGcSpLK75sIysdcA7LkbgotHclgz7Fjih+7ro8S0MSTymjCdls574pzo9grma78MaPkOw9O0z4IPxNmahwULf6VrocjiLAEm8lLtjms151N7ZbgzL1/u/n6V6TjoxDYFzY2o0avQ165tFYlJpMeuMBMzrqhqNiYlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786181933; c=relaxed/simple;
	bh=hD/EvuRY764RrsJx1wuEKYerRIdAetHJ9oH/4f0ywDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMXpxmUD/h9bi9EbpdotLc/8sI4iNAQ2uGywHju3CdhJzLec8tEmyZRP2WfjNfa1199GkR71UOasUVSfpka2KxJ1dxbiqGlG3P5GLwjsFNNA6VKoGvH/UqPdmwrROgGXa3xo1OagiRuCXmhgYRcQNChI72SpisYrjqT827WmuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGbb+jKv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGbb+jKv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so266650a91.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786181931; x=1786786731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RX1DphTMSs3B4MvCbqjOAvkckybgUBneK6EG7I97Aec=;
        b=QGbb+jKvMrc5EKkDBAwrR42oszFlRKcQMVpk1QTwWO0s4mhNBsIW06gS4d61J9nPj3
         1h/K0Bn1soW0xe9KImLgPsaCyY3fJhuFwDyFDAaLXp6dSC1KKXwFY93xINVrvwifxULp
         Z+5+9A0uGORET+U5pfujkfjXJRv8EWAeZ2V2u31WYzJt6lhfAuU1dEKzT3CVkzRJpR/h
         Eor6bYOxaO/NJo/SSQZOgazGBHZGqtuxym5eCh69Mld/2Z+V/ZZodn2+c2pidvdXnnYO
         54JKGW70snT2n8lMr9TOO55o/sJLvgVE/qYUqfB56XkvcF1Ow3u0edoz9fSM7hIgwudd
         hJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786181931; x=1786786731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RX1DphTMSs3B4MvCbqjOAvkckybgUBneK6EG7I97Aec=;
        b=HwmtOgXlF8/+mbaZYXVAl6XMtLnvlKpvg8rtQ//TsSz+I+cuA2iLQdYM11esbEun4p
         yuiDb/l/+BEnvFO0GestDW2i+1iKI0vNzSEuxwZk1R3STmSIbOo2IHqnaOgYKlqeYp+l
         6UxwFLwULURTpA3eX6QYsNOFnMy7Ld/mFQbkFefMfieVOPt3dQrdPDB4UmJFtmuZb6Ht
         6k57gBJTzTcyT+gQADDhl1r4lpZQIEywsrblY0beDpQVD+402YJ1LYXSu3wDYexk9LXP
         E+a4n+eiYjrAkMCs/yfTrQoNvIT9G9PUK1GrJya64J4mEyKYkzQ2sBN84X79jOCbLwLJ
         smrw==
X-Gm-Message-State: AOJu0YwyqywS3ih5XaC/X6bNJzO8aFuPvA9WxDz0U4klIwhawNqOArOK
	LdYnDtujvepVPzeruuavDwOki57BlbkGoqiE90zqReU/AJnaafPsyhNn
X-Gm-Gg: AR+sD13DR2AbhNBmjMs+BPrK2LNMCemEh1Z5kj8dIxQzKVgGpYPZZedHjyNoEH0qBO+
	64Don/DFJBcojDufZJF7zlylXIDCnvJ4F0Km+/vGyRy0ac4Vb25RG84mz192z5a2MantnR+jmgu
	RZ9rGR3iVrmYR+TJPF/Fl+vTZYp2AJcp7ANRbPkOK8li9Tnex9IuHVONLHKPuI63QMS8reQEhtl
	dpmtjEEdebeBSKvMkv/5t1UOqkfn+ceP+nZp+o7dBBfTDnXurJWiT1pHKBYo8OnuW7AUKDJi+36
	cMydBq9C2JBAcdC1u6o88GEd2D+wY4i81QvizSdGIqk4KWQ7sfr60q+0/8d2HzBS0SSUZPBnOJt
	jakNaxkY7++mKW+Q06Z82bZaO6h9RX/yiVBaqGuwIMkFfo0wwnNZNKrT67R0GL4XnXlIy5ToDWR
	ksuOQf37dt81SNzy0d/LLJXdkzCNYfDOgrHpMMqOCYE+Qo4zRCsbUI8w==
X-Received: by 2002:a17:90a:ec86:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-392846fd57fmr1926782a91.17.1786181931093;
        Sat, 08 Aug 2026 02:38:51 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dab4sm5615231a91.3.2026.08.08.02.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:38:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Maxime=20M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"lionel.debieve@st.com" <lionel.debieve@st.com>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] crypto: stm32/cryp: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 17:36:23 +0800
Message-ID: <20260808093623.2744314-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_cryp_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor stm32_cryp_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 65f9aa36ee47 ("crypto: stm32/cryp - Add power management support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index b79877099942..74f6e329b1fa 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2691,6 +2691,7 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 		dma_release_channel(cryp->dma_lch_out);
 err_dma:
 err_rst:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 
@@ -2722,6 +2723,7 @@ static void stm32_cryp_remove(struct platform_device *pdev)
 	if (cryp->dma_lch_out)
 		dma_release_channel(cryp->dma_lch_out);
 
+	pm_runtime_dont_use_autosuspend(cryp->dev);
 	pm_runtime_disable(cryp->dev);
 	pm_runtime_put_noidle(cryp->dev);
 
-- 
2.43.0

