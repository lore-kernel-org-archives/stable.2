Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338963;
	b=uLDqn10mGdyo/MDhX1zyjxy7073of2GjBlryBObpaG92BXMtV4lRvQyvEZlrVztHswEK
	 G0vPDv4h7xEr1d1oo6MnN8wGHbytyjOhwn5wvgkBdNGQxuSm2UbWC0OOwvGiVcxGvPaoX
	 AimL/nlnY8a2rETOWc9lcykAgCqYYk4gd3T+5P+3bEa8JjsMTlcraUsQQ07Tk3/2VT3Pd
	 62soQh4dTwgrMl4+Zho+c16hjbA/Hi35dpWgTepOb+v8jgtMXYFtEEmiSQOH7mjxZumzP
	 pJ1xT/6gNbMOLOLeNqwDyr8EeLoWEyndRxcSneZDsjtUie7zholaXJ6q1r+AfeZYqyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338963;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7s04s+FTXF+dqLxykkABzpgi61BabtfzgPKSDvLSRg=;
	b=cfBknczV8vVcP1Xh44yVTu2BAQ0p576ytmvw54rRMEOvzIhc7+AFJT+P1era9V4ZI9Zo
	 lZE1QnF2mr+6i6LTbwNQWQ3yxGAT0L9BIbaEnqdW9iUBGykpzsCA/2qoaR6l1dJvFFdLb
	 PWMQIKo0k41psWlljM77oGUvNEbGKpf2Xb39yfoAma4KgGfFOc0p7fHjlcIpGMf3VG4tG
	 Zymiq5iRKJ3SumqRBeEWxIrqOFEixlLrAB5Y9vSwXO6FTG3E0a+uqIqDTRIlWvlVp1xTl
	 0Xi+sO9vlze4FVheQ3QEi7lo49sp6ZFiJfTdR0U61lvCKs1lT3KWL5xcfSlbw4dZasQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=d6H5ReWx;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4847F606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4847F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=d6H5ReWx
Received: by dvalin.narfation.org (Postfix) id 70DE020292;
	Tue, 10 Nov 2026 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794338961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7s04s+FTXF+dqLxykkABzpgi61BabtfzgPKSDvLSRg=;
	b=d6H5ReWxhSgFr+dVMZTOB4FCP5nnYQ/yThiaB16zSnu9+7Wj8DuKk49+lwjNRRl7TROZKD
	gcI0himQzzCGyKxGGH4mT2hQ3eprMMlBIblEDF/WmQYIMRPCvhWL3jRP+JEisTrtHu2k44
	dtWrhCb5eX4Yb7mFyJ3II5B4Jj8FHoU=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1.y] batman-adv: tt: only transmit local ROAM flag together with DEL
Date: Tue, 10 Nov 2026 20:29:13 +0100
Message-ID: <20261110192913.232756-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201519-failed-6.1-10f24f058417@kernel.org>
References: <20261109201519-failed-6.1-10f24f058417@kernel.org>
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

commit 10f24f058417024a2c19cb8d88a6a0678a58a21b upstream.

BATADV_TT_CLIENT_ROAM is part of BATADV_TT_REMOTE_MASK but on the wire it
only has a defined meaning together with BATADV_TT_CLIENT_DEL: the
originator no longer serves the client because it roamed to another node.
Such a DEL is only relevant for events (non-full table requests).

An ADD carrying ROAM is processed (by accident) by the receiver like a
ROAMING_ADV: a newly created global entry is marked as roaming and is
excluded from the global CRC. But the sender includes it in its local CRC.

But such a behavior doesn't make sense for non-ROAM_ADV because a new TTVN
is meant as announced commit of the local TT table of a node and should
therefore not be used to create a temporary (roam) global entry in a node.

At the moment, such an ADD with the BATADV_TT_CLIENT_ROAM flag set can
happen due to two mechanisms:

batadv_tt_local_valid() copies all flags of the local entry into a full
table response. It is not synchronized with batadv_tt_local_mark_removed().
An entry which was marked as ROAM|PENDING by a ROAMING_ADV is still part of
the current TTVN and is sent with the ROAM flag set. The receivers then
create a roaming global entry for it and detect a CRC mismatch, which
causes them to request the full table again.

The same can happen for an ADD change which is queued for an entry which
(still) has the ROAM flag set. For example when only the dynamic WIFI or
ISOLA flags were updated.

It is not triggered by batadv_send_other_tt_response() because
batadv_tt_global_valid() is already taking care of filtering out
BATADV_TT_CLIENT_ROAM entries.

For the two problematic announcement mechanism, only send the ROAM flag of
local entries together with a DEL.

This only fixes the ROAM marking of the global entry and the resulting CRC
mismatch. When the requester of the full table is the node which sent the
ROAMING_ADV, the still announced entry will (independent of the ROAM flag)
cause batadv_tt_global_purge_local() to remove the requester's own (new)
local entry for the client. This is not addressed here.

Cc: stable@vger.kernel.org
Fixes: 27b37ebfa2d2 ("batman-adv: correctly pass the client flag on tt_response")
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ Context, use direct tt_common_entry->flags access ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 40657ac09666a..86e066e56e820 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -470,7 +470,6 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	if (!tt_change_node)
 		return;
 
-	tt_change_node->change.flags = flags;
 	memset(tt_change_node->change.reserved, 0,
 	       sizeof(tt_change_node->change.reserved));
 	ether_addr_copy(tt_change_node->change.addr, common->addr);
@@ -478,6 +477,15 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
+	/* the ROAM flag is only meaningful for the receiver in combination
+	 * with a DEL. An ADD with ROAM would be interpreted as a roaming
+	 * advertisement
+	 */
+	if (!del_op_requested)
+		flags &= ~BATADV_TT_CLIENT_ROAM;
+
+	tt_change_node->change.flags = flags;
+
 	/* check for ADD+DEL or DEL+ADD events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
@@ -2757,8 +2765,12 @@ static bool batadv_tt_local_valid(const void *entry_ptr,
 	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
 		return false;
 
+	/* the entry is (still) announced. A ROAM flag of an entry which is
+	 * pending to be removed must not be transmitted. Otherwise, the
+	 * receiver would handle it like a roaming advertisement
+	 */
 	if (flags)
-		*flags = tt_common_entry->flags;
+		*flags = tt_common_entry->flags & ~BATADV_TT_CLIENT_ROAM;
 
 	return true;
 }
-- 
2.47.3

