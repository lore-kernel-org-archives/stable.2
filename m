Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D325332E;
	Tue,  9 Jun 2026 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992802; cv=none; b=netYQ3eWYbVbllr6eSh5UqfmPZ+0uJLUFeTpYVVfWGuzVoQoyTXHuflmZ1fwuxLvBDt7hXbkuxpToZGVTMYJfemgaTyE5GLlhJjvIFLKnW3YRooy6wXgSPfCagK+BMECMeSUxMOl8BjXlyVZSXXhblYKPfojGgxuNJ+qn4/Iht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992802; c=relaxed/simple;
	bh=pxlmxIEaTwoefr00RQFlFivTxHVpQz8xXMFmZbXYXBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/0d7l/hwCu+fNGM0cGu4KYmvx60IDfwOzX2tnR9p1kXpkxh6zqktI7EWfL2ElKKJBjSWU1ox6J0HXgSPCo0AYChFmmGq6O/HKRH5gJL47L9eeGf6xwdYixuAqzJhIL9b0nXP6tZSj/b+CuJ5E/p7ur6NrzEFh20uaUraFfQBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnAdUTyydqqErOEg--.7605S2;
	Tue, 09 Jun 2026 16:13:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: ethernet: mediatek: fix refcount leak in mtk_probe()
Date: Tue,  9 Jun 2026 08:13:00 +0000
Message-Id: <20260609081300.208168-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnAdUTyydqqErOEg--.7605S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DuF1rXFyDZr1xtry7Jrb_yoW8Jw4kpr
	WUtayUCF95Jr13Ga1kua18XF1rAayrKry5Gr15Zw1fZ3s0yrW7JFyFqayjkFyIvrW0k3ZI
	yrnFv39xCFyqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgNA2onpvyVpQAAst

If mtk_sgmii_init() fails after successfully creating some PCS
instances, it returns an error without cleaning up the partially
created ones.  mtk_pcs_lynxi_create() increments the fwnode
refcount for each PCS it creates, but this refcount is never
released because mtk_probe() uses a plain "return err" instead of
a goto to the err_destroy_sgmii label.  This leaks both the PCS
devices and their fwnode references.

Fix the leak by jumping to the existing err_destroy_sgmii path
which calls mtk_sgmii_destroy() to safely release all allocated
resources.

Cc: stable@vger.kernel.org
Fixes: 9ffee4a8276c ("net: ethernet: mediatek: Extend SGMII related functions")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8d225bc9f063..0f185462cf85 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5169,7 +5169,7 @@ static int mtk_probe(struct platform_device *pdev)
 		err = mtk_sgmii_init(eth);
 
 		if (err)
-			return err;
+			goto err_destroy_sgmii;
 	}
 
 	if (eth->soc->required_pctl) {
-- 
2.34.1

