Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273939;
	b=ZPpwXco4L2PiYabW2Wy4OxGlpSUlU1+LNApv5br4AZpKNgcGaKRJ+YkBNCtiU1Fx/NjN
	 q1Ee+X/qk9v8DFGcfndDaxjQxpM7r/YXOKZhOh4fg+Hv9iBWFKcaDPEhLD9dT4jhCSorM
	 m9UDVqZUz2Y0aqN1KA999bjZwaAUrnfvTZ36z9KsB5YzkX86ykT3qdGZvo7QQwZ1A9/qV
	 FoEvXtBTsD3cQSyowOFf5p81SfnJRUNmXJu9xO9vbFvPd0xqB5YbenM1ZsyGe0QTDHJQQ
	 B/g443snJF3Svxp8aHbGANFvtgmeteCBr1OPFPlHEGhfmFvtLkTnQKl5xj89PjWuW+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5l4APNAFeDqWx0luIXYFtqdGq0Fh/PjCEmXSrAsDPPw=;
	b=B7xLvsEfB7H+XF7WyewbxrrwIVP5YuM7yYKHcNMixnoKXGaHqOjWCGzBKD1n9bbhHSxz
	 BrViVIFMwIPBB+NCXWIBZ7B6HftfImKyJGNTPvpJ57xQb1zFlufKIdWl+AAyzFKa5q/Xd
	 vk+XONtmsByupAmA66ycqY2zfQgUL8GWPWKleYxd7JepozkTh08k3R0ncYi5TJTMvLh+f
	 SqXfWSMtjqCK8qb39fB2yT+EISzcQtPxaWEY2lQieewf2bWCV9nQcizrB9NwYUp1YjUbc
	 YOys0+MU/hpzYSyUpsipFSb06gKxrCb/cCPZeflV/AKsDkW8PLspoDk22IVCt4u4gQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvs1472R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DC6071874
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvs1472R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318531F0089F;
	Tue, 10 Nov 2026 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273938;
	bh=5l4APNAFeDqWx0luIXYFtqdGq0Fh/PjCEmXSrAsDPPw=;
	h=From:To:Cc:Subject:Date;
	b=mvs1472R7ffwwbBocxKPNp0NVJ2Ol/bl0/+nkwnmFwbRoEAM7/FZxluT8oS0mP4UV
	 rmcxq88CkXnOru8hzaLMkLUWnaEvmaSTsAeyx/W0VYlU0OapwzyOJk/WBSVVpxTCtO
	 7mwH1PKAPoAINlgI+WIdczHypGTUOOdC3GQoXXZWQ3e+wtMPLlqKapWEkFhQ5PO6DN
	 jwwNCx0ZzAKUfombOXzSLN3B/x0Ezm8+z0lRt5U0EXt0suYRxsQ6+d9e5KJyg1DADF
	 cr041wOOz6zm2Z5oJFSwQUScgOQzSqNofQFQA8t+zztISn0hoyqDLMWT5lqF5347k0
	 4/QzGAurdwVhQ==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: ignore ROAM flag of received ADD changes" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:37 -0500
Message-ID: <20261109202537-failed-5.10-c5d68abe6e7f@kernel.org>
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
git cherry-pick -x c5d68abe6e7f1dbd132a602cb696fe1fff0389eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202537-failed-5.10-c5d68abe6e7f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




