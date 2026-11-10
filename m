Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336720;
	b=PPSIBYmUXOlietcZWp4LBDXxoKs12kboirUjvgTgSVvYmqrXjmK2fRHfmSSTqiJVd9kH
	 5vzmS40/6h1mexPbpGs3XF59Wal3k+ewVaWS2CxZhJNYyWI5vBcmxevIetO2sXRYjgZMp
	 zsxR9jbS6sf64CREWwbzL0nus3310i9v5vQdW2X8KonjhOmWjCnDb9tdg+8zwzBKivpU+
	 kTy9AcSM2+sGO51Bl6Y6rtd5JnOSSeIbSrkjNuEK0Vu8h/0WiATiu3ma8b+AqE45/wdbc
	 BYvfnNX4gMZSVQfD08u2rnkjjzcziQ0QIK1323fc/Utu7qh41vZnL/qsqNk53yid4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336720;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g1kVWFsclHhKnnin/6eVab000S8tj6K/xOueEtkCI9A=;
	b=Q3SWc58jugQY17vovVoM19wN5aY/OPkmhYETJQ8BxA+XanF9/SlV4C6jIliUz1c4HLUY
	 wGwL9Q/TrXrZXr4R7ydJTYVUHc924DwPKgna9YjEvELshJ2e9WAN+NUdtyS26N8uZMa6I
	 cGgljgfGsrZX2nGWTHBAVxu++T/lig7RFO+tAL5/ZYLg9CIVly0n2uy7Gv9tUq4enbl6f
	 m/ZFmwfGNM06mu3vSR+K2n+CLnzXL5w8uoirYsWVsIiBoGxvEiCT8CXT105RshrEyU5EY
	 Hx4PkJHf59K+25ppQZuzP5zZtk1SGEANGPCNS7H1t94b7Ob33E3PFPnaO0L6UizQxTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=pO82LHaw;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 485D1606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485D1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=pO82LHaw
Received: by dvalin.narfation.org (Postfix) id 8EA4D20FF9;
	Tue, 10 Nov 2026 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1kVWFsclHhKnnin/6eVab000S8tj6K/xOueEtkCI9A=;
	b=pO82LHawygyRihLoF+u4DHp4sQsVC/mhfd9VSX60zEynAjMPjSKjmJYv87gag/4jQqcXoj
	CcMlyrLY2KlUHveef9w8Vlf4+AQ5VB5MoQDGRKd5aAu+AgjIZWQO4DL4qwA+HuWB6hYbHM
	TJnKp5RsWNslolXpgV6vJsTP/OCOFUE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Tue, 10 Nov 2026 19:51:54 +0100
Message-ID: <20261110185154.76707-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200227-failed-6.18-c5d68abe6e7f@kernel.org>
References: <20261109200227-failed-6.18-c5d68abe6e7f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c5d68abe6e7f1dbd132a602cb696fe1fff0389eb upstream.

A received TT change (OGM diff or full table response) with the ROAM flag
but without DEL is handled by batadv_tt_global_add() like a ROAMING_ADV:

* a newly created global entry gets BATADV_TT_CLIENT_ROAM and is
  therefore excluded from the global CRC. The sender has it in its local
  CRC and the receiver has to request the full table again
* batadv_tt_global_purge_local() removes the local entry of the
  receiver. The receiver's own client is considered as roamed to the sender
  and frames for it are rerouted

The ROAM flag only has a meaning together with DEL. Drop it on reception to
keep it from populating the global table with a temporary ROAMING entry
which is not part of the CRC - and therefore causing a CRC mismatch.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3f0b26ad699c0..c73596ef6160c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3268,20 +3268,29 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 {
 	int i;
 	int roams;
+	u8 flags;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
-			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
+		flags = (tt_change + i)->flags;
+
+		if (flags & BATADV_TT_CLIENT_DEL) {
+			roams = flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
 					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
+			/* an announced client cannot have roamed away from
+			 * orig_node. Only a ROAMING_ADV is allowed to add a
+			 * global entry with the ROAM flag
+			 */
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
 						  ntohs((tt_change + i)->vid),
-						  (tt_change + i)->flags, ttvn))
+						  flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
-- 
2.47.3

