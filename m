Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72641A56B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090565; cv=none; b=jCs86HVzcnQH45kYeuEnhMPmhvrFvK0Mj/SN59cM7ck4cIY5qe/peECzse2K/Avr9zLsxtcFjdcvd2SWaZv6n0kXKPqvm8duBQKKde7cBYJFg8Fq7uLch7A4rMd5NMQ0YRHo1Dg6EK9JRWkgULDLCwETMjTt+lpltTc+3fTVkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090565; c=relaxed/simple;
	bh=5kcfvNEIhvF6eWDEgn5urXt9xckCrwBQgNPHuQGYEhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8UbI+XdkmKYYxk/o9B7v7NcVeRpCzTAwEExGmpsCtvu8/rZnOtcwPwl4mgTIZAHkr35UNm8G55yxoxWuKFcCHHGBuFZbfNo8UZuwVjmlTRIOpImsplDgnCf3YWjmRNphfGvieVFx2SIBy7uA92XGlBWaqnczN13YdzP8pLquVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLadvi6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLadvi6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A201F00893;
	Tue, 22 Sep 2026 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090564;
	bh=rTlQkOxc2+E4eluYsEKoGti6ievj/AgtrOrvuX6hbc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VLadvi6T8dVQz1Xv4RxtRM47vUKDK+CCPtXGdOUNStdJAAW/QeZmWmxBp3fATeaaR
	 Lq10U2yrofbOyDXkbW2IilMDwsixztjP+UqfL/1FhNQyklXA8xtUE0Gx9EaL/g5N8n
	 q0GO3X8yXco3peR5sRxMYE00U8PNWh+0LqxCkZrJwbaDhXV+N/Aeco4bhNXWtAQki+
	 iX4Yzbvsh5uvRLhRTRXOr6ETxs8Y7z16J1dE5su8cPIPE8GBSFgHH+KSj4jp7JtD+K
	 9GfRxfDEbIMVLSFXEpAsyunWxReutJ/Tv9+sYD6MikWGmlTLNN233Ip8IpAyE+QRev
	 4WYy7nBQ50INw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] spi: Switch back to struct platform_driver::remove()
Date: Tue, 22 Sep 2026 11:22:41 -0400
Message-ID: <20260922152242.2799625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092222-marital-chasing-0267@gregkh>
References: <2026092222-marital-chasing-0267@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 494c3dc467768782f93f1433650c56b08feb54ea ]

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/spi to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

The change for the spi-npcm-fiu stands out in the diffstat because the
inconsistent formatting style of the platform_driver initializer is
fixed to match the other struct initializer in the file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20240925113501.25208-2-u.kleine-koenig@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>

Backport note: Retain only the spi-zynqmp-gqspi conversion required by
commit e922bad8b2d5028c51a096d083fea41cd0987154. The 6.12 platform_driver
already aliases the void remove and remove_new callbacks, so this only
updates the initializer name to match the target patch's context.

Drop conversions of unrelated SPI drivers. In particular, stable commit
f68b27d82a749 ("spi: fsl-qspi: use devm function instead of driver remove")
already removed fsl_qspi_remove() and its callback; preserve that managed
cleanup instead of restoring a reference to the deleted function.

[ sashal: Reduced backport -- upstream 494c3dc467768 touches 88 file(s), this
  backport carries 1. Not backported here:
  drivers/spi/atmel-quadspi.c
  drivers/spi/spi-ar934x.c
  drivers/spi/spi-aspeed-smc.c
  drivers/spi/spi-at91-usart.c
  drivers/spi/spi-ath79.c
  drivers/spi/spi-atmel.c
  drivers/spi/spi-au1550.c
  drivers/spi/spi-bcm2835aux.c
  ... and 79 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e922bad8b2d5 ("spi: spi-zynqmp-gqspi: stop the controller on shutdown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 143c572b263e2..54cea0986af09 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1389,7 +1389,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
-	.remove_new = zynqmp_qspi_remove,
+	.remove = zynqmp_qspi_remove,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.53.0

