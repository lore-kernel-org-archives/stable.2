Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416793;
	b=i7AuydPqg6a4aK5GD6jzJYHX2Uson8Nw4apY7TV2TgozbmlNF/Q08y26sg7jgk8ZwFUA
	 Hevj81K2cBrNLWDBz1LhGRk7PweC6iBJs9RGaSYXCJ3B91L1X89wtCkfXkEnoIrYhrHrM
	 J08w561Ty6cX3I2BN0dVXClCqRyxEKaxYFlmcLrKzqvFb7rAqFO53BU8XP0og+2/m9F1Q
	 j/qM059ZVFKlvoC1OYNIsBxgRvTSn1CYwqLROwarN36oyrTFGXqXbpIj+Sl7gNZap6ePl
	 6OOtj0FoXrrBHe9zR15xkBScE9HkbDK00O13BU1leuQzWZvR2ihxcHrbahVksRRGHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	b=UjHYEI8+h22xzLJNnr6uHubA9J5mqMsUNztF6hDXl0zpnwR4EkFMVOEYSJeCx/Sql7bR
	 UWOWYvv1L7oGKIhXPVq4zqg7DaApuVta2cuE86No35LkrTGiiG0dX88Ic4F6ION0cvxeo
	 uCaeuWsw084Rlp7ixCuxpNdZLxyvcSCPwpfx3qtZI5VYzPhAy2xGcNJ27iGZ/+QssvIyE
	 tQuTL2pa8z+x+SqmG4r3CoNf7WPyiaen1gFVfCkISf/owFeQ7TMm2mA1cI//tW6Pm6xWC
	 axXmORLvnyJTxpNbCbGIBXk/R3b35iDX6TkkDY2qNRB9kIgz4zQKi6JBtOXE37w8ZTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfWMiPn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32EB606A898
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfWMiPn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D496E1F00A05;
	Wed, 11 Nov 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416793;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LfWMiPn3aPwcTQCNNx8UwSANYwy8zvb0yeOVxELHfHX98gnbAarUDpdFjLlITuGTm
	 /bBBN9A/vRqDw6YxcYyoV5Vn6MQExbgfKzFHwElkyOyyoi0mZUZV2vu4SrA3avDtpg
	 g2mVtheIeomv5fV4XPXQ0SBQ/p4sew+KDwZBThK0xvRs5Z3TekINsBY9y2f2r0lDL9
	 f4j25U7xnZvb1uykGRRDFKAy94uMyWLs6obPONgY7Sm8sZjXQAeSqXsjrnIMUOHDp8
	 grndasynL4V54dHifz6FVkiNynGhCWse0bVDw1eWapOlNfuknb2LvoEKlkic+Bvffj
	 ub5fJoelMyMGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jacky Huang <ychuang570808@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 4/4] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:06:29 -0500
Message-ID: <20261111170618.3423248-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111170618.3423248-1-sashal@kernel.org>
References: <20261107050550-failed-7.3-1dc3871ce7ec@kernel.org>
 <20261111170618.3423248-1-sashal@kernel.org>
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

