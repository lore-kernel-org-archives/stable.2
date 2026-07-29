Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D914314BD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330397; cv=none; b=oTzyl5At3EIAaglBTeRF1pCvB1I8DZiIfNQ1pbSxI+FhflkKlLfZQz4J002jZrodUnVds6+7BlpZDMhGWzFaci3q82yNQrrt8OiBnRvRSjDbg5EMT2bN8AvG3zYpxd1bcY/VXxUuW19zzbWHMcj2ekh0Dl8V7SQ0iaH90kSf9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330397; c=relaxed/simple;
	bh=3A6KP23tx9uPd5a2Cq1iM4auVdubuBwXy4Go20xCiKQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gfwbHYSTugjTJp6cT0FIqYY/zJQqcW2R/JsC7BnYIWqgfFi1ZPVW4uYx6RxUjqJukBAhD4YfeOQGDQyZY7GBwHb33BQCKmv6gpH/qnHomqJeOGtOoAasvMNPM8le1akouOFnONKPW6+ZI1Vh+O9PnkQwH9K7y7FQLBbmGAKOslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mkjjuMnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mkjjuMnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8A61F000E9;
	Wed, 29 Jul 2026 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330396;
	bh=inNPlBkvGhv/zL9eCU162pXA0oU7Ypu5Ge2R/I4d69s=;
	h=Subject:To:Cc:From:Date;
	b=mkjjuMnOFD86yNyJ5ugF8F0c/YxHHFjDfI75vEUa3ZuRWHbVDTR4+5dSe5j6Tb52k
	 TCgnOqDgkXRQqK53/SxD5AU4s8lqYe8rNQs8t20PcI3nPol3OkWjBr556//H8wQLgX
	 fQuwlsheGHbp+HFbenCuJVuZOT3RJGsVhAhTts+I=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses" failed to apply to 5.10-stable tree
To: lucid_duck@justthetip.ca,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:06:15 +0200
Message-ID: <2026072915-basket-dreamboat-204d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 39afc46c0243d10b7795e6e6cf4ae91f41732120
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072915-basket-dreamboat-204d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

