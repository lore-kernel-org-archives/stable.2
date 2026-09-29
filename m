Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B23D47AB;
	Tue, 29 Sep 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693169; cv=none; b=A1tuyAIby7z8cPUrNoOzre+m7nEuecHszOh60ggtwBclZyu2pzjD+/o/ZghEJXnaEdKbbeH4AOBfxJMkGJq+2xKUjLgk42Hq5ImUQi14Zp2lRicp/LhFTo8ePuA81csB2zhM8T2La+GC22aCu7Tpkye/87tpOZ/uJpz2RuNtj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693169; c=relaxed/simple;
	bh=hOddkv3wWZtXaZfqX0yYJ42s1beC3q0ez+jj1Cgad+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VX6wrGfBJFCYoLJhY9ehIOwrjJ+9VmK4VGPhva5/Cs7yumRgx/LlJxTBFkcbXLL4w7NbSoRDg7mrSK7plRC08Xc/wfwFa5IVlNNvVKP+7X5BP7cDlDEgUsW9haW7BwuwJ+dX0h3s7zgiNAbrrjW/5mUgDfKyVt3rLRNKBLmmhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DdF4IGaW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DdF4IGaW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5E1DF4E410BE;
	Tue, 29 Sep 2026 14:45:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 31161601BD;
	Tue, 29 Sep 2026 14:45:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D2BE10329815;
	Tue, 29 Sep 2026 16:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790693149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PyZg4USpMlr6jxcqfj+x0kR3xC02mhWhTVwbkMQJqR8=;
	b=DdF4IGaWpj16WPBBZbzhFW60MRQgO8Uyjl/BsRQMbHSuBJy6FlWndqhAzHZxIsInFauBPu
	NOdl2fOgKvv/W2PHAto5kiNdGLUI86EEANId7dNkvZi5L7GhRfHL/zRE8JF/iWO9FhUGUu
	J07elF6syBB1ObM+DoqSFMtSXjUsZjKprxK1mdaVBbQPVuVyRJ9m0nn5Kdn+sBCs/YUZaq
	V51P5rlEzwnNtg8N9GGvD3gNT+DuL1kjzYajTaxCMlsCJX897ElXtZwwBUR9Exwg43GWJt
	fmbh7mAsErxySJ8+DVWhFGJJVqzOhYOUtR0i1cVm9Tu6uaM5sYPQr4DAzo0Hng==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 29 Sep 2026 16:44:49 +0200
Subject: [PATCH v5 6/9] clk: nuvoton: ma35d1: Use clk_hw pointers as mux
 parents
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-perso-ma35d1-upstream-clk-v5-6-68533e935ee4@bootlin.com>
References: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
In-Reply-To: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chi-Fang Li <cfli0@nuvoton.com>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The MA35D1 clock provider registers its muxes with parent data
structures filling .fw_name. This is not the ideal approach since that
would require a massive amount of internal clock names declaration in
the DT. Since the DT does not play the game of exposing all these names,
none of the parent lookups performed when instantiating the muxes
succeed. As a result, these muxes get registered as root clocks, leading
to a sadly flat clock tree and no frequency assigned to most of the
peripheral clocks:

                                 enable  prepare  protect
   clock                          count    count    count        rate

 usbphy1                             0       0        0        480000000
 usbphy0                             0       0        0        480000000
    husbh1_gate                      0       0        0        480000000
    husbh0_gate                      0       0        0        480000000
    usbh_gate                        0       0        0        480000000
    usbd_gate                        0       0        0        480000000
 syspll                              0       0        0        180000000
 lirc                                0       0        0        32000
    lirc_gate                        0       0        0        32000
 hirc                                0       0        0        12000000
    gtmr_gate                        0       0        0        12000000
    hirc_gate                        0       0        0        12000000
 lxt                                 0       0        0        32768
    rtc_gate                         0       0        0        32768
    lxt_gate                         0       0        0        32768
 hxt                                 0       0        0        24000000
    vpll                             0       0        0        1224000000
       dcup_div                      0       0        0        612000000
    epll                             0       0        0        6000000000
       epll_div8                     0       0        0        750000000

       epll_div4                     0       0        0        1500000000
       epll_div2                     0       0        0        3000000000
          emac1_gate                 0       0        0        3000000000

          emac0_gate                 0       0        0        3000000000

    apll                             0       0        0        6048000000
    ddrpll                           0       0        0        266460000
       ddr_gate                      0       0        0        266460000
       ddr6_gate                     0       0        0        266460000
       ddr0_gate                     0       0        0        266460000
    capll                            0       0        0        2400000000
    hxt_gate                         0       0        0        24000000
 clk_hxt                             0       0        0        24000000
 spi3_mux                            0       0        0        0
    spi3_gate                        0       0        0        0
 spi2_mux                            0       0        0        0
    spi2_gate                        0       0        0        0
 spi1_mux                            0       0        0        0
    spi1_gate                        0       0        0        0
 spi0_mux                            0       0        0        0
    spi0_gate                        0       0        0        0
 i2s1_mux                            0       0        0        0
    i2s1_gate                        0       0        0        0
 i2s0_mux                            0       0        0        0
    i2s0_gate                        0       0        0        0
...

Apart from the wrong clock tree representation, it means that none of
the device drivers (spi & i2c in the excerpt above) can actually query
their clock rate, or they would get 0Hz.

Instead of declaring the parents in the clk_parent_data structure, use
the actual HW clocks to lookup the parents directly: parents are
described by an array of indices into the controller's main clock table
(like in other clock controller drivers), which the "new" mux helper now
resolves.

The WDT and WWDT muxes list the /4096 children of PCLK3 and PCLK4 among
their possible parents. Those two clocks are now registered by the
previous commit, so their entries in the parent tables are restored
instead of being turned into invalid slots.

                                 enable  prepare  protect
   clock                          count    count    count        rate

 usbphy1                             0       0        0        480000000
 usbphy0                             0       0        0        480000000
    husbh1_gate                      0       0        0        480000000
    husbh0_gate                      0       0        0        480000000
    usbh_gate                        0       0        0        480000000
    usbd_gate                        0       0        0        480000000
 syspll                              1       1        0        180000000
    dbg_mux                          0       0        0        180000000
    sdh1_mux                         0       0        0        180000000
       sdh1_gate                     0       0        0        180000000
    sdh0_mux                         0       0        0        180000000
       sdh0_gate                     0       0        0        180000000
    sysclk1_mux                      2       2        0        180000000
       pclk4                         0       0        0        90000000
       pclk3                         0       0        0        90000000
          sspcc_gate                 0       0        0        90000000
          ssmcc_gate                 0       0        0        90000000
       hclk3                         0       0        0        90000000
       pclk2                         0       0        0        180000000
          eadc_div                   0       0        0        90000000
             eadc_gate               0       0        0        90000000
          qei1_gate                  0       0        0        180000000
          ecap1_gate                 0       0        0        180000000
          spi3_mux                   0       0        0        180000000
             spi3_gate               0       0        0        180000000
          spi1_mux                   0       0        0        180000000
             spi1_gate               0       0        0        180000000
          epwm1_gate                 0       0        0        180000000
          i2c5_gate                  0       0        0        180000000
          i2c2_gate                  0       0        0        180000000
       pclk1                         0       0        0        180000000
          qei2_gate                  0       0        0        180000000
          qei0_gate                  0       0        0        180000000
          ecap2_gate                 0       0        0        180000000
          ecap0_gate                 0       0        0        180000000
          spi2_mux                   0       0        0        180000000
             spi2_gate               0       0        0        180000000
          spi0_mux                   0       0        0        180000000
             spi0_gate               0       0        0        180000000
          epwm2_gate                 0       0        0        180000000
          epwm0_gate                 0       0        0        180000000
          i2c4_gate                  0       0        0        180000000
          i2c1_gate                  0       0        0        180000000
       pclk0                         1       1        0        180000000
          adc_div                    0       0        0        90000000
             adc_gate                0       0        0        90000000
          qspi1_mux                  0       0        0        180000000
             qspi1_gate              0       0        0        180000000
          qspi0_mux                  1       1        0        180000000
             qspi0_gate              1       1        0        180000000

          i2c3_gate                  0       0        0        180000000
          i2c0_gate                  0       0        0        180000000

