Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802701;
	b=BlsUP7YH3//O1gudjBjInG6VNS3MbipyT+yjAolxBVRligK6WRytmvCU/O9JpPrkHp8L
	 Oq4V8V/67NgyHUz0AqQFfjVm954FOd2EXLfhesyFNS/1n2AlrHUAHmbFhZcGf9odGC12v
	 YQLHdlzttOgOyaVz3ZGJ51QGRec+zzXkN924ZJMEAwfOMjf/EOR8PlclRlnomrk6LJzZ+
	 JY8Gx8L2hU0XRj2rU4ZqybuN04nRSqY6qwcxTaOdUV5BM6n1DwXy9W7ohJGq9LZ0HlPt6
	 AI4wLD8v36IqLrGcOhO++KcZl+Uc31CGeXAJqxT6FZKnrdTR7SbnpXJDgMzpAfNvICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ev4/79lezZGUalRaCRxsS6Gn+Fl+AdLb3ry7Ayy3jz4=;
	b=b8M4T/57hAHxYUGo7O1ODtOxGXsx2w1ynqsJUk6IikkRV11slsFlndaEh+acVUbL3ZSU
	 7YqAPKFzBGLxdmuKMGB+yIvk5QybUNQuVSo6wJzrFbsjIU7D3L2BWBzH7oENTiU/QBTxA
	 oRiVnbAE7766MZB6MGXx+pLESG2lkUsBT/47ksQyUegQRI7LZ/rwmCIBtchMuUA0NiCKX
	 3DtyHBuFRbvNqDXEnVq6AXoOjHHhR7jHQsfAGd8gvlDSrpMaZpWKAxpJ/qoIdwe84EGMP
	 /Tqgo/zVhrOD+yxO2JdPfFNYpXj2ORd6LAup7qesuwI5vKLb04u7/qpVlzAvUQX1/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMRgcfc4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CE606A330;
	Fri, 27 Nov 2026 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMRgcfc4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C411F00897;
	Fri, 27 Nov 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802700;
	bh=Ev4/79lezZGUalRaCRxsS6Gn+Fl+AdLb3ry7Ayy3jz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMRgcfc43cGYsQ6hN0eNTI5tDt743WMHsEJC+LGalD7orx5aE3O4g9Kt+gdD4Bu4K
	 cGI3TIxr38zxEFRFB7YBTZ4UHv6YQ7dwBm4NEUzwzgrRXLERTqC4dShwI87N3cDGpQ
	 ZpZHeev1A8xuLaLu5Jwvuysgah5nRyU0LTpGgDdG3KIYr4JWtZAMrOc187IZ+h8E66
	 YCUF5RkRDz4nPhPEkYn/cNiPr42/Yg2mVuOBD0gaeGuV9MJ8CIJJNXNLIlX5lqbOcO
	 lr+suu9Uro/Il5rp/BLeS7WIBsX6KHmOqGNGgqIKZiOQ0ZphLqT1dWffKI1yORZdNt
	 CoQ4miZHKbdfg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	GyoungBo Min <mingyoungbo@coasia.com>,
	Ravi Patel <ravi.patel@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@axis.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/12] clk: samsung: artpec9: Terminate PLL rate tables with sentinels
Date: Fri, 27 Nov 2026 18:03:12 +0000
Message-ID: <20261127180416.3277544-5-lee@kernel.org>
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
into pll->rate_table.  However, artpec9_pll_audio_rates,
artpec9_pll_cpucl_rates, and artpec9_pll_fsys1_rates all omit a
terminating zero sentinel, causing out-of-bounds reads into adjacent
read-only data and populating pll->rate_table with bogus entries.

Append a sentinel entry to each of the 3 PLL rate tables.

Fixes: 85cc5be65b82 ("clk: samsung: artpec-9: Add initial clock support for ARTPEC-9 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-artpec9.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/samsung/clk-artpec9.c b/drivers/clk/samsung/clk-artpec9.c
index 2eaf8117638c..aee5a9283de4 100644
--- a/drivers/clk/samsung/clk-artpec9.c
+++ b/drivers/clk/samsung/clk-artpec9.c
@@ -176,6 +176,7 @@ static const unsigned long cmu_cmu_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table artpec9_pll_audio_rates[] __initconst = {
 	PLL_A9FRACO_RATE(25 * MHZ, 589824000U, 94, 1, 3, 6238440),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cmu_cmu_pll_clks[] __initconst = {
@@ -490,6 +491,7 @@ static const struct samsung_pll_rate_table artpec9_pll_cpucl_rates[] __initconst
 	PLL_35XX_RATE(25 * MHZ, 1400000000U, 56, 1, 0),
 	PLL_35XX_RATE(25 * MHZ, 1100000000U, 44, 1, 0),
 	PLL_35XX_RATE(25 * MHZ,  850000000U, 34, 1, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cmu_cpucl_pll_clks[] __initconst = {
@@ -815,6 +817,7 @@ static const unsigned long cmu_fsys1_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table artpec9_pll_fsys1_rates[] __initconst = {
 	PLL_35XX_RATE(25 * MHZ, 2000000000U, 80, 1, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cmu_fsys1_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

