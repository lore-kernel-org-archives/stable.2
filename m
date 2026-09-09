Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C03ACA40
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980606; cv=none; b=krbfe2Ux6ch5Gk6OT53Kwex4a3JQpcFqvB4VYhTtKlHmiuvnNbUEWc3367hwGP8rUHoT2U5JMrYYSq8UaGx56X2WN6MhbloP1TdwPWHihZyNhRhOWIGSSZaN4Zl+Lc8T/rdFTpajbmYx5eaIpfyAee10ZFwaytxrcq2f3MKeKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980606; c=relaxed/simple;
	bh=ZSgsOy30N/F4/JIJih3TJteV86vAlAkIn1byk/sBCQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3PCnriTuOLn6R1UeXDZNCCaBQMpfpEycBctGpdp0K2c73w42Znk1HLKiTnTqXPiMRXyUoghwaeFMoi78ewuUIGRrzrLOrUesdeDilE4XHMW4frvgErFTv4/clwayHRoq4Kk6NmCJAVkmFmcULzHBaDWe4lOQ177a2svYMNdwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=eN/AeQzq; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="eN/AeQzq"
Received: by dvalin.narfation.org (Postfix) id 8B124203EB;
	Wed, 09 Sep 2026 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788980602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypfzkfZLSabP/BnhAj/kqLIXAE8cwDDa6CkkZhgdots=;
	b=eN/AeQzqecZacWO1zO5+CoivUuACZJl7goUeRPIzuXPeKglhBTOAG8PAaSiTXRSBNTfbbs
	Rp7F7xTrY5hsE8cu/q4EW1wklUHJJTb8bVeCkmFQbW/N2Se+B5oGVLwuzki1kIlr1Eb5GD
	ZmEs2tBEosjB8MEJ/F+nBRvufE0IFsw=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.1.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Wed,  9 Sep 2026 21:03:19 +0200
Message-ID: <20260909190319.1067807-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090943-monogamy-stoppage-de69@gregkh>
References: <2026090943-monogamy-stoppage-de69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 08645ab95768b88e2ff85a89211994651710465b upstream.

batadv_bla_add_claim() is used to add claims and modify the backbone of
claims for CLAIM frames from remote backbones and local packets. When it
handles a claim, it needs to either

* add the new claim's CRC to the backbone CRC
* remove the already existing claim's CRC from the old backbone and add it
  to the new backbone

But when the "new" claim code was running in parallel to the "change
backbone" code, it can happen that the CRC was invalid because the
backbone_gw of the claim was changed twice in the "new" claim code path:

* CPU0 creates the claim for gateway A and publishes it in the claim
  hash. The crc16 of the address has not yet been added to A's crc at
  this point.

* CPU1 processes a claim frame of gateway B for the same client, finds
  the just published claim, and performs the ownership change: it
  switches the pointer to B, removes the crc16 from A's crc - which
  never contained it - and adds it to B's crc.

* CPU0 continues behind the creation branch, unconditionally switches
  the pointer back to A without compensating B's crc (its remove_crc
  is false for the creation path), and finally adds the crc16 to A's
  crc

The CRC is then wrong for both:

* claim belongs to A: but CRC is not part of backbone A's CRC
* claim doesn't belong to B: CRC is still part of backbone B's CRC

This wrong CRC is never recomputated from the stored claims. For local
backbone claims, this can also not recovered using syncs.

To avoid this, split the functionality in clear separate parts:

* new claim which always adds claim CRC to the backbone CRC (but never
  changes the already set backbone_gw of the claim back)

* update of existing claim which automatically changes the backbone_gw
  entry and only updates both backbone CRCs when there was an actual change

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 65 ++++++++++++++++----------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ac12c06f11b89..448dd30cab262 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -698,12 +698,14 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim search_claim;
-	bool remove_crc = false;
 	int hash_added;
+	u16 claim_crc;
+	bool changed;
 
 	ether_addr_copy(search_claim.addr, mac);
 	search_claim.vid = vid;
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	claim_crc = crc16(0, mac, ETH_ALEN);
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
@@ -735,43 +737,56 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			kfree(claim);
 			return;
 		}
-	} else {
-		WRITE_ONCE(claim->lasttime, jiffies);
-		if (claim->backbone_gw == backbone_gw)
-			/* no need to register a new backbone */
-			goto claim_free_ref;
 
+		spin_lock_bh(&backbone_gw->crc_lock);
+		backbone_gw->crc ^= claim_crc;
+		spin_unlock_bh(&backbone_gw->crc_lock);
+
+		WRITE_ONCE(backbone_gw->lasttime, jiffies);
+
+		batadv_claim_put(claim);
+		return;
+	}
+
+	WRITE_ONCE(claim->lasttime, jiffies);
+
+	/* replace backbone_gw atomically and adjust reference counters */
+	spin_lock_bh(&claim->backbone_lock);
+	if (claim->backbone_gw != backbone_gw) {
+		changed = true;
+
+		old_backbone_gw = claim->backbone_gw;
+		kref_get(&backbone_gw->refcount);
+		claim->backbone_gw = backbone_gw;
+	} else {
+		old_backbone_gw = NULL;
+		changed = false;
+	}
+	spin_unlock_bh(&claim->backbone_lock);
+
+	if (changed) {
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): changing ownership for %pM, vid %d to gw %pM\n",
 			   __func__, mac, batadv_print_vid(vid),
 			   backbone_gw->orig);
 
-		remove_crc = true;
+		/* add claim address to new backbone_gw */
+		spin_lock_bh(&backbone_gw->crc_lock);
+		backbone_gw->crc ^= claim_crc;
+		spin_unlock_bh(&backbone_gw->crc_lock);
+
+		WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	}
 
-	/* replace backbone_gw atomically and adjust reference counters */
-	spin_lock_bh(&claim->backbone_lock);
-	old_backbone_gw = claim->backbone_gw;
-	kref_get(&backbone_gw->refcount);
-	claim->backbone_gw = backbone_gw;
-	spin_unlock_bh(&claim->backbone_lock);
-
-	if (remove_crc) {
+	if (old_backbone_gw) {
 		/* remove claim address from old backbone_gw */
 		spin_lock_bh(&old_backbone_gw->crc_lock);
-		old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		old_backbone_gw->crc ^= claim_crc;
 		spin_unlock_bh(&old_backbone_gw->crc_lock);
+
+		batadv_backbone_gw_put(old_backbone_gw);
 	}
 
-	batadv_backbone_gw_put(old_backbone_gw);
-
-	/* add claim address to new backbone_gw */
-	spin_lock_bh(&backbone_gw->crc_lock);
-	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
-	spin_unlock_bh(&backbone_gw->crc_lock);
-	WRITE_ONCE(backbone_gw->lasttime, jiffies);
-
-claim_free_ref:
 	batadv_claim_put(claim);
 }
 
-- 
2.47.3

