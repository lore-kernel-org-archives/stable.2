Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CE1ACEDE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244809; cv=none; b=dQJWcAz/KxoTazN84o6eFyQnfxMXSsrvYFCA4kF7/g610kDG2pmh6dPZKfK4GPl6OkXVzvUGvk53CK50MVj6PDout3YzeGLmOGR2jWYPubjanJtL7vEpzRz4ylA3RrwvJVHbTjW7QlDpi4s1RUz7ibZTzDbnw5rhIZdqFQmRp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244809; c=relaxed/simple;
	bh=wQ155pLWM+BtVF4hfOnxLRwmZ0XxDT1yXlTSXvqPw7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmeReToRZb7P5oLG5X5MiZMr6YuxpbpjnN7QifQyENUS6zaqEiG/VPcraTkdzCg0UZF6VEPLWWOZ/CfZPV1udySVj3OrE0BJH+FGRFfL7gm9GhviMm88LeeYjLkEJF0SvJFXFITcPY4qUcBCJ4nv34jLSdbYVGTBI4dDERddG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1VLCt+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1VLCt+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA6D1F000E9;
	Tue, 28 Jul 2026 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244807;
	bh=jtWZFOpvzrcporoHhVDR7qSuftSHnh18xtH7LYDKrpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1VLCt+0pBqH/Trx+fB1FkQbDqc0N9+WbURMSjMrWl5Ry1nzKl3a1hk+i2vU8BYdP
	 1PwN7KlEK83a1uwrcASyRmjUqBAKV5N9lGx3m6MJU6FLW7KfhX2g8BXiDLj/KTeDFC
	 4BbT3J6J4s7Im0OFUCT/mptAGL7xp6hnLrV4VFGmZ1IdzLTapXuQatImJ9JwOWYKEb
	 hbKTKneKs4smQt/E/xK6RdygR5qqyO6lgIePmsVQdhSnjxT5WI0pzK4UpiZeidoRYn
	 XoI4bVzaIdQVQ3YmQcr8N6DZ/Zx7GGNtEBViw0FZKNzBP3ekZ3LzXxAPfoQ5k1xgAX
	 aPL6cZ+x9lzzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] gve: move DQO rx buffer management related code to a new file
Date: Tue, 28 Jul 2026 09:20:03 -0400
Message-ID: <20260728132004.3954154-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072027-feline-deserving-7fc7@gregkh>
References: <2026072027-feline-deserving-7fc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshitha Ramamurthy <hramamurthy@google.com>

[ Upstream commit 93c68f1275f9e21ccfed9ee292aedb11c3f6241b ]

In preparation for the upcoming page pool adoption for DQO
raw addressing mode, move RX buffer management code to a new
file. In the follow on patches, page pool code will be added
to this file.

