Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840862;
	b=JXnN/bBbbWVGlMmuda++Up68yelY7iEcwYD4duOJpkE9M46vGWx3tNzFy9YF6OJyyN2P
	 aLs/2tyBN+NWQ1wWRJlPvsZ+YrpoUgT2HmXyuNtEXxNV8k2xQdo+UD3G1fF12pTyXvJJq
	 h5z/FUCS4vz7pQ0iZlHIfSlOmQb5XrpZq0Nd2YnXqj6rLkQ3GD6OhzwIn/g7vq1Zzh6/S
	 YXTIojV1CWGPnt2/7FtQmyMSzuSx0Q1pmIwHGVw1f/oGmkQT0fmm7mBljKu4OZ3SpugZ9
	 5sYnTzlkh7AEzI+brWa1ISLTEdLj24jssvPUO7RzOO6GulpUlrm3rxrLIZ59af8MHsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G1zg7oDnPMMLPkGbaldczgRDAJIrfK55owtXYdnhz5Y=;
	b=Wei0wJveGV4+MJbLCG4Ugm65v3gcPr43d8VPfrahuLpELTgsDqf7CCtj/2QuibF1LSXN
	 CHpQR5thuBA1ch4I4nVXzi/TaD1sDdjGwZ9vDf+XaSxnFxqjD3qchfhyoSIeH3M/9fp3R
	 fEOXREHOomHGXPpQ/f3iVDL7KBaIqwXQITfByDE6qtFd9nLRjap8/BUFaUnuhCTu15/l6
	 fnzj3bcFtZeoGtQtdCwK5HFe09F1yF9o/NowRKlx7y/2DxJ7RDP3FUrE+yUkYwA5L0t56
	 AnCqCrksaKpBYd6eZvCyAIJtaUWOG72Dz6CMluZqK229aP7ULw7IHX0AgTU8tDRv/hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxlrDgtb;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F593606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F593606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxlrDgtb
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso4368130a91.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840861; x=1796445661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1zg7oDnPMMLPkGbaldczgRDAJIrfK55owtXYdnhz5Y=;
        b=GxlrDgtb14O81jpISTbcaVBRGDgmTfQsDcs1AaRKdxWl7mp/t7TLGt7vVQRIfVryDk
         aPHHldiBeXC6T/JVb0pHAARynaGMetwoyzWzEXZ1BuFYCKs3Xan+aKA/RIby3K6fvjtT
         RxN4X65YbR2fXqgmopcRoMmmJ1dNrNF2P3S4pzbqWLmWU95G8NCP5aQhLOTtPOEIT+mi
         wWSG65nBFxK6zWgQVxU1pnFrH74Az1KvVFPap34dAzD2ifcOElqkowyBZsGgMXa0nE3h
         VS6KBERQyFY29ztrAEKECdQCl+1RHVNeuS8o8F2KvwuVYR4gWRGqbvj+yWu5OTkhIsKP
         JuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840861; x=1796445661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1zg7oDnPMMLPkGbaldczgRDAJIrfK55owtXYdnhz5Y=;
        b=CeUpwDb9FLEpHoIK6oxeX4NZQlZrPs5hmHyHkBS/J98it+3qXGr4Jgx3QDuua9ILEl
         1NiGYuVtpTGKm7EGmal+ZsBuXCjJJtW2N1RkzXG+2q+7ctelpFPWXfDrhJu9U3BZ9R3A
         nTClekq0RJvjuf8gjtNF1cF9tf1naX8clAqxJNvNQhGRk/eG1FroXwqd4v5vhHpp+IAJ
         X9OdEd623sbqZ2PFED40io6umpWfmmrjz0B7ykBApTpSrh/YNgLMWLkfOS9+Gi76LVOL
         VzJvVEZyAZK8NBPLeHVAP0uP5mZchnaNtLzxWoiyPJEt7qDno39y858dKSlYQy368HlJ
         4gDw==
