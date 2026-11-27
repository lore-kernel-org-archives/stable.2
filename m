Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802754;
	b=I2D62/vN91vt/Ip6o/YiKkCpbsIoPtcjYrLIHGKcTQFfCihDhPHwk7Cgy4DDze/7Kbv5
	 dWX5M/hsOrv1qagQH3CEB65D/BcsMtCWxdHo/JF1WW2L3e9KuCGRc/NDBR3/zAAvkkrOV
	 ZAllZPjBqU8FTRZI06vo3+at76xRz0HU4XSSt8wMYbfnl4BQJueEGdQKWT9VDPCtyltU9
	 X8CpAKbv1o7Y8c2EqwGp54Dyl2zOD9cK1/Z/YFJ2i8lMsHE2mcA6fcxtycsb9fLrZNc7D
	 bFnG+n3ql4VtM2VLbXy1MJ+J2XLp7yZJkf4lrnfuR4rA/06hOOy1CuETgEuP3s2O+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802754;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fDXUMKPJMrDufyiYxPC4NDHMrvqkg/Y3/64a4fBpYwg=;
	b=Uw2HVfLb2+RT3giY6VltOeKIhM8V/4/P2LV2+jWSKfUXScy+1PhOt7e2k5+jsWMK2rSQ
	 9lc2EBdfYChPCxDiAeUE2VKtFTi79Oufx9+rQ819lG/8wbG8TjV+YL0oFqMjfDTOt2zcI
	 M6sCmbdGzI2UHofNan5ayLeiqGLEPehqsLBpEO/42GblnNGqR2hfoUM++cMmWyCFXfHT7
	 JlaxKe1ehMtwZINOaL4TgOpOLgjGZsS+bGHPpHXx8wKd4caTgsmuTAgSMOqLznADlLTcp
	 E0s04RTv94vprN0YoTzoSZkStcMjUX+9aLMQLJcX7a6HnOlwhk6lCh09dyqk7sG5Heg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZIY7jhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACE606A31C;
	Fri, 27 Nov 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZIY7jhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CB71F00927;
	Fri, 27 Nov 2026 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802753;
	bh=fDXUMKPJMrDufyiYxPC4NDHMrvqkg/Y3/64a4fBpYwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZIY7jhVSoraM3HaQ/qrctab3KAipDa6HW6vFLqAL+dqfJhQTBqBMM8+V72WLW6iI
	 cyJTxHzhkpv/G6QmJcyDtOo4qQz4OE0iL+qXERH6gIoBeRM8hdO0XpkzkrkKZFHyNB
	 6qNGyXAauptQjRd9yhHdJhojq0dmJZbFXknkHkssH6tSnEFIhXEO5cGBGRqTc+VHvd
	 zintHdH+xLbWeUdKuWWqRRL+Tr4qw0pc6CPgnk4/pVLziQJLJS7ezswhD/AvjN35YQ
	 MqanPq3amskOt/quBG/BcA1zrAQPXGzcHKlkFXyAkoOkF/A1c8VSkeAnj1aVwRbTEH
	 /C6Hjaclr2rrQ==
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
	Raghav Sharma <raghav.s@samsung.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Sunyeal Hong <sunyeal.hong@samsung.com>,
	Shin Son <shin.son@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 11/12] clk: samsung: exynosautov920: Terminate PLL rate table with sentinel
Date: Fri, 27 Nov 2026 18:03:19 +0000
Message-ID: <20261127180416.3277544-12-lee@kernel.org>
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
into pll->rate_table.  However, cpu_pll_rates omits a terminating zero
sentinel, causing out-of-bounds reads into adjacent read-only data and
populating pll->rate_table with bogus entries.

Append a sentinel entry to cpu_pll_rates.

Fixes: 59636ec89c2c ("clk: samsung: exynosautov920: add cpucl0 clock support")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynosautov920.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynosautov920.c b/drivers/clk/samsung/clk-exynosautov920.c
index a938f3cc7b57..7c4e9ab25624 100644
--- a/drivers/clk/samsung/clk-exynosautov920.c
+++ b/drivers/clk/samsung/clk-exynosautov920.c
@@ -1077,6 +1077,7 @@ static const struct samsung_pll_rate_table cpu_pll_rates[] __initconst = {
 	PLL_35XX_RATE(38400000U, 1152000000U, 120, 4, 0),
 	PLL_35XX_RATE(38400000U, 576000000U, 120, 4, 1),
 	PLL_35XX_RATE(38400000U, 288000000U, 120, 4, 2),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cpucl0_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

