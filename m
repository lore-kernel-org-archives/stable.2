Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802739;
	b=Orz5mHAegOdTMs/ZlH6M2Pza5rcmPMGKd3VVA3TtVcJnqc29pdLOCntwULN9MEQvhQdP
	 228jNst5RBSE4Hraikgsgkvhdqn9/3qAbEAY8vta4PbdcMQpW5iL/cEtpl7deb05HFyd+
	 mvMLo+hp9Qrb044MNcsH+8V9Yehg0DM0u2+dWDqXTiWrERmsrDkHqcatN+DYwCMRUSFM/
	 p6atEmU5lstb0q0anMgUMBvYOl5aIo0LdmSni1+6vMOYCZdjf0yX/vZVldwW6+djqiE/c
	 cz0Ot/vyhyCjmqMzKsjD/H+Z6NWYJWL8XuNgrzvmMREk4fIvdXGCJAOmq9lqYjf/Qew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802739;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vm87kNFv7uCYYZAQDZHdRyL8EkUzY9YQND6CK5MBnxk=;
	b=J8K8Jv73sc8qLsN1tkZ6z0vASgm8Z0UkO+ojhiyS+knl0YnTxLoNqsL5nSjGOJJhym07
	 A3WrEgQK0obcWyHb18CtmR01a50vOnq+7n2L6kAgPKUiaodelV+CBvBanNZCcG1IrEFbt
	 FWFdOy0Og7R80MRNB9nvwFP8fnlKq7Yj9ZrFAW164QcpMyLFsqAuh6Orbb6WLJX3WzGDW
	 tJYDdYZrrhsibVlXnHREcz+28JLHSYzPgVIkRm8bYRPf39Zd8C9KWzw6Nqk29pHZmPyGm
	 Gi5q7S8wsEpcjIyJvcrPg/kMXNV+hZZyUkC7GMBtMuTj1CmjNfHvBv1mE+au/lNRw3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWv11QJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190D606A31C;
	Fri, 27 Nov 2026 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWv11QJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2FD1F00898;
	Fri, 27 Nov 2026 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802738;
	bh=vm87kNFv7uCYYZAQDZHdRyL8EkUzY9YQND6CK5MBnxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWv11QJoOy6vvIYlSzs4X4OyUZdqERjNLd+HFvFNxjslzwQhkUdhueL8FGDsruBSy
	 DVnrM9Ktcxz+zvnKsjIzUu7wHD1HqfLkzPvAarAVeOKgDt2kwUvNomOuM1v/CcIevj
	 T7ojJbqvi7QMhFco//ls0ji1oldo9N634BrnqJP4P1EBELgo7gk4O4xD2jIYovVqLh
	 qfRBrYE3VleFE+wWLmjd66nvwIzIjLLoLdbJ0lDTh3DFJPBIYkw1iPU5jCr7NCC6bp
	 uhjUmYvk4R1E3UNKTzROugBIKMhEgQB+YAuOuN8TeP/tWGmEThB8hkBN/Qp/+xZLSj
	 6e4/LcOqZ4gJA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/12] clk: samsung: exynos850: Terminate PLL rate table with sentinel
Date: Fri, 27 Nov 2026 18:03:17 +0000
Message-ID: <20261127180416.3277544-10-lee@kernel.org>
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

Fixes: dedf87341ad6 ("clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/samsung/clk-exynos850.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index ebcdde93bd46..9ac311161a3e 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -1180,6 +1180,7 @@ static const struct samsung_pll_rate_table cpu_pll_rates[] __initconst = {
 	PLL_35XX_RATE(26 * MHZ, 247000000U,  114, 3, 2),
 	PLL_35XX_RATE(26 * MHZ, 182000000U,  168, 3, 3),
 	PLL_35XX_RATE(26 * MHZ, 130000000U,  120, 3, 3),
+	{ /* sentinel */ }
 };
 
 static const struct samsung_pll_clock cpucl0_pll_clks[] __initconst = {
-- 
2.56.1.839.g22a8290db9-goog

