Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461532;
	b=1T7QOZ+uItjDf8VZMl20pTHV5J9s05SMFBm9Pb0FHialRwNJunFFlrzaS5BMEH0waQ4x
	 uBszPNZI760AR8jdaTJ/rshUz6HVVAOF41RgHTXsboR31x9o94U9JhMWZAD61JLrhztLG
	 ENmqIiwF6Bf4W8UK35hDYAGxfTsFDgvluDn5Nn7GXXj0me55lmh7ttKwHDhP350S2mc76
	 8RGPTpmq/Pke/IbXevurFS+AneFrCmCI3GyYkK7oQptl8kBs0RbFy1mAoXzr5wx0BOcza
	 7MqcXeHQ/MU5+XrlEyuDBASs6WdZEGeuHQ0vmgURLFbMFqyp/A2tBREU3f9cA+4aG9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NTwmS0cXn/fDgENx4s6M91w/9O+98Yyk8OQMMb+a61M=;
	b=Vrook+WKwtqvblmiMuCZCfecnudKE+kj92v8GBG0k5Z7RJUiAftEmVINusgmtBaqwouz
	 p5UDKiQX9Z7m7DPD5vGKHx7qQ4IFyFt/15HngMi6sRvUSbORPK5Nfx6V3NDJahUSei/b0
	 WGoZXE2Iju2hZQuhAIsrJ/tS6S1e5OE0zHQwhJB5l86gZ4I1YeygfwoIC4gkupK12v9L4
	 dl4nL6IyG3RaGRVgMUgGaCE9ITGOrjO3Sr2OABbGj4+9pxhTGfUWve35cSYJeAbAv6iff
	 zlrwSy0yhuVkBFXwr2OQBc0MPKIpmHX5LO589ikSyS/Sl34H3dpEo1VnUM1qV+ZZ14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFh6HYTP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC0606A33C;
	Mon, 23 Nov 2026 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFh6HYTP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4F81F000CA;
	Mon, 23 Nov 2026 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461531;
	bh=NTwmS0cXn/fDgENx4s6M91w/9O+98Yyk8OQMMb+a61M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mFh6HYTPvakiRxmtTMUG5/44aSgrfmHA4DI6QmVyuVRGBZFwFPuHhecalqVMMkDJ0
	 88YHisK0Gsh5OsP2DI0fZsngYhaH/kRg4vmpgvpOMb/Fzle9FWiTQ16FqbMogvQfZy
	 5st+eTFKxPL9R1J28c8umm1pH+neHysxOAwnQ9WAVZWZc5n5aos1ZbPc5vt1tQirPC
	 P/Z4IX0w1EVmAwiqQBThRJPYG/x3d4Rd60UTZgwf2PWt1dk8FgSsbvbeAo9hjl3Btm
	 axLf5mA9XMNTToOL42shBnS8b48OwRwZc8AffUxs3PQHGHNqq3lHVjL5mCs9xr4Qv6
	 qDlJ8Xj9ENf4w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 13/13] mmc: sdhci-brcmstb: Handle absent optional sdio_freq clock in probe
Date: Mon, 23 Nov 2026 19:15:57 +0000
Message-ID: <20261123191703.179283-14-lee@kernel.org>
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

Standard MMC Device Tree nodes may specify "clock-frequency" on SoCs
that do not provide the optional 72116B0 "sdio_freq" clock, in which
case devm_clk_get_optional() legitimately returns NULL.  However,
sdhci_brcmstb_probe() only checks IS_ERR(base_clk): when base_clk is
NULL, clk_get_rate(base_clk) evaluates to 0 and overwrites
SDHCI_CLOCK_V3_BASE_MASK in host->caps with 0 MHz while leaving
priv->base_freq_hz non-zero for system resume.

Check IS_ERR_OR_NULL(base_clk) and clear priv->base_freq_hz on the
fallback path before jumping to add_host.

Fixes: 97904a59855c ("mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0")
Closes: https://sashiko.dev/#/bug/linux-88799a75-1ece-4f9d-bdab-eeb713627ab2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/sdhci-brcmstb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index db857f2273e2..976cddb2ca9e 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -585,8 +585,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 		goto add_host;
 
 	base_clk = devm_clk_get_optional(&pdev->dev, "sdio_freq");
-	if (IS_ERR(base_clk)) {
-		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
+	if (IS_ERR_OR_NULL(base_clk)) {
+		if (IS_ERR(base_clk))
+			dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
+		priv->base_freq_hz = 0;
 		goto add_host;
 	}
 
-- 
2.56.1.750.gf70dc682cf-goog

