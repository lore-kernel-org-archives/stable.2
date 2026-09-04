Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D144C678
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515136; cv=none; b=oDpYyGYUgH/kSFd2wcCBemjZVTxBUTQ5VIoCGMUM007r7hmRjsyNrKxqh9RMeOeXldk4bIrqDzHflEN2dAz4X7LKoiUPWCQguKhta1sBrr8LluoKJpXEJ4UGQB57sgiNTWB6SDNcZxMQcFHKF9QoFh/wtdPb1FEFzliHrDVqokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515136; c=relaxed/simple;
	bh=aUSwu1DmtRd0wj6OCAc8y7wU8/GpZEZbY2/8qVUQYuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubDthqV1tfWBcr3cOK7FHRSJz9sQNzVfp6NupLYpPlzd1Q5RS+afyxcGFx60TeIFKlVhcsJ5uCUiLRQh2fWdPfNjcy9RMK1z20pDzxfVocIXAXABw5unCpP8WfIhKKhjq+iXeJ49vAL/hKg9tgaxJPKJw4jShxVWAuzK/g9MS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso6966865e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515133; x=1789119933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F2Mxqz9GXFznd4UXm97kdqHvlOQlaPZBm28tXLL2Xjk=;
        b=FO1TfC8XfUR3nBeA0SGxMczbuYTAeE2c88qq+tGFXRYogefek3dKRImjG2GSIAbOaW
         lvkDIx1IH1Zwc/eDK1sRgJs+/KVE6UUCmVIqijWDkWUVi5RG79U5r3jG1DGMs6oy7iqY
         /jRVwQ7Rha7J8LXy8IXwRGV0b5B4vjOTU7Ya3w6VA4krWEt8+1lgb2OLs6F+2Nf7mDUz
         TUTrph3/qcGFsnSN8cSrWGDsUoGGa/xdY8jKcyB4GdslGpsadH3dBymlA8s5RFt4GUrM
         2M6F76Ft0XA6uVp/Z46bJTTrNBQQpRvR7bNsblXVqLWIxSv8gdS+grm0uH3+NLxVX9ih
         J+9Q==
X-Gm-Message-State: AFuF++mkfe+gcCLc+RZ7jT6RIxls6pi2dE/2QDCyEPvkbeCkMNGP+ITj
	6+m4bIl3JmgmPTVcUnWysz/VpmKuFwePaJwrlML40SqjOHE0gSdPw5uK7gN9bdjg
X-Gm-Gg: AYBFou2RR7UDw7JtXThhVUCAmtUJGBcZYSQ38+e3TdClRzCnNUWH82VKAa3LGy3XOkk
	s7tmXfXq9TSA8kO5WgqhWHuN6EwI0vjA3wUQEl9E74jKIFqWfUeFpqIloMBHq7xJs7sM2RyAHqq
	8IVdw2BQALvE0bOU5DZVh19fDZQhP3oflCT35EYbFMDnf66iIkpkqg9pBkML5/YdLef73R/SejE
	DqX0PXG4mGTNmFGYBbWTV+cYxfjrvBvMSCY9EnQkp+8xvrc27hNPJjYhUZGcpjMMWuF+nJNaypH
	v/QPs+0uyJAi4sTpL8gFbH6nIf4syIdgTF0+sVKCHBoRdhnQxSgFIB7k+U9vHNKQFGF6I9pkniS
	px+jmaTfhJAMPGPqJykR9XoYEB6qnqkUDFXBDSBhN0ALpbzR2xLMmVcx/9jKq0j1/x4AW8pGCIX
	xrkHh1+vpNbV0ZbWFcfdkkhDJ+TJ3k7HJONBY5XuEpyfRxQ5ejyQ0sTXxF/KAmPnNFEOJuOVNk5
	M2IX8jwevHaVT2p68s=
X-Received: by 2002:a05:600d:849b:10b0:49c:f13d:ffe6 with SMTP id 5b1f17b1804b1-49cf13e05d9mr78751975e9.10.1788515132434;
        Fri, 04 Sep 2026 02:45:32 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588133600sm5632238f8f.5.2026.09.04.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:45:32 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Yuqi Xu <xuyuqiabc@gmail.com>,
	Vega <vega@nebusec.ai>,
	Nan Li <tonanli66@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 2/2] openvswitch: Fix CT limit teardown use-after-free
Date: Fri,  4 Sep 2026 11:45:15 +0200
Message-ID: <20260904094519.1817105-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904094519.1817105-1-i.maximets@ovn.org>
References: <2026090351-refill-bondless-262d@gregkh>
 <20260904094519.1817105-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuqi Xu <xuyuqiabc@gmail.com>

