Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580112DF719;
	Wed,  8 Jul 2026 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550819; cv=pass; b=QYjAYM+ZPAhUyYHUfPajG5D+Mx6WVeu2g+oy9sW6GjrKF5IRFMGsfCKDfzT873Wupv2ops8hLatGZ+2A47YCyGaqBE12QBijCUKC7SKwf3ePXu7Bw5QqGt18j+j2qD39WmJpoCtyPtBpyv7Mmw8ZaBTGwQxH6wpiQrU/w4e674s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550819; c=relaxed/simple;
	bh=jILP5Z6OPK8gxpQC2+iS4tCb6I25ZrP2gErb2RMG+f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+MZbOIMDVmrPi1OaWLcHoso7SL/PGjcfxaTTH5soUuJF+yqVnq0wAnyJVwVokPvmfMsbt46k6uO/z3O7idXCzsFDz+85oaeL05wNeVmYX6Z3xymm7n9ESqjrl4XMrl8/dcT/ADpZ23SPhfd3RQUV6Ds56HSNgwvPIKKiFq4Gt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=hapswX3h; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="hapswX3h"
ARC-Seal: i=1; a=rsa-sha256; t=1783550795; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=I69ImU8dBtqEfzcFa7JxisF1ng3nCovGaDDcVl7ESwqq1aOCdrTodJ3X6LjsA8mWj7mUpzUVqVVeiV/Xq1RXUBgmDOdcxFerpC3DP46zyoZv8swwUbpgJ2ydblc7dIi1rapBsy9oPpaqlDl7h32hooIZjjaV5XYSHbrIUrdQLfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783550795; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YHo7QS+KZ7ArRwLLv3UorwxU8L3SjC/F1OjeKqTwFiw=; 
	b=MWmeEH5AzwfUxjrq9/Ujfegy82OUZ2OwrebaIep0mYaJYFfuR0DDs3NNVo8cSt38+7gnzpXSHXNsOStmWRDbyPaULI7RNpek+3HAd8AWqKkNyjLzrwfUq7hZ6YBAmld+wEEYt18C+hTffmf0f2iUihY1L72ZVlabAFiNac74M1U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783550795;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YHo7QS+KZ7ArRwLLv3UorwxU8L3SjC/F1OjeKqTwFiw=;
	b=hapswX3hoKdCdOpiapMAVs26P/SrH9CKwTX92Yl0waCvf4StFVpqTPKPql78j/th
	jhxA2IJzzaJBTe7MCLSooI0HMXMaVU88eNm4XWoMogu9ihmTA3Q3jG93wczieI58lz/
	gUHtl6QnDPWooIuCH/+unf6RZgtWwQ4jpRx34eHc=
Received: by mx.zoho.eu with SMTPS id 1783550793953780.7520409843604;
	Thu, 9 Jul 2026 00:46:33 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ovpn: prevent UAF re-add to by_transp_addr on float-vs-delete race
Date: Thu,  9 Jul 2026 00:46:31 +0200
Message-ID: <20260708224631.1365-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ovpn_peer_endpoints_update() reacts to a data-channel "float" (a
peer's packets arriving from a new source transport address) by
first committing the new endpoint under peer->lock, then dropping
peer->lock, and only afterwards re-acquiring peer->ovpn->lock and
peer->lock to rehash the peer into peers->by_transp_addr:

	spin_unlock_bh(&peer->lock);
	ovpn_nl_peer_float_notify(peer, &ss);
	if (peer->ovpn->mode == OVPN_MODE_MP) {
		spin_lock_bh(&peer->ovpn->lock);
		spin_lock_bh(&peer->lock);
		bind = rcu_dereference_protected(peer->bind, ...);
		if (unlikely(!bind)) {
			... return;
		}
		...
		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr, ...);
		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
		...
	}

