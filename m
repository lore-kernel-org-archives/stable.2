Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771613B47F5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559655; cv=none; b=rE1KJ2R2KfKpVw6YBdVY6GMYkjnJezYaxoaEKUY9IGVvCST1rYK6eDrUgHcCUHW/iYnqACVHRAYHu+LRUsfl+TBKGXpwgYyV6wBjFkgLIeo7F05QvCDEXFXZ1SdjDPI9M9nQT97292cb5YVbZAr0Oik9EyOnpDicm2kBtWFH3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559655; c=relaxed/simple;
	bh=qMP5RU0Pef8Xz7nZsUnH+QXqu2AzmL7SSYiQCfnmoIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws88BB0/YjfI5w/VJRQ8aQtjaeMyFV9v5vpVHVc+MQGrIngwHxE84A7ryOYSOG0gkD9/WUiJnsvKiVSYwPjjEH8NtUMcv413W94d64CE2ges8hTWxD3+vPOuXgyUqPBvfZiyebpAOEcmKl1w9FYP9lJw0jqra1rEj+dEBd+Zm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP3Pxvjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP3Pxvjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E811F00A3A;
	Mon, 20 Jul 2026 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559654;
	bh=Nd8tCTIrwgBg+XDrKUh2ffiHvSZqfyUw5A1tmagTqSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JP3PxvjvAwxwKQxy4nHlOywoEjir/+DKy57x7+lPbO3pYWUhvb7YAREfVjKTJbzCA
	 aeb0wdQLx2OAXQFupXDtsZ/1g6+wAwu5fy8buLQc9sVl++FXG8oc8fvBroL3gYquVL
	 mLNWdfKjs8KFowVyULdzUIDYpJHBkN5Jnfc83xI7OTDfDvxJUrij9KNmr6rE5carI3
	 gGMUy7cw6qvIVEeQgQWneda/Yhyz5ihO6Y5AL++L0VrqjvLX9aEQB4yC5BWMYjH5O6
	 iwOlLOtTF76c8/Uo4xuW8Sjc9wEIUXCYKcCbHOIXFBWMJqvcXaRRnSp9qQmUk/P7ux
	 K4jVkqcqD0V1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] crypto: atmel - Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 20 Jul 2026 11:00:50 -0400
Message-ID: <20260720150051.1918796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720150051.1918796-1-sashal@kernel.org>
References: <2026071513-seducing-second-a53b@gregkh>
 <20260720150051.1918796-1-sashal@kernel.org>
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
 drivers/crypto/atmel-ecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index e427cb59a162b1..004d87cbfa2213 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -375,7 +375,7 @@ MODULE_DEVICE_TABLE(of, atmel_ecc_dt_ids);
 #endif
 
 static const struct i2c_device_id atmel_ecc_id[] = {
-	{ "atecc508a", 0 },
+	{ "atecc508a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_ecc_id);
-- 
2.53.0

