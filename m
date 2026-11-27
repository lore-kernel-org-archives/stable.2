Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802724;
	b=RfMeEtiFZS4eT+M6p/ItDnZYo+BWDIaYrcxHSTg8mz9M74Jr6iDUd8E76H2jkkt4KFTe
	 lTtFtposw0jejI5golKAEgqh/TUpHVmRCjXk/SEeLSctlp28vzMOQ1CeSl3LOWirvlKJd
	 ZeeultVlSmj1LJn3mo5tAGg3ZE22AWXssFFMYjxwcEs63UXgsI6dBMxuWOa2wmRp9fPHs
	 asc3u1iuKdU/P0JExQPCrQag7y738tb5fj4iUz/5CYh6aPHtT2Sn3Lc2d4d5vVJy7L6bW
	 oZqeNCy5EnefeNW3VH1khwpN4sSFDrBp2KuVtRzOnwpJ4+MLo5tuEBOqCv1gPTLO2AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802724;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ogOm0dTzKvWGc75iWT1FdWl5GoOSduyc+CkcidfPAIM=;
	b=kFo0JR24pPDK+fMP+DHy7SJH3204sFYrRsI5DFYdYRTUdacixl/ADUJHfeWFHdQiaphq
	 yEwXOQqIMOz9huEoh4flQnylHOC+eKYJSaVU/VviIey+qHABAt31X0QFqpq8VuVrJM15v
	 Hl5MEZJ9nWtTeHFthhjIL7N04Hv5cS7qj/9xLlLHoCgwimK+LYGHB2PYtYawepiSWbv+X
	 TxvoHkXLIZ6d2mzg1DJ8K2xdCY0J6aFrfiznHvWILfqJRe4yzo5CMLQh3H+ReIhAscaeI
	 yAnloiANdV4DQdJ6fO8vdFpfFMdE8zbIpevSxpSlPtKLJ1YoUM98u0q6NGffpc4AeBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQSYVL36;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E979606A31E;
	Fri, 27 Nov 2026 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQSYVL36
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB321F00897;
	Fri, 27 Nov 2026 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802723;
	bh=ogOm0dTzKvWGc75iWT1FdWl5GoOSduyc+CkcidfPAIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AQSYVL36g41pMfcwv5SlMiR46FzH41SWgrK9y16//xq3m05ArY78TsLqVHfcafmvj
	 kKoCRkzBYUWnVNq+RW0j4EB39W28Ibv6qJNm+5IDLs/kIrcIC7qNwgPtsNTwU17AyG
	 ExN/frQJmEuGR4jb1sjdiBkfCtxAxmi6/o1prglIgt3cBnK/295FU9o/12RozKokJN
	 ZapNM8C3rhbxvCepYGNEYOe74xIERDNG4GVnEH8JdMbmjzlr1oVrPcF3rpiqz9UQUj
	 BUfOGJOhZk8yKipTzEqzf6VvoQiit1IEwnBK/oCSFF+yt7FwsRTeAQ6EaRRDVbZViP
	 vz1k12jbGSTjw==
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
	Tarek Dakhran <t.dakhran@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/12] clk: samsung: exynos5410: Terminate PLL rate table with sentinel
Date: Fri, 27 Nov 2026 18:03:15 +0000
Message-ID: <20261127180416.3277544-8-lee@kernel.org>
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
into pll->rate_table.  However, exynos5410_pll2550x_24mhz_tbl omits a
terminating zero sentinel, causing out-of-bounds reads into adjacent
read-only data and populating pll->rate_table with bogus entries.

Append a sentinel entry to exynos5410_pll2550x_24mhz_tbl.

Fixes: be95d2c7d918 ("clk: samsung: Add support for EPLL on exynos5410")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos5410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index baa9988c7bb7..0036544bd77d 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -235,6 +235,7 @@ static const struct samsung_pll_rate_table exynos5410_pll2550x_24mhz_tbl[] __ini
 	PLL_36XX_RATE(24 * MHZ, 133000000U, 266, 3, 4, 0),
 	PLL_36XX_RATE(24 * MHZ, 100000000U, 200, 3, 4, 0),
 	PLL_36XX_RATE(24 * MHZ, 66000000U,  176, 2, 5, 0),
+	{ /* sentinel */ }
 };
 
 static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
-- 
2.56.1.839.g22a8290db9-goog

