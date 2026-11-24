Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535057;
	b=oTLks7uPId6MR/deKM9mZvhmudYc3yCD96GdHx6kgpkq+wxFiuO2SxBm/jNfI6RWXWvg
	 k845cREVKygFs19ejnIGT2xUH+VqoXdB1Z68DfjVX0cgTi5xWTl6r6mzLsG0Mqlnp6mFp
	 aLqHYoeFhB+cWwGLf3heCmE+XIPNohrm3ae5eXvgaih1i6f7zsnvxySZ+Wpij5lYGtwtX
	 WBp6IOvM2GoF8EcIlBdmJJi2YD7UbyU++TPMgxam/n91XhzVstIVhw+NvjLSK+/toSUwo
	 /lCJQzzjSTl7+7NMQ6HexbLTap0YtR/Sc0uIYEH0+Ig0xiJRNYeIb9BWoKvb7sCcnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3jNs1MILqfa4/4VhvpYhodfxfTwdslwp5GRZqCmyGQg=;
	b=DHU56z5l3qr8wEEmuPmCFIOJpQpxyX8m25PxsJa2cyLfi7KaUhnGcnbRuadL4QeFtl3h
	 93ugNlMSlcbTa8pyUBev2Qsp96GPMfnIxLX+xlnu1gxJMR4p6t/0JY5QgcJlm2gIEPf/t
	 47qDhlUJX6i/72sx/UyD2kzzI5C3OPyugdAb64jWGp+E4rehxKA3rgIToCe0SaVWifT5d
	 p0h4tgp7O4ovchcRY8/C1uzWwp9AwvSS6m7/9oImYsITzPVc+qiIFtXcPO8PE6NGT1jaJ
	 f0zKFspy+I08vcIUoGT8Pu53VJmfBOJRa3Hxgqv0ksOugm2DJ6ZwcUGhgrkt6Jhj6Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZWdSILv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385E606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZWdSILv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FDD1F000E6;
	Tue, 24 Nov 2026 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535056;
	bh=3jNs1MILqfa4/4VhvpYhodfxfTwdslwp5GRZqCmyGQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZWdSILvP24RvavI+HnODCZ8prC66RHWFzcRDt9Jhg/K3yD7iH4Ss1xlfOzyrCijX
	 1kU2CUe2XBZPuE5ki4MW1Ssr5bb6rc/yY5KKoH8qjyYedk1MCKfiaqdv2LPDtDsPm7
	 EVcXhxZgdPIDJNMwVKm0qopcicYtKfdqIrdsj7SRKP9oEtbhIGwRJ8eH2KZFAAz/Ag
	 FVlokmZobqtVQKOQJQuiZdAsEZzSpZIwJvQz0UhoaiuWKWmUKQI5wl31K8QWLkFFSM
	 ZlTpvArVu+UQjzC5IOZAejqk2XCdFRB+5uB+jMKsTOwUwbausPp9aRCdEu648qWaRd
	 5rmZux0H93acg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mmc: jz4740: Remove the host before resetting the controller
Date: Tue, 24 Nov 2026 10:44:14 -0500
Message-ID: <20261124154403.783980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112434-enchilada-curled-d598@gregkh>
References: <2026112434-enchilada-curled-d598@gregkh>
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
[ sashal: changed timer_delete_sync() to del_timer_sync() for the older timer API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index f379ce5b582d4..46e5b3b16ccc3 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1167,12 +1167,13 @@ static void jz4740_mmc_remove(struct platform_device *pdev)
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

