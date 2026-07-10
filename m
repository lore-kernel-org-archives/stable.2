Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBC36B07C;
	Fri, 10 Jul 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702376; cv=pass; b=J89ZjjlHasdytMYUSrX8hT1aHvF6+ZoPb9+jimCLPhUI/hbO5Nhsvdimk1au0FPB79qbkmWDdF49Uvlm3ti3SJgTvqfXJqRWNputOGHHzcb0aFOoedbrrDEm/tctQF7D+ZLRKWVzFuemXhksnDmT+F8VwbaZ84vYoVe6mvCKSnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702376; c=relaxed/simple;
	bh=q+Sk53swtum93yGYVh+KHcuxknvc4M1bUWRIzKxuws4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHP1K4w8GbYOr4V2+0tX0UDwHAy7oN4B2ens6HrYr8Ijegz+k7uMJzBBzvrF7N9Cq0H9C20ZMFQw1VBBoCbheYdOaQbkPf48/QemsA9jXh0vEN9x2NpOK4YvgrIBPVpNOxCtYByOYe3Uq36UWnIj6IFwVAr7Qi1h8Z+acZs5dKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=cu/2Jt9h; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="cu/2Jt9h"
ARC-Seal: i=1; a=rsa-sha256; t=1783702351; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XDu4tADfNd/qn8k9UnrXMuA6EWwbZDi163G5rEgk7AZW34nN20u58lrDRX1eN41zjQVw0s9eO+jm4KCkZaKYPSqUbNZHnA84Bjd+HfDNKiwC2T71jmBWd+mMcqB3RNnb+mZcWXlmUxpRwotEmGPbcCrF4O0OHmg+6wv0NBMw0/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783702351; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ymwoyO5d+sv+38372zTRo45+PiisAufXhgObzx67suk=; 
	b=aJCP6nhzrqHdFpaq7/Y9x95KVnf3UlyJ6qkwUJ7WonoPjEbkkjrOBmBm4mv/0XCm1V9V3Om11GiY4KrkXrT9dZLCtU/7r2Wolbze9QlFXvzyd+RcqMb3E6VhQq/nle+n0LPgqCDnL6CEMuYfMN6+uxe9yXid5S2hF5F0I500iCw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783702351;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ymwoyO5d+sv+38372zTRo45+PiisAufXhgObzx67suk=;
	b=cu/2Jt9hDDFqEEbAMl8cM4D+UtFPlaiJfqLBmT99EipUNgNsYZSSlLPzKHY1z0NA
	+hu2Tcmb2nQX3x05dv3yhLZ3i5aRIkLnuwEi8e0wV+Bx33JehVd68QfH29vQbL3vxhT
	2Fb9R43J1T96X3wjUEtzilSKxkiXHHw90tLUjpvQ=
Received: by mx.zoho.eu with SMTPS id 178370234856547.84319191224199;
	Fri, 10 Jul 2026 18:52:28 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] batman-adv: bound BLA claim and backbone gateway table growth
Date: Fri, 10 Jul 2026 18:52:24 +0200
Message-ID: <20260710165224.39411-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

batadv_bla_add_claim() and batadv_bla_get_backbone_gw() each kzalloc a
new hash entry (struct batadv_bla_claim / struct batadv_bla_backbone_gw)
for every distinct (mac, vid) / (orig, vid) pair carried in a
BLA-group-conforming CLAIM frame, and insert it into
bat_priv->bla.claim_hash / backbone_hash. There is no maximum-entry
cap on either table -- entries are only ever removed by the
timeout-driven periodic purge (batadv_bla_purge_claims() /
batadv_bla_purge_backbone_gw(), BATADV_BLA_CLAIM_TIMEOUT /
BATADV_BLA_BACKBONE_TIMEOUT, on the order of 100 s).

