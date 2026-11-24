Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534809;
	b=bNu1s5/vvrj5up8fFbojm9QWm/XzBPmBJZeFdFeVXRzG5LKON82zzczLNqh0waQ4J1h2
	 i3BSMEJfbwEiBTvxCVB18gf09YzXZHGaiLIJmjsFqDsDibNSjRcKFDmYaY8SgXl5ISYYO
	 3joR3gzFEyAQaFq4cV39X1cQzK+niOfX7DL8DuVlSoPE+VsV6PbRaKoOSn4gRhsW2j1JX
	 FZ4ywAEOlBidgvoN5DAryPQVUtw5jgvZK5/Rp3mO3mecu6BONWjh3SlQmY6nFu9PDVKoN
	 H5GZTf1KCwim9dowCZtUGkd10xUGMmnBxr/UNc1wME1z9uae18yXUO3AWWYCt60nuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UWScrjEwc2o38DDWxmXHo3iyp0XVXeGNgIQsHmrTpE4=;
	b=hT/8FVE7tBKwIiYVTXw3qYybAUp6lLouZ1gxLS9IxCQJIgSovRGg2P600iKvxtYlrCHb
	 rGZnYGd74b8SfePhyxOMNhK0RppUzt8Zx34i6TizVjmTiwqLyvWfkQMtltS6UjFCuCBSY
	 453uEDVs5Susl9cT5fD6m8l6yd5VzRlOzAZkPaYNeFG3mREWcXJMsu4tLFstg24VTZGbe
	 jdMNau97IOjGJ93lO3wiOHAqAGMvoKT9bnEmFGF2yt8U6y3OGgTFP6XJhU9ycxaYEku5c
	 2gDoV4kyl8UMSRYnCh3CbbG24CDnU8uEk+i2UqjFHRi9KRNpfR2IvNPWZyHFowy+6Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akquFrZg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCA606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akquFrZg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B211F000C0;
	Tue, 24 Nov 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534808;
	bh=UWScrjEwc2o38DDWxmXHo3iyp0XVXeGNgIQsHmrTpE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akquFrZg0FeQrc1qvBQVXBHKWzGsonhnYhI1A8SweZfRjdWEWaIUu+lqjdzgcBOrZ
	 xbI6TVVaBcdFC0hWcLQBIwdMx7V9mFcQBUKvjwylVlKHxpiRg13o2M88IeWZWyhqmZ
	 TD2Vjiqfs3BtF77P+wHy8JaT4JmtetC4PB1FoHwwyNSUkHYDXAFhjq4Mt/AfDPq2hl
	 jtuU5+2b05WqCbN5oPJuCKct7y7PCGgWT1EeKhjbdTfL1VrQ4HX+oScrZyqsX0BMqq
	 Lx2Gov8zBSiIOHiPXrTA6fo15UyOQKicSdYJkXsmvk/xHIOVRe4bZYpVIwscnUq0w9
	 3ciQNmXPkzXFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mmc: jz4740: Remove the host before resetting the controller
Date: Tue, 24 Nov 2026 10:40:06 -0500
Message-ID: <20261124153956.486952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112434-underfed-overdrawn-f84c@gregkh>
References: <2026112434-underfed-overdrawn-f84c@gregkh>
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
[ sashal: Kept del_timer_sync() instead of upstream's timer_delete_sync() in the context line, since the older timer API is what this tree uses. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a45991ca056f..9e8be3894e496 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1162,12 +1162,13 @@ static void jz4740_mmc_remove(struct platform_device *pdev)
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

