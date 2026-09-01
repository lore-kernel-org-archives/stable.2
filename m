Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D6477999
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293532; cv=none; b=P9vqy7+LQoyMK1fu2BrreRQCMVhWNTrJK6Pk/fGbKnCl55M/k6lHHrzQkqrovdstWzAtkqkdjTjAj2s88FVA14FIwzmT6tktP8eU14t0ShL/tlcoouN6RSm0OzH/Ba9nqixgQh9Mj4fHbGqJoHKC5bA4jlqPJy38ypS2K6DbBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293532; c=relaxed/simple;
	bh=vWz7qQ6Tqkfv0QC0lobzqdNKnJfcS3yZbcRAa0hgjS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MA5rUtz+3FjAd40WwtDYDURDqNCF01S13f62csTJLG7LFT88VVd44j1uzN6+zPyMqCiqeDkOLXsPFxH1/YYdfRuW9Mh9/nmr4P6TNG9oJKulfbePowQYd0i7XlD+8AIhnApf3T7MEMCMfkkZtMwXqm+jne9kd3Hzgn2pP/osY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1wIw5A6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1wIw5A6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125B41F00A3D;
	Tue,  1 Sep 2026 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293525;
	bh=Q3Ynw1JPq9Z8y+4HvngBz/K54X1D0QU449+UbGA7JRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1wIw5A6BhdgGz9DMxmyBqdjTGMyXeE2GwI9UoFccJLMGngOmQ34d2kgwmrkZxdga
	 1s1+krnGZZ4UumeDYeAEPC0wzARQBnhrOj5k+q1KRwWo0xuXRg1zyXBgt9XBgJvB7s
	 sVHwcs7OqTdClsmm3/vbyXeNMO5O2JAF6kZybVh8CDmwr43x2wRZMqs9NxVyLjLd0K
	 5AjLU9SH4dhjsk5nldAPYk12fyaF9CsMDyuY09g0mBnYpLARKN+aw7+dPgMcg3dHVP
	 UHvzPTLZVxX0hlFiQM4JRivKVYX+jMr3Ovrjoh4ToUO1rjQxRQgzLe4yswTxvMZKkJ
	 ZVkGRVLOc+O1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Tue,  1 Sep 2026 16:12:02 -0400
Message-ID: <20260901201202.1469817-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901201202.1469817-1-sashal@kernel.org>
References: <2026083111-slighting-undergrad-859c@gregkh>
 <20260901201202.1469817-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit f07a0d251db7606e4792d2610788fbcc7b2c0d12 ]

Clear ->do_fallback before decoding a new ECDH secret and enable it only
after the software fallback accepts a caller-provided private key. This
avoids using a stale fallback key should crypto_kpp_set_secret() fail.

Fixes: 11105693fa05 ("crypto: atmel-ecc - introduce Microchip / Atmel ECC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-ecc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 87e25696400df..4dc34c5bc0f6c 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -84,6 +84,7 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 
 	kfree(ctx->public_key);
 	ctx->public_key = NULL;
+	ctx->do_fallback = false;
 
 	if (crypto_ecdh_decode_key(buf, len, &params) < 0) {
 		dev_err(&ctx->client->dev, "crypto_ecdh_decode_key failed\n");
@@ -91,8 +92,9 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	}
 
 	if (params.key_size) {
-		ctx->do_fallback = true;
-		return crypto_kpp_set_secret(ctx->fallback, buf, len);
+		ret = crypto_kpp_set_secret(ctx->fallback, buf, len);
+		ctx->do_fallback = !ret;
+		return ret;
 	}
 
 	cmd = kmalloc_obj(*cmd);
@@ -103,8 +105,6 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	if (!public_key)
 		goto free_cmd;
 
-	ctx->do_fallback = false;
-
 	atmel_i2c_init_genkey_cmd(cmd, DATA_SLOT_2);
 
 	ret = atmel_i2c_send_receive(ctx->client, cmd);
-- 
2.53.0

