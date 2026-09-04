Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296F399CFC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515322; cv=none; b=s735PaNygUiHe7gle+QO+NyDvHASQ+BwGzxudW90Y4svM3IriMnDxvE30H5JPIs+MAYfs/F+XHce1Kpg6ZZwQmC3mzHfkzHRO2posozoAQ2ISlSLPudFc17dVBUXl2KMkWrfl2F3ywKPIOZ49VyzWI41pxbgRWG/jrvZgPV2ipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515322; c=relaxed/simple;
	bh=HcugBEo3FppEaM0eLvdUWVjGaN1L+biPm8je5RZWfu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huZ1Bg9ce9SCLDLu3vZfGHdjZHy2xd6htCywA1nx6T18NWL33ez6yUhIOr70Ue/xOn7Se4nkjfCVwwlr1RK6ImncuZwtEqWa5UfILfwvSm9tLgOKMPOwmrK6jM729a7BICZaVB9JcPwl9k6CXoYL55GkA3HomQzsPqwqxdiwEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso3502935e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515318; x=1789120118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoXs7Q8L0fZywSBVWtqPProcsfCDAvHAS6HCcTCiAYs=;
        b=jIA++158iCI3UdhehF7z2nXrg1w61jLbK0RPG7ZHGCUMAQ1UbWBlspoj4SwjwHkYpW
         NO4MWiyj81XGlN9AClDNjDa3iKGeeVMxgOWm4bPhpVr6CH9SZkp8BKnU4xpUTT5V/YQd
         89Ht7dmNh5iv5bVc+f5u8F2RpATNYrP7Lq/DUvLe/Xmss4+ZkDTiIiksA4C3k1LtOhce
         ORfR6+mUpjok3kvyLh8IclVg5thWyssC3IOQcB2Y7UANZuDcc41A5D9CjARMqT5mHLpH
         OZUF0pKuUUvtwqnIWjCBziu0wkuH/BESNgSv/8wQ5Lv54AsPh6uKmUtmom5V8tBt4mSB
         wLhg==
X-Gm-Message-State: AFuF++kJSBMebldiOcy+14x/lb3j3RK8H/qiEhejRnyWIuwGOD9x02aM
	SFVMj2rWhhm0RQTmo+eU6RqRDBdHpuoIzifkoo+qjrXiV0swwpJjfccbOefmS2gi
X-Gm-Gg: AYBFou2Yq655kPXyRSDnp5L4kkbWae57aS3WGDN+iMWcYMxPVOXy6pIhL8/q9uKHufp
	hECjyQbD6tUnVPG2H6z5IsfX2w0/7TY29+nb+QU7MNxbfnTwQA4AS+qbW81CmPG7/E9nhM0XWy0
	tGOR3WnuydCVWlBbLKOc2fED7GdKvxNYPZEf8kAkdNPb8tXVe9yRskkLWItbpsHGW2+C70bVrua
	QhCWtKuHgTEczpm+0GsWCkC3gIO+HmaVWePsJ5wQycLxKPEpwaq3R8K+SZqKSFHR07yu4O6fUc5
	Hl+zxC4KLkQ3ncG987PAoIXBfd05YXCYazB21Dr/8t8sJG/i0CERtxx20fz/vs6LIpDjAj0BAGU
	g3ahEH/GMSrQutvzxirS3eMCpuIOTue+WQjT/2Wh70sdHs1Rzu2OgHOyKSyGnpiq/MLaC6MrHbi
	wfwO+e4C4mr7rC6NYb91h46L8shX3+lTRBnOkIQUyozAIEStJYzaTbQZE1rzq7uXTA9qO9Ux+7v
	1T/4eIAF4+q4z8bRsY=
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49cf82a514cmr56255765e9.16.1788515318030;
        Fri, 04 Sep 2026 02:48:38 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm145501045e9.6.2026.09.04.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:48:37 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: openvswitch: fix kernel-doc warnings in internal headers
Date: Fri,  4 Sep 2026 11:48:17 +0200
Message-ID: <20260904094826.1817930-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904094826.1817930-1-i.maximets@ovn.org>
References: <2026090351-garnish-ferocious-2169@gregkh>
 <20260904094826.1817930-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 6bb0dcb3d321c14be7ca33b71a149034d6a2cde8 ]

Some field descriptions were missing, some were not very accurate.
Not touching the uAPI header or .c files for now.

Formatting of those comments isn't great in general, but at least
they are not missing anything now.

Before:
  $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
  16