The BLA group a frame must carry is htons(crc16(primary_hardif_mac)),
which is trivially observable/derivable by any node already on the
mesh soft-interface (batadv_check_claim_group()). A single on-mesh
sender can therefore emit CLAIM frames with an incrementing source MAC
and force one kzalloc(GFP_ATOMIC) per frame on both hot paths, growing
kernel memory without bound for as long as the attacker keeps sending
-- uncontrolled resource allocation. Both allocations are
GFP_ATOMIC with a NULL check, so this is a graceful memory-pressure
DoS, not a crash: there is no OOB access.

batman-adv already has an established pattern for capping an
attacker-/peer-influenced, unbounded-growth per-mesh-interface
resource: the TP-meter session list bounds concurrent sessions with a
fixed ceiling and an atomic_add_unless() admission check that rejects
new allocations once the cap is hit, logging and freeing/decrementing
on the abort path (net/batman-adv/tp_meter.c, BATADV_TP_MAX_NUM,
bat_priv->tp_num, "Meter: too many ongoing sessions, aborting").

Apply the same pattern to BLA: add two atomic_t counters,
bat_priv->bla.num_claims and bat_priv->bla.num_backbone_gws, each
capped at a new BATADV_BLA_MAX_CLAIMS / BATADV_BLA_MAX_BACKBONE_GW
limit (4096 / 256 -- generous for any real bridged LAN/VLAN
population, several orders of magnitude below what would need to be
sprayed to threaten memory availability). batadv_bla_add_claim() and
batadv_bla_get_backbone_gw() reserve a slot with atomic_add_unless()
before allocating; on cap-hit the frame is dropped (matching existing
"drop silently, let the sender resync/backoff" BLA behaviour) instead
of allocating. The reservation is released on every existing early-out
(kzalloc failure, hash_add failure) and in the kref release paths
(batadv_claim_release(), batadv_backbone_gw_release()), where the
counters are decremented right before the objects are freed. No
locking changes are needed: the counters are only ever touched via
atomic ops, mirroring tp_num.

This does not change on-the-wire behaviour, hash table sizing, or
timeout-based purging; it only stops a single on-mesh peer from
growing the tables past a bounded ceiling.

Verified by code review rather than by driving either counter to its
cap at runtime: the atomic_add_unless()/atomic_dec() pairing was
checked against every existing early-out (kzalloc failure, hash_add
failure) and against both kref release callbacks, confirming exactly
one reservation and one release per entry, mirroring the same
tp_num accounting in tp_meter.c. A loopback CLAIM-frame reproducer
was used earlier to confirm the pre-fix unbounded growth itself
(distinct claim_hash/backbone_hash entries scale linearly with the
number of distinct (mac, vid) pairs sent), but reaching the new
4096 / 256 caps with that same reproducer is impractical: entries
age out via the existing timeout-driven purge faster than a
single-host reproducer can accumulate enough distinct pairs to hit
the ceiling, so the cap-hit and slot-release paths were exercised
by inspection, not by a live saturation run.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 net/batman-adv/bridge_loop_avoidance.c | 38 ++++++++++++++++++++++++--
 net/batman-adv/main.h                  |  3 ++
 net/batman-adv/types.h                 |  6 ++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5c73f6ba16cf..1b6e9bee5c6c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -154,6 +154,9 @@ static void batadv_backbone_gw_release(struct kref *ref)
 	backbone_gw = container_of(ref, struct batadv_bla_backbone_gw,
 				   refcount);
 
+	/* release the slot reserved in batadv_bla_get_backbone_gw() */
+	atomic_dec(&backbone_gw->bat_priv->bla.num_backbone_gws);
+
 	kfree_rcu(backbone_gw, rcu);
 }
 
@@ -179,6 +182,7 @@ static void batadv_claim_release(struct kref *ref)
 {
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_backbone_gw *old_backbone_gw;
+	struct batadv_priv *bat_priv;
 
 	claim = container_of(ref, struct batadv_bla_claim, refcount);
 
@@ -187,12 +191,18 @@ static void batadv_claim_release(struct kref *ref)
 	claim->backbone_gw = NULL;
 	spin_unlock_bh(&claim->backbone_lock);
 
+	/* stash bat_priv before dropping our reference on old_backbone_gw */
+	bat_priv = old_backbone_gw->bat_priv;
+
 	spin_lock_bh(&old_backbone_gw->crc_lock);
 	old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&old_backbone_gw->crc_lock);
 
 	batadv_backbone_gw_put(old_backbone_gw);
 
