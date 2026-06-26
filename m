Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D539F190;
	Fri, 26 Jun 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487219; cv=none; b=rBk9yAszNMvbmsovJiXgXz14RxunI/6LnO1KrJ8hT9xFwOkZhpd7HoxTUbv3wwg7J1mMveM5ftRQXQGWP+XGfwJLriw44+YGkGcfoF87BOHrMmfP4RDP/oAN/Vvrj6fAhfA7noDxDy0IHHKpJp2q6yvtcVsHVPY5lLVUq3CRneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487219; c=relaxed/simple;
	bh=bEOxE2KWspaDobBkImcKxUa9LvKft82/wWRecuS1mKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HH5juMSEV8eFYllL67Kja8KQ9gYlDfvwxYQtecBkx1ra/DUl6ZBojpIVLZWhZ+IwfkI3yFjdtS02RHQtg5cCERF0XI36H2iOasKbJ2lsCmj9i+ehtgfmiLO7Jk99eW8WGQsXw0vibHfCd6ffOp0s5LeEb8smBQI8Aa5AADvfTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHqdGqmD5qiOVrAw--.16632S2;
	Fri, 26 Jun 2026 23:20:11 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: mediatek: mtk_star_mdio_init: fix double of_node_put after   devm_of_mdiobus_register
Date: Fri, 26 Jun 2026 23:20:09 +0800
Message-Id: <20260626152009.51599-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHqdGqmD5qiOVrAw--.16632S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xWr4Duw4UKw1UtryxZrb_yoW8Gr17pw
	43Kayavr18Xr4Igw4kua1UZFy5Kan7K398Gr1avwsaq3Z5J34UJr40qayYqr1SyrWUG3ZI
	qr48Aw17uan5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeTmhDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAKA2o+idsp0AAAs6

After devm_of_mdiobus_register succeeds, the mdio_node reference
  ownership is transferred to the mii_bus device (released via
  mdiobus_release on device teardown). However, the function
  unconditionally calls of_node_put(mdio_node) after registration, causing
  a double put.

Only call of_node_put when devm_of_mdiobus_register fails (i.e., when
  ownership was not transferred). On success, the bus driver manages the
  reference lifecycle.

Cc: stable@vger.kernel.org
Fixes: 9ed0a3fac08b ("net: ethernet: mtk-star-emac: use devm_of_mdiobus_register()")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index b83886a41121..b949dd240e6b 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1446,7 +1446,10 @@ static int mtk_star_mdio_init(struct net_device *ndev)
 	priv->mii->priv = priv;
 
 	ret = devm_of_mdiobus_register(dev, priv->mii, mdio_node);
+	if (ret)
+		of_node_put(mdio_node);
 
+	return ret;
 out_put_node:
 	of_node_put(mdio_node);
 	return ret;
-- 
2.39.5 (Apple Git-154)

