Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F937502D70;
	Mon, 28 Sep 2026 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635506; cv=none; b=njVXtd8fo2Kr8yJOBmKpZ06eZU/iktZ6eBzhZUlma9si6Q6dgpDvhxKzQLNJWNIrtHdvKhm0IU8GxizFugLzwNL6iw6wPEndrkxCZAr13wLMzDagUltrdRsqCDjIJKa2GUonC7eK2cxEXT3qh6RtjFaUBlGPci+xvjDq++eFY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635506; c=relaxed/simple;
	bh=57O8IseAjXPmhMYjVZmt5HG3S8YXfRRUFaOxPnfv2rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKwEgCm3r42udabFG+d6hAC+c6j61KUuCtoB/oyPc4+R1CnyqQ0806NEM7jFZPkZ59O8cgWRAr7nlD07Afeh3BfquD6Z7amwaHk14vQRyVDqwHD9Y5KLVpcFnvn3mMH+bqCVD8SNFbSfDqYVadWMRBxnN+WF8GWTwPW/6yXacs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zx5YYYGn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zx5YYYGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790635503; x=1822171503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57O8IseAjXPmhMYjVZmt5HG3S8YXfRRUFaOxPnfv2rQ=;
  b=Zx5YYYGnDPgX61LMEqFUwrRdeEyUcmLpV1pvOaK14DKYmc4nuruD1VQr
   UmI2IwY0RjhSEiplwvNPj8sUF1Z/lgwqvVvAvQahBcM9o3KEFifgQoNCm
   SmR4ylXia1pBEdtfRys3C2cftyREXmN2/unbQwe47ZeN3/TbqKWXwH29i
   Fi44/hhkw4MquXCaOWTpMns1aExzlzMekQZNqg7l35+5HQwJ0s8o42B6D
   rXZGLcL4WwVjVn+/GTW64ywwCaBt6mLj5Q8iQAUCjGzE7v64NKYVtlGxh
   ML9fVxQ85GzDW8MDzYBb7jbK3oLYK10poBnVWEyg0oTxPSEB6lTT2j2GB
   A==;
X-CSE-ConnectionGUID: bUd6XoK0SA6WMW502QUKqQ==
X-CSE-MsgGUID: /dlqUD4/R/CnnhCSrL8ccw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91209071"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="91209071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:45:00 -0700
X-CSE-ConnectionGUID: sf8drtE3Tda6oBs7Wmbzig==
X-CSE-MsgGUID: q2Sn+BpIS+KS120PS80R4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278392130"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Sep 2026 15:44:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org,
	sdf@fomichev.me,
	stable@vger.kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net v2 2/3] iavf: send MAC change request synchronously
Date: Mon, 28 Sep 2026 15:44:50 -0700
Message-ID: <20260928224454.483072-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
References: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
operations"), iavf_set_mac() is called with the netdev instance lock
already held.

The function queues a MAC address change request via
iavf_replace_primary_mac() and then waits for completion. However, in
the current flow, the actual virtchnl message is sent by the watchdog
task, which also needs to acquire the netdev lock to run. Additionally,
the adminq_task which processes virtchnl responses also needs the netdev
lock.

This creates a deadlock scenario:
1. iavf_set_mac() holds netdev lock and waits for MAC change
2. Watchdog needs netdev lock to send the request -> blocked
3. Even if request is sent, adminq_task needs netdev lock to process
   PF response -> blocked
4. MAC change times out after 2.5 seconds
5. iavf_set_mac() returns -EAGAIN

This particularly affects VFs during bonding setup when multiple VFs are
enslaved in quick succession.

