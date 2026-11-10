Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272788;
	b=QIxdvG7Ka1oY2DZrZnMog/L/865A04XQU+bL++/b4Y+WZFcm5OkR9VSdzBbvWDBKxmeq
	 oO8OV5AqOTU+Vuw/Y3VFENGM7MvGxQhxIcUTZ7pzab4uqB72/KOqfpclCWXMohAmVKWXU
	 OtHlwOqOts+MQjFXnMaZe5SWD9O3lMykLt4fF38yFSqMAOGqMYld3o1hdHkkEXgU2WBoM
	 Rjn0YkPT6swl1rcdo9TGR0+eSiLabOQNZXHEQLwziaSTbt7gNLTxax94pBM4faAHXLKkL
	 BmcjHMg6t048UxhuWbLtDgHH1rbXcRQtzXux+tVqwBdzXKSf8vfUnkXw1THww75/PsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UUOnrQVoRUZJ4GZmEKYMSbntxKIdWDuV1erOu+lbOAM=;
	b=SsZwfqvevgrAWRKQoqeLKvN4yUrhfFUrAJEp1fzMrwQoq4az2nnIPM8WJhzhHPYAcG31
	 aTjVQMMmgHzMz6YACKDRNfYheA3hai+j2rntYovsgAA3Z8R0dVryIz/Y4IiViVE/tr7MD
	 JpxzWR3ffedeQhk2KAWWuQXZF4yqK6w1YY5EClxOMgU45zrM9DAhTfBzN8uGecwKlgzwd
	 7Zamd/BbTm8HO8j4TfeCBmZ1d5qRXyJEfAMvOWAUyX9WN3vz0BGKHKzqgd/zLk6/f0NnT
	 TMMB4HWHXFmzkC0cr2ZzjCL5CCHpjivnVVmZ77LIqy6EP/kbeGbV5TknnCWxeCGR2OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL3m8pXP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL3m8pXP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253DA1F0089F;
	Tue, 10 Nov 2026 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272787;
	bh=UUOnrQVoRUZJ4GZmEKYMSbntxKIdWDuV1erOu+lbOAM=;
	h=From:To:Cc:Subject:Date;
	b=QL3m8pXP0qY77LsCQI+YO9VjwX73gXT28jSSUpMBpjBqFd/xjMpL6f/n2kRiV3ASL
	 A+QkBOK2he8tAMxHS0zBwQ0yXA2VgBgy/JpNJQgHaRrcRm2xqX66dp0OocyRUvpqKE
	 x3Vt5a+e/tOXkor9RBLjjuMpySietQ47anOLxi0j5IPHMG/OrIiIexiqJInVW6IEMD
	 sdSK0i+noh8VfsyEJIeatUEzY6lvlryaQlLCXQwJunJzcZ6nRYq92LVlasrYGi8fAN
	 y0N0sIggvZBVrBDoV0kR8VAZifvqr5Dzc/OlzFbPNOMwQ5QEe1nARhpYiGigRX5qlG
	 tJnqb0ldHurpw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: ignore ROAM flag of received ADD changes" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:25 -0500
Message-ID: <20261109200625-failed-6.12-c5d68abe6e7f@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c5d68abe6e7f1dbd132a602cb696fe1fff0389eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200625-failed-6.12-c5d68abe6e7f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c5d68abe6e7f1dbd132a602cb696fe1fff0389eb Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 7 Oct 2026 13:03:29 +0200
Subject: [PATCH] batman-adv: tt: ignore ROAM flag of received ADD changes

A received TT change (OGM diff or full table response) with the ROAM flag
but without DEL is handled by batadv_tt_global_add() like a ROAMING_ADV:

* a newly created global entry gets BATADV_TT_CLIENT_ROAM and is
  therefore excluded from the global CRC. The sender has it in its local
  CRC and the receiver has to request the full table again
* batadv_tt_global_purge_local() removes the local entry of the
  receiver. The receiver's own client is considered as roamed to the sender
  and frames for it are rerouted

The ROAM flag only has a meaning together with DEL. Drop it on reception to
keep it from populating the global table with a temporary ROAMING entry
which is not part of the CRC - and therefore causing a CRC mismatch.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0df51523dcf0c..247cce95c09f4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3941,21 +3941,30 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      u16 tt_num_changes, u8 ttvn)
 {
 	int roams;
+	u8 flags;
 	int i;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
-			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
+		flags = (tt_change + i)->flags;
+
+		if (flags & BATADV_TT_CLIENT_DEL) {
+			roams = flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
 					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
+			/* an announced client cannot have roamed away from
+			 * orig_node. Only a ROAMING_ADV is allowed to add a
+			 * global entry with the ROAM flag
+			 */
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
 						  ntohs((tt_change + i)->vid),
-						  (tt_change + i)->flags, ttvn))
+						  flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
-- 
2.53.0




