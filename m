Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647119;
	b=RJ21JfCaiOBUZPBmdHoCiO4jIiiuckvzpaJEFeiVXB+KRW2DCOovGxrgiBD46jgzrcP7
	 f1fDquphYOjGaW+D8XTI5piMJK9BFPRyTVxHp2AsMlJhDZAd0O0svFzPLps82bUzbNvnd
	 R8vtiL17BpwQUrY0St2Gl8twDSEszB5Z2pVoOTIOC3ZMoRJP9uStJ2QAdp0nkqi2FRGkx
	 J+/xxqVV+5bUSW0rNssNSJ22lj7A17poDfRr87t7ZvMGcxUDD4Iw0LIw5SJZ3/5yIabr/
	 QiWiLxKLqmwccAX9AAx0vOwQEyXqnwLN4+ohKC0Oo/+7q8DIoXMDu8Nxg9R3P7LehVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647119;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B815Sf6bduzPc3DZEZODsXRLzdQ5/ZYRopDsd0+3+ls=;
	b=O0Z3380L/RkeBwCAaC0K4niIvnbA+z+Q9nbC+w92AvNWkYfOY9swmcIzgweOR8TxKajY
	 ufi+7REVC8xvD0MHDR4fqJ1fz9QhF8i0+dcgLuxV28XtQjML1XdmhCkThSDmRGwvlZQkC
	 f4rd5cp4/Pg9MUz0ksu7Swxq8US2sBWlWIjYOyyeCYetqq3I3uven9Vg2ylswHjQAKw8f
	 mwgxO6qQ97B/3+yfPQSCA+dS6Do8Bw5ix7aiSRZ69fLa0sgNLlcn0qc0sQhQcN4XUj9zi
	 FjwkUsQ0Ki4CBKKdd3W/R46D3Wfl9BRP1fYGoQpPdXMhUhyu+YzIhLbyF30W77KoSZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eqxF7xAL;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358F606A337;
	Wed, 25 Nov 2026 22:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A358F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eqxF7xAL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795647118; x=1827183118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05zugeaceFKW51k2cEqGL7Cm3wTDiDzWOlX3aA0JY+c=;
  b=eqxF7xALp5FXV8HCUV0iW4YcfYLpK9VtDNy98qFm6AKSoptBIv2LY8dS
   mcVXXy9BaFA9yQ/PtAncFClI9CBfaw4l68TPZgbrwm7TbAgnKFO4YlT/T
   F17BaTIXOsybPhy+8sa1tDCGeWInYnKCN5bskBrTkdpZIEJ7YT1pXgkyx
   xYt67SwhCz6cKtsTLB71eCqjgY/ZJlc7gLVGPOaCjwrIMrI6h5MilrlpU
   j4peIctZIOHWwFGWUV2JA/TYFCwUSD3kQE7DFGMqJn1F1b1b3qw3uwq6C
   7AP69eOK/mCll6f0SeVg0K2HnwEq1pouxesUSBKfCvZ01dVj+n1WXVDGj
   w==;
X-CSE-ConnectionGUID: NYBh7qVZRx6GVaxJTu6yxw==
X-CSE-MsgGUID: chelDxNeRE61UBU0Wbc9Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4450683"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4450683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:51:55 -0800
X-CSE-ConnectionGUID: 3XR50qjqSKGks30nWyhQ6A==
X-CSE-MsgGUID: P8UrbuGDQ5m8iBh0mhFRnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11996942"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 14:51:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	willemb@google.com,
	netdev@vger.kernel.org
Cc: Tian Xun Ng <tianxun.ng@bytedance.com>,
	anthony.l.nguyen@intel.com,
	oss.patchbox@gmail.com,
	emil.s.tantilov@intel.com,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	konstantin.ilichev@intel.com,
	stable@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 4/6] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Wed, 25 Nov 2026 14:51:41 -0800
Message-ID: <20261125225145.4126333-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261125225145.4126333-1-anthony.l.nguyen@intel.com>
References: <20261125225145.4126333-1-anthony.l.nguyen@intel.com>
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
before idpf_deinit_task() tears the vports down, so every message sent
during that teardown (disable vport, disable queues, destroy vport)
fails at once, and the device is never told that the vports are gone.

A reset should clear that state, but on the system where this was found
the device kept the queues enabled across a warm reboot. The first queue
reconfiguration in the next kernel (udev setting the MTU) sends
VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX
completions to the previous kernel's completion rings. With the IOMMU
translating, those writes fault about 19 s into every such boot:

  arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0

