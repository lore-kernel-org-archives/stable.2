Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE8469859
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805424; cv=none; b=JYCocGPKA6RRtxNvdwouAmoQ5gYP+N5GAJdMWd5PSXqVfGGPZ8TIAjto1WUX+IV9PP1lmWxlyMLLkI6kNsFwqF12jk8aJYpCz7/mJGXJEQdT4QH1Q40l0hxFnm5STcd7Y8UdYtE7g81C8c8d4mp9U6gX7ONm+WUXP9Nwz8yMDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805424; c=relaxed/simple;
	bh=PnOs5EiqiyZGmRp5J5YvJeN4Isg1XDeeHrElU9OIYFc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ucra389XjFrw5ZEYRW3p/C1WXpQ8Pln/y420lXJpttXKhqYQV2CVRWgToy5xHn64gNeLK9AOrdg0VnzEbUejuW4vN43UXO3amJ3IgE+HyHnmkZQ+FGdRcES3WWcpyjsMS43tLxWRwzc6yidJJYUHfFcaSuSZA/1w4BD+KiZ+hC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv8au2rD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv8au2rD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D0C1F0089B;
	Mon, 12 Oct 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805422;
	bh=j9jkQxQ68ub3py9XGzqqADRR0+G/D+XZGL5HpxOo/oA=;
	h=Subject:To:Cc:From:Date;
	b=Cv8au2rDg9VgGkSswnmNU9OnxJ4bsILpZEG7o7vnaywnNn08+/fbJdGy5c7bfADvm
	 DHvp8uofcv9VRXr9lBvzdkN7+MMEZt5mAJwfZfEaMqGD3HYgpn8kprCkRMkj0xznRH
	 mKbD/VN6S2dY5xWpDOqYss7GqmsbKjmlE+NqpqzM=
Subject: FAILED: patch "[PATCH] ip6_gre: remove obsolete ERSPAN PMTU update" failed to apply to 6.6-stable tree
To: 4ncienth@gmail.com,idosch@nvidia.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:43:43 +0200
Message-ID: <2026101243-shrivel-chrome-e622@gregkh>
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
git cherry-pick -x 8bc60db48e8cba35488bbd6e1f94aa990afa275a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101243-shrivel-chrome-e622@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bc60db48e8cba35488bbd6e1f94aa990afa275a Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Fri, 2 Oct 2026 12:30:58 +0900
Subject: [PATCH] ip6_gre: remove obsolete ERSPAN PMTU update

A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
and mirred can redirect it to a native ip6erspan device. The legacy PMTU
update in ip6erspan_tunnel_xmit() treats that metadata dst as a route.
Since it has no output device, dst_dev(dst)->mtu dereferences NULL.

On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0 used
self-created user and network namespaces to trigger:

  KASAN: null-ptr-deref
  RIP: ip6erspan_tunnel_xmit+0x10fc/0x2cc0
  Kernel panic - not syncing: Fatal exception in interrupt

The update is obsolete. Commit fe1a4ca0a2b7 ("ip6_gre: process toobig
in a better way") changed IPv6 GRE Too Big handling to update the
underlay route and removed the equivalent block from __gre6_xmit().
ip6_tnl_xmit() then propagates the underlay PMTU to the overlay route.

Remove the stale ERSPAN copy and its now-unused dst variable. This
eliminates the metadata-dst dereference and keeps ERSPAN aligned with
IPv6 GRE PMTU handling.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261002033058.358137-1-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc..04f7c70b7320 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -923,7 +923,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1058,12 +1057,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	gre_build_header(skb, 8, flags, proto, 0,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst) {
-		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst_mtu(dst) > mtu)
-			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
-	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {

