Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BF48EBF7
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333189; cv=none; b=X6sYzgJ4x4dNxkFcNG6Q04It2KMdOA06bFd0uQuvb8K5vYphRwYvEu5nT7KFoDzafeEypaaB6ATNoKjGTWuSsRE0p3zY+X0S2VmEUw0lBJ9dyY0xyYhdL6BCwfl8vvCeq/6A4pjkqNB7yzmrwdPeyB4mj7CL4G4CrqhCW0SEd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333189; c=relaxed/simple;
	bh=phRxYn+wVYI05ruagnKeD8fvGfpN9oWeds9PWNAynCM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q95ty2pDLYt6YQPK/cizVPXc1ZyGf8aQ9pbylxkNwQ9SdsWC8gHo3K3y2CHhC+eyRMCkvSWbzAJGaNjNRI/ff+ATrZAZptUZOxn39cwC+1F3E6RpI3f19lcY1aqy1/A5IQMv7lHNV0aFlUPt6eJRY0GV51AerID5HPQc1YhIFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TlEt3vcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TlEt3vcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BBA1F000E9;
	Wed, 29 Jul 2026 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333186;
	bh=B41izZfDOXig29WMz/dp81nmcdnNpMax4mCGYKZaQJ8=;
	h=Subject:To:Cc:From:Date;
	b=TlEt3vcsjiWy27e2u/dtxEO0irRyD+lY8+sTdSoO++GThuDEg4So720Uq61hxDgY7
	 N917K8z7nCBJHyLc+aVXx20HnW+NQxmpyRR5xxVRq15cntJBrJhr2b9EOvWsPXTHlb
	 qg+ROj4XUAZWXNRFDraHuztuxK6XGdUT4B3d2+Gk=
Subject: FAILED: patch "[PATCH] net: gro: fix double aggregation of flush-marked skbs" failed to apply to 5.15-stable tree
To: shiming.cheng@mediatek.com,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:52:47 +0200
Message-ID: <2026072947-straw-entity-e1ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e751256486d0ded20f5a9f9863467f1dce65142f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072947-straw-entity-e1ff@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e751256486d0ded20f5a9f9863467f1dce65142f Mon Sep 17 00:00:00 2001
From: Shiming Cheng <shiming.cheng@mediatek.com>
Date: Thu, 9 Jul 2026 09:46:39 +0800
Subject: [PATCH] net: gro: fix double aggregation of flush-marked skbs

Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
packet.") added a flush check to skb_gro_receive(), but
skb_gro_receive_list() lacks the same validation.

As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
re-aggregated.

This allows already-GRO'd packets with existing frag_list to be
re-aggregated into a new GRO session, corrupting the frag_list chain
structure. When skb_segment() attempts to unpack these malformed packets,
it encounters invalid state and triggers a kernel panic.

Scenario (Tethering/Device forwarding):
  1. Driver: Generated aggregated packet P1 via LRO with frag_list
  2. Dev A: Receives aggregated fraglist packet and flush flag set
  3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
  4. Missing flush check allows re-aggregation despite flush flag
  5. Frag_list chain becomes corrupted (loops or dangling refs)
  6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list

Root cause in skb_segment():
  The check at line ~4891:
    if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
        (skb_headlen(list_skb) == len || sg)) {

  When frag_list is corrupted by double aggregation, when list_skb is
  a NULL pointer from skb->next, skb_headlen(list_skb) dereference
  NULL/corrupted pointers occurs.

Call Trace:
 skb_headlen(NULL skb)
 skb_segment
 tcp_gso_segment
 tcp4_gso_segment
 inet_gso_segment
 skb_mac_gso_segment
 __skb_gso_segment
 skb_gso_segment
 validate_xmit_skb
 validate_xmit_skb_list
 sch_direct_xmit
 qdisc_restart
 __qdisc_run
 qdisc_run
 net_tx_action

Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
skb_gro_receive_list(), matching the defensive programming pattern of
skb_gro_receive().

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Cc: stable@vger.kernel.org
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260709014704.3625-1-shiming.cheng@mediatek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/gro.c b/net/core/gro.c
index 35f2f708f010..29b4d02bf519 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -229,7 +229,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
-	if (unlikely(p->len + skb->len >= 65536))
+	/* make sure to check flush flag and to not merge */
+	if (unlikely(p->len + skb->len >= 65536 ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {

