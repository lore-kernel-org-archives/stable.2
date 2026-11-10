Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273041;
	b=0nn6MdcKN2CjgoYB9qiX36C76FlyqJTBfTlzvd8dQ2O1bfT1dgmPKVtVh2hKv3F32zYQ
	 J+ebcYQhuU9U1DPeIa7DU+wfc17/S3xzq6GFXdAvUHnMORw3nQnoL9XbELAvE64uuuXwa
	 J5Z201aBWigUiAQJIOBm71ZOq3SRrR8DxhTDnY1qddWTDj4wec5K/DWmvD/BaSnzbue+o
	 PblyrTZtyMGOTyvArnOhnpuGm2ihVaZ1XMDwm1RQx+jbkEplKEFkdbmjZXwvWI08bZC9n
	 FcJRF8t5Ec3Zba4JINTXSq2eJjm5BPiSMBHdUFvjflj1wUs51Bal7cRDndnUF0j2XgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VXUzBZ+UOlo7moHYgaUs4GBxeuy5sxcCtsyHtkpm684=;
	b=4B9WgCAhGf22sQYRiOXhsiot+2TBY1J7olF84OHiISZrqtg42fF79fElJw2V8EXjRtbB
	 X6n/fWlt164sLQH7DHVNz6tDunoHw7vSywsVXYxOfKlhlU3ZAonJMC+EaFnD6r7bH7R2a
	 GyuiQrO/aaonY/z52qbTb2kjhW94N/5tDadfkzE+A1cblI2q+A4nxcZuce4hqlpNo3A64
	 kSJVB+Q8IAw0gBUx/gpduNQAdXgaIzEZE4XoLNtqtQ2kLi5Lb8n1flvNSvrqH00oU22Fk
	 JzGBkTdONzhDlYJbd6qNgcvXTANJsWZie+iqqabKREITrmQ6ABgT5B59eOaz0pKRj/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GoJQWkar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GoJQWkar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0221F0089F;
	Tue, 10 Nov 2026 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273041;
	bh=VXUzBZ+UOlo7moHYgaUs4GBxeuy5sxcCtsyHtkpm684=;
	h=From:To:Cc:Subject:Date;
	b=GoJQWkarvH4OKEfNooNNIxB89NZEzYLB47fk/qwHiP74fyryDaSJcjpW9+CB8KDtw
	 EfHUtLbFoyOnj1khnHzYgQNvi15sWJ2YoPLxDg665mQK1thiG+Sj78uy767vXjyKoD
	 rKeLlQltzc+nnd4BPohj/2eS0CBOvTA2ud/sAwq6HrxATQ58DY5rO7Ja2QSM8boB30
	 g8Pu8C1aTdH12F1H+FZc/xlCjp4yqgnCtRe29EhtjeAs/ETCwzDR6VKmYKeUz0Y8eb
	 JoETpJR4QKb7XGhb7981IA5KPWBMybeO+K8ICEEmfwyP8YjOEUY4IrUKAt7JwPLWpy
	 JoWrb188fMR1Q==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: ignore ROAM flag of received ADD changes" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:39 -0500
Message-ID: <20261109201039-failed-6.6-c5d68abe6e7f@kernel.org>
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
git cherry-pick -x c5d68abe6e7f1dbd132a602cb696fe1fff0389eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201039-failed-6.6-c5d68abe6e7f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