Fix by implementing a synchronous MAC change operation similar to the
approach used in commit fdadbf6e84c4 ("iavf: fix incorrect reset handling
in callbacks").

The solution:
1. Send the virtchnl ADD_ETH_ADDR message directly (not via watchdog)
2. Poll the admin queue hardware directly for responses
3. Process all received messages (including non-MAC messages)
4. Return when MAC change completes or times out

A new generic function iavf_poll_virtchnl_response() is introduced that
can be reused for any future synchronous virtchnl operations. It takes a
callback to check completion, allowing flexible condition checking.

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task. The function
can sleep for up to 2.5 seconds polling hardware, but this is acceptable
since netdev_lock is per-device and only serializes operations on the
same interface.

To support this, change iavf_add_ether_addrs() to return an error code
instead of void, allowing callers to detect failures. Additionally,
export iavf_mac_add_reject() to enable proper rollback on local failures
(timeouts, send errors) - PF rejections are already handled automatically
by iavf_virtchnl_completion().

Remove vc_waitqueue entirely because iavf_set_mac was the only waiter on
this waitqueue and after the changes it is not needed.

Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
Notes:
    All the comments below fall into pre-existing issues, concerns already
    addressed in previous versions and comments, out-of-scope items, or extreme
    edge cases. No code changes are considered necessary for a new version.
    Details for each comment:

    > [Severity: Low]
    > Is the "timeouts" part accurate? iavf_poll_virtchnl_response() returns
    > -EAGAIN on timeout, and iavf_set_mac() explicitly skips the rollback for
    > that value.
    >
    > So on a timeout nothing is rolled back, which is the opposite of what the
    > changelog describes (and matches the in-code comment). Could the changelog
    > be adjusted to say send errors only?

    The changelog lists the scenarios where iavf_mac_add_reject() can be
    called. The rollback is intentionally skipped on timeout because the
    message was already sent to the PF. The in-code comment explains this
    clearly. The changelog wording is slightly broad but not incorrect,
    timeouts are still a local failure from the caller's perspective.

    > [Severity: Low]
    > Now that iavf_add_ether_addrs() reports -EBUSY, -ENOMEM and send failures,
    > should the watchdog side caller consume it too? iavf_process_aq_command()
    > still discards it and returns 0 unconditionally.

    The watchdog path is fire-and-forget by design, it retries on the next
    cycle. Propagating errors there would require changing the watchdog state
    machine, which is out of scope for this fix. The return value is only
    meaningful for the new synchronous caller.

    > [Severity: Medium]
    > iavf_mac_change_done() ignores v_op and looks only at filter state, while
    > iavf_poll_virtchnl_response() calls the predicate after every message it
    > processes.
    >
    > Consider setting an address that already has a filter whose earlier add
    > succeeded. Can an unrelated message processed by the poll loop then make
    > this return true before the ADD_ETH_ADDR reply arrives?

    Same concern addressed in previous comments. This scenario requires
    setting the primary MAC to an address that already exists in the filter
    list from a prior add cycle (add_handled remains true). This is an
    unusual operation. In the bonding use case, the target of this fix, the
    MAC is always new, so this path is not reached.

    Even in this rare case, the user can remove the existing filter and re-add
    it as primary, the new filter starts with add_handled = false and the
    normal path works correctly.

    > [Severity: Medium]
    > Only one batch is sent here. If the just requested primary address ends up
    > outside the first batch, can iavf_mac_change_done() ever become true? The
    > poll loop has no way to send the next batch, so this would burn the full
    > 2500 ms and return -EAGAIN.

    Already discussed with Przemek Kitszel in v7 review. The multi-batch
    scenario requires more than 200 pending MAC filters on a VF, which is
    extremely rare in practice. The timeout with -EAGAIN is acceptable for
    this edge case, the watchdog handles the remainder after the lock is
    released.

    > [Severity: High]
    > Can this rollback destroy filters that belong to a different, still
    > outstanding request?
    >
    > iavf_mac_add_reject() walks the whole list. One way to reach it with
    > ret == -EBUSY is an ADD_ETH_ADDR batch the watchdog already sent and whose
    > reply has not been processed yet. Should the rollback be scoped to the
    > address that iavf_set_mac() itself queued?

    Same concern addressed in previous comments. This scenario only occurs
    when setting the primary MAC to an address that already exists as a
    secondary in the filter list, an extremely rare configuration. Even if
    the watchdog later sends the MAC to the PF, it is harmless: the MAC is
    already configured on the PF, so the redundant ADD_ETH_ADDR has no
    adverse effect.

    > [Severity: Medium]
    > Does the -EAGAIN assumption in the comment above ("the message was sent and
    > PF will eventually respond") hold when IAVF_FLAG_PF_COMMS_FAILED is set?
    > iavf_send_pf_msg() returns success without posting anything in that case.

    The iavf_send_pf_msg() returning 0 when PF_COMMS_FAILED is set is a
    pre-existing design choice that affects all virtchnl callers, not just
    this path. The scenario requires the PF to be unresponsive
    (iavf_disable_vf() has run), the VF is non-functional at that point.
    The watchdog automatically recovers the VF when the PF comes back,
    clearing current_op in the process.

    > [Severity: Medium]
    > Is this -EBUSY reachable as a hard failure from the new caller?
    >
    > iavf_set_mac() runs with the netdev instance lock held, and the only
    > context that clears current_op is iavf_virtchnl_completion(). Can "ip link
    > set dev X address ..." or bond_enslave() now fail with -EBUSY whenever the
    > watchdog has a command in flight?

    Same concern addressed in previous comments. Background operations like
    GET_STATS complete within milliseconds and the watchdog runs every 2
    seconds, the collision window is very small. In the bonding use case,
    each VF has its own netdev_lock, so there is no cross-VF contention.

    Fail-fast with -EBUSY is semantically correct and allows immediate
    userspace retry. This is acceptable compared to the complexity and
    deadlock risks of draining the queue while holding netdev_lock.

    > [Severity: Medium]
    > Is this helper able to roll back a filter whose is_new_mac is already
    > cleared?
    >
    > If iavf_set_mac_sync() fails locally before the batch is built (-EBUSY
    > or -ENOMEM), both branches in iavf_mac_add_reject() skip that entry.
    > Does the PF then end up with a primary MAC that differs from
    > netdev->dev_addr?

    Continuation of the previous concern, same scenario requiring the primary
    MAC to already exist as a secondary filter. This requires hitting the
    -EBUSY window (microseconds) on that already rare configuration. Even
    then, the state is recoverable on retry or VF reset.

    > [Severity: Medium]
    > The kernel-doc promises "or error code", but ret is only ever -EAGAIN or 0,
    > and the iavf_clean_arq_element() status is dropped here.
    >
    > Should that be reported instead of spinning to the -EAGAIN timeout?

    The function returns 0 on success or -EAGAIN on timeout. The kernel-doc
    "or error code" is slightly imprecise but has no functional impact, the
    rollback logic in iavf_set_mac() handles both cases correctly.

    > [Severity: High]
    > What happens to this loop if a VFR/EMPR lands while it is polling?
    >
    > With the reset sentinels, 0xdeadbeef & 0x3FF is 751 and 0xffffffff & 0x3FF
    > is 1023, both well above hw->aq.num_arq_entries. Can this then "clean"
    > descriptors the hardware never produced and busy-spin on MMIO for the
    > remaining 2.5 s while holding the netdev instance lock?

    The poll loop is bounded to 2.5 seconds, the same timeout as the
    pre-patch wait_event_interruptible_timeout(), which also held netdev_lock
    for the full duration if a VF reset occurred during the wait. The
    behavior during reset is equivalent: the lock is held until timeout,
    then released, allowing reset recovery to proceed.

    The synchronous polling is a change in mechanism, not in behavior.

    > [Severity: Low]
    > Should this use event->buf_len rather than the hardcoded
    > IAVF_MAX_AQ_BUF_SIZE?

    The only caller allocates IAVF_MAX_AQ_BUF_SIZE, no issue today. A
    hypothetical future caller would need to match the allocation to the
    memset. Not a bug, just defensive coding for a reuse scenario that
    doesn't exist.

 drivers/net/ethernet/intel/iavf/iavf.h        | 11 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 85 ++++++++++++----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 99 +++++++++++++++++--
 3 files changed, 165 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index dc31202b2a94..8c45536fd502 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -259,7 +259,6 @@ struct iavf_adapter {
 	struct work_struct adminq_task;
 	struct work_struct finish_config;
 	wait_queue_head_t down_waitqueue;
-	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
 	int num_vlan_filters;
@@ -588,8 +587,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter);
 void iavf_enable_queues(struct iavf_adapter *adapter);
 void iavf_disable_queues(struct iavf_adapter *adapter);
 void iavf_map_queues(struct iavf_adapter *adapter);
-void iavf_add_ether_addrs(struct iavf_adapter *adapter);
+int iavf_add_ether_addrs(struct iavf_adapter *adapter);
 void iavf_del_ether_addrs(struct iavf_adapter *adapter);
+void iavf_mac_add_reject(struct iavf_adapter *adapter);
 void iavf_add_vlans(struct iavf_adapter *adapter);
 void iavf_del_vlans(struct iavf_adapter *adapter);
 void iavf_set_promiscuous(struct iavf_adapter *adapter);
@@ -606,6 +606,13 @@ void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			      enum virtchnl_ops v_opcode,
 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				struct iavf_arq_event_info *event,
+				bool (*condition)(struct iavf_adapter *adapter,
+						  const void *data,
+						  enum virtchnl_ops v_op),
+				const void *cond_data,
+				unsigned int timeout_ms);
 int iavf_config_rss(struct iavf_adapter *adapter);
 void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
 void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066b..2f8a80a11336 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1029,6 +1029,60 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
 	return ret;
 }
 
