Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99D42A7A5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555466; cv=none; b=EG4bDMql/bZ1QgP+iielwODALUKhVSgkhJDYl+azJatlbWsoi+zKw/pocdg/RlR7FaBf6jb79mAM97DnDaeYvRy7jiV8olwfC6C/gkta3bEmcM0EuITDcdqZvN3lIdeYWUmgSsJC7oCLSeDKW4igYWuPT89g8k4IPDmXzOLFf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555466; c=relaxed/simple;
	bh=7z5tCO/10kCGdIU5pDIUE2WKnWRS/MzBYOy3ScKeFS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLXtK30/VCbh/E9QuZlfAIZ6mKXjjGxxTTlKV4oEi+AOPJs2wkJOvzOCu23uCpXU8slMtWUTYloMEm+1OEPJjl7+kqebLi5PPs/ALRooPwK/eDScmYblh/BYg8bOqTMNdzgIO0qrOiuEsI2WgFb3LcfJay/7dfRSNVBlbjDOhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/GdvyfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/GdvyfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94521F00A3A;
	Mon, 20 Jul 2026 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555465;
	bh=Cye/PGwwS8IMo51Jeoaq7FyjCkE6CDxNEHwzuOiOHkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/GdvyfHuISzbXY65wjRZCBi4jCAeF4PjDhySYpr3jhXsyDzP/v9ZEhRgPGjzR6w/
	 +RtDud5PLlrP0BqgbTLXog97hWtGpDJ8EX4vxDVK/iS+47x9qxqO2gIOqQMyEhTs03
	 3EVbJiFCNDS6WiXz2bxD86LtzwOcurixaw/DCr0LAkN/a1QzHcNljiL7COFWC/A+/K
	 WNGQ0gOhKJDYdVmelOQxrQTNDyz45MWB0Pz8icQj4/JpKZWbyjloPFMF8YZ7mDqdqZ
	 yvhsrpjkaghhezbNlYX0StzXk2lQAfQR+f43HGWjq3Uz51S+0j+cPka6ki3Jdrluy9
	 ZoN/Z+wpxJuwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] crypto: atmel-sha204a - Mark OF related data as maybe unused
Date: Mon, 20 Jul 2026 09:51:01 -0400
Message-ID: <20260720135103.1306043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071513-flatness-crepe-f5ee@gregkh>
References: <2026071513-flatness-crepe-f5ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 75f3d950054389e2556277e42170e37dd97cd872 ]

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/crypto/atmel-sha204a.c:129:34: error: ‘atmel_sha204a_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: ea5e57cc9718 ("crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 989c8b72cf3835..3a5830ba4412f7 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -132,7 +132,7 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 	kfree((void *)i2c_priv->hwrng.priv);
 }
 
-static const struct of_device_id atmel_sha204a_dt_ids[] = {
+static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
 	{ .compatible = "atmel,atsha204", },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
-- 
2.53.0

