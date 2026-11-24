Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536726;
	b=3FT3vacBNayhCIWup8X2Jl1GlrZgtpWtf9Ny98sw0jcOIUrWm0VN75+fmN+De4oqSAyk
	 cudmQGwQO2+ucN67heT2DgLcvvbBlLMYdo/GMa8ZMHxhaQAvPKFI+4sSz4VAJ+oeGl/+M
	 VKj7GRfomehRPr9ndDtbwkTRDrDDZiZL5CbHgTfqWy/CdQw5Z2fzokjbfp8BkMFiGb/96
	 E5NPDxhXEgCFiXM0Rg1uBzKHCwe06cOauOAFrfN8IcwskzFMnbMzLyFJPNYnrBsfNDU9y
	 LGw7B56M9jlCHxbDI26MZg9TSArtIowoDpOimEgIq5OSGnfiBjDpDZ/Kzr34rMiq2Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=52m+UU6UqtGXp28m1Dg0w6G9mTnBbNsyuxDLSvQstA0=;
	b=uX1lb4BOw58Vjf3HQQYC2wFn6Iz/+Gg5X1PEesTIuBQYZQpWb5g1hLHqb69hECzZ0/JI
	 zap68Hg1YNAwd4cCovK4Lb2UzL3Sjo8EmR1VDaxyChGKPmpBHJevgYR39gzqEYq5agoTF
	 q44xnQwewD5smCnaih2+9hF6lB8fydk3hp2GRRrgzoLiv9SK0uoYRXBmgl/eTzpt4DXe8
	 c5CkK5iVw3KISF/eJ1aVampEjMsVoDEP7ymVl4e/O/ySJm9hWRXL/nFvBGsnhwT6JN+4R
	 MbHfJP7pdeD61dg55ajzkFd10QslSL48Nv3/5GfwhvhYcjA22SjNcRviyY97Od44g1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf1pJ0sp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00216606A331
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf1pJ0sp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0791F000C4;
	Tue, 24 Nov 2026 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536725;
	bh=52m+UU6UqtGXp28m1Dg0w6G9mTnBbNsyuxDLSvQstA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vf1pJ0spfG0u8aOuxM2/bRnpI0gzyyvcVKNQehZXQfwlW5eIlSB925X2fjjVUNXwV
	 XyQvnOa0vc2Wj2vp1WqKvj7YUCzbjKVwwYfq0gWacnx6IBWJ7hP8bvd5Is8VdUcc9p
	 65V9ZY3/o7B8E7sWDkZ36hr5Gs8Xod8vxaH001TKm8SgcanbIh+6/isa2nysmgXcvN
	 1hlDr915eha7ZrhSH+bpKyQq8Nasoed+eU71ucpW75Q2G12Bu05Y9UT6PPkdp13MaR
	 kPDhaFuOB7+l2gNhNnkKmzBRw9ivjs/Yh3U9apa6t3IDCeHrpn4W3Ufv+UM5XfYlBt
	 Y6BZW4E4zRQZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mmc: jz4740: Remove the host before resetting the controller
Date: Tue, 24 Nov 2026 11:12:03 -0500
Message-ID: <20261124161147.906737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112435-active-relight-4a16@gregkh>
References: <2026112435-active-relight-4a16@gregkh>
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
[ sashal: adapted to the older int-returning jz4740_mmc_remove() signature and del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 62d00232f85ea..753cf074e7c7e 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1120,12 +1120,13 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
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

