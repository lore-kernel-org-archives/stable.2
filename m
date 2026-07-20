Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F138182D6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554229; cv=none; b=s2/lRGIUp7QZLAwIGplBSNnLrh04KVFrxsQE0xKBKSU6P4/1fadQEYGLi3o/NBXFPdjEaeCmggJV+WHiNSdHCWXJLEaX1u6NkDZba10Z2A+v9dbpdbA+rOyH4WQzzUpVeKbnwQhFwCYbN9y/RAOPFVCzx3nPIlW16oAP0OEeFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554229; c=relaxed/simple;
	bh=yNdIMmLv0NGNH8QqEoRMldkDkWPXEm11ax+7PtoSVuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5pyWkaVLU7ftrVgXL4yxm4/GIPjKpEHf0aKA3mbQs6JQixYEuSCdTPTIYgkN4o+zeqTsx2UJZSCj/LDENFNOnPfXlTLV47UUw6a112pcTScdy9YfYvPu9ptT2HytwUNFUNSixYvwRkaLYgGlP9oFy88mXdEeAXXYb9j6j53+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLOYE3uN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLOYE3uN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068CA1F000E9;
	Mon, 20 Jul 2026 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554228;
	bh=fI19ko+0CH3iJu+cXZQYOUhdvRlQMARwDTLxDYi/ffg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLOYE3uNt1s0xbqy0sfBxXpNhmhATfT6HsY2Kk9BMeUYhlX7x8ZzOlFQW6dQwXfFp
	 qfEM5ETnfkpSz0HDZWnP+wideOTjVNhc1m7Ygd7L+HRA0bZDTLwAVDdC78alZOwJvc
	 PcHbyEZ6R5kz3LZZlMeiKFs7Porw7dc/rHPRJCQxuy/Qja1I9HC9I50n6lJnp+439p
	 Kb9ttv7yca+Tb2+6SRkslBPlp8yCAp7OoD0gXWrf4yP47ikGsTYeFg5o20X0s1DIGD
	 NPuZNXNCd8n/kupK2UspP6zIM2Ubv0ypayPAPP+aHrc98af8MaCudsnkw59tlwBF0T
	 i/xfinToS01Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] crypto: atmel - Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 20 Jul 2026 09:30:25 -0400
Message-ID: <20260720133026.1149181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071512-stuffed-blunderer-f733@gregkh>
References: <2026071512-stuffed-blunderer-f733@gregkh>
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
index 2cf5407818f146..b4bb35eb4a4b4b 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -139,8 +139,8 @@ static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
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