No functional change, just movement of code.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20241014202108.1051963-2-pkaligineedi@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d676c9a73bdc ("gve: fix header buffer corruption with header-split and HW-GRO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/Makefile      |   3 +-
 drivers/net/ethernet/google/gve/gve.h         |  18 ++
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 230 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 225 -----------------
 4 files changed, 250 insertions(+), 226 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c

diff --git a/drivers/net/ethernet/google/gve/Makefile b/drivers/net/ethernet/google/gve/Makefile
index 9ed07080b38a25..4520f1c07a638f 100644
--- a/drivers/net/ethernet/google/gve/Makefile
+++ b/drivers/net/ethernet/google/gve/Makefile
@@ -1,4 +1,5 @@
 # Makefile for the Google virtual Ethernet (gve) driver
 
 obj-$(CONFIG_GVE) += gve.o
-gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o
+gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o \
+	    gve_buffer_mgmt_dqo.o
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8ddd366d9fde54..99fd933a1f30d4 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1173,6 +1173,24 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
 u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
 bool gve_header_split_supported(const struct gve_priv *priv);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
+/* rx buffer handling */
+int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs);
+void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
+		       bool free_page);
+struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx);
+bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
+				struct gve_rx_buf_state_dqo *buf_state);
+void gve_free_buf_state(struct gve_rx_ring *rx,
+			struct gve_rx_buf_state_dqo *buf_state);
+struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
+						   struct gve_index_list *list);
+void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
+			   struct gve_rx_buf_state_dqo *buf_state);
+struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx);
+int gve_alloc_page_dqo(struct gve_rx_ring *rx,
+		       struct gve_rx_buf_state_dqo *buf_state);
+void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
+			 struct gve_rx_buf_state_dqo *buf_state);
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
new file mode 100644
index 00000000000000..8e50f0e4bb2ecb
--- /dev/null
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Google virtual Ethernet (gve) driver
+ *
+ * Copyright (C) 2015-2024 Google, Inc.
+ */
+
+#include "gve.h"
+#include "gve_utils.h"
+
+int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
+{
+	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
+}
+
+void gve_free_page_dqo(struct gve_priv *priv, struct gve_rx_buf_state_dqo *bs,
+		       bool free_page)
+{
+	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
+	if (free_page)
+		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
+			      DMA_FROM_DEVICE);
+	bs->page_info.page = NULL;
+}
+
+struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+	s16 buffer_id;
+
+	buffer_id = rx->dqo.free_buf_states;
+	if (unlikely(buffer_id == -1))
+		return NULL;
+
+	buf_state = &rx->dqo.buf_states[buffer_id];
+
+	/* Remove buf_state from free list */
+	rx->dqo.free_buf_states = buf_state->next;
+
+	/* Point buf_state to itself to mark it as allocated */
+	buf_state->next = buffer_id;
+
+	return buf_state;
+}
+
+bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
+				struct gve_rx_buf_state_dqo *buf_state)
+{
+	s16 buffer_id = buf_state - rx->dqo.buf_states;
+
+	return buf_state->next == buffer_id;
+}
+
+void gve_free_buf_state(struct gve_rx_ring *rx,
+			struct gve_rx_buf_state_dqo *buf_state)
+{
+	s16 buffer_id = buf_state - rx->dqo.buf_states;
+
+	buf_state->next = rx->dqo.free_buf_states;
+	rx->dqo.free_buf_states = buffer_id;
+}
+
+struct gve_rx_buf_state_dqo *gve_dequeue_buf_state(struct gve_rx_ring *rx,
+						   struct gve_index_list *list)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+	s16 buffer_id;
+
+	buffer_id = list->head;
+	if (unlikely(buffer_id == -1))
+		return NULL;
+
+	buf_state = &rx->dqo.buf_states[buffer_id];
+
+	/* Remove buf_state from list */
+	list->head = buf_state->next;
+	if (buf_state->next == -1)
+		list->tail = -1;
+
+	/* Point buf_state to itself to mark it as allocated */
+	buf_state->next = buffer_id;
+
+	return buf_state;
+}
+
+void gve_enqueue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list,
+			   struct gve_rx_buf_state_dqo *buf_state)
+{
+	s16 buffer_id = buf_state - rx->dqo.buf_states;
+
+	buf_state->next = -1;
+
+	if (list->head == -1) {
+		list->head = buffer_id;
+		list->tail = buffer_id;
+	} else {
+		int tail = list->tail;
+
+		rx->dqo.buf_states[tail].next = buffer_id;
+		list->tail = buffer_id;
+	}
+}
+
+struct gve_rx_buf_state_dqo *gve_get_recycled_buf_state(struct gve_rx_ring *rx)
+{
+	struct gve_rx_buf_state_dqo *buf_state;
+	int i;
+
+	/* Recycled buf states are immediately usable. */
+	buf_state = gve_dequeue_buf_state(rx, &rx->dqo.recycled_buf_states);
+	if (likely(buf_state))
+		return buf_state;
+
+	if (unlikely(rx->dqo.used_buf_states.head == -1))
+		return NULL;
+
+	/* Used buf states are only usable when ref count reaches 0, which means
+	 * no SKBs refer to them.
+	 *
+	 * Search a limited number before giving up.
+	 */
+	for (i = 0; i < 5; i++) {
+		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
+		if (gve_buf_ref_cnt(buf_state) == 0) {
+			rx->dqo.used_buf_states_cnt--;
+			return buf_state;
+		}
+
+		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
+	}
+
+	/* For QPL, we cannot allocate any new buffers and must
+	 * wait for the existing ones to be available.
+	 */
+	if (rx->dqo.qpl)
+		return NULL;
+
+	/* If there are no free buf states discard an entry from
+	 * `used_buf_states` so it can be used.
+	 */
+	if (unlikely(rx->dqo.free_buf_states == -1)) {
+		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
+		if (gve_buf_ref_cnt(buf_state) == 0)
+			return buf_state;
+
+		gve_free_page_dqo(rx->gve, buf_state, true);
+		gve_free_buf_state(rx, buf_state);
+	}
+
+	return NULL;
+}
+
+int gve_alloc_page_dqo(struct gve_rx_ring *rx,
+		       struct gve_rx_buf_state_dqo *buf_state)
+{
+	struct gve_priv *priv = rx->gve;
+	u32 idx;
+
+	if (!rx->dqo.qpl) {
+		int err;
+
+		err = gve_alloc_page(priv, &priv->pdev->dev,
+				     &buf_state->page_info.page,
+				     &buf_state->addr,
+				     DMA_FROM_DEVICE, GFP_ATOMIC);
+		if (err)
+			return err;
+	} else {
+		idx = rx->dqo.next_qpl_page_idx;
+		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
+			net_err_ratelimited("%s: Out of QPL pages\n",
+					    priv->dev->name);
+			return -ENOMEM;
+		}
+		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
+		buf_state->addr = rx->dqo.qpl->page_buses[idx];
+		rx->dqo.next_qpl_page_idx++;
+	}
+	buf_state->page_info.page_offset = 0;
+	buf_state->page_info.page_address =
+		page_address(buf_state->page_info.page);
+	buf_state->last_single_ref_offset = 0;
+
+	/* The page already has 1 ref. */
+	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
+	buf_state->page_info.pagecnt_bias = INT_MAX;
+
+	return 0;
+}
+
+void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
+			 struct gve_rx_buf_state_dqo *buf_state)
+{
+	const u16 data_buffer_size = priv->data_buffer_size_dqo;
+	int pagecount;
+
+	/* Can't reuse if we only fit one buffer per page */
+	if (data_buffer_size * 2 > PAGE_SIZE)
+		goto mark_used;
+
+	pagecount = gve_buf_ref_cnt(buf_state);
+
+	/* Record the offset when we have a single remaining reference.
+	 *
+	 * When this happens, we know all of the other offsets of the page are
+	 * usable.
+	 */
+	if (pagecount == 1) {
+		buf_state->last_single_ref_offset =
+			buf_state->page_info.page_offset;
+	}
+
+	/* Use the next buffer sized chunk in the page. */
+	buf_state->page_info.page_offset += data_buffer_size;
+	buf_state->page_info.page_offset &= (PAGE_SIZE - 1);
+
+	/* If we wrap around to the same offset without ever dropping to 1
+	 * reference, then we don't know if this offset was ever freed.
+	 */
+	if (buf_state->page_info.page_offset ==
+	    buf_state->last_single_ref_offset) {
+		goto mark_used;
+	}
+
+	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	return;
+
+mark_used:
+	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
+	rx->dqo.used_buf_states_cnt++;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 1154c1d8f66f05..b343be2fb118ad 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -16,189 +16,6 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 
-static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
-{
-	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
-}
-
-static void gve_free_page_dqo(struct gve_priv *priv,
-			      struct gve_rx_buf_state_dqo *bs,
-			      bool free_page)
-{
-	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
-	if (free_page)
-		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
-			      DMA_FROM_DEVICE);
-	bs->page_info.page = NULL;
-}
-
-static struct gve_rx_buf_state_dqo *gve_alloc_buf_state(struct gve_rx_ring *rx)
-{
-	struct gve_rx_buf_state_dqo *buf_state;
-	s16 buffer_id;
-
-	buffer_id = rx->dqo.free_buf_states;
-	if (unlikely(buffer_id == -1))
-		return NULL;
-
-	buf_state = &rx->dqo.buf_states[buffer_id];
-
-	/* Remove buf_state from free list */
-	rx->dqo.free_buf_states = buf_state->next;
-
-	/* Point buf_state to itself to mark it as allocated */
-	buf_state->next = buffer_id;
-
-	return buf_state;
-}
-
-static bool gve_buf_state_is_allocated(struct gve_rx_ring *rx,
-				       struct gve_rx_buf_state_dqo *buf_state)
-{
-	s16 buffer_id = buf_state - rx->dqo.buf_states;
-
-	return buf_state->next == buffer_id;
-}
-
-static void gve_free_buf_state(struct gve_rx_ring *rx,
-			       struct gve_rx_buf_state_dqo *buf_state)
-{
-	s16 buffer_id = buf_state - rx->dqo.buf_states;
-
-	buf_state->next = rx->dqo.free_buf_states;
-	rx->dqo.free_buf_states = buffer_id;
-}
-
-static struct gve_rx_buf_state_dqo *
-gve_dequeue_buf_state(struct gve_rx_ring *rx, struct gve_index_list *list)
-{
-	struct gve_rx_buf_state_dqo *buf_state;
-	s16 buffer_id;
-
-	buffer_id = list->head;
-	if (unlikely(buffer_id == -1))
-		return NULL;
-
-	buf_state = &rx->dqo.buf_states[buffer_id];
-
-	/* Remove buf_state from list */
-	list->head = buf_state->next;
-	if (buf_state->next == -1)
-		list->tail = -1;
-
-	/* Point buf_state to itself to mark it as allocated */
-	buf_state->next = buffer_id;
-
-	return buf_state;
-}
-
-static void gve_enqueue_buf_state(struct gve_rx_ring *rx,
-				  struct gve_index_list *list,
-				  struct gve_rx_buf_state_dqo *buf_state)
-{
-	s16 buffer_id = buf_state - rx->dqo.buf_states;
-
-	buf_state->next = -1;
-
-	if (list->head == -1) {
-		list->head = buffer_id;
-		list->tail = buffer_id;
-	} else {
-		int tail = list->tail;
-
-		rx->dqo.buf_states[tail].next = buffer_id;
-		list->tail = buffer_id;
-	}
-}
-
-static struct gve_rx_buf_state_dqo *
-gve_get_recycled_buf_state(struct gve_rx_ring *rx)
-{
-	struct gve_rx_buf_state_dqo *buf_state;
-	int i;
-
-	/* Recycled buf states are immediately usable. */
-	buf_state = gve_dequeue_buf_state(rx, &rx->dqo.recycled_buf_states);
-	if (likely(buf_state))
-		return buf_state;
-
-	if (unlikely(rx->dqo.used_buf_states.head == -1))
-		return NULL;
-
-	/* Used buf states are only usable when ref count reaches 0, which means
-	 * no SKBs refer to them.
-	 *
-	 * Search a limited number before giving up.
-	 */
-	for (i = 0; i < 5; i++) {
-		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
-		if (gve_buf_ref_cnt(buf_state) == 0) {
-			rx->dqo.used_buf_states_cnt--;
-			return buf_state;
-		}
-
-		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
-	}
-
-	/* For QPL, we cannot allocate any new buffers and must
-	 * wait for the existing ones to be available.
-	 */
-	if (rx->dqo.qpl)
-		return NULL;
-
-	/* If there are no free buf states discard an entry from
-	 * `used_buf_states` so it can be used.
-	 */
-	if (unlikely(rx->dqo.free_buf_states == -1)) {
-		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
-		if (gve_buf_ref_cnt(buf_state) == 0)
-			return buf_state;
-
-		gve_free_page_dqo(rx->gve, buf_state, true);
-		gve_free_buf_state(rx, buf_state);
-	}
-
-	return NULL;
-}
-
-static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
-			      struct gve_rx_buf_state_dqo *buf_state)
-{
-	struct gve_priv *priv = rx->gve;
-	u32 idx;
-
-	if (!rx->dqo.qpl) {
-		int err;
-
-		err = gve_alloc_page(priv, &priv->pdev->dev,
-				     &buf_state->page_info.page,
-				     &buf_state->addr,
-				     DMA_FROM_DEVICE, GFP_ATOMIC);
-		if (err)
-			return err;
-	} else {
-		idx = rx->dqo.next_qpl_page_idx;
-		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
-			net_err_ratelimited("%s: Out of QPL pages\n",
-					    priv->dev->name);
-			return -ENOMEM;
-		}
-		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
-		buf_state->addr = rx->dqo.qpl->page_buses[idx];
-		rx->dqo.next_qpl_page_idx++;
-	}
-	buf_state->page_info.page_offset = 0;
-	buf_state->page_info.page_address =
-		page_address(buf_state->page_info.page);
-	buf_state->last_single_ref_offset = 0;
-
-	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
-
-	return 0;
-}
-
 static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 {
 	struct device *hdev = &priv->pdev->dev;
@@ -557,48 +374,6 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 	rx->fill_cnt += num_posted;
 }
 
