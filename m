Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327037;
	b=JqJ5hEMpsUl25TcqePhyBF8vnEzWzToxBiol8/0YFogAxlCp8IS52uQGLMc9jm598xo7
	 93/3H0esrJV9GRRyu9b4MWCFhB0bAUzQg0Y63BWsrbWHuAjy0Q8HsrGlV0GQDihQpegq/
	 hlSzZraPUpYKDxN+3AzoS+9TXaod8JkFWeXb0XwWuBSwTXGQW0uODMeJ9r5DvtxVMVCOo
	 +pUlmeLM/RZfTjpxPbgEJ6HT8htrbcX9p3I3S2BCjvJxJ1ZMVCI8d2FtmFBI0jr+3dpw9
	 7vJVsQ/quRt5c7chGCFb1gnbewicyJZI79YWkF+/Leoo29JsL9/aiLuuhYFUYpJTubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u76qoIy0ErZOo3lGtuUE0Ub4yL+XugQzr4JckF5cGP8=;
	b=C+Kh/zOa/hIyXs7tP91mYKBMBxltrzAq3x+vxFckXA1ZblJF18AwGZvHdYOI/ApViihM
	 jznbqqHzuk8rU+M5zMndPmgv8ZSe2P6/K5KbjCayQeAMb04CzRR/UAmi9XDf5Ae8bR4qW
	 mWYC06VQdgGVqXpL0PKBO8FTiTbmdVgIzhHdo0auO33Cl7r50BXKzId37wb/eL66QPuep
	 lE4y8grOCQP2sOBeviiRhkGpbE0vWDvzsv0zWQDBLhRJtYCmLJJcEaBJTD1643Vgt/wQS
	 v6AIdanIt9xQ9briIoOFkNZiwWoBy7kZjJ7PCj2gYyeUdpO/huTRqaKTlLNQ2EAN7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQnLYU1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED360A2626
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQnLYU1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE401F008A4;
	Tue, 10 Nov 2026 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327037;
	bh=u76qoIy0ErZOo3lGtuUE0Ub4yL+XugQzr4JckF5cGP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQnLYU1QAM7RMdQ+nyxrvno8MEMCXDXYslhy6tML4CnQo+DDaEoTv64j4J7+aA7hO
	 yHkh/n4KfZU2MP8FRgQRAU3iyoiFNB1BE2Q8iNUEz61/YZUI1sLFKISooWu7huxQaa
	 qnY1rlF78fchG+nqTk7rqRnM0D1Iis/NFXD1cDCaE6385cIzTeKu2j0Uk1CprjlRHh
	 IYdgbzIaPGlIn1MrRgY4UWGZv9LGkeG7AaJJx4TWi7whP35ebhuNsNAk6sC2gpc/Bc
	 WmlLzb9eUHczO3zalqf1MIzr7kzGrktJnIFLcQM7hFm3/rWBznm8Qqi1weCzINAExs
	 Wa2utMyhBV2gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] mfd: twl-core: Use i2c_check_functionality as boolean value
Date: Tue, 10 Nov 2026 11:10:33 -0500
Message-ID: <20261110161015.2399183-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161015.2399183-1-sashal@kernel.org>
References: <20261107060010-failed-5.15-3c5c55d979dd@kernel.org>
 <20261110161015.2399183-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 7ee4fa2674e51a0d100b9240cd8a50355141362f ]

i2c_check_functionality() returns a boolean status rather than an error
code - directly use it as a boolean value.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260505114543.159381-2-thorsten.blum@linux.dev
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 3c5c55d979dd ("mfd: twl-core: Unregister the auxiliary platform device on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index ae5f101167b45..acfc0b96b4a1a 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -791,7 +791,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
-- 
2.53.0

