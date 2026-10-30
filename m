Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368293;
	b=B5pQq9vOX6ci1945Lr41jZK2+mbL082HDkVJ3NCwEbcIF4kqUalsg3G3KBy4wCTcy77F
	 SVDnO0vGo5LvIZpw3OJPN9qne01WyJbsq4QwD76jSrpayej+jvQJabBU1jBNIBTvOS6In
	 Y38fUVT5LSe64f+BK7PZ+8SWBOjCv/x4Y3HT7H34AWITssLjRyGwfxuvF7GyM0AyWFPtl
	 CrSctu35w/04sIeuK9lfNJeTaP+eLEtr6bD512oqEM91TLRVdUiawTX3Ny0lK+J4xCpIz
	 Kx2Z6npUqIJLMHqEcvi04NwHsL/UkwRhUTdwgJ0kN5diw3ElDMRUsgeR+jN1WcvW/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368293;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
	b=bnx/G/WDV3Ru3dMW7Ke2IuQooN3ez2JamfyyanJEzESdEzZKa+FnzHKkGDEAIjLOm2Zz
	 JoLm+RVEHP0xNKv7dFSTBpagDgJe7DfHTF4ODh3UhtfmlyLN7bcVUNqtbVLs4l9t8kBPs
	 0fT2o6rVN8W7/2tEdJrlqv9WBpYLGalajSVDzOTbIFD33NzdK6K7fWqJd1R3RJWYZU5sv
	 x99fFHdoTQZol+ZzAEcRuNck3dGcosy84RjGEeM2jrmCQpZqtCO+PxHrqkRusPh2u/Hkp
	 Pd7UJ54om3GV36BMB2AgcTlef0QACl/0Mz5umc/ISRieAzh4qmKhLbYJtpn2p0kFRXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ySC56UOh;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3775B606A333;
	Fri, 30 Oct 2026 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3775B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ySC56UOh
Received: from kero.packetmixer.de (p200300C597124fd839580c360d3ed6f6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 33787FA1CC;
	Fri, 30 Oct 2026 14:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
	b=ySC56UOhdXeYD5ZTai0+o7Hqc1KreHftBHMGenfMfKrr5qZFZ1s1HcAdvUZS5x7BhsYJ6F
	1TYZuDKNg7/in6jWbZBly3cY9N/k5zUrWFTAjLQN6v9k2Z4he3/yG2GcIsdHn5M3hHjAs1
	S+K3fEXz0JxfiiWt4Ll73xGkJ2U8PHadvPU/Oyv9yVGUzVyu2vz8CkpTJ64mkRfCjVRdWO
	0KlpGEFlPEcMEegdohPyHjlKctnNrDEQi0fCKdPOr8SPDoec9XJmmWTbNnqVmtMluyjZT3
	wCq/GmydpGiGXzsQPzdnYdaZo6Wqpy8OcF7UI7hWkpvR2d/kc3qyFwzx84WVIQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 07/14] batman-adv: stop originator purge worker before freeing TT
Date: Fri, 30 Oct 2026 14:50:58 +0100
Message-ID: <20261030135105.2555887-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

batadv_mesh_free() releases the translation tables via batadv_tt_free()
before batadv_originator_free() stops orig_work. The purge worker can
therefore still run while the TT is torn down. When an originator times
out, batadv_purge_orig_ref() calls batadv_tt_global_del_orig(), which
loads tt.global_hash and walks all buckets while taking their locks:

  CPU0                          CPU1
  batadv_tt_free()              batadv_purge_orig()
                                  batadv_tt_global_del_orig()
                                    hash = ...tt.global_hash;
    batadv_tt_global_table_free()
      batadv_hash_destroy(hash);
                                    spin_lock_bh(&hash->list_locks[i]);

Disable orig_work at the beginning of batadv_mesh_free(), directly after
the mesh was marked as deactivating. The second
disable_delayed_work_sync() in batadv_originator_free() is harmless because
it is free'd anyway.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708091821.314516-1-sw%40simonwunderlich.de?part=3
Fixes: 9d31b3ce8168 ("batman-adv: fix potential TT client + orig-node memory leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ced76942f33c5..3b9fa861be7be 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -295,6 +295,11 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 
 	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
+	/* the originator purge worker accesses (among others) the TT tables
+	 * and must therefore be stopped before any of them are freed
+	 */
+	disable_delayed_work_sync(&bat_priv->orig_work);
+
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
 
-- 
2.47.3

