Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0946A5E6
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299890; cv=none; b=YGYIvZqy0uSE0yUWswO3b0DaCd/qLpzF/QD2Cs2XfTAXfPYRb2/RmRtXsPaWXKBN10hoGheADfKDsIeFUKnT5zuQSJ0XBkh5ex4wY/Vj0B3p+Rl0HBpV9jmB/l6S1Xu/E/AFSUB5DNmNDqOx9JRmTw5AmjHrkvveBzrLeCx5Xro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299890; c=relaxed/simple;
	bh=cAdA5ogPIaM01cszzrMdJ47T/3yjlVhJe4P3UHMkGPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8NT1aONMo/Ktg5aSav43+OdLorYKkI7qIVh0o4m/0/fZ2jwi9ChYUpS3luaCHHoeTatPvzHdowDDwmUTtv5jUDKB0tmc/67NMreqe0t4FIc7XbnTuXs4SU7h6SHVhm2T3Rlk8GJgyvpTo//40giddFD8ktAOz9NSX7tp5gWqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apnr9KIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apnr9KIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F21F00ACA;
	Tue,  1 Sep 2026 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788299886;
	bh=OhiYUU/wZZ4VvGBMy6XbeFL4rkcY0/p8EQjmqP/16ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Apnr9KIjnaZcDnMnntaOfEQj8ck9TjTJY7iOi2Cy8HGcIe3XDp+vNXcQ8eiobm78L
	 88zI/Zh6D3zZ0cLLyKK71FPnIw0KG3odg9SFQZXOMuHqNf/iXMZwBq7Y/RL/2yJekv
	 dtgfObqMA/94vyILOUPI7gykVhphXSQXap0NiqDL9nzBpv5m2mB21y3qriSj6ejwqT
	 iCoTrZkWq2OhPYEkKecm0AI9s1MLSGxGflUAVMKYRb0gQs9oq5Bmd7J76+E/P+Iu+F
	 0uUsWeT8TbjbpVmCYEO626oGmBD9rWT5eeqDw8svS8l0Q8k7M00yuN/CJ9c3lVpvd2
	 EzNF/aWZkV3GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Tue,  1 Sep 2026 17:58:01 -0400
Message-ID: <20260901215801.1668303-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901215801.1668303-1-sashal@kernel.org>
References: <2026083112-dreaded-mayflower-4781@gregkh>
 <20260901215801.1668303-1-sashal@kernel.org>
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
index efb346e5550e8..91edb42aba4af 100644
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
 
 	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
@@ -103,8 +105,6 @@ static int atmel_ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	if (!public_key)
 		goto free_cmd;
 
-	ctx->do_fallback = false;
-
 	atmel_i2c_init_genkey_cmd(cmd, DATA_SLOT_2);
 
 	ret = atmel_i2c_send_receive(ctx->client, cmd);
-- 
2.53.0

