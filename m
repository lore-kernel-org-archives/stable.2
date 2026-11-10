Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273941;
	b=Jy3t6zZHlXDSkPU1U5lJFrEQXK4DCrzH/2RXV2sjp8AWmWtEsRXQXyRnL52AGyftNKty
	 1Rf/WavDxtT2fB+4pr9MgXhaPLIyHebqYBzdxwEsmF8PIT6PVeXQ/FZpUmb8mIAYU5EyZ
	 nqcHT0+TfgzZ/fGY/TKhUH7t1VeDk6JhWyfHkPQpZacbM2Vzgb2fiB9QIxLY7rh5DyrTv
	 USRHx6RzVfUfPGMoYzQIn5805ZUk1oYL6AxMgQU6AP3KlqxMiH5gMxOD8ULthklywY46K
	 7a+eTUwXer5/lxUXbeyv0I0xSTRIp3s4wISPL7SM0vhsFaQNgzF19PPXdtqt+0SbwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dZbj1QX5bjli3vxsgU8kEshEAcJqP0SMp1qs0D5ZNrA=;
	b=bL+pyqXhYpgxdNEFyOtAa/CpraAjkGNL7fHwg6Z04LfKvS9bmc1LESJgodoFpjbXa1s4
	 Fi/2YUvz8k7jKkxUzcloYUoAHjeRavYjivgnqb73iC0cgWZvxyCXflB5JuVncFL29D2nz
	 4STvIag7vE1SR37X71CBO8H2yF+dyXgvC7GvF+F5rUL6VSaUKKExU5LlfelGt08G5Fwke
	 ooIsMoGk7AjSjFLYcFTmcxeC/YvIU2DQEDfXwEIiGLYEmwt19nVmd7vId4dBNonGa88Qh
	 DoogGCJ7DLDjaOAhc6mLSZblstEjLqy5oOwvDuR6v+yP7YIcQKYE1bSs4dbyXpaAg+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wxgu5bRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766A606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wxgu5bRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE98F1F008A1;
	Tue, 10 Nov 2026 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273941;
	bh=dZbj1QX5bjli3vxsgU8kEshEAcJqP0SMp1qs0D5ZNrA=;
	h=From:To:Cc:Subject:Date;
	b=Wxgu5bRfYuVasaFjJNhlCPo5ytieXZl/Gs+IIgTHynrqrPQNEopbo3lRdIWhStn78
	 W/ZOqed2AsxRTwAEEM+6n38249U6O4nUnCwzTtX1UOC96+tA+RLNBQIXCL6iarFfUK
	 c51wYkNI8peVie9IYzjfIvBQ825mnMc+Z3kb1jqEWTtEq7uyEdECqxbnmMPqvNXu87
	 h9tfSB8d+Db87flQj56mGFNzTSUA9jcO44NR1JTboLv4td3gLVxNUgtOAqNrT5u0en
	 2B+Mc09/PtVYdsQ/u1MRHYpNmmLB6+uFmnktKs6E7F0rPhL2c2zY0ypSHq6zl0uLco
	 n2dayROzC/r4Q==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: only update flags for TT events" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:39 -0500
Message-ID: <20261109202539-failed-5.10-ad1fd828aa39@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ad1fd828aa3944efc393b84b0d7c02483f1b5638
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202539-failed-5.10-ad1fd828aa39@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




