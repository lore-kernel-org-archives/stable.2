Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC83806DC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306346; cv=none; b=FNeNKTuwijlOl9iOCxvfhwmbrgihX6uxV+LiMQHO0dxTgKeBEYUbSGDpuUWNDZYxPTuDxynvSyzT8VtePmguEmX6VI6AuMHVw8Eb8KnIxPJd6+XkO1mKi5xeneKQ4s2/QQbpsPcoVN6/BmXtHKoxVeGgMmzwnRkd5fYNJoKm5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306346; c=relaxed/simple;
	bh=y8y41rQ2mY6sye0Jsm/o+PzQHYDEHCZ8bY9196VUmjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmRXrY0hUofYWIUmAcHwxSuVMR8J0ifnkCuniuUNKvLu3yc2va36HEOqmxsOjMI4EwHOB9Da5R/ZdDQOrBIRqMAVuBcH6JGZc4syTED2neEc8b1Jlp101QdI3IE5vcHJGu7zbD33rlG5Tfy53btHpdVll/pAu0KWyys4AC3+p/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WatK+MAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WatK+MAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7411F00A3E;
	Tue,  1 Sep 2026 23:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788306345;
	bh=KoIfr0KDmQ1REVP8HUKJbGjIa84XO7v4y2xE0JrXsIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WatK+MAHZRqzsCmD0jpxuCBqbuLiKEKHXPVCrGNjKn/LWTOc34BgWF4afkBcaOxid
	 Xiw25SSyfouC33np8ZhumbeNlyp2Ptrs3ACHqb4AECtFLLe+AyevYyiTb8JeBsW7JO
	 QUef62hhRY7D9dfc8v1D0MLiS81nx+6uaQYlJRouYsMMB/piMOkZt7XcLwuZ3MpGF7
	 DSHtQVKlEUrumT8XeuXaMmSAEWl++V7MlRqj3Is4XjjWRzcLF8oEZyQUQO+MlYfLcK
	 obvb3HAz1+Ovlidrd3Os/5ISmNks/wTqDmhSb95ID9MCDgOEUUQohMkiQ3HqU99W12
	 krkNaYjZATCCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Tue,  1 Sep 2026 19:45:41 -0400
Message-ID: <20260901234541.1770079-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901234541.1770079-1-sashal@kernel.org>
References: <2026083113-uncapped-voicing-f7d4@gregkh>
 <20260901234541.1770079-1-sashal@kernel.org>
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
index 8bc22af2c3c50..aa1a143250efb 100644
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

