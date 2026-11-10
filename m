Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337414;
	b=FrQHw+N/J/uyBtK/Hgcxl0C4CsUp497tNSelF7fJUkNftI3mRw4NqWkPT+56KWfMUQGA
	 UpxByMQvPSQB4Ihp1O1k6LcVujdrcc3YvK0p8Fp29r/pYy6aq4zu4NAhbuOGup4GQOzWz
	 kBKRBdbjG0VudP4iWlSKjXZ4OvjSQlPbRr6LmTJuxfbkw9ej4GDbmNmAZi1iBYJI9CZ74
	 ABuidXibTw8KXUiKKrR/a9BOnKXLImsA7SsGmigfhJgovWPC044aSOfX7XoFkCnXTtlLt
	 1LAxtj7CkSjLe9HeuRBd3armKeQ5qMPRkNHrRyGHWj0xOHvRhaYN0iUCwawk9eRCytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337414;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zApXQKKuDKZssS5suFdpCnwlR9opXQim6rkPH8ml6Ik=;
	b=4wD2/1RHNW/SOH8qnp/RD8coXkwNnq62oUzgWm+NLpwRpxVFbNFdV8AohgxRiUwv4Ush
	 CYQJczH7aGwNVfUllXDalAMT0dTbasozp4zf8E/IUErwhjcmKagyi3p+FmqKNo4U7UpKS
	 d3mQ6pkRpmJASztKp0+/2S/ncBHmppnVUXYsyh1Ax3X8E65TyUCg4hz7aHJjWApwREe2F
	 vZIuNRHYA0IXgjopHZkBNaJ/VBfE7rrrjC/oI6Y5Mq+p6eM9x7xreyc780X/n82yKeYbT
	 LllIFijf9WRJ7ObYjOnhCBjCoHCYCkIRMCAPzIbYwkFrABWXQT974eeVpy28b3s54rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Lg76N1hP;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B2545606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2545606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Lg76N1hP
Received: by dvalin.narfation.org (Postfix) id E19B020281;
	Tue, 10 Nov 2026 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794337412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zApXQKKuDKZssS5suFdpCnwlR9opXQim6rkPH8ml6Ik=;
	b=Lg76N1hP289YwY1niWlMPtC2wMETS1lPXOkhuqWEfKOwTp68AH3bCRnc8aRPHoyOly+wq5
	tOJHxUMoA6JxpLFb8BUrv50m++eYOwHt2k9qQ3aRv8g9o5VRvuvZk2BPappBdwhGp/u5GS
	nmx0Khr0YFLDE5vL2JA8fHFh5110wBY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 20:03:28 +0100
Message-ID: <20261110190328.112717-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200623-failed-6.12-aff4d5d10f2d@kernel.org>
References: <20261109200623-failed-6.12-aff4d5d10f2d@kernel.org>
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

