Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B8182D6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554243; cv=none; b=WoXFJQ4ikGbw5i7ytugmaTdYIdh5vSa1eYbUOlh9yYpIOUdCFGjGBIlSKGstbbTIVvUbt+ZW6O6n+wr6mTiCyMqy/7hchZsU0avbqN42ejg4qE4cJAztEwa8AHrNx3/nBFlq/L0fg36vSAQ8egCayiL8HdssYUTmaGt3oLthq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554243; c=relaxed/simple;
	bh=yg+dJbTEmZh9XAt2xcMLo30QZfDAu6UzPe6C5899yi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB/Q3RdR9Mhby8HPoSP+8GCl6MY4fbBEXkcPEV/voTYSEKgBdsubOED0qEmRHDf8tMukL2lVT1XLiiGXpiIbuqYRVe5nbQ1OgQ3PU4ItSyV3iTHU0dAXj6cAkizx9u8MyNiEs8FR64MMSCw0fplxnQexf95v+V4YFKOp3uz8Gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL9ODxJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL9ODxJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93FA1F000E9;
	Mon, 20 Jul 2026 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554242;
	bh=aXw3WJQRhBMeCj/RGwEIF9O3pGsV55qIc2YIz77M+Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GL9ODxJIczlkRbR2glSgqcqv66O1fxWU02n17g48VVIj1ZmX1nIW7rE8Jbe0FCp+W
	 KZGQ3EyiH52cKqhsVm/5Dq0/kxtwQzltaGsQ1Ss8c7B/bIO8QE393O+6j8FAYO3I9T
	 IL32VmMsxSTdyOTTskbEJJpq6oaant5ScbHHsZpzBQJJ/ZiBemtYZihlHdad3TvFf6
	 NJ+Wl6lsujZlc7Dmlw9FwWHglcTHbPHK94Ln9oOnOM4r723u5I4HNzZ6rn2PULYNe1
	 uCpWm3KoDaTcyXDOaEkmkVaKezEJ+bjcIUdEsSUoNxouUWdGhL4Dksfpj0if8IY1gY
	 Mf3q8GTXvV0/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] crypto: atmel-sha204a - fail on hwrng registration error in probe path
Date: Mon, 20 Jul 2026 09:30:39 -0400
Message-ID: <20260720133039.1149543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071522-shy-landmark-49bf@gregkh>
References: <2026071522-shy-landmark-49bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 49e05bb00f2e8168695f7af4d694c39e1423e8a2 ]

Commit 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
overwrote the hwrng registration return value when creating the sysfs
group, which allowed atmel_sha204a_probe() to succeed even if
devm_hwrng_register() failed.

Return immediately when devm_hwrng_register() fails, and report both
hwrng and sysfs registration errors with dev_err(). Adjust the sysfs
error log message for consistency.

Fixes: 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 49e545ef6493b9..66daf254072dd6 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -183,8 +183,10 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 		i2c_priv->hwrng.quality = *quality;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
-	if (ret)
-		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
+	if (ret) {
+		dev_err(&client->dev, "failed to register RNG (%d)\n", ret);
+		return ret;
+	}
 
 	/* otp read out */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -192,7 +194,7 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 
 	ret = sysfs_create_group(&client->dev.kobj, &atmel_sha204a_groups);
 	if (ret) {
-		dev_err(&client->dev, "failed to register sysfs entry\n");
+		dev_err(&client->dev, "failed to create sysfs group (%d)\n", ret);
 		return ret;
 	}
 
-- 
2.53.0

