Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203236;
	b=epU73K8EbD1IJy0Qh9+c5zp/ctpjMXi/aGp2cXreaTOoZ7bf3bbwZDd+EzMUByn2+tqZ
	 qaZ8WCeSyle5nDNpxLGN7Gs3rf1ahwgOGRITsIO36/yzML9THQT/jbVUFbwlps0YWNBZL
	 mpxwITd8HLp4Zl0I45OFdk4YVoWMJboaPzysjkXYzXi6katQEumtIbDxCfk0yjswcJrEU
	 0PLVvGflwWj/+dnksPC5gByVb9GHwDA//p5MkBt+IpqSUO9Kedn46saJ3QJpXZfFMNYPe
	 E5qohq2L+mrzq26FSS9ouAzXUONTnWkElF+CdtFqvn9rHpEtN/+3zYHmVUQvs9wz/6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203236;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=XUKvphWQG3E2qdszTkFnGrfYWkO3RlEByqvAlwrX+5U=;
	b=SUIwLb3SW4hWYJJdmBJrvUtTMgGl6U+PrvAP+DQND3XUgiMIiNQBvdGjHj8EaKVrPykt
	 Sntw8+Sg+yh1kZp3QJFjNzZxjqsIXqi5w8hQQpL78pXF9IderPPUmHnVBm723BxMh1gke
	 VFKpLV3B/gSyzrAqntXdOlir5XCVpGWN7PJ8QugE5U1S+/6NV9OvF2zwY+Qo1XkaeFHv7
	 4YGh2iJIXBff2al0nogMsKEaQqIuVC6kxCFe8eUfK43obIFYQwin7h3Jh5JEpr42tQcqY
	 bn/tiMwiHicEoNzXV6O5VHQUE/itzzoieGMPe35mSaf+PqL7bEUVKhMXS0vk7M1pT1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gx7IDeO9;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4539606A31A;
	Wed, 28 Oct 2026 16:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4539606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gx7IDeO9
Received: from mac.lan (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DF3720B7166;
	Wed, 28 Oct 2026 09:00:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DF3720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793203223;
	bh=XUKvphWQG3E2qdszTkFnGrfYWkO3RlEByqvAlwrX+5U=;
	h=From:To:Cc:Subject:Date:From;
	b=gx7IDeO9SdDKYub235c63rtmXNUTN98Q6EzkvyvKIch7Jzhb8utVIsE9vb9z0YU6T
	 3ofjCiV/WIsU7rD7WHy0nbY3DcbEqR3FF3TX3zjsYJ0a0keWTuAvVjd+xekF1bCcN4
	 c1rk22SC8hMHhZGBZtRihT8i/OCnPh8sXac4ZNvE=
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
Subject: [PATCH net v2] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
Date: Wed, 28 Oct 2026 12:00:18 -0400
Message-ID: <20261028160018.73299-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
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

fib6_walker uses w->leaf to remember the next fib6_info to dump, so an
RTM_GETROUTE dump can continue there on the next recvmsg().  This
assumes that whoever removes a route from the tree also updates the
walkers pointing at it.  fib6_del_route() does: it moves w->leaf to
the next route.  The NLM_F_REPLACE branch of fib6_add_rt2node() does
not: it removes the old route, fib6_add() frees it, and w->leaf keeps
pointing at the freed object.

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

Fix by adjusting walkers separately for replacement and deletion.
For replacement, add fib6_walkers_replace_leaf() points w->leaf
at the new route. For deletion and ECMP sibling removal,
fib6_walkers_skip_rt() calls fib6_walkers_replace_leaf() with the
next route. Reset w->skip_in_node when updating w->leaf, and set
w->state to FWS_U when no next route remains.

Fixes: 4a287eba2de3 ("IPv6 routing, NLM_F_* flag support: REPLACE and EXCL flags support, warn about missing CREATE flag")
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
Developed with LLM assistance.

v2:
 - Move replacement walkers to the new route instead of skipping it
   (Sashiko).
 - Add fib6_walkers_replace_leaf() for the shared adjustment; make
   fib6_walkers_skip_rt() a deletion wrapper around it.
 - Reset w->skip_in_node when updating w->leaf (Sashiko).
 - Rebase on net.
v1: https://lore.kernel.org/netdev/20261009225142.47005-1-cenzhang@linux.microsoft.com/

 net/ipv6/ip6_fib.c | 50 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 0dc6ebee6e56..fb19670521c6 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -89,6 +89,40 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
 	write_unlock_bh(&net->ipv6.fib6_walker_lock);
 }
 
+/* @old is leaving the tree.  Walkers resting on it continue from @new, or
+ * climb to the parent node when there is no @new.  Called with tb6_lock
+ * held.
+ */
+static void fib6_walkers_replace_leaf(struct net *net, struct fib6_info *old,
+				      struct fib6_info *new)
+{
+	struct fib6_walker *w;
+
+	read_lock(&net->ipv6.fib6_walker_lock);
+	FOR_WALKERS(net, w) {
+		if (w->state == FWS_C && w->leaf == old) {
+			pr_debug("walker %p adjusted by unlink of %p\n", w, old);
+			w->leaf = new;
+			w->skip_in_node = 0;
+			if (!new)
+				w->state = FWS_U;
+		}
+	}
+	read_unlock(&net->ipv6.fib6_walker_lock);
+}
+
+/* @rt is removed from its node: walkers resting on it continue from the
+ * next route of the node.
+ */
+static void fib6_walkers_skip_rt(struct net *net, struct fib6_info *rt)
+{
+	struct fib6_info *next;
+
+	next = rcu_dereference_protected(rt->fib6_next,
+					 lockdep_is_held(&rt->fib6_table->tb6_lock));
+	fib6_walkers_replace_leaf(net, rt, next);
+}
+
 static int fib6_new_sernum(struct net *net)
 {
 	int new, old = atomic_read(&net->ipv6.fib6_sernum);
@@ -1316,6 +1350,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		rcu_assign_pointer(rt->fib6_node, fn);
 		rt->fib6_next = iter->fib6_next;
 		rcu_assign_pointer(*ins, rt);
+		fib6_walkers_replace_leaf(info->nl_net, iter, rt);
 		if (!info->skip_notify)
 			inet6_rt_notify(RTM_NEWROUTE, rt, info, NLM_F_REPLACE);
 		if (!(fn->fn_flags & RTN_RTINFO)) {
@@ -1337,6 +1372,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (iter->fib6_metric > rt->fib6_metric)
 					break;
 				if (rt6_qualify_for_ecmp(iter)) {
+					fib6_walkers_skip_rt(info->nl_net, iter);
 					*ins = iter->fib6_next;
 					iter->fib6_node = NULL;
 					list_add(&iter->purge_link, purge_list);
@@ -1971,7 +2007,6 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			   enum rt_del_reason del_reason)
 {
 	struct fib6_info *leaf, *replace_rt = NULL;
-	struct fib6_walker *w;
 	struct fib6_info *rt = rcu_dereference_protected(*rtp,
 				    lockdep_is_held(&table->tb6_lock));
 	struct net *net = info->nl_net;
@@ -2022,18 +2057,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
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