After:
  $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
  0

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20250320224431.252489-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ struct vport_upcall_stats_percpu doesn't exist in 6.2 and earlier
  struct datapath doesn't have @upcall_portids in 5.14 and earlier ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.h | 20 ++++++++++++++------
 net/openvswitch/vport.h    |  8 ++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 62e7ad32f8376..26f310f807083 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -29,8 +29,8 @@
  * datapath.
  * @n_hit: Number of received packets for which a matching flow was found in
  * the flow table.
- * @n_miss: Number of received packets that had no matching flow in the flow
- * table.  The sum of @n_hit and @n_miss is the number of packets that have
+ * @n_missed: Number of received packets that had no matching flow in the flow
+ * table.  The sum of @n_hit and @n_missed is the number of packets that have
  * been received by the datapath.
  * @n_lost: Number of received packets that had no matching flow in the flow
  * table that could not be sent to userspace (normally due to an overflow in
@@ -40,6 +40,7 @@
  *   up per packet.
  * @n_cache_hit: The number of received packets that had their mask found using
  * the mask cache.
+ * @syncp: Synchronization point for 64bit counters.
  */
 struct dp_stats_percpu {
 	u64 n_hit;
@@ -59,8 +60,10 @@ struct dp_stats_percpu {
  * ovs_mutex and RCU.
  * @stats_percpu: Per-CPU datapath statistics.
  * @net: Reference to net namespace.
- * @max_headroom: the maximum headroom of all vports in this datapath; it will
+ * @user_features: Bitmap of enabled %OVS_DP_F_* features.
+ * @max_headroom: The maximum headroom of all vports in this datapath; it will
  * be used by all the internal vports in this dp.
+ * @meter_tbl: Meter table.
  *
  * Context: See the comment on locking at the top of datapath.c for additional
  * locking information.
@@ -107,10 +110,13 @@ struct ovs_skb_cb {
 #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
 
 /**
- * struct dp_upcall - metadata to include with a packet to send to userspace
+ * struct dp_upcall_info - metadata to include with a packet sent to userspace
  * @cmd: One of %OVS_PACKET_CMD_*.
  * @userdata: If nonnull, its variable-length value is passed to userspace as
  * %OVS_PACKET_ATTR_USERDATA.
+ * @actions: If nonnull, its variable-length value is passed to userspace as
+ * %OVS_PACKET_ATTR_ACTIONS.
+ * @actions_len: The length of the @actions.
  * @portid: Netlink portid to which packet should be sent.  If @portid is 0
  * then no packet is sent and the packet is accounted in the datapath's @n_lost
  * counter.
@@ -131,6 +137,10 @@ struct dp_upcall_info {
  * struct ovs_net - Per net-namespace data for ovs.
  * @dps: List of datapaths to enable dumping them all out.
  * Protected by genl_mutex.
+ * @dp_notify_work: A work notifier to handle port unregistering.
+ * @masks_rebalance: A work to periodically optimize flow table caches.
+ * @ct_limit_info: A hash table of conntrack zone connection limits.
+ * @xt_label: Whether connlables are configured for the network or not.
  */
 struct ovs_net {
 	struct list_head dps;
@@ -139,8 +149,6 @@ struct ovs_net {
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_ct_limit_info *ct_limit_info;
 #endif
-
-	/* Module reference for configuring conntrack. */
 	bool xt_label;
 };
 
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 1eb7495ac5b45..6e5909ce049db 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -90,6 +90,8 @@ struct vport {
  * none was supplied.
  * @dp: New vport's datapath.
  * @port_no: New vport's port number.
+ * @upcall_portids: %OVS_VPORT_ATTR_UPCALL_PID attribute from Netlink message,
+ * %NULL if none was supplied.
  */
 struct vport_parms {
 	const char *name;
@@ -117,6 +119,8 @@ struct vport_parms {
  * have any configuration.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
+ * @owner: Module that implements this vport type.
+ * @list: List entry in the global list of vport types.
  */
 struct vport_ops {
 	enum ovs_vport_type type;
@@ -144,6 +148,8 @@ void ovs_vport_free(struct vport *);
  *
  * @vport: vport to access
  *
+ * Returns: A void pointer to a private data allocated in the @vport.
+ *
  * If a nonzero size was passed in priv_size of vport_alloc() a private data
  * area was allocated on creation.  This allows that area to be accessed and
  * used for any purpose needed by the vport implementer.
@@ -158,6 +164,8 @@ static inline void *vport_priv(const struct vport *vport)
  *
  * @priv: Start of private data area.
  *
+ * Returns: A reference to a vport structure that contains @priv.
+ *
  * It is sometimes useful to translate from a pointer to the private data
  * area to the vport, such as in the case where the private data pointer is
  * the result of a hash table lookup.  @priv must point to the start of the
-- 
2.55.0

