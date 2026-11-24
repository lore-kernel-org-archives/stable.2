Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536228;
	b=JXmDtxPLuzQrX2Qof0em1J2iCNgR7tsjlRVqvvAxQyGk5ZO2YcLmeGmtfZpnnCSCbWLc
	 qSPVY770gvvWeOCA2rTNgpSCYumTSjr6FK54f4mUOHOZ1I6uLBFAJ4YGSttItHXM/E/EZ
	 pudKqAp6O4xQN6MA8e88Sn6jQIMQ+pI8ZbvBSRnrZqyeUSlOMZyC8D+k0h8SQgm7sYqQQ
	 L2E4YAzEj0q0nZCit7Mx9WxOCFSOuT5m6Dl2C0jfL2CJSdDPHlnN8ZSfncCPfDjlA6Sh2
	 BR7w0zHUbv+T1amaizwTWnG7y26NCPDIEpomxrCzyDiWRA2LboExuVAL1dZ39NNs1GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536228;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mqHJettg1zHJNE3bcrvPyfYFiLc42av6njTvd8AGBT0=;
	b=3lSlDI7+ER112zlxwOVnEBjwqpY9dOKtTJ4wiDydQbtd43D9ZAcsyzHMl2EFSbiMGDUC
	 C01U/S4VxbjSgIZSqDaExP0mucNlgKIJLcU3X04j+0ir/96GmnvatR53cbfq/OccCoJVl
	 wmnDvy0tGOh6KpLGPZ2K96sIteMsDrmIUSi7fL0+/O/qTPMpnVyP+D5udkUZbM68WXLxX
	 ZewkNGHW9xB8loQ/QZ/qu3FLV+wHZgjm55Zg8qV4muP08qvvu2Xb7r42AKOcqsyg3tBOk
	 fWPNqCShl621d7+Qp4Je8/v6lwzt/W+4ADwqjzed2vv7IEa9YY15k3EBHq+A7iW8Jqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEcdjuS0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA6606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEcdjuS0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744761F000E0;
	Tue, 24 Nov 2026 16:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536228;
	bh=mqHJettg1zHJNE3bcrvPyfYFiLc42av6njTvd8AGBT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DEcdjuS0ucv9AYX6c0uLNhdndJ9a+LVtgyTLvuHrqAvglz5qyO2IUl7JYomvJzwap
	 8R6h21LnJvMU0Z0AjGM5+4ByPLzpOZkLkhF8L9NYKF/3pZ5hNR4VDslSFy8hS995iv
	 bdG5sUSvNFMFWdtFzIJa/1+hxXDyvHDm0nuuQvj7mqI8EiWj7ENyYylXtWW+iTkjhn
	 EN7mwnvVPjC4xPDmoLqhvExulYgxkaPU/ZinYsLN8v7KUaVJK+BuRxSV5CTiOjiKUp
	 kXzVaALMWEuke1RvSRI+bBcj4t4Rk8dG4D7JerzewrvEg+bMoRhmGhMz+4exqUkrJz
	 HwWj8H6UkHIaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mmc: jz4740: Remove the host before resetting the controller
Date: Tue, 24 Nov 2026 11:03:46 -0500
Message-ID: <20261124160310.858381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112435-undone-daily-7520@gregkh>
References: <2026112435-undone-daily-7520@gregkh>
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
[ sashal: adapted to the older API by changing the return type to int and using del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 2254db44fb02c..de42df6765ee0 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1117,12 +1117,13 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
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

