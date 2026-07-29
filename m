Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DF0445AF0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330389; cv=none; b=sSAYTgPgMDepQbWF4Bippm/qNtYnS9alDayTITV+TK/dE/CG45xnXyz41Nnk9syZDyY5tj99UyUpxVYKMbd60P8iD/6tbyz1nu/nl0pKUTlIiMPy3BQxzyggA1mhlze/ZGRX0QkVx0m64HyxIpuXsavBniucsaByjhG+Msxg6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330389; c=relaxed/simple;
	bh=0MSPcAGOMZknOWJflJsHY5F/tQDlr3V7mmUHNQ+g2bo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fLwixRn0O+8LWV6uYs9e4+53wVmj/Xvu0Ulpm6nXmn5+vxyNwL02+dqfp2PU7cPadcdzGV0j5yzg5l0TIXzKYpRcJO2LXDf5A4qPwQT+D/RSGmmY3Z80hYiuvDBFG0wjibsPiehXd0wKxgK6LFu7XhjJd8wFbirJnbfq3KbP9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g74nbM0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g74nbM0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956E71F000E9;
	Wed, 29 Jul 2026 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330388;
	bh=+hwvmXRUIKGScMMilq4Beu2H87352Tkh/o6+MLugMqo=;
	h=Subject:To:Cc:From:Date;
	b=g74nbM0vh7MMS/U9YMXHaaojvec2LlsczZ+eFf97Ee2Su+7aG0SCpJ3zNu1B/p3Zq
	 cuMs7Y8P7gwtGQcu/+GHJDVbxXue8KDbKw1Ml8/YD7jjJtjwHUNAgcloNZH1LkFuAv
	 60Nnx37S2AyY7i49O3xX5LB8FlDX+VdG+LzEWNjc=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses" failed to apply to 5.15-stable tree
To: lucid_duck@justthetip.ca,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:06:14 +0200
Message-ID: <2026072914-convent-flame-f173@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 39afc46c0243d10b7795e6e6cf4ae91f41732120
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072914-convent-flame-f173@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39afc46c0243d10b7795e6e6cf4ae91f41732120 Mon Sep 17 00:00:00 2001
From: Devin Wittmayer <lucid_duck@justthetip.ca>
Date: Sat, 27 Jun 2026 12:13:36 -0700
Subject: [PATCH] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses

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

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ce0051468501..aad232c5a6fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1601,6 +1601,8 @@ bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len)
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev))
+			return false;
 		mt7615_mac_tx_free(dev, data, len);
 		return false;
 	case PKT_TYPE_TXS:
@@ -1634,6 +1636,10 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev)) {
+			dev_kfree_skb(skb);
+			break;
+		}
 		mt7615_mac_tx_free(dev, skb->data, skb->len);
 		dev_kfree_skb(skb);
 		break;

