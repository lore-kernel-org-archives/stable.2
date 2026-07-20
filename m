Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA83434E26
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562498; cv=none; b=kL1VNI7xaVpGnW4VO+2lqVYqhc4AsTLlvw8t2tzjpOWXcwEBk2gM4k2Nvm33q3pHVcMwIjIr9E+CUBxK745CKwqdRXLxEiRR1VSa56onKKzFvKv6+KaEWof8y6XgqbO+1JUorEtWWPNqbHr6spR9F68GPsEtGkzNSkerp6kZ/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562498; c=relaxed/simple;
	bh=MM3Edi8NXpABU+20xv6K3a77BcaRHFzRFgqjxVH98JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLxeAcP/NSCCLF5YbwaLGwuEIgUpg0scgwU8ySBmSdK8AzeUjcGokcKKMpSEl3+JOwm3Wr7BH2T0XEfxGxRZQ1QO3AwoxwczIbHURGXzUtmQRhVQKUtUNLxNWs/dUKSEB1fP4MSyULJYmCTvS/8fo/mlLjTn6V0UdycCyNxW4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxUyLcqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxUyLcqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852621F000E9;
	Mon, 20 Jul 2026 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562497;
	bh=okKRkksksk3vOjmxMUXYv/EtTP1OyBJ3XQDqbvyNvrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WxUyLcqbQ41tENvWalcKPt7rf3sEzt6k1YOUx28hBMFCuZvzab9SFPdCEUQF8MK+R
	 tOXwEsyjfP7vaKrs/v3AMl8NoKAXi/dpbNY5jN9gdp7xVZjoYZI5PQGjsl8t1YXaHs
	 VXjxw6f4GePWhgpxXKydAdhHamf0T39HEE00koKOevegIKNKpK5wVa+fnDKI8KEFLp
	 k0I7VQakI1TZhiJEvABtMdoC74vFcsc8oITkNKDXGMQOt9BAR71Ytg05h7W3GMyGc+
	 //TSs6YZdAfdpGDhJxni59hgRltQuO1S8hsL6U7g7G0u/9td78RQC1lvewDBzfyf18
	 JXW9B+yizFQAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] crypto: atmel - Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 20 Jul 2026 11:48:12 -0400
Message-ID: <20260720154813.2319486-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720154813.2319486-1-sashal@kernel.org>
References: <2026071514-kindling-fried-4b7e@gregkh>
 <20260720154813.2319486-1-sashal@kernel.org>
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
index 4162dfb31dcabf..c3a9b223d83455 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -387,7 +387,7 @@ MODULE_DEVICE_TABLE(of, atmel_ecc_dt_ids);
 #endif
 
 static const struct i2c_device_id atmel_ecc_id[] = {
-	{ "atecc508a", 0 },
+	{ "atecc508a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_ecc_id);
-- 
2.53.0

