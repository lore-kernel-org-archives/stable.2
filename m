Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8137471D1C;
	Mon,  5 Oct 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197585; cv=none; b=bA1/Qnak0SvqvnAJa/skv3Os/SP2psRLi+qD4b6cXZ1ETi5NVX0ZiIyXhFavPlLT5V3vJSoaotYiil+T3K7RSRqBpLE5IEiYBHqqkxgmuM17hFofjOhins54BxHB6Xi8c1Z8ZcQQ5HwQ2bSUjOl8wVwJgru26DM5TywR7iG8e3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197585; c=relaxed/simple;
	bh=uG7cVZOUhRU1CvjpNGUS2kleddpBmmy63VT1/GtYu9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jpypc+4E4u4wckICLRWZvqj6q9I/Y3L7NzLdHPft4LrFW8p6dyZPk6D7CzppA85Spv62DYOdS8t85FQrE/aV2IUtIbnPBUk1OTCXGR0o2bTPMdWjsg/zE/7CK8KAP2KeK3nSs/6kodeE5wN0yp0LTyHYqyh3bEAW8Q9arWULmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eab907f0c0aa11f19a56ed5b684f684d-20261005
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:068689eb-63ca-414f-a8f9-92181bc92e42,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:1b08ef77b8ababbcce259c069b71aa37,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eab907f0c0aa11f19a56ed5b684f684d-20261005
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1969851950; Mon, 05 Oct 2026 18:52:54 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	nic_swsd@realtek.com,
	Birger Koblitz <mail@birger-koblitz.de>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] r8152: Use BMSR to detect the link state
Date: Mon,  5 Oct 2026 18:52:49 +0800
Message-Id: <20261005105249.1281648-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
BMSR_LSTATUS can still be latched low when the carrier comes up.
Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the
network cable is not connected"), the first speed query after link up
can then report SPEED_UNKNOWN, leaving NetworkManager at 0 Mb/s until
the next carrier change.

Use BMSR_LSTATUS in set_carrier() and rtl8152_runtime_resume(), so the
driver consumes the latched link down itself. If the first read still
reports link down, the next link-up notification triggers another read
and brings the carrier up.

Tested on an RTL8153B with a 6.6-based kernel. In 5 rebinds and 6 cable
replugs, the first read returned LSTATUS=0, a second link-up
notification came about 32 ms later, the second read returned
LSTATUS=1 and the carrier went up; NetworkManager reported 1000 Mb/s.
Runtime suspend/resume with the link up did not change the carrier.

Fixes: f6f2e946aa4d ("net: mii: Fix the Speed display when the network cable is not connected")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
v2:
- Fix it in r8152 instead of mii.c, detecting the link from BMSR as
  suggested by Andrew Lunn.
- Also use BMSR in rtl8152_runtime_resume().
v1: https://lore.kernel.org/netdev/20260930113842.2640928-1-lilinmao@kylinos.cn/

Only tested on an RTL8153B, with a 6.6-based kernel; the changed lines
are the same in net/main. I could not check whether BMSR_LSTATUS is
reliable on the 2.5G/5G/10G chips handled by this driver.
I could not reproduce a link drop that recovers while the device is
runtime suspended, so that case is only covered by code inspection.

r8152_mdio_read() cannot fail today. The pending RTL8157/RTL8159
series makes it return errors, so these two callers will need error
handling once that is merged.

 drivers/net/usb/r8152.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..e3947eb796c5 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6979,11 +6979,8 @@ static void set_carrier(struct r8152 *tp)
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
@@ -8653,7 +8650,7 @@ static int rtl8152_runtime_resume(struct r8152 *tp)
 		set_bit(WORK_ENABLE, &tp->flags);
 
 		if (netif_carrier_ok(netdev)) {
-			if (rtl8152_get_speed(tp) & LINK_STATUS) {
+			if (r8152_mdio_read(tp, MII_BMSR) & BMSR_LSTATUS) {
 				rtl_start_rx(tp);
 			} else {
 				netif_carrier_off(netdev);
-- 
2.25.1

