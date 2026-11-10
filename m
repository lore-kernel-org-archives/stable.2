Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342390;
	b=t+wQ+ti5OWxC1ZN6lu2ZED2dythOFnAGq9H17bUzokeqWFTF5tuDi/qk4Racl7hTkqHE
	 XncgK3bJwzQlykY6AX0DZMMxFY2WDLt0Q4pRYVPrJOoFv5nJrkWASQM7VP/v34uzUws8x
	 u5mNuOttCdvDmSFPNrvqQSA5WnpIy4Q4LAD0MCThKECG+3wrYXMx2NsCeraWgnUA5Wsqr
	 ZEc4GsRnnDCS+I/42PyS8KwfHUjCLh0ij83A+rexMnWCbKBeAbuTbe1joIXdBR+hrrASd
	 SAwq6BtbSMt/A4s6HrVHsdNfIsCn74wzlnWVpJ4prOyvyvV1ZupWZwIHRM34HCSyskw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342390;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EfTyZLRJ/lcdfr+kHgw/qhbzSEy0cB7Nl7yK75mNxug=;
	b=N1wHiNiP2qGr/673CiWRjM0H3lwn+IaFHUzjLSbO5+PIYBWb4WDxt6uQHrDpClzhCH8O
	 xAd23XcXFfVBhSF15ee+uMCI9/5MZI12V1WJoI7ytn/1yr6e4hljza/dVs1cyBZ5WV5Qg
	 FyWxyyDF10Ub6IIq3ZhqzVZxpWXXjZXk9p5KDA5wEQea8zdCNeyWqMyVFVN6eEb9Goh/P
	 yLuvS+igS8p1uWhyQw7XRww2k46JNNLB+gncpM6gmIF/IxUC4uhBkbQXCklO9YfUcahF/
	 zkDroKUeM21fnvG3S00ReSUEgZUM6aRH3u/0vPIh15oSZIrPXj2Z12vEL/re8+V7v2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=HiuyYiha;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6CB44606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB44606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=HiuyYiha
Received: by dvalin.narfation.org (Postfix) id 24D001FE32;
	Tue, 10 Nov 2026 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794342388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfTyZLRJ/lcdfr+kHgw/qhbzSEy0cB7Nl7yK75mNxug=;
	b=HiuyYihaIc17J5DJOOF6DYF8ioRUI6WRJry31fmEolkXtgOGfSyNQ2lWS4609t5y4ihrU5
	oc40y5EPky23t+YoW6+xDIr80H0XXc36BFS+WCNazDgdtFOtcUe2xmYWRMhyunT4Rfxik+
	J5afqTpf5ews+AuM+SRoZCxf++kmiN0=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.6.y] batman-adv: stop originator purge worker before freeing TT
Date: Tue, 10 Nov 2026 21:26:12 +0100
Message-ID: <20261110202612.586196-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201041-failed-6.6-f89eda5a9ccf@kernel.org>
References: <20261109201041-failed-6.6-f89eda5a9ccf@kernel.org>
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

commit f89eda5a9ccf82cba06b085b42ebc4886b8dfe9e upstream.

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
[ Switch to cancel_delayed_work_sync() ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 48065fd09e1a8..fb8964d867349 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -262,6 +262,11 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
+	/* the originator purge worker accesses (among others) the TT tables
+	 * and must therefore be stopped before any of them are freed
+	 */
+	cancel_delayed_work_sync(&bat_priv->orig_work);
+
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
 
-- 
2.47.3

