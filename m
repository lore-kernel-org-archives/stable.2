Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342663;
	b=Neb06K2jCoHi9vNejbQEFUqMDL4xqXGEay35sAGc2TptFhPlcX+SfFMasdHXbUiOwQsU
	 5OSG/Po+s9NzCP1vNwV1hRTSqq41bbrbIweU4w7KMABbp2iATp88l+IXABCH6L60pWt7X
	 PeUX/o+abQvFSLw4Cm9HY8l7N5A4VwxrGTa5hiPUD34Pcmfa4JwBA5z2njovSgPOY84e0
	 Dmfpx04tU8eRxukcWpqHVZrDehNcX9TFbSucIMQVzuKK4RnhaaVlVv9aMpnobNxbNfzcH
	 gXohw/vTlpq2J3x4UzIjym7lcZyQOqZK/70102CVsHSGZ/rFboCBeR89YGOhL50eiPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342663;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vp3LyVa75/a+8DwQc4vopld6ITRB01LVZPaJRB4gGMc=;
	b=3W4opaJ9Vfdj+pEGKLSJ4BwQJfLmNzw3OfHxewa2ragr1WMlGRCPrnNO1Wk/eAWTyIZ9
	 m6hQFPXTWrkELZz2qSlj0a2+1BHpQYKdsS7zmVdgOPrY8LTjvq4DrB1t8AjBxVYCFyoV4
	 dZnB0Fv/kpdciC8IWDtn/26IgLzcfjYPWkLYKn2bf34W9RGZp+smmeGSKvxnb+Cg2aYxs
	 g6tFTUlVY0BGMLcqwY6hHsRROB4DHHlpkHRIsOcPAsOzS1QXuor4lOCxiWQuerjX8TPRx
	 x+O1ih/yk+dsjwSHavpSUxr1xeNNC5VYFL+AmBacv0OJFH+O+pP24+/CHnTJ3+rMLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=RoVll4vJ;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3A4EF606BA45
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4EF606BA45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=RoVll4vJ
Received: by dvalin.narfation.org (Postfix) id 25DB820317;
	Tue, 10 Nov 2026 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794342661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp3LyVa75/a+8DwQc4vopld6ITRB01LVZPaJRB4gGMc=;
	b=RoVll4vJO9cmu6WXxevOoK/7NyNmUd0kx67M8dF+jDg4lAuFG1L1gJZjnk+MDWWy7lnVbE
	9akhLe/G2/eG//d+oiv1QBOuIlDfnFJFB2mNpnlrBX2Y0Wl9I8hyCUYMfnP0RzPFFmt3tV
	2+O+1bhQh7C0hOPaLfhma32hocT54HA=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.15.y] batman-adv: stop originator purge worker before freeing TT
Date: Tue, 10 Nov 2026 21:30:57 +0100
Message-ID: <20261110203057.691765-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202020-failed-5.15-f89eda5a9ccf@kernel.org>
References: <20261109202020-failed-5.15-f89eda5a9ccf@kernel.org>
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
index 6d3d15332ff9e..717c4a1985fb5 100644
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

