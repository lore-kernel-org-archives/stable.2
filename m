Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802687;
	b=vTQV1WN9HRV1fGKC3pb6anKSI14jYrteyhKY0afSYacXsVdEflg68chCWFKbwSo1ADvq
	 Jgy9pG/hExnENI1cdgsL/dT6an7B32HDfa1bNrFrSPta8ueVG8Y69RHF9XdPtLC0r87Va
	 QE+NA7RGLNAYF0IcS92VM0B4BCnH0/5qe3KX5XNQkdeMeWlztNuoHkW8yLUvY2gx65WSa
	 G570j0z5kdiVhgjH8i4oENnTpV/b0fU+oH9hIQB5C1z3UO4dwvg+Tyd3OM1jyvCtDFSX5
	 DyR+lelSHiImJJV4Hst+L+na7W6H+WaOgBUvzwaWrtEDrUKVC2gYfQ/9jroTj13Lf/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iykf3X3+ChvaN5G6+M6V6y4Wk8M+xXCVPSQCEvNKrTU=;
	b=KR40RVlwL2z09CtWCsjtep+X1EbYWvMIEvh9zDILs2TAs9v9hFmMpJD3X1Sc/F4RIeev
	 72MOfzMsEOfsx3t2IWoIBz0n4Zwy3YGH+3QlLNOAOrg/ADsZ+C2UHdWhLohjf1juIm0JS
	 0iKLGZx0S2qjVrMUNeC5oQvttUz5x9kYfJ8td7yXJIILZQW0Siz4/l2AIbxljoBLSmsiI
	 gbbof9bc2jEf0MIOlnM5sb0k0UPE8hKUjnBcdEWl3TZvcTqGIs+XtJ8+p7GJ+iCj34y5e
	 UNFOHJWYvVZlHyjB8YtNz1Vs0bcrgGQ4qt7SJ84gyD0p2AwtNKQunNzv6wPKIw3U3yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ob4KMCsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6641606A31C;
	Fri, 27 Nov 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ob4KMCsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862641F00898;
	Fri, 27 Nov 2026 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802687;
	bh=iykf3X3+ChvaN5G6+M6V6y4Wk8M+xXCVPSQCEvNKrTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ob4KMCsVkExvdgaqNV6wLZvGUCB+/eupYkApP5vlMV5j5lqflUu7lS+AFAAMwYa2s
	 9/fOdJ/te3QMjOgbQCxT22xPn9BR6HFrmhdeL4WU2bsG4vwkOQX7rGT+tHJxH0q3KS
	 kRZD3frB7FIAyzrIo6/x3M4IMxCEW7AkeWzkhR3L9PSQxyaGrEdYHsybn92mSTTEEZ
	 nMEkd7OqOjP1pjxSr6B7gqjULfNWdObrOAk4IPshj3CGeO7ztMduCXHL7FvLrzEpjC
	 HRBQAPCGyjtwyfWrlI88MMHYybvHlLeZaoBudd4YuNi8reRzOlnNu4rOxUjcrU40ah
	 3LGW9WyVo8vxQ==
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
	SeonGu Kang <ksk4725@coasia.com>,
	Ravi Patel <ravi.patel@samsung.com>,
	Varada Pavani <v.pavani@samsung.com>,
	Hakyeong Kim <hgkim05@coasia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@axis.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/12] clk: samsung: artpec8: Terminate PLL rate table with sentinel
Date: Fri, 27 Nov 2026 18:03:11 +0000
Message-ID: <20261127180416.3277544-4-lee@kernel.org>
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
into pll->rate_table.  However, artpec8_pll_audio_rates omits a
terminating zero sentinel, causing out-of-bounds reads into adjacent
read-only data and populating pll->rate_table with bogus entries.

Append a sentinel entry to artpec8_pll_audio_rates.

Fixes: bd5336e3f704 ("clk: samsung: artpec-8: Add initial clock support for ARTPEC-8 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-artpec8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-artpec8.c b/drivers/clk/samsung/clk-artpec8.c
index 0ea7c8b58674..fd35643be2e3 100644
--- a/drivers/clk/samsung/clk-artpec8.c
+++ b/drivers/clk/samsung/clk-artpec8.c
@@ -173,6 +173,7 @@ static const struct samsung_pll_rate_table artpec8_pll_audio_rates[] __initconst
 	PLL_36XX_RATE(25 * MHZ, 100000000U, 32, 2, 2, 0),
 	PLL_36XX_RATE(25 * MHZ,  98303985U, 47, 3, 2, 12184),
 	PLL_36XX_RATE(25 * MHZ,  49151992U, 47, 3, 3, 12184),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cmu_cmu_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