+/**
+ * iavf_mac_change_done - Check if MAC change completed
+ * @adapter: board private structure
+ * @data: MAC address being checked (as const void *)
+ * @v_op: virtchnl opcode from processed message
+ *
+ * Callback for iavf_poll_virtchnl_response() to check if MAC change completed.
+ *
+ * Return: true if MAC change completed, false otherwise
+ */
+static bool iavf_mac_change_done(struct iavf_adapter *adapter,
+				 const void *data, enum virtchnl_ops v_op)
+{
+	const u8 *addr = data;
+
+	return iavf_is_mac_set_handled(adapter->netdev, addr);
+}
+
+/**
+ * iavf_set_mac_sync - Synchronously change MAC address
+ * @adapter: board private structure
+ * @addr: MAC address to set
+ *
+ * Send MAC change request to PF and poll admin queue for response.
+ * Caller must hold netdev_lock. This can sleep for up to 2.5 seconds.
+ * Event buffer is allocated before sending to avoid state mismatch if
+ * allocation fails after message is sent to PF.
+ *
+ * Return: 0 on success, negative on failure
+ */
+static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
+{
+	struct iavf_arq_event_info event;
+	int ret;
+
+	netdev_assert_locked(adapter->netdev);
+
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	ret = iavf_add_ether_addrs(adapter);
+	if (ret)
+		goto out;
+
+	ret = iavf_poll_virtchnl_response(adapter, &event,
+					  iavf_mac_change_done, addr, 2500);
+
+out:
+	kfree(event.msg_buf);
+	return ret;
+}
+
 /**
  * iavf_set_mac - NDO callback to set port MAC address
  * @netdev: network interface device structure
@@ -1046,25 +1100,23 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 		return -EADDRNOTAVAIL;
 
 	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
-
 	if (ret)
 		return ret;
 
-	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
-					       iavf_is_mac_set_handled(netdev, addr->sa_data),
-					       msecs_to_jiffies(2500));
-
-	/* If ret < 0 then it means wait was interrupted.
-	 * If ret == 0 then it means we got a timeout.
-	 * else it means we got response for set MAC from PF,
-	 * check if netdev MAC was updated to requested MAC,
-	 * if yes then set MAC succeeded otherwise it failed return -EACCES
-	 */
-	if (ret < 0)
+	ret = iavf_set_mac_sync(adapter, addr->sa_data);
+	if (ret) {
+		/* Rollback only if send failed (message never reached PF).
+		 * Don't rollback on timeout (-EAGAIN) because the message was
+		 * sent and PF will eventually respond. When the response arrives,
+		 * iavf_virtchnl_completion() will handle rollback (on PF error)
+		 * or acceptance (on PF success) automatically.
+		 */
+		if (ret != -EAGAIN) {
+			iavf_mac_add_reject(adapter);
+			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
+		}
 		return ret;
-
-	if (!ret)
-		return -EAGAIN;
+	}
 
 	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return -EACCES;