In IOMMU pass-through mode they corrupt pages the new kernel has reused.

Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as
idpf_remove() does, so that the event task cannot be requeued and the
vports are destroyed while the mailbox is still up; the first two
patches keep the Tx timestamp callback and the link event handler away
from the state released on the way. So that an unresponsive control
plane does not hold up a reboot for long, cap each transaction sent
during the teardown at 500 ms instead of 60 s, through a new
adapter->vc_xn_timeout_ms, and fail later synchronous ones at once after
the first one times out. If the SW marker of one disabled Tx queue does
not arrive, the remaining queues of that vport do not wait for theirs,
but the mailbox messages that follow are still sent: the device has just
answered DISABLE_QUEUES. A control plane that dies at that point costs
one marker timeout per vport and one mailbox timeout. The statistics
task stops sending once IDPF_REMOVE_IN_PROG is set. A request it already
has waiting, or a reset already running in the event task, keeps its own
timeouts, as bounding those would need support in libie. If the function
has already been reset, for instance a VF whose PF went down first,
idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this series backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions, with all 64 Tx queue markers received; the
slowest transaction, VIRTCHNL2_OP_DEALLOC_VECTORS, took about 300 ms.
With the first Tx queue marker treated as missing, the other 63 queues
did not wait, all six transactions still completed, the teardown took
about 2 s per PF, and 3 of 3 warm reboots were clean. With the driver
made to skip sending the teardown messages, every reboot faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  5 ++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 33 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f214023095ee..533b069d97f9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -85,7 +85,7 @@ enum idpf_state {
  * @IDPF_HR_FUNC_RESET: Hard reset when TxRx timeout
  * @IDPF_HR_DRV_LOAD: Set on driver load for a clean HW
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
- * @IDPF_REMOVE_IN_PROG: Driver remove in progress
+ * @IDPF_REMOVE_IN_PROG: Driver remove or shutdown in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_FLAGS_NBITS: Must be last
@@ -635,6 +635,8 @@ struct idpf_edt_caps_ilog2 {
  * @asq: Send control queue info
  * @arq: Receive control queue info
  * @xnm: Xn transaction manager
+ * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
+ *		      on shutdown and set to 0 once a shortened one timed out
  * @num_avail_msix: Available number of MSIX vectors
  * @num_msix_entries: Number of entries in MSIX table
  * @msix_entries: MSIX table
@@ -695,6 +697,7 @@ struct idpf_adapter {
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
 	struct libie_ctlq_xn_manager *xnm;
+	u32 vc_xn_timeout_ms;
 	u16 num_avail_msix;
 	u16 num_msix_entries;
 	struct msix_entry *msix_entries;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 523c0e0be884..062d2f540254 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1377,6 +1377,9 @@ void idpf_statistics_task(struct work_struct *work)
 	for (i = 0; i < adapter->max_vports; i++) {
 		struct idpf_vport *vport = adapter->vports[i];
 
+		if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+			return;
+
 		if (vport && !test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 			idpf_send_get_stats_msg(netdev_priv(vport->netdev),
 						&vport->port_stats);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6baa..21be83dc82b1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	/* As in idpf_remove(): keep the event task from being requeued, and
+	 * destroy the vports while the mailbox is still up.
+	 */
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Bound the teardown transactions started from here on, so that an
+	 * unresponsive control plane costs a single timeout. A reset or a
+	 * transaction that is already running keeps its own timeouts.
+	 */
+	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
@@ -267,6 +277,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_rx_splitq = true;
 
 	adapter->pdev = pdev;
+	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	err = idpf_dev_init(adapter, ent);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 854eb1f1ada4..e7a8ccbc3585 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -195,20 +195,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
+ * synchronous transaction with a shortened timeout times out, later ones
+ * fail at once instead of waiting again.
+ *
  * Return: 0 if the request was successful, -%EBUSY if reset is detected
- *	   or Tx control queue is full, other negative error code on failure.
+ *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
+ *	   already timed out, other negative error code on failure.
  */
 int idpf_send_mb_msg(struct idpf_adapter *adapter,
 		     struct libie_ctlq_xn_send_params *xn_params,
 		     void *send_buf, size_t send_buf_size)
 {
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
 	struct libie_ctlq_msg ctlq_msg = {};
+	int err = 0;
 
-	if (idpf_is_reset_detected(adapter)) {
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (!timeout_ms)
+		err = -ETIMEDOUT;
+
+	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
 			kfree(send_buf);
 
-		return -EBUSY;
+		return err;
 	}
 
 	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
@@ -219,10 +231,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 	xn_params->xnm = adapter->xnm;
 	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
 	xn_params->rel_tx_buf = kfree;
+	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
 
 	idpf_mb_clean(xn_params->ctlq, false);
 
-	return libie_ctlq_xn_send(xn_params);
+	err = libie_ctlq_xn_send(xn_params);
+	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return err;
 }
 
 /**
@@ -372,6 +389,11 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 	struct net_device *netdev;
 	struct idpf_tx_queue *txq;
 	bool markers_rcvd = true;
+	bool wait_all;
+
+	/* On shutdown, once one marker is missing, don't wait for the rest */
+	wait_all = READ_ONCE(qs->adapter->vc_xn_timeout_ms) >=
+		   IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	for (u32 i = 0; i < qs->num; i++) {
 		switch (qs->qs[i].type) {
@@ -381,7 +403,8 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 			netdev = txq->netdev;
 
 			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
+			if (markers_rcvd || wait_all)
+				idpf_wait_for_sw_marker_completion(txq);
 			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5d27805ff40f..911a25ad958b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -7,6 +7,7 @@
 #include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	500
 
 struct idpf_adapter;
 struct idpf_netdev_priv;
-- 
2.47.1

