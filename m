Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802762;
	b=TzC24msy5fMDmXlOt2fv4JwaGtRD+/84I0NMCDHyuqGZvi1YN1jmpDP4DzfRFWLReg6S
	 jC2hgWFD4TlQSqChvobPf1Dah8jM7iBhasu8PI/ml8zLOl59M7a8dNr60EKFY+cl6ZNzG
	 GA381v31thHk726MxEX6aIUaIDPzSPyQe8K/pqONH8u+WTNbiLYpa9muUjYWu/HO1ypD1
	 akUayMrJ3Glox0ZPioRDRUz1RF1IvccI4c8G8jP1Y6p7x+I5+yDx+cqvObywwyeZrDrVJ
	 dmxgKiX3nraHfMv2EJPAnv6fTQhXZYDP5sgoHnnZfI0ud6Ou782WYU1NE2mdAmvJgFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802762;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/LAn10CjDS6Zxt3L6mFomWVrJQxlQ87/AtaWfuA2RyM=;
	b=jZiTUh9O/eY+wNued8HluGZ2zMKEXIwKvMFGXhXn5sosPjwHdQYNhwfMqoaPNwGx0q+s
	 wygc8MTmgAjvf3N+UYKHgLANK+dubqG4lmtFP1QKbeqjrWEyegzGH16xMrCb2XKH9Ql1V
	 1aEkvaQIYqahnMmIJ0w/niVm0q5f9ExVbTPuJ21PQvcecgK9kfXTX35YDLyVJnHbwtPoY
	 YGcaeKA4Rt4DH9x34rNaowscGr13ZgXAj69/DtTEmeOoI3ZJBifjbiVU3VU5QaWw5H0h5
	 gWkbQqy+6okBV3skeUVswNRXCgiCkyF3XCmkKqNS4r/WBAB1ftctYatx1wBXcq98VQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLMcuMf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE7606A336;
	Fri, 27 Nov 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLMcuMf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A1A1F000C1;
	Fri, 27 Nov 2026 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802761;
	bh=/LAn10CjDS6Zxt3L6mFomWVrJQxlQ87/AtaWfuA2RyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLMcuMf7+6bklxEfCrmvW0LnReaqJnDeLLu3fRuzG0i6o/KU4CsLtTWJO8kfIRdOe
	 0F8pNKxURPoi+83T5ueRj5oPLzDUEhNX4ww3OUbMvbKJ9F4Qr80RKQuAMCRiDOiLq1
	 0lYJaVB+Zb21BudkyEkIUcueRfBGAreu0ccjeVMKc+h+xEMwAsQzcpAK8//6fBpFW8
	 75jj2Vs8AFAOVT/NB7mfc0w00ACGWHJJ3QZm8O9zEXug5VrmNZe66eIcZBfsS7Oc5c
	 //Ns4MjBwwGkvi800rvOUwNKmfFY10TU8oo7Y7D9GAtyQbQymgOTCWq8MbPED2gqGg
	 PSgqLxtBkJMtw==
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
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Ajay Kumar <ajaykumar.rs@samsung.com>,
	Jayati Sahu <jayati.sahu@samsung.com>,
	Smitha T Murthy <smitha.t@samsung.com>,
	Sathyakam M <sathya@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 12/12] clk: samsung: fsd: Terminate PLL rate tables with sentinels
Date: Fri, 27 Nov 2026 18:03:20 +0000
Message-ID: <20261127180416.3277544-13-lee@kernel.org>
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
pll_mfc_rate_table, and pll_cam_csi_rate_table all omit a terminating
zero sentinel, causing out-of-bounds reads into adjacent read-only data
and populating pll->rate_table with bogus entries.

Append a sentinel entry to each of the 6 PLL rate tables.

Fixes: 4f346005aaed ("clk: samsung: fsd: Add initial clock support")
Fixes: 75c50afaa0d9 ("clk: samsung: fsd: Add cmu_mfc block clock information")
Fixes: b826c3e4de1a ("clk: samsung: fsd: Add cam_csi block clock information")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-fsd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 0a0bf1d62a04..ded7bfa97234 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -155,18 +155,22 @@ static const unsigned long cmu_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table pll_shared0_rate_table[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 2000000000U, 250, 3, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared1_rate_table[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 2400000000U, 200, 2, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared2_rate_table[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 2400000000U, 200, 2, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_rate_table pll_shared3_rate_table[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 1800000000U, 150, 2, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cmu_pll_clks[] __initconst = {
@@ -1482,6 +1486,7 @@ static const unsigned long mfc_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table pll_mfc_rate_table[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 666000000U, 111, 4, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock mfc_pll_clks[] __initconst = {
@@ -1642,6 +1647,7 @@ static const unsigned long cam_csi_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table pll_cam_csi_rate_table[] __initconst = {
 	PLL_35XX_RATE(24 * MHZ, 1066000000U, 533, 12, 0),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cam_csi_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

