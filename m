Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753F29DB8F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447328; cv=none; b=i4z36DtZrjzMrf4Lm7RdGw8zUzAdlFq6akEIBWOsX6DmHq9IghismB2RJqblErZ+EJvbmS81xWvSolbsq8jr4E2a5nsrc11TaWC0uEEyVw0EgrjCgtkl06b6IGRQF6rnL3Da4LUAZIyGUNIguph/vF2KNKEO9wjRxfMuChUhnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447328; c=relaxed/simple;
	bh=udX9kiSfmnJQB/DwJ3LbXJnOr9aVU1tP1ExKV6ia9hU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cr0psfLMPJc+UTFqYBtqK2VJPJQgs50SORBFLN8mHSYyUUNCenHZx7MxrlHR0e2XxkiduB3s9mwWeK48SBCvneBlnH6ijdMH4EsMhRBvilSloSovkPp3oCicwFsK/yLB17t2tqVGxcPjy8ir8MzBqIt8LokuzQOpeTVR8Y7ZAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNvh3E4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNvh3E4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC011F000E9;
	Thu,  3 Sep 2026 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447326;
	bh=h3r08NknPUNzOZq7mZchTJlE6fNSmCM23k9gtKXd7Yc=;
	h=Subject:To:Cc:From:Date;
	b=VNvh3E4U6vPJycnVLmyZDIsGly6Afslwq3TTcv7znFL8xyzZQw7PgMrRy1dB8uRDe
	 qFT4iJu2Sx73MIwsYj8fSWJZFOHPcV/RWTBsQ6Hbd1mgyvVv8HdCCNjPP8F1okZaBP
	 73y3BSjNTnwA9WeI+zQP3iopZuWi19lmIfZPS1M0=
Subject: FAILED: patch "[PATCH] openvswitch: Fix CT limit teardown use-after-free" failed to apply to 6.12-stable tree
To: xuyuqiabc@gmail.com,enjou1224z@gmail.com,i.maximets@ovn.org,kuba@kernel.org,tonanli66@gmail.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:30:49 +0200
Message-ID: <2026090349-submitter-decorated-2272@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 403f96c32c9e24600093d7d0c61c17daeedca957
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090349-submitter-decorated-2272@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 403f96c32c9e24600093d7d0c61c17daeedca957 Mon Sep 17 00:00:00 2001
From: Yuqi Xu <xuyuqiabc@gmail.com>
Date: Fri, 21 Aug 2026 11:19:38 +0800
Subject: [PATCH] openvswitch: Fix CT limit teardown use-after-free

Packet processing uses CT limit state under RCU, while netns teardown
frees that state under ovs_mutex. The CT limit pointer was neither removed
from readers nor protected by a grace period, allowing packet processing to
dereference the freed state.

An unprivileged user can trigger this bug from a user and network
namespace, causing a slab-use-after-free in ovs_ct_execute() when the
netns is torn down.

Publish the CT limit pointer through RCU, remove it before teardown, and
wait for readers before freeing its contents. Keep ovs_mutex around
individual CT limit updates, and use the RCU read-side lock while GET
traverses the RCU-protected limit lists.

Netns teardown detaches the RCU-protected CT limit state in the pernet
.pre_exit callback while holding ovs_mutex.  The pernet core guarantees an
RCU grace period between the .pre_exit and .exit callbacks, so the .exit
callback completes the teardown without adding any extra synchronization.

The netlink command handlers do not need NULL checks because the userspace
netlink socket holds an active reference to its network namespace while a
request is processed. The per-netns exit path therefore cannot run
concurrently with SET, DEL, or GET for that socket's namespace.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
Co-developed-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Link: https://patch.msgid.link/288fbd5459d92b9dd0dcc6faf625f04819161ff3.1787280296.git.xuyuqiabc@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 49eb2b0d234d..27115967e5d9 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -932,10 +932,14 @@ static int ovs_ct_check_limit(struct net *net,
 			      const struct ovs_conntrack_info *info)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	const struct ovs_ct_limit_info *ct_limit_info;
 	u32 per_zone_limit, connections;
 	u32 conncount_key;
 
+	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
+	if (!ct_limit_info)
+		return 0;
+
 	conncount_key = info->zone.id;
 
 	per_zone_limit = ct_limit_get(ct_limit_info, info->zone.id);
