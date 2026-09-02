Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D81214A84
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309209; cv=none; b=bFXWL0cMW1Wl9YI4/z/FynSRShdvDtgMh/X1xs6uhrPYTN9Dbw33pZ3hicCx03MgAF8eHOEAAcz4/x7RYmbrqtGCnPiS5xZ6zKKIqpz+XezMRohnKliPmtDNAIrbg2T97xkVQ41m4Hmim8+g5unkjJVhntJDt/+Xq/RHt+wyefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309209; c=relaxed/simple;
	bh=ntTpe0PaXfS8/Cz3nxp3yWmIWeUH41zpw0uCWMeYvnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBIvk2i4587YAxaUGQxnSyIpV+t4YpBH8Wyh3LYL6m0nn6ZNxfM8BbfW0Y1pphgoD74/yrfMt6aCl/WzObeLHNitlTgZPSbxQ3nY0xY/CEEtwd5zmebhJvQH2aJyvVEzF4nW8LWZXwU9YkpuIxicDzInX136SHiuKpaZVweOGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hldcd20b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hldcd20b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A141F00A3E;
	Wed,  2 Sep 2026 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309208;
	bh=yxBBQsE8sTP62XzBZxf6ILUG1Dm2/NynFUib3NUXEY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hldcd20bwuIDFAYXKCgYNFRDw8KfA0wlDkMvpzmSWutqHD0SLAGyMl4wj9OJfYicX
	 BgjkUwk5A20ek+3pP6y3Zordpg6BET0RihPCW5JC/e0U0quu2RRp+zaQOCPBL5FtQ/
	 rfjrELBdV/hYz1rhp3KsPfSpEzkkxNjVFPxtU9AGwBm4/xClEri9PTGyJksTlDzxDm
	 UNCs5IpWZ6XIRVOOlmXkc+NA6NeJZsxuF3GbPw4UhRyhR9bIDkBQxZMJQ47pDss935
	 qp+9aYFgrux3/PSGdfjvuejPOpy3mt6oOi1I4ufMhbVS3lmegvQIJbBUWxiYkj0lIg
	 m3AEZlqpSL3gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Tue,  1 Sep 2026 20:33:24 -0400
Message-ID: <20260902003324.1792196-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902003324.1792196-1-sashal@kernel.org>
References: <2026083113-trough-translate-08c1@gregkh>
 <20260902003324.1792196-1-sashal@kernel.org>
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
index 7950e635277a5..415970cecb329 100644
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

