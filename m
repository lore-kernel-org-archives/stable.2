Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802709;
	b=VDLIe7mVJD3yR8gZ83/Nv0Hglv8bHlURq0nmweag6XT9hZH8+VqO7E1yPvKkr6KamKZj
	 R1ReeRvCq/zNguLCCwcLfYWiF0M+hVgC4LRRBgt2sfA3VvLSS+bvjg89UDJBCFw9KKSYj
	 Ms7wNDWB3CGNxXdcswSUKTtVoJdQddM8YGuzXn5QABhfn2LmSmqT/SJMDPwW/qzUrXmmf
	 lhRvxN857cUktb0FmEtU8h17/ryetJilah7xTRrAFexPfCmT6rfgOD/+ebYBoBzp+5upl
	 HbZrumBU6/lpTCktFC5u0PG3nf4blVwaKHphaSvkH82s8h4RKT65ClqZPGOwJpvtlqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802709;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dm5xm1kq6ZEGkC8uQj5hSaHXrHxlmmnQS706H19wwG4=;
	b=JLc+RXUuMkzp3W1XUBZBTJfYzmD4xn4KRfA/THuLJT6OwNUAsdMSbJ6oZV0Depwml/PN
	 A6fjiiKhSTo3BsjMdxMeUz3SW2o8/SzwLjZqYPDq5B0PQPqCz7aymO3BcN6eQJUZbu8bV
	 Hs8Y6HLes7VWB9UA/bFhSDZFeOMt2W+4Adqhp5G3ItItWkhxfye0bzkzVGSrtWwvy4YYH
	 nFUTma0pZlUNfJlf1So8sKueCBI7nx8AE2YosufuwtAhN1HmOtYrUeBNYsmsQDRtMOmfF
	 JJArCXW2TwYtQmaFpqX2dPnwgK3BIREWD0krqMtZJssrYEyB2MW0VGodoibEHKNudxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkv9KAfe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43786606A329;
	Fri, 27 Nov 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkv9KAfe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA911F0089C;
	Fri, 27 Nov 2026 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802708;
	bh=Dm5xm1kq6ZEGkC8uQj5hSaHXrHxlmmnQS706H19wwG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkv9KAfet5e/uF3x8/nVEgG3cAhcVqTECGZyoNOQOli39gn5UV9SP9Lt5B86xAH9p
	 2Zirzns0/fQP+7mwtSwqfPB2TyuK+0AYTUt1oK3p0KkipO4Q4si27iv6WQoOEOlQPQ
	 hG3FCZLiwP1xaVOHVLZArNZ1W0gasoPQOJdxbG0cHtxJ6XEdZzbHtYx++9Ij97cWWd
	 UT0wDaoRvdu/hHb5PuH64yLHOAwvziPRssXHCEMp+Ggv5GC8BVOAhGF1jAWUpEwNZf
	 1GsAflXQJRHNpQ25nlaTxmnyWjCnWzIRZY44Mt4vxfof9NEyJNjzqul0m7PiaA6bIE
	 ICL1/OHlj7P7Q==
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
	Tomasz Figa <t.figa@samsung.com>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Andrew Bresticker <abrestic@chromium.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/12] clk: samsung: exynos5250: Terminate PLL rate table with sentinel
Date: Fri, 27 Nov 2026 18:03:13 +0000
Message-ID: <20261127180416.3277544-6-lee@kernel.org>
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
into pll->rate_table.  However, apll_24mhz_tbl omits a terminating zero
sentinel, causing out-of-bounds reads into adjacent read-only data and
populating pll->rate_table with bogus entries.

Append a sentinel entry to apll_24mhz_tbl.

Fixes: f521ac8b390c ("clk: exynos5250: register APLL rate table")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos5250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 802300c945a9..bce5b03ecd2f 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -730,6 +730,7 @@ static const struct samsung_pll_rate_table apll_24mhz_tbl[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 400000000, 100, 3, 1),
 	PLL_35XX_RATE(24 * MHZ, 300000000, 200, 4, 2),
 	PLL_35XX_RATE(24 * MHZ, 200000000, 100, 3, 2),
+	{ /* sentinel */ }
 };
 
 static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
-- 
2.56.1.839.g22a8290db9-goog

