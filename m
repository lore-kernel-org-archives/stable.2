Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF369242D62
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970456; cv=none; b=F35XKpw+uFAQSEDJW4hu4cS/C4K4QBj3L94KVRqMw1G7sn4GIVHuNobzEokh/Syg+ALfwyHGUhciKvjWp7hJLagj9uE92u67Hlzqg8ixfW2YVITfpduiueMbPZyE5n0eqJm0eTqT3BPIQTnb5l3hsyRCrtAMhb34sQy+kspifAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970456; c=relaxed/simple;
	bh=XHk3xK0e7rN2lgrsOKyF+DrhjB5vAm5BvFbaegF/d7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkEdHHPCyq/fP7yjltWc1URcaohu4R1BHlnS+QWLEZeX7ZyXjVxJ5kjebrCMgsSMmIUdN+NVxaBbYUyP464JDh07uIrwvEqJ5C9IuqgrWdLUyfdGVj8mPX1/5toJatnYYD5z21Unu0VErFv9tOloS738Z9biBbOR5fW2hYveR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eotM34mr; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eotM34mr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784970441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jS4EmPE++JlYoj9INElOECDtHahsaUK8Ksb6sIQ1Ds0=;
	b=eotM34mr78IJiW56UIh82tGAnbmFOc46amXLsTjHVttagpPTg6uGMCrc2qoEflF6rvJYZr
	Hq9OcSRLFt9VfGs06uJu8Cb9JDz7q8jWVOfIE0rl1yR6C8m5IhLQx6wOGyhp3HaJ9C1Dvz
	kbsbNj5FgurlclGcb8A/bzSBR/9CoS0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	William Qiu <william.qiu@starfivetech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: starfive - use scatterlist length before DMA mapping
Date: Sat, 25 Jul 2026 11:06:10 +0200
Message-ID: <20260725090609.315812-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=thorsten.blum@linux.dev; h=from:subject; bh=XHk3xK0e7rN2lgrsOKyF+DrhjB5vAm5BvFbaegF/d7w=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkpNY2bSnzY5kUtY2y5XyU0Zcnm8A+l1w6uf2FZE/XyT uB2Xz/ujlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhI/CJGhlNWvYtefTAsP7Xq wCUB0Q3z3q2Un7Tt6iY+kb0TmLvm3/nN8JOROzrGXnmCo1qa7MU5aw1Wt6dVrrFca+QTFq/1Uyf IkA8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Using sg_dma_len() is only valid after mapping a scatterlist with
dma_map_sg(). However, starfive_aes_aead_do_one_req() uses it before
mapping the scatterlist.

Use the original scatterlist length because the DMA length has not been
populated yet when CONFIG_NEED_SG_DMA_LENGTH=y.

Fixes: 7467147ef9bf ("crypto: starfive - Use dma for aes requests")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/starfive/jh7110-aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index a0713aa21250..f59adb2a5651 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -677,7 +677,7 @@ static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, void *areq
 
 	if (cryp->total_in)
 		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
-			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       rctx->in_sg->length - cryp->total_in,
 			       cryp->total_in);
 
 	ctx->rctx = rctx;
