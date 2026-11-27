Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807647;
	b=chVJT9wMimckH9JXMkLECL4jabuXZuaeOUW69fr10EQ4vxVCQ4mNkD1d+JUcJ1pxrdnC
	 sK5Cq36kV986FFs/DRNkMagSOZHVjAEadkTS0E44VvSI/5SeThBaNCII3sjPxaVUPMymT
	 V/nHDwo0V51QXdx0JDEVLTtMCB9Qk9ig41f2rGhResU4hU1XQ2pvyxsuE5LHd1LoNCeJL
	 tD/zfXO/Ovsgl2DZ4Zct6NNoTQySx4CU4GTzbsdocXsxBl1gYuRuwum9yr9AIGYVOtGvK
	 JTBnPQgE5W2/zZRUFV2lpBA3zoR8kewU+dj48SSaAgZSSPL/270TwhEw3ZT3ojkFYPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=10bVaCEGsM4jeEOParKEyBgQviJ8LhkcZZpLkWasWow=;
	b=aGBboxDGUx11/vhEDDOFia6IS+U2ke8KMwOwW42fI/3+Eybg6mwfZkKWTnvaW7DzOdoq
	 z7Ueheb/PA3CA2ZixPmnNls+4MRM59wmJY7+/aNyMlbKZOZGkVieYFuMXZIQUwhoPV4hc
	 n4112GZBE0qv/nH4iSnlx3GYZ5ZtXFh3Y0sYrnTVmS1W/bKuH7IM6VRRbdqDMwH/nk7Qs
	 HJPfIXcr90SEpc5gnjiRPHStxjyZNrL5+M1uFb1opf65AJvqqyuETsIpfe2LBl8Oy+Pct
	 +foTcY/84LtW+jbp4DeV6FLERXpLS+x78Ecm8Z36A5aHa1YmdZFEmS7DGiQtgIIKYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFhtSUVm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D0606A31E;
	Fri, 27 Nov 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFhtSUVm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B3D1F0089A;
	Fri, 27 Nov 2026 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807646;
	bh=10bVaCEGsM4jeEOParKEyBgQviJ8LhkcZZpLkWasWow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFhtSUVmQojxt9ECMPMTYut1MMVZr+G3hcue4763XqNsevx8dB5z1qJG5GqRf06Yw
	 m3nKCKXy6Uj+/P8lFF1WwToi/uSNoR9gvhYy+CRQobgerGNZfRXiOUwEeVYWFJsEtJ
	 vb1vhFCV1voVugoNQC+lrtL5HSlCGs39wVFQpLGd1lX+57b9RhYVJM4XvDVYCzJLVg
	 qjA3Ca9B8DjAEIJa+CdeiAYHqyu8M3LX9iuP2TDA6oteiwWo1tupa7bIS3GRS41Yx4
	 YcFwR4jJ/tWb7XAdep7UkvTGgRdsixvCLaS24crSsk/iQhg99dAcBjI07/hOf1pg17
	 8tK9qN0MgX3vg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] clk: rp1: Reference secondary PLL divider clk_hw in parent tables
Date: Fri, 27 Nov 2026 19:25:32 +0000
Message-ID: <20261127192620.3443537-9-lee@kernel.org>
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

rp1_register_pll_divider() registers &desc->div.hw rather than
&desc->hw, leaving desc->hw.core NULL for the secondary PLL dividers
pll_sys_sec_desc, pll_video_sec_desc, and pll_audio_sec_desc.  Fourteen
clock parent table entries still reference &pll_*_sec_desc.hw instead of
&pll_*_sec_desc.div.hw, causing parent resolution to fail for those
clocks.

Point all fourteen parent entries at .div.hw, matching clk_eth_parents.

