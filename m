Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08D38737A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088944; cv=none; b=t0RItBYKZ9lWzN086fyVXkiZ8i9GUDNDqzJ1bSNK4265D9L0VFsPusxBLuUFDdjCzuE19fN7c4bIq/Ir63g4ZycefJKB2WriV9Ko7XlUv7/qxDBmdauaL5xY30uPEw+XFcn/dHyI9yhRMTrL8z0xCTRCk62UTz3dUizcrd+hp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088944; c=relaxed/simple;
	bh=VcOkxJPivA6L7rGcFOkrqxQ/zYg7lAfds1ZhzYUbedg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVa/f+N4ldRt/wKnmL/YLTPEWoLILrvmCkRTTp0+47fKiwN42+TNGyt7M2Rfsrz95XZ6cQLgqRcPEhpiWYLtKUdOdw9f3ILm2b8kAufg2cDgjgyJbYvTYqWSHUEXt0HqmeLCQh0Lk9QMN4SDCO39HaGCkaEcQElQltl4NcW7jFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmxH2dp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmxH2dp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E51F00899;
	Tue, 22 Sep 2026 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088941;
	bh=IsPaplHHeEf5tBngcQTmN+RIYXyWor4RBgE4y6I94tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmxH2dp2XgMH9YeMbVomgMrQbyiqm4onKzsQg13p2HehvTuU7e4xj+zv7QX/B+RLy
	 QZZ7qHsk0h2ydvGjQfNVN1PNx2gH7+xaLauXdSwuP5CRJuxri/xG8TM4VI9kdZSz3a
	 fsJlsZnGdEIw7Xbye17tXD7OuyYeWRpuV3aYBegqKeIJnAUORipUcHxNZdRNe7ec7Q
	 Pf7Kyky01sjYz7ZsrYYpV+gHQ5qpQzo34usW5CR0eMFLReIxuy+ZV/7SlrMxG9Mvds
	 C02epJH6/eHos9HDgsjM3dYdDDbKJNG8vuDta9Tv/dFtjcdgjmqX04sLgOAsXqQlkU
	 1obtyDGhLJI+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanglei Zhu <zhugl3@xiaopeng.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
Date: Tue, 22 Sep 2026 10:55:38 -0400
Message-ID: <20260922145538.2711877-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922145538.2711877-1-sashal@kernel.org>
References: <2026092215-sincere-shack-66e6@gregkh>
 <20260922145538.2711877-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanglei Zhu <zhugl3@xiaopeng.com>

[ Upstream commit c7ead9704249d57d4693a04697e3bbd285138fa9 ]

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

Link: https://patch.msgid.link/20260911021734.1396599-3-zhugl3@xiaopeng.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index c5d974a935903..965ddc5f1c2aa 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -323,6 +323,10 @@ static void t7xx_ccmni_recv_skb(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *s
 
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
2.53.0

