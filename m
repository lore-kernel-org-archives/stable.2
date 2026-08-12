Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074E41F5F5
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534639; cv=none; b=axCTOWktwZafbXvPbQ75nXCfKdQ7QEJdwNw3DAwMi2TKJ03ScKPwqBVqtsh4xT2U5l6g2+8Eyi+8YxbrV63TIhKO+vWq+t3riiLXPQK0w3DlBzyP7C6g874Ohv0NxG9dSUC5CnbuHrFtF4Y9XE6nKR3eJ16Mp0FqljB6jpC/xDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534639; c=relaxed/simple;
	bh=CrTvb2kGHPK7+d0R14EHkHS3bKejDJlE1grVilZoGvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3nUiOHSUWqXJ0AVSc56R5JZ+JH7XoGDd+ImmouREjE8/ouEACpuej9qmxr3f+Nywnt9ETVoVcq8b3hyxqLT6GxNLj3nX4DI5gbOH8s7nuiaXQydg/lrod3vLoivwMKBFHXqI8jIpPr//Z9WDQj2lsXPT2mjQx1RGmQsA+o4bwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw9Co8UR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw9Co8UR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceab75934dso11620725ad.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786534638; x=1787139438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=awK1WKPMjKwqqW9lFazWbI/9bmuJ+2znKvkeY5ORX+M=;
        b=Zw9Co8URzGv80bCltBNL7kV9DPRMt42wt4JR/36IvUUUPIoGBu6aCRJq1N3YvRMi0q
         F3n9BrOvv6Gjy/eihZtoWdzBtRXUZOYSl7B5O+YGsImoG/NF81VelpZVmzxewlBy6rJ8
         5/JjqoJTxpcV9MFIUUhQp3SLegk0DG6z/n+TGtSFgZETwoMQDi3fiHXBRScS7jIxslcq
         Yq9IgOiPAOc2kWJuUb3Po2jWWMWubVF8k7EGkcetZhpMSKM8n6pQ6GclbUo5DZdfg+64
         pdN8SOA9qyAGtOpqfrYoDD+AbGqtaz7b3XCQGE3RA2Q+NIemEj2YINyzWJMP0qjfFwME
         hUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534638; x=1787139438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awK1WKPMjKwqqW9lFazWbI/9bmuJ+2znKvkeY5ORX+M=;
        b=TCHLjceO1LXxdQbWISnSxDuzzBCjHod+GQ/hPFcMP9oYexmUWxaeZl+k1+iahi8yHE
         u4OEb7SWYhpZPVFSMp9xDUi5M6wyRpIixSYxoM3K3jx/G5b0VHcx75JjDCZ4fS/XlyHa
         JqooNeghZOaNGZKOEkrpIpdgIbXMz8H4jBXzC1W1yKkUhNLfrHW17kF9HJzZyW2vai0z
         ff07PcqwQ+Mtl6tuVP/UhszJK1u3SFIzEOWfPfOuVsNfFCBKEaQWDW5ymmyxCCUINdrS
         xjP7r2TEWGSckJ/aYQl5O1GdqxL6fybyO3MnOiVQKlnQ2MRz/HmJIQlITMeF1btJG3Kc
         jSsw==
X-Gm-Message-State: AOJu0YxhR9lae2liG+JqVNY6PmJZpPcdhT2c2bdsyAYpfa47N1lJEYVo
	boU30l5F87IALeQqI67ZN34yMHYaNaV85nXLLV5zsSrrmtjjqweju9mL
X-Gm-Gg: AR+sD12zahUTqGg1ySkLf4kIOn7yauwBWfqYaWSHhZOMd6ltFjpE0zqW6ey5rpEKa/6
	X+Gkq4HyNG4QOGeVAjhCGLV+5/nXx+TMxEp2bWr8WwUPCooPieECZCrjoQtPLkZzOg3aX+HtgtB
	T+jC0Fdv0etNMsHmNTbzUJ2J2mhMiCcL/lpG19DmP9yV5UVZ/pA1qOKDoB2/C7QWYskfVEblJEH
	LHONFj4mR7arj6umu/VOs8XJPmfM1a0FZoLkn/kd94RVxvL0/E8qIvi9G6zVR2dX32spofJqU+j
	T10aJFTU9tUYoqh9Xzz5sWFS7YUHqZ794ISc/tOLg/yC7fy9V35YbuBQNbQXF4QHxElNOb2aHTK
	xt2X/CC1YRmu6+NFTv7+0rqv2Twdw11OM17F58KSmHXCyT4PjN1qqSlCp5MResyA19EisOkgnGV
	eArYn82mw0NBAbKlcRONEpviLmkLXpPdvoNvvW/d7rw6bnZlBW56/zwAg4BVlUdEo=
