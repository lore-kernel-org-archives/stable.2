Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA984343E2
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562497; cv=none; b=SyZDG+eRQdZRPAFBxIbIxB0ZQiYx94JeAWuO5dZ7n17hn9JnTMOGp/jHK63J3YfENlmzajxU8/+tipROuuhPwxCbiq4gAlLultEh+jSjPvpIBBfUB9S7DuxfBpiT/jcYZ+N0Mym6YFb63wny2W7+pVHyECYZSH2RsjJYj7r2PuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562497; c=relaxed/simple;
	bh=+eWhlrywRgZqU3X7i/oGyLYf5aNZtlLOfwVLLWExFp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJxNXsNpeQEdUYs7UQjw23h3Lt4T9hg5dzxXCpJyvoWoVDb/3okiPtiIYMvn8i9c37iUdcp4w7SjW/AXieEuIheaMa9Q2MXvF/CQZni7dQHvtkGjOlo6PidXG4fWmSbnkqH+qjSs5yybFDpL4ohp/lgvdcjUHY2x+HnFxbaBcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAuULhqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAuULhqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8491F00A3A;
	Mon, 20 Jul 2026 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562496;
	bh=QKdN3aPPs5T2PTOMLn4S7Ikf9C098eBZNlIjXuAEeCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAuULhqNEw6qI+yTJyokE7dRkFIFpvFa7FCMumgFTwN1rPHg/8Z48UyERVPaK/ubt
	 dk1prRLgf8JnFnW3vocviWENVoMThoeMaBOIKNr5r638fFgfhoSQrjZSjJcDt6m3yj
	 iitHXb1rSLYohq85qBPqk7xZYUmXyXjkomBhKIaNv2rKyrJ+ImXR4OUFhgnIib8sDe
	 kVu4FfA/D8Hd1y8S0cw49IvK3fnJtbTmbC5fdjaNBK2umq4sFE43z8jijM4tPVQiaa
	 rZpNcLzntvIKM0fie0Jhvm03xH+srlmSJuTMcXFfuzxCT2R/TdjZZ/mncDRCPiAI68
	 yibrmZRKU+ggw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] crypto: atmel-sha204a - Mark OF related data as maybe unused
Date: Mon, 20 Jul 2026 11:48:11 -0400
Message-ID: <20260720154813.2319486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071514-kindling-fried-4b7e@gregkh>
References: <2026071514-kindling-fried-4b7e@gregkh>
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
 drivers/crypto/atmel-sha204a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 64d5ba13f4baf4..033ed7cb64b695 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -137,14 +137,16 @@ static int atmel_sha204a_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct of_device_id atmel_sha204a_dt_ids[] = {
+static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
+	{ .compatible = "atmel,atsha204", },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204a", 0 },
+	{ "atsha204" },
+	{ "atsha204a" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_sha204a_id);
-- 
2.53.0

