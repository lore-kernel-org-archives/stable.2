Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEA38C2A7;
	Fri, 26 Jun 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487798; cv=none; b=Znc+w/woSiIZfBUOfjWOQGNbEazsMsxUOxg1zNxrcT6o4ihQ+7wGZkJyOmcI3gqUXEDYxIl9/JMWvuH7Bf3nWQ+npTw4D2hI/T1UZoXxsmSOXfWglDgGxKHt5VKKX0D6gjUBtKP67lziXtm0cVfEoJ/ArIQZ5PTURHskewIam0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487798; c=relaxed/simple;
	bh=XEEtySvz2H/5n7QxI6sUMxgO1+nX50dCkUnJfaDLMQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0PkTS6RHnJaCkeZb9q5LXl+BzHvEr5UcIe5KbiogQ8W0d3/o/FpxUE6cskoyasEkyBdX0OANMm588u/tQmSnhJ/3xC5hcyKKwBR1MYNNBbIOvuSpX7EF1wCdfcPqbhlFVsjmVD32ipSWjhNRgE9pdbRHD2/1NiRPsk0njLuUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHpc3qmj5qUDxsAw--.54404S2;
	Fri, 26 Jun 2026 23:29:47 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: ti: cpsw_init_common: fix excess of_node_put on parent node when   cpts child not found
Date: Fri, 26 Jun 2026 23:29:45 +0800
Message-Id: <20260626152945.52192-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHpc3qmj5qUDxsAw--.54404S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryUXry8ArWfJrWxtrW5Wrg_yoW8Gry5p3
	yFka43ZFn5Jr4vgwn7t3yFvFZIva1ktws093WxCa4fZ34qvry3JF1DXa4Yvrn8trZ5GF4Y
	yr95Awn7J3WkGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMKA2o+iCg0iAAAsb

When no "cpts" child node exists in the device tree, cpts_node is
  assigned cpsw->dev->of_node without taking a reference via of_node_get.
  The function then unconditionally calls of_node_put(cpts_node) at the
  end, causing an excess put on the parent device node which can lead to a
  refcount underflow.

Use of_node_get when falling back to the parent node to ensure the
  reference count is properly balanced with the subsequent of_node_put.

Cc: stable@vger.kernel.org
Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/ti/cpsw_priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 1f6f374551cb..b20567f96d78 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -553,7 +553,7 @@ int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 
 	cpts_node = of_get_child_by_name(cpsw->dev->of_node, "cpts");
 	if (!cpts_node)
-		cpts_node = cpsw->dev->of_node;
+		cpts_node = of_node_get(cpsw->dev->of_node);
 
 	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpts_node,
 				 CPTS_N_ETX_TS);
-- 
2.39.5 (Apple Git-154)

