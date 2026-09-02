Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E847728D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346435; cv=none; b=fr4bvCEvbJIy3Kqhza3G77dgobrbfixzWfmF9kuFuvm+6znFvpxM7WqU0IfOf/gr4ijYklQ+iUIUvPcvKJ8+3Dnvj4WXrjbemSrVKpr+3CSGmOD1RCHwvfKexj6pa6RnKSCL3WWMzxWarzPr+mfl1YuqkPfE0MMQUVRas45/czY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346435; c=relaxed/simple;
	bh=ntTpe0PaXfS8/Cz3nxp3yWmIWeUH41zpw0uCWMeYvnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiLpXH+xz1MfN9KXZ1CFv3W10Ga27mLVGXnNlK5n8n0+PH1GGd9zVrp5/E1B+BEjFMPUvfa3e5QsJ6Zf4artWWauF279WCe70OLydCTmUBaoKAzERpclWITf4GvQz8NTee2TIGD8qzSXGxx9km1QAbs+U55opdLEKYt3Mq4DzA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlxKUC9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlxKUC9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B211F00A3E;
	Wed,  2 Sep 2026 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346408;
	bh=yxBBQsE8sTP62XzBZxf6ILUG1Dm2/NynFUib3NUXEY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlxKUC9QHK6oTz9ER9Gl0XhIwa3ibgNHzLHGq+NSNcb3Ld3W9VOXbNA3bbZSLuc4J
	 QSOxf9wTRnzT3AoSs8AZaAz/VNN0c467M9r/3EQkONVEDzuJ4p7d3XWer5FeVZc00u
	 ogCvUGZwMcvt915HnBQyO1504vx+mAga/iflEzyA2BGSJV0IgCy9RL7v6BazgYGT3q
	 +biEUGsgL7Mos2uMbm10u5eaxIBSWilxeFPCX/FpBeCGRXBz6MdQIKkH1mQ5Hm8ogQ
	 xhDCRud8swEZczrmsqTXkzfPZxWbjxGMoJQwH/fp+wCNF0PSmIH2TY9tY8gyylrh6r
	 lpeDlqcRx0/+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Wed,  2 Sep 2026 06:53:22 -0400
Message-ID: <20260902105322.2048136-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105322.2048136-1-sashal@kernel.org>
References: <2026083113-premiere-tables-885d@gregkh>
 <20260902105322.2048136-1-sashal@kernel.org>
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

