Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272469;
	b=VC2cegTUUPCCnzfuvts4jlCSkpwl+mqhM4UZEKe2mXWKXNH//VE+IZhOe+wN/hlaWtCU
	 xf7leXzg7TeVIzqZwQlhPXYzAiwZ3rCLyqAuDtjA4afGYLHbpbJelZ1J8xC70D26sAYV8
	 N123tqjGQ68c8fSYVdg1G+pBJ7TElEtu2TNyK9sXSKPaKA0NLDp3D8c0vH9sA5gO1dObN
	 dy1siQkF2z28KUZfqjmsDHv7jEze8hmshibAmGnt9cXrdOhzBCl/vsEDcsBY2pRodIhjM
	 /qNtlyf+d1YE2gr6vcSbsfWgIHgtRNTWBG1bVdpwwkcYOHJ4Ypjq5NsXrQQTY9LeI4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m6GEopnXxWXAmkHGmJm0HKg7voiGhq4HMuGhlOT1l3A=;
	b=ppxbu2U2IAJYNV02qOdXyo6222z/ebFsA1QnPOpeBpZJ1o4ocQLXPRk8jw9XGZqBYj0/
	 UUZUvwRqLB9NPzlge2LjllyAvQnh1iY+gS8tm12D5HNPsPpDslNiX/N3EvU5kiYU/XGmz
	 ibzdqenbPngQYJbKD/jfBKFNPa7FtqeI+bStwieA/o2QwKXoHr4A/nI53WiCvwCEYFml2
	 f6nwkpNs4WPAFja3imUj+FsVKSLgonxh9n1Wvhvg1eX7gCXsrYXMOixCdsgjE+c6EEsWu
	 41i6TVySbdB52b0zWrqEorwur+XpIOIDas23U3NEnIpHjprtSbW6JtDcc7aqlCDqWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4hgBrAM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4hgBrAM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A441F0089F;
	Tue, 10 Nov 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272468;
	bh=m6GEopnXxWXAmkHGmJm0HKg7voiGhq4HMuGhlOT1l3A=;
	h=From:To:Cc:Subject:Date;
	b=W4hgBrAMlPe5EaF++/D5waQAzwrRc0QSuTsNwmxkqvC+NMr/jr85IvqDXq8/nsC2y
	 +N5wvxCbY6DuGwxNdfRcCLRRzlSh7ESiVCGXvOeYzRXhBzCSPiZa/oy7+XwoY9rlnF
	 Y/KVV/DNBSQlqrbdK5dCJW72pVty5QyKubukZdGVryCXSPQO0wE1uWxhaUD32YyOgs
	 vzHXy78PMz03NrIaqjSzEDUzcRxGLNtHoDBhNl5fpGfgHMS5ilji+6GLy+H6uv5ZKu
	 +lZQu8MocYmt+p4RrpIOgBPCqWzzRbvYOHqW+1m97Dc9QJvVM/fiGjDm9pyjRzI2IN
	 3u5rf9oUbR8yg==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: send ROAM_ADV on each roamed back client" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:06 -0500
Message-ID: <20261109200106-failed-7.3-aff4d5d10f2d@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x aff4d5d10f2dcb4a9b604e27414dafa1d51b6406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200106-failed-7.3-aff4d5d10f2d@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




