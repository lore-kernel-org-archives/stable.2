Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447239C632
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551334; cv=none; b=VSNh1wa5KFUuDlHRo+OBaAWK/Sdy6h1cZTUcnvdnDipRd9TmLt7XIg3gFZ5Ms0pSvfOw8emAEr3SoQ6683TQ70f4K3dWyItHLwTxr2JM6ZM6sRJZL0Gm5s4E96reBIU5ogMtTI6D1U6FvbUyeWfsJqZQs89aU9dMaFBYoEyCX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551334; c=relaxed/simple;
	bh=F9gExmOQZo9bDQar10KrjIy7CSD4wG+pnKUemEn6Ki0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sH3NFd3Lq5h7J0Q/3M8bIVn5QWGrTZSMpBn6IPaC/DC8fDW4hRhYNyPu8nghuwWfnNQYt/65Izkx000F/F6UArFPNALlxUgmuLePKl/jtyWLHT2QuxSLMYJxd00iZpLWCTi7CP8w0oiOw42DYzAsaDwkYdFkFUwa2jwsahG+5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gdk25cG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gdk25cG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2541F00A3A;
	Mon, 20 Jul 2026 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551333;
	bh=33gnZGQBAdg5S0aNQ21YbVXzKriIeYBiPZMGMimeBO4=;
	h=Subject:To:Cc:From:Date;
	b=Gdk25cG8yNyoyTfdqb4tFWXHxt3MmJqVbcPxeOMzPRfqvDbAkGsRGqkB8Y1sqt2+/
	 jb6v4QMvPgRPaA+4k98Qe/Agbf/IdfambZ7tBAYXClqgSIQmqKEXbdcrShIsC+6GwE
	 bV6EEDKVCGuge8fUS2nKtokfTroITy6fNTDACBBg=
Subject: FAILED: patch "[PATCH] batman-adv: retrieve ethhdr after potential skb realloc on RX" failed to apply to 6.6-stable tree
To: sven@narfation.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:41:56 +0200
Message-ID: <2026072056-squatting-boss-26a5@gregkh>
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
git cherry-pick -x 035e1fed892d3d06002a73ff73668f618a514644
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072056-squatting-boss-26a5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

