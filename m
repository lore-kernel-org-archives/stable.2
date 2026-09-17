Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060E4D2ED8;
	Thu, 17 Sep 2026 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645032; cv=none; b=M8V6iGbOCiRVV3xI0mL7Pe85mjDEtknBfKVVrUYaVWW4NKf5IF7t0Y7ovRVoTk7Z5LHo9kqf9AYYJ9Ein0/+BO5kC89UE7Fo+lnzgCkJUbKeP3JjRl+gYRTbfzVgFe74ZNoGOXFr3oZegHqGXeG4eNS1zeFG1ZVijVywioooBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645032; c=relaxed/simple;
	bh=Wcr4n+AA427t8C01cZCI3uB+FbcFP5+u2Cp3I9g9a+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1wghx7w2TomDkegUUp0nH4KDHmpqIRIyUa5lq6/ipziZrZH85hUVl4a9vUSC+WnZG/dl9TIz+D3zAvNFh6hbue0fwTZSAqdefSNM8vOo0HH+WYIH4jmgZVXU+IAoQoFLHXqNJgzPBZaK/Y0nT8gUoFEiEeFhia/YbjN7HZYhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHKkPW0Ktqj7F_CA--.42390S2;
	Thu, 17 Sep 2026 19:36:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexandre.torgue@foss.st.com
Cc: andrew+netdev@lunn.ch,
	clabbe.montjoie@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	jernej.skrabec@gmail.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	samuel@sholland.org,
	wens@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: stmmac: dwmac-sun8i: Fix EPHY clock leak in get_ephy_nodes()
Date: Thu, 17 Sep 2026 11:36:54 +0000
Message-Id: <20260917113654.2149268-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHKkPW0Ktqj7F_CA--.42390S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45tF4rKFW8AFW8Jry5Jwb_yoW8Aryfpr
	Z7uFyYv34fArWSg3Z8tr1UZF98Zay2qF4rGr1ftan3Canayayjv34a9Fy5XFn8AF4rWa4a
	qr48G3Z3C3WDArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUVpBTUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq016GgAAsS

get_ephy_nodes() stores the clock returned by of_clk_get() directly in
gmac->ephy_clk before the reset control is obtained. When the reset
lookup fails, the loop continues or returns without releasing that
clock, and sun8i_dwmac_probe() then jumps to dwmac_remove, which does
not call clk_put(). Keep the clock in a local variable and release it
on the error paths.

Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb96233..38d7e71de925 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -783,18 +783,22 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 
 	/* Seek for internal PHY */
 	for_each_child_of_node_scoped(mdio_internal, iphynode) {
-		gmac->ephy_clk = of_clk_get(iphynode, 0);
-		if (IS_ERR(gmac->ephy_clk))
+		struct clk *ephy_clk;
+
+		ephy_clk = of_clk_get(iphynode, 0);
+		if (IS_ERR(ephy_clk))
 			continue;
 		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);
+			clk_put(ephy_clk);
 			if (ret == -EPROBE_DEFER) {
 				of_node_put(mdio_internal);
 				return ret;
 			}
 			continue;
 		}
+		gmac->ephy_clk = ephy_clk;
 		dev_info(priv->device, "Found internal PHY node\n");
 		of_node_put(mdio_internal);
 		return 0;
-- 
2.34.1

