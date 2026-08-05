Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82869471406;
	Wed,  5 Aug 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936599; cv=none; b=SbLxLcLowuExi3HVyWhg74jwbRjeAJ8mjS6aHD5HpVhxlIZJbEOHmi6AK8awPfjt80fvdrIOU6//uuV4QFz4xmrOuYT1JwPiYLesZqHjdjimya4Rv7B349vrpnU9t70CeDJVLBS2+fjO0QKeIGdTjejOeDdvIdvJ/OzTXq80MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936599; c=relaxed/simple;
	bh=6iqn5fp1t88pzCb8MJ2UXey1PeGVxwxqC1sMmRI2dqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pin3mh/k/5AgVgFIKLqhQIiA6vbsHWXBFCE4ixdZZmsdavsDRFyYeY7NJky1xjIsi7ijKpJWJ/X5P0FV42Mh/3QI/q1U2i+2JehbQb2pjkRxTiw3ajBFeacLz65LrbZPIzevXkjDpxB6SzZpBS+nsFrjIgME02KFBfFImkb/JQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyL+ZMBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyL+ZMBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B1F3C2BCFC;
	Wed,  5 Aug 2026 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785936599;
	bh=6iqn5fp1t88pzCb8MJ2UXey1PeGVxwxqC1sMmRI2dqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FyL+ZMBJh5BjTR/jz2TpwW90t2qrkKpuYAk88HH5IysdOzkpc4mk1K2T3p4es+MTL
	 gRPMW0FhipZVHVpZ1GYQqL4U9wg3k9O3pRgvtjQ6JtpB81/gR1VZmNlK4D+sn4sOXM
	 cH1zgtcqWPZduHOe5spDpY/BuW9C1OHvpI5dNUaUfUmUJv/7lpPax6ptNPxG/M/EUN
	 vD2QnbDUrS+AeUqWoP+NXRJS5djJO6Ki3P4BFId4Ec1gagXIiqWZ8FwIpl+g+ji/34
	 UrMWFakY/GxmXRzL+kd3wtzd6xhbbneWsJOBagBaYDtRtX7InaL/OJX9rgJALRHFYf
	 W90sXXURSpi2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18217C55174;
	Wed,  5 Aug 2026 13:29:59 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 05 Aug 2026 21:29:37 +0800
Subject: [PATCH net 2/2] ovpn: don't re-hash a removed peer on float
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-ovpn-fixes-v1-2-763f8c237fb9@outlook.com>
References: <20260805-ovpn-fixes-v1-0-763f8c237fb9@outlook.com>
In-Reply-To: <20260805-ovpn-fixes-v1-0-763f8c237fb9@outlook.com>
To: Antonio Quartulli <antonio@openvpn.net>, 
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=TNob32RUD1q+jLQJNBoNmFv017reaFPJPazB8n2U7SU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrGKrq47RCv6zixunbJ1qGlVSt9/va9jCY3kPQiRCn
 rJ1bev4s6KjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJtLox/CbbYfdB+fambaO
 /9vCY9Lvfuz3YF+h8KN/V8T2w3031Do2MDJsvfWkd89Pm+z0ud0PJ+/czBKv8eHR0/mX2P9m7Kz
 rvT2THwBJNFBQ
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

ovpn_peer_endpoints_update() releases peer->lock before sending the
float notification, then re-acquires ovpn->lock and peer->lock to move
the peer to its new bucket in the by_transp_addr table. The only
re-check in that second critical section is for a NULL bind, which
cannot detect removal: bind is cleared by ovpn_peer_release() only
after the refcount drops to zero, and the RX path holds a reference
across the whole float.

Both paths take ovpn->lock, but that only serialises them - it does
not order them:

  CPU0 (RX softirq)              CPU1
  ovpn_peer_endpoints_update()
    spin_unlock_bh(&peer->lock)
    ovpn_nl_peer_float_notify()
                                 ovpn_nl_peer_del_doit()
                                   ovpn_peer_remove()  <- unlinks peer
                                   unlock_ovpn()       <- drops last ref
    spin_lock_bh(&ovpn->lock)
    hlist_nulls_add_head_rcu()   <- removed peer re-linked

ovpn_peer_release_rcu() then frees the peer without unlinking it again,
leaving a dangling node in by_transp_addr that every later datagram
walks in ovpn_peer_get_by_transp_addr():

  BUG: KASAN: slab-use-after-free in ovpn_peer_endpoints_update+0xa5a/0x1010
  Write of size 8 at addr ffff888008576858 by task trigger/78

  Call Trace:
   ovpn_peer_endpoints_update+0xa5a/0x1010
   ovpn_decrypt_post+0x212/0x1040
   ovpn_recv+0x2b6/0x540
   ovpn_udp_encap_recv+0x21c/0x420
   udp_queue_rcv_one_skb+0x1060/0x11a0
   process_backlog+0x451/0x600

  Freed by task 0:
   kfree+0x11a/0x390
   rcu_core+0x7aa/0x1570

  Last potentially related work creation:
   call_rcu+0x82/0x720
   ovpn_peer_release_kref+0x5c/0xd0
   ovpn_nl_peer_del_doit+0x355/0x550

Fix it by extending the existing early return to also bail out when the
peer is no longer hashed by ID. hash_entry_id is unhashed with
hlist_del_init_rcu() by ovpn_peer_remove() under ovpn->lock, which the
float path holds across both the check and the rehash, so a peer that
passes the test cannot be removed before it is re-linked.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ovpn/peer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a21d02ac715e..03886c46ec85 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -302,7 +302,12 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 		spin_lock_bh(&peer->lock);
 		bind = rcu_dereference_protected(peer->bind,
 						 lockdep_is_held(&peer->lock));
-		if (unlikely(!bind)) {
+		/* peer->lock was released above, therefore the peer may have
+		 * been removed in the meantime: ovpn_peer_remove() unhashes
+		 * hash_entry_id under ovpn->lock. Re-linking a removed peer
+		 * would leave it reachable after it has been freed.
+		 */
+		if (unlikely(!bind || hlist_unhashed(&peer->hash_entry_id))) {
 			spin_unlock_bh(&peer->lock);
 			spin_unlock_bh(&peer->ovpn->lock);
 			return;

-- 
2.51.2


