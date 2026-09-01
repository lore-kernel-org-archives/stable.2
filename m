Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184B45C6E1
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301302; cv=none; b=DVtKxvPR3dEuE7LPFzmf+1LUjD3Vl77JadECbzhH6/AUYKrNevxeHoAdOzXsW7RqXxfGKlpRtcOWEMlm0UBHq38j5//dD0gdgL9cW2pxgweUeorzXvG/MmzB1YfGvI8HnxEnjwulZh9TQq8xQCXvqYFQu/wZoTTK0qFQISpzROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301302; c=relaxed/simple;
	bh=cAdA5ogPIaM01cszzrMdJ47T/3yjlVhJe4P3UHMkGPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjR9CS7HruRMdffE//MBzKTyZP05e0VE93wX5xT29bFBHnhUKl/kC5C8Y588kgK+9wYnvAb5WASBngCaz+J1nvyORcBbiD+Z/o+ecznABTWN2N9O1QyQgGrmG9w0D4RZGA/tDXvtm3UhJOOWn5AHl7syv6IQU7kp7IDpXQvEhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkfzH05Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkfzH05Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A681F000E9;
	Tue,  1 Sep 2026 22:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788301301;
	bh=OhiYUU/wZZ4VvGBMy6XbeFL4rkcY0/p8EQjmqP/16ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VkfzH05YSBeTeVVWLoYieVvOZBWuduncmnke17ZiOzVWgCxxvIDhstjn/KDDvKSuv
	 zck+k2zrOTIjy6m47/JRsPV3ZMl0YkeX2Hjc9diFAyFIK5hSRScaJAohTjsR4uBjEN
	 WUtEqVvjnQrBqB1089XQIw7mXgycv8WEbD63uQ6WvpRvZEbXHZ0TqayZK5EwjOjckP
	 HHDYnT2CRRrqaD8/cscLUa/906NPv7G9cq53Z2PcRaF14zM5I6b2JBmXTgC9lQQmPL
	 /9j0dIWX04QN0HCjjmdjGb1KlhKrnt6B4HqMjCUCZtIn4uCCy/FLzgGDCfiC/uYPAp
	 dhHifZBiPz7/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] crypto: atmel-ecc - avoid stale fallback key after set_secret failure
Date: Tue,  1 Sep 2026 18:21:37 -0400
Message-ID: <20260901222137.1700893-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901222137.1700893-1-sashal@kernel.org>
References: <2026083112-tulip-scrabble-f503@gregkh>
 <20260901222137.1700893-1-sashal@kernel.org>
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

