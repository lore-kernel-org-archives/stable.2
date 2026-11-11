Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417121;
	b=sQgf2zCataMowcMvtYlCsTmujzEYPs4azdHPcSAj9j1sreI7voMSeeK6ZESwncHfw2fP
	 efFJMfTMCJbHZCPvo7wIL0ppySxP3yEzEwrjAjSlAvSvXATrtiOOhIWHVvAPgdadXpZa4
	 z4BRd9jlW+h2pv39Fb1o507wYHYI0jPSt0s1vlzGTyo1Ju4lFNoVW850SYMa63lFakat7
	 nXx8v0AdWhnseZLyfO0YlMGhIUGCx3/pnM9k+gfYBlumuEUkaQ4ijaapdggiY+5xWUBXx
	 zqKX7bQlUOIMBQK4qqyFBZlRP23AQWyWvw5wlc0ZVlOU7WkPJajreYJg0FIIHUcxB0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	b=bdG93WssATbvvS+V/kF/aZ4/s6fKlI/KiCWUC95w0YBEp93Oy3iMf5L1J33VH0EnqGK+
	 fAxp/laAouNol40gXyKpMF2WGPrFORObdzyS+dLSEwO8Mj+S1PcQkQmu/JHLQ/aGU9jWY
	 Ehi+PGkLtyM5r8s/1eCiLY2UsHAmci7s6y1Jiq0lng/UcLrEmtjAtouMV2NKKZ7iB0Zp3
	 jU/usX0k2CovZah1ekLeCHdQw3e1r8/Ii8UcmYx4adDLVfxSniUhQ/0YI0mrOvfe3tktM
	 NeGgyWmg5Q3aALRUVwAMmAdexCp+6p6Y4zy4n6JuehysLNvoekg6UCNPuuCiheYn5lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bx7lmm+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE04606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bx7lmm+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C4F1F00A06;
	Wed, 11 Nov 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417120;
	bh=97mLJIJnd3eL0q1fygrW3TE4YSosVo2xloVzW0QVbf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bx7lmm+ihhoKABU7f91Uwdvm+RWGi+Z+GM2gj0/AFKpHMkpcDMvlDX6yGz6ta6ill
	 hjMARUCc/LQTgMx9KyVg1I3HDE5G5CYfXq9QkR2aSrimNm4EmaCgxZMUSWW9wE4kV2
	 Gzd3encrYlhmrYodrkSwC9r9fXxp+9JUw8AXYzVlxwBRWhZUik8JKmTx1pbqcfnbqD
	 0mXF8svS/Lz+AEMwCnDhT/46/E/4F3iTKlebQV5rwhhccLTtqkZQ9A6DOtm6wkTqHX
	 KMQnNmuT2DPkzsHGdFqiEjh44+NIbeIJQLu49P2/5NpsqhJwP6aQ1QuldYxkS4j1br
	 nrZaQIGdjWPEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jacky Huang <ychuang570808@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:11:56 -0500
Message-ID: <20261111171146.3480409-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111171146.3480409-1-sashal@kernel.org>
References: <20261107051509-failed-6.18-1dc3871ce7ec@kernel.org>
 <20261111171146.3480409-1-sashal@kernel.org>
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

