Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272551;
	b=Kb+Dq5SYXm+KI9lHZgeAuNf4S00QJlNj6cpRnctm133KAeqW9THtRThDwNmcG8KkkTdy
	 Delm5y1AVt7P6Gw7vWgMoGJeOn9DIdHUKvxetPTLIyKnFw9fu7rkIfPYKt1EYIVYp8JkV
	 SO7AlQs0AQT845D+rpNy7EfmbOeoBo44v6EGFPMIPnbVwc5US8JXFFSN1Werea6qwXU6K
	 4qS4/YpZuN3cI2q0FAei3MFsWmFsKfP5Xk9R/54wQGP9UXKz+VRVxpkEYdXtm5uFpkwjz
	 1SIwRGLD0RskGoIjGo3RyZ7b+8aAav5WpR/AIWbCgCp52yJ8f+6dxxjjVIyZt0Dq9dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MOv5PedRXj7qP4irS9qUOtyTHS6yacHfv0oQ2T0eJQI=;
	b=btAgHAI27BTgHSUmsFzNHsmousHHR5+Tx09J/j7vCwXJwzksn1QGUJ764bWTL6giNjwS
	 MI/UyEsFAMR+WWdnvkKja76A9BKKFSlQG2dGCj45QqCuQyMmS8jxQYcHMg3J+Wez3Ivf3
	 BBdaXwQ4f65SRV1F/R3Xflvwdd1XC11Y3yc5gwfXNtbRbC4HdVSCUqQLJLMwZ+w8Ks+Vi
	 q6b+YgsWNQ8pbUXzd8wM5P5GTkcsdD8Cu55zWX2X8dSTtSoB9Z1XqwJjAl8BDA/cAfz6g
	 CAC1mBspX2uwfxFUnvn+TztXyAgw301aqbauhXuGHI/VsnJyjfXN0zfeu/lAFP38gPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xmh6une6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xmh6une6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED51F0089F;
	Tue, 10 Nov 2026 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272551;
	bh=MOv5PedRXj7qP4irS9qUOtyTHS6yacHfv0oQ2T0eJQI=;
	h=From:To:Cc:Subject:Date;
	b=Xmh6une6gq6w5kVtrZIGb/WrTCtFT3LLHD8DJUIzvyZDPrTsr9DQVszR2d5zSs1je
	 XqtpAREJaKgI6Tm6hBuwOuZz5QRIZrgpCyF5PnVjFhmJUJqBvgGN3tYkQPPgZojdLc
	 OsnWDMhBEgojcR/vWfleq92ZXJq9XlkcX6W07nmS/7tA2cwwR6mN2vIc1WOLoK3ouv
	 +05b1vnMOvzIGbEep9IuFoKGB5mqbdgOvagJMRD+dizNy8DQH/o/aZZripjBAI/B+o
	 iy4UsewsXW/1wOWsTblK4c9wk1TEWi3/KnIQASrvM9PZX1D745ek36fyclDBwzWGDk
	 fZ7ptKW6FPedw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: only update flags for TT events" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:29 -0500
Message-ID: <20261109200229-failed-6.18-ad1fd828aa39@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ad1fd828aa3944efc393b84b0d7c02483f1b5638
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200229-failed-6.18-ad1fd828aa39@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ad1fd828aa3944efc393b84b0d7c02483f1b5638 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 8 Oct 2026 16:30:10 +0200
Subject: [PATCH] batman-adv: tt: only update flags for TT events

In the first implementation of the translation table events, it was only
possible to announce:

* ADD: new locally detected client
* DEL: disappeared local client

If an ADD event was queued and then a DEL event was queued in the same
timeslot, it is valid to destroy both events because nothing actually
changed for remode nodes

But with commit 3c4f7ab60cc2 ("batman-adv: improve the TT component to
support runtime flag changes") and subsequent changes, it could also happen
that there are extra ADD events:

* ADD: _NEW_ locally detected client
* ADD: already existing client with new flags
* DEL: disappeared local client

The first and the last type of event could in theory still be removed
together from the (to be announced) events queue. But if the "update flags"
ADD is dropped together with the DEL, it would still leave global
translation table of a remote node in the incorrect state - believing that
the client didn't disappear.

If a detected client was previously announced, a DEL event must only
overwrite the "update flags" ADD but the DEL itself must still continue to
exist in the (to be anounced) events queue. For now, adjustment of the
announced flags is used for everything instead of dropping already queued
up events completely.

Similarly, a DEL followed by an ADD caused both entries to be deleted. But
the new ADD could announce flags changes which were not yet present for the
client before it was marked for DELetion. The new ADD must therefore only
overwrite the DEL - but still be kept.

Cc: stable@vger.kernel.org
Fixes: 3c4f7ab60cc2 ("batman-adv: improve the TT component to support runtime flag changes")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 247cce95c09f4..fa5ead248f192 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -622,6 +622,9 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one.
  */
 static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
@@ -631,7 +634,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
-	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -665,25 +667,12 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (del_op_requested != del_op_entry) {
-			/* DEL+ADD in the same orig interval have no effect and
-			 * can be removed to avoid silly behaviour on the
-			 * receiver side. The  other way around (ADD+DEL) can
-			 * happen in case of roaming of  a client still in the
-			 * NEW state. Roaming of NEW clients is now possible due
-			 * to automatically recognition of "temporary" clients
-			 */
-			list_del(&entry->list);
-			kmem_cache_free(batadv_tt_change_cache, entry);
-			changes--;
-		} else {
-			/* this is a second add or del in the same originator
-			 * interval. It could mean that flags have been changed
-			 * (e.g. double add): update them
-			 */
-			entry->change.flags = flags;
-		}
+		/* the other nodes may know the client with different
+		 * flags. A DEL+ADD must therefore still announce the
+		 * current flags and an ADD+DEL must still remove the
+		 * client. ADD+ADD and DEL+DEL only update the flags
+		 */
+		entry->change.flags = flags;
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
-- 
2.53.0




