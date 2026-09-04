Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754B4343F2
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515134; cv=none; b=NZ9gkwHi3KaLU5GRI4qGGZn8xxdtBe2JIQ1+ENFxig0aplDbiDHZ94jcM7NkK9Y373412Ki5+A6Stqqb/6NdPr630kyCW/3nmzw2653oQMlk8DIEo/6LcT3gxk/Jg3MMOMnQQMyCk13qLrxRyBx2c0UGimfZDoO6gXkwzKfBHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515134; c=relaxed/simple;
	bh=s49b85FjHGKHSuNc+GJwsXIgOS6FGPLGH/zK6IY6Xr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubJEU0s3dkBOC0nNZGgtADPb0JRR6+0Q80MZzXtwReuGjiYCyamwxBIe/Fior7gWW1knF9JimAHhbAfi0UNmtK/OdRjiAa6PV+k3poYHjaaJN8KEwUQNVz+7teMopH+w5X+6gSq6RVDSZox3b8xTYvdcZMOh2bFBP5f6n+HMSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so216693f8f.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515130; x=1789119930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhGpNM5OSnjMRzfuxT/GA3MKVAHmzCHIYQE9cLSQzN4=;
        b=Xdu074OO5Cw/x7hdcJzGHeC/zE3eNosCnopUjflR5OX1PjzRugsGFLjbrjVJJFLS8c
         qk6WzwiKglIicseqQxPx1OR9X/ez4D/FL3HpzODigdeI0C89ZQ8bfPrnoPQ0uQ1MpSAx
         qc6yB6j6Py62yMCpKaCWzx9+WOPduJHDNBAD1yve0aAfI401baEV+rainz/tYS59Tp8+
         9o4CkXH0tbLAJIr/2X7NMv3lgT7R4yQyaFXRyZNF6XidHd2USutCazD6JXzW5nw+xIK8
         ZUu47rygg+t1ltGHscvjF1BlYHpsNAx929/RuWTxmTwiomtPm1BsNH9fZdvqCi2nS2Pk
         DUDA==
X-Gm-Message-State: AFuF++mOBf8bNAPEdaQFEs8pXKIE8DOKQgGkddzhNkNU+0++Osas0aVP
	HQGC6gtjzfY7Nj5pr9a3R1c5qXSdB7M/62yvShkbAT7Rc5HG+UoVBNPhurwx1/fu
X-Gm-Gg: AYBFou1YpHoO5Ka1onPOfQ8H+0s7AFZAUP+o4WWGuEYG0CtLqvbuvJ0lDHSzShHBctT
	q+9dfhfVZRbgflNWsWxgpJ45FID+v7Gjo8IHBdTyvNuut707yVTFhM/JeWLrGFLzCfVY5S1eaBl
	/U4bmMbfyIliG6vwESaCAiDjkq7FECVbDC5SEcrGJVBbAiX07wEQbm93U/1tFM85/El2luCyMew
	jjPZxl4wCqSDw0Xv/7/oy8ajN+mTLV7DJ3bl7ePPLwIKtPwGsOI5CwKGf6ENW3IOSeJhkOAqNvn
	1rVlxrfEX5gpGGLPKnNgFW8hRDizRu0Hif4x+PuggEEFoP8/uy4vh/Mem4SAprBz72Mxqtali9i
	INmqTcEPTIldjLlsfEqQHeN79l5aCPH5EpdlHuUGNnAsr1uM4VUKZVFyQyUyQ8leG24CWdA0HPq
	9WWpjMtr6TabuGj17/5f7XCyMVPTgHXrC1CAkWocgVtMVjyKZFB2NlvqAkqltIw3KSEY+qPD283
	9j6koh64bActWjkX2oAO08QUj3MMQ==
X-Received: by 2002:a05:6000:4a1a:b0:484:3334:9dc2 with SMTP id ffacd0b85a97d-4858708cb0dmr8973008f8f.15.1788515130123;
        Fri, 04 Sep 2026 02:45:30 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588133600sm5632238f8f.5.2026.09.04.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:45:29 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: openvswitch: fix kernel-doc warnings in internal headers
Date: Fri,  4 Sep 2026 11:45:14 +0200
Message-ID: <20260904094519.1817105-2-i.maximets@ovn.org>
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
index 86a47998a359a..cdbe281cf4c81 100644
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
index 8a930ca6d6b17..87cdc61c4150f 100644
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

