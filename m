Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272556;
	b=KzyYs4N47xgkAsx9g4VsS8OU93kotxU/3SRFG1OMtY2dTjtzTbE0IwGTScyITyHe2n5e
	 HdWqiFkMtJCG74K8BmwGgmDysJABZv9die3gfzIK1r+Qh7YJoecAvMb2V8+GIjPub1umO
	 vvpqOaLQlbsX9JVWAH7yDlu2aXSpwV7qj3nuSaAfxhjBYF5Y6kK25JsTRlwAJCawYHzU5
	 SBiIQvh/WXHzdwoJqZxvPnrudigIRyFR52wUe8O5EKJhrh7GcKWiWwsRwv4oXvU4henj9
	 yr3Hqb6yvwv0z0PBzZusf7u0O4Uz8jD125aBuE9/2vhxt/l2F4eXvoPwYK8Nm8BDxQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4tf7Q4OQX61HyktNQTFKvtb6zaXHJFzA9uo6uKBfIWo=;
	b=L6KVHaR9mKjRre9xu+xsn807qAPqQS2hhI4TdFGR18ImiLMGvWQ7Nc+ncG5IA8QsgplI
	 K4XVESi1JktmLg6Uqj2BDs4xlooPPZNd7OV4s+RpyugiHAuh41Tsl6BnMRArHnQzveQC5
	 pgEwOJCgAWwUIUaq/hnxNEmbwndhxOLmV8DKiRbrPZ5NkQRs7ZekDTLMV8JNChO0vFOVm
	 tWhh7qYR2rus82Mvg3WCIxHda452PlaHu5Ilwvi4IDrq8UkX95Sg1NL5KU1Giq8jxFBCJ
	 w7a98+AMSmOcdcirqDNQhPOMGHluW8CMJ5jByXS94vHPz2ke/Oqd1/469sHrU38XwWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc+Z34Rp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc+Z34Rp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C50B1F0089F;
	Tue, 10 Nov 2026 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272555;
	bh=4tf7Q4OQX61HyktNQTFKvtb6zaXHJFzA9uo6uKBfIWo=;
	h=From:To:Cc:Subject:Date;
	b=Fc+Z34RpFvrt+/qLiKfCbgW/mRacMuwG+M62tQWeHi1zoj9EMVLhSYHDVX3Gy+27w
	 K39XA5MMM7jcKUAQaSAlUGK9kJIkirNHbm3Dpe+mfyrzgTCetRNy60W2ScHR9lkXgF
	 bI4FBWY8QOGKmWbujcbORUZQ0FojEsaO7IZKxmryhxQTVKtfaRO2hacrUBB4Sgh+LZ
	 +ieKPtThofeSlFv1Q01+iejh511Ko3cAfIZgez9wSK+WRW7Ci7vUu7dUPN6Kj2RGX0
	 Eu0UwD7wcAbfRl70GSi0dsnvX2E+u22yx3U1CGP1BQD3befvlJsMnNFEHju5vw/ecP
	 dlxbydtHHX/WQ==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: send ROAM_ADV on each roamed back client" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:34 -0500
Message-ID: <20261109200234-failed-6.18-aff4d5d10f2d@kernel.org>
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
git cherry-pick -x aff4d5d10f2dcb4a9b604e27414dafa1d51b6406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200234-failed-6.18-aff4d5d10f2d@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From aff4d5d10f2dcb4a9b604e27414dafa1d51b6406 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 8 Oct 2026 12:00:27 +0200
Subject: [PATCH] batman-adv: tt: send ROAM_ADV on each roamed back client

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
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e13c2828da475..0df51523dcf0c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -819,14 +819,21 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	if (!tt_global)
 		return;
 
-	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled
+	/* Handle newly roamed client - but not roamed back client.
+	 *
+	 * A client which roamed back must always be reclaimed from the
+	 * originator(s) which sent the ROAMING_ADV. The global entry created by
+	 * this ROAMING_ADV might still carry BATADV_TT_CLIENT_ROAM because the
+	 * new originator did not yet announce the client.
 	 */
-	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
-		if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
-			return;
+	if (!roamed_back) {
+		scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
+			/* Check whether it is a roaming, but don't do anything
+			 * if the roaming process has already been handled.
+			 */
+			if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+				return;
 
-		if (!roamed_back) {
 			/* The global entry has to be marked as ROAMING and has to be
 			 * kept for consistency purpose.
 			 *
-- 
2.53.0




