Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD75388369;
	Fri, 26 Jun 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487760; cv=none; b=HT5496CrsMe5is3sqhr8ETrvwGkRywQG1U9fNYnhaRuvc2TJTyrvaLW2+TepR9KLEfvGanWYKU+uSLkH8qAUg6j9+gX3sGY923q483WBEHw/O3cMxJXS7jMXiq8lH3xdUY0pQLzg3cstsMCqUoI2iY7TorhZAcRJTz3Q5737ce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487760; c=relaxed/simple;
	bh=bw4QDJpE6mXmIGwuYewL7Sw/4TaK5NCZ2rZp+7CBf3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zk3G8ABguuP6mqv3nLU5/1QRb7mnIze7ayabUk0iy/focPkIGnySXh9WnNg1lybnjmswIbkgBc668h/U9Q2KNRePtkNyiZqUIm7e7ZUGlV+CSzO6f/6qd/F6AKa2riodQWdtAtC98oY2eikMY4Bv+b4GQwZafHqdUV9tHggm4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAC3UsvDmj5q5DZsAw--.57009S2;
	Fri, 26 Jun 2026 23:29:08 +0800 (CST)
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
Subject: [PATCH] fix: net: ti: cpsw_probe_dt: fix phy_node reference leak on error paths
Date: Fri, 26 Jun 2026 23:29:06 +0800
Message-Id: <20260626152906.52112-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3UsvDmj5q5DZsAw--.57009S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1rXF1fWw1xCw48CFy7trb_yoW8XF4kpr
	W5GayYvrn7JFZ2g3WIq34DZFZ0ka1jqrW3uFWjya1furn8t347Ar4jgFyYq3W5ArZ5Gr90
	yrWUAr9rXr1DG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIKA2o+iCg0OAAAsq

After slave_data->phy_node is assigned (via of_node_get or
  of_parse_phandle), if subsequent calls like of_get_phy_mode or
  ti_cm_get_macid fail, the error path jumps to err_node_put which only
  releases the loop's port_np reference but not the phy_node reference.
  This causes a device_node reference leak.

Release slave_data->phy_node via of_node_put before jumping to
  err_node_put on error paths after phy_node has been acquired.

Cc: stable@vger.kernel.org
Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/ti/cpsw_new.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index c5be359f3c66..9f90d5a9d39f 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1337,6 +1337,7 @@ static int cpsw_probe_dt(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(dev, "%pOF read phy-mode err %d\n",
 				port_np, ret);
+			of_node_put(slave_data->phy_node);
 			goto err_node_put;
 		}
 
@@ -1344,8 +1345,10 @@ static int cpsw_probe_dt(struct cpsw_common *cpsw)
 		if (ret) {
 			ret = ti_cm_get_macid(dev, port_id - 1,
 					      slave_data->mac_addr);
-			if (ret)
+			if (ret) {
+				of_node_put(slave_data->phy_node);
 				goto err_node_put;
+			}
 		}
 
 		if (of_property_read_u32(port_np, "ti,dual-emac-pvid",
-- 
2.39.5 (Apple Git-154)

