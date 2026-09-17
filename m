Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ECB221DAE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604373; cv=none; b=QIl8qolYyKY0RGlLrq//LloHa93MBDU9RDQf7Ja+B39n/3uHmPk0gHGfGhvB42jByQ5fT/UkLPvUresYf7QAHNDeN3S/uHW0CBQYQc8XZ/EKyL2SGgZhcXHTDl7JGAgMWpbhrXQGdJUDgIVd73xy9stFE/xucGpmZV0EwwL9m1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604373; c=relaxed/simple;
	bh=pWHA4jCGdmF72RDPnfQL1UmSzKHTRCxAuUv9KfXnWJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ldn2b3Y8+TVv71KxdJ8IAck8iEiWp5jNcZDG19V2psh+mWAK4rdaUDkGOHOzCmwmX0T2j4DhRr6VwAIVwebps8BGeH5I6R4XS0WmyhFVGd6JUHfky+8Bhdd7thwFR7HrYByg9yBBHyYJTZTKeBEXKEs/b3cIIBNk6dmo6O24WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcpotpVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcpotpVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC451F000FF;
	Thu, 17 Sep 2026 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604370;
	bh=Z7K6df6VxUBHKa7wFWLwfzsdKofmgbOmdsyjpUe1kkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcpotpVn8dUp3b5cDqugwMwu3JTwV0XqSDPQqLrrw5WCEZ8Wf/I0DpZuRylGJp8al
	 VlVWqMm0dmp2Kz3nT9U9/wzyeN2Y9lNMjbOebb/9yNTMWtA4qf1Yp+yJtBGzRwMKdm
	 o0xGwOasufB902BYzH8KQLcxC4RgTdq3lf1k2dOtPlu689rFsSvFSZf87MbBJ624fz
	 b+grHthPmvtgGdXazhSDCo7GwFIVvPHn3roMnT8Eo+rsrq6y3eOEeRG/y67MXD9J9e
	 BnFa+ythKuWH07Xd37TA6cR27fY5hmkaz7m4ytENcx270g8IlFJL1sUcRWMfUBYbH7
	 NnUj76nz7x+SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] idpf: Fix kernel-doc descriptions to avoid warnings
Date: Wed, 16 Sep 2026 20:19:24 -0400
Message-ID: <20260917001927.3362053-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091647-strum-traverse-cb75@gregkh>
References: <2026091647-strum-traverse-cb75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 7fe9c81aa24a2374b1a9a2160d44f4afbf8ab80d ]

In many functions the Return section is missing. Fix kernel-doc
descriptions to address that and other warnings.

Before the change:

$ scripts/kernel-doc -none -Wreturn drivers/net/ethernet/intel/idpf/idpf_txrx.c 2>&1 | wc -l
85

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 7dd4c829bac2 ("idpf: disable DIM work before freeing q_vectors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 94 +++++++++++++--------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4a4e00c70d93e..bc12b30824b3a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -19,6 +19,8 @@ LIBETH_SQE_CHECK_PRIV(u32);
  * Make sure we don't exceed maximum scatter gather buffers for a single
  * packet.
  * TSO case has been handled earlier from idpf_features_check().
+ *
+ * Return: %true if skb exceeds max descriptors per packet, %false otherwise.
  */
 static bool idpf_chk_linearize(const struct sk_buff *skb,
 			       unsigned int max_bufs,
@@ -172,7 +174,7 @@ static void idpf_tx_desc_rel_all(struct idpf_vport *vport)
  * idpf_tx_buf_alloc_all - Allocate memory for all buffer resources
  * @tx_q: queue for which the buffers are allocated
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 {
@@ -196,7 +198,7 @@ static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
  * @vport: vport to allocate resources for
  * @tx_q: the tx ring to set up
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 			      struct idpf_tx_queue *tx_q)
@@ -297,7 +299,7 @@ static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
  * idpf_tx_desc_alloc_all - allocate all queues Tx resources
  * @vport: virtual port private structure
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 {
@@ -548,7 +550,7 @@ static void idpf_rx_buf_hw_update(struct idpf_buf_queue *bufq, u32 val)
  * idpf_rx_hdr_buf_alloc_all - Allocate memory for header buffers
  * @bufq: ring to use
  *
- * Returns 0 on success, negative on failure.
+ * Return: 0 on success, negative on failure.
  */
 static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 {
@@ -600,7 +602,7 @@ static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  * @bufq: buffer queue to post to
  * @buf_id: buffer id to post
  *
- * Returns false if buffer could not be allocated, true otherwise.
+ * Return: %false if buffer could not be allocated, %true otherwise.
  */
 static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 {
@@ -649,7 +651,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
  * @bufq: buffer queue to post working set to
  * @working_set: number of buffers to put in working set
  *
- * Returns true if @working_set bufs were posted successfully, false otherwise.
+ * Return: %true if @working_set bufs were posted successfully, %false otherwise.
  */
 static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
 				   u16 working_set)
@@ -718,7 +720,7 @@ static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
  * idpf_rx_buf_alloc_all - Allocate memory for all buffer resources
  * @rxbufq: queue for which the buffers are allocated
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_rx_buf_alloc_all(struct idpf_buf_queue *rxbufq)
 {
@@ -746,7 +748,7 @@ static int idpf_rx_buf_alloc_all(struct idpf_buf_queue *rxbufq)
  * @bufq: buffer queue to create page pool for
  * @type: type of Rx buffers to allocate
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 			     enum libeth_fqe_type type)
@@ -781,7 +783,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
  * idpf_rx_bufs_init_all - Initialize all RX bufs
  * @vport: virtual port struct
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 {
@@ -836,7 +838,7 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
  * @vport: vport to allocate resources for
  * @rxq: Rx queue for which the resources are setup
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_rx_desc_alloc(const struct idpf_vport *vport,
 			      struct idpf_rx_queue *rxq)
@@ -898,7 +900,7 @@ static int idpf_bufq_desc_alloc(const struct idpf_vport *vport,
  * idpf_rx_desc_alloc_all - allocate all RX queues resources
  * @vport: virtual port structure
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 {
@@ -1426,7 +1428,7 @@ void idpf_vport_queues_rel(struct idpf_vport *vport)
  * dereference the queue from queue groups.  This allows us to quickly pull a
  * txq based on a queue index.
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport)
 {
@@ -1559,7 +1561,7 @@ void idpf_vport_calc_num_q_desc(struct idpf_vport *vport)
  * @vport_msg: message to fill with data
  * @max_q: vport max queue info
  *
- * Return 0 on success, error value on failure.
+ * Return: 0 on success, error value on failure.
  */
 int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 			     struct virtchnl2_create_vport *vport_msg,
@@ -1694,7 +1696,7 @@ static void idpf_rxq_set_descids(const struct idpf_vport *vport,
  * @vport: vport to allocate txq groups for
  * @num_txq: number of txqs to allocate for each group
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 {
@@ -1786,7 +1788,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
  * @vport: vport to allocate rxq groups for
  * @num_rxq: number of rxqs to allocate for each group
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 {
@@ -1915,7 +1917,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
  * idpf_vport_queue_grp_alloc_all - Allocate all queue groups/resources
  * @vport: vport with qgrps to allocate
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 static int idpf_vport_queue_grp_alloc_all(struct idpf_vport *vport)
 {
@@ -1944,8 +1946,9 @@ static int idpf_vport_queue_grp_alloc_all(struct idpf_vport *vport)
  * idpf_vport_queues_alloc - Allocate memory for all queues
  * @vport: virtual port
  *
- * Allocate memory for queues associated with a vport.  Returns 0 on success,
- * negative on failure.
+ * Allocate memory for queues associated with a vport.
+ *
+ * Return: 0 on success, negative on failure.
  */
 int idpf_vport_queues_alloc(struct idpf_vport *vport)
 {
@@ -2172,7 +2175,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
  * @budget: Used to determine if we are in netpoll
  * @cleaned: returns number of packets cleaned
  *
- * Returns true if there's any budget left (e.g. the clean is finished)
+ * Return: %true if there's any budget left (e.g. the clean is finished)
  */
 static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 				 int *cleaned)
@@ -2398,7 +2401,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 }
 
 /**
- * idpf_tx_splitq_has_room - check if enough Tx splitq resources are available
+ * idpf_txq_has_room - check if enough Tx splitq resources are available
  * @tx_q: the queue to be checked
  * @descs_needed: number of descriptors required for this packet
  * @bufs_needed: number of Tx buffers required for this packet
@@ -2529,6 +2532,8 @@ unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
  * idpf_tx_splitq_bump_ntu - adjust NTU and generation
  * @txq: the tx ring to wrap
  * @ntu: ring index to bump
+ *
+ * Return: the next ring index hopping to 0 when wraps around
  */
 static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
 {
@@ -2797,7 +2802,7 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
  * @skb: pointer to skb
  * @off: pointer to struct that holds offload parameters
  *
- * Returns error (negative) if TSO was requested but cannot be applied to the
+ * Return: error (negative) if TSO was requested but cannot be applied to the
  * given skb, 0 if TSO does not apply to the given skb, or 1 otherwise.
  */
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
@@ -2875,6 +2880,8 @@ int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
  *
  * Since the TX buffer rings mimics the descriptor ring, update the tx buffer
  * ring entry to reflect that this index is a context descriptor
+ *
+ * Return: pointer to the next descriptor
  */
 static union idpf_flex_tx_ctx_desc *
 idpf_tx_splitq_get_ctx_desc(struct idpf_tx_queue *txq)
@@ -2893,6 +2900,8 @@ idpf_tx_splitq_get_ctx_desc(struct idpf_tx_queue *txq)
  * idpf_tx_drop_skb - free the SKB and bump tail if necessary
  * @tx_q: queue to send buffer on
  * @skb: pointer to skb
+ *
+ * Return: always NETDEV_TX_OK
  */
 netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb)
 {
@@ -2994,7 +3003,7 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
  * @skb: send buffer
  * @tx_q: queue to send buffer on
  *
- * Returns NETDEV_TX_OK if sent, else an error code
+ * Return: NETDEV_TX_OK if sent, else an error code
  */
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 					struct idpf_tx_queue *tx_q)
@@ -3117,7 +3126,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
  * @skb: send buffer
  * @netdev: network interface device structure
  *
- * Returns NETDEV_TX_OK if sent, else an error code
+ * Return: NETDEV_TX_OK if sent, else an error code
  */
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev)
 {
@@ -3267,10 +3276,10 @@ idpf_rx_splitq_extract_csum_bits(const struct virtchnl2_rx_flex_desc_adv_nic_3 *
  * @rx_desc: Receive descriptor
  * @decoded: Decoded Rx packet type related fields
  *
- * Return 0 on success and error code on failure
- *
  * Populate the skb fields with the total number of RSC segments, RSC payload
  * length and packet type.
+ *
+ * Return: 0 on success and error code on failure
  */
 static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		       const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
@@ -3368,6 +3377,8 @@ idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
  * This function checks the ring, descriptor, and packet information in
  * order to populate the hash, checksum, protocol, and
  * other fields within the skb.
+ *
+ * Return: 0 on success and error code on failure
  */
 static int
 __idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
@@ -3462,6 +3473,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
  * @stat_err_field: field from descriptor to test bits in
  * @stat_err_bits: value to mask
  *
+ * Return: %true if any of given @stat_err_bits are set, %false otherwise.
  */
 static bool idpf_rx_splitq_test_staterr(const u8 stat_err_field,
 					const u8 stat_err_bits)
@@ -3473,8 +3485,8 @@ static bool idpf_rx_splitq_test_staterr(const u8 stat_err_field,
  * idpf_rx_splitq_is_eop - process handling of EOP buffers
  * @rx_desc: Rx descriptor for current buffer
  *
- * If the buffer is an EOP buffer, this function exits returning true,
- * otherwise return false indicating that this is in fact a non-EOP buffer.
+ * Return: %true if the buffer is an EOP buffer, %false otherwise, indicating
+ * that this is in fact a non-EOP buffer.
  */
 static bool idpf_rx_splitq_is_eop(struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
@@ -3493,7 +3505,7 @@ static bool idpf_rx_splitq_is_eop(struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_de
  * expensive overhead for IOMMU access this provides a means of avoiding
  * it by maintaining the mapping of the page to the system.
  *
- * Returns amount of work completed
+ * Return: amount of work completed
  */
 static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 {
@@ -3623,7 +3635,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
  * @buf_id: buffer ID
  * @buf_desc: Buffer queue descriptor
  *
- * Return 0 on success and negative on failure.
+ * Return: 0 on success and negative on failure.
  */
 static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 				    struct virtchnl2_splitq_rx_buf_desc *buf_desc)
@@ -3750,6 +3762,7 @@ static void idpf_rx_clean_refillq_all(struct idpf_buf_queue *bufq, int nid)
  * @irq: interrupt number
  * @data: pointer to a q_vector
  *
+ * Return: always IRQ_HANDLED
  */
 static irqreturn_t idpf_vport_intr_clean_queues(int __always_unused irq,
 						void *data)
@@ -3871,6 +3884,8 @@ static void idpf_vport_intr_dis_irq_all(struct idpf_vport *vport)
 /**
  * idpf_vport_intr_buildreg_itr - Enable default interrupt generation settings
  * @q_vector: pointer to q_vector
+ *
+ * Return: value to be written back to HW to enable interrupt generation
  */
 static u32 idpf_vport_intr_buildreg_itr(struct idpf_q_vector *q_vector)
 {
@@ -4008,6 +4023,8 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 /**
  * idpf_vport_intr_req_irq - get MSI-X vectors from the OS for the vport
  * @vport: main vport structure
+ *
+ * Return: 0 on success, negative on failure
  */
 static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 {
@@ -4218,7 +4235,7 @@ static void idpf_vport_intr_napi_ena_all(struct idpf_vport *vport)
  * @budget: Used to determine if we are in netpoll
  * @cleaned: returns number of packets cleaned
  *
- * Returns false if clean is not complete else returns true
+ * Return: %false if clean is not complete else returns %true
  */
 static bool idpf_tx_splitq_clean_all(struct idpf_q_vector *q_vec,
 				     int budget, int *cleaned)
@@ -4245,7 +4262,7 @@ static bool idpf_tx_splitq_clean_all(struct idpf_q_vector *q_vec,
  * @budget: Used to determine if we are in netpoll
  * @cleaned: returns number of packets cleaned
  *
- * Returns false if clean is not complete else returns true
+ * Return: %false if clean is not complete else returns %true
  */
 static bool idpf_rx_splitq_clean_all(struct idpf_q_vector *q_vec, int budget,
 				     int *cleaned)
@@ -4288,6 +4305,8 @@ static bool idpf_rx_splitq_clean_all(struct idpf_q_vector *q_vec, int budget,
  * idpf_vport_splitq_napi_poll - NAPI handler
  * @napi: struct from which you get q_vector
  * @budget: budget provided by stack
+ *
+ * Return: how many packets were cleaned
  */
 static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 {
@@ -4436,7 +4455,9 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
  * idpf_vport_intr_init_vec_idx - Initialize the vector indexes
  * @vport: virtual port
  *
- * Initialize vector indexes with values returened over mailbox
+ * Initialize vector indexes with values returned over mailbox.
+ *
+ * Return: 0 on success, negative on failure
  */
 static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport)
 {
@@ -4502,8 +4523,9 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport)
  * idpf_vport_intr_alloc - Allocate memory for interrupt vectors
  * @vport: virtual port
  *
- * We allocate one q_vector per queue interrupt. If allocation fails we
- * return -ENOMEM.
+ * Allocate one q_vector per queue interrupt.
+ *
+ * Return: 0 on success, if allocation fails we return -ENOMEM.
  */
 int idpf_vport_intr_alloc(struct idpf_vport *vport)
 {
@@ -4590,7 +4612,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
  * idpf_vport_intr_init - Setup all vectors for the given vport
  * @vport: virtual port
  *
- * Returns 0 on success or negative on failure
+ * Return: 0 on success or negative on failure
  */
 int idpf_vport_intr_init(struct idpf_vport *vport)
 {
@@ -4629,7 +4651,7 @@ void idpf_vport_intr_ena(struct idpf_vport *vport)
  * idpf_config_rss - Send virtchnl messages to configure RSS
  * @vport: virtual port
  *
- * Return 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
 int idpf_config_rss(struct idpf_vport *vport)
 {
-- 
2.53.0

