Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272785;
	b=0dwc8Xq4DDmEDC0WPP0+ZWvuFLt/OS6khqRz8gDepepYJYh3DWeFugTkQsAl6DFMbVNK
	 tBIDqKbCxxXDUmEZXIhV83Nm+OcxEDEf84m6SvJLZk3baJjilz4P333/+sFpF8c4dSPQk
	 kfNaigtYE/Hycrd/GQTZJKFfumOiXyp/vIPzx0ngW4Z+QI015Ldu7bZTjriXBxl3jiwBX
	 J3Bh5xRDBzPJ6JQzDBcAl6a6gRXkMa/U9GaqiZODRMYTlFoMw3BmR6BLvfpax//i/CeVY
	 Xdff6uhI200YhloOmMFhdQVXzChqKrYRs90lBYPbCdYbOoUZSBR3/WOhN8Ffqh9EZxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272785;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=02pNoas1m9YEMLXvIzNOJ80IfuKhoATOv7CQE3DKv6c=;
	b=hLohKzIN9nps3gy/Sp+Gq+77VO/9U48XiWkwnCm0EG3NKqNJdMCSWuXM/gR6uwUwGARK
	 kRIi1QQWEiRHnOaEMxgTM+qb/BdCLCO/w5yS67QZ8cJBJDLRuoFgiP3EDHXqErmIuPA2k
	 85Xs2C3j9Ydoag1tHIFkxDYFluD0RGO7BuO8EHk3VyoWMK37XyaqFgPEkykVC9XOiQssF
	 9GlEis6C4QbB4Qaa+7O+4ZFXQaOVGf7Uzx7GtdLJ2ZTLQl1Rz+7YtwNfn+Eg8jKrSOLGP
	 K3s4StMKjR26jeg3pKLWMRZRafSYed2UJT8HQpwwlNMlpJp7xX0WORiZCTRXsqYDaDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oErM+JqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67913606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oErM+JqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FA91F0089F;
	Tue, 10 Nov 2026 01:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272785;
	bh=02pNoas1m9YEMLXvIzNOJ80IfuKhoATOv7CQE3DKv6c=;
	h=From:To:Cc:Subject:Date;
	b=oErM+JqMswrboQhb/YAzcrGaF6o68ewEEameDR2LiRxJCpXHyrmdcxyWljz5YM/of
	 DW8Qxg3GPTUYz2HRg0FrTcokAu5xUiyXehf9/2S2X0DwQqsArWn7G1Xv5t5QUF0aiB
	 ezty9rF5iO/ACONrtFraHrCns236WhaJ0jwYZ8idmrPT03TQDUkWIPSPrOWIdiOuTI
	 VvGI1FwYNHmRcz0PAb4TesBZ4bKfX+iqWCy/fRe0eW+8A5ynoI2780aHvgMd/2fvzx
	 d2A3sSlvQl9wtY8DUMyh+hlmfzZ607xE2WdprcQeDT8VsnIbpmtRg33ZGDazY8rWYi
	 bNFf5LpXjdOtw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: send ROAM_ADV on each roamed back client" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:23 -0500
Message-ID: <20261109200623-failed-6.12-aff4d5d10f2d@kernel.org>
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
git cherry-pick -x aff4d5d10f2dcb4a9b604e27414dafa1d51b6406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200623-failed-6.12-aff4d5d10f2d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




