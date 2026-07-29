Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D96282F35
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333187; cv=none; b=TQkG/eWfku46DooHJJ32slLZM+hgr2HjhiuCzrmh4ilkqGgmmJHbTF3RQ0GsCxYSMK3Qh6BmTCkDDWYU6A/aXwzmA7hIisxSrZL/ekdKjwmhetK4nsB9cRDRG8XIeCskp2o5E7ClawfxO4tm3fsr6DEQ9/YPcVp52SROkv+NAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333187; c=relaxed/simple;
	bh=ekd0VVyWEqEkaBl6TI16skNvxxuzohRkogUmUH2U110=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WPK0JibkI4yALmyfb7gaxfTdOdIdVO28Wm50BTy2b64k8JXgkKhp/l4FRX58bNgfNDMy+OWK9S9vdPsRX6xMFN/7cx3Bvi/IEWDIgM9QqxEbIjxhLHNYn5Ixg3UbPLseU2kea6UN2cfzELy/XV51K/c1xaT0J7pLGvd1RVGSKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oueJ1gCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oueJ1gCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DDB1F00A3A;
	Wed, 29 Jul 2026 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333183;
	bh=4f0AmRls1C4zvYX+EajAh+0x+Cs1aeF3SpC0WFUGoG8=;
	h=Subject:To:Cc:From:Date;
	b=oueJ1gCz9PYrvBh9niaGZNqazHKtgxCdQMjG9HpFwf4TniksmiSOT7enhYpbXa7Ws
	 51YMIJsnc0QI5f6d+aLAFm2CSG7ipcvK+fOy+b5p1O+7t4JZZHNGouRIZnBX+1BIIt
	 2BRJ120sukehO8eGXQmA6q0Ip16eYvS0wbq33vfA=
Subject: FAILED: patch "[PATCH] net: gro: fix double aggregation of flush-marked skbs" failed to apply to 6.6-stable tree
To: shiming.cheng@mediatek.com,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:52:46 +0200
Message-ID: <2026072946-scavenger-smelting-3d16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e751256486d0ded20f5a9f9863467f1dce65142f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-scavenger-smelting-3d16@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