@@ -1579,40 +1583,55 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 static int ovs_ct_limit_init(struct net *net, struct ovs_net *ovs_net)
 {
+	struct ovs_ct_limit_info *info;
 	int i, err;
 
-	ovs_net->ct_limit_info = kmalloc_obj(*ovs_net->ct_limit_info);
-	if (!ovs_net->ct_limit_info)
+	info = kmalloc_obj(*info);
+	if (!info)
 		return -ENOMEM;
 
-	ovs_net->ct_limit_info->default_limit = OVS_CT_LIMIT_DEFAULT;
-	ovs_net->ct_limit_info->limits =
+	info->default_limit = OVS_CT_LIMIT_DEFAULT;
+	info->limits =
 		kmalloc_objs(struct hlist_head, CT_LIMIT_HASH_BUCKETS);
-	if (!ovs_net->ct_limit_info->limits) {
-		kfree(ovs_net->ct_limit_info);
+	if (!info->limits) {
+		kfree(info);
 		return -ENOMEM;
 	}
 
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; i++)
-		INIT_HLIST_HEAD(&ovs_net->ct_limit_info->limits[i]);
+		INIT_HLIST_HEAD(&info->limits[i]);
 
-	ovs_net->ct_limit_info->data = nf_conncount_init(net, sizeof(u32));
+	info->data = nf_conncount_init(net, sizeof(u32));
 
-	if (IS_ERR(ovs_net->ct_limit_info->data)) {
-		err = PTR_ERR(ovs_net->ct_limit_info->data);
-		kfree(ovs_net->ct_limit_info->limits);
-		kfree(ovs_net->ct_limit_info);
+	if (IS_ERR(info->data)) {
+		err = PTR_ERR(info->data);
+		kfree(info->limits);
+		kfree(info);
 		pr_err("openvswitch: failed to init nf_conncount %d\n", err);
 		return err;
 	}
+	rcu_assign_pointer(ovs_net->ct_limit_info, info);
 	return 0;
 }
 
-static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
+static void *ovs_ct_limit_exit_start(struct ovs_net *ovs_net)
 {
-	const struct ovs_ct_limit_info *info = ovs_net->ct_limit_info;
+	return rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
+				   lockdep_ovsl_is_held());
+}
+
+/* The CT limit state must be detached by ovs_ct_limit_exit_start() and an
+ * RCU grace period must elapse before this function runs.  The pernet core
+ * guarantees the grace period between the .pre_exit and .exit callbacks.
+ */
+static void ovs_ct_limit_exit_finish(struct net *net, void *data)
+{
+	const struct ovs_ct_limit_info *info = data;
 	int i;
 
+	if (!info)
+		return;
+
 	nf_conncount_destroy(net, info->data);
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
@@ -1620,7 +1639,7 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 		struct hlist_node *next;
 
 		hlist_for_each_entry_safe(ct_limit, next, head, hlist_node)
-			kfree_rcu(ct_limit, rcu);
+			kfree(ct_limit);
 	}
 	kfree(info->limits);
 	kfree(info);
@@ -1659,12 +1678,13 @@ static bool check_zone_id(int zone_id, u16 *pzone)
 	return false;
 }
 
-static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
-				       struct ovs_ct_limit_info *info)
+static int ovs_ct_limit_set_zone_limit(struct ovs_net *ovs_net,
+				       struct nlattr *nla_zone_limit)
 {
 	struct ovs_zone_limit *zone_limit;
-	int rem;
+	struct ovs_ct_limit_info *info;
 	u16 zone;
+	int rem;
 
 	rem = NLA_ALIGN(nla_len(nla_zone_limit));
 	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
@@ -1673,6 +1693,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = zone_limit->limit;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1689,6 +1710,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->limit = zone_limit->limit;
 
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_set(info, ct_limit);
 			ovs_unlock();
 		}
@@ -1703,12 +1725,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 	return 0;
 }
 
-static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
-				       struct ovs_ct_limit_info *info)
+static int ovs_ct_limit_del_zone_limit(struct ovs_net *ovs_net,
+				       struct nlattr *nla_zone_limit)
 {
 	struct ovs_zone_limit *zone_limit;
-	int rem;
+	struct ovs_ct_limit_info *info;
 	u16 zone;
+	int rem;
 
 	rem = NLA_ALIGN(nla_len(nla_zone_limit));
 	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
@@ -1717,6 +1740,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = OVS_CT_LIMIT_DEFAULT;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1724,6 +1748,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_del(info, zone);
 			ovs_unlock();
 		}
@@ -1767,6 +1792,7 @@ static int __ovs_ct_limit_get_zone_limit(struct net *net,
 	return nla_put_nohdr(reply, sizeof(zone_limit), &zone_limit);
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_zone_limit(struct net *net,
 				       struct nlattr *nla_zone_limit,
 				       struct ovs_ct_limit_info *info,
@@ -1790,12 +1816,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 							&zone))) {
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
-			rcu_read_lock();
 			limit = ct_limit_get(info, zone);
 
 			err = __ovs_ct_limit_get_zone_limit(
 				net, info->data, zone, limit, reply);
-			rcu_read_unlock();
 			if (err)
 				return err;
 		}
@@ -1810,6 +1834,7 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 	return 0;
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 					   struct ovs_ct_limit_info *info,
 					   struct sk_buff *reply)
@@ -1822,19 +1847,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 	if (err)
 		return err;
 
-	rcu_read_lock();
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		head = &info->limits[i];
 		hlist_for_each_entry_rcu(ct_limit, head, hlist_node) {
 			err = __ovs_ct_limit_get_zone_limit(net, info->data,
 				ct_limit->zone, ct_limit->limit, reply);
 			if (err)
-				goto exit_err;
+				return err;
 		}
 	}
 
-exit_err:
-	rcu_read_unlock();
 	return err;
 }
 
