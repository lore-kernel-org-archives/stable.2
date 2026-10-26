Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004802;
	b=uDs3g+BtQ/2pvE0bdpUAq0VtJuzjnOso0LNWqiHu4Bs6grrLJVPq5RjGqtZxZDxqwWlR
	 MzeZXWzcjN1x/ueEWENBKdnL6nMFMvx9xie7nfMra5NqGQyUFBfUjX/BxOSY3R7mKKAIT
	 Hd2vYTE7PaPxz5U2R9KRTe+mbdFAvqbwNGgq8wYQtwa/fIxnaHfNg2MsToQOJx12nFmCT
	 MJmf5igVkdr3FDfbxCaJI5zOLzYDUke98yMjxYY1G8tENejDzpi0ZPFRcGXoDR7T2oP3x
	 0gj8W32F5CVCYW1zVBReLsxlX1tghesBY+4Mi4fbKPZ8tmL3rpv512JKav17n007Tkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004802;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ibnlRdMDfruCoRPmJn7htwYgiPi5QCuvCums/+Zi7Iw=;
	b=cR/eJrSYtc3rPWb7o56ThmWg84GO6foqPLPHlt03/fExp3y7KUXPh63/1nAST9WI9SDb
	 qMzFNe6c5YwRFPM/5iHq9yTrxBT8a7W8Sa8VOCzsRGbnQtNJL7l0yCgrN8LMBFy9qLD6t
	 Zi3BmWzHaOkW5lKhRADZKfAytdgXKSc02bncJMXSrPwtaMvXWyJiFWuelUO4Yn5/MEc5Q
	 WwW48abp3B3Yflu6pgNviP2XZCD0SY2mVqvVMd4/v67NcwGEvOc5FWIjjfIPEF2cmMtSP
	 U6KOpI3cFlPDk9Cmq5oJF3dhw7X2hiBTaqMW2Yux0pKaXvFmb833uDAd0TQyxJyLkLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=AKiMNvwI;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EA36C606A339;
	Mon, 26 Oct 2026 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA36C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=AKiMNvwI
Received: from kero.packetmixer.de (p200300C5973CE5d80fc8dFe94a24022D.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2693AFA1DF;
	Mon, 26 Oct 2026 09:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibnlRdMDfruCoRPmJn7htwYgiPi5QCuvCums/+Zi7Iw=;
	b=AKiMNvwIPOPRq5L5mMieuooL/xvZQK5IwZE+xxDFfPUFNgFg8/fLoqc3uofnHXlWNm4M6c
	6ZNliEwcZKsmmdE18jQ6dwPtAsmLVXB8LzjYYeUt4tZdjcDBU3QUOY+n+fbtnYc9VQUU32
	wP7QsrSmm7LyZheGmzw7MJeQaIqdOi64eFvh/tsTYblttzmYtaRV/XUNrNQ3Ddrq1dEgrz
	mx+DwJmrILjk/Gx09xx87SKIzKaYwi0+8QEDo0DvHpf8pQlNkuxVMZWQYiGnmDJTLJ/RS6
	GU1poS9pUrNo+MZIlleKDkKH7g9zIGA7TswJ45ssW9BI3nLEXoQJw0hdUNNFVA==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 07/10] batman-adv: tt: only transmit local ROAM flag together with DEL
Date: Mon, 26 Oct 2026 09:53:06 +0100
Message-ID: <20261026085309.1074911-8-sw@simonwunderlich.de>
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

BATADV_TT_CLIENT_ROAM is part of BATADV_TT_REMOTE_MASK but on the wire it
only has a defined meaning together with BATADV_TT_CLIENT_DEL: the
originator no longer serves the client because it roamed to another node.
Such a DEL is only relevant for events (non-full table requests).

An ADD carrying ROAM is processed (by accident) by the receiver like a
ROAMING_ADV:

* a newly created global entry is marked as roaming and is excluded from
  the global CRC. but the sender includes it in its local CRC
* batadv_tt_global_purge_local() removes a local entry of the receiver

But such a behavior doesn't make sense for non-ROAM_ADV because a new TTVN
is meant as announced commit of the local TT table of a node and should
therefore not be used not be used to create a temporary (roam) global entry
in a node.

At the moment, such an ADD with the BATADV_TT_CLIENT_ROAM flag set can
happen due to two mechanisms:

batadv_tt_local_valid() copies all flags of the local entry into a full
table response. It is not synchronized with batadv_tt_local_mark_removed().
An entry which was marked as ROAM|PENDING by a ROAMING_ADV is still part of
the current TTVN and is sent with the ROAM flag set. When the requester is
the node which sent the ROAMING_ADV, it then marks its own (new) local
client as roamed back to the old originator and drops it when it is still
NEW. Other receivers will detect a CRC mismatch and request the full table
again.

The same can happen for an ADD change which is queued for an entry which
(still) has the ROAM flag set. For example when only the dynamic WIFI or
ISOLA flags were updated.

It is not triggered by batadv_send_other_tt_response() because
batadv_tt_global_valid() is already taking care of filtering out
BATADV_TT_CLIENT_ROAM entries.

For the two problematic announcement mechanism, only send the ROAM flag of
local entries together with a DEL.

Cc: stable@vger.kernel.org
Fixes: 27b37ebfa2d2 ("batman-adv: correctly pass the client flag on tt_response")
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3349376a9087d..39b61426f1680 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -643,9 +643,17 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	ether_addr_copy(tt_change_node->change.addr, common->addr);
 	tt_change_node->change.vid = htons(common->vid);
 
-	tt_change_node->change.flags = flags;
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
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	changes = READ_ONCE(bat_priv->tt.local_changes);
@@ -3342,8 +3350,12 @@ static bool batadv_tt_local_valid(void *entry_ptr,
 	if (tt_flags & BATADV_TT_CLIENT_NEW)
 		return false;
 
+	/* the entry is (still) announced. A ROAM flag of an entry which is
+	 * pending to be removed must not be transmitted. Otherwise, the
+	 * receiver would handle it like a roaming advertisement
+	 */
 	if (flags)
-		*flags = tt_flags;
+		*flags = tt_flags & ~BATADV_TT_CLIENT_ROAM;
 
 	return true;
 }
-- 
2.47.3