Fixes: a7713a7dd159 ("clk: rp1: Implement remaining clock tree")
Closes: https://sashiko.dev/#/bug/linux-4497e5e9-4f3a-4398-8f6a-f2d72a2b61eb
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-rp1.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
index cfa7cbefad2e..d5d94d699829 100644
--- a/drivers/clk/clk-rp1.c
+++ b/drivers/clk/clk-rp1.c
@@ -1419,7 +1419,7 @@ static struct rp1_clk_desc pll_video_sec_desc = REGISTER_PLL_DIV(
 
 static const struct clk_parent_data clk_eth_tsu_parents[] = {
 	{ .index = 0 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .index = -1 },
 	{ .index = -1 },
 	{ .index = -1 },
@@ -1450,7 +1450,7 @@ static struct rp1_clk_desc clk_eth_tsu_desc = REGISTER_CLK(
 static const struct clk_parent_data clk_eth_parents[] = {
 	{ .hw = &pll_sys_sec_desc.div.hw },
 	{ .hw = &pll_sys_desc.hw },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 };
 
 static struct rp1_clk_desc clk_eth_desc = REGISTER_CLK(
@@ -1651,7 +1651,7 @@ static struct rp1_clk_desc clk_uart_desc = REGISTER_CLK(
 
 static const struct clk_parent_data clk_pwm0_parents[] = {
 	{ .index = -1 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .index = 0 },
 };
 
@@ -1677,7 +1677,7 @@ static struct rp1_clk_desc clk_pwm0_desc = REGISTER_CLK(
 
 static const struct clk_parent_data clk_pwm1_parents[] = {
 	{ .index = -1 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .index = 0 },
 };
 
@@ -1705,7 +1705,7 @@ static const struct clk_parent_data clk_audio_in_parents[] = {
 	{ .index = -1 },
 	{ .index = -1 },
 	{ .index = -1 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .index = 0 },
 };
 
@@ -1731,7 +1731,7 @@ static struct rp1_clk_desc clk_audio_in_desc = REGISTER_CLK(
 static const struct clk_parent_data clk_audio_out_parents[] = {
 	{ .index = -1 },
 	{ .index = -1 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .index = 0 },
 };
 
@@ -1757,7 +1757,7 @@ static struct rp1_clk_desc clk_audio_out_desc = REGISTER_CLK(
 static const struct clk_parent_data clk_i2s_parents[] = {
 	{ .index = 0 },
 	{ .hw = &pll_audio_desc.hw },
-	{ .hw = &pll_audio_sec_desc.hw },
+	{ .hw = &pll_audio_sec_desc.div.hw },
 };
 
 static struct rp1_clk_desc clk_i2s_desc = REGISTER_CLK(
@@ -1879,7 +1879,7 @@ static struct rp1_clk_desc clk_sdio_alt_src_desc = REGISTER_CLK(
 
 static const struct clk_parent_data clk_dpi_parents[] = {
 	{ .hw = &pll_sys_desc.hw },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .hw = &pll_video_desc.hw },
 	{ .index = -1 },
 	{ .index = -1 },
@@ -2015,7 +2015,7 @@ static struct rp1_clk_desc clksrc_mipi1_dsi_byteclk_desc = REGISTER_CLK(
 
 static const struct clk_parent_data clk_mipi0_dpi_parents[] = {
 	{ .hw = &pll_sys_desc.hw },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .hw = &pll_video_desc.hw },
 	{ .hw = &clksrc_mipi0_dsi_byteclk_desc.hw },
 	{ .index = -1 },
@@ -2046,7 +2046,7 @@ static struct rp1_clk_desc clk_mipi0_dpi_desc = REGISTER_CLK(
 
 static const struct clk_parent_data clk_mipi1_dpi_parents[] = {
 	{ .hw = &pll_sys_desc.hw },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .hw = &pll_video_desc.hw },
 	{ .hw = &clksrc_mipi1_dsi_byteclk_desc.hw },
 	{ .index = -1 },
@@ -2082,7 +2082,7 @@ static const struct clk_parent_data clk_gp2_parents[] = {
 	{ .index = -1 },
 	{ .index = -1 },
 	{ .index = -1 },
-	{ .hw = &pll_sys_sec_desc.hw },
+	{ .hw = &pll_sys_sec_desc.div.hw },
 	{ .index = -1 },
 	{ .hw = &pll_video_desc.hw },
 	{ .hw = &clk_audio_in_desc.hw },
@@ -2163,7 +2163,7 @@ static const struct clk_parent_data clk_gp4_parents[] = {
 	{ .index = -1 },
 	{ .index = -1 },
 	{ .index = -1 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .index = -1 },
 	{ .index = -1 },
 	{ .index = -1 },
@@ -2197,7 +2197,7 @@ static struct rp1_clk_desc clk_gp4_desc = REGISTER_CLK(
 
 static const struct clk_parent_data clk_vec_parents[] = {
 	{ .hw = &pll_sys_pri_ph_desc.hw },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .hw = &pll_video_desc.hw },
 	{ .index = -1 },
 	{ .index = -1 },
@@ -2233,7 +2233,7 @@ static const struct clk_parent_data clk_gp5_parents[] = {
 	{ .index = -1 },
 	{ .index = -1 },
 	{ .index = -1 },
-	{ .hw = &pll_video_sec_desc.hw },
+	{ .hw = &pll_video_sec_desc.div.hw },
 	{ .hw = &clk_eth_tsu_desc.hw },
 	{ .index = -1 },
 	{ .hw = &clk_vec_desc.hw },
-- 
2.56.1.839.g22a8290db9-goog

