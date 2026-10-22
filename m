Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674800;
	b=zdgA7/QDnGw/Jnngdy8w+oIIO4QPoV7GX4VUJ9vvS7afjLHSLeNfwO+IXE+NGDpoWxZK
	 CkImGxy1GMlDEDB/LkizlW4HEAjlHsTDfrE+2MGRKxIkbDQy3dNG/n5i6JPW17KPCJXO7
	 fxARC9a14OSsDSP0PRz5MBxGTcrgg0WsdRL2+uNy4I/xWctToSIwZIcB48mW+GrLkedjU
	 d+aLHxMrF6dUKmQgkHMmAULv5lMFmLxw5cGtM+LQ0upneR9ZEMjlPTct3k8oqavkYvPh/
	 xbBF5n2QlT+IJcl5P/TyVgNnvjsFjRjqy35xDpiYZ5m7dPqYSs3N/GzYo6gCdFV/tdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674800;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rFwIFitE7AV6lw8I7TltUlunE+8mu1Eia2EX65/4UiI=;
	b=1QHslKeMamXa55e0ZvQ0bwDVb7N1fgb71q5XFdZVDL/h+fCYdt+3MH5r9uoRt4pKEIMG
	 uJZpOSBXURcePOAwNL6g1dxumV1oNvWQDCWvtnyd+U+cedcPJc49iHfsbr4y1o8X73Mb5
	 qeL+aS8avJ2funbe8m+D3n2J5Z+wyVFV/c07TL+opNU4cTAkEMMdE/lgfBBA8EEOn+BHn
	 0sbWGjJ5UALClPmNSCibiJcSRxmF0ac46eel47I5GCFFmD1UhGVohgJYSzpAFJyGJKwoe
	 OQqHkpnjNfEF3k8Ny8W63I57rgA9hYagTS20kzADP+Z9zraTeknVkrrYxHqMMBf9csw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HXkFVPlD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3090606A330
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HXkFVPlD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8FF1F000C1;
	Thu, 22 Oct 2026 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674799;
	bh=rFwIFitE7AV6lw8I7TltUlunE+8mu1Eia2EX65/4UiI=;
	h=Subject:To:Cc:From:Date;
	b=HXkFVPlDJAluMGpW1rFAiZQeqhD//U/gjNufPXhzhcFjnGGNIlhnQvcjGGyga/JEo
	 Ps5LlL3dQtnoOJCqekz2kGTBIjxasouuI2WhFG5p3vNZFNFixBdRJt+6kC4DWTxSz+
	 H/teDKh7fo5NwzjLidLbJ9U3OtalT61NV8itrek0=
Subject: FAILED: patch "[PATCH] net: bridge: mcast: don't truncate the port group walk on" failed to apply to 5.10-stable tree
To: littleddfu@gmail.com,corvus@tencent.com,junvyyang@tencent.com,kuba@kernel.org,razor@blackwall.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:09:17 +0200
Message-ID: <2026102217-reuse-backlit-3e7d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5a3f7a683aee56e1f15c9d53041f3236767eaae7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102217-reuse-backlit-3e7d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a3f7a683aee56e1f15c9d53041f3236767eaae7 Mon Sep 17 00:00:00 2001
From: Jun Yang <littleddfu@gmail.com>
Date: Mon, 31 Aug 2026 19:13:04 +0800
Subject: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown

__br_multicast_disable_port_ctx() and br_multicast_del_port() walk
port->mglist with hlist_for_each_entry_safe(). However,
br_multicast_find_del_pg() can also delete other entries from the same
list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().

If such an entry is the iterator's saved next node, hlist_del_init()
clears its ->next and terminates the walk early. The reproducer triggers
this in both teardown walks, leaving port groups in the bridge mdb with
a dangling ->key.port after del_nbp() frees the port:

  BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
   __mdb_fill_info+0x1191/0x1320
   br_mdb_dump+0x594/0xe40
   rtnl_mdb_dump+0x1cf/0x5d0

Use hlist_del_init_rcu() to unlink the group while preserving ->next.
br_multicast_del_pg() and the teardown walks run under
br->multicast_lock. The GC worker must acquire the same lock before
detaching the group for destruction, so the node remains alive while
the walk uses the preserved pointer.

Preserving ->next means a walk can now reach a group that an earlier
iteration already deleted as a side effect. That group is off mp->ports,
so br_multicast_find_del_pg() would fall through its port scan and hit
the trailing WARN_ON(1). Skip such groups at the top of that helper: a
port group is put on port->mglist when it is created and only unlinked
when it is deleted, so hlist_unhashed() identifies exactly this case.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20260831111330.199543-1-junvyyang@tencent.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..3e9b10f8abf1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
@@ -835,6 +839,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 
+	/* A teardown walk over port->mglist can reach a group that an earlier
+	 * iteration already deleted as a side effect. It is off mp->ports by
+	 * now, so skip it instead of falling through to the WARN_ON() below.
+	 */
+	if (hlist_unhashed(&pg->mglist))
+		return;
+
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (WARN_ON(!mp))
 		return;

