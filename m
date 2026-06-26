Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D7387361;
	Fri, 26 Jun 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487480; cv=none; b=pf1pqHpzX46X6KEbMc/2JBU/OCtofSvzuQ3SZ0hzrGUmRnsrOPHdAgRSuTzGx0jluCdZMmzzG1+6Daeg3sMDKscEampIk3e2qqCANH5SRPpMKQmUXi1tce4jpxc1UWXP+VX0KRbznuLgueFbkAnmTf3ZzgkzJPxz57Kt8ethyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487480; c=relaxed/simple;
	bh=UaKX2v8Zde1/mEnCpoQ6ZNmMmzXgbSJt9HixAlTWVdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hiux/KzcISrLh6f8VxphRclLBN0d1uM8f5YiMNi4ggjn+26GNbS0lopecGvtPbQq0BInBnA8fp+6Ei8AZADN/PyFl7ev6DuY7r24Twd7E/tt0g4FKl1R4DmTQRfvatGLaN1CsX5gEbEpafETtW7AyvxA9jB9ZfsryFGWei7/Nhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowABnB9CumT5qmQxsAw--.185S2;
	Fri, 26 Jun 2026 23:24:31 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: netdev@vger.kernel.org
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: renesas: rswitch_mii_register: fix double of_node_put after   of_mdiobus_register
Date: Fri, 26 Jun 2026 23:24:30 +0800
Message-Id: <20260626152430.51835-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9CumT5qmQxsAw--.185S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rur15AFWkJFyDXr43Wrg_yoW8GF4rpr
	Z8KrW7ZrykXr42qa1kGa1UuF9YyayFkrW5uF1jka9Y9anYyF98Ary0ga45ur45GFW8C3W3
	tr1jyw18uas8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUKA2o+h0E05AAAsI

After of_mdiobus_register succeeds, the mdio_np reference ownership is
  transferred to the mii_bus device (released via fwnode_handle_put during
  mdiobus_release). The success path calls of_node_put(mdio_np) which,
  combined with the automatic release via bus teardown, results in a double
  put and refcount underflow.

Move of_node_put so it is only called in the error path where
  of_mdiobus_register failed. On success, the bus driver manages the
  reference lifecycle.

Cc: stable@vger.kernel.org
Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for Ethernet Switch")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe964816322..c33add28a70c 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1387,13 +1387,13 @@ static int rswitch_mii_register(struct rswitch_device *rdev)
 	err = of_mdiobus_register(mii_bus, mdio_np);
 	if (err < 0) {
 		mdiobus_free(mii_bus);
-		goto out;
+		of_node_put(mdio_np);
+		return err;
 	}
 
 	rdev->etha->mii = mii_bus;
 
-out:
-	of_node_put(mdio_np);
+	return 0;
 
 	return err;
 }
-- 
2.39.5 (Apple Git-154)

