Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273037;
	b=e0JF7JSxkediYBL6NWKCpiJma6596nxW3jqMMelGMBnNu5/NRF+YGO1brHgtPan3pGpZ
	 L/OoTVtg+IP446uVAipfsAzP0TeP9OkwQc51KzNne56QytUDXcafT8PhQwn5bhLLgV977
	 exZ/Eh5RG5P350bzF+sJB/P1aCHWWAa0kjz3qFtCGjS/oXgxBVmNEtFGHYwQ4adHBzvjH
	 9TIN4jDOgJn2UIZoPodll6guerCweYtIoxp1A71J0ZGTx+qUq3bk2PMGHNF0f6IBDWTc6
	 O+poFMm2iEn8r08J7IGIvflFLbvRWgesA5aPiXLhgMGZgRTLMJRUq+3XC708SwC2mbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eK04c2x6083vN3aDrcQWEhM4OT3W/gKs/xbK89On44g=;
	b=5ozVOl1frXipsFuspF1AgX94MIbM4a2TV3tNJGf0NGetneF9rIZ4JP0DMR+YOWwRCBWY
	 Jovnk1d8fAfbCGm87+bAdkngyYuwMzNgGoqQB5zsQKO93JC7fwC59tsIwG+X/TA5FcB6T
	 loF7jkVoPEopeb4Wrsgy54QqdHecZNPuOZEeUngEzzqjyGyesAYcGAJEnx2OXT5M/Bxj8
	 xlXCGAdqEBO/+S9/3LYfPJM20AE5PlocHxcJau97DvjXPjlRvkUClT0Be70iHkoTpXuo/
	 44kTHBApJngm1ZyLwXTuFltgDaAjc2k8IqG5Nu304t7xGbqxEpD8QUCi4Ye6z5uP7lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJbwNNLw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJbwNNLw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5199C1F0089F;
	Tue, 10 Nov 2026 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273036;
	bh=eK04c2x6083vN3aDrcQWEhM4OT3W/gKs/xbK89On44g=;
	h=From:To:Cc:Subject:Date;
	b=gJbwNNLwZD2trqKz/R5nGwJWnFe9j8uAsdjg6NiwZEGnVxH9lKIvNOTCZu4wH7JGa
	 K+kTTBJ7VpsCO5sxpqKN2bAwU4i2/s+NMMrMTdq1OXXKKbBZqV5QLAC3XGYOo9ZVq6
	 4sdKslYNEUM0ml7m5mfCdStrTISSs55MJXkosIdInJj0mygDAR0WTW6mmXmV1Onvmo
	 cgDkvZOv53t7kwH80Ze6HsRtOzTPPDlQmSejchxJN+n05rkGTShFPQmfy3ESu80MqD
	 K8tPnZytIU+MupSpcDf+ri+CBPrH3CrA3gle6aMRN/cIL9dj9797k9D+A9mOWHl1B7
	 cGatfSjca0pnA==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: only transmit local ROAM flag together with DEL" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:35 -0500
Message-ID: <20261109201035-failed-6.6-10f24f058417@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 10f24f058417024a2c19cb8d88a6a0678a58a21b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201035-failed-6.6-10f24f058417@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 10f24f058417024a2c19cb8d88a6a0678a58a21b Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 8 Oct 2026 16:30:06 +0200
Subject: [PATCH] batman-adv: tt: only transmit local ROAM flag together with
 DEL

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
Signed-off-by: Sven Eckelmann <sven@narfation.org>
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
2.53.0




