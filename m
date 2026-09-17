Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEE4DAF98;
	Thu, 17 Sep 2026 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645204; cv=none; b=NhfGp+IGa3aHTZOqR31GLgD7+dXoGTzukvQhC+MU2xG3deyG7RniCRpG77RzlW4FE+h1KhVFpnVZ5n2XWzNugljOL2gqujC66afTzK1bnFLLgq/o/RIHcpVpbNahsUF1MsIfThwLoqmjTZLzFe7wii3LnPrNoD3s5J+inC3ixcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645204; c=relaxed/simple;
	bh=NoxzKN8cAx+3h795kfAfNwSlZamFjjRAyGkJWepcSro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjgD4KUA9j+iEtccYOjGlyk83grgKc2PeTjqYK2sYFxc2B+rNCYX/SvwYN8l1njSNkyWh8KtJyfHiAsEcsl9kVksAm6JGg3y4HyqvqHkfQOuYeqzfjf30r+n9VWx93KrXBe6TTjsSJKqwEYMqF5xDbAmXvygvSQ+9NyNYXjaHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDqB0atqp7x_CA--.1766S2;
	Thu, 17 Sep 2026 19:39:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexandre.torgue@foss.st.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	treding@nvidia.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: stmmac: Fix MDIO node leak in stmmac_mdio_setup()
Date: Thu, 17 Sep 2026 11:39:45 +0000
Message-Id: <20260917113945.2149361-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDqB0atqp7x_CA--.1766S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDtr17WF13CF1UKr17KFg_yoW8GrWrp3
	y7Ca9Fvr95Gr97tw4kJr40vFWFkayayrWUGr1Ikanavan8GFWaqryaqrWjvas7GrWDWa4a
	qr10kw4UZF1DArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU878n5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYNA2qrq3Z7RAAAst

stmmac_mdio_setup() acquires a reference on the MDIO node through
stmmac_of_get_mdio() and stores it in plat->mdio_node. If the allocation
of plat->mdio_bus_data fails, the function returns -ENOMEM and the
caller takes the error_put_phy path, which only releases plat->phy_node,
so the MDIO node reference is leaked.

Release plat->mdio_node on this error path.

Fixes: 1a981c0586c0 ("net: stmmac: Make MDIO bus reset optional")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..09359ccb32ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -356,8 +356,11 @@ static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
 		plat->mdio_bus_data = devm_kzalloc(dev,
 						   sizeof(*plat->mdio_bus_data),
 						   GFP_KERNEL);
-		if (!plat->mdio_bus_data)
+		if (!plat->mdio_bus_data) {
+			of_node_put(plat->mdio_node);
+			plat->mdio_node = NULL;
 			return -ENOMEM;
+		}
 
 		plat->mdio_bus_data->needs_reset = true;
 	}
-- 
2.34.1