[ Upstream commit 403f96c32c9e24600093d7d0c61c17daeedca957 ]

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
[ 7.0+ uses kmalloc_obj[s] while older versions use kmalloc[_array]
  6.12+ doesn't have a 'family' argument in nf_conncount_init/destroy ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/conntrack.c | 122 +++++++++++++++++++++++-------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |  10 ++-
 net/openvswitch/datapath.h  |   8 ++-
 4 files changed, 98 insertions(+), 48 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 747ba60afe0a7..7c1fdcd241b25 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1177,10 +1177,14 @@ static int ovs_ct_check_limit(struct net *net,
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
@@ -1885,43 +1889,56 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 static int ovs_ct_limit_init(struct net *net, struct ovs_net *ovs_net)
 {
+	struct ovs_ct_limit_info *info;
 	int i, err;
 
-	ovs_net->ct_limit_info = kmalloc(sizeof(*ovs_net->ct_limit_info),
-					 GFP_KERNEL);
-	if (!ovs_net->ct_limit_info)
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
 		return -ENOMEM;
 
-	ovs_net->ct_limit_info->default_limit = OVS_CT_LIMIT_DEFAULT;
-	ovs_net->ct_limit_info->limits =
+	info->default_limit = OVS_CT_LIMIT_DEFAULT;
+	info->limits =
 		kmalloc_array(CT_LIMIT_HASH_BUCKETS, sizeof(struct hlist_head),
 			      GFP_KERNEL);
-	if (!ovs_net->ct_limit_info->limits) {
-		kfree(ovs_net->ct_limit_info);
+	if (!info->limits) {
+		kfree(info);
 		return -ENOMEM;
 	}
 
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; i++)
-		INIT_HLIST_HEAD(&ovs_net->ct_limit_info->limits[i]);
+		INIT_HLIST_HEAD(&info->limits[i]);
 
-	ovs_net->ct_limit_info->data =
-		nf_conncount_init(net, NFPROTO_INET, sizeof(u32));
+	info->data = nf_conncount_init(net, NFPROTO_INET, sizeof(u32));
 
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
+{
+	return rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
+				   lockdep_ovsl_is_held());
+}
+
+/* The CT limit state must be detached by ovs_ct_limit_exit_start() and an
+ * RCU grace period must elapse before this function runs.  The pernet core
+ * guarantees the grace period between the .pre_exit and .exit callbacks.
+ */
+static void ovs_ct_limit_exit_finish(struct net *net, void *data)
 {
-	const struct ovs_ct_limit_info *info = ovs_net->ct_limit_info;
+	const struct ovs_ct_limit_info *info = data;
 	int i;
 
+	if (!info)
+		return;
+
 	nf_conncount_destroy(net, NFPROTO_INET, info->data);
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
@@ -1929,7 +1946,7 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 		struct hlist_node *next;
 
 		hlist_for_each_entry_safe(ct_limit, next, head, hlist_node)
-			kfree_rcu(ct_limit, rcu);
+			kfree(ct_limit);
 	}
 	kfree(info->limits);
 	kfree(info);
@@ -1968,12 +1985,13 @@ static bool check_zone_id(int zone_id, u16 *pzone)
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
@@ -1982,6 +2000,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = zone_limit->limit;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1998,6 +2017,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->limit = zone_limit->limit;
 
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_set(info, ct_limit);
 			ovs_unlock();
 		}
@@ -2012,12 +2032,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
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
@@ -2026,6 +2047,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = OVS_CT_LIMIT_DEFAULT;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -2033,6 +2055,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_del(info, zone);
 			ovs_unlock();
 		}
@@ -2076,6 +2099,7 @@ static int __ovs_ct_limit_get_zone_limit(struct net *net,
 	return nla_put_nohdr(reply, sizeof(zone_limit), &zone_limit);
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_zone_limit(struct net *net,
 				       struct nlattr *nla_zone_limit,
 				       struct ovs_ct_limit_info *info,
@@ -2099,12 +2123,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
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
@@ -2119,6 +2141,7 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 	return 0;
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 					   struct ovs_ct_limit_info *info,
 					   struct sk_buff *reply)
@@ -2131,19 +2154,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,
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
 
@@ -2153,7 +2173,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -2166,8 +2185,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_set_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -2187,7 +2206,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -2200,8 +2218,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_del_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -2221,7 +2239,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -2235,18 +2253,19 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
@@ -2316,12 +2335,29 @@ int ovs_ct_init(struct net *net)
 #endif
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
index 317e525c8a113..ab21d032fde3d 100644
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
index cef3cefae9b45..0df483e4d1902 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2677,6 +2677,13 @@ static void __net_exit list_vports_from_net(struct net *net, struct net *dnet,
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
@@ -2687,7 +2694,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 	ovs_lock();
 
-	ovs_ct_exit(dnet);
+	ovs_ct_exit_finish(dnet);
 
 	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
 		__dp_destroy(dp);
@@ -2711,6 +2718,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 static struct pernet_operations ovs_net_ops = {
 	.init = ovs_init_net,
+	.pre_exit = ovs_pre_exit_net,
 	.exit = ovs_exit_net,
 	.id   = &ovs_net_id,
 	.size = sizeof(struct ovs_net),
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index cdbe281cf4c81..d20b33aed11eb 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -157,7 +157,10 @@ struct dp_upcall_info {
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
@@ -165,7 +168,8 @@ struct ovs_net {
 	struct work_struct dp_notify_work;
 	struct delayed_work masks_rebalance;
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	struct ovs_ct_limit_info *ct_limit_info;
+	struct ovs_ct_limit_info __rcu *ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_exit_data;
 #endif
 	bool xt_label;
 };
-- 
2.55.0

