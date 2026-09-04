Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93074446BE2
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514896; cv=none; b=jIUzRF6vx3d7IjuzOFE0c+zDILKqWjbVrwh6wzk4S03zZRRReGf4tKIYa61M9JHncP1EZPshWKtdmGAexWiw3KszP1aT4AGtmVNFSxdjicL7hm/Tx0D9Qq9uGzt/sJIam2oMOaLLxOpSe2akB3GDFN4g6q/Bfq6pgSgt+6G73Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514896; c=relaxed/simple;
	bh=G2U/51g4RnQeJGZ0YAWB2ULjoEYAuuyjFJ3iMatY19k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpmHNY27osS2p4F3jcVm3UcuhS/vNVKd0LxMeA/nSdi3FartllhLbfCwCGXoJ/6FIs1qTbAwfbJve7+AmJKWXT5PWKdhOQ4/CIkwq81xctguUWWumzzsScDDzmy+t9OR/79ZBQVqBqBmJI6jSr47Z7vMmMVS35e8ayfgrV70+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so237537f8f.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514892; x=1789119692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv9vHDWKkO/hfyexG0BPxA1wt4nbdB8Wac4Gwh6c7h4=;
        b=Y6VQLWMfgWaz+9XbyHqCTjGaZ6EKedZ6dL4K9ECQ1RbreoMq/knY8YAarDXWL6VX6D
         L/dqxOGSLSiGhl08oCjZRbJU7FNZPDLjDX5qEVsks/zMY8+QkYd5YnVziXq447Aj1f2+
         LTdK/L4138zq00dUjJzKy4qGTx8OXBzTnsyelFydq+95jn8qUsvRWXOGztJ5pXpDpc6b
         8jLuNOxZ/eZb68cSXfDgiBabt9/Jr6fmYQPeAZikIxXEEoYl4ELOjer+BCJ5nIZGrLLr
         wozjjT5gfiBBGuVZ4f1V0J664//NXhwWosrISUY9VgXErAnYYVqgxCyISmAJHZDNAKQA
         hkvA==
X-Gm-Message-State: AFuF++kHsxzhOHQEhu+E/JY6BAys61D1EEAFXHMVxL+8gsPxNc/6jELF
	N+V3eFiN6HocxI4ttdZuFx5DQ+zJKHiO/ji0BMV+0dn3q/JwXP2bPyvcjyYm71iB
X-Gm-Gg: AYBFou08Lfy5Pru+uMiJmlWfTURFIbRrbaKm0Aw8talrch+MCG2KfuFHDx78vvpqshi
	7UYmar16Vw5C8l4wNt+OmIOQAtBt33Zo47PHUh6uanHkoB8YSAgyjMMU5bodXSRYNa+B906dxnv
	w1z0zK+CXkvPwwwzw9Sdifrm1WZxN0lIHAcZ/w7i7D97zEZ2gXNGtaaLfDnWoYKwPmm5CDOOqYY
	GpYaKL8707xidv4AiFkxCpbGdtfmWK12S0B83Fe90R8Y2OpfBpTItaDpID/6qo0DQQEaWKwtv3Z
	i0wHaEU8vcquF1Qzf79qYIIAJPiOeXoXBpyQEKs29KAY+PyG9mbW6NgI0bqZDZd8kdrNKdA7hsa
	rS1k7KIjVb7Pja66F4Ho5+UdLZRIpnFWnedB5v5qPVTOiLJgvx26qVGjHDz/lKi04q+7kMkHgzQ
	VXNrSmPl2JQqBdhgFfSxTNTXc2LoTte1b6g67n3aq1iMH2OcHdLdoSDgog2VJTtATWEM+hwbyl+
	svRglTtyB20Pp7030c=
X-Received: by 2002:a5d:5f51:0:b0:485:8a47:5b9c with SMTP id ffacd0b85a97d-4858a475d7dmr2874472f8f.57.1788514892464;
        Fri, 04 Sep 2026 02:41:32 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm5178576f8f.27.2026.09.04.02.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:41:32 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: openvswitch: fix kernel-doc warnings in internal headers
Date: Fri,  4 Sep 2026 11:41:02 +0200
Message-ID: <20260904094111.1816002-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904094111.1816002-1-i.maximets@ovn.org>
References: <2026090350-galvanize-epidermal-77ae@gregkh>
 <20260904094111.1816002-1-i.maximets@ovn.org>
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
[ struct vport_upcall_stats_percpu doesn't exist in 6.2 and earlier ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.h | 20 ++++++++++++++------
 net/openvswitch/vport.h    |  8 ++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 88156a677f22c..92dea32da88bd 100644
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
@@ -74,8 +75,10 @@ struct dp_nlsk_pids {
  * ovs_mutex and RCU.
  * @stats_percpu: Per-CPU datapath statistics.
  * @net: Reference to net namespace.
- * @max_headroom: the maximum headroom of all vports in this datapath; it will
+ * @user_features: Bitmap of enabled %OVS_DP_F_* features.
+ * @max_headroom: The maximum headroom of all vports in this datapath; it will
  * be used by all the internal vports in this dp.
+ * @meter_tbl: Meter table.
  * @upcall_portids: RCU protected 'struct dp_nlsk_pids'.
  *
  * Context: See the comment on locking at the top of datapath.c for additional
@@ -125,10 +128,13 @@ struct ovs_skb_cb {
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
@@ -149,6 +155,10 @@ struct dp_upcall_info {
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
@@ -157,8 +167,6 @@ struct ovs_net {
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_ct_limit_info *ct_limit_info;
 #endif
-
-	/* Module reference for configuring conntrack. */
 	bool xt_label;
 };
 
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 6ff45e8a0868d..ecde971e77b42 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -93,6 +93,8 @@ struct vport {
  * @desired_ifindex: New vport's ifindex.
  * @dp: New vport's datapath.
  * @port_no: New vport's port number.
+ * @upcall_portids: %OVS_VPORT_ATTR_UPCALL_PID attribute from Netlink message,
+ * %NULL if none was supplied.
  */
 struct vport_parms {
 	const char *name;
@@ -121,6 +123,8 @@ struct vport_parms {
  * have any configuration.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
+ * @owner: Module that implements this vport type.
+ * @list: List entry in the global list of vport types.
  */
 struct vport_ops {
 	enum ovs_vport_type type;
@@ -148,6 +152,8 @@ void ovs_vport_free(struct vport *);
  *
  * @vport: vport to access
  *
+ * Returns: A void pointer to a private data allocated in the @vport.
+ *
  * If a nonzero size was passed in priv_size of vport_alloc() a private data
  * area was allocated on creation.  This allows that area to be accessed and
  * used for any purpose needed by the vport implementer.
@@ -162,6 +168,8 @@ static inline void *vport_priv(const struct vport *vport)
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

