Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5F3EC80B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337256; cv=none; b=ACGQcVSQlgch7RPZ7krzpTdt/jXu4AablNRgPq2tmda1DgY0+jJilRYquocRYrDNoGXqV79AzFojDnlZBq1g3wcghWKY+Zhin3DvVJsyTuphnWK4rZoEfBCDfL6ROfP/yxfq4DUPkQBR94TVjxgqQi8dbBpHYHEQB4ic/Lxgams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337256; c=relaxed/simple;
	bh=6NfSj58pVl3BqQoOwSpxDM2WO4TmsVqitSp6iWNgVxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsEBgmi8s5rFEe6LyxiFaUOpHzCjSds+qSRRTq19s0/kt2uRh/pd84aZ5DJNWj5dHzcdzFQBnyfDcjC6KvrkNQAOvOoUFimiPsRChvmek7Otmynn19cWRohrDvJ3rOF3wndQay5/kfZ9+7ZsQJG1A2QrprJoi6l20de1K2B1Dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=pXlzEDLe; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="pXlzEDLe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1785337246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSHySC9imnqvlaBunVuxOk+yqC8THPw06ofBuF1Bvis=;
	b=pXlzEDLeS7pmwlzvB6C/+cj2RZwozmFa1F8sEJR4kFwq78HBHkVbVpU8GWbZHBr8JpLQkU
	Ix7O5YR9KH+ds5GcSgaZf8k1kAw9J732FhFRER4LAHxqYqaOS75GyLeaAui7oZPLbUGPZA
	WtnZkOee1bfbzywSbAH3ZD5w1/1Vryck3pyCjeiOWZaRdzXYoYpdXdGYQvYcmi0GG1L1BE
	hVIbBfUlUREWNs11GV9MJrGXludYqjoxLOrFGLqdMA/u+JSKfa0zI7OyZMNs64gKGVM/yq
	N7rqRzV8zM4wKO4vLl1lB8wsHtZM4M11oB/fpuBDVonwCBsunZh9y1P43+XCrA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: nbd@nbd.name
Subject: [PATCH 5.10.y] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
Date: Wed, 29 Jul 2026 08:00:42 -0700
Message-ID: <20260729150042.49315-1-lucid_duck@justthetip.ca>
In-Reply-To: <2026072915-basket-dreamboat-204d@gregkh>
References: <2026072915-basket-dreamboat-204d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit 39afc46c0243d10b7795e6e6cf4ae91f41732120 upstream.

PKT_TYPE_TXRX_NOTIFY is an mmio-only event, but mt7615_rx_check() and
mt7615_queue_rx_skb() dispatch it to mt7615_mac_tx_free() on every bus.
mt7615_mac_tx_free() cleans the DMA tx queues with
mt76_queue_tx_cleanup(), which calls queue_ops->tx_cleanup(). Only the
mmio queue ops implement that callback; on the mt7663 USB and SDIO
buses it is NULL, so a TXRX_NOTIFY there calls a NULL pointer in the RX
worker. Same defect as the mt7921 and mt7925 patches in this series.

Drop the event on non-mmio buses via mt76_is_mmio(), as in
commit 5683e1488aa9 ("wifi: mt76: connac: do not check WED status for
non-mmio devices").

Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20260627191336.20223-4-lucid_duck@justthetip.ca
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ No mt7615_rx_check() on this tree, so only the mt7615_queue_rx_skb()
  hunk applies, and mt7615_mac_tx_free() takes the skb rather than
  (data, len), so the guard frees it here. ]
---
Compile-tested on v5.10.261; mt7615-common, mt7615e and mt7663u build.
Not runtime-tested, I have no MT7663 and that is the only chip that
reaches this path.

 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 4364f73b5..0c9201e07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1492,6 +1492,10 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev)) {
+			dev_kfree_skb(skb);
+			break;
+		}
 		mt7615_mac_tx_free(dev, skb);
 		break;
 	case PKT_TYPE_RX_EVENT:
-- 
2.55.0

