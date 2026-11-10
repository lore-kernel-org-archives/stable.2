Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342764;
	b=eSuwI9mP5cIt6PfXc4tMLLhRKewqlPUnERBgVxPBTDmiFAfbIjlbrUq1naGe04b3jzhT
	 vE3G5qN/VhBTfLgTLJIQKISGSBMxiR5IjHXqJ8eT3IJgO+5phWM482lIF/ay34f86SUNE
	 gMU2p6Z/kqD3b4pFGV8ChCCW/F4mXLCSQRR/B9bEvrW/Gm5dIY5m12S+Hp04WFx1ZZYxI
	 mXGbdt+lygq2HSnjM77EgYm9rOlABlBcOIWwf8i7EZDxwztAmrOrl1DMpXh2C+DD/axIM
	 p8iEx+9FkgdpLGv1Z0Bjv/2OFNwEnW+MLUqKkU764WD3KPVEEj22zjvBFEejMCJMjoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342764;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9aGpfxMribN8uWkk0NnZUHLaChmrCn6g06NgOy8ZpFM=;
	b=qBJ0GGEXF6ypLSnqMfBeIRNjQVwLf7YmWC2jLwLP3pytjCB6SG9Q8FU57pCM5i8AtouM
	 +7fgA4z0Qjh3V/KOQGBeUGJ9KL41qsYem51bIjKoGMrJ7sszVN5qFk7Aul+Fkw81cdZQ+
	 rkPsl1jtTMQIMPaYVjJL4DTjEEOZ3z5wQpL6wY3J84acVBKT0kXmC/S6bM+gcwMUOO6J4
	 DisjhHgBxfVy1Z1YPCwgHzkw//BAk25X+MHVfIehZa40R6tFpTz5j2lRrT6pouU5O2o7Z
	 4rFJoplQmJLuEiXTCbmyohPoYoCRD3QMx+UcIh0chtxxn/xYjxAAvOh+oM3kuxo9BnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=NWj+izLQ;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 98272606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98272606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=NWj+izLQ
Received: by dvalin.narfation.org (Postfix) id 5904020292;
	Tue, 10 Nov 2026 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794342761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aGpfxMribN8uWkk0NnZUHLaChmrCn6g06NgOy8ZpFM=;
	b=NWj+izLQezVFnlFYJmPPEWfZPn+XU3kncrt3orBmxhzFvzvm0KHenbfeqRm+5BmVksijyQ
	/KZnd6YWGXZHJt/59zXqlYLTfeO4GmMiFl1qyFtgQ2r0KqsorS4nM99CJ5Rqq/OHA4Jd6T
	O425KDZ4jFhSuf0353zI/l3ivOSppo8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.10.y] batman-adv: stop originator purge worker before freeing TT
Date: Tue, 10 Nov 2026 21:32:38 +0100
Message-ID: <20261110203238.734218-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202525-failed-5.10-f89eda5a9ccf@kernel.org>
References: <20261109202525-failed-5.10-f89eda5a9ccf@kernel.org>
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
index 860194a06e534..e484128f1bbc2 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -269,6 +269,11 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
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

