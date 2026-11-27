Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802731;
	b=cgPfvyCyxW7OzzRly05sRFkqlciyalDD2Av68mMM7P8f/6zVkQ23xY0J8iTniQxfmOxr
	 RQ4jkOZpBe0krWa6FP0CMlZsHRPstn38/zBK1rDz2O0ekD9fHQOYy2n1KbWdDVOastF3Y
	 i7kkozhkE4UN4us5XZAfQ7c51Y9++jkQyVFzj8XK0PPG0fmbHJztDz/sNKjJBv5FP2qlE
	 UlIFTG1CivbXwTl4xCJtXnvxnu4VUnyaxmNMWkk6Q91MdWQWIjq+jFDpZN9VLBLU/RwoT
	 9nl7EqOWQjGOQXfNkT/q0R9tE+xW/h4eL5KeYUnL3aRfyuXn1rv5Bs4hgOnpoV50zRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802731;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oKPw0Sh6u08gGWLdVkVsz9ohHZFfCciFyRStu4d8iQg=;
	b=PLubx+u+6ETp5q8L9sAkJkCrq7GSf0T+WaIwJWFbZN40llU0Mxr/0pSInFen3lmULaXR
	 QLqeEHeIXL6CaMDkQOwqeMlgl460dAwQf3sHDTu3BedhZ5UK/1OssKSNO72jvDxyiFR9n
	 sYRfSI/8aeundEjlinOZXKaTjrHVgDhfUgoLizcFPwuo0GBLaILqBRTBpWKqfeWEolFnu
	 JTAvjMujPU2xG/YFAfRiYGCEUNLAATAljteHy5+O0ljthhkSEeHMkIM2CK0m8NqyCHjTH
	 hIDaUk6OK2z0HLNefoDni2nzpjlJxK1wT0kCyZ3SKj2HAgR0hv7AbWcKY1rgRftJEWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFhc0+5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA2606A31C;
	Fri, 27 Nov 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFhc0+5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F391F00893;
	Fri, 27 Nov 2026 18:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802731;
	bh=oKPw0Sh6u08gGWLdVkVsz9ohHZFfCciFyRStu4d8iQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFhc0+5AaEWBuBLIFFgV6BhxXq8oB3Ok+LbhwMvqJEms1JUMRAHrGze18V/ANJ12S
	 xw0pFmeoAyK8M18cUjlftz6vntdqduKyh7ADX3PF1mcWcGsS5OkelqRFDy//vvZNEY
	 z222KKk9LWYfe8KtXE59xgj3B+6+oINcH2JuK4Krwj61ZsrcXPJoT1sJIZy6RJy79Y
	 S5xc0uaL2XDTo18msEcGFTIdoeKJbg/DUSJlxXN5i4j8xlPHtTcWw2iQNIGa2z+YPD
	 FIVdAAemyHLWrfrRo9UTfJAKFeEYNKl59aJRajBPOB1OjkWGX3KrQxJoyLekdQ5peb
	 btAnvVN8Q7hiw==
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	=?UTF-8?q?D=C3=A1vid=20Vir=C3=A1g?= <virag.david003@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/12] clk: samsung: exynos7885: Terminate PLL rate table with sentinel
Date: Fri, 27 Nov 2026 18:03:16 +0000
Message-ID: <20261127180416.3277544-9-lee@kernel.org>
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
into pll->rate_table.  However, pll_usb_rate_table omits a terminating
zero sentinel, causing out-of-bounds reads into adjacent read-only data
and populating pll->rate_table with bogus entries.

Append a sentinel entry to pll_usb_rate_table.

Fixes: 011a9de99793 ("clk: samsung: exynos7885: Add USB related clocks to CMU_FSYS")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos7885.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index 17c2a4fc1a55..6bde2437b0ff 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -729,6 +729,7 @@ static const unsigned long fsys_clk_regs[] __initconst = {
 
 static const struct samsung_pll_rate_table pll_usb_rate_table[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 50000000U, 400, 13, 4),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock fsys_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

