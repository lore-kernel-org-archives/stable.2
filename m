Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535573;
	b=p9059IxP7n1zzbysGxFFewyIHxLF6DViJroKDhu3Ml8LBdPUZAS6DY2JFhStsmaIsl9M
	 AAZR+KEqzxF/vaFzzPDxArwG6otlckFLGHxhwZBvSCEFBj3CxHafFltDGfQ0A4btq2DZn
	 8vKtEb/cIsPsQkCle8pTeRs76emcLgaIC1ImnUJLf3rsLF7N2JSqzhdXyFtSRY7Oqu4Md
	 maCsy5s5vDmaDc6ogJ3QjulbSPGjAirEkWxSqopQ2PicZHhu6DvurNuDTgneYGoI+qmy+
	 RqFuopJwKzkbfJZ2ARf+OBw2hZLRPqlwPCr1ljVukF/hBFXTfQVy+I32D9eYzPey1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4eOA9nhCLrthb8A5D6i2egVSSqgkc7RggQAHbEdwixc=;
	b=yZTo0XmFsogrTeume5KntucfGswan8QIAzIIO+MOEYnD5xhwwYEwSfIVxj7Lg3qfDKw0
	 wZe+bypLDIFiQ6AjGY+XwtyjTkYPP3AzDlaGju3W7N49sAgP1UffCv7O3yt+eL+y+Amz6
	 JFTAQ7tg5QPrIwjVvl1NMlN5MImn10r41ZHey6YD9Vu7+YXSmfq3CmLW2ZBNtEoAsnodU
	 cM2CZ2TEc8WUx5XM6PckiaIxE29q03QPCqn4wzAf/xal/d36BU14KUGtWJfLrz/bB+Rzu
	 XNXfB+OGjGnRONkWyOU47PfvMuqB9B13ICxwnNg7fw869/WZeHUo7EghgLjyoVsrRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNQHuUBe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B005606A33D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNQHuUBe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504861F000EC;
	Tue, 24 Nov 2026 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535572;
	bh=4eOA9nhCLrthb8A5D6i2egVSSqgkc7RggQAHbEdwixc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNQHuUBeKKv8LYETU0CWF1w3LAaU3+OAyQmjcs3uamLXabtxXY2sKT8AXc7jblqqs
	 5+jp+YzyGRaVkVyK/cXFEJ8GEJ9GxQSRSyS9cYypO39JH3PgIKima7z3l9o/uwSTjU
	 ja1p5BQPxPKhLvzuP8WAW6U7fv6ZWad5fWkR8f530idSl4RN+cqod89mv1whlhADdH
	 wG48S5Zub8cg8Ux1eee2PEv8gz+WhBPoPztJsw3xxmc9OP5O9QsQvknpVqDK54jRuq
	 X9nlROh2exP1blQ3wCz/Qz9GYUkgYa3mVOjoPMQR1rixXRZ3LC/F0XpFCXdu59DphH
	 soPjVGlUHokiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mmc: jz4740: Remove the host before resetting the controller
Date: Tue, 24 Nov 2026 10:52:51 -0500
Message-ID: <20261124155237.812616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112435-glamour-animating-1da7@gregkh>
References: <2026112435-glamour-animating-1da7@gregkh>
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

From: Olivier Louvignes <olivier@mgcrea.io>

[ Upstream commit 6b8b1e8827837bf4cf1f87219038fddae9e81b0b ]

jz4740_mmc_remove() masks every interrupt and resets the controller
before mmc_remove_host(), which removes the card and lets the card's
driver send its last commands. Those commands then run on a controller
that was just reset, and can wait out the driver's 5 s request timeout.

With an SDIO card that cost 5 s on every unbind: on a HiBy R1 (Ingenic
X1600, a BCM43430A1 driven by brcmfmac), the CMD52 that
sdio_release_irq() sends from brcmfmac's remove waited 5.1 s. The
command had finished (END_CMD_RES set in MSC_STAT), but MSC_IMASK read
0xffffffff although the request had unmasked END_CMD_RES. MSC_STAT can
still show IS_RESETTING after jz4740_mmc_reset() returns, so the reset
most likely completed after that write and undid it.

Remove the host first, then quiesce the controller, as other host
drivers do. On the R1, unbinding the Wi-Fi's MSC now takes 0.65 s.

Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ sashal: Adapted to the older API: the function returns int rather than void, and timer_delete_sync() is del_timer_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index eda1e2ddcaca8..a1fc48f17a9a1 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1132,12 +1132,13 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host = platform_get_drvdata(pdev);
 
+	/* The card's driver may still send commands as it goes */
+	mmc_remove_host(host->mmc);
+
 	del_timer_sync(&host->timeout_timer);
 	jz4740_mmc_set_irq_enabled(host, 0xff, false);
 	jz4740_mmc_reset(host);
 
-	mmc_remove_host(host->mmc);
-
 	free_irq(host->irq, host);
 
 	if (host->use_dma)
-- 
2.53.0

