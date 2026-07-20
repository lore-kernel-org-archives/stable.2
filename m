Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824B42A7A9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555469; cv=none; b=In7V5LuyWt8KuG8hNTZLH5tXXzVktoIYAmQxk1mO0U9ItTbHexOwo2I+l943rt+cUmU2/UUK+z0/J8rf4coD7NceonirmQ7FTS82T86dkxTkd5Wo8gmnZIBU0QX7PivRq6JKQZ4xETlctI0Gbkc5K66Q2JTfNV3WwEZAyxUpCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555469; c=relaxed/simple;
	bh=LuBWnpLpyQB2cyVHp9IMXdQRbMwESNxJx++j3AXZAf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMBrfrkADP49toA2tujwhoCA5xU/8E7jR9vvY6i83GrwDfPxg+5VinSYCQZxtEB/6PZngwKQcn+HX6HJMUgnDZ2EU+iTDS/Axar6neSNBCGXGTbzbjxWPY1+1qrsKRUtFnwUdRrvO6dgbr8txXewuL89R8XZHsU/mHWXhjwgEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0rL0UzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0rL0UzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F711F00A3A;
	Mon, 20 Jul 2026 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555468;
	bh=rv/rw1tXSHqarffRKpwu4+tXkdFRVze1cDSn/fEVhNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0rL0UzBnYhmkKdw8+Zy6P4bZGJQbSgLtkVDr7ofN5O8ymnhVQ8p93okcB0en5zE+
	 y0DInQj4LvVIMWVrDC6pfOUnnyufbtJ7Mc5UyiNDYobhEzuvP2U9Shi6XLaaT4okq1
	 Fj9pd4jBKvmjokqH9uSTbPm3f6WmqaKmWTWCncZEJT5zlyAdF2Qg65zRa9IfmQ4UwF
	 NKJI4A2CWOPikU7Amu+HiqCscvJ9cQMAq4C8l5nRXqvinOOCrYbjDnoD2dAzcefte3
	 IduQhrjX7vT6TbC9BGVYou1Jb2GEh9s3tceF5cDSqbroY3OlsqVDKyoayCdCtXixBt
	 YYbHezyOt0VSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] crypto: atmel-sha204a - fail on hwrng registration error in probe path
Date: Mon, 20 Jul 2026 09:51:06 -0400
Message-ID: <20260720135106.1306281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071522-confiding-outhouse-33b6@gregkh>
References: <2026071522-confiding-outhouse-33b6@gregkh>
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
index 1add8dcd306f09..f444939134cd6a 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -178,8 +178,10 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 	i2c_priv->hwrng.quality = 1;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
-	if (ret)
-		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
+	if (ret) {
+		dev_err(&client->dev, "failed to register RNG (%d)\n", ret);
+		return ret;
+	}
 
 	/* otp read out */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -187,7 +189,7 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 
 	ret = sysfs_create_group(&client->dev.kobj, &atmel_sha204a_groups);
 	if (ret) {
-		dev_err(&client->dev, "failed to register sysfs entry\n");
+		dev_err(&client->dev, "failed to create sysfs group (%d)\n", ret);
 		return ret;
 	}
 
-- 
2.53.0

