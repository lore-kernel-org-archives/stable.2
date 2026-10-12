Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E07485510
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807780; cv=none; b=Xg6mM8UDDQrj1Tp6gVEsxHi+r6Ileqm4D5bSLhwucdPdth5zj8SNbStSfSdBt3+b4SNy1cg9wU905Q+O+jpfG4HKhV/DinWQ9bJcumC0RyLtSeJYbIKj42nQ67tdYI4+f4S73Wo3+AnpvyCbZUiDqFhjRrk2/TfPxNMtU/jc6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807780; c=relaxed/simple;
	bh=wfUS29TNA0PUZEVSzi3dI4/bJmVSN8w1qz8NqY1T5ao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GE1I1d6ltT/MwY7L9W0nyUkOM7uaGADrxjeoLiXASPqJax6XUnKknCaOoaHd/HdCirmo8yR32zCnxxMRV2y/1uQbWpfwufsxgquWtpq0OLxC7B9Pk1E10Tdv/6wNzuP9CUP4QArUfoKH2TwsSYsIjP/cBcjZB6SHzaIC8HI4zVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kAazHZvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAazHZvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B551F0089B;
	Mon, 12 Oct 2026 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791807779;
	bh=vw7sAoAEQWg9zTio6fMY9TGGFg/EYZ8DSNM7PN3xXTs=;
	h=Subject:To:Cc:From:Date;
	b=kAazHZvw2Jr/vf9tOmi7UsiJcHXQzyTbdCPRSNKFlrZV5JrkGutTl2T7LO8RT2wSQ
	 Q76sDfOcdOj/ubiMSHQ3QFUg6oHnCTrcRnT0I5U5hzqL8wW7aVN/FP2/GGkUJRoE/5
	 +HiaS12xjHqL3jB+r/pJeAfxbhMBtf+UbDzlSw9k=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7603: initialize global station WCID" failed to apply to 6.6-stable tree
To: pcristian292@gmail.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 14:20:01 +0200
Message-ID: <2026101201-tidal-cinnamon-5943@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 456de496b53ae73e6e3020fec815dbdc88aa7c07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101201-tidal-cinnamon-5943@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 456de496b53ae73e6e3020fec815dbdc88aa7c07 Mon Sep 17 00:00:00 2001
From: Cristian Papa <pcristian292@gmail.com>
Date: Thu, 3 Sep 2026 22:07:02 -0300
Subject: [PATCH] wifi: mt76: mt7603: initialize global station WCID

mt7603 uses a driver-private global station WCID for frames that have
neither a station nor a vif, including frames injected through a monitor
interface. Unlike the core global WCID initialized by
mt76_register_device(), this WCID is published without ever being passed
to mt76_wcid_init().

Since commit 0335c034e726 ("wifi: mt76: fix race condition related to
checking tx queue fill status"), mt76_tx() queues every such frame on the
WCID's tx_pending or tx_offchannel queue and links its tx_list. The first
injected frame therefore reaches __skb_queue_tail() with an uninitialized
sk_buff_head and dereferences a NULL prev pointer.

Initialize the WCID before publishing it.

The fix was tested on an MT7603 PCIe device. Three wildcard probe requests
were injected through a monitor interface. The hardware queue head and tail
advanced from 0 to 3 and a second radio captured the third request over the
air. No oops or reset occurred. After restoring AP mode, a 150 MB transfer
also completed without a reset.

Fixes: 0335c034e726 ("wifi: mt76: fix race condition related to checking tx queue fill status")
Cc: stable@vger.kernel.org
Signed-off-by: Cristian Papa <pcristian292@gmail.com>
Link: https://patch.msgid.link/20260904010702.16306-1-pcristian292@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 10f2ec70c792..218ec406d2a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -230,6 +230,7 @@ mt7603_mac_init(struct mt7603_dev *dev)
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, MT7603_WTBL_RESERVED, -1, bc_addr);
+	mt76_wcid_init(&dev->global_sta.wcid, 0);
 	dev->global_sta.wcid.idx = MT7603_WTBL_RESERVED;
 	rcu_assign_pointer(dev->mt76.wcid[MT7603_WTBL_RESERVED],
 			   &dev->global_sta.wcid);