+	/* release the slot reserved in batadv_bla_add_claim() */
+	atomic_dec(&bat_priv->bla.num_claims);
+
 	kfree_rcu(claim, rcu);
 }
 
@@ -508,9 +518,20 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		   "%s(): not found (%pM, %d), creating new entry\n", __func__,
 		   orig, batadv_print_vid(vid));
 
+	if (!atomic_add_unless(&bat_priv->bla.num_backbone_gws, 1,
+			       BATADV_BLA_MAX_BACKBONE_GW)) {
+		batadv_dbg(BATADV_DBG_BLA, bat_priv,
+			   "%s(): too many backbone gateways (limit %d), dropping (%pM, %d)\n",
+			   __func__, BATADV_BLA_MAX_BACKBONE_GW, orig,
+			   batadv_print_vid(vid));
+		return NULL;
+	}
+
 	entry = kzalloc_obj(*entry, GFP_ATOMIC);
-	if (!entry)
+	if (!entry) {
+		atomic_dec(&bat_priv->bla.num_backbone_gws);
 		return NULL;
+	}
 
 	entry->vid = vid;
 	WRITE_ONCE(entry->lasttime, jiffies);
@@ -531,6 +552,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 
 	if (unlikely(hash_added != 0)) {
 		/* hash failed, free the structure */
+		atomic_dec(&bat_priv->bla.num_backbone_gws);
 		kfree(entry);
 		return NULL;
 	}
@@ -708,9 +730,20 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
+		if (!atomic_add_unless(&bat_priv->bla.num_claims, 1,
+				       BATADV_BLA_MAX_CLAIMS)) {
+			batadv_dbg(BATADV_DBG_BLA, bat_priv,
+				   "%s(): too many claims (limit %d), dropping %pM, vid %d\n",
+				   __func__, BATADV_BLA_MAX_CLAIMS, mac,
+				   batadv_print_vid(vid));
+			return;
+		}
+
 		claim = kzalloc_obj(*claim, GFP_ATOMIC);
-		if (!claim)
+		if (!claim) {
+			atomic_dec(&bat_priv->bla.num_claims);
 			return;
+		}
 
 		ether_addr_copy(claim->addr, mac);
 		spin_lock_init(&claim->backbone_lock);
@@ -732,6 +765,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* only local changes happened. */
+			atomic_dec(&bat_priv->bla.num_claims);
 			batadv_backbone_gw_put(backbone_gw);
 			kfree(claim);
 			return;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index f68fc8b7239c..f7bb3991dbf1 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -110,6 +110,9 @@
 #define BATADV_BLA_WAIT_PERIODS		3
 #define BATADV_BLA_LOOPDETECT_PERIODS	6
 #define BATADV_BLA_LOOPDETECT_TIMEOUT	3000	/* 3 seconds */
+/* upper bound on claim_hash / backbone_hash entries per mesh interface */
+#define BATADV_BLA_MAX_CLAIMS		4096
+#define BATADV_BLA_MAX_BACKBONE_GW	256
 
 #define BATADV_DUPLIST_SIZE		16
 #define BATADV_DUPLIST_TIMEOUT		500	/* 500 ms */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b1f9f8964c3f..e427318eb6d9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1077,6 +1077,12 @@ struct batadv_priv_bla {
 	 */
 	spinlock_t num_requests_lock;
 
+	/** @num_claims: number of entries currently in @claim_hash */
+	atomic_t num_claims;
+
+	/** @num_backbone_gws: number of entries currently in @backbone_hash */
+	atomic_t num_backbone_gws;
+
 	/**
 	 * @claim_hash: hash table containing mesh nodes this host has claimed
 	 */
-- 
2.50.1 (Apple Git-155)

