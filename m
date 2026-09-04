Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67158448BB6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514729; cv=none; b=sADBTk7omyahDqhoFjoRO2m6jf9Z/jVbnADNXvkTYEbd1kBTM40WBGgjKh0q7Sl2Asvg8+kpp7Mqg8ywyeVGd6M5D4nmDmVyepkWScOQWQ2cgEWrhCP+Vd8BzBShGx8qZZ4g3fkBoyZuvLNPpq1DQ+2ztoBSJAEYPYxAO3bIvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514729; c=relaxed/simple;
	bh=uWcajjMQc5PmAjZRspGtcsDlfWb3CkobvQ5/40IBnyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI++VZucS2Y23lg9xqQUQkdUUuCWiLfbX8QeRvpcjd2u4Fqcp47UHswjfy+OjgDj8zXrvVWXqE4kdBI2XwK1sfN7045Udt9o5Z9ksbhRzW4uMRhjoaN5YZQepv7qdE2iQ43879SmSg1gISl52FVuk9ucSGVy/PPSc4zmPT1dyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so2444115e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514725; x=1789119525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVCMLw1/BEbG73IcNTZRgx8te/51Nu+ptC/kQlhazeM=;
        b=hOQ0JnYNXG9Rj3Uv/d7e7mPq+H++Eesa0Lgw7XCy2t3wddgeU0yYabyQQC65LKeSpg
         9c3mpIxsTQj1zNrrlUv+MSot2s/W86SwJPuBGnnbds2Xf9DVOE40herhkZZHZw9NfUTN
         oBcY4te40VLGEqemndxUNURTzc0W8aIWNltOwixdeNDxIdMXc5/NNfaLtjeMrejPzU97
         Kc4aeG/8wZsXabhjqcM+KxSZCpjb4YLhq3bhHXJHEjB8YleQEx3lNnCRPh20RjF9EhfF
         tDE/SX8aT4HJstIjLhNB5x0LTusI+xSVivjNM5g6pwy7LlW0U4HngCY922OULuZq3Su9
         JNIA==
X-Gm-Message-State: AFuF++mssJLKPJPD9WNxVSzvZ6e/fDOgqlblziycOF+vtZN5CrKe1KKl
	u52nLFNBvbfWDOqQp4LCPDLCJltb4HVib1hzNb6fRasvSHhYGRF+cagQ+VwpA7yb
X-Gm-Gg: AYBFou09Q1qxMji6F1SpoT2By6Ue6t9leyVVpV+szpdmuDnf341c4z+ypK3Sh8eaETH
	qI3dUJtZ10hvZyuyXRc2uEGQR4T+zfbJGfXITAhDfPduM6VliojR7cJ0OnQvX0zrsRn+SJVweSL
	KxpbnYfqiiEuHc7suyeV41EXYqZOqgV8ed7c4dyUR2xOl84nvVbZI/u2lwrzy7rDinWDtw4vVrq
	RqOxPOL/6lK5hjNHAzOhKaoMhv5uXIbER8OFTH1nZ+vqRh2HwGw00UT9z82kl+CeZLB3eHbSzSt
	oII7ZWR9vttXCG8KRYkOcZBRQ+q7U+EC5oTChJ6Ufr4+2KrLky60uwb/hxGdRdFyFB8KQZYPGYi
	YZfAA5sfQfxdT4Ep/PzxAx82bcmulkxAEQBNy+CDGAcRXNXJlB9tm+B5kZsYElxZizjvEB4P4QP
	piuxiogblPunGyZeIIuJGpLGnGydh1MSwzmPPvE2p8+ZuMpKBbQ2CTRGeV1x+zOJHXpRWLFxJQc
	C9MgekN59A8zs0i1+8=
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr54093565e9.2.1788514724843;
        Fri, 04 Sep 2026 02:38:44 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740af2sm56458955e9.14.2026.09.04.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:38:44 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: openvswitch: fix kernel-doc warnings in internal headers
Date: Fri,  4 Sep 2026 11:38:20 +0200
Message-ID: <20260904093840.1815273-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904093840.1815273-1-i.maximets@ovn.org>
References: <2026090350-daily-ultimatum-52f4@gregkh>
 <20260904093840.1815273-1-i.maximets@ovn.org>
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

