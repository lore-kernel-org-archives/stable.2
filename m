Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB7359A66
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790561072; cv=none; b=HBtrzS+viHRRdIez/lXmVMflnNvTkrkWTnsigT4DWZ/ASLMRKpSSVLnIiMYsNJ9s6GWVn8BtQ2K/YGe7WHThvmlwWBFe0w51cem51l+wv+/2ZxXeXdrg6Iw/pHnJOl+fqGJiulUu4Q5tKKhe45aoKHOHbu/vPn9dm/SfCVt0xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790561072; c=relaxed/simple;
	bh=wb438Nh78ujrN5XRhCMbqn9TlhweH9PjuGbCYpqEEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Id00+Vb5vxa2aJ8OIBshkyMcSVd7OkjrYEW6z+SXNIRNnm+FmMzfUrCRkM3fyj2vmDpmGSpcHpKdG+/Y4jXbd8/G78y3omcIfkyAjy0ZNrnni1SIDnq5wAmTF3bxhujRtabzOWh68HgpqjqGQrxvTtkMFkBHZ0j6hYHeKi6Zla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=sReLFmO4; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="sReLFmO4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790561060; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7kv+TYsL7J1+VsIds2z30ODUI7wn3lk8kCDCOgL9gSs=;
	b=sReLFmO48kqMdC4aACtjNSB2Y0D5ceRFFFILUWwGcU79yhXJPP/bX2n16H1NTLyo19/1jgJDw5LIB+EoDkznjAtrXOG3VwgYyfPs602XkFEJyzZlEv4quX+t/7jmMCheZYeQXgzLmM3hBCnV/w/DBjg5Yo9ddV10SQrMKtoaRPg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2602343|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0024013-0.00116799-0.996431;FP=13788917362007517746|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jPdPPto_1790561058;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jPdPPto_1790561058 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 10:04:19 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	liuc63@xiaopeng.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y v2] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
Date: Mon, 28 Sep 2026 10:04:18 +0800
Message-ID: <20260928020418.6117-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923022159.16308-1-zhugl3@xiaopeng.com>
References: <20260923022159.16308-1-zhugl3@xiaopeng.com>
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
Link: https://patch.msgid.link/20260911021734.1396599-3-zhugl3@xiaopeng.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: add the Link: and Signed-off-by: Jakub Kicinski trailers from the
upstream commit, as requested by Sasha Levin.  No change to the code
or the rest of the commit message.

 drivers/net/wwan/t7xx/t7xx_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index f71d3bc..2eea999 100644
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

