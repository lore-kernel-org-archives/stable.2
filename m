Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313359;
	b=1LSD85OJwJrn6d+2IxV1jd9brT1SzkrAogypH1A2m5lkP+xP2zNJTELpTjU5KD8wOI2S
	 nzgxITzf1iVGeyVPfxe5450mzqfVpUbwc+zS59BsvQLqpm+fFZ09CAfuIDXhuslwtfZVw
	 I3uYzToC3YF+p2J9S4ken32hwoNL956SRUrl9le9DquXykYdLOm1JiFpEJiGqEAHrFmjO
	 OL0YReQ1uEKPXjdTkjfXkdJe119J6QKsLVY/+E1Q5Ts7y+jCVuMGNfUafWdJDRYW4Wy/a
	 0yW9Klzglm+0XMjt7LSCFvALX8nPAjtF+3TYOdZkRDdVaPFQZJMtVJw/Ky/sRE5Ng0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i8aqVl4YAjgzdkkeLSN/eYbryYseJ3w6jAMXOJt5BwU=;
	b=HdG4reyM4jygnVSu8xEo0/TY0WZNw2L9k5EzWewR4z4eWuUKOEhNhGPvo++NShq4Ci8g
	 0EiW4U+eLGRAFd8xunQsYVaPgNjW9DPXdcckLMOSvKpGZ5lm3v3/5pz9o5FApoFqUXM1/
	 u6UdRVTXd2UgA7LoHs7Pr/LBw8Po2nW0JyzqKLvtHgPG3isCmuhbyRx7kCG6SZFg5a/Ac
	 JbGQUQl25o2/8Wxyrx1kaV4pF8N4da7LyTZZcqHyIz/qZP0RbvMzDJtH5yHkLMC1bZzah
	 hvLr2cXSXNkbIZH3EK/jjLcAwOfPkY+VdoOyas8HS5BOM4AMVQ/1xmDjEX0lfT+aM0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/Sx06/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/Sx06/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB60F1F0089F;
	Tue, 10 Nov 2026 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313358;
	bh=i8aqVl4YAjgzdkkeLSN/eYbryYseJ3w6jAMXOJt5BwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/Sx06/G6PyCw0Mzfuvq0neExrJ8C2W1dE05ckOE1CXqWcli2AKQZmeQAHXO4xzJc
	 3KKfMjuf3hTfhvzbxV8+jwTiCCAhCjs/F5rAP7YuZuCX31FHUHHXxLC2vGT0K9AUwh
	 3KCVu2pYu/Oq5/7/jszX4UnID/IHCXG3sAzTlywmDOyOUexs1t5J0fs/MaXkZ097uK
	 IJvM8e0mi9+oUDbgizq0nOBE4HR05VpnX2jZ6sg6v2LgjnDn6lPP/CinAsXCl0QSA3
	 2AagttfKT1QGxYDY2GWPahaQ4YQo6iBgxj52UZ0DQzCUmqpKr1sTqzQRF2W+RcUXhQ
	 Dwk97GAKxwJeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Corentin Labbe <clabbe@baylibre.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] crypto: omap - increase priority of DES/3DES
Date: Tue, 10 Nov 2026 07:22:31 -0500
Message-ID: <20261110122229.1112116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
References: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
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

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit eca568a39481728224edd5c2053ead5479dd8e07 ]

Give the same priority of OMAP DES/3DES than OMAP AES for being sure it
is picked before software implementation.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 5d69ed4cd4f9 ("crypto: omap-des - fix crypto engine cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-des.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index be77656864e3f..538aff80869f6 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -735,7 +735,7 @@ static struct skcipher_alg algs_ecb_cbc[] = {
 {
 	.base.cra_name		= "ecb(des)",
 	.base.cra_driver_name	= "ecb-des-omap",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 300,
 	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_ASYNC,
 	.base.cra_blocksize	= DES_BLOCK_SIZE,
@@ -752,7 +752,7 @@ static struct skcipher_alg algs_ecb_cbc[] = {
 {
 	.base.cra_name		= "cbc(des)",
 	.base.cra_driver_name	= "cbc-des-omap",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 300,
 	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_ASYNC,
 	.base.cra_blocksize	= DES_BLOCK_SIZE,
@@ -770,7 +770,7 @@ static struct skcipher_alg algs_ecb_cbc[] = {
 {
 	.base.cra_name		= "ecb(des3_ede)",
 	.base.cra_driver_name	= "ecb-des3-omap",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 300,
 	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_ASYNC,
 	.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
@@ -787,7 +787,7 @@ static struct skcipher_alg algs_ecb_cbc[] = {
 {
 	.base.cra_name		= "cbc(des3_ede)",
 	.base.cra_driver_name	= "cbc-des3-omap",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 300,
 	.base.cra_flags		= CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_ASYNC,
 	.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
-- 
2.53.0

