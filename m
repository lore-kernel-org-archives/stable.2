Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273627;
	b=REppm2qBhHl2uwtNXBZ125Xb9H7xLk3ea77KwrG0XWkBQ86PbHq7TMTch83CL+yfRtHY
	 ZLBsXcXnXpjczGJcqSasb71yRSBR8i7y85qrmOEgERrfV4FruMtD6Nogk7cVTlCPMvQOW
	 BDfCi7uPYnDTBUrXDbZb30eTmn8L6hu61+uUO1851r7SxSYnL2C7R7BbtnhcrCcCDNwa3
	 MZQVvuj/MVoqIH98Secdy4FHSkN7nmdnG22w891Y3o9jgAYLFVAFU93lEGz9T/5g1324d
	 Gkvdoo1jJs/FK9BO00LUmfOuqPaQiWFdhAPQN5MCy2TtXvUjla/OKoVXX+IRdTk74oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pgR3REyyedPLXV20B7BjvYq/SBEy9d1rhDNxbKxurC4=;
	b=qok0VPxxjo3TWt/DdywCUdnCjNbP+P1rGj2VEXsb4WVo9v3tIgdL+8qwQo1aKuTL4HQU
	 pb+SVFb7rMWfLRrNoTAm2vnuAbrP17FKgDxKHYd7pwaqEZAbvcF58G6T4uvMIUwu+Hn73
	 bhrV9ocrC6Ny+uQeigQjstPfa43DAgX3oBb5R916rVXXH/JHUm6breiuQ+auXzWmrOHkv
	 EPLYtwDPCZX96iC9LTQE3dM0m8bwP0EE5TFH80BtHaicseBaPHuRx1vePO50mre3yLJl5
	 q6lxF2rYciw1ofrTUisfeCmqdMhU8vzS02++qrKSsPecw5RZ/rHo50RxfMXFugRDUzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=le29fu2P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319360A2635
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=le29fu2P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69C81F008A1;
	Tue, 10 Nov 2026 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273627;
	bh=pgR3REyyedPLXV20B7BjvYq/SBEy9d1rhDNxbKxurC4=;
	h=From:To:Cc:Subject:Date;
	b=le29fu2PlPUzRBgbhjUGFeePsIkTiMRt7Wlkiihodh1TUfwfylTGH0vuvhNehsoWG
	 KN5F/YlsNCQkzdbm68+krrmGuFRKulWq8FAVUvhrgvxoSVSbsZ8c9DWBAaPLtHUBzS
	 S+VPlQs4DW+l6WO6sKcc3OIepQsf/Gat06G/P4+Fqlk/ahBt6LySCKZTEzWpB5Od1q
	 8D8lQtLtslEdIw9KKfcgDIM7Ibe7aU1Fen1QIUso0RsrnSqevD4GGkvDn7CnLqRYvW
	 DLbWF0d7UuJltuHbzgMpzrChwOOYrOnFYFtUYRuZi0dBN3OqV472hdnTCsfeNxsaQs
	 mee9SArIjNdHw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: ignore ROAM flag of received ADD changes" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:25 -0500
Message-ID: <20261109202025-failed-5.15-c5d68abe6e7f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c5d68abe6e7f1dbd132a602cb696fe1fff0389eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202025-failed-5.15-c5d68abe6e7f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




