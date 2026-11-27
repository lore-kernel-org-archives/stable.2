Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807621;
	b=rJe637Dbwtkk/F6/FYq+VSDxiiaFxL7n41FxPEj0aPX7Mh0DjHg1XNi5HQoqVQWQ67uT
	 X+Ck65DecdIIc25/1lC1Aq16kIz+xyDJkb/y5acWsWZGzt6f+8LCsGtaVfcFK19kPAytw
	 2VmvqsOsZYLUQyHnrlTZrKPaCuKICKB5rqrqPgbex2ZkY5lYez13GhGss5XIQvDJTI+89
	 T++P5IAsA3xDHz5YW+Qlk4fW46355tUSs2jYpC/l1Spf/qtlyZNOBw2rV+N6MY+BvKZsM
	 PiweTP1cI64SAzOaTBmQz8K1Qh44+VfYQFuLQpkBIqMHNeo72GYU27lg0jHN0inIGfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i067TMNpbiCFZjRbPWgGfWz2BpFhr8QyptRGWKajm4Y=;
	b=h+md972gt7XyzKAR5LDlquZa3FjKzh8yxKj9QdfContQyYXWh9T6B23gH1rbu7PXUY47
	 HU0pKmQjowvXk80pmWlNOF7FGTfXp5vt55SZPdjcKyV1A5gNdtKIkfT900rPNR6RIkft1
	 iiLoFl/0j9EO7GS+PozseIG1iXQSf+pUo5rMRHBQPkkSBRWmiO4N7S2ykQR/98gZgLjAH
	 7zqE2EyqbkwyYSM80jCFxo9CpgfVAWTEpm5n9lV70Q2OTvEOTXh9+8QZXejAUOEM+VD+x
	 ZgA2yoA+IWmWCR5mij1EV/7eqEKlqMvV2c6fvDJgZzd+fTZsfzV7TIVXBHs3pha0kcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngVGGr4A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C0606A31E;
	Fri, 27 Nov 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngVGGr4A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D21F00898;
	Fri, 27 Nov 2026 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807620;
	bh=i067TMNpbiCFZjRbPWgGfWz2BpFhr8QyptRGWKajm4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngVGGr4AKLGCMjG4T3316urWRwW8furONFr6A0d/TYXhKeektVEWB46RmfMJzslIo
	 eyRcnS9jfgdqkIL175FqnrGSMmvXWZ9VyVgPMtEChdCCOQd+HVSj3i/0nBTmHUlHRV
	 86bta7usV0MoRvsOxCuVmbt4ZojTFr7nTp6U7bC3wKtGd0MlzNkfZgRhEmygVHsVau
	 xKL+Qj7ESubhogHWjOzmrmZxswjfA0tYQ1K9+QSrk7GGcdD0lSzLQRrrO5X52u9vGC
	 VH947ntDHB5fysao5IJusoaDUIX4ynQh3XmHSK54+N1PtGnRhB3IT9RktS5RMng2qN
	 2e82GWb3ZI+Gg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Dominique Belhachemi <db@domibel.de>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Joshua Peisach <jpeisach@ubuntu.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] clk: starfive: jh7110: Duplicate top clock bulk arrays per device
Date: Fri, 27 Nov 2026 19:25:28 +0000
Message-ID: <20261127192620.3443537-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127192620.3443537-1-lee@kernel.org>
References: <20261127192620.3443537-1-lee@kernel.org>
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

Both the JH7110 ISP and Video-Output clock drivers point top->top_clks
directly at static global struct clk_bulk_data arrays and pass them to
devm_clk_bulk_get(), mutating shared global state in place across probes
or unbind/rebind cycles.

Mark the template arrays const and allocate per-device copies with
devm_kmemdup_array().

Fixes: 81279f5d0812 ("clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver")
Fixes: dae5448a327e ("clk: starfive: Add StarFive JH7110 Video-Output clock driver")
Closes: https://sashiko.dev/#/bug/linux-ac62c6ac-f9af-4289-9154-e1129a2f6139
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/starfive/clk-starfive-jh7110-isp.c  | 9 +++++++--
 drivers/clk/starfive/clk-starfive-jh7110-vout.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
index d39ce4a2a8e9..9395de01d42b 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -23,7 +23,7 @@
 #define JH7110_ISPCLK_DVP_CLK			(JH7110_ISPCLK_END + 3)
 #define JH7110_ISPCLK_EXT_END			(JH7110_ISPCLK_END + 4)
 
-static struct clk_bulk_data jh7110_isp_top_clks[] = {
+static const struct clk_bulk_data jh7110_isp_top_clks[] = {
 	{ .id = "isp_top_core" },
 	{ .id = "isp_top_axi" }
 };
@@ -119,8 +119,13 @@ static int jh7110_ispcrg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	top->top_clks = jh7110_isp_top_clks;
 	top->top_clks_num = ARRAY_SIZE(jh7110_isp_top_clks);
+	top->top_clks = devm_kmemdup_array(priv->dev, jh7110_isp_top_clks,
+					   top->top_clks_num,
+					   sizeof(*top->top_clks), GFP_KERNEL);
+	if (!top->top_clks)
+		return -ENOMEM;
+
 	ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
 	if (ret)
 		return dev_err_probe(priv->dev, ret, "failed to get main clocks\n");
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index d4181cce9c15..8b4dbae372ee 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -25,7 +25,7 @@
 #define JH7110_VOUTCLK_HDMITX0_PIXELCLK		(JH7110_VOUTCLK_END + 5)
 #define JH7110_VOUTCLK_EXT_END			(JH7110_VOUTCLK_END + 6)
 
-static struct clk_bulk_data jh7110_vout_top_clks[] = {
+static const struct clk_bulk_data jh7110_vout_top_clks[] = {
 	{ .id = "vout_src" },
 	{ .id = "vout_top_ahb" }
 };
@@ -126,8 +126,13 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	top->top_clks = jh7110_vout_top_clks;
 	top->top_clks_num = ARRAY_SIZE(jh7110_vout_top_clks);
+	top->top_clks = devm_kmemdup_array(priv->dev, jh7110_vout_top_clks,
+					   top->top_clks_num,
+					   sizeof(*top->top_clks), GFP_KERNEL);
+	if (!top->top_clks)
+		return -ENOMEM;
+
 	ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
 	if (ret)
 		return dev_err_probe(priv->dev, ret, "failed to get top clocks\n");
-- 
2.56.1.839.g22a8290db9-goog

