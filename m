Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802716;
	b=KpiaiAc8s7YALRDgEYud1ULlCLwG69jkA7bbeFfdFtv4o2fQhAckVVPMSb3NEZSjFht+
	 kLjv6hREAX9398bitrn3TWnUxT/rSgvnnDYPg6dOOnwYzCOT6Qb0jZf4U5XWfhZurQ86U
	 pEVk+usYWa3j6sS9MBW4ReFFoXmGyT2g5RX+WeaVO38TvoH8Yb/p2W1vaAjy6qftOI4YG
	 EVwwdGw+3SSIUoBvvyA+ikpp2qfQMGOK+7OH3T9g4aUUm52tKKjo9kE0Cw/yZ5XvUQvKV
	 XZj75FAQ/XgC2CdFsybgY0iBKFsu/YPys/e02Qq7L/CdJYF/6WZPxtCA7gFlrZ4GcNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802716;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WtO56VJdoJ8x71AZKpomoEjXKBrkJ9C3gxPN3Oka1fs=;
	b=HCARX+ZwMICpkx0ofnWskz+vsDbUWXmSxPtGTl1BAQUCtTBQb8wyQAG08g6d8Wh+qSTq
	 f1U0eBL1MuzOgq1cyZvvWW5GOIJDvF28bErScDKEVdn62dVisva0vVTkQbb3LoHKvCwJS
	 C8R2Rkit6k/AIS/cVxG76cz06zjqO6Y0YRWOunOgwi2cLko9JT9MGxwcAmyDgemqJSmIi
	 SK/ac7x4ECTAczhzOv3yllfKsRhQeYayJLsgXMGyXtIvBsTus/cKUSK5BGopwZstE1uel
	 EXLrAwCV22YyLaHVngJrakOfAYPcaH7/5kIJ3CW3ZLa24a0giwx9sxENYI4hRFFsT8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqNIOC6N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBA606A31C;
	Fri, 27 Nov 2026 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqNIOC6N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848691F00897;
	Fri, 27 Nov 2026 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802716;
	bh=WtO56VJdoJ8x71AZKpomoEjXKBrkJ9C3gxPN3Oka1fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqNIOC6N48n6D/aVTXmPI3lG4b4TpwVT39vIKcnyP54a16Wvk2Jr3Q+lFRWkn9CuY
	 snFTbMBQ8JRW/TEX3JsI7bl/vImMetuvBwKWnDcGwK3gfS7HqdrPn3fV86ktCv3a96
	 RF3wjW3KOVq+3PUdib6btOOTVVhVbqJvjuKiMk9gatNnX6QigFB4a9WgPa/0Ko/+e5
	 ju8uMeQ0JWBOy6gN2EB2FbjNm5vfQ0FHhggIVqRNgiW05FZOHxNtAjV2MfVycDsPtj
	 M8496tJ9pLuPbRDAjRjqsL3XFoA0406sYkbZqo8L+Plgu+U92E1xTAFx+FQO2DPp2j
	 XaUvjcpzzDK6g==
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
	Rahul Sharma <rahul.sharma@samsung.com>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/12] clk: samsung: exynos5260: Terminate PLL rate tables with sentinels
Date: Fri, 27 Nov 2026 18:03:14 +0000
Message-ID: <20261127180416.3277544-7-lee@kernel.org>
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
into pll->rate_table.  However, pll2550_24mhz_tbl and pll2650_24mhz_tbl
both omit a terminating zero sentinel, causing out-of-bounds reads into
adjacent read-only data and populating pll->rate_table with bogus
entries.

Append a sentinel entry to both PLL rate tables.

Fixes: d39e55e06371 ("clk/exynos5260: add clock file for exynos5260")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos5260.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index 0a5959823370..8417321c1202 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -59,6 +59,7 @@ static const struct samsung_pll_rate_table pll2550_24mhz_tbl[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 266000000, 266, 3, 3),
 	PLL_35XX_RATE(24 * MHZ, 200000000, 200, 3, 3),
 	PLL_35XX_RATE(24 * MHZ, 160000000, 160, 3, 3),
+	{ /* sentinel */ }
 };
 
 /*
@@ -83,6 +84,7 @@ static const struct samsung_pll_rate_table pll2650_24mhz_tbl[] __initconst = {
 	PLL_36XX_RATE(24 * MHZ, 133000000, 266, 3, 4, 0),
 	PLL_36XX_RATE(24 * MHZ, 100000000, 200, 3, 4, 0),
 	PLL_36XX_RATE(24 * MHZ, 66000000, 176, 2, 5, 0),
+	{ /* sentinel */ }
 };
 
 /* CMU_AUD */
-- 
2.56.1.839.g22a8290db9-goog

