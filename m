Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113123CB8F1;
	Fri, 26 Jun 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488020; cv=none; b=pThm/Ga4/k9QBlUOHXr6qiRkhlgjcHOFhsjv65xyZ1+QPTJVUC9M0K+0e/hC0nGupt2ZTKXvi/4vkUHRpOpquQJWWIWo3YS53v01WvmpUBSgRSrd+63yaWFlFVJsU6oqmEJP9wFcS/td8uDLWKoD+Xsv6xYO5Tks8FuGSslq998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488020; c=relaxed/simple;
	bh=UkFmkqcAorIoXwm+YkIjtvwd8sU+6oKhQGqB6WnUj3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nGDKyY1J4wnb2ArqXoHoVX+SSP7qs5D2CQ/7KBoTr5gbjmIC59n0owQPDZgdFFC9W1smythWzslVL/jEr0zExwsxx8IHqxywICFYyXB9Wdp18xoUP7REqQU8w3NlMAoVXsJrIyDbyLQtIz3f40qnRzl4efTW0y0kUYzKKVGkfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowABnCdLLmz5qBF5sAw--.4384S2;
	Fri, 26 Jun 2026 23:33:31 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: mdio: of_phy_register_fixed_link: fix phy_device reference leak   via discarded pointer
Date: Fri, 26 Jun 2026 23:33:30 +0800
Message-Id: <20260626153330.52741-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnCdLLmz5qBF5sAw--.4384S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWfuw1kAw1kJw1Utw1xuFg_yoW8Xr4xpa
	9IgFyFyryDGF4I9w409F4rAFyY9ayIy3yFkF4fGa9agwn5Gry8Zr1UuFyUXr1Fyrs5CF9x
	Ary7Gayru3Z8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbo5l5
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQKA2o+ikUvogAAsc

fixed_phy_register returns a struct phy_device pointer with a held
  reference on success. However, the register_phy label discards the
  pointer via PTR_ERR_OR_ZERO, and the phy_device's fwnode is not set, so
  of_phy_deregister_fixed_link cannot find the device via
  bus_find_device_by_fwnode to clean it up. This permanently leaks the
  phy_device and its device_node reference.

Store the returned phy_device pointer and set dev->fwnode so the
  deregister path can properly locate and clean it up.

Cc: stable@vger.kernel.org
Fixes: 24c30dbbcdda ("of/mdio: Add support function for Ethernet fixed-link property")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/mdio/of_mdio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b8d298c04d3f..0dd25d94fec0 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -456,8 +456,16 @@ int of_phy_register_fixed_link(struct device_node *np)
 
 	return -ENODEV;
 
-register_phy:
-	return PTR_ERR_OR_ZERO(fixed_phy_register(&status, np));
+register_phy: {
+	struct phy_device *phydev;
+
+	phydev = fixed_phy_register(&status, np);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+
+	phydev->mdio.dev.fwnode = of_fwnode_handle(np);
+	return 0;
+}
 }
 EXPORT_SYMBOL(of_phy_register_fixed_link);
 
-- 
2.39.5 (Apple Git-154)

