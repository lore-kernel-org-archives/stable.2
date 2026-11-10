Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338385;
	b=Wz4t4X5PJ00ziahIWVy5homsIczfE0AUF/gAI7R45WtJfR8Al8ThRFd34t8GjeBhmDxf
	 cadtmHZdvV+cOKOHCrUGVYAUi8470Ql4Pj7jQ8IslFFoYHfumJnuwj/nt1CxSGEKCUCmH
	 hHqyQ0fQDi0FXRCHRKrYFCgdm1vjAAVt8bSZ1lH8AjuS55XutQitnSsWsHnafxDLyyNRu
	 Xsk8NpDsgP4uHxenLey1ht1JQCOX1g+EpSGBitwqTh+eftPjN5GoKai0nryDGp592/wpE
	 oK9AzAPhHmxv230Cj/p6cAnvrrDu9AtcsBRaqKLo1x+LoRk/Uc9qcACVqd2IhrPliWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338385;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1g6N+UiSFWtJXbhcz2hQ0sX5BzMJnPPhFYk09G5Egyo=;
	b=VJUaSLs6BzkCntriFTv1wRhasjHe728arJs0+QRiO0XncLTEN9ZCPARL5La50qPwjzGI
	 2mvdxLIiYkbaXgLrbINnj/kjUBPt/DQ8heYzsy+RXEiBsBaYQgPNNqHBdhf3XWMH5PqwO
	 XtatQ2n2Zg12GeeYRucj0GyvtLeozGvCtq7TbUzmC+BQF1Wg2bwzsGkz8vfwmFMT9jyMh
	 pB+7tXqpZJEe5fwtHhQpri9ftAopppHuPGnlZo1ZiAJhjX6x7ZK8SmrIpzE+/ND3mCW5a
	 /WwR+gaDbjVWEzUYHp9ijKxIzR7EVvSaDpQOWCztcjEHYQkuvuUIIUFi/IS9eH6ezpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=qcEHHIFi;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AF679606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF679606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=qcEHHIFi
Received: by dvalin.narfation.org (Postfix) id BCD161FD16;
	Tue, 10 Nov 2026 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794338382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1g6N+UiSFWtJXbhcz2hQ0sX5BzMJnPPhFYk09G5Egyo=;
	b=qcEHHIFimp51YDbK7DUOlMS3jIIfGOkgooycrImODX9YQG7sCQqLPiCSML8G01jYd1Cbn3
	OXjvY/ub1QSmOP5LYD2O71mWqdK731d/+V5zt9D8qLBskDauxz2b3reWh/mg73rn8aAl6r
	zspXi3xJSAHGRu91omr6YjpQ2h4byUQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Tue, 10 Nov 2026 20:19:25 +0100
Message-ID: <20261110191925.152797-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201044-failed-6.6-cc2186d78547@kernel.org>
References: <20261109201044-failed-6.6-cc2186d78547@kernel.org>
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

commit cc2186d7854785b30d423f5d43757b086b300e55 upstream.

When a ROAMING_ADV is received for an announced local client,
batadv_tt_local_mark_removed() sets BATADV_TT_CLIENT_ROAM, queues a
DEL|ROAM change and marks the entry as BATADV_TT_CLIENT_PENDING. If the
client sends a frame again before the next TTVN commit,
batadv_tt_local_add_existing() only clears the PENDING flag and returns
early. The ADD cancels the queued DEL, but the entry keeps the ROAM flag:

* batadv_is_my_client() reports the client as not served by this node
* batadv_tt_local_client_is_roaming() reroutes unicast frames for it to
  the node which sent the ROAMING_ADV

The ROAM flag is only removed with the next frame of the client.

Since BATADV_TT_CLIENT_ROAM is set together with BATADV_TT_CLIENT_PENDING,
it has to be cleared also at the same time with BATADV_TT_CLIENT_PENDING
when the client roamed back.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ adjust code still in batadv_tt_local_add ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b4c98ac6d338d..c148127799c1b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -658,6 +658,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	int hash_added, table_size, packet_size_max;
 	bool ret = false;
 	bool roamed_back = false;
+	bool added = false;
 	u8 remote_flags;
 	u32 match_mark;
 
@@ -684,7 +685,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			goto add_event;
+			added = true;
 		}
 
 		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
@@ -765,10 +766,12 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		goto out;
 	}
 
-add_event:
-	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+	added = true;
 
 check_roaming:
+	if (added)
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-- 
2.47.3

