Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4593C4172
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514102; cv=none; b=q+Vqq/HWmnh6b3MAmzql8Yy3hXnFAzeyZD3CaFGnkuhMYKLSvk7dBFAvNEVv2pIMFleAruy4rqT3MyW6VpEFOjCsZNBbTol6TWsWPEFcsrKNRqI/Z3q0fmp+6knOYtsyVCiXmjxnGl8N+IArMUmwGZ5MhK/9MN515OV7yis2CKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514102; c=relaxed/simple;
	bh=/EBhFhmonMpPLK31n+8MfillTxi+reOLDR7fqgJxUbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIat76s/zdShoY9txriNmjC5CNyk0mUIiLUU7aDkuQX6k0fuUz8xzRUAnlP2Q5E8G/JI4liz913eGHb8lnHQt4wSdUE4g6uQw95WJkmmdfBFdH+53Nzv1T6Op5mE5iRlguScIq6HUCqieCJelgaXP6/7NCEfuLIcwuXCoXHVtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482e067ec96so153296f8f.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514098; x=1789118898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3mbcX6VY08+lnuxxTkew2AYvbia8oVFGxNEQNRg1vN0=;
        b=W5Bgy+BmzQtol4Wp8B6V3vNiBLicqaojm83FpnJN8DWgQ7wUnZCMHBiWkw3go4hok/
         MFcz5K25TJqaLr1Z3XVpLIIU4b0QtB/tn0ccm6ApInolo11YE/UdIIrJ9qxSLHF2HZZK
         WHD5f0ttXU8XQRMfq6BcHN9UjU6YQi4f9FuFZ16CzTrQykGeazjU0kFedhiK7j20KMOa
         pFXzAmVjJFQsJ7DfL/xrOoAf2TjXs2jJe2qnaPM3P/Rj5vuaXZQVL1rhDrjlNAdXKnK+
         KhKBTXUz9xBv25Day1/2tgpuKyutRs/SGgueU1iTNTTZCQZGo3Sf3neXxcSRiPsEkULL
         3Nbg==
X-Gm-Message-State: AFuF++nXUiKwGDkrYg51UY1Gp9uY0LRtp3+19NUWeRZpGaLZaJTKXkpy
	3xTW7kvH4p8EIkMZ77OS7sFAD1nzq+Cl4pj7Qir27YlNt8halsyi5E9zvfDeX7Sn
X-Gm-Gg: AYBFou1hUqF+pSiyN6OnkswlVse/ZNr9NreCBRgbLc9YS3Ecf8M+fCjoVMHpfFF4SXU
	dZeCGLz8ps9LcrD7KP44s4GzQu/dAKkxmX5G+R4XS/kyW4e5OImPoWQ6Ywnm7i/PFZK3trju5gx
	p9cmJVLEGQySc6Hvc63tADeP/2f/WQ57aDvHbSoZaJ4eEeWpCWOo1UW1EYtctRDFqnhifk5vekB
	+D++g5Rvn6/1llk4FWhRwwBcWxznL+gyV9INLlZjfSM23kun7z35mKMniAWWhl7RQxGw3lck+p+
	Ihm2UZPxpPZOWpw0tM9g4ZgVUPffVh9S5KovHnl4xwvNYm/ckQ+ZPfrJcZjc4ZEqa6iK97yz56h
	pONOEkQIqwuge+fQfkatsNLBqPvcDSLVM1xFlCZ7Zb6+/U471dJlr9C9S7ATOCpviZfRZ6YfUdg
	vrCc8Pv6qmWFxLuiII4D/3tTst0BE75En+iOmGT1Suts4eAMWZB0Te5dUXVNzt2cOLKwJBChYDg
	rjqTtGcAwEHowVDpe4=
X-Received: by 2002:a05:6000:29dc:b0:482:eadd:174a with SMTP id ffacd0b85a97d-485872a7ef3mr3621310f8f.17.1788514097864;
        Fri, 04 Sep 2026 02:28:17 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm5108934f8f.27.2026.09.04.02.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:28:17 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 1/2] net: openvswitch: fix kernel-doc warnings in internal headers
Date: Fri,  4 Sep 2026 11:27:46 +0200
Message-ID: <20260904092810.1813221-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904092810.1813221-1-i.maximets@ovn.org>
References: <2026090349-submitter-decorated-2272@gregkh>
 <20260904092810.1813221-1-i.maximets@ovn.org>
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
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.h | 20 ++++++++++++++------
 net/openvswitch/vport.h    |  9 +++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 8453da5507e11..67250d7df1ab2 100644
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
@@ -128,10 +131,13 @@ struct ovs_skb_cb {
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
@@ -152,6 +158,10 @@ struct dp_upcall_info {
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
@@ -160,8 +170,6 @@ struct ovs_net {
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_ct_limit_info *ct_limit_info;
 #endif
-
-	/* Module reference for configuring conntrack. */
 	bool xt_label;
 };
 
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 3e71ca8ad8a78..9f67b9dd49f98 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -97,6 +97,8 @@ struct vport {
  * @desired_ifindex: New vport's ifindex.
  * @dp: New vport's datapath.
  * @port_no: New vport's port number.
+ * @upcall_portids: %OVS_VPORT_ATTR_UPCALL_PID attribute from Netlink message,
+ * %NULL if none was supplied.
  */
 struct vport_parms {
 	const char *name;
@@ -125,6 +127,8 @@ struct vport_parms {
  * have any configuration.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
+ * @owner: Module that implements this vport type.
+ * @list: List entry in the global list of vport types.
  */
 struct vport_ops {
 	enum ovs_vport_type type;
@@ -144,6 +148,7 @@ struct vport_ops {
 /**
  * struct vport_upcall_stats_percpu - per-cpu packet upcall statistics for
  * a given vport.
+ * @syncp:     Synchronization point for 64bit counters.
  * @n_success: Number of packets that upcall to userspace succeed.
  * @n_fail:    Number of packets that upcall to userspace failed.
  */
@@ -164,6 +169,8 @@ void ovs_vport_free(struct vport *);
  *
  * @vport: vport to access
  *
+ * Returns: A void pointer to a private data allocated in the @vport.
+ *
  * If a nonzero size was passed in priv_size of vport_alloc() a private data
  * area was allocated on creation.  This allows that area to be accessed and
  * used for any purpose needed by the vport implementer.
@@ -178,6 +185,8 @@ static inline void *vport_priv(const struct vport *vport)
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

