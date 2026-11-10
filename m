Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336171;
	b=SwzcQz7U10P1CWwMq2fHVB8H7XoNEjuO0nYH/6hAbAPDmrhViSdrDBXpFhuMytYiD0yy
	 CQ87ine/8KnW6sWlsLgiX98k/KKFVF581yLAAT2M8nIf7fdo7IOv9wbexxaVuVKLRbQ0m
	 8T8rqxMqb3nmrW/8m4lwobYAiRODG63HPQd1fCm6jV42uVqfzuTythjP3F9DAwN5VW8QM
	 0Jhqyp6WuGbaHGs81bjjZ0wZdXLa0maSDtn1vDGstJ2P/Xl5J7ZzynKrFwRwBj2TH33A1
	 hzjinTheHRpiMSekseICRFQsFGQpGsBK7WVqh059RM1g9wPLx42UqAnO/hzhCzskOjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336171;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WxfQ+pRuh/49QByqzzGitGu7v8i7RifW8RlBjXlKUnQ=;
	b=AMAFuYcBW+cgJfTi5y4sJK0UpgZdSRdmH8ZGzb0h+4NE8tuVV/0vC18s+J7E8Dj4LvfE
	 5ysLZz8KCaA+oyXh+pu9SydO61XA5L5sGKKAQVSjvE16/F7uIwqT4Wcjtzyqpxk0FfT2p
	 PyPDyDK2Upooj9UyiHquohdOwcLxPv5vBBNULBWqwDjWP2wc04w8m+cF3sIrmKluG6Jxf
	 NxV9Z7O6t3bV5r51vVSKiTYqe2h5w+e0h0/cR2I46dp2mmKrHeywfRboNCgpVv0lsF4lr
	 nZIrqsU/y2039WODRL/lREceghBYVaWEzXUJMYho28lcUqgPU1oozlDHsMRngslQwNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=GzYTE63F;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 39364606A92B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39364606A92B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=GzYTE63F
Received: by dvalin.narfation.org (Postfix) id 3F6CF216C6;
	Tue, 10 Nov 2026 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxfQ+pRuh/49QByqzzGitGu7v8i7RifW8RlBjXlKUnQ=;
	b=GzYTE63FD+ujkJxIZIcTI0kG8wiGHFd0AGMsYtlJXGnEqlkyh4IMW3igF76dz81yykjh+9
	1wKxd0Cr/PiloK61J9JxXdHyo4ruqx9mprvuzQuSHag4ZDJgBjuKsz3ES8UACuzHU55rXC
	PZDZuig8iW6MRGw6N5NKF0/V0keXwWU=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.3.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 19:42:40 +0100
Message-ID: <20261110184240.44536-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200106-failed-7.3-aff4d5d10f2d@kernel.org>
References: <20261109200106-failed-7.3-aff4d5d10f2d@kernel.org>
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

commit aff4d5d10f2dcb4a9b604e27414dafa1d51b6406 upstream.

When a ROAMING_ADV is received for an announced local client,
batadv_roam_tvlv_unicast_handler_v1() creates a global entry with the
BATADV_TT_CLIENT_ROAM flag set.

If the client sends a frame again before the next TTVN commit,
batadv_tt_local_add_roam() is expected to announce this return via a
ROAM_ADV frame. But this doesn't happen because the global entry (created
by the first ROAMING_ADV) carries BATADV_TT_CLIENT_ROAM until the new
originator announces the client.

Let batadv_tt_local_add_roam() always handle a roamed back client -
independent of the ROAM flag of the global entry:

* trigger sending of the ROAM_ADV frame(s)
* remove the (with the roaming) associated global entry

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ adjust code still in batadv_tt_local_add ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4523daec6de5c..6fbd96fa08e03 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -755,7 +755,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
+	if (tt_global &&
+	    (roamed_back || !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM))) {
 		/* These node are probably going to update their tt table */
 		head = &tt_global->orig_list;
 		rcu_read_lock();
-- 
2.47.3

