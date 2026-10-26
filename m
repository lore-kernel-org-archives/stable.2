Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792977849;
	b=DDmnzJSmZ09F/1JoVrBtQRgq6jPIysy36l3TgtIH+zNEEyxE7RJmFHiIu0tRI3Og5JUI
	 6Wa+R7Azr1Tfnz+XUoPWZRNwA9r2yP8K5/YaA/Sz7/cvgrHt7OWwgm7rR+EMLvMTWGBca
	 +pu5gxe+Xeh0Xgv/8dg2ldKpG7nsaxIqiCDl2xxtSJe4fa1udSQUKJZaulMTuXCghRaOy
	 B6hdZOKF/Dm2YyZCtp0NJEier1TerXeM3yCdknbvFBB2dYC3H+CBV6F0GdyYrgIbJaAop
	 ZowDrBBwp17byQerNENWABe/a287wAzLdRZ9MNmlkrTZdo3l9wXqJ4uUXyh2cdRNGOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792977849;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zdFsEP1AN6T2i8dQrAhXNPucHiLg/K1/ek8PnkvRhmA=;
	b=04u6XEMj4YgQJWlcejOuBKJC00ua61mZTdi76E2sCayE0uLBL6KYNox8USnX0liMIZ3D
	 b+L8VEUtHr++LLcH2aB3iVmlulrdZNMWOhCWLob/FrvaSOhab3e+9hd63C+k2olvL222C
	 lmvMK9PC4NLe7BscAcMeYEzVfCBEAF2Ql8WFKyz62hgge4rFsysWv6v+sSMjz4j5aknfK
	 QZAk30rCRP2dOYS9jRWC13m3uNnjjWncefFDnNJvBIMyCtUXaij0RP6LkbWHkM5eoy7cC
	 VvUAEZAcEb1rxTjrTk/i8vQhalPE3Uedjf3bV8Jc2dm9APR8AElEy60x8KnOw/V6G3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4A606A31B;
	Mon, 26 Oct 2026 01:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e67d2d56d0db11f19a56ed5b684f684d-20261026
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7454b403-2174-47ea-a00d-626dd293ba85,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:7e0345ce150d8e09b77cb675ba672b6b,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e67d2d56d0db11f19a56ed5b684f684d-20261026
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 171342252; Mon, 26 Oct 2026 09:23:50 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: hayeswang@realtek.com,
	nic_swsd@realtek.com,
	hsu.chih.kai@realtek.com,
	mail@birger-koblitz.de,
	zhangxiangqian@kylinos.cn,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH net v3] r8152: Use BMSR to detect the link state
Date: Mon, 26 Oct 2026 09:23:45 +0800
Message-Id: <20261026012345.1902285-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
BMSR_LSTATUS can remain latched low after link up. Since
commit f6f2e946aa4d ("net: mii: Fix the Speed display when the network
cable is not connected"), the first speed query can then report
SPEED_UNKNOWN, which applications such as NetworkManager may cache
until the next carrier change.

Use BMSR_LSTATUS in set_carrier() so a latched link down can turn
carrier off after the link has recovered. If BMSR reports down but
PLA_PHYSTATUS reports up, reschedule the link work to read the current
state without waiting for another notification.

Tested on an RTL8153B: NetworkManager reported 1000 Mb/s after 3 of 3
rebinds, instead of an unknown speed.

Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network cable is not connected")
Cc: stable@vger.kernel.org
Suggested-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
v3:
- Use Hayes's approach: detect carrier from a single BMSR read, so a
  latched link down can turn carrier off even after the link has
  recovered (Andrew), and reschedule the link work while
  PLA_PHYSTATUS still reports up, so carrier up does not depend on
  another notification (Hayes).
- Drop the runtime resume change.
- Tested on a net/main based kernel instead of a 6.6-based one. With
  intr_callback() filtered to pass only link status changes, and the
  first link check delayed until after the down and up notifications
  from ethtool -r, 5 of 5 runs showed NO-CARRIER then LOWER_UP about
  8 ms apart. With the PHY powered down for 10 s, the carrier stayed
  off and the speed was unknown.

v2: https://lore.kernel.org/netdev/20261005105249.1281648-1-lilinmao@kylinos.cn/
v1: https://lore.kernel.org/netdev/20260930113842.2640928-1-lilinmao@kylinos.cn/

 drivers/net/usb/r8152.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index af3d7dcb2f14..ae861eb6d9a9 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6958,11 +6958,8 @@ static void set_carrier(struct r8152 *tp)
 {
 	struct net_device *netdev = tp->netdev;
 	struct napi_struct *napi = &tp->napi;
-	u16 speed;
-
-	speed = rtl8152_get_speed(tp);
 
-	if (speed & LINK_STATUS) {
+	if (r8152_mdio_read(tp, MII_BMSR) & BMSR_LSTATUS) {
 		if (!netif_carrier_ok(netdev)) {
 			tp->rtl_ops.enable(tp);
 			netif_stop_queue(netdev);
@@ -6988,6 +6985,11 @@ static void set_carrier(struct r8152 *tp)
 			tasklet_enable(&tp->tx_tl);
 			netif_info(tp, link, netdev, "carrier off\n");
 		}
+
+		if (rtl8152_get_speed(tp) & LINK_STATUS) {
+			set_bit(RTL8152_LINK_CHG, &tp->flags);
+			schedule_delayed_work(&tp->schedule, 0);
+		}
 	}
 }
 
-- 
2.25.1

