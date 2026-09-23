Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E8379C4E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130132; cv=none; b=rjK5Ww5lbqDrWhwu0Sm2Cym+68kmscF4j27ODVPcPdGpZqLZ16RH91BTotf0g5HtMI60gnla0dl7IwVUurC7EJ3/S/NZ/eabWEvwtU58k7g3iRDowzHUYmXl4SGQCml8KvkTx6tv7cZgCZEezPSZVh3OdFJ9BZqs7H1FnFQV/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130132; c=relaxed/simple;
	bh=uVW4kBynmbM6zEfPOT/1TJN/PIvZOPM8WnaGrwnA2lE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6pyTNY3BUrHpmO1+OgpCX9WgG9AmTSrXQPQp42y+8d/T1Wu+YxuiQApaMyvIc8coIRO5Kwnw58S2+rS829jhksCVfUKErpbt8ChIXMHqvjjzxtWrc4bclMocKG0fnSzijNESi1+m12E2KyKx3PSE/Umdgr+s2gyImQZ4RUmnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=DjGrvCQC; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="DjGrvCQC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790130121; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XnyjMdq1Z0++wMYQBvwqUuG2H3miydBJlNSKcdTfRQ8=;
	b=DjGrvCQCYHkQcdnPYCWBiB8iJPf2TbjCIUOKkqCS+P/JOy4uoWlEOw3z/pSRcoTWBiqtTcCSYuEN8KWSzG6JObsMOOxYs0NaRaVGMVshKazCcfgJm8uWerRtyrnQSivWtaEcG/8WeXszjnLCFw1+O7W7oBeHVvWavR6pAs+eZjc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4873709|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00374037-0.000828409-0.995431;FP=12635978007448961552|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.jKYLXDm_1790130120;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jKYLXDm_1790130120 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 10:22:01 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
Date: Wed, 23 Sep 2026 10:21:59 +0800
Message-ID: <20260923022159.16308-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092215-sincere-shack-66e6@gregkh>
References: <2026092215-sincere-shack-66e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c7ead9704249d57d4693a04697e3bbd285138fa9 upstream.

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
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index f71d3bc3b..2eea9997b 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -321,6 +321,10 @@ static void t7xx_ccmni_recv_skb(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *s
 
 	skb_cb = T7XX_SKB_CB(skb);
 	netif_id = skb_cb->netif_idx;
+	if (netif_id >= NIC_DEV_MAX) {
+		dev_kfree_skb(skb);
+		return;
+	}
 	ccmni = t7xx_dev->ccmni_ctlb->ccmni_inst[netif_id];
 	if (!ccmni) {
 		dev_kfree_skb(skb);
-- 
2.43.0