Between the spin_unlock_bh(&peer->lock) and the re-acquire of
peer->ovpn->lock, this thread holds *no* lock on the peer at all. If
an OVPN_CMD_PEER_DEL arrives in that window, ovpn_peer_remove()
(which only requires peer->ovpn->lock) runs to completion: it
unhashes the peer from every table, including by_transp_addr, and
queues it on the release list. peer->bind is only cleared much
later, when the peer is actually released, so the
"if (unlikely(!bind))" check performed after re-acquiring the locks
does *not* observe that the peer has already been removed.
ovpn_peer_endpoints_update() then proceeds to unconditionally re-add
hash_entry_transp_addr, resurrecting the already-removed peer in the
by_transp_addr hash table. Because ovpn_peer_remove() itself guards
against a double remove with
"if (hlist_unhashed(&peer->hash_entry_id)) return;", nothing ever
unhashes the peer a second time. Once the in-flight RX packet that
triggered the float drops its reference and the refcount reaches
zero, the peer is kfree()'d via RCU while still linked in
by_transp_addr. The next matching lookup in
ovpn_peer_get_by_transp_addr() walks that bucket and calls
ovpn_peer_transp_match(), dereferencing the freed peer's ->bind
*before* ovpn_peer_hold() is attempted -- a slab-use-after-free read
on the RX softirq path, runtime-confirmed under KASAN (715
independent "slab-use-after-free in ovpn_peer_get_by_transp_addr"
reports, kmalloc-1k / struct ovpn_peer, freed by the RCU callback,
read from udp_queue_rcv_one_skb -> ovpn_udp_encap_recv ->
ovpn_peer_get_by_transp_addr).

Fix it the same way ovpn_peer_remove() protects itself against a
racing double-remove: after re-acquiring peer->ovpn->lock, check
hlist_unhashed(&peer->hash_entry_id) before touching
hash_entry_transp_addr. ovpn_peer_remove() only mutates the peer's
hashtable membership while holding peer->ovpn->lock, and this check
is performed while we hold that same lock, so the observation is
race-free: either the remove has already happened and hash_entry_id
is unhashed (in which case we must not resurrect the peer and simply
return), or it has not happened yet and cannot happen until we
release peer->ovpn->lock (by which point the rehash under this lock
has already completed). This mirrors the existing double-remove
idiom in ovpn_peer_remove() (drivers/net/ovpn/peer.c) rather than
introducing a new locking primitive.

This is a minimal, targeted fix for the float-vs-delete race; it
does not attempt to shrink the lock-free window itself (peer->lock
is still dropped around ovpn_nl_peer_float_notify()), only to stop
the rehash path from acting on a peer it can no longer safely assume
is still part of the peer tables.

Runtime-verified on a v6.19 KASAN-instrumented kernel: a reproducer
that races authenticated-peer float traffic against a concurrent
OVPN_CMD_PEER_DEL reliably trips a KASAN slab-use-after-free read in
ovpn_peer_get_by_transp_addr() before this fix, and the same
reproducer no longer triggers it once this fix is applied.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/net/ovpn/peer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..aeb69f0b06fa 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -307,6 +307,28 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			return;
 		}
 
+		/* Guard against a peer that was concurrently removed (e.g.
+		 * OVPN_CMD_PEER_DEL -> ovpn_peer_remove()) while we held neither
+		 * peer->lock nor ovpn->lock, i.e. in the window opened by the
+		 * spin_unlock_bh(&peer->lock) above. ovpn_peer_remove() only
+		 * unhashes the peer and queues it for release: peer->bind is
+		 * not cleared until the peer is actually released, so the
+		 * !bind check we just did above does not catch this case.
+		 * Blindly re-adding hash_entry_transp_addr below would
+		 * resurrect an already-removed (and soon to be freed) peer in
+		 * the by_transp_addr table, causing a use-after-free the next
+		 * time that table is walked. Reuse the same
+		 * hlist_unhashed(&peer->hash_entry_id) test ovpn_peer_remove()
+		 * itself uses to detect a duplicate removal: ovpn->lock is
+		 * held here too, so this observation is race-free with any
+		 * in-flight or future removal.
+		 */
+		if (unlikely(hlist_unhashed(&peer->hash_entry_id))) {
+			spin_unlock_bh(&peer->lock);
+			spin_unlock_bh(&peer->ovpn->lock);
+			return;
+		}
+
 		/* This function may be invoked concurrently, therefore another
 		 * float may have happened in parallel: perform rehashing
 		 * using the peer->bind->remote directly as key
-- 
2.50.1 (Apple Git-155)

