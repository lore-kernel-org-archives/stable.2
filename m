Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140F42A7AC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555467; cv=none; b=cTB8dkhaSjcEEBVesQZ8eMChp80FuS9x6seJMHaR0DuV16mjpELI3Q1PE24zZKbs6pCfcLAm8AdjIoiN4jEv/GgXNoHjPAt+NX5UXeY7m5uvhOrrVwGbevLIv4dMvz5ujwqi25+IxskqAdQYNh29IlZNFFbnBWypii+TJrgOVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555467; c=relaxed/simple;
	bh=r3g55kAxuB/OEgPtG0TQLGbSPUD8AovxlfgtOHUx73c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+BkqZw560RX2Pisjgy9GQ2wc6HIFaPix2D8814x5j/pJV1288D4+rRj+tNWFDCmGwNJc3pXEgH0Zm5W7Zp4gN/tCZCY5dsq5oSgdfkk/5Ck9YKRlCuue88JZ+Ev4hel5j2s/gbl7AtFto8n+m2omQRLjbbejREKJndLysfd8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3eadp/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3eadp/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3591F00A3D;
	Mon, 20 Jul 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555466;
	bh=HcdzzhuC4dgrDWsFgAoavlihFuzuDFObWa5qrAx1CLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3eadp/ZB3/ZmHJgopTHo4V7RbcVfkTUyuT0lPATPReTpxDNiwSkj3fKPlnPSViI+
	 s704PH0ki//Ptu3UD5xUR76tbd8gmTHGKy5SusR+rQ4dWdVCTGR2r8KGHfaDQJSu+m
	 caQ03BHtPTmsYcfMRJpdfYWlS6ENbWTUGs+1VWSeL7sI2aLlnhhqEx3AIHoeuNRPnh
	 Hl1kBwUTvgvd6UPHcpO7xwy3UrkhtwKA4WhUiYBcg49mdmpCs3mFc0n23Kj3aGwBNv
	 sgopbs/C0gAdjS33qscydPgjRVqVF1DCF2uIA82z9h8IL5cmwL4FBY3lpR7Z2S5GqZ
	 FWNZQgFFMazmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] crypto: atmel - Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 20 Jul 2026 09:51:02 -0400
Message-ID: <20260720135103.1306043-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720135103.1306043-1-sashal@kernel.org>
References: <2026071513-flatness-crepe-f5ee@gregkh>
 <20260720135103.1306043-1-sashal@kernel.org>
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
index af0921f2a73a53..75fb7be844cf17 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -381,7 +381,7 @@ MODULE_DEVICE_TABLE(of, atmel_ecc_dt_ids);
 #endif
 
 static const struct i2c_device_id atmel_ecc_id[] = {
-	{ "atecc508a", 0 },
+	{ "atecc508a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_ecc_id);
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 3a5830ba4412f7..45703bc3b40337 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -140,8 +140,8 @@ static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
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

