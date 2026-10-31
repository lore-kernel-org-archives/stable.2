Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448441;
	b=KUQFCShDf5dguC2KCLoWEtZJljOJvjao3G7SUPhZAw2meE4Pmd2l9zT27569YxSeORQY
	 4XVf3e9zJ2GCxHBWTLHd0zVwVqCDchDLJ+jxmiYXQn1P5qJ5woPP6Mqvkm/3yDXG7MB6L
	 uo/Hdh3tTUf8QcdrEqnUq5f58glpJLzkZqnEK4FZHBoAPCrIVhaAw+EoU8P2T3Ppx0g0Y
	 hfANbeBSH39zxPk+XAEjdzQrQQ6XYA/YLEaBNP4eu8EbzXVeM07KK2QkrVhzbf2oY1dLl
	 IlcMBfWgMdrFTCdfMpF/Xerw2/KJQyx933bLqYqO9b6Ggt/YGNUGtQNVT/EKyLBFHkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448441;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jyk3rgi6eH2uBTITUiOecFzmCK/Ol922slxYpE+PPRs=;
	b=J+HJNlh5JG9cpVR859OnXUWH789zDRiE2Q2xKasH0GFBk8MirhSmtXjLWnZMmsXTg0nI
	 BcK6fM01HaaiOQ4qTLtXiAk0dhEAyZ1IIl3TkKb9kSL3FedUc7N1YlkE7uzyP9B9wPlyc
	 2Wo1d1SxLj2Emy+3Cjg4HCIRnvNMxuekBrkVySUEstouCiGWwfROtAbNtdjNbuhVeDBen
	 KQlcHrN6AcuyMedHsY7RlchypTgpUj4Aw/ScqNm9hkSuj8m0l+ZQSL4z9HLWqaopdlfj1
	 yQTKPURabfXKMSfgtyN+A7YvIchDE7UKHgBsZh9tMfTpa0pDTlBKg7p6fRdGgDk5KLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=dMplOwLY;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D437606A329
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D437606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=dMplOwLY
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6BD46240028
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793448433;
	bh=jyk3rgi6eH2uBTITUiOecFzmCK/Ol922slxYpE+PPRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=dMplOwLY0aDJxLldmkgQcF+xhl9AGuLGcEQamfFFe4Y5i5Il9SE0PX128i4v/oUt3
	 89JYyQjemRG79JHTl7kpwn965bn5mVrr+FTLhwbkJzJPnJf9SaK6mX7whWon5q6CpV
	 P/3FbNxLvfjLLB3tZkKVJWdVFc/LlxKL5DmXzvmYooSd1N+afa7nqQvGDWhiIPhBZB
	 tbUOFvxFdlbM1yYCvgGMx0Lu38/CuCkeSw+bIMF02SlbboZ7gkPl0QRK3k8xadBAa0
	 6mbkLG7XpqHnlwoC2uU0zKnieWK6wHvls/5ZDPPuoCygkbT51oGSW5JddYMv9gQb7+
	 9BhKrVEa+/Djg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jGxXv3CL4z6v1f;
	Sat, 31 Oct 2026 13:07:11 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Christophe Kerello <christophe.kerello@foss.st.com>,
	Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] mmc: mmci: stm32: do not use NEGEDGE in HS200 mode
Date: Sat, 31 Oct 2026 12:07:12 +0000
Message-ID: <20261031120700.42576-3-mateusz.nowicki@posteo.net>
In-Reply-To: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
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

RM0457 marks NEGEDGE as not applicable in HS200. With a clock divider it
corrupts multi-block writes: on the STM32MP257F-DK (st,neg-edge, 200 MHz
kernel clock, HS200 at 100 MHz) written data read back different. The
same writes are correct without NEGEDGE.

Fixes: 36240ef8665b ("mmc: mmci: add hs200 support for stm32 sdmmc")
Cc: stable@vger.kernel.org
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
RM0457 describes HS200 only without a divider. If HS200 through a
divider should not be used at all, the alternatives for the DK are:

- Drop mmc-hs200-1_8v from the DK device tree. DDR52 is tested and only
  about 5% slower than HS200 at 100 MHz (read/write 78/66 MiB/s against
  82/68 MiB/s).
- Drop st,neg-edge from the DK device tree. This also changes DDR52,
  which was not tested without NEGEDGE.
- Set the SDMMC2 kernel clock to 150 MHz in the firmware (OP-TEE). HS200
  then runs without a divider (tested, 119/86 MiB/s).

Which way is preferred?

 drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 9dc51859c2e5..d74efdff6ac2 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -342,6 +342,10 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
 	clk |= host->clk_reg_add;
 	clk |= ddr;
 
+	/* NEGEDGE is not applicable in HS200 (RM0457), with a divider it corrupts writes */
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200)
+		clk &= ~MCI_STM32_CLK_NEGEDGE;
+
 	if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50)
 		clk |= MCI_STM32_CLK_BUSSPEED;
 
-- 
2.56.0