-static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
-				struct gve_rx_buf_state_dqo *buf_state)
-{
-	const u16 data_buffer_size = priv->data_buffer_size_dqo;
-	int pagecount;
-
-	/* Can't reuse if we only fit one buffer per page */
-	if (data_buffer_size * 2 > PAGE_SIZE)
-		goto mark_used;
-
-	pagecount = gve_buf_ref_cnt(buf_state);
-
-	/* Record the offset when we have a single remaining reference.
-	 *
-	 * When this happens, we know all of the other offsets of the page are
-	 * usable.
-	 */
-	if (pagecount == 1) {
-		buf_state->last_single_ref_offset =
-			buf_state->page_info.page_offset;
-	}
-
-	/* Use the next buffer sized chunk in the page. */
-	buf_state->page_info.page_offset += data_buffer_size;
-	buf_state->page_info.page_offset &= (PAGE_SIZE - 1);
-
-	/* If we wrap around to the same offset without ever dropping to 1
-	 * reference, then we don't know if this offset was ever freed.
-	 */
-	if (buf_state->page_info.page_offset ==
-	    buf_state->last_single_ref_offset) {
-		goto mark_used;
-	}
-
-	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
-	return;
-
-mark_used:
-	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
-	rx->dqo.used_buf_states_cnt++;
-}
-
 static void gve_rx_skb_csum(struct sk_buff *skb,
 			    const struct gve_rx_compl_desc_dqo *desc,
 			    struct gve_ptype ptype)
-- 
2.53.0