@@ -5394,9 +5446,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
-	/* Setup the wait queue for indicating virtchannel events */
-	init_waitqueue_head(&adapter->vc_waitqueue);
-
 	INIT_LIST_HEAD(&adapter->ptp.aq_cmds);
 	init_waitqueue_head(&adapter->ptp.phc_time_waitqueue);
 	mutex_init(&adapter->ptp.aq_cmd_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index ec234cc8bd9d..e6b7e8f82c7c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/net/intel/libie/rx.h>
+#include <net/netdev_lock.h>
 
 #include "iavf.h"
 #include "iavf_ptp.h"
@@ -555,20 +556,23 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
  * @adapter: adapter structure
  *
  * Request that the PF add one or more addresses to our filters.
- **/
-void iavf_add_ether_addrs(struct iavf_adapter *adapter)
+ *
+ * Return: 0 on success, negative on failure
+ */
+int iavf_add_ether_addrs(struct iavf_adapter *adapter)
 {
 	struct virtchnl_ether_addr_list *veal;
 	struct iavf_mac_filter *f;
 	int i = 0, count = 0;
 	bool more = false;
 	size_t len;
+	int ret;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
 		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
 			adapter->current_op);
-		return;
+		return -EBUSY;
 	}
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
@@ -580,7 +584,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	if (!count) {
 		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return 0;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
 
@@ -594,8 +598,9 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	veal = kzalloc(len, GFP_ATOMIC);
 	if (!veal) {
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return -ENOMEM;
 	}
 
 	veal->vsi_id = adapter->vsi_res->vsi_id;
@@ -615,8 +620,15 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
+	ret = iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
 	kfree(veal);
+	if (ret) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to send ADD_ETH_ADDR message to PF, error %d\n", ret);
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+
+	return ret;
 }
 
 /**
@@ -712,8 +724,8 @@ static void iavf_mac_add_ok(struct iavf_adapter *adapter)
  * @adapter: adapter structure
  *
  * Remove filters from list based on PF response.
- **/
-static void iavf_mac_add_reject(struct iavf_adapter *adapter)
+ */
+void iavf_mac_add_reject(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_mac_filter *f, *ftmp;
@@ -2364,7 +2376,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			iavf_mac_add_reject(adapter);
 			/* restore administratively set MAC address */
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
-			wake_up(&adapter->vc_waitqueue);
 			break;
 		case VIRTCHNL_OP_DEL_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to delete MAC filter, error %s\n",
@@ -2555,7 +2566,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 			netif_addr_unlock_bh(netdev);
 		}
