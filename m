Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273328;
	b=3lABDu1LNzDn9btDHePrgCQpyikmEWiUUXjjLYR74MPh8cHEz390B3yIeBIY/eRxuWYg
	 pvaH4LDmDL9SAPPSteTt6eU8J4CtJ7p5Y5GX09dczrPEvP2SI9nQwEc4IGOcyZidsj6e7
	 EdQxqVYZ3wIycwsPTRFCh9kH1ydzJFOZxeITDgYU3e0311uFmdKOpZhasrBkpvDJ+Qvy5
	 L+BvIebPSEkovKQ1zw99V44gFroo5XXL9ZwlSE1Ddn3K3mD4rI3I2D3PXCBcLl+LYFVGW
	 rSpGzq/huqq00nhw5Xz/zS2Q4OF15FK1CyEMQFtjFZ72nS4yR41lH15UspCSiYqhO5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273328;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J1UlFSgFTwYCp7u0ZK/AtxzoTKusUBN301hTpOA6NNU=;
	b=HUTdz1VnYHV7EXLKv2RiHV4xLi535PTFoIE+q8sLZdUwntqccYdnxfzxvmbXm0jDR8wS
	 FvPH6UZUdGiQczHyQVh95IQQ87g/si8FiZw2Juf3RUw5xHZTZrckSSKD0TJMGDw3YmUOr
	 B5CmmyixkjeghrCFQhXF/qXen0gHY20+/RUYpVTsy9/b8ibg4elSBzsb8I6ELCJrwbZOj
	 bP2D3PZcG7+jZFyFNNtI23DckhzSozv3cXqg1fclDl5tOii4zcu/XjXN02L1Kt5SiJePh
	 TZrGr993S6YOm6gdf502EqhopMGQ014vLtfaYMTgf09ilHico01ij+Np1A1Y2Y1P5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEJTESKM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEJTESKM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BF1F0089F;
	Tue, 10 Nov 2026 01:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273328;
	bh=J1UlFSgFTwYCp7u0ZK/AtxzoTKusUBN301hTpOA6NNU=;
	h=From:To:Cc:Subject:Date;
	b=ZEJTESKMRTF5EW8qB9EvuzdHpdRyzuOu24TBTlhjRZk0uLiI1UTOG3A8S5MwHs6Oh
	 J0kC9DJxpmJ5nhjrZU0gdbCSqz8yJCo+bJuDkQUAtq6Pld8C5o/y6z4zliYEmkFDUl
	 ZTPujJ5QqyU099dEIxuKUtLKSp9Zu/DckogzBPfWtlTEIcj4w0RwdMWKlqT15mQqPD
	 VwULgUj2cMpN6lFYIdL9r82QpIOezEkKY21jK82vfqg5Hh6oxJvzq7qLoG11IqH8Dm
	 eKrL8HkQqE47AX1A4r77OjuUCdgAruthJjD9VJ79IwYlyJXSlVFq4dbgLdrjjQrWQ0
	 NgEtOJc4jy5tA==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: send ROAM_ADV on each roamed back client" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:26 -0500
Message-ID: <20261109201526-failed-6.1-aff4d5d10f2d@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aff4d5d10f2dcb4a9b604e27414dafa1d51b6406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201526-failed-6.1-aff4d5d10f2d@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