X-Received: by 2002:a17:902:cecf:b0:2ca:f8ef:33e4 with SMTP id d9443c01a7336-2d3456e06damr50057335ad.17.1786534637562;
        Wed, 12 Aug 2026 04:37:17 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35222e5b3sm4942125ad.74.2026.08.12.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:37:17 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Wed, 12 Aug 2026 19:34:24 +0800
Message-ID: <20260812113435.1854275-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__br_multicast_disable_port_ctx() and br_multicast_del_port() walk
port->mglist with hlist_for_each_entry_safe(), which only guarantees that
the *current* node may be removed by the loop body.

The body is br_multicast_find_del_pg() -> br_multicast_del_pg(), and that
deletes further port groups of the very same port. br_multicast_del_pg()
drops the group's sources, and br_multicast_fwd_src_remove()
(net/bridge/br_multicast.c:583) deletes the (S,G) port group installed on
that same port; br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
(net/bridge/br_multicast.c:330) deletes the automatically installed
MDB_PG_FLAGS_STAR_EXCL entries, again on that same port. All of those sit
on the same port->mglist.

When one of them happens to be the node the iterator already latched as
"next", hlist_del_init() clears its ->next, the walk sees NULL and stops.
Every port group after it is silently left on the port. port->mglist is
head-inserted, so this needs the cascade victim to be older than the (*,G)
entry owning the source - a user-added, non-permanent (S,G) MDB entry added
before the (*,G) join produces exactly that ordering.

Hitting it once truncates the disable walk in
__br_multicast_disable_port_ctx() and once more truncates the flush in
br_multicast_del_port(), so del_nbp() goes on to free the port with port
groups still on port->mglist - and still linked in the bridge's mdb, with a
dangling ->key.port. Any subsequent mdb dump reads the freed port:

  BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
  Read of size 8 at addr ffff88803065d008 by task bridge/9527
   __mdb_fill_info+0x1191/0x1320
   br_mdb_dump+0x594/0xe40
   rtnl_mdb_dump+0x1cf/0x5d0
  Freed by task 0:
   kfree+0x265/0x740
   kobject_put+0x212/0x6a0
   rcu_core+0x5c6/0x1140
  Last potentially related work creation:
   __call_rcu_common.constprop.0+0xb7/0x9e0
   br_del_if+0xdd/0x260

Don't rely on the pre-latched next pointer. br_multicast_del_port() deletes
everything, so just take the current list head each round. The filtered
walk in __br_multicast_disable_port_ctx() keeps its iterator but restarts
whenever the latched node has left the list; port groups are only freed by
the multicast GC work, which takes br->multicast_lock, so the node is still
valid memory for that check.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/bridge/br_multicast.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..624dfca4066b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2065,12 +2065,17 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	struct hlist_node *n;
 
-	/* Take care of the remaining groups, only perm ones should be left */
+	/* Take care of the remaining groups, only perm ones should be left.
+	 * Deleting one can delete others on this same port->mglist, so
+	 * always restart from the head.
+	 */
 	spin_lock_bh(&br->multicast_lock);
-	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
+	while (!hlist_empty(&port->mglist)) {
+		pg = hlist_entry(port->mglist.first,
+				 struct net_bridge_port_group, mglist);
 		br_multicast_find_del_pg(br, pg);
+	}
 	spin_unlock_bh(&br->multicast_lock);
 	flush_work(&br->mcast_gc_work);
 	br_multicast_port_ctx_deinit(&port->multicast_ctx);
@@ -2126,11 +2132,23 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	struct hlist_node *n;
 	bool del = false;
 
-	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
-		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
-		    (!br_multicast_port_ctx_is_vlan(pmctx) ||
-		     pg->key.addr.vid == pmctx->vlan->vid))
-			br_multicast_find_del_pg(pmctx->port->br, pg);
+	/* br_multicast_find_del_pg() can delete further entries of this same
+	 * port->mglist, so the node latched in @n may be unlinked by the loop
+	 * body. Port groups are only freed by the GC work under multicast_lock,
+	 * so @n is still valid here; if it left the list, restart.
+	 */
+restart:
+	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist) {
+		if ((pg->flags & MDB_PG_FLAGS_PERMANENT) ||
+		    (br_multicast_port_ctx_is_vlan(pmctx) &&
+		     pg->key.addr.vid != pmctx->vlan->vid))
+			continue;
+
+		br_multicast_find_del_pg(pmctx->port->br, pg);
+
+		if (n && hlist_unhashed(n))
+			goto restart;
+	}
 
 	del |= br_ip4_multicast_rport_del(pmctx);
 	timer_delete(&pmctx->ip4_mc_router_timer);
-- 
2.55.0

