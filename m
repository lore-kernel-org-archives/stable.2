Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B04A260E;
	Wed, 30 Sep 2026 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768339; cv=none; b=EwlIulG2cB4IvDpFlLneyP0O6X28nFLnhKRf2DawD8v9m+3Gsrmmqu3EBSkb4+DYbk3yoL5WbDILW3z+ESaGapAJ8l2Gcsb+6lu4qZ0d+JfjhIWizSHo8op7Pkr03Fz7VdjZlq/GyuTcMtsneKIHmy1T8QUG5WlacUEUQZ1PgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768339; c=relaxed/simple;
	bh=cNZbAkIhSgjYO/F/LH/0/Ke2lFVlsMxsLsGsPUURqnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/6aqvjsfxrmtjHo8EHc3HHrfYyaQTwpXmNLlghgEB9HOqet5xk3QBKr9eqeTJ5s4WaNAuTIEzYcvlsqmcYVIb4cBsbckqevxZV6Sr2/YnxkTJkmY8fMAohIGnFp8j0JP4UvK+IuHypwY+AbqiE0f/MPlIM+alkve1hpIbO6FaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7f7f53a8bcc311f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2aa2846d-902d-4eb2-950c-40bda623fea3,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-19
X-CID-META: VersionHash:7db8b62,CLOUDID:5e03f16cf577fed6d904c64fe7baafd8,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:1|-1
	00,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7f7f53a8bcc311f19a56ed5b684f684d-20260930
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1759642515; Wed, 30 Sep 2026 19:38:46 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net: mii: Fix unknown speed after link up
Date: Wed, 30 Sep 2026 19:38:42 +0800
Message-Id: <20260930113842.2640928-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mii_ethtool_get_link_ksettings() reads BMSR only once. Since
BMSR_LSTATUS is latched low, the first query after link up can
report SPEED_UNKNOWN even though the link is already up.

This is seen with r8152, which detects carrier using a MAC register
without clearing the BMSR latch. NetworkManager can then keep
reporting 0 Mb/s until the next carrier change.

Read BMSR twice to obtain the current link status, as mii_link_ok()
already does.

Tested on an RTL8153B with a 6.6-based kernel. Traces confirmed
LSTATUS=0 followed by LSTATUS=1 in the same query in 20 rebind runs.
NetworkManager reported 1000 Mb/s in all 10 managed-device runs.
With the cable unplugged or the PHY powered down, the speed is still
reported as unknown.

Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network cable is not connected")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
Runtime testing used a 6.6-based kernel containing the change identified
by the Fixes tag. The tested drivers/net/mii.c is identical to the
patched version based on net/main.

 drivers/net/mii.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 37bc3131d31a..bd4fdcb55df3 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -163,6 +163,8 @@ void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 	advertising = ADVERTISED_TP | ADVERTISED_MII;
 
 	bmcr = mii->mdio_read(dev, mii->phy_id, MII_BMCR);
+	/* BMSR_LSTATUS is latched low, dummy read to get the current state */
+	mii->mdio_read(dev, mii->phy_id, MII_BMSR);
 	bmsr = mii->mdio_read(dev, mii->phy_id, MII_BMSR);
 	if (mii->supports_gmii) {
 		ctrl1000 = mii->mdio_read(dev, mii->phy_id, MII_CTRL1000);
-- 
2.25.1

