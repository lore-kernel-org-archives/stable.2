Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448442;
	b=eLWrLO7+i8ERtZhCzCB+Ge+byc9vH7pAaztdxcnIhbvknOcalCLAh7c1G7bia44B1iw3
	 gj7wpeX3XKIIpyCVuMCZrpo0DYlZIFDXoB2KaxWXRovQvstWA85QaDu5XJSfhNRn3zAcv
	 dW3+X4UGEe/mdUEOq1nkB2Ks7eo18x1gvhTzmmYNE92bsvlfHNGwVHHTyg48cZ2DiDMW6
	 zIlvWhv+EtucvDA8UqSf6wyBVU/r0QU6L/1LglkvNaWnXgUBEbPXv+HztsQPDMRmlmCx0
	 39nHlqGhsaV+pnWDpg98BPU+a4ApRVwnfKkHelsI4WGhg3wqDa22gMcBTf83L4SIoiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448442;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ra9w+zWZgwoCxB8YuqKLO7gy/hnQxYG7gsDPgEiLLpU=;
	b=uPpgAt/SYhXlIX/Yxk3DkxeU2hg/A8YX/6sU6OkFzPd2rJJRJGbO7/i0GeFZSgn8VGPF
	 T/AiCclxCoAbsgNQtCkULA22oGh0Ns2ZTiHCSuOav+KKyUm60NyH/vKerysFsvY/LI41M
	 Y5Auute14U6pvrznDXBjZWt5dnI4gJLX0kMoumsn2rXpZcwCUWYNSf7NfGtTYbKrsChbX
	 PFNHa3FEPPaRYyLL06Fb9IzuDlONYP9SUAkbxJKqRPDyx5X3GLSObajG8WrV9L2XB+Fbm
	 Rdhp+fHhORN+uV+hjgpAuD/XpQ+dr3QD3lEXJLeEgAb1Hce2ESS1ugK0ee6MQN5AEGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=OjAlI7I3;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC1606A331
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FC1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=OjAlI7I3
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E0598240136
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793448434;
	bh=Ra9w+zWZgwoCxB8YuqKLO7gy/hnQxYG7gsDPgEiLLpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=OjAlI7I37GMxg1ZeHT8HQkXDsSmLMMkV7waYDyjYo0Y1HZ9vQYV7H69rlnUF+vtoy
	 87i4JOAjwn0lLHfeyNLLhYYb+oeJvv4XSBQ9RuyVZ5SDqdCrFWfKlSzVC7VhtX1ZMY
	 cz6495e9GBehHoyQQbp7Tcgr0DFXAzWQThSqlNWdXn6Q0oeNvR9uT+4mU3btkyMuHo
	 Q3KdN+9Q7JcBK7jWz3xgB8zNckqh38qIzxTLEh+gWZbPmhtCbjqsknKz2HtVunDUOV
	 r3tLlTt9IBfbKBJH23CDyOmElTtDAcYj373hQrUm3ceEWN6md/AXsCbTdYDxrY2JF+
	 1tskkiQIIUrHQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jGxXx0lm9z6v26;
	Sat, 31 Oct 2026 13:07:13 +0100 (CET)
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
Subject: [PATCH 3/3] mmc: mmci: stm32: lock the STM32MP25 delay block again before tuning
Date: Sat, 31 Oct 2026 12:07:14 +0000
Message-ID: <20261031120700.42576-4-mateusz.nowicki@posteo.net>
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

Once locked, the DLL of the delay block follows voltage and temperature
but not a change of the clock frequency. RM0457 requires the DLL to be
disabled and locked again after a frequency switch.

sdmmc_dlyb_mp25_enable() only sets EN, so a DLL left enabled by an
earlier tuning keeps its old lock. On the STM32MP257F-DK eMMC, switching
from DDR52 to HS200 then made the tuning pick a wrong phase in 9 of 18
tries. With this change the phase was correct in all 12 tries.

Clear EN and wait for LOCK to drop before enabling the DLL again.

Fixes: b5c3eb385797 ("mmc: mmci: stm32: add delay block support for STM32MP25")
Cc: stable@vger.kernel.org
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index d74efdff6ac2..2310dba75c35 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -541,11 +541,21 @@ static int sdmmc_dlyb_mp15_prepare(struct mmci_host *host)
 static int sdmmc_dlyb_mp25_enable(struct sdmmc_dlyb *dlyb)
 {
 	u32 cr, sr;
+	int ret;
 
+	/*
+	 * The DLL tracks voltage and temperature but not a frequency switch
+	 * (RM0457), start the lock sequence again on the current clock
+	 */
 	cr = readl_relaxed(dlyb->base + SYSCFG_DLYBSD_CR);
-	cr |= DLYBSD_CR_EN;
+	writel_relaxed(cr & ~DLYBSD_CR_EN, dlyb->base + SYSCFG_DLYBSD_CR);
+	ret = readl_relaxed_poll_timeout(dlyb->base + SYSCFG_DLYBSD_SR,
+					 sr, !(sr & DLYBSD_SR_LOCK), 1,
+					 DLYBSD_TIMEOUT_1S_IN_US);
+	if (ret)
+		return ret;
 
-	writel_relaxed(cr, dlyb->base + SYSCFG_DLYBSD_CR);
+	writel_relaxed(cr | DLYBSD_CR_EN, dlyb->base + SYSCFG_DLYBSD_CR);
 
 	return readl_relaxed_poll_timeout(dlyb->base + SYSCFG_DLYBSD_SR,
 					   sr, sr & DLYBSD_SR_LOCK, 1,
-- 
2.56.0

