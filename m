Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA33E51F5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816936; cv=none; b=ksFcjWxZRBHugNmZwRRm6M/dDKmATHEMCjsZRXo6W3c5EMUnZVlqGb8iSMwB8AzO8wkJn4uLrOk/0bvrdKykGrMHfw/iQ0DKk5xYEuLV4p44mZiU3kjSJaO4px2xKWZvZABNi4+7GhWkuaiIDiE4avK16tclfiITWCwMoi3ezmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816936; c=relaxed/simple;
	bh=QtQb/r//LOhC9Z9MmDfAdZyCTvrNRtqvrL7sRAIUXtg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f+rQG7OaSGUmudEMVe7HVSZh4kY5nHcNL0zIg5mQ1YbiWPZjXBcLuh9xSdqWcFiI2EMptQFgKd90s/qZk06kofz/fKPbVacdhjJIYqUh3lpYIeaE2Qm81fYj66LzI6m5eRmhIWsMgtIl5L71ZJxD7mWPMiv6W3mHcZfPZgMJMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBgQA3z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBgQA3z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D161F0089B;
	Mon, 12 Oct 2026 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791816935;
	bh=iSaL9eAfZRDEq8djcvjFbNqKd5W+UWC4oaglS2PmMcY=;
	h=Subject:To:Cc:From:Date;
	b=QBgQA3z6bHwcBYVYwZpkjzJx+W1yS2up8srQTRvB0oVgz/Eo08qhrKyk7sSO29tg/
	 QIAWoPoLJvjdGVqTIKpX/MjfbKuFbEbPY8+k2ehuO6UuSNKyhqEf8KHXbJALBF6aR6
	 a2YaVOOCX86sVIX4oRUN7KFEbtwWZDXyX4fhWfpk=
Subject: FAILED: patch "[PATCH] net: bridge: avoid recursive multicast port cleanup" failed to apply to 5.10-stable tree
To: petalzu987@gmail.com,davem@davemloft.net,vega@nebusec.ai,weir@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:55:40 +0200
Message-ID: <2026101240-savanna-duplicate-1e1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 5158353121bae4f552cb677ce8c5c3ef52f93a0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101240-savanna-duplicate-1e1b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5158353121bae4f552cb677ce8c5c3ef52f93a0d Mon Sep 17 00:00:00 2001
From: Zixuan Chai <petalzu987@gmail.com>
Date: Sun, 27 Sep 2026 01:04:39 +0800
Subject: [PATCH] net: bridge: avoid recursive multicast port cleanup

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

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2f9bb30e1a1f..3fbad7b59769 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -81,6 +81,10 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 			 bool blocked);
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg);
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports);
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx);
 
 static int br_mc_disabled_update(struct net_device *dev, bool value,
@@ -458,7 +462,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
 		if (!(p->flags & MDB_PG_FLAGS_PERMANENT))
-			br_multicast_del_pg(sgmp, p, pp);
+			__br_multicast_del_pg(sgmp, p, pp, false);
 		else
 			pp = &p->next;
 	}
@@ -799,9 +803,10 @@ static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
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
@@ -820,7 +825,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
 				       br_sg_port_rht_params);
-		br_multicast_sg_del_exclude_ports(mp);
+		if (sg_del_exclude_ports)
+			br_multicast_sg_del_exclude_ports(mp);
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}
@@ -832,6 +838,13 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
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

