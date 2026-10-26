Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004803;
	b=PggsgyUBh6JGiPWhDpKaUKvdH5VfKrA3CHMnge4BhaBiez+0qpLbkVe21VLPe7LwoNco
	 0/7icorNNOMYwgOh43mF6F69Lw+T8GepLgsM+MUCvby4KgOaVDmFn+x7uQ6joVWLgAvhx
	 WNM22tbYhhEJG3RF8gi0iParW4PLgjwctXQYFCrIF+iPQr4/TO4nMsYKOwdLBkVzZYPez
	 bIF6j2omy8B/KBoFnP+1qtmGHuSOVPiGUFLxYbzPLSNX8GrO7MbujoX0JBlVOCMICeoB9
	 Q+erw49JhiwIcfVirruk7Fnbc6/X00YJrY39PPyT8RNZ4h925meKIZbKPu8xJxO6lHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004803;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
	b=RvR7kTloAMQEId+SuT6C5Vqn4J47JTrUASzQDoX2nqMlhIq8EKXvM731bGq5v4rQFkmd
	 0zGL13ly/vO7yWfBezJpz+Zgc8Yfsly/fWW8aNoRmWdZNT5+Xcl2bHVfI93OzOcVXIdx/
	 j0gguID2AyrMH0l7sxO+GhFGyGEud6FqEiYz5rNis1m8yUIR3k/VhZZ89ueiDXxxU/lh4
	 tYyO1ELZuLyNK42D6raS5nugTBzhbrKOw9dZhbmXUuvUlAPDN6ElTRsI+HRF5/vcNF92L
	 MFJwVJrQEQot+lJECP5CsSaXjpIhU/pU4nVJClXQPa9T5Swtc7amZAj2wqZz0xyphtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=gnraW2l4;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BD75D606A337;
	Mon, 26 Oct 2026 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD75D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=gnraW2l4
Received: from kero.packetmixer.de (p200300C5973CE5d80fc8dFe94a24022D.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 7384CFA1DD;
	Mon, 26 Oct 2026 09:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
	b=gnraW2l40+qdMqD9HFBkJ27iu1Qu1IJn9u1z+/kTnTSuPAAPHhp4zP7k1H/PgDM76lJMSu
	TlIux4U8I29V3Rx8PWOAIuJO90lbdv7WNOMJV9RZoY8dWIgWjuvTH/P58RtDAuK0bJAkrk
	hluiEFoI/0djs+4Fn6p/o4CB2kdgWVXTKlWxOr2N2+29pVoJwTB7oPKKjrKkoeiE1A+RQX
	6Av8+8IWIELXSVgnOSSJWZGB5uGhQ0zuL9dm1gYTpO/TKRpuIFewnEhi+HX7bXzEULCsj/
	+5yiFkfjT1maYhkHmbpZD/6ntl+2uEiNK48Njx+CSV2Ai4+Fu8FGIHwaM8xFsA==
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
Subject: [PATCH net 06/10] batman-adv: stop originator purge worker before freeing TT
Date: Mon, 26 Oct 2026 09:53:05 +0100
Message-ID: <20261026085309.1074911-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
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

