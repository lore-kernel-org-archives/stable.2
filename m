Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5593DEAE3
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551342; cv=none; b=iduQ9v6G6gTxileLszsa/GMUnlJLrbAwrFTd+5uZjUEvYhU4ZodkDIGtyxt2RRW8socVrb2H9d9S+5qgGwzHdHbg42J6GWyyCOyjEn13BBSMu014xTLfX9VUXLglZZmYEwGzr6jsRputHUYEf80kKxp8tMm5GGH8C4ssTwtSiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551342; c=relaxed/simple;
	bh=IWBhJv3AIBA1TZK1RkQrqE+oumqADeGK7Lv1G95/mIY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=avw3iUsve+W13lB20cSepgh0Y1QoaXQDX00GtMJ/g9ZGxe08nW2tkND4JTaOlm+BM3PzrOasZcgk2MzEeWok4Px/UDVd7jDobLEOW8JOT5AKAEVSoJN8MXdyHYQjljURl5lLxml3c3o3mph0gKeKw5pBt6DiFDYpxtVUcJWTQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HFHv+p6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFHv+p6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC3F1F000E9;
	Mon, 20 Jul 2026 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551341;
	bh=8BTrwCUdKBdXdMGYirgNZo+/aiQDSViMq3ULiIxKMf8=;
	h=Subject:To:Cc:From:Date;
	b=HFHv+p6q/yg8WHYuKbiueFbWpgcjNA9C0zp5QOdy63dzNO+O6w9sbmCYQ2n5vVmxL
	 ZfIS/flKYK4m7b8QGcQO4T2ieCfkEsHg/plA/qKy8zTogMpdhBqvMEfMLXONbBL8K2
	 cR1DaQRN4Vu6jh5fNuhSAr6h0Rl0x2IWFE6QbwGY=
Subject: FAILED: patch "[PATCH] batman-adv: retrieve ethhdr after potential skb realloc on RX" failed to apply to 5.15-stable tree
To: sven@narfation.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:41:57 +0200
Message-ID: <2026072057-food-spender-efd0@gregkh>
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
git cherry-pick -x 035e1fed892d3d06002a73ff73668f618a514644
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072057-food-spender-efd0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 035e1fed892d3d06002a73ff73668f618a514644 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 06:44:13 +0200
Subject: [PATCH] batman-adv: retrieve ethhdr after potential skb realloc on RX

pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the VLAN header but missed for the ethernet
header which is later used for the TT and AP isolation handling.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: c78296665c3d ("batman-adv: Check skb size before using encapsulated ETH+VLAN header")
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 44026810b99c..511f70e0706a 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -434,6 +434,7 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */

