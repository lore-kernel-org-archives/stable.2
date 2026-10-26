Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021404;
	b=N4tHBDhkTIWxX5oTBqtrVyHIDb2ZtuEkvPUlwYABDwFnZ6iwwhShmNR0yLPi7Mtqkh04
	 asAgdtzRt0Dv7PTF5ml7sV9ipU9QgBh7fHcVduraikjhUrCOFnzpYFsUYYRfZgCCbAQ/V
	 5Cxj3slaqjE2BWx9/+GQqvokzjrlopD+a4reOSJh+4R5fBf4iLnEdrlHVYDbl2y9FGzs0
	 iTOwWLqwoTAIX62qKiILzu7aixjXgTQgRM7/C2MG9fo8VSQ7l+SlLUSGC9vhW8G6WONJn
	 ABBtVc3fa6cJloDxXT9c7Zqwd4X3kzIWIMHwYnJW7XNG+CzAT5m+mk4DiyOpQJwJyZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021404;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
	b=n2C/Gupa2g/UoNLTr/+u3azK8mMBZxGklAdFiNSo8PCjzGDSIf8uR5LZM5vvLW+gg5Fc
	 k/FEjLN7nkPCHN71W3Q/UFBLC8KDo4SJKnF4OjK1OTnhbCW5OlC0hZPYEd+/1V6JGZxx6
	 j2YJrql7hZ56N86s/LmzSYnteXU2m/mBMOkltSr9QifL2CSUBRF/fbnsgiaOjYqZ47xaH
	 q5FfSAWsTpZvtfM+fW+NZP0/Ms2m2ECEhp8So0vYJ4oE1qleSoarWhUqZLNevRnwiCM8Z
	 ogUFAkOLsRCWG/DycwcZB7/+a28BBXepxF2GjqWmLraocUS5OoiwH63sfivS69BOqbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUPFHXye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F1606A330;
	Mon, 26 Oct 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUPFHXye
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793021403;
	b=NwUkvWlvlJAm8TWmWKWUM/qh3QRNleLj73VNVNDb6DH6/cnm/CFNMoPKuoqB20caJrPj
	 YVmGkIKnI8jKdhZPDR9IrmtffMQRsEkDbDCBYRUf3ioYThe0TR/NQE8rFPCH8/Xgj0+GJ
	 k/XDDBQ8m0F8uhy9uV85Pwd85jDwiud7FdUE8UBX9TWIDSq/kixUR83+WzqdINLoVZ+D5
	 9hA5qsEMMx5KGY8rTugvg4hYZld1iuF+t2+zx9CcTVMNWmF1t6hw56lPDXQF6uWlFJE/u
	 Iou89tmwWx5FF6HwQq6UDIZOSXSJKIy0t3Tefsmzg7n6ss4HbohvNZhjhJ2EaZKmJqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793021403;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
	b=Mlzew+tctid/wmKKmf4J+cCkS1mYH9PGbrh8m/60iAchn2VvF5JqrQqt4erYGBgUf1Ul
	 2uX+SZuLXJA28CflezpJC3MHpS7mI9X16wFMdV+3F3dXHmnlUsSpYtEa1FElZa6riAgvW
	 0efWRgm/7S1RUSZ113iATp9Ps9Bm9FA0akTIY/4CIPYXX5CPQzDneB89MI/sZF/XiSD2f
	 J75SErFrQFxtvXN4lfbV7ob8aI2bgu0WfxHq/haVF2fz1zEzRHfsrQbUWnspeMcJv3mnc
	 oWLqLy17wI4nsuYL4th9Mdd9yI7IbzaoRisPw6/CMLH8G3MEBX+QL1veswVvCGRApwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C56021F031E3;
	Mon, 26 Oct 2026 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021403;
	bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OUPFHXye7iehfypmUCTdy3xAShReDaspmIhFKKDG7G1WpzWIEdKfb0MtLttGmwhX3
	 4wxkmD/KayWRqTbvsxjP3UB6r7YED/jZjyN+riGTbVkGuqcMVPeEm7SMe0Li84/u3Z
	 P0+HokofsHnw9pw1TzRYFIKXF/lADrQh0OhY+gdALDHRDNqA08MtjUgaWt6zKUVvWE
	 x+p+Le3ZEMMPP4x9mrkHgxc1gUxLqNWr131MIOXwOEUDRW99n2p/wt8nfE6vuUP1qS
	 xF5su2ilmouANk/XuB2lyPxHul9C+vKYooNnk/Ec04RgzckKajAKk376sQdO2W3tp/
	 K3CZmZN0J06Dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A11544D1D;
	Mon, 26 Oct 2026 13:30:00 +0000 (UTC)
From: Vincent Choiniere via B4 Relay <devnull+choiniere.vincent.hydroquebec.com@kernel.org>
Date: Mon, 26 Oct 2026 09:30:00 -0400
Subject: [PATCH net v2] ice: fix Tx hang dump using stale tx_buf[0].skb
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
X-B4-Tracking: v=1; b=H4sIANdV32oC/3WNwQ6CMBBEf4Xs2TW0QBVO/ofhAO0iawLFthAI4
 d8FPHucmTczK3hyTB6KaAVHE3u2/S7kJQLdVv2LkM2uQcZSiVgoZE0YZjwyNGM3IKWqTsmk98Q
 o2GuDo4bnc/IJPQUof6Yf6zfpcIwdWMs+WLecx5M44f8fk0CBiWniJstveZWJR7sYZz8j1aSv2
 nZQbtv2BSpF3KnNAAAA
X-Change-ID: 20261016-ice-tx-hang-dump-e46b4ed483d6
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Vincent Choiniere <choiniere.vincent@hydroquebec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793021400; l=12328;
 i=choiniere.vincent@hydroquebec.com; s=20261016;
 h=from:subject:message-id;
 bh=I7GEHSOCewXkNOi9K97E16dk0vuMi2DEXOuTLKY6QgQ=;
 b=5DIjrp3LvUGrWXTnHDk10SqGvffs7ztbkvNi/EHheO70a/aSX2gabthGubzjoyT2XTYVDvK0A
 5quIkv6iadMC2lqQ97SyIDiInQbqC6sZ3NfuowgnlUDDbh60oVuBEXX
X-Developer-Key: i=choiniere.vincent@hydroquebec.com; a=ed25519;
 pk=MctQE067DucsZOaNqb+sjY7aQ+urhztuURanagEW3+8=
X-Endpoint-Received: by B4 Relay for
 choiniere.vincent@hydroquebec.com/20261016 with auth_id=1210
X-Original-From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Reply-To: choiniere.vincent@hydroquebec.com
Content-Transfer-Encoding: 7bit

From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>

ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
regardless of next_to_clean. The Tx cleanup path frees the skb and
marks the buffer empty without clearing the skb pointer, so slot 0 can
hold a stale pointer. A NULL check alone does not cover this, and
devlink_fmsg_dump_skb() can fault on the freed skb.

Using tx_buf[next_to_clean] alone does not fix the lifetime issues.
The dump runs from the service task without synchronization with Tx
cleanup or ring replacement:

- ice_clean_tx_irq() can free the skb at next_to_clean while the
  report is being prepared. It calls napi_consume_skb() before
  marking the buffer empty.
- The ring saved by ice_tx_timeout() can be replaced or freed before
  the service task runs. ethtool -G replaces the ring contents and
  frees tx_buf and desc, while ethtool -L can free whole rings.

Record the queue index, next_to_clean and next_to_use at timeout time.
Before reporting, take RTNL and check that the saved ring is still
one of the PF VSI Tx rings and that the VSI is up. Copy the
descriptors and IRQ name while the ring storage is protected against
replacement. If the ring cannot be used or the copy cannot be made,
report only the values recorded at timeout time.

Tx cleanup can still run while the ring state is copied, so do not
dereference the skb. Retain only its pointer value in the dump and
remove the skb contents.

Release RTNL before calling devlink_health_report(), which takes the
devlink instance lock. Build the dump from the copied data and free
the descriptor copy after reporting.

Observed on an E810 PF passed through to a KVM guest with Ubuntu
kernel 7.0.0-14 (PREEMPT_RT and a local scheduler patch): a delayed
queue IRQ led to a Tx timeout and a page fault in
devlink_fmsg_dump_skb():

 BUG: unable to handle page fault for address: 0000000004cd0c11
 Workqueue: ice ice_service_task [ice]
 RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
 Call Trace:
  ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
  devlink_health_do_dump+0xcc/0x190
  devlink_health_report+0x1d7/0x260
  ice_report_tx_hang+0x7d/0xa0 [ice]

Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
---
Changes in v2:
- Validate the saved ring under RTNL before dereferencing it from
  the service task, and restrict snapshots to the PF VSI while it
  is up (Sashiko).
- Check next_to_clean against count before indexing tx_buf, and
  copy the descriptors and IRQ name while ring replacement is
  excluded (Sashiko).
- Stop dereferencing the skb and remove its contents from the dump.
  Keep only its pointer value (Sashiko).
- Release RTNL before reporting to preserve the devlink instance
  lock ordering.
- Record the queue index and ring indices at timeout time as a
  fallback when a snapshot cannot be made.
- Drop Paul's Reviewed-by because the patch changed substantially.

v1:
https://lore.kernel.org/netdev/20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com/

Testing:
- Built ice.ko with x86_64 defconfig, CONFIG_ICE=m, GCC 12.2 and W=1.
  Ran sparse with C=2 (sparse git c464045). Neither reported warnings
  in the changed files.
- checkpatch --strict reported only an unknown Fixes commit because
  the local tree is a shallow clone.
- Runtime testing used an E810 PF passed through to a KVM guest with
  Ubuntu kernel 7.0.0-38 (PREEMPT_RT), KASAN, PROVE_LOCKING and
  DEBUG_ATOMIC_SLEEP.
- Forced Tx timeouts by starving one queue's IRQ thread. The watchdog
  fired after five seconds, the PF recovered, and the dump retained
  the v1 fields except for the skb contents.
- Used a test-only kernel patch to insert configurable delays before
  ice_report_tx_hang() or the dump callback. Racing ethtool commands
  were started when the instrumentation logged the delay.
- With v1 and the same instrumentation, shrinking the ring with
  ethtool -G tx 64 while next_to_clean was above 64 triggered a KASAN
  slab-out-of-bounds report. This was also reproduced on a non-RT
  kernel built from net. Racing ethtool -L combined 1 triggered a
  use-after-free followed by a general protection fault.
- With v2, ran 168 forced Tx timeouts, including 149 with concurrent
  ethtool -G (tx 64, 128 or 512) or ethtool -L combined 1, before and
  after the ring state was copied. No KASAN, lockdep or
  sleeping-in-atomic reports were observed. When the saved ring was
  no longer present, the dump contained only the timeout-time values.

Limitations:
- The same stress testing was not completed on a non-RT kernel,
  where Tx timeouts could not be forced reliably.
- Subfunction VSIs and XDP were not tested. Subfunction VSI rings
  are excluded from the snapshot because ice_sf_dev_remove() frees
  them without RTNL.
- This patch does not synchronize publication and consumption of
  tx_hang_buf between ice_tx_timeout() and the service task. A newer
  timeout may still be dropped or its fields mixed with an older
  event.

The original devlink_fmsg_dump_skb() crash was reproduced on Ubuntu
kernel 7.0.0-14 with PREEMPT_RT and a local scheduler patch. The
additional race reproductions above used test-only instrumentation.
The affected reporter code is also present in upstream net at
191aa4154.
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 117 ++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/devlink/health.h |   6 ++
 2 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 8e9a8a817..b9493ab47 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -382,7 +382,13 @@ struct ice_tx_hang_event {
 	u16 queue;
 	u16 next_to_clean;
 	u16 next_to_use;
-	struct ice_tx_ring *tx_ring;
+	/* the fields below are only valid if @desc is set */
+	char irq_name[ICE_INT_NAME_STR_LEN];
+	void *desc_ptr;
+	dma_addr_t dma;
+	void *desc;
+	u32 desc_size;
+	void *skb_ptr;	/* pointer value only, never dereferenced */
 };
 
 static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
@@ -390,12 +396,10 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_tx_hang_event *event = priv_ctx;
-	struct sk_buff *skb;
 
 	if (!event)
 		return 0;
 
-	skb = event->tx_ring->tx_buf->skb;
 	devlink_fmsg_obj_nest_start(fmsg);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
@@ -403,13 +407,14 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
-	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
-	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
-	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
-	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
-	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
-				     event->tx_ring->count * sizeof(struct ice_tx_desc));
-	devlink_fmsg_dump_skb(fmsg, skb);
+	if (event->desc) {
+		devlink_fmsg_put(fmsg, "irq-mapping", event->irq_name);
+		ice_fmsg_put_ptr(fmsg, "desc-ptr", event->desc_ptr);
+		ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->dma);
+		ice_fmsg_put_ptr(fmsg, "skb-ptr", event->skb_ptr);
+		devlink_fmsg_binary_pair_put(fmsg, "desc", event->desc,
+					     event->desc_size);
+	}
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
@@ -424,24 +429,104 @@ void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
 	buf->vsi_num = vsi_num;
 	buf->head = head;
 	buf->intr = intr;
+	buf->queue = tx_ring->q_index;
+	buf->next_to_clean = tx_ring->next_to_clean;
+	buf->next_to_use = tx_ring->next_to_use;
+}
+
+/**
+ * ice_tx_hang_snapshot - copy the hung Tx ring state for the dump
+ * @pf: PF on which the Tx hang was detected
+ * @tx_ring: ring saved by ice_tx_timeout(), possibly stale
+ * @ev: event to fill in
+ *
+ * The saved ring may have been freed or replaced since the timeout (e.g. by
+ * ethtool -G or -L). Use it only if it is still one of the PF VSI Tx rings
+ * and the VSI is up: those rings are only replaced or freed under RTNL or
+ * from the service task, so with RTNL held every access below is to live
+ * memory. ice_clean_tx_irq() may still run and free the skb at
+ * next_to_clean at any time, so only the pointer value is recorded and the
+ * skb itself is never dereferenced.
+ */
+static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
+				 struct ice_tx_hang_event *ev)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_q_vector *q_vector;
+	struct ice_tx_buf *tx_buf;
+	unsigned int i;
+	u16 ntc, ntu;
+	void *desc;
+	u32 size;
+
+	ASSERT_RTNL();
+
+	if (!tx_ring || !vsi || !vsi->tx_rings ||
+	    test_bit(ICE_VSI_DOWN, vsi->state))
+		return;
+
+	ice_for_each_txq(vsi, i)
+		if (vsi->tx_rings[i] == tx_ring)
+			break;
+	if (i == vsi->num_txq)
+		return;
+
+	q_vector = tx_ring->q_vector;
+	if (!q_vector || !tx_ring->desc || !tx_ring->tx_buf || !tx_ring->count)
+		return;
+
+	size = tx_ring->count * sizeof(struct ice_tx_desc);
+	desc = kvmalloc(size, GFP_KERNEL);
+	if (!desc)
+		return;
+
+	ntc = READ_ONCE(tx_ring->next_to_clean);
+	ntu = READ_ONCE(tx_ring->next_to_use);
+
+	if (ntc < tx_ring->count) {
+		tx_buf = &tx_ring->tx_buf[ntc];
+		if (tx_buf->type == ICE_TX_BUF_SKB)
+			ev->skb_ptr = READ_ONCE(tx_buf->skb);
+
+		memcpy(desc, tx_ring->desc, size);
+		ev->next_to_clean = ntc;
+		ev->next_to_use = ntu;
+		strscpy(ev->irq_name, q_vector->name);
+		ev->desc_ptr = tx_ring->desc;
+		ev->dma = tx_ring->dma;
+		ev->desc_size = size;
+		ev->desc = desc;
+	}
+
+	if (!ev->desc)
+		kvfree(desc);
 }
 
 void ice_report_tx_hang(struct ice_pf *pf)
 {
 	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
-	struct ice_tx_ring *tx_ring = buf->tx_ring;
-
 	struct ice_tx_hang_event ev = {
 		.head = buf->head,
 		.intr = buf->intr,
 		.vsi_num = buf->vsi_num,
-		.queue = tx_ring->q_index,
-		.next_to_clean = tx_ring->next_to_clean,
-		.next_to_use = tx_ring->next_to_use,
-		.tx_ring = tx_ring,
+		.queue = buf->queue,
+		.next_to_clean = buf->next_to_clean,
+		.next_to_use = buf->next_to_use,
 	};
 
+	if (!pf->health_reporters.tx_hang)
+		return;
+
+	rtnl_lock();
+	ice_tx_hang_snapshot(pf, buf->tx_ring, &ev);
+	rtnl_unlock();
+
+	/* devlink_health_report() takes the devlink instance lock, which nests
+	 * outside RTNL, so only report once RTNL has been released.
+	 */
 	ice_devlink_health_report(pf->health_reporters.tx_hang, "Tx hang", &ev);
+
+	kvfree(ev.desc);
 }
 
 static struct devlink_health_reporter *
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
index 5edfc4d2a..508e4115d 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.h
+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
@@ -37,6 +37,9 @@ enum ice_mdd_src {
  * @head: descriptor head
  * @intr: interrupt register value
  * @vsi_num: VSI owning the queue that the hang occurred on
+ * @queue: index of the queue that the hang occurred on
+ * @next_to_clean: next_to_clean of the ring when the hang was detected
+ * @next_to_use: next_to_use of the ring when the hang was detected
  * @fw_status: buffer for last received FW Status event
  * @port_status: buffer for last received Port Status event
  */
@@ -50,6 +53,9 @@ struct ice_health {
 		u32 head;
 		u32 intr;
 		u16 vsi_num;
+		u16 queue;
+		u16 next_to_clean;
+		u16 next_to_use;
 	);
 	struct ice_aqc_health_status_elem fw_status;
 	struct ice_aqc_health_status_elem port_status;

---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261016-ice-tx-hang-dump-e46b4ed483d6


