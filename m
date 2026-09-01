Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79351D514E
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296845; cv=none; b=k3wmm1nj3si7Tbn4Z4tFERk/7Kd7ccjQTAnHJtlVDTrIHf+L6dirQscqv/d8BhL0N7zY/N4mTCM/LDYJ3VPe/ynJH75DQGwV6RunWic8hHy0YrIJ7y/yB9GZ4jWtHqec9DXF9DkCZIME8C3aSgz741gtPmMDZFeyMVrqpY+KQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296845; c=relaxed/simple;
	bh=OGoO/WN0q5yNCCXOENl4Dl2JeoRG1KayzfmdoGVhIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0dYNMrm9if1cG1mcEaP2E7MTifF9ouaOVf20siVGfNBFsM8xiKHYcoUr4Tmjog2BXXuWVRxPb5S5LhxZ9617XqqkItdSg+xJ24P7Ic9CBLHmSPXvHD691EImc2SFqRMG2vA3Mmwr6UScZWQ7fBYdNE1K/YIDZSX8NNkW19MmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsIRq8GI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsIRq8GI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0AC1F00A3D;
	Tue,  1 Sep 2026 21:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296844;
	bh=Ki/SxLrcfesoVqOOqabmOj4iZYHWJ3fMmm+qkzv0H5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsIRq8GINruUorMvTng6Y4t/xlSi1wzAXs6YaQtFohavHjq8vP9KX1jC5+FJu2vsn
	 dXjz69hHinMaBFrvNCthaH4ivl0DY20NITDn3zlu3WXKh3eJQMjUtmt7MCKzDBCVpn
	 151PdYd1Ea7fiFe327Fob7fX5AaALFWNvd0J3N6On5pfGK7KhJvMn7iT45CuH30Ukt
	 09HjNGrCberaEUzIjPt8OY6IN9wEZv7XxsEv8w/JhNA8IQMhdlbYGj1hEMPo2xPorg
	 DqvstuoGUkoShYd0qYCfa+PA7J34tOlLTjiyddXn47HxpqTnHQASDk61O9Z+nS4R3q
	 IvDGAyMNsSTjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/3] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Tue,  1 Sep 2026 17:07:20 -0400
Message-ID: <20260901210720.1603783-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901210720.1603783-1-sashal@kernel.org>
References: <2026083111-derail-placate-9202@gregkh>
 <20260901210720.1603783-1-sashal@kernel.org>
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
index 8a47ade1a8a71..8d4e75be9d184 100644
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

