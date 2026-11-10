Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342531;
	b=iQhyy+cOdN3ZtU6RcCd/DimXMtS42BLsW7Fb6usALPLpybyBYlSv5O4hhcxFCXz09x7t
	 NJQEFwrZCbz0awmszrfb1b9R5aYH5AaCcRNXGtbHtOa+PPsBaRgYVRmn3J1wZFG9+D8vK
	 C8oVBEYiqFkKL8kPwmXe/yqJbF/ZrLt/groGfjyuKo+dD4aRRBbYdYyMcDUic8F/KkSCO
	 XDVYaTxDAfbb8wPLXjizgb8uZxbDYj/oqfbFwDDTT37qVLlha8UW2uAj0/MWz6sT7UFax
	 Ia/0mVsdJgroQNsGc1Jqw1F4dJLPB3ToM43uQQPzipUWVYvyIqhxjzIzJqmBM6Pimng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342531;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EfTyZLRJ/lcdfr+kHgw/qhbzSEy0cB7Nl7yK75mNxug=;
	b=nBiVhhOQPu2+CxTo/SCHv6+cIdMQuBkSCnvZo+VoBUKZlMiCB8X9L9oO7uVdljCVG/+A
	 rM/dlxjpekTKBa3oRDD2l6NmQ/DjFww3UDcipvjLpXyadV2v//zqB9iOMaiZbPvYAeV/r
	 Bildvovnq8vr6J0H5VOWlcT9ef3Lhd+fwbjBgN/BA/kZjk3n4LdakE7vq5RK0Pv/H2Qsw
	 9Zg9E8SnkspTd4omWEAQ0U0kiCKFBoQmcVPksrd8Z5qtju44y+rzEu1hr2jzIGJsGnaa5
	 kLLO9LDG01MAVkzZFRv1OiwjMNNO5ODR+yNYPM7jOSMGiVjwjfpjJMdqPbBwrMtyk1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=FBwRF574;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DCB9A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=FBwRF574
Received: by dvalin.narfation.org (Postfix) id CE8B220317;
	Tue, 10 Nov 2026 20:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794342528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfTyZLRJ/lcdfr+kHgw/qhbzSEy0cB7Nl7yK75mNxug=;
	b=FBwRF574cv+UemoEHdmgIbYN1CBsApgsSUZyMueT0ZOyEG+RSqPWAnmXSMAV1Yj3Qxm0eC
	Ju+DvSuOtxp9sIKKpD5VH2GMyj4Cl3RbaL6Myq72xE4D95CPNm1gzDwH352RNr6dKbE3fU
	fi6z01Jx0MwTNaOTj70V4da9mU/ZQl8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.1.y] batman-adv: stop originator purge worker before freeing TT
Date: Tue, 10 Nov 2026 21:28:45 +0100
Message-ID: <20261110202845.644622-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201514-failed-6.1-f89eda5a9ccf@kernel.org>
References: <20261109201514-failed-6.1-f89eda5a9ccf@kernel.org>
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

