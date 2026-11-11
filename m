Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417705;
	b=uyUpBX9dvmp36ro5YMClfWcYYYK1XPcwpy6EK5TzglpCWy60TwcLPeXqdOnrcfH44DEh
	 X+9w/HMlwQlYaa2mHH7NeLUdLvD0hlA4QvrYPMfunq1FHLxsoZNbwh4+jmg1hAThamrdq
	 /G7n9D9wvTIwbU2F80J3dNzGWJNQ4oDYrZ1xatzlbYI0jcMiW7yBngvSDGfNN79Tn0mgm
	 6g0qTaZ9D6lEW55SmWkJMFJGZEsag5zXxp+7oiKkK6lW/vvIq2v7w5+DQKJWFmKMi2S1f
	 JrQZ7snv1urBCl/hR1Yro8gvMoSYaoa90c1JFmqHKLujfurtuk28rCf9pcwxCfcPmiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	b=semxf/TJatxlHwduJWNDGPRBtWcL1ssHxiLMSn3Mwi0t+dpcLKgoR5l98WtPPNMZKKzE
	 NK/eGX2RQdkXFmtyZHjge4/2bNux+Tu87/7OX01HA+aouD+vD0IN3f9Ckws03CuKht9T0
	 FZioOQFK1fzXknepigVmmy66JHM1DDZ09cJ1zscJAK1yJuJp5xceKI4OLEyNtnryyDcwL
	 yVq0taIBqzKhBBrVGH79bvy7TVrrrlB033MDzZRdRRk8cFjdO9yu8VYbg1BzRNypXd5ya
	 z/qTBHWzjXTX/iDjKs8aNtCjL2WCE5DYCmxPCo9aDE1P8uDb4euSeLl5qkUBq16BrFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOyKPnTQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB3606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOyKPnTQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8161F00A05;
	Wed, 11 Nov 2026 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417705;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOyKPnTQUjBsFdWaZjgJ3qISSl5VupA2c7JBQgMeloI2KcgLAqmdGVKibNfpqpzMU
	 SA3rZLxYPhG90I+MaytfzWKmmAb8FuTxdshIAueBYZDCu9jGtGL4fGK/ci+BfyFCNb
	 rc77GIrSWfgInMX8iLSWnMw4IGpXMO6+DDdJzQtPSqQb8PVK8sx+tReZADtEb6L+sO
	 kwi5GtfmD5LDc6Nwf1mg3ZSTRhM8Ne03Zt/XlEGUCE/AEzGWVVswL2l/frA987aTPq
	 YXftQo8ig1U7d1vbpoyXP63LmkrDSTHiBWtBcPWKaX5mOYjZbImFuiPHoZwsf+ERFe
	 r0Fbq+nrvMHPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jacky Huang <ychuang570808@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:21:41 -0500
Message-ID: <20261111172129.3551299-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111172129.3551299-1-sashal@kernel.org>
References: <20261107053946-failed-6.6-1dc3871ce7ec@kernel.org>
 <20261111172129.3551299-1-sashal@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 1dc3871ce7ec819030c22297f8960c61cc42a990 ]

The WDT and WWDT muxes list PCLK3/4096 and PCLK4/4096 among their
possible parents, but the driver never registers the corresponding
clocks, so these parents could never be used.

Add pclk3_div4096 and pclk4_div4096 as fixed factor children of pclk3
and pclk4 and expose them through the clock provider.

Reported-by: Jacky Huang <ychuang570808@gmail.com>
Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com/
Suggested-by: Jacky Huang <ychuang570808@gmail.com>
Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-5-48937ee6c9bb@bootlin.com
[jbrunet@baylibre.com: removed stale link trailer]
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 6aa42a3e1be3b..c914079cee2d4 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -17,7 +17,7 @@
 static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define PLL_MAX_NUM		5
-#define	MA35D1_CLK_COUNT	236
+#define	MA35D1_CLK_COUNT	238
 
 /* Clock Control Registers Offset */
 #define REG_CLK_PWRCTL		0x00
@@ -544,6 +544,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[HCLK3] = ma35d1_clk_fixed_factor(dev, "hclk3", "sysclk1_mux", 1, 2);
 	hws[PCLK3] = ma35d1_clk_fixed_factor(dev, "pclk3", "sysclk1_mux", 1, 2);
 	hws[PCLK4] = ma35d1_clk_fixed_factor(dev, "pclk4", "sysclk1_mux", 1, 2);
+	hws[PCLK3_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk3_div4096", "pclk3", 1, 4096);
+	hws[PCLK4_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk4_div4096", "pclk4", 1, 4096);
 
 	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000);
 	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000);
-- 
2.53.0

