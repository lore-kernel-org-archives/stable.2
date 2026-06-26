Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717837DAAA;
	Fri, 26 Jun 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486903; cv=none; b=fX3sRWRvAO6iJ1KZMgRIbPw8dzYb6mhQ2M365jxAwliNgtmOosfsPRg0gIApqujXZ/B9g/nKmaFvlSm419ZxqRWaE/M3DVMsiJFRPxCGVwpO9gk29zuzn2A2OAdlr76bjuhzONIeCwqfZZxfeY+ToYlo52pSh/Nwr/TnI5uzShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486903; c=relaxed/simple;
	bh=VtnWEWRy+CVDljRKwa0JKskkVAFjQhUVahwJL6o5v2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VcQA2sUn+l0zqd7s4YCJvz3G5ZZHiZ/jswNbmxyrwALJSjUL7mg8kMbFWcfN9qOrvDUFF2YWJDCASR5oFoAJVllzed+M0fSoh/up2OuEiDDmsIpFItLD/+kmAMTEO6QApH2YaLv+9akDxSsALjDvv6QanDp+9N4QT3ix4HUOA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRplz5qarxrAw--.18895S2;
	Fri, 26 Jun 2026 23:14:50 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: cadence: macb_mii_init: fix double of_node_put on mdio_np after   macb_mdiobus_register
Date: Fri, 26 Jun 2026 23:14:49 +0800
Message-Id: <20260626151449.50969-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA33NRplz5qarxrAw--.18895S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rur15Aw1kXw1UJF13Jwb_yoW8Gr4Up3
	yYkrW5Wrn7Jr4Iyw4kGa18AF90ga15trW8uFWjk3yrZFs8GFy8AryxWFy5urn8GrZ7CanF
	yrn5A3Wqqas5Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbUPED
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQKA2o+iCgsEAABsd

After macb_mdiobus_register succeeds, the mdio_np reference ownership is
  transferred to the mii_bus device (stored in mii_bus->dev.of_node). When
  the subsequent macb_mii_probe fails, the error path jumps to
  err_out_unregister_bus which calls mdiobus_free (releasing the node via
  fwnode_handle_put) and then falls through to err_out which calls
  of_node_put(mdio_np) again, causing a double put.

Move the of_node_put to only execute on paths where the reference was not
  transferred (i.e., before successful macb_mdiobus_register).

Cc: stable@vger.kernel.org
Fixes: ef8a2e27289e ("net: macb: fix probing of PHY not described in the dt")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e8..c58e089e5888 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1170,6 +1170,9 @@ static int macb_mii_init(struct macb *bp)
 	mdiobus_unregister(bp->mii_bus);
 err_out_free_mdiobus:
 	mdiobus_free(bp->mii_bus);
+	of_node_put(mdio_np);
+	return err;
+
 err_out:
 	of_node_put(mdio_np);
 
-- 
2.39.5 (Apple Git-154)

