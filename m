Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338428;
	b=bOQiGqJ34FOHTVrIACfx8k6HeeEobGlr3QXEhIjKmRx5F6geZ+8sJ/3/tXQM2C9/BG11
	 wdSm9FoWHehKqMkHU3zgpoR9bPm+fqDIUMxhPi8ozvMCBokGJjvWbzBZbDt+qQk5V5pIc
	 IxsB6zD0R0c4K0dT3/YDFsKR+hOHz7QYh0bGCkZrWvOE9wzf8UVpVgn6sU8t/pu9XesFI
	 UKevLJE8e4KRTBt09sB1iB4dOTUQQfCx7AYqmz72BByj3zbBEq6voqicsa782dwXQxnXw
	 WKtAjdGbNcdUAh4iD1aVKGWdy2+GTRyO38Cv8oUSbX7PpzsVX+Ndiaq73Lw9AZmR+Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338428;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zApXQKKuDKZssS5suFdpCnwlR9opXQim6rkPH8ml6Ik=;
	b=WJlJAdzVc/Jhlfv4/8D/UEZZ5T6XvHImdvgn7CJI6uYMShyBVyApmVrK+XJ88RVJtthD
	 qJdyd0sYsdJPeD1SfynYnu7q1/IpOPfP6Q4J5c3L/wDliPYY4eHQXAFFFm8a0XWlXdzFj
	 a4NS9KfRx4R/WZISL9P2c8TBDNrfMs2WRT6hgJswdLTtmknVE/peaKMngXVkcx0xz8Aky
	 MTXjVrgd48aVah/T0/Q6f1hcHevSWpQxnmE5QE2ep6yIBj10gxj7QjRaFtbDoZvceoXUq
	 kqMcPFws4QiNgw3sqXEldlU2twvsSEn1eKLr7KMi1QDF66ici4OAnTCn2RHu32DGC5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=np+tZzlz;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 428BD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=np+tZzlz
Received: by dvalin.narfation.org (Postfix) id A6A47216C6;
	Tue, 10 Nov 2026 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794338426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zApXQKKuDKZssS5suFdpCnwlR9opXQim6rkPH8ml6Ik=;
	b=np+tZzlz2grjkuzCji6zkjhIohXKrxJgrQhOmuAEtEjYljz6lGnNCka0XNnBto0PSSzRVX
	msBRdIH/mk8U5fL5ItMW8GU+O7eX/Rb/+BEb0FQGf5p2CgxFpEgWsNRGXEiTLhMZaKdWSs
	C8hNEN0h5wew1/wjCxzWHE0yS/Kc3GQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 20:20:23 +0100
Message-ID: <20261110192023.154929-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201037-failed-6.6-aff4d5d10f2d@kernel.org>
References: <20261109201037-failed-6.6-aff4d5d10f2d@kernel.org>
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
index c148127799c1b..8397b9edb5aea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -775,7 +775,8 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
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

