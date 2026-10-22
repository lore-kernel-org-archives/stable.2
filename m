Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706644;
	b=EqAwx3n5Az4s5ZdEiICXnw+ImscWdzdH/dIz95bFsrV0NbkHlkOgmTfMnhGoudDPuVbv
	 1mLpTOurQE0lVtYz3sscvPmkvcuXMFCJDPyQEdX8vOG9foiHyJbHwYeswK+BEfh0Qg+03
	 V/elEdWVgz1b+XggMKg5if+0om3azO8rjP+wqe36X2dAQRAz+6xl9XEZ0+DUQrvKAAFkZ
	 6o17N7gqHyryZxKra2h0Y5o0s5LrWdvh2Q2xoSrxsiPOv7aMiQBH5deGzoSPwKpfFmCuk
	 0UhhDNdKn6IicDLpePIWshbWiWImXXOZESnIhbwkSsHsQXs4ZP/S+gC4Qj0rQXgWoGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BGSGjw3AfRJKhSQYDygDyishNCZub3fivg1QMA60f8g=;
	b=YxSF27Tb6ZmjS/sgr86Va58cm4F/aZgHqvTWGEn6FMmN7suwk8NAB751ClLDj5Vy7ZDm
	 gagyOOLpCj4EqhWf/btMk4/BlcuihXSixsfOZYXNKzwZKGNhTp1EiBXedEzZVUVjTG9MJ
	 lXapj4AzqDxrIhnmuKC0DY/tvpUrwaibomyQWjyiWqsu3NdE4Qoi2utah0LSBzc3is9aZ
	 mI1QKcv1qzJ5h/6+Nd+cyUoKUA4qghe0SGZNYRjDUKpucJlfLRlLujTgG21lk72uuld16
	 1VAby/wG7HFo4z5ekbn5+WhjV3ofcgyAMmMAc3zfPCUDr8BrTfVedXu+VPpVmJGG37g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FrwT9JO/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450D606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrwT9JO/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD53D1F01825;
	Thu, 22 Oct 2026 22:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706643;
	bh=BGSGjw3AfRJKhSQYDygDyishNCZub3fivg1QMA60f8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrwT9JO/Hcvy85wiZb4u3hEMQOeuQW5tJxM93b0sUISxLeYYsgNJXlJjxu/Jh/5ZZ
	 9Un9MTj2FqeLhwtDfPi7VO4oupIZp5sm5ptM37eb+/T6IDkYHJeZsE4VGZLpcYQ43I
	 Bj98KqfnTOjyefIZUhJ+qpLkk+M/IZQ6jbmSY4HN4tMcke6b73lvnSl87vkwFNIgBr
	 owTc0T2fNOQm+u68mXOPV4spn3txYOnf6rSDPBj8vEvQunHkfApb+7Mqq928NA0z7K
	 F6CgX6cCkJ+HSrZjR51afFCXeNSMtJlEG+JnlHMFJdrUHYAY1VCp44JEtP1bF74Urg
	 4owOIFC7ZSeaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jun Yang <littleddfu@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	TencentOS Corvus AI <corvus@tencent.com>,
	Jun Yang <junvyyang@tencent.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Thu, 22 Oct 2026 18:04:00 -0400
Message-ID: <20261022220239.1982727-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102217-reuse-backlit-3e7d@gregkh>
References: <2026102217-reuse-backlit-3e7d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <littleddfu@gmail.com>

[ Upstream commit 5a3f7a683aee56e1f15c9d53041f3236767eaae7 ]

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
[ sashal: Applied the br_multicast_del_pg() change to the existing __br_multicast_del_pg() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_multicast.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 53dd2d56c37ef..fdaf2db7173e6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -596,7 +596,11 @@ static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent);
 	br_mdb_notify(br->dev, mp, pg, RTM_DELMDB);
@@ -629,6 +633,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
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
-- 
2.53.0

