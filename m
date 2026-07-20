Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136E3FD946
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551339; cv=none; b=sFEnmXS6ZfhzuSbDQmBwwcR3e3N/zmdwApgScJa3vFylgVcSI7q9D3a0g4mJVhEsWkDWSFcg/MKEmyKABVx80osQ8y80NkN5yHyEs3RJgz1ZbahyodtKyO8zOaYR2g/OipOwmUIbvOHEnN7+AZ4C6sfha7MF9WkazZQmcda7FHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551339; c=relaxed/simple;
	bh=i2ojiC1BHpTPpnQph6FO3p3sAV1/MIgR9peimhNh+DY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dQ43NUNP0oz/841qh6qdZbS4+KSOCYoV3j96utzKE2OWU0ObQnNOamv88TmOx/ONIzXItnvC0NRpJvR/02yiiSM7UyXTg0bzkWif0tTT6kPVJArzLiAo3gyQZF/YlZ9KH+i1jn+QBLnjO+yOwjqUj3HY7M/Qel1y+XWhsKVyYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AHG+43qj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AHG+43qj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A431F00A3A;
	Mon, 20 Jul 2026 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551338;
	bh=GLvJDdTTHk6b4zIEhqerO2hbu/kt2p3cVsiFxRhxovs=;
	h=Subject:To:Cc:From:Date;
	b=AHG+43qjvzKJnqUK0OwnhD9wGa08pum5nCFSuSGrC0PVhyvvAHpvsRnowEEY5sKIW
	 5JpMTxHVlpkCo8+VmF8v24n+bf2j77YauBhVw8Jk/ub5ug5vgVS62LuA+kQqdr9jYK
	 TbJ9vptntUQodkI2cr8jhmMdzZ/4pkIlYA08lTjo=
Subject: FAILED: patch "[PATCH] batman-adv: retrieve ethhdr after potential skb realloc on RX" failed to apply to 5.10-stable tree
To: sven@narfation.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:41:57 +0200
Message-ID: <2026072057-equate-alfalfa-df1b@gregkh>
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
git cherry-pick -x 035e1fed892d3d06002a73ff73668f618a514644
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072057-equate-alfalfa-df1b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