@@ -1844,7 +1866,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -1857,8 +1878,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_set_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1878,7 +1899,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -1891,8 +1911,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_del_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1912,7 +1932,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -1926,18 +1946,19 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
+	rcu_read_lock();
+	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
 	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
 		err = ovs_ct_limit_get_zone_limit(
 			net, a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT], ct_limit_info,
 			reply);
-		if (err)
-			goto exit_err;
 	} else {
 		err = ovs_ct_limit_get_all_zone_limit(net, ct_limit_info,
 						      reply);
-		if (err)
-			goto exit_err;
 	}
+	rcu_read_unlock();
+	if (err)
+		goto exit_err;
 
 	nla_nest_end(reply, nla_reply);
 	genlmsg_end(reply, ovs_reply_header);
@@ -2012,12 +2033,29 @@ int ovs_ct_init(struct net *net)
 	return err;
 }
 
-void ovs_ct_exit(struct net *net)
+/* Must be called with ovs_mutex held.  Detaches the RCU-protected
+ * ct_limit_info and stores it in ovs_net->ct_limit_exit_data for
+ * ovs_ct_exit_finish() to complete the teardown after an RCU grace period.
+ */
+void ovs_ct_exit_start(struct net *net __maybe_unused)
+{
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
+	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
+
+	ovs_net->ct_limit_exit_data = ovs_ct_limit_exit_start(ovs_net);
+#endif
+}
+
+/* Completes the CT limit teardown.  The pernet core guarantees an RCU
+ * grace period between detaching the state in ovs_ct_exit_start() and
+ * this call, so no RCU readers remain.
+ */
+void ovs_ct_exit_finish(struct net *net)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	ovs_ct_limit_exit(net, ovs_net);
+	ovs_ct_limit_exit_finish(net, ovs_net->ct_limit_exit_data);
 #endif
 
 	if (ovs_net->xt_label)
diff --git a/net/openvswitch/conntrack.h b/net/openvswitch/conntrack.h
index 317e525c8a11..ab21d032fde3 100644
--- a/net/openvswitch/conntrack.h
+++ b/net/openvswitch/conntrack.h
@@ -14,7 +14,8 @@ enum ovs_key_attr;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 int ovs_ct_init(struct net *);
-void ovs_ct_exit(struct net *);
+void ovs_ct_exit_start(struct net *net);
+void ovs_ct_exit_finish(struct net *net);
 bool ovs_ct_verify(struct net *, enum ovs_key_attr attr);
 int ovs_ct_copy_action(struct net *, const struct nlattr *,
 		       const struct sw_flow_key *, struct sw_flow_actions **,
@@ -40,7 +41,8 @@ void ovs_ct_free_action(const struct nlattr *a);
 
 static inline int ovs_ct_init(struct net *net) { return 0; }
 
-static inline void ovs_ct_exit(struct net *net) { }
+static inline void ovs_ct_exit_start(struct net *net) { }
+static inline void ovs_ct_exit_finish(struct net *net) { }
 
 static inline bool ovs_ct_verify(struct net *net, int attr)
 {
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index f2d5b5ab38de..100a2ce4d74d 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2742,6 +2742,13 @@ static void __net_exit list_vports_from_net(struct net *net, struct net *dnet,
 	}
 }
 
+static void __net_exit ovs_pre_exit_net(struct net *dnet)
+{
+	ovs_lock();
+	ovs_ct_exit_start(dnet);
+	ovs_unlock();
+}
+
 static void __net_exit ovs_exit_net(struct net *dnet)
 {
 	struct datapath *dp, *dp_next;
@@ -2752,7 +2759,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 	ovs_lock();
 
-	ovs_ct_exit(dnet);
+	ovs_ct_exit_finish(dnet);
 
 	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
 		__dp_destroy(dp);
@@ -2776,6 +2783,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 static struct pernet_operations ovs_net_ops = {
 	.init = ovs_init_net,
+	.pre_exit = ovs_pre_exit_net,
 	.exit = ovs_exit_net,
 	.id   = &ovs_net_id,
 	.size = sizeof(struct ovs_net),
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 696640e88fa7..b2c2b8da12d4 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -164,7 +164,10 @@ struct dp_upcall_info {
  * Protected by genl_mutex.
  * @dp_notify_work: A work notifier to handle port unregistering.
  * @masks_rebalance: A work to periodically optimize flow table caches.
- * @ct_limit_info: A hash table of conntrack zone connection limits.
+ * @ct_limit_info: Hash table of conntrack zone connection limits. Protected
+ * by RCU; updates and teardown are serialized by ovs_mutex. May be NULL during
+ * netns teardown.
+ * @ct_limit_exit_data: CT limit state detached at .pre_exit, freed at .exit.
  * @xt_label: Whether connlables are configured for the network or not.
  */
 struct ovs_net {
@@ -172,7 +175,8 @@ struct ovs_net {
 	struct work_struct dp_notify_work;
 	struct delayed_work masks_rebalance;
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	struct ovs_ct_limit_info *ct_limit_info;
+	struct ovs_ct_limit_info __rcu *ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_exit_data;
 #endif
 	bool xt_label;
 };

