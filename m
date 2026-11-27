Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802746;
	b=GheqxRVB1IUIPC/P0N9rKpRn7E0adu1h55QjAJN4mh/9tKTapEIBCTuv/EgE1v/VoAl5
	 +h1954/0dtSaDf3OFZhCx+MlgtFSNGsReEAf8Ff3TM+7mWPOe4+hcJsJS8Mwhwico7+tj
	 rUFLBZDOcAwVIH18zbrk8iHH/a/dfKPfUNiX7j+O4ZE7BAVV+i3BuMESfv1OPAKxf3mtk
	 0U+e1sDx7si0Of9fWfemy5fYYCKsHIuHTwuXqCJvRfdyO2PfBVHLq9EMam4UeByR9xchD
	 5Q0hTCvEJ7DxwHEndL9lcs6B0GNQv1550RkHFnZmZN3wNu+iVOkZKVU4OQ4R4oROKJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=drD5AYux/nAgyk5mlGZWKgdWplCkfZIFBpk/Bqx84bc=;
	b=w8rD60BDSLfN48NRHax4eEe6cUeU6MdLYjmyfO7UK728zEUWu/jniEQFVcUkfJ22BHo3
	 Ofw3V3tuaQSeZDj1wd1eP87DRvH2kyaTFpc1Jv5Bw8lsuWIJGbSl6GqBtjFWXw+I3jcYd
	 c7GQivxPkdWXOfYyn5TWIVu3QPbhr1bL/+ciQOWGRneEAjM+atscL8/7RxRuuOLVkNqmW
	 H9GzmID3Gkp9cAJeEgHhzI98ud+1JtvG0Ev87INhcC88tXxZ8F+/tsgaRWGCEEw/dRCz9
	 mbd3v1VuzJAUTO6T9tezC0PobX2hL4FOliHnPVTy5LCFMyRAsalqxSJaVPyKft+xJrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dePSpsDL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB8606A31C;
	Fri, 27 Nov 2026 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dePSpsDL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CB1F00898;
	Fri, 27 Nov 2026 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802745;
	bh=drD5AYux/nAgyk5mlGZWKgdWplCkfZIFBpk/Bqx84bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dePSpsDLAvw7PlKB3kE245WttjoohRlSfbQ4Efe/p3We72Um/O3Qx3LhQ+mOKrUk9
	 umuyceNF6By6M6z8ONXbtnOZYx2TkblFNpKek2d9PHJ17QQI3YttdlZ35Ubh95kH37
	 Te1EHYqAPFVQqeLilGZbnwuFyBMqJlFDbnlTxcOC3woL3bH8a9t87uKYEswLWHL9pf
	 nOJRnKT0p1A8cPZsiEGh7gPMptfbKYT0x+D4gr4Su6j/m/1Ft012LlnX+uKVbSVzo6
	 JVQCc8w88GR+a6kTPjRgVAN11CuL5qjCc5JFq/KMb1VhLiE9vzpH2ocDQcaFuOtZgs
	 gYOIcqQ9zrK1w==
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/12] clk: samsung: exynos8895: Terminate PLL rate tables with sentinels
Date: Fri, 27 Nov 2026 18:03:18 +0000
Message-ID: <20261127180416.3277544-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127180416.3277544-1-lee@kernel.org>
References: <20261127180416.3277544-1-lee@kernel.org>
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

_samsung_clk_register_pll() sizes each PLL rate table by scanning until
it encounters an entry with .rate == 0, then copies the counted entries
into pll->rate_table.  However, pll_shared0_rate_table,
pll_shared1_rate_table, pll_shared2_rate_table, pll_shared3_rate_table,
and pll_shared4_rate_table all omit a terminating zero sentinel, causing
out-of-bounds reads into adjacent read-only data and populating
pll->rate_table with bogus entries.

Append a sentinel entry to each of the 5 PLL rate tables.

Fixes: 9174fac3b302 ("clk: samsung: Introduce Exynos8895 clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos8895.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos8895.c b/drivers/clk/samsung/clk-exynos8895.c
index 259481c4276e..daf337f47e4f 100644
--- a/drivers/clk/samsung/clk-exynos8895.c
+++ b/drivers/clk/samsung/clk-exynos8895.c
@@ -478,22 +478,27 @@ static const unsigned long top_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table pll_shared0_rate_table[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 2132000000U, 328, 4, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared1_rate_table[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 1865500000U, 287, 4, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared2_rate_table[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 800000000U, 400, 13, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared3_rate_table[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 630000000U, 315, 13, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared4_rate_table[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 667333333U, 154, 6, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock top_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