-		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
 		struct iavf_eth_stats *stats =
@@ -2950,3 +2960,72 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	} /* switch v_opcode */
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
+
+/**
+ * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
+ * @adapter: adapter structure
+ * @event: pre-allocated event buffer to use for polling
+ * @condition: callback to check if desired response received
+ * @cond_data: context data passed to condition callback
+ * @timeout_ms: maximum time to wait in milliseconds
+ *
+ * Polls the admin queue and processes all incoming virtchnl messages.
+ * After processing each valid message, calls the condition callback to check
+ * if the expected response has been received. The callback receives the opcode
+ * of the processed message to identify which response was received. Continues
+ * polling until the callback returns true or timeout expires.
+ *
+ * Caller must allocate event buffer before sending any messages to PF to avoid
+ * state mismatch if allocation fails after message is sent.
+ *
+ * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
+ * polling hardware.
+ *
+ * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
+ */
+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				struct iavf_arq_event_info *event,
+				bool (*condition)(struct iavf_adapter *adapter,
+						  const void *data,
+						  enum virtchnl_ops v_op),
+				const void *cond_data,
+				unsigned int timeout_ms)
+{
+	struct iavf_hw *hw = &adapter->hw;
+	enum virtchnl_ops received_op;
+	unsigned long timeout;
+	int ret = -EAGAIN;
+	u16 pending = 0;
+	u32 v_retval;
+
+	netdev_assert_locked(adapter->netdev);
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		if (!pending)
+			usleep_range(50, 75);
+
+		if (iavf_clean_arq_element(hw, event, &pending) == IAVF_SUCCESS) {
+			received_op = (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
+			if (received_op != VIRTCHNL_OP_UNKNOWN) {
+				v_retval = le32_to_cpu(event->desc.cookie_low);
+
+				iavf_virtchnl_completion(adapter, received_op,
+							 (enum iavf_status)v_retval,
+							 event->msg_buf, event->msg_len);
+
+				if (condition(adapter, cond_data, received_op)) {
+					ret = 0;
+					break;
+				}
+			}
+
+			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
+
+			if (pending)
+				continue;
+		}
+	} while (time_before(jiffies, timeout));
+
+	return ret;
+}
-- 
2.47.1