Fixes: f50a000b4219 ("clk: nuvoton: Use clk_parent_data instead of string for parent clock")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 626 +++++++++++----------------------------
 1 file changed, 177 insertions(+), 449 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index c914079cee2d..1a857f28310f 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -63,300 +63,49 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 #define PLL_MODE_FRAC           1
 #define PLL_MODE_SS             2
 
-static const struct clk_parent_data ca35clk_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "capll", },
-	{ .fw_name = "ddrpll", },
-};
+#define MA35D1_MUX_MAX_PARENTS	10
 
-static const struct clk_parent_data sysclk0_sel_clks[] = {
-	{ .fw_name = "epll_div2", },
-	{ .fw_name = "syspll", },
-};
-
-static const struct clk_parent_data sysclk1_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "syspll", },
-};
-
-static const struct clk_parent_data axiclk_sel_clks[] = {
-	{ .fw_name = "capll_div2", },
-	{ .fw_name = "capll_div4", },
-};
-
-static const struct clk_parent_data ccap_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "vpll", },
-	{ .fw_name = "apll", },
-	{ .fw_name = "syspll", },
-};
-
-static const struct clk_parent_data sdh_sel_clks[] = {
-	{ .fw_name = "syspll", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data dcu_sel_clks[] = {
-	{ .fw_name = "epll_div2", },
-	{ .fw_name = "syspll", },
-};
-
-static const struct clk_parent_data gfx_sel_clks[] = {
-	{ .fw_name = "epll", },
-	{ .fw_name = "syspll", },
-};
-
-static const struct clk_parent_data dbg_sel_clks[] = {
-	{ .fw_name = "hirc", },
-	{ .fw_name = "syspll", },
-};
-
-static const struct clk_parent_data timer0_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk0", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer1_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk0", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer2_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk1", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer3_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk1", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer4_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk2", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer5_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk2", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer6_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk0", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer7_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk0", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer8_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk1", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer9_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk1", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer10_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk2", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data timer11_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk2", },
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "lirc", },
-	{ .index = -1, },
-	{ .fw_name = "hirc", },
-};
-
-static const struct clk_parent_data uart_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "sysclk1_div2", },
-};
-
-static const struct clk_parent_data wdt0_sel_clks[] = {
-	{ .index = -1, },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk3_div4096", },
-	{ .fw_name = "lirc", },
-};
-
-static const struct clk_parent_data wdt1_sel_clks[] = {
-	{ .index = -1, },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk3_div4096", },
-	{ .fw_name = "lirc", },
-};
-
-static const struct clk_parent_data wdt2_sel_clks[] = {
-	{ .index = -1, },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "pclk4_div4096", },
-	{ .fw_name = "lirc", },
-};
-
-static const struct clk_parent_data wwdt0_sel_clks[] = {
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "pclk3_div4096", },
-	{ .fw_name = "lirc", },
-};
-
-static const struct clk_parent_data wwdt1_sel_clks[] = {
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "pclk3_div4096", },
-	{ .fw_name = "lirc", },
-};
-
-static const struct clk_parent_data wwdt2_sel_clks[] = {
-	{ .index = -1, },
-	{ .index = -1, },
-	{ .fw_name = "pclk4_div4096", },
-	{ .fw_name = "lirc", },
-};
-
-static const struct clk_parent_data spi0_sel_clks[] = {
-	{ .fw_name = "pclk1", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data spi1_sel_clks[] = {
-	{ .fw_name = "pclk2", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data spi2_sel_clks[] = {
-	{ .fw_name = "pclk1", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data spi3_sel_clks[] = {
-	{ .fw_name = "pclk2", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data qspi0_sel_clks[] = {
-	{ .fw_name = "pclk0", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data qspi1_sel_clks[] = {
-	{ .fw_name = "pclk0", },
-	{ .fw_name = "apll", },
-};
-
-static const struct clk_parent_data i2s0_sel_clks[] = {
-	{ .fw_name = "apll", },
-	{ .fw_name = "sysclk1_div2", },
-};
-
-static const struct clk_parent_data i2s1_sel_clks[] = {
-	{ .fw_name = "apll", },
-	{ .fw_name = "sysclk1_div2", },
-};
-
-static const struct clk_parent_data can_sel_clks[] = {
-	{ .fw_name = "apll", },
-	{ .fw_name = "vpll", },
-};
-
-static const struct clk_parent_data cko_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-	{ .fw_name = "hirc", },
-	{ .fw_name = "lirc", },
-	{ .fw_name = "capll_div4", },
-	{ .fw_name = "syspll", },
-	{ .fw_name = "ddrpll", },
-	{ .fw_name = "epll_div2", },
-	{ .fw_name = "apll", },
-	{ .fw_name = "vpll", },
-};
-
-static const struct clk_parent_data smc_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "pclk4", },
-};
-
-static const struct clk_parent_data kpi_sel_clks[] = {
-	{ .fw_name = "hxt", },
-	{ .fw_name = "lxt", },
-};
+/* Mux parent selection, by index into the controller's clock table */
+static const int ca35clk_parent_idx[] = { HXT, CAPLL, DDRPLL };
+static const int sysclk0_parent_idx[] = { EPLL_DIV2, SYSPLL };
+static const int sysclk1_parent_idx[] = { HXT, SYSPLL };
+static const int axiclk_parent_idx[] = { AXICLK_DIV2, AXICLK_DIV4 };
+static const int ccap_parent_idx[] = { HXT, VPLL, APLL, SYSPLL };
+static const int sdh_parent_idx[] = { SYSPLL, APLL };
+static const int dcu_parent_idx[] = { EPLL_DIV2, SYSPLL };
+static const int gfx_parent_idx[] = { EPLL, SYSPLL };
+static const int dbg_parent_idx[] = { HIRC, SYSPLL };
+static const int timer0_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
+static const int timer1_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
+static const int timer2_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
+static const int timer3_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
+static const int timer4_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
+static const int timer5_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
+static const int timer6_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
+static const int timer7_parent_idx[] = { HXT, LXT, PCLK0, -1, -1, LIRC, -1, HIRC };
+static const int timer8_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
+static const int timer9_parent_idx[] = { HXT, LXT, PCLK1, -1, -1, LIRC, -1, HIRC };
+static const int timer10_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
+static const int timer11_parent_idx[] = { HXT, LXT, PCLK2, -1, -1, LIRC, -1, HIRC };
+static const int uart_parent_idx[] = { HXT, SYSCLK1_DIV2 };
+static const int wdt0_parent_idx[] = { -1, LXT, PCLK3_DIV4096, LIRC };
+static const int wdt1_parent_idx[] = { -1, LXT, PCLK3_DIV4096, LIRC };
+static const int wdt2_parent_idx[] = { -1, LXT, PCLK4_DIV4096, LIRC };
+static const int wwdt0_parent_idx[] = { -1, -1, PCLK3_DIV4096, LIRC };
+static const int wwdt1_parent_idx[] = { -1, -1, PCLK3_DIV4096, LIRC };
+static const int wwdt2_parent_idx[] = { -1, -1, PCLK4_DIV4096, LIRC };
+static const int spi0_parent_idx[] = { PCLK1, APLL };
+static const int spi1_parent_idx[] = { PCLK2, APLL };
+static const int spi2_parent_idx[] = { PCLK1, APLL };
+static const int spi3_parent_idx[] = { PCLK2, APLL };
+static const int qspi_parent_idx[] = { PCLK0, APLL };
+static const int i2s_parent_idx[] = { APLL, SYSCLK1_DIV2 };
+static const int can_parent_idx[] = { APLL, VPLL };
+static const int cko_parent_idx[] = { HXT, LXT, HIRC, LIRC,
+				      AXICLK_DIV4, SYSPLL, DDRPLL,
+				      EPLL_DIV2, APLL, VPLL };
+static const int smc_parent_idx[] = { HXT, PCLK4 };
+static const int kpi_parent_idx[] = { HXT, LXT };
 
 static const struct clk_div_table ip_div_table[] = {
 	{0, 2}, {1, 4}, {2, 6}, {3, 8}, {4, 10},
@@ -375,24 +124,20 @@ static struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
-static struct clk_hw *ma35d1_clk_mux_parent(struct device *dev, const char *name,
-					    void __iomem *reg, u8 shift, u8 width,
-					    const struct clk_parent_data *pdata,
-					    int num_pdata)
-{
-	return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
-					       CLK_SET_RATE_NO_REPARENT, reg, shift,
-					       width, 0, &ma35d1_lock);
-}
-
 static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
 				     void __iomem *reg, u8 shift, u8 width,
-				     const struct clk_parent_data *pdata,
-				     int num_pdata)
+				     struct clk_hw **hws,
+				     const int *parent_idx, int num_parents)
 {
-	return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
-					       CLK_SET_RATE_NO_REPARENT, reg, shift,
-					       width, 0, &ma35d1_lock);
+	const struct clk_hw *parent_hws[MA35D1_MUX_MAX_PARENTS] = {};
+	int i;
+
+	for (i = 0; i < num_parents; i++)
+		parent_hws[i] = (parent_idx[i] >= 0) ? hws[parent_idx[i]] : NULL;
+
+	return clk_hw_register_mux_hws(dev, name, parent_hws, num_parents,
+				       CLK_SET_RATE_NO_REPARENT, reg, shift,
+				       width, 0, &ma35d1_lock);
 }
 
 static struct clk_hw *ma35d1_clk_divider(struct device *dev, const char *name,
@@ -515,22 +260,17 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EPLL_DIV4] = ma35d1_clk_fixed_factor(dev, "epll_div4", "epll", 1, 4);
 	hws[EPLL_DIV8] = ma35d1_clk_fixed_factor(dev, "epll_div8", "epll", 1, 8);
 
-	hws[CA35CLK_MUX] = ma35d1_clk_mux_parent(dev, "ca35clk_mux",
-						 clk_base + REG_CLK_CLKSEL0, 0, 2,
-						 ca35clk_sel_clks,
-						 ARRAY_SIZE(ca35clk_sel_clks));
+	hws[CA35CLK_MUX] = ma35d1_clk_mux(dev, "ca35clk_mux", clk_base + REG_CLK_CLKSEL0, 0, 2, hws,
+					  ca35clk_parent_idx, ARRAY_SIZE(ca35clk_parent_idx));
 	hws[AXICLK_DIV2] = ma35d1_clk_fixed_factor(dev, "capll_div2", "ca35clk_mux", 1, 2);
 	hws[AXICLK_DIV4] = ma35d1_clk_fixed_factor(dev, "capll_div4", "ca35clk_mux", 1, 4);
 
-	hws[AXICLK_MUX] = ma35d1_clk_mux(dev, "axiclk_mux", clk_base + REG_CLK_CLKDIV0,
-					 26, 1, axiclk_sel_clks,
-					 ARRAY_SIZE(axiclk_sel_clks));
-	hws[SYSCLK0_MUX] = ma35d1_clk_mux(dev, "sysclk0_mux", clk_base + REG_CLK_CLKSEL0,
-					  2, 1, sysclk0_sel_clks,
-					  ARRAY_SIZE(sysclk0_sel_clks));
-	hws[SYSCLK1_MUX] = ma35d1_clk_mux(dev, "sysclk1_mux", clk_base + REG_CLK_CLKSEL0,
-					  4, 1, sysclk1_sel_clks,
-					  ARRAY_SIZE(sysclk1_sel_clks));
+	hws[AXICLK_MUX] = ma35d1_clk_mux(dev, "axiclk_mux", clk_base + REG_CLK_CLKDIV0, 26, 1, hws,
+					 axiclk_parent_idx, ARRAY_SIZE(axiclk_parent_idx));
+	hws[SYSCLK0_MUX] = ma35d1_clk_mux(dev, "sysclk0_mux", clk_base + REG_CLK_CLKSEL0, 2, 1, hws,
+					  sysclk0_parent_idx, ARRAY_SIZE(sysclk0_parent_idx));
+	hws[SYSCLK1_MUX] = ma35d1_clk_mux(dev, "sysclk1_mux", clk_base + REG_CLK_CLKSEL0, 4, 1, hws,
+					  sysclk1_parent_idx, ARRAY_SIZE(sysclk1_parent_idx));
 	hws[SYSCLK1_DIV2] = ma35d1_clk_fixed_factor(dev, "sysclk1_div2", "sysclk1_mux", 1, 2);
 
 	/* HCLK0~3 & PCLK0~4 */
@@ -556,41 +296,41 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[DDR6_GATE] = ma35d1_clk_gate(dev, "ddr6_gate", "ddrpll",
 					 clk_base + REG_CLK_SYSCLK0, 5);
 
-	hws[CAN0_MUX] = ma35d1_clk_mux(dev, "can0_mux", clk_base + REG_CLK_CLKSEL4,
-				       16, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+	hws[CAN0_MUX] = ma35d1_clk_mux(dev, "can0_mux", clk_base + REG_CLK_CLKSEL4, 16, 1, hws,
+				       can_parent_idx, ARRAY_SIZE(can_parent_idx));
 	hws[CAN0_DIV] = ma35d1_clk_divider_table(dev, "can0_div", "can0_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 0, 3, ip_div_table);
 	hws[CAN0_GATE] = ma35d1_clk_gate(dev, "can0_gate", "can0_div",
 					 clk_base + REG_CLK_SYSCLK0, 8);
-	hws[CAN1_MUX] = ma35d1_clk_mux(dev, "can1_mux", clk_base + REG_CLK_CLKSEL4,
-				       17, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+	hws[CAN1_MUX] = ma35d1_clk_mux(dev, "can1_mux", clk_base + REG_CLK_CLKSEL4, 17, 1, hws,
+				       can_parent_idx, ARRAY_SIZE(can_parent_idx));
 	hws[CAN1_DIV] = ma35d1_clk_divider_table(dev, "can1_div", "can1_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 4, 3, ip_div_table);
 	hws[CAN1_GATE] = ma35d1_clk_gate(dev, "can1_gate", "can1_div",
 					 clk_base + REG_CLK_SYSCLK0, 9);
-	hws[CAN2_MUX] = ma35d1_clk_mux(dev, "can2_mux", clk_base + REG_CLK_CLKSEL4,
-				       18, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+	hws[CAN2_MUX] = ma35d1_clk_mux(dev, "can2_mux", clk_base + REG_CLK_CLKSEL4, 18, 1, hws,
+				       can_parent_idx, ARRAY_SIZE(can_parent_idx));
 	hws[CAN2_DIV] = ma35d1_clk_divider_table(dev, "can2_div", "can2_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 8, 3, ip_div_table);
 	hws[CAN2_GATE] = ma35d1_clk_gate(dev, "can2_gate", "can2_div",
 					 clk_base + REG_CLK_SYSCLK0, 10);
-	hws[CAN3_MUX] = ma35d1_clk_mux(dev, "can3_mux", clk_base + REG_CLK_CLKSEL4,
-				       19, 1, can_sel_clks, ARRAY_SIZE(can_sel_clks));
+	hws[CAN3_MUX] = ma35d1_clk_mux(dev, "can3_mux", clk_base + REG_CLK_CLKSEL4, 19, 1, hws,
+				       can_parent_idx, ARRAY_SIZE(can_parent_idx));
 	hws[CAN3_DIV] = ma35d1_clk_divider_table(dev, "can3_div", "can3_mux",
 						 clk_base + REG_CLK_CLKDIV0,
 						 12, 3, ip_div_table);
 	hws[CAN3_GATE] = ma35d1_clk_gate(dev, "can3_gate", "can3_div",
 					 clk_base + REG_CLK_SYSCLK0, 11);
 
-	hws[SDH0_MUX] = ma35d1_clk_mux(dev, "sdh0_mux", clk_base + REG_CLK_CLKSEL0,
-				       16, 2, sdh_sel_clks, ARRAY_SIZE(sdh_sel_clks));
+	hws[SDH0_MUX] = ma35d1_clk_mux(dev, "sdh0_mux", clk_base + REG_CLK_CLKSEL0, 16, 2, hws,
+				       sdh_parent_idx, ARRAY_SIZE(sdh_parent_idx));
 	hws[SDH0_GATE] = ma35d1_clk_gate(dev, "sdh0_gate", "sdh0_mux",
 					 clk_base + REG_CLK_SYSCLK0, 16);
-	hws[SDH1_MUX] = ma35d1_clk_mux(dev, "sdh1_mux", clk_base + REG_CLK_CLKSEL0,
-				       18, 2, sdh_sel_clks, ARRAY_SIZE(sdh_sel_clks));
+	hws[SDH1_MUX] = ma35d1_clk_mux(dev, "sdh1_mux", clk_base + REG_CLK_CLKSEL0, 18, 2, hws,
+				       sdh_parent_idx, ARRAY_SIZE(sdh_parent_idx));
 	hws[SDH1_GATE] = ma35d1_clk_gate(dev, "sdh1_gate", "sdh1_mux",
 					 clk_base + REG_CLK_SYSCLK0, 17);
 
@@ -606,14 +346,14 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[HUSBH1_GATE] = ma35d1_clk_gate(dev, "husbh1_gate", "usbphy0",
 					   clk_base + REG_CLK_SYSCLK0, 22);
 
-	hws[GFX_MUX] = ma35d1_clk_mux(dev, "gfx_mux", clk_base + REG_CLK_CLKSEL0,
-				      26, 1, gfx_sel_clks, ARRAY_SIZE(gfx_sel_clks));
+	hws[GFX_MUX] = ma35d1_clk_mux(dev, "gfx_mux", clk_base + REG_CLK_CLKSEL0, 26, 1, hws,
+				      gfx_parent_idx, ARRAY_SIZE(gfx_parent_idx));
 	hws[GFX_GATE] = ma35d1_clk_gate(dev, "gfx_gate", "gfx_mux",
 					clk_base + REG_CLK_SYSCLK0, 24);
 	hws[VC8K_GATE] = ma35d1_clk_gate(dev, "vc8k_gate", "sysclk0_mux",
 					 clk_base + REG_CLK_SYSCLK0, 25);
-	hws[DCU_MUX] = ma35d1_clk_mux(dev, "dcu_mux", clk_base + REG_CLK_CLKSEL0,
-				      24, 1, dcu_sel_clks, ARRAY_SIZE(dcu_sel_clks));
+	hws[DCU_MUX] = ma35d1_clk_mux(dev, "dcu_mux", clk_base + REG_CLK_CLKSEL0, 24, 1, hws,
+				      dcu_parent_idx, ARRAY_SIZE(dcu_parent_idx));
 	hws[DCU_GATE] = ma35d1_clk_gate(dev, "dcu_gate", "dcu_mux",
 					clk_base + REG_CLK_SYSCLK0, 26);
 	hws[DCUP_DIV] = ma35d1_clk_divider_table(dev, "dcup_div", "vpll",
@@ -625,14 +365,14 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EMAC1_GATE] = ma35d1_clk_gate(dev, "emac1_gate", "epll_div2",
 					  clk_base + REG_CLK_SYSCLK0, 28);
 
-	hws[CCAP0_MUX] = ma35d1_clk_mux(dev, "ccap0_mux", clk_base + REG_CLK_CLKSEL0,
-					12, 1, ccap_sel_clks, ARRAY_SIZE(ccap_sel_clks));
+	hws[CCAP0_MUX] = ma35d1_clk_mux(dev, "ccap0_mux", clk_base + REG_CLK_CLKSEL0, 12, 1, hws,
+					ccap_parent_idx, ARRAY_SIZE(ccap_parent_idx));
 	hws[CCAP0_DIV] = ma35d1_clk_divider(dev, "ccap0_div", "ccap0_mux",
 					    clk_base + REG_CLK_CLKDIV1, 8, 4);
 	hws[CCAP0_GATE] = ma35d1_clk_gate(dev, "ccap0_gate", "ccap0_div",
 					  clk_base + REG_CLK_SYSCLK0, 29);
-	hws[CCAP1_MUX] = ma35d1_clk_mux(dev, "ccap1_mux", clk_base + REG_CLK_CLKSEL0,
-					14, 1, ccap_sel_clks, ARRAY_SIZE(ccap_sel_clks));
+	hws[CCAP1_MUX] = ma35d1_clk_mux(dev, "ccap1_mux", clk_base + REG_CLK_CLKSEL0, 14, 1, hws,
+					ccap_parent_idx, ARRAY_SIZE(ccap_parent_idx));
 	hws[CCAP1_DIV] = ma35d1_clk_divider(dev, "ccap1_div", "ccap1_mux",
 					    clk_base + REG_CLK_CLKDIV1,
 					    12, 4);
@@ -670,13 +410,13 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[TRA_GATE] = ma35d1_clk_gate(dev, "tra_gate", "hclk0",
 					clk_base + REG_CLK_SYSCLK1, 11);
 
-	hws[DBG_MUX] = ma35d1_clk_mux(dev, "dbg_mux", clk_base + REG_CLK_CLKSEL0,
-				      27, 1, dbg_sel_clks, ARRAY_SIZE(dbg_sel_clks));
+	hws[DBG_MUX] = ma35d1_clk_mux(dev, "dbg_mux", clk_base + REG_CLK_CLKSEL0, 27, 1, hws,
+				      dbg_parent_idx, ARRAY_SIZE(dbg_parent_idx));
 	hws[DBG_GATE] = ma35d1_clk_gate(dev, "dbg_gate", "hclk0",
 					clk_base + REG_CLK_SYSCLK1, 12);
 
-	hws[CKO_MUX] = ma35d1_clk_mux(dev, "cko_mux", clk_base + REG_CLK_CLKSEL4,
-				      24, 4, cko_sel_clks, ARRAY_SIZE(cko_sel_clks));
+	hws[CKO_MUX] = ma35d1_clk_mux(dev, "cko_mux", clk_base + REG_CLK_CLKSEL4, 24, 4, hws,
+				      cko_parent_idx, ARRAY_SIZE(cko_parent_idx));
 	hws[CKO_DIV] = ma35d1_clk_divider_pow2(dev, "cko_div", "cko_mux",
 					       clk_base + REG_CLK_CLKOCTL, 0, 4);
 	hws[CKO_GATE] = ma35d1_clk_gate(dev, "cko_gate", "cko_div",
@@ -714,181 +454,169 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[GPN_GATE] = ma35d1_clk_gate(dev, "gpn_gate", "hclk0",
 					clk_base + REG_CLK_SYSCLK1, 29);
 
-	hws[TMR0_MUX] = ma35d1_clk_mux(dev, "tmr0_mux", clk_base + REG_CLK_CLKSEL1,
-				       0, 3, timer0_sel_clks,
-				       ARRAY_SIZE(timer0_sel_clks));
+	hws[TMR0_MUX] = ma35d1_clk_mux(dev, "tmr0_mux", clk_base + REG_CLK_CLKSEL1, 0, 3, hws,
+				       timer0_parent_idx, ARRAY_SIZE(timer0_parent_idx));
 	hws[TMR0_GATE] = ma35d1_clk_gate(dev, "tmr0_gate", "tmr0_mux",
 					 clk_base + REG_CLK_APBCLK0, 0);
-	hws[TMR1_MUX] = ma35d1_clk_mux(dev, "tmr1_mux", clk_base + REG_CLK_CLKSEL1,
-				       4, 3, timer1_sel_clks,
-				       ARRAY_SIZE(timer1_sel_clks));
+	hws[TMR1_MUX] = ma35d1_clk_mux(dev, "tmr1_mux", clk_base + REG_CLK_CLKSEL1, 4, 3, hws,
+				       timer1_parent_idx, ARRAY_SIZE(timer1_parent_idx));
 	hws[TMR1_GATE] = ma35d1_clk_gate(dev, "tmr1_gate", "tmr1_mux",
 					 clk_base + REG_CLK_APBCLK0, 1);
-	hws[TMR2_MUX] = ma35d1_clk_mux(dev, "tmr2_mux", clk_base + REG_CLK_CLKSEL1,
-				       8, 3, timer2_sel_clks,
-				       ARRAY_SIZE(timer2_sel_clks));
+	hws[TMR2_MUX] = ma35d1_clk_mux(dev, "tmr2_mux", clk_base + REG_CLK_CLKSEL1, 8, 3, hws,
+				       timer2_parent_idx, ARRAY_SIZE(timer2_parent_idx));
 	hws[TMR2_GATE] = ma35d1_clk_gate(dev, "tmr2_gate", "tmr2_mux",
 					 clk_base + REG_CLK_APBCLK0, 2);
-	hws[TMR3_MUX] = ma35d1_clk_mux(dev, "tmr3_mux", clk_base + REG_CLK_CLKSEL1,
-				       12, 3, timer3_sel_clks,
-				       ARRAY_SIZE(timer3_sel_clks));
+	hws[TMR3_MUX] = ma35d1_clk_mux(dev, "tmr3_mux", clk_base + REG_CLK_CLKSEL1, 12, 3, hws,
+				       timer3_parent_idx, ARRAY_SIZE(timer3_parent_idx));
 	hws[TMR3_GATE] = ma35d1_clk_gate(dev, "tmr3_gate", "tmr3_mux",
 					 clk_base + REG_CLK_APBCLK0, 3);
-	hws[TMR4_MUX] = ma35d1_clk_mux(dev, "tmr4_mux", clk_base + REG_CLK_CLKSEL1,
-				       16, 3, timer4_sel_clks,
-				       ARRAY_SIZE(timer4_sel_clks));
+	hws[TMR4_MUX] = ma35d1_clk_mux(dev, "tmr4_mux", clk_base + REG_CLK_CLKSEL1, 16, 3, hws,
+				       timer4_parent_idx, ARRAY_SIZE(timer4_parent_idx));
 	hws[TMR4_GATE] = ma35d1_clk_gate(dev, "tmr4_gate", "tmr4_mux",
 					 clk_base + REG_CLK_APBCLK0, 4);
-	hws[TMR5_MUX] = ma35d1_clk_mux(dev, "tmr5_mux", clk_base + REG_CLK_CLKSEL1,
-				       20, 3, timer5_sel_clks,
-				       ARRAY_SIZE(timer5_sel_clks));
+	hws[TMR5_MUX] = ma35d1_clk_mux(dev, "tmr5_mux", clk_base + REG_CLK_CLKSEL1, 20, 3, hws,
+				       timer5_parent_idx, ARRAY_SIZE(timer5_parent_idx));
 	hws[TMR5_GATE] = ma35d1_clk_gate(dev, "tmr5_gate", "tmr5_mux",
 					 clk_base + REG_CLK_APBCLK0, 5);
-	hws[TMR6_MUX] = ma35d1_clk_mux(dev, "tmr6_mux", clk_base + REG_CLK_CLKSEL1,
-				       24, 3, timer6_sel_clks,
-				       ARRAY_SIZE(timer6_sel_clks));
+	hws[TMR6_MUX] = ma35d1_clk_mux(dev, "tmr6_mux", clk_base + REG_CLK_CLKSEL1, 24, 3, hws,
+				       timer6_parent_idx, ARRAY_SIZE(timer6_parent_idx));
 	hws[TMR6_GATE] = ma35d1_clk_gate(dev, "tmr6_gate", "tmr6_mux",
 					 clk_base + REG_CLK_APBCLK0, 6);
-	hws[TMR7_MUX] = ma35d1_clk_mux(dev, "tmr7_mux", clk_base + REG_CLK_CLKSEL1,
-				       28, 3, timer7_sel_clks,
-				       ARRAY_SIZE(timer7_sel_clks));
+	hws[TMR7_MUX] = ma35d1_clk_mux(dev, "tmr7_mux", clk_base + REG_CLK_CLKSEL1, 28, 3, hws,
+				       timer7_parent_idx, ARRAY_SIZE(timer7_parent_idx));
 	hws[TMR7_GATE] = ma35d1_clk_gate(dev, "tmr7_gate", "tmr7_mux",
 					 clk_base + REG_CLK_APBCLK0, 7);
-	hws[TMR8_MUX] = ma35d1_clk_mux(dev, "tmr8_mux", clk_base + REG_CLK_CLKSEL2,
-				       0, 3, timer8_sel_clks,
-				       ARRAY_SIZE(timer8_sel_clks));
+	hws[TMR8_MUX] = ma35d1_clk_mux(dev, "tmr8_mux", clk_base + REG_CLK_CLKSEL2, 0, 3, hws,
+				       timer8_parent_idx, ARRAY_SIZE(timer8_parent_idx));
 	hws[TMR8_GATE] = ma35d1_clk_gate(dev, "tmr8_gate", "tmr8_mux",
 					 clk_base + REG_CLK_APBCLK0, 8);
-	hws[TMR9_MUX] = ma35d1_clk_mux(dev, "tmr9_mux", clk_base + REG_CLK_CLKSEL2,
-				       4, 3, timer9_sel_clks,
-				       ARRAY_SIZE(timer9_sel_clks));
+	hws[TMR9_MUX] = ma35d1_clk_mux(dev, "tmr9_mux", clk_base + REG_CLK_CLKSEL2, 4, 3, hws,
+				       timer9_parent_idx, ARRAY_SIZE(timer9_parent_idx));
 	hws[TMR9_GATE] = ma35d1_clk_gate(dev, "tmr9_gate", "tmr9_mux",
 					 clk_base + REG_CLK_APBCLK0, 9);
-	hws[TMR10_MUX] = ma35d1_clk_mux(dev, "tmr10_mux", clk_base + REG_CLK_CLKSEL2,
-					8, 3, timer10_sel_clks,
-					ARRAY_SIZE(timer10_sel_clks));
+	hws[TMR10_MUX] = ma35d1_clk_mux(dev, "tmr10_mux", clk_base + REG_CLK_CLKSEL2, 8, 3, hws,
+					timer10_parent_idx, ARRAY_SIZE(timer10_parent_idx));
 	hws[TMR10_GATE] = ma35d1_clk_gate(dev, "tmr10_gate", "tmr10_mux",
 					  clk_base + REG_CLK_APBCLK0, 10);
-	hws[TMR11_MUX] = ma35d1_clk_mux(dev, "tmr11_mux", clk_base + REG_CLK_CLKSEL2,
-					12, 3, timer11_sel_clks,
-					ARRAY_SIZE(timer11_sel_clks));
+	hws[TMR11_MUX] = ma35d1_clk_mux(dev, "tmr11_mux", clk_base + REG_CLK_CLKSEL2, 12, 3, hws,
+					timer11_parent_idx, ARRAY_SIZE(timer11_parent_idx));
 	hws[TMR11_GATE] = ma35d1_clk_gate(dev, "tmr11_gate", "tmr11_mux",
 					  clk_base + REG_CLK_APBCLK0, 11);
 
-	hws[UART0_MUX] = ma35d1_clk_mux(dev, "uart0_mux", clk_base + REG_CLK_CLKSEL2,
-					16, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART0_MUX] = ma35d1_clk_mux(dev, "uart0_mux", clk_base + REG_CLK_CLKSEL2, 16, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART0_DIV] = ma35d1_clk_divider(dev, "uart0_div", "uart0_mux",
 					    clk_base + REG_CLK_CLKDIV1,
 					    16, 4);
 	hws[UART0_GATE] = ma35d1_clk_gate(dev, "uart0_gate", "uart0_div",
 					  clk_base + REG_CLK_APBCLK0, 12);
-	hws[UART1_MUX] = ma35d1_clk_mux(dev, "uart1_mux", clk_base + REG_CLK_CLKSEL2,
-					18, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART1_MUX] = ma35d1_clk_mux(dev, "uart1_mux", clk_base + REG_CLK_CLKSEL2, 18, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART1_DIV] = ma35d1_clk_divider(dev, "uart1_div", "uart1_mux",
 					    clk_base + REG_CLK_CLKDIV1,
 					    20, 4);
 	hws[UART1_GATE] = ma35d1_clk_gate(dev, "uart1_gate", "uart1_div",
 					  clk_base + REG_CLK_APBCLK0, 13);
-	hws[UART2_MUX] = ma35d1_clk_mux(dev, "uart2_mux", clk_base + REG_CLK_CLKSEL2,
-					20, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART2_MUX] = ma35d1_clk_mux(dev, "uart2_mux", clk_base + REG_CLK_CLKSEL2, 20, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART2_DIV] = ma35d1_clk_divider(dev, "uart2_div", "uart2_mux",
 					    clk_base + REG_CLK_CLKDIV1,
 					    24, 4);
 	hws[UART2_GATE] = ma35d1_clk_gate(dev, "uart2_gate", "uart2_div",
 					  clk_base + REG_CLK_APBCLK0, 14);
-	hws[UART3_MUX] = ma35d1_clk_mux(dev, "uart3_mux", clk_base + REG_CLK_CLKSEL2,
-					22, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART3_MUX] = ma35d1_clk_mux(dev, "uart3_mux", clk_base + REG_CLK_CLKSEL2, 22, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART3_DIV] = ma35d1_clk_divider(dev, "uart3_div", "uart3_mux",
 					    clk_base + REG_CLK_CLKDIV1,
 					    28, 4);
 	hws[UART3_GATE] = ma35d1_clk_gate(dev, "uart3_gate", "uart3_div",
 					  clk_base + REG_CLK_APBCLK0, 15);
-	hws[UART4_MUX] = ma35d1_clk_mux(dev, "uart4_mux", clk_base + REG_CLK_CLKSEL2,
-					24, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART4_MUX] = ma35d1_clk_mux(dev, "uart4_mux", clk_base + REG_CLK_CLKSEL2, 24, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART4_DIV] = ma35d1_clk_divider(dev, "uart4_div", "uart4_mux",
 					    clk_base + REG_CLK_CLKDIV2,
 					    0, 4);
 	hws[UART4_GATE] = ma35d1_clk_gate(dev, "uart4_gate", "uart4_div",
 					  clk_base + REG_CLK_APBCLK0, 16);
-	hws[UART5_MUX] = ma35d1_clk_mux(dev, "uart5_mux", clk_base + REG_CLK_CLKSEL2,
-					26, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART5_MUX] = ma35d1_clk_mux(dev, "uart5_mux", clk_base + REG_CLK_CLKSEL2, 26, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART5_DIV] = ma35d1_clk_divider(dev, "uart5_div", "uart5_mux",
 					    clk_base + REG_CLK_CLKDIV2,
 					    4, 4);
 	hws[UART5_GATE] = ma35d1_clk_gate(dev, "uart5_gate", "uart5_div",
 					  clk_base + REG_CLK_APBCLK0, 17);
-	hws[UART6_MUX] = ma35d1_clk_mux(dev, "uart6_mux", clk_base + REG_CLK_CLKSEL2,
-					28, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART6_MUX] = ma35d1_clk_mux(dev, "uart6_mux", clk_base + REG_CLK_CLKSEL2, 28, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART6_DIV] = ma35d1_clk_divider(dev, "uart6_div", "uart6_mux",
 					    clk_base + REG_CLK_CLKDIV2,
 					    8, 4);
 	hws[UART6_GATE] = ma35d1_clk_gate(dev, "uart6_gate", "uart6_div",
 					  clk_base + REG_CLK_APBCLK0, 18);
-	hws[UART7_MUX] = ma35d1_clk_mux(dev, "uart7_mux", clk_base + REG_CLK_CLKSEL2,
-					30, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART7_MUX] = ma35d1_clk_mux(dev, "uart7_mux", clk_base + REG_CLK_CLKSEL2, 30, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART7_DIV] = ma35d1_clk_divider(dev, "uart7_div", "uart7_mux",
 					    clk_base + REG_CLK_CLKDIV2,
 					    12, 4);
 	hws[UART7_GATE] = ma35d1_clk_gate(dev, "uart7_gate", "uart7_div",
 					  clk_base + REG_CLK_APBCLK0, 19);
-	hws[UART8_MUX] = ma35d1_clk_mux(dev, "uart8_mux", clk_base + REG_CLK_CLKSEL3,
-					0, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART8_MUX] = ma35d1_clk_mux(dev, "uart8_mux", clk_base + REG_CLK_CLKSEL3, 0, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART8_DIV] = ma35d1_clk_divider(dev, "uart8_div", "uart8_mux",
 					    clk_base + REG_CLK_CLKDIV2,
 					    16, 4);
 	hws[UART8_GATE] = ma35d1_clk_gate(dev, "uart8_gate", "uart8_div",
 					  clk_base + REG_CLK_APBCLK0, 20);
-	hws[UART9_MUX] = ma35d1_clk_mux(dev, "uart9_mux", clk_base + REG_CLK_CLKSEL3,
-					2, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART9_MUX] = ma35d1_clk_mux(dev, "uart9_mux", clk_base + REG_CLK_CLKSEL3, 2, 2, hws,
+					uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART9_DIV] = ma35d1_clk_divider(dev, "uart9_div", "uart9_mux",
 					    clk_base + REG_CLK_CLKDIV2,
 					    20, 4);
 	hws[UART9_GATE] = ma35d1_clk_gate(dev, "uart9_gate", "uart9_div",
 					  clk_base + REG_CLK_APBCLK0, 21);
-	hws[UART10_MUX] = ma35d1_clk_mux(dev, "uart10_mux", clk_base + REG_CLK_CLKSEL3,
-					 4, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART10_MUX] = ma35d1_clk_mux(dev, "uart10_mux", clk_base + REG_CLK_CLKSEL3, 4, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART10_DIV] = ma35d1_clk_divider(dev, "uart10_div", "uart10_mux",
 					     clk_base + REG_CLK_CLKDIV2,
 					     24, 4);
 	hws[UART10_GATE] = ma35d1_clk_gate(dev, "uart10_gate", "uart10_div",
 					   clk_base + REG_CLK_APBCLK0, 22);
-	hws[UART11_MUX] = ma35d1_clk_mux(dev, "uart11_mux", clk_base + REG_CLK_CLKSEL3,
-					 6, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART11_MUX] = ma35d1_clk_mux(dev, "uart11_mux", clk_base + REG_CLK_CLKSEL3, 6, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART11_DIV] = ma35d1_clk_divider(dev, "uart11_div", "uart11_mux",
 					     clk_base + REG_CLK_CLKDIV2,
 					     28, 4);
 	hws[UART11_GATE] = ma35d1_clk_gate(dev, "uart11_gate", "uart11_div",
 					   clk_base + REG_CLK_APBCLK0, 23);
-	hws[UART12_MUX] = ma35d1_clk_mux(dev, "uart12_mux", clk_base + REG_CLK_CLKSEL3,
-					 8, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART12_MUX] = ma35d1_clk_mux(dev, "uart12_mux", clk_base + REG_CLK_CLKSEL3, 8, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART12_DIV] = ma35d1_clk_divider(dev, "uart12_div", "uart12_mux",
 					     clk_base + REG_CLK_CLKDIV3,
 					     0, 4);
 	hws[UART12_GATE] = ma35d1_clk_gate(dev, "uart12_gate", "uart12_div",
 					   clk_base + REG_CLK_APBCLK0, 24);
-	hws[UART13_MUX] = ma35d1_clk_mux(dev, "uart13_mux", clk_base + REG_CLK_CLKSEL3,
-					 10, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART13_MUX] = ma35d1_clk_mux(dev, "uart13_mux", clk_base + REG_CLK_CLKSEL3, 10, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART13_DIV] = ma35d1_clk_divider(dev, "uart13_div", "uart13_mux",
 					     clk_base + REG_CLK_CLKDIV3,
 					     4, 4);
 	hws[UART13_GATE] = ma35d1_clk_gate(dev, "uart13_gate", "uart13_div",
 					   clk_base + REG_CLK_APBCLK0, 25);
-	hws[UART14_MUX] = ma35d1_clk_mux(dev, "uart14_mux", clk_base + REG_CLK_CLKSEL3,
-					 12, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART14_MUX] = ma35d1_clk_mux(dev, "uart14_mux", clk_base + REG_CLK_CLKSEL3, 12, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART14_DIV] = ma35d1_clk_divider(dev, "uart14_div", "uart14_mux",
 					     clk_base + REG_CLK_CLKDIV3,
 					     8, 4);
 	hws[UART14_GATE] = ma35d1_clk_gate(dev, "uart14_gate", "uart14_div",
 					   clk_base + REG_CLK_APBCLK0, 26);
-	hws[UART15_MUX] = ma35d1_clk_mux(dev, "uart15_mux", clk_base + REG_CLK_CLKSEL3,
-					 14, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART15_MUX] = ma35d1_clk_mux(dev, "uart15_mux", clk_base + REG_CLK_CLKSEL3, 14, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART15_DIV] = ma35d1_clk_divider(dev, "uart15_div", "uart15_mux",
 					     clk_base + REG_CLK_CLKDIV3,
 					     12, 4);
 	hws[UART15_GATE] = ma35d1_clk_gate(dev, "uart15_gate", "uart15_div",
 					   clk_base + REG_CLK_APBCLK0, 27);
-	hws[UART16_MUX] = ma35d1_clk_mux(dev, "uart16_mux", clk_base + REG_CLK_CLKSEL3,
-					 16, 2, uart_sel_clks, ARRAY_SIZE(uart_sel_clks));
+	hws[UART16_MUX] = ma35d1_clk_mux(dev, "uart16_mux", clk_base + REG_CLK_CLKSEL3, 16, 2, hws,
+					 uart_parent_idx, ARRAY_SIZE(uart_parent_idx));
 	hws[UART16_DIV] = ma35d1_clk_divider(dev, "uart16_div", "uart16_mux",
 					     clk_base + REG_CLK_CLKDIV3,
 					     16, 4);
@@ -900,8 +628,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[DDR_GATE] = ma35d1_clk_gate(dev, "ddr_gate", "ddrpll",
 					clk_base + REG_CLK_APBCLK0, 30);
 
-	hws[KPI_MUX] = ma35d1_clk_mux(dev, "kpi_mux", clk_base + REG_CLK_CLKSEL4,
-				      30, 1, kpi_sel_clks, ARRAY_SIZE(kpi_sel_clks));
+	hws[KPI_MUX] = ma35d1_clk_mux(dev, "kpi_mux", clk_base + REG_CLK_CLKSEL4, 30, 1, hws,
+				      kpi_parent_idx, ARRAY_SIZE(kpi_parent_idx));
 	hws[KPI_DIV] = ma35d1_clk_divider(dev, "kpi_div", "kpi_mux",
 					  clk_base + REG_CLK_CLKDIV4,
 					  24, 8);
@@ -921,49 +649,49 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[I2C5_GATE] = ma35d1_clk_gate(dev, "i2c5_gate", "pclk2",
 					 clk_base + REG_CLK_APBCLK1, 5);
 
-	hws[QSPI0_MUX] = ma35d1_clk_mux(dev, "qspi0_mux", clk_base + REG_CLK_CLKSEL4,
-					8, 2, qspi0_sel_clks, ARRAY_SIZE(qspi0_sel_clks));
+	hws[QSPI0_MUX] = ma35d1_clk_mux(dev, "qspi0_mux", clk_base + REG_CLK_CLKSEL4, 8, 2, hws,
+					qspi_parent_idx, ARRAY_SIZE(qspi_parent_idx));
 	hws[QSPI0_GATE] = ma35d1_clk_gate(dev, "qspi0_gate", "qspi0_mux",
 					  clk_base + REG_CLK_APBCLK1, 6);
-	hws[QSPI1_MUX] = ma35d1_clk_mux(dev, "qspi1_mux", clk_base + REG_CLK_CLKSEL4,
-					10, 2, qspi1_sel_clks, ARRAY_SIZE(qspi1_sel_clks));
+	hws[QSPI1_MUX] = ma35d1_clk_mux(dev, "qspi1_mux", clk_base + REG_CLK_CLKSEL4, 10, 2, hws,
+					qspi_parent_idx, ARRAY_SIZE(qspi_parent_idx));
 	hws[QSPI1_GATE] = ma35d1_clk_gate(dev, "qspi1_gate", "qspi1_mux",
 					  clk_base + REG_CLK_APBCLK1, 7);
 
-	hws[SMC0_MUX] = ma35d1_clk_mux(dev, "smc0_mux", clk_base + REG_CLK_CLKSEL4,
-					28, 1, smc_sel_clks, ARRAY_SIZE(smc_sel_clks));
+	hws[SMC0_MUX] = ma35d1_clk_mux(dev, "smc0_mux", clk_base + REG_CLK_CLKSEL4, 28, 1, hws,
+				       smc_parent_idx, ARRAY_SIZE(smc_parent_idx));
 	hws[SMC0_DIV] = ma35d1_clk_divider(dev, "smc0_div", "smc0_mux",
 					   clk_base + REG_CLK_CLKDIV1,
 					   0, 4);
 	hws[SMC0_GATE] = ma35d1_clk_gate(dev, "smc0_gate", "smc0_div",
 					 clk_base + REG_CLK_APBCLK1, 12);
-	hws[SMC1_MUX] = ma35d1_clk_mux(dev, "smc1_mux", clk_base + REG_CLK_CLKSEL4,
-					 29, 1, smc_sel_clks, ARRAY_SIZE(smc_sel_clks));
+	hws[SMC1_MUX] = ma35d1_clk_mux(dev, "smc1_mux", clk_base + REG_CLK_CLKSEL4, 29, 1, hws,
+				       smc_parent_idx, ARRAY_SIZE(smc_parent_idx));
 	hws[SMC1_DIV] = ma35d1_clk_divider(dev, "smc1_div", "smc1_mux",
 					   clk_base + REG_CLK_CLKDIV1,
 					   4, 4);
 	hws[SMC1_GATE] = ma35d1_clk_gate(dev, "smc1_gate", "smc1_div",
 					 clk_base + REG_CLK_APBCLK1, 13);
 
-	hws[WDT0_MUX] = ma35d1_clk_mux(dev, "wdt0_mux", clk_base + REG_CLK_CLKSEL3,
-				       20, 2, wdt0_sel_clks, ARRAY_SIZE(wdt0_sel_clks));
+	hws[WDT0_MUX] = ma35d1_clk_mux(dev, "wdt0_mux", clk_base + REG_CLK_CLKSEL3, 20, 2, hws,
+				       wdt0_parent_idx, ARRAY_SIZE(wdt0_parent_idx));
 	hws[WDT0_GATE] = ma35d1_clk_gate(dev, "wdt0_gate", "wdt0_mux",
 					 clk_base + REG_CLK_APBCLK1, 16);
-	hws[WDT1_MUX] = ma35d1_clk_mux(dev, "wdt1_mux", clk_base + REG_CLK_CLKSEL3,
-				       24, 2, wdt1_sel_clks, ARRAY_SIZE(wdt1_sel_clks));
+	hws[WDT1_MUX] = ma35d1_clk_mux(dev, "wdt1_mux", clk_base + REG_CLK_CLKSEL3, 24, 2, hws,
+				       wdt1_parent_idx, ARRAY_SIZE(wdt1_parent_idx));
 	hws[WDT1_GATE] = ma35d1_clk_gate(dev, "wdt1_gate", "wdt1_mux",
 					 clk_base + REG_CLK_APBCLK1, 17);
-	hws[WDT2_MUX] = ma35d1_clk_mux(dev, "wdt2_mux", clk_base + REG_CLK_CLKSEL3,
-				       28, 2, wdt2_sel_clks, ARRAY_SIZE(wdt2_sel_clks));
+	hws[WDT2_MUX] = ma35d1_clk_mux(dev, "wdt2_mux", clk_base + REG_CLK_CLKSEL3, 28, 2, hws,
+				       wdt2_parent_idx, ARRAY_SIZE(wdt2_parent_idx));
 	hws[WDT2_GATE] = ma35d1_clk_gate(dev, "wdt2_gate", "wdt2_mux",
 				       clk_base + REG_CLK_APBCLK1, 18);
 
-	hws[WWDT0_MUX] = ma35d1_clk_mux(dev, "wwdt0_mux", clk_base + REG_CLK_CLKSEL3,
-					22, 2, wwdt0_sel_clks, ARRAY_SIZE(wwdt0_sel_clks));
-	hws[WWDT1_MUX] = ma35d1_clk_mux(dev, "wwdt1_mux", clk_base + REG_CLK_CLKSEL3,
-					26, 2, wwdt1_sel_clks, ARRAY_SIZE(wwdt1_sel_clks));
-	hws[WWDT2_MUX] = ma35d1_clk_mux(dev, "wwdt2_mux", clk_base + REG_CLK_CLKSEL3,
-					30, 2, wwdt2_sel_clks, ARRAY_SIZE(wwdt2_sel_clks));
+	hws[WWDT0_MUX] = ma35d1_clk_mux(dev, "wwdt0_mux", clk_base + REG_CLK_CLKSEL3, 22, 2, hws,
+					wwdt0_parent_idx, ARRAY_SIZE(wwdt0_parent_idx));
+	hws[WWDT1_MUX] = ma35d1_clk_mux(dev, "wwdt1_mux", clk_base + REG_CLK_CLKSEL3, 26, 2, hws,
+					wwdt1_parent_idx, ARRAY_SIZE(wwdt1_parent_idx));
+	hws[WWDT2_MUX] = ma35d1_clk_mux(dev, "wwdt2_mux", clk_base + REG_CLK_CLKSEL3, 30, 2, hws,
+					wwdt2_parent_idx, ARRAY_SIZE(wwdt2_parent_idx));
 
 	hws[EPWM0_GATE] = ma35d1_clk_gate(dev, "epwm0_gate", "pclk1",
 					  clk_base + REG_CLK_APBCLK1, 24);
@@ -972,12 +700,12 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EPWM2_GATE] = ma35d1_clk_gate(dev, "epwm2_gate", "pclk1",
 					  clk_base + REG_CLK_APBCLK1, 26);
 
-	hws[I2S0_MUX] = ma35d1_clk_mux(dev, "i2s0_mux", clk_base + REG_CLK_CLKSEL4,
-				       12, 2, i2s0_sel_clks, ARRAY_SIZE(i2s0_sel_clks));
+	hws[I2S0_MUX] = ma35d1_clk_mux(dev, "i2s0_mux", clk_base + REG_CLK_CLKSEL4, 12, 2, hws,
+				       i2s_parent_idx, ARRAY_SIZE(i2s_parent_idx));
 	hws[I2S0_GATE] = ma35d1_clk_gate(dev, "i2s0_gate", "i2s0_mux",
 					 clk_base + REG_CLK_APBCLK2, 0);
-	hws[I2S1_MUX] = ma35d1_clk_mux(dev, "i2s1_mux", clk_base + REG_CLK_CLKSEL4,
-				       14, 2, i2s1_sel_clks, ARRAY_SIZE(i2s1_sel_clks));
+	hws[I2S1_MUX] = ma35d1_clk_mux(dev, "i2s1_mux", clk_base + REG_CLK_CLKSEL4, 14, 2, hws,
+				       i2s_parent_idx, ARRAY_SIZE(i2s_parent_idx));
 	hws[I2S1_GATE] = ma35d1_clk_gate(dev, "i2s1_gate", "i2s1_mux",
 					 clk_base + REG_CLK_APBCLK2, 1);
 
@@ -986,20 +714,20 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[SSPCC_GATE] = ma35d1_clk_gate(dev, "sspcc_gate", "pclk3",
 					  clk_base + REG_CLK_APBCLK2, 3);
 
-	hws[SPI0_MUX] = ma35d1_clk_mux(dev, "spi0_mux", clk_base + REG_CLK_CLKSEL4,
-				       0, 2, spi0_sel_clks, ARRAY_SIZE(spi0_sel_clks));
+	hws[SPI0_MUX] = ma35d1_clk_mux(dev, "spi0_mux", clk_base + REG_CLK_CLKSEL4, 0, 2, hws,
+				       spi0_parent_idx, ARRAY_SIZE(spi0_parent_idx));
 	hws[SPI0_GATE] = ma35d1_clk_gate(dev, "spi0_gate", "spi0_mux",
 					 clk_base + REG_CLK_APBCLK2, 4);
-	hws[SPI1_MUX] = ma35d1_clk_mux(dev, "spi1_mux", clk_base + REG_CLK_CLKSEL4,
-				       2, 2, spi1_sel_clks, ARRAY_SIZE(spi1_sel_clks));
+	hws[SPI1_MUX] = ma35d1_clk_mux(dev, "spi1_mux", clk_base + REG_CLK_CLKSEL4, 2, 2, hws,
+				       spi1_parent_idx, ARRAY_SIZE(spi1_parent_idx));
 	hws[SPI1_GATE] = ma35d1_clk_gate(dev, "spi1_gate", "spi1_mux",
 					 clk_base + REG_CLK_APBCLK2, 5);
-	hws[SPI2_MUX] = ma35d1_clk_mux(dev, "spi2_mux", clk_base + REG_CLK_CLKSEL4,
-				       4, 2, spi2_sel_clks, ARRAY_SIZE(spi2_sel_clks));
+	hws[SPI2_MUX] = ma35d1_clk_mux(dev, "spi2_mux", clk_base + REG_CLK_CLKSEL4, 4, 2, hws,
+				       spi2_parent_idx, ARRAY_SIZE(spi2_parent_idx));
 	hws[SPI2_GATE] = ma35d1_clk_gate(dev, "spi2_gate", "spi2_mux",
 					 clk_base + REG_CLK_APBCLK2, 6);
-	hws[SPI3_MUX] = ma35d1_clk_mux(dev, "spi3_mux", clk_base + REG_CLK_CLKSEL4,
-				       6, 2, spi3_sel_clks, ARRAY_SIZE(spi3_sel_clks));
+	hws[SPI3_MUX] = ma35d1_clk_mux(dev, "spi3_mux", clk_base + REG_CLK_CLKSEL4, 6, 2, hws,
+				       spi3_parent_idx, ARRAY_SIZE(spi3_parent_idx));
 	hws[SPI3_GATE] = ma35d1_clk_gate(dev, "spi3_gate", "spi3_mux",
 					 clk_base + REG_CLK_APBCLK2, 7);
 

-- 
2.55.0

