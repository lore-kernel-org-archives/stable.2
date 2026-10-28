Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163848;
	b=TMZywJVKElOg+WX5E3C7Xx/0/wsxtxwNW1JiK2kUtfkur/msDn/VnbSBPVgzjk4UL/TJ
	 RSCx8pUB/rfOjkp5/waDA5QcT2Yg1TZNRXueqH55hVLTe4kehdnr9vVbCdjdkzrsHZS3P
	 G8a7a1sRlQzLOK1gwf4w2qMkRiSxPgx+IVGMBEb3Zm/2XTfFs++IFed+Fiuq4enLeKEko
	 RrkoLfNzfkMQRfSO8imBWfQzstx/yeH8V7z4tU6EPytK3sriNkzLE5Ucb9LlxLnCgUI/S
	 z34XGwvAXq+aLCA82hEDHKpXjkWwTZduiYMlUMz/gFKtK/kGmz4+Jb/r/XfFTumtF4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163848;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=FlFLV+LrMOBGmpATjG3z5jE42aeiJSCz2DhkhKzdZJY=;
	b=JQZch//HGEr0ROXLbY0l57Z2n0IDECC5HXzx2dE8lEvbwb5/gb1CqQa3+S1sOFnlvbFK
	 azsglvi+BiZUKdVrDx4ztifbxvUaKnCo+Nnlu49mLC9lEQ/HGl9j4Af5Q0IIpz0q1Atko
	 Ywjop25dzfos6L/Wl1LrYi8vBMXwqQoVPOuqL6MsoCgUqVOTkCPv77HVpaWy5aphMoMQs
	 eW5hNo6omfXUDdAJ0+GyIunUKsf2jDhpIdnuQY5afKn+ois+8Q7e3JJT6kZ1UBV9PA1nT
	 Z6rdynJkuQcmd3vpzpc4252OTMg+qFPD9Tq3QFtCQ4/507xB4yhFAgK2wdJPPRt+bww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aELgK7ws;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA018606A31D;
	Wed, 28 Oct 2026 05:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA018606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aELgK7ws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fl
	FLV+LrMOBGmpATjG3z5jE42aeiJSCz2DhkhKzdZJY=; b=aELgK7wseZzANP5nSx
	6kWzED6BXAEgxjXhIPQZI5+oaNu3QTi/tGDDPd92HW8HE10Uqv66IFz0gL+CWWmT
	eVSGnPcISzVVCTQSOyVmP1A8Y9zxZzUmUXS8H6VA0+J2ytL4UejSSNMqQjxI3YnU
	pri/7nsh8JgdMIfm6GuXlX9is=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXXx0QguFq4jaQDQ--.52556S2;
	Wed, 28 Oct 2026 13:03:13 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <chleroy@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: phy: only remove owned topology entries
Date: Wed, 28 Oct 2026 13:03:12 +0800
Message-Id: <20261028050312.126508-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXXx0QguFq4jaQDQ--.52556S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1UAr47Jw45JFyxXFWfAFb_yoWkKFX_C3
	9rZrW3Zws5Jan0yryfWr4fArySk3Z3J3Wv9r1vg3y5Xa15Gr15Crn5Xrn8Jr9ru3WaqFWD
	Gw1UCFyxAa45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU847K3UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhG38WrhghHgUAAA3x

phy_link_topo_add_phy() can fail to insert a PHY when its saved index is
already occupied.  Its caller may subsequently run the normal detach
path.  phy_link_topo_del_phy() then unconditionally removes the entry at
that index, including its ports, even though the entry belongs to a
different PHY.

Look up the topology entry first and only remove the PHY and its ports
when the entry belongs to the PHY being detached.

Fixes: 384968786909 ("net: phy: Introduce ethernet link topology representation")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/phy/phy_link_topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 214ccce23cf6..175eef44cf54 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -185,6 +185,10 @@ void phy_link_topo_del_phy(struct net_device *dev,
 	if (!topo)
 		return;
 
+	pdn = xa_load(&topo->phys, phy->phyindex);
+	if (!pdn || pdn->phy != phy)
+		return;
+
 	list_for_each_entry(port, &phy->ports, head)
 		phy_link_topo_del_port(dev, port);
 
-- 
2.34.1

