Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452576;
	b=JrnlHnCXxNFEkaDmQkqqA5KwzOV1IITG72A4VdcKNXnSnItN4Xje/k46gF2hWOm8GR0Y
	 V2eXEq29h/gp0eUrJ0m4xHkdVd9rqXfXnvPzISYLDYGOqDAaugPPNs5egSRJDdNXk6jat
	 njmDqxkXjMA4Za2pJcEQBgQp0jmwWLDFW7Tnevqf22kvevie9xO0/VS1XYmGJv564jWle
	 etB6mmi3rjTt1J97oXlh3k6nPisCe8N+0a1wXO+RBszUWx/ez1KyWRk+Vg9H5Jl3h6xa+
	 XngZPQg9qGmB4+ZxCIEFRzT4BXySuyLYH04K+dtPqEGVMIdTfhrWR96SJv29/mNSbUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=S1Gp2Tv8FiLL9zGaZkwNFKOWLqDNS1bHIMrQXS8jtIQ=;
	b=rquHUNSJvv9xN3dRjuNzbDi3nDAFoCDJFh34JUYmhMFIpKcGBEVpynDy88+XU//ELmBA
	 OUN3tsdkvlHVYSaC9vp0ynnEup0lC9MmowzEjudHFnwbwiXXWOzxbU3xgHzwlbCSI6lD6
	 Hk+Rpigh7OIvbIrIwZZ+iJReBxpZGQ/pkDkekLskyRPhw3ziqBlHN9RsJonm8ergCswqE
	 gW+9TEyTgKQtxC2ui0MTp4b0mIXGKPDPybBl33eMOzewaUD6vnKrT8/8UXCzIkqy81KG5
	 hCaztKmedGggCc1i95Q9eLcpBIrhQHJ2jo3yYlQPxgZ5hQx3dEw70/KwDMxUhwqq9ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGez+3Tb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A70606A69C;
	Mon, 23 Nov 2026 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGez+3Tb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEE51F000EE;
	Mon, 23 Nov 2026 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452576;
	bh=S1Gp2Tv8FiLL9zGaZkwNFKOWLqDNS1bHIMrQXS8jtIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGez+3TbhzDNmdt3TH3qQ2mUFSBDqJipZdrUehk+BuWGlCZygu3oxgjQAavQVtsu/
	 +OysUCxOj/tDJTC7Kl2fFGLJEZJ83KK3yP7eEehbi+PGQVLDf300s85Z4+F0Bekk26
	 +bb3PTVFJ6WBZsSKZ8O0L1IY4fvnerVFsVA79cZuINjM6RCckp0A/3LFH2PrRETDes
	 NR81R+HKsMKHm7SZIdaYCV6IXdBKb+ooanP0zaUYm5rfqwCWd2Ylnt9SfqqcO5Fn24
	 Ixqnj6MB/a0mXHnqHvCCdAI0fgOV0ne8wzS5dZnkTEVCpxWqtcTzHsJtSFNor2q6Ls
	 MEJbNoTnIQL3g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Abraham <thomas.ab@samsung.com>,
	Chander Kashyap <k.chander@samsung.com>,
	Amit Daniel Kachhap <amit.daniel@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Marian Mihailescu <mihailescu2m@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] clk: samsung: exynos5420: Terminate PLL rate tables with sentinels
Date: Mon, 23 Nov 2026 16:47:40 +0000
Message-ID: <20261123164834.3330320-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123164834.3330320-1-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
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

_samsung_clk_register_pll() sizes each PLL rate table by scanning until
it encounters an entry with .rate == 0, then copies the counted entries
into pll->rate_table.  However, exynos5420_pll2550x_24mhz_tbl,
exynos5422_bpll_rate_table, exynos5420_epll_24mhz_tbl, and
exynos5420_vpll_24mhz_tbl all omit a terminating zero sentinel, causing
out-of-bounds reads into adjacent read-only data and populating
pll->rate_table with bogus entries.

Append a sentinel entry to each of the four PLL rate tables.

Fixes: ca5b40293822 ("clk: samsung: register exynos5420 apll/kpll configuration data")
Fixes: 9842452acd3d ("clk: samsung: exynos542x: Add EPLL rate table")
Fixes: 8b4a7acf7b30 ("clk: samsung: add BPLL rate table for Exynos 5422 SoC")
Fixes: b92981de92cb ("clk: samsung: exynos5420: Add VPLL rate table")
Closes: https://sashiko.dev/#/bug/linux-553831f9-0a7b-4e94-be60-222de60ca8c3
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 400a5c59815c..35baeabf3ccb 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1419,6 +1419,7 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 400000000,  200, 3, 2),
 	PLL_35XX_RATE(24 * MHZ, 300000000,  200, 2, 3),
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
@@ -1430,6 +1431,7 @@ static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
 	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
 	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
 	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
@@ -1448,6 +1450,7 @@ static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ,  49152000U, 197, 3, 5, -25690),
 	PLL_36XX_RATE(24 * MHZ,  45158401U, 90, 3, 4, 20762),
 	PLL_36XX_RATE(24 * MHZ,  32768001U, 131, 3, 5, 4719),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] = {
@@ -1459,6 +1462,7 @@ static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] = {
 	PLL_35XX_RATE(24 * MHZ, 266000000U,  266, 3, 3),
 	PLL_35XX_RATE(24 * MHZ, 177000000U,  118, 2, 3),
 	PLL_35XX_RATE(24 * MHZ, 100000000U,  200, 3, 4),
+	{ /* sentinel */ }
 };
 
 static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
-- 
2.56.1.750.gf70dc682cf-goog

