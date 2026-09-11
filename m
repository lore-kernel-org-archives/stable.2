Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318A3D75C2;
	Fri, 11 Sep 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093070; cv=none; b=MJ9dzNSodje8ZIUTeYQ+rJvJHrVPtTS2IZMq61KQ7UPU8c3ki2dPBtYggCepXs7TZdZOwWG0RMxjrtFzEMQXVFAmRc7kgWNbdjY8v1JP9PH5i02jdCX04RMDK5zOXZpwybvgUMVVVd/gIadbq+Kf11mhTXh7rPxW0ZONWGlcEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093070; c=relaxed/simple;
	bh=YeUiz0TA2fqpJJSS2EYAIWSY1nFQCGpFi41YpsISEGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPPaljx1jfcgIap4wfx0FSxR+mAAXEqSYhSLQXzkT4o9xIHTDWOAubn/B+hJL4WpzhdnChYxJS9JJ2/wPSaNitQV1MvbtJwTLfKfTKP2DVEVprpVhohVx+VzA6WYtfKz01THKyKU3rlJHxrpgQ3o/b4woitl573567T2stb6W1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=lv90easE; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="lv90easE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789093058; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AGmgEz4KZ3RbuH8gGSn86MMXtdpu+QzNzpDnUzRIncA=;
	b=lv90easEn2JVk0aymgp0dsUy6yeWTuQOMzpMTYHtIMpgPMjAkrmRd78YGuE/DBCD6r/O20tbbOv0EvYSG5SyNR/JdlkWhCEPSCENaQgFQM9ULQs/yKl8PB++sBZxTe3FigWXIW71qRqXPHrdV+ccWd2xdQ2Q/D7kTL/rpKSyzrY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5046552|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00294002-0.00123015-0.99583;FP=13788908308216070704|15|2|20|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jArxPlx_1789093056;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jArxPlx_1789093056 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 10:17:36 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH v2 3/3] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
Date: Fri, 11 Sep 2026 10:17:34 +0800
Message-ID: <20260911021734.1396599-3-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911021734.1396599-1-zhugl3@xiaopeng.com>
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
 <20260911021734.1396599-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netif index carried in the DPMAIF PIT header is five bits wide,
but ccmni_inst[] only has room for NIC_DEV_MAX (21) entries.
t7xx_ccmni_recv_skb() indexes the array without a bounds check, so
indexes 21 to 31 read past it.  The out-of-bounds value lands in the
callback table that follows the array, which is never NULL, so the
existing !ccmni check does not catch it and the driver dereferences
whatever sits there as a struct t7xx_ccmni.

Drop the skb when the index is out of range.

Fixes: 05d19bf500f8 ("net: wwan: t7xx: Add WWAN network interface")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Verified in a QEMU guest with a fault injector setting the netif
index to 25: the unpatched driver reads a value past ccmni_inst[],
which lands in the callback table, and dereferences it far enough to
queue the skb.  With this check the packet is dropped.  Well-formed
traffic on index 0 is unaffected.

Changes in v2: none.
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index fc0a7cb181..8f32c2d269 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -420,6 +420,10 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
 
 	skb_cb = T7XX_SKB_CB(skb);
 	netif_id = skb_cb->netif_idx;
+	if (netif_id >= NIC_DEV_MAX) {
+		dev_kfree_skb(skb);
+		return;
+	}
 	ccmni = READ_ONCE(ccmni_ctlb->ccmni_inst[netif_id]);
 	if (!ccmni) {
 		dev_kfree_skb(skb);
-- 
2.43.0

