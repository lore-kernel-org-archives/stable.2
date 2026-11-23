Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461525;
	b=DZkainQtCKGi89vl8rmhHZtvuyfw1+Pb3pWblMg61n6YEA7Q/QXC/lXQqxkT82Pi8ZFN
	 jZeUCm3RNu2W/IZtI4VeZOGUeHFQDQrCWNZdSmlEzhvm7Z1mV9b7YWvRRXwTSZrXLAfeq
	 O96KXcSlItBg7FXECeagsqqC2OemrtSQhg0Eklecu02deU1/BRnmCTAVxOhvQGALtux9Y
	 6bKM0AFIqguw94g4sSyuPNM+g68ZWOMdJL6NGlhxVtgKz9YbfGlUUDpOu9tzak6fIMZGP
	 wekNW6GTK2HTZSASsVgvRV2hbDWY95aVvEQKSDEWD4x/exHLQL+C8Co+q4oUzCemYvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JnOYAZMVOKO0Zb5wr2NJKaiBoXlxX18Wrt6Tra1io+M=;
	b=cWSiJ3gGQ7+Ac3wmZ8OKnS4YaDl4lv+KAMtNjnrfWTW34c3avSXE6DbTBrhEAahNiuKY
	 wkvf7I/Io5fiFTsvD0aMz7kIewS4OCciGiZlov8xgTXn+2XT3KMEzvH5872g1ZDby9Ib0
	 KYRZrKMzbQ5hT2cqP+WtWMa1yzToUV7VHM7crBOTS3BD8Axrbi0GWYKu6VtsD/kugyoPy
	 M2Gk5ZPtbrxkdRvTvXXN8yXmboR0mCasVG0zOA4f0F0xQzEUiHVQSt/plT56oeF+6D7P3
	 H+UdCYbtoAdkxz00JEEcz9GvGVfsab4Hb5b0uzr8PVAydEfoT248Y9JizSn57854slg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVXId1HY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8E606A326;
	Mon, 23 Nov 2026 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVXId1HY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C281F000CF;
	Mon, 23 Nov 2026 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461524;
	bh=JnOYAZMVOKO0Zb5wr2NJKaiBoXlxX18Wrt6Tra1io+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aVXId1HY4yvRkxunhsZ5Ii0G3g4gOgtOkKcQhELWATLmLG8u39Mmpd/8pckilWHht
	 WwVBFzGApqpo2nnUgdezLywGH3u4PFqT55rRxOgiewg9MxIReGpw2/SfUoHuhMzSsz
	 0JzO3+2kzcGilYPJjN2VADJcn2Zl2qBzkLZiSTEuNupIiBzr2p0ryclQidrAvvUFOT
	 vKfK4HbBBjVKeaUfpBw/JQx+pw4XFuCdtg3bX4jzev9X1OPVLptxFCt6htLkKCX+i2
	 udmvcjvcEfF31GGXebNe/vpkLkW69u3vvYi2Qy6CT/FeJFa9d12AwBdZBS9NZTTuXF
	 NR3jgXMzo1P8g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Phil Blundell <pb@handhelds.org>,
	Samuel Ortiz <sameo@openedhand.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 12/13] mmc: renesas_sdhi: Fix SDIO manual tap correction in SDR104 mode
Date: Mon, 23 Nov 2026 19:15:56 +0000
Message-ID: <20261123191703.179283-13-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 30fa7d53afd4 ("mmc: host: renesas_sdhi: Fix incorrect auto
retuning for an SDIO card") switched SDIO cards from automatic to manual
SCC tap correction so that DAT1 SDIO interrupts would not spuriously
shift the sampling tap, but exposed two logic errors in the manual
correction path:

1. renesas_sdhi_manual_correction() checks !priv->card_is_sdio instead
   of priv->card_is_sdio before ignoring DAT1 mismatches, so the SDIO
   DAT1 check never executes for SDIO cards.

2. renesas_sdhi_check_scc_error() already returns early when running in
   4-tap HS400 mode, yet still passes the hs400_4taps quirk flag as
   use_4tap to renesas_sdhi_manual_correction(), halving the 8-tap
   SDR104 and HS200 tap index when writing SH_MOBILE_SDHI_SCC_TAPSET on
   SoCs with hs400_4taps.

Check priv->card_is_sdio without negation and drop the unused 4-tap
division from renesas_sdhi_manual_correction().

Fixes: 30fa7d53afd4 ("mmc: host: renesas_sdhi: Fix incorrect auto retuning for an SDIO card")
Closes: https://sashiko.dev/#/bug/linux-735317da-fe00-4630-b954-5dcc1052aaa8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index cb35360239bf..497c7c75f966 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -741,7 +741,7 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return ret;
 }
 
-static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, bool use_4tap)
+static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int new_tap = priv->tap_set, error_tap = priv->tap_set;
@@ -783,7 +783,7 @@ static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, bool use_
 		if (bad_taps & BIT(new_tap % priv->tap_num))
 			return test_bit(error_tap % priv->tap_num, priv->smpcmp);
 	} else {
-		if (!priv->card_is_sdio &&
+		if (priv->card_is_sdio &&
 		    !(val & SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR)) {
 			u32 smpcmp = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP);
 
@@ -802,8 +802,7 @@ static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, bool use_
 	}
 
 	priv->tap_set = (new_tap % priv->tap_num);
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET,
-		       priv->tap_set / (use_4tap ? 2 : 1));
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, priv->tap_set);
 
 	return false;
 }
@@ -854,7 +853,7 @@ static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host,
 	    SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN)
 		ret |= renesas_sdhi_auto_correction(host);
 	else
-		ret |= renesas_sdhi_manual_correction(host, use_4tap);
+		ret |= renesas_sdhi_manual_correction(host);
 
 	return ret;
 }
-- 
2.56.1.750.gf70dc682cf-goog