X-Forwarded-Encrypted: i=1; AL+hErFBibwNrKw1sAjExkGHy8tFU8sR3dzkslayvWsl7u2zpFweyKDEl23MhcI8f8fALUIfzhYzD4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jm8lVVj9+R23nyfdZ72zbXds3Pf/tsyZVASPjw/hqkhuoCbZM
	1yJsDMcClkwVcx3ZiCI6M99ns+KPT2aROxFGBhIV8zFBNGx1DAJhdQdW
X-Gm-Gg: AZFdTZcYRGIa5R3lKWjCRpmxekuooWdpGGKtKN30aVnSzjqoPNRXR1vrauo7BLrFxVV
	wjsc73G6oQ2CfCMh7vlWZy1PYcSUFgSz+epgWIKuoyRHXdHcPYRMkkP5aOuM7yirnrY2wuEsLkN
	kT93wIpTBSey3IYlMsR69sfqdfYhk2kSUdIJoukW5aFmdoaxdYkwzs/76BIPsz0rAKp/Ape6fBz
	6XH4prWIzLK7bNtHr+Z0gqIOkZoX+ffcV9rtaPFcMY7gtr2LHAJHbESxGupm3Vmjvbv7vnsES+Q
	lNhsInYiOC6wbhT86lQ1qHNJ1pmxmoxGmalzmTJHzKOQJzOv3wCxoBi0ymLx9jP91vkBOmLy6w1
	+Y2d9iTp9RiqV4K1GWnDC7r2OFGdbTxL1uUWMty+B/9ToWtC5P8KktvvU/xGu9JBQrfZadkAfrB
	hlAsVXrt7OEYvWwU1YEqqUHJJ4URSyduvjcNVfAy4p79tXOxfj3k3pcbam9oHvesU6t60D4QdTI
	6g1YbnjmWXH8OWVNi2TcI5ch4+wCvV2E2d+F/7gK0MrC0/rbNOFouJw5T3rABZXnFTnQEsGflQA
	GK20lOr4nW+t+99oV/F5cJa6k5kozvpd7Y+T3+kTnbLZjNYlJTSkqDiibm97UyckYrDbWfjUTKx
	3zOI383OPrBeTJxEBIDdJzS0NJmzO17DbAF0XZrtk1D1FkxXHfANjEQs3i1G1WhfqrYeJuv3WDB
	d+sw==
X-Received: by 2002:a17:90b:390c:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3b41c9beafamr24728083a91.66.1795840861545;
        Fri, 27 Nov 2026 20:41:01 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:41:01 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rosen Penev <rosenp@gmail.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Romain Perier <romain.perier@free-electrons.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/8] crypto: cesa - put the non-TDMA hash padding behind the data
Date: Fri, 27 Nov 2026 20:40:48 -0800
Message-ID: <20261128044050.722617-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128044050.722617-1-rosenp@gmail.com>
References: <20261128044050.722617-1-rosenp@gmail.com>
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

Commit e62291c1d9f4 ("crypto: marvell/cesa - Fix sparse warnings")
changed mv_cesa_ahash_std_step() to build the hash padding in the cache
and copy it to SRAM, instead of building it in place right behind the
data. The length is advanced before the copy, so the padding lands one
padding length too far, and the engine hashes as many bytes of stale
SRAM in its place.

Copy the padding first, then account for it.

Fixes: e62291c1d9f4 ("crypto: marvell/cesa - Fix sparse warnings")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index f6894ed7c1cc..6fcd78427b71 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -253,7 +253,6 @@ static void mv_cesa_ahash_std_step(struct ahash_request *req)
 						      new_cache_ptr);
 			} else {
 				i = mv_cesa_ahash_pad_req(creq, creq->cache);
-				len += i;
 				if (engine->pool)
 					memcpy(engine->sram_pool + len +
 					       CESA_SA_DATA_SRAM_OFFSET,
@@ -262,6 +261,7 @@ static void mv_cesa_ahash_std_step(struct ahash_request *req)
 					memcpy_toio(engine->sram + len +
 						    CESA_SA_DATA_SRAM_OFFSET,
 						    creq->cache, i);
+				len += i;
 			}
 
 			if (frag_mode == CESA_SA_DESC_CFG_LAST_FRAG)
-- 
2.56.1

