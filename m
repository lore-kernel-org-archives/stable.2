Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9113A258;
	Fri,  9 Oct 2026 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586323; cv=none; b=fNU9THis4sx98pyEpi5wKPdJ4zZcLhZg2hsqW7PizZKMaKbnrlQfFsWyF4hX7X2KnNpeEuFKRBjk8KERXDkkxgQ796TBAKKvzn9hPP7Ylh4SDK9SvBMVo+eJMyG+MkROjGizFM4kXIW1xR/UI50X/iPBCLjewFvKZCAn9ShRdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586323; c=relaxed/simple;
	bh=v/TAjBE1UUbpIO6vyUnpk9uA82N5vj3fjiVm6XpI/wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCQZ2gjTCaEMyrPWrqzHS7Cd+fu70Osf0ied1vNzTYNlO+ZnqD2WUy1AIokIEO25zJ1x0asB9WWgbyIhS7dzCj84CcZIpr6fnxpV8OzhautxyqbDvBrKAMa1wGsuzDESBjgb/94Jqdqt3NZF0qBexythpBZjN4TR1xm5gi/gTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=djWKgrWw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="djWKgrWw"
Received: from localhost.localdomain (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7007320B7168;
	Fri,  9 Oct 2026 15:51:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7007320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791586320;
	bh=SB6i8Q/z/JBPFDBZwt31VaHf1p4MoLNT0AmWMeHfREs=;
	h=From:To:Cc:Subject:Date:From;
	b=djWKgrWwhisrmcXPOafuVy6rBaoKPKlAV2naI3A2Du7g1U+MJHAZO9SL12vaONz6z
	 +BWGP36wsc4um/LIG9RcCIUUEQqGCXZ4xNmCC91Z0py2/TZ4Yfy1Ce5sezZpVfUfQ7
	 F7qZAu4yCwSm+ox6KU9JRw8DNaE+ZrN4mH7HG1T8=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
Date: Fri,  9 Oct 2026 18:51:42 -0400
Message-ID: <20261009225142.47005-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib6_walker uses w->leaf to remember the next fib6_info to dump, so an
RTM_GETROUTE dump can continue there on the next recvmsg().  This
assumes that whoever removes a route from the tree also updates the
walkers pointing at it. The NLM_F_REPLACE branch of fib6_add_rt2node()
can break this assumption. It removes the old route, fib6_add() frees
it, and w->leaf keeps pointing at the freed object.

The fn_sernum version check in fib6_dump_table() normally protects
against resuming on a stale w->leaf, but it can be bypassed:
ip6_link_failure() resets fn_sernum to -1 when the default route
fails, which an unprivileged user in a user+net namespace can cause:

  1) link failure            fn_sernum = -1
  2) dump pauses on route R
  3) replace R               fn_sernum changed, R freed
  4) link failure            fn_sernum = -1
  5) dump resumes            -1 == -1, reads freed R  <- UAF

  BUG: KASAN: slab-use-after-free in rt6_fill_node+0x1c22/0x2cd0
  Read of size 4 at addr ff11000011fa0064 by task poc/101
   rt6_fill_node <- rt6_dump_route

Fix by making the walker adjustment of fib6_del_route() as a common
function fib6_walkers_skip_rt() and call it from both fib6_del_route()
and the NLM_F_REPLACE branch, for the replaced route and each removed
ECMP sibling.

Fixes: 4a287eba2de3 ("IPv6 routing, NLM_F_* flag support: REPLACE and EXCL flags support, warn about missing CREATE flag")
Reported-by: AutonomousCodeSecurity@microsoft.com
Assisted-by: LLM
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 net/ipv6/ip6_fib.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9ff761962b45..a5699809fe04 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -89,6 +89,29 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
 	write_unlock_bh(&net->ipv6.fib6_walker_lock);
 }
 
+/* Move the walkers resting on @rt to the next route, or up the tree if
+ * @rt is the last one.  Called with tb6_lock held.
+ */
+static void fib6_walkers_skip_rt(struct net *net, struct fib6_info *rt)
+{
+	struct fib6_info *next;
+	struct fib6_walker *w;
+
+	next = rcu_dereference_protected(rt->fib6_next,
+					 lockdep_is_held(&rt->fib6_table->tb6_lock));
+
+	read_lock(&net->ipv6.fib6_walker_lock);
+	FOR_WALKERS(net, w) {
+		if (w->state == FWS_C && w->leaf == rt) {
+			pr_debug("walker %p adjusted by unlink of %p\n", w, rt);
+			w->leaf = next;
+			if (!next)
+				w->state = FWS_U;
+		}
+	}
+	read_unlock(&net->ipv6.fib6_walker_lock);
+}
+
 static int fib6_new_sernum(struct net *net)
 {
 	int new, old = atomic_read(&net->ipv6.fib6_sernum);
@@ -1315,6 +1338,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		fib6_info_hold(rt);
 		rcu_assign_pointer(rt->fib6_node, fn);
 		rt->fib6_next = iter->fib6_next;
+		fib6_walkers_skip_rt(info->nl_net, iter);
 		rcu_assign_pointer(*ins, rt);
 		if (!info->skip_notify)
 			inet6_rt_notify(RTM_NEWROUTE, rt, info, NLM_F_REPLACE);
@@ -1337,6 +1361,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (iter->fib6_metric > rt->fib6_metric)
 					break;
 				if (rt6_qualify_for_ecmp(iter)) {
+					fib6_walkers_skip_rt(info->nl_net, iter);
 					*ins = iter->fib6_next;
 					iter->fib6_node = NULL;
 					list_add(&iter->purge_link, purge_list);
@@ -1971,7 +1996,6 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			   enum rt_del_reason del_reason)
 {
 	struct fib6_info *leaf, *replace_rt = NULL;
-	struct fib6_walker *w;
 	struct fib6_info *rt = rcu_dereference_protected(*rtp,
 				    lockdep_is_held(&table->tb6_lock));
 	struct net *net = info->nl_net;
@@ -2022,18 +2046,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 		rt6_multipath_rebalance(next_sibling);
 	}
 
-	/* Adjust walkers */
-	read_lock(&net->ipv6.fib6_walker_lock);
-	FOR_WALKERS(net, w) {
-		if (w->state == FWS_C && w->leaf == rt) {
-			pr_debug("walker %p adjusted by delroute\n", w);
-			w->leaf = rcu_dereference_protected(rt->fib6_next,
-					    lockdep_is_held(&table->tb6_lock));
-			if (!w->leaf)
-				w->state = FWS_U;
-		}
-	}
-	read_unlock(&net->ipv6.fib6_walker_lock);
+	fib6_walkers_skip_rt(net, rt);
 
 	/* If it was last route, call fib6_repair_tree() to:
 	 * 1. For root node, put back null_entry as how the table was created.
-- 
2.55.0

