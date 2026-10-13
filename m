Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F7399372
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902350; cv=none; b=dG7B6FXMV9sZVTC1ZQL9nPAeiT+RoLt8bEUkmZE5tD8IlrA+aOIDoKTR+azXJ6hB5hlykafe/B0Q/6iZhDxAxQhzWnLPyV/ksj2JyDnnMEafPZ1IArWXUCztK+cxkTdJOEUzwknbXrJKCvRKrIhXj6eegB0Ft+xaNKp3bIul45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902350; c=relaxed/simple;
	bh=coN6Citiof3NV1xoDlhgeNfsTHMNOblEIfuFBsdBR14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNOpQa+u93X+ehNV8N4VfiTuYpWN4cg4Yt7b42yPvy2AL4jjpvEWSsBBsJ33qC3K2j8tD5M5deB98g6jyPvJsosNszUwAhSPJKxWuCk81JGxY8GE8CsXeONY3a4CCO/eIY1AQEHQlNCITZCpHKaTd/mYnD4EpXDluQ8Af/p/MZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLisSSST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLisSSST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544171F000FF;
	Tue, 13 Oct 2026 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902349;
	bh=HRtBNxdhUAmIDHiHrNRAdeydqcg300IxlzSrAI0OJuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLisSSSTh/Z75A0WHoYg658jkUn3tF058mr/Uki2hSvUvMQx7kCKzq6wqSVKe6G8p
	 EhUhh96ccpYMTXcSb37mOResivqgg+9dcUX7OF/d2blWJC3H80cmVq2hqyzLU3qkCG
	 mxwD+7P86QrkYrQeQPRBxbCZtm4oWzWwMLEHcaM84vGHficiVrmUo6MMkCzcQbsLZN
	 EjXU23IeysOyFBmBMNtSU8HDaBgTPuJoMMXoL1atEj9iGfp24+cdPzEJAxylixH+n3
	 w9cm4Mc20Ax/J+DalZpIZzSI51MnoWrRl6dWZ87xwimRjCr8Wen/LWkcW5EUPy9Dt3
	 qgEYyNfPuOHfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zixuan Chai <petalzu987@gmail.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: bridge: avoid recursive multicast port cleanup
Date: Tue, 13 Oct 2026 10:39:07 -0400
Message-ID: <20261013143849.4044254-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101240-savanna-duplicate-1e1b@gregkh>
References: <2026101240-savanna-duplicate-1e1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

[ Upstream commit 5158353121bae4f552cb677ce8c5c3ef52f93a0d ]

br_multicast_sg_del_exclude_ports() removes automatically added STAR_EXCL
port groups by calling br_multicast_del_pg(). For S,G entries, that
deletion calls back into br_multicast_sg_del_exclude_ports(), so a large
number of STAR_EXCL ports consumes one kernel stack frame per port and can
hit the stack guard page.

Keep the complete port-group deletion path for cleanup, but suppress the
S,G exclude-port cleanup while that helper is already walking the same
entry. Normal deletion callers retain the existing behavior.

Fixes: 8266a0491e92 ("net: bridge: mcast: handle port group filter modes")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ sashal: Adjusted context for the __br_multicast_del_pg() declaration because neighboring upstream forward declarations are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_multicast.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5cc65f51b3785..53dd2d56c37ef 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -76,6 +76,10 @@ __br_multicast_add_group(struct net_bridge *br,
 			 bool blocked);
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg);
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports);
 
 static struct net_bridge_port_group *
 br_sg_port_find(struct net_bridge *br,
@@ -361,7 +365,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
 		if (!(p->flags & MDB_PG_FLAGS_PERMANENT))
-			br_multicast_del_pg(sgmp, p, pp);
+			__br_multicast_del_pg(sgmp, p, pp, false);
 		else
 			pp = &p->next;
 	}
@@ -582,9 +586,10 @@ static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(pg, rcu);
 }
 
-void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
-			 struct net_bridge_port_group *pg,
-			 struct net_bridge_port_group __rcu **pp)
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports)
 {
 	struct net_bridge *br = pg->key.port->br;
 	struct net_bridge_group_src *ent;
@@ -598,7 +603,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
 				       br_sg_port_rht_params);
-		br_multicast_sg_del_exclude_ports(mp);
+		if (sg_del_exclude_ports)
+			br_multicast_sg_del_exclude_ports(mp);
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}
@@ -609,6 +615,13 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 		mod_timer(&mp->timer, jiffies);
 }
 
+void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+			 struct net_bridge_port_group *pg,
+			 struct net_bridge_port_group __rcu **pp)
+{
+	__br_multicast_del_pg(mp, pg, pp, true);
+}
+
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg)
 {
-- 
2.53.0

