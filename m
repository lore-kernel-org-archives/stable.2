Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAE3EA940
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544885; cv=none; b=KrTe9m+kAFMKnKF6OLTXEHj3lm13ImbwgO11dgkoxO8xvFKPxa7I7ChVfAYpHGds/qQXFD9GfRs0Lrjfy0si5qE7DnlbpPFEiikdcC+p+3tyCxfjm/TJSH9CvWfN7Tw2jhGtbYw820dIYeG3trxawl80qpFdOt7YaFE24Jq6r98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544885; c=relaxed/simple;
	bh=U6ZP9SBCqJT31+Sz5zUQRKtAOrjKsS+1c2hxtvovX54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzc+9TSxizhi53y9iUDoS9pBeiR5n5yItJ85BvA00PxhPTQQ7x5JmKePIZnJZItngCoupDxCdRVSaCUux+c3I6VbeIPcBqRpf20Mq81n34AkXdifvSkrwmOy6th/f3yZffjB2kSjdPRzrsBdu/H8+OcyOQVRCbsoOXttIOjv8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5UcfRLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5UcfRLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAD61F00A3E;
	Mon, 20 Jul 2026 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544884;
	bh=vVlHNiHxC1D0YfjZ/WcEI1dZ/jsoKImveHnCcY+EcTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O5UcfRLRaAAaTv9vLCBVD1lyjqP2jqeI/0eAb0r1+IOTjNFOeojgjGMylRWB7k7nk
	 t4XGo3QdmA9fMpAgCpEP7AprbDHUhWieVwoV1ruE8VysG3clVwxDtWyJxWnhjU1nFJ
	 QjhwLrbqTrYWM5mI57kta5HNcYv0Nft4ah70+Y+ZACx/t/z0tMpwBaPLl6R/a9su3+
	 4q/eHh0jKjX7w0wqLQpFRHaCv4HGOLZAKzL7a87fV/mqgfzhB2y/9D/uRsL9o3V4M3
	 8B4ohvTHCjyD2kfLxV9zpMTvANlerD0TDM+x9YKRSFgZSp/121f0jxNnh5xb7S692Y
	 WId/4KvzxLIGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] crypto: atmel - Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 20 Jul 2026 06:54:41 -0400
Message-ID: <20260720105442.215749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071512-herring-explicit-5a7f@gregkh>
References: <2026071512-herring-explicit-5a7f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit d86ad3911a5d4549297ed810ee450e5772fd665f ]

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: ea5e57cc9718 ("crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-ecc.c     | 2 +-
 drivers/crypto/atmel-sha204a.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 813d8517e1c3ca..9da5a03880807d 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -380,7 +380,7 @@ MODULE_DEVICE_TABLE(of, atmel_ecc_dt_ids);
 #endif
 
 static const struct i2c_device_id atmel_ecc_id[] = {
-	{ "atecc508a", 0 },
+	{ "atecc508a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_ecc_id);
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 1add8dcd306f09..ae04b27a9ad112 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -214,8 +214,8 @@ static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204", 0 },
-	{ "atsha204a", 0 },
+	{ "atsha204" },
+	{ "atsha204a" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_sha204a_id);
-- 
2.53.0

