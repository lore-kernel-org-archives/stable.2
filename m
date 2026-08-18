Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BE1F94F
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097144; cv=none; b=UCN6jx7DUsMz6OwbL5nSomvaWVHJVMxGxfJPv+bRm2/eZz6tcH6bMw8MJHoyFEh3yrZnF1y5CuZQv7bw+s0iuRc31sZaFjvZ/ArzjVlY1hoOhbzr7aiZVcrZHKh2SOHUxWcJ6ZAvJHu3EomaC/ct3fNj70BQ5vLRuOgAYagO1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097144; c=relaxed/simple;
	bh=8r8QO+4ER2+//xLMw+ASVsCY+J5pLhvzRmo3gmqz4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4rcLX7k+U3kHsTrNSTSXXQM5bZGczQ6Oq/CiTdMT5nvbo7vFpQ23rmwSqcna5hEcMJ6j24QrX94oLxRQ9ps1DIBeriVDleex5aAEdBNWGaYmNGqWEJOKYJqONsPIXfZKuLTXp1bbMWoSn6NFJIFjdI3p/a1W/3nSzi4cv4CtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=sPGhZ19D; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="sPGhZ19D"
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A37DD3F8AE
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787097139;
	bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=sPGhZ19DNehk4sN7j6QStNApcUs2M+eeNLDnT1Iuvp9wE1h/BQ6CLT3/dShutSUJ5
	 wVoYnwObqZ0TVc4a8JdjIXtjcIbuxfxxmjICTko9r7GP/gQgifyKH2yXnkYDR2WIPL
	 +R/hKP91KSZPSRLYNQdeyvDdkevLUe9iMoUDqddJwyTndiVuy34Ppk6j2gjKJJH/3s
	 PhhS4UR/3Iio50rrsv7YgBkWuTF4gu1r2PvBIX1QMgrMZMtgVmSFf/THTKSAqx2D/b
	 kyVuspUj8azhGzwddsX+g09nHbpC8nwx2C/gwSwaYslQSclR0Jigaxtv1ps/4GvsUc
	 VmC83SmF8IDJoftyU8m5KEUvYP61ZWVHETtr/nWX9N8+GLWbZ7xFCh9axlXsRxHk5w
	 xUgejcN5VvXg0qQyWfchfkNK4fahqKnfncZ8M+xomVG79idCasRPTkuW6oGjpdU5ES
	 dLjeDCixztNFqMQJhkk2zmFSH2mHqiC6tuS+JH6K7adzk5rfSogIha6T73WDjRC491
	 LvFbWalYZ5rjrJspRaz7NnFVaIHpwdwJ1PfZnHPT1sME5OJMKek5h25LAKZjGN/i2V
	 wjGE8BARPSJCsHHkVSdwwT83mDq46BjVA0Xp1zQdjiL+C4DSzhHdw/Hbcrh7wcv0Jk
	 LA6u6SSXW8Ym8UDgdgWs5Tgo=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c70d0dd81so1269445d50.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787097138; x=1787701938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
        b=YxV3mSMWF77gSWR3+bUbP3T9x0sAb0rQ/u1WfeugClXcZbtJ2UrD0iP7RhOrwfOeof
         ThODlxJtOEKHzD0f+nYgxQz1HcV1hYhmXarC4gvmOPW7aDH/DstF4HHkQKYEY1nNksSW
         TuPpAKfwl6wQGeHOkBFnsWTUNFCl6XeoGpnEfnXWJfiUgbBOYonG1QtWlqTP2lwbjuA5
         X9kiiCDnSJX9qIRvv5UoaVghly56jdBNau2GwmMB2+VGS5m6rzbasFkp2JNDawN7neMn
         qwg7qoSjBgpciEfLV5FQf+MlXIHsCjeffxDT5ibL0+vQsE1gRV/hE3GVYxDIdGFIBHkQ
         js9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqAyzAaTXF1DOubEkMlec1pNSFZ31Q5/cH2TISHOjHr3aWBkwPROmPUVmYW6+xikeLKAzgjNWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxi1zx7gApHKklPvCdA53U2Y7vnk2pPQ2cm3SjJj6/Ef779E/
	PWszJnY8xXUPaOuXbE23YElvygUMavw1w+Gf1AHfUKtnlmU/DDXEQLV9vfYghu/yNLI14ppaoQq
	2eEsj2BbyoNUl7E48IHJT4zPjqjpoB5vcZobPPNoSmuRcWkeB9/xwW67uHHdoXHc86ndOnDRSYQ
	==
X-Gm-Gg: AR+sD11TyBweXz8f6FqmYtBh7bwM60WL81mecPjmjKXPE8slcGxSsPtH7XcdS5DlSaW
	kOP2bEp+W4Ika7/e2gLzoW01JXIsIRQvI6V0mDijCymjlLlyEfe8yJC9BV4Ioee7smY7oiSwQBp
	0s3mrQKDwXPld3x+KB5PUCQwpiUCclkVTelGJw/W4gKM0JTj4NwcUj1QGeqfSj6aN7OYRES9IpE
	OVmObwj5gCwOFxDWsUDkqD2h0mcadNxNnpzWtZY2uxDIgrlOdeIuuQ4/DYBnLE9+k3t8i9erURy
	MOiNEoEXAIQjngwIKb/9Wg3vWnGXd+Os7oWFUesQ6Ofchwmh3jPf+xl1TqE17nW7JGlNgv5Gu6p
	BXHigc6x+8pOKcfo=
X-Received: by 2002:a53:dd09:0:b0:66b:b123:edf7 with SMTP id 956f58d0204a3-66ccb7151demr225246d50.41.1787097138073;
        Tue, 18 Aug 2026 16:52:18 -0700 (PDT)
X-Received: by 2002:a53:dd09:0:b0:66b:b123:edf7 with SMTP id 956f58d0204a3-66ccb7151demr225234d50.41.1787097137673;
        Tue, 18 Aug 2026 16:52:17 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccafcfe3esm200735d50.2.2026.08.18.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:52:16 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: rickey.castillo.valenzuela@canonical.com
Cc: Ankit Garg <nktgrg@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Joshua Washington <joshwash@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU][N:linux-gcp][PATCH 1/2] gve: fix header buffer corruption with header-split and HW-GRO
Date: Tue, 18 Aug 2026 17:52:09 -0600
Message-ID: <20260818235210.19330-2-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818235210.19330-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818235210.19330-1-rickey.castillo.valenzuela@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankit Garg <nktgrg@google.com>

BugLink: https://bugs.launchpad.net/bugs/2153950

The DQO RX datapath programs a per-buffer-queue-descriptor
header_buf_addr at post time and reads the split header back at
completion time. Both the post and the read currently index the
header buffer by queue position rather than by the buffer's identity:

  - post (gve_rx_post_buffers_dqo): header_buf_addr is computed from
    bufq->tail
  - read (gve_rx_dqo): the header is read from desc_idx (the completion
    queue head index)

This relies on the buffer-queue index and the completion-queue index
being equal for the start of every packet, i.e. on the device consuming
posted buffers and returning completions in the exact same order. That
assumption does not hold once HW-GRO is enabled with multiple
flows: coalesced segments are accepted and completed in an order that
may differ from the order buffers were posted, and segments from
different flows may interleave.

That results in two problems:

1. Wrong header slot on read. Because the read offset is derived from
   the completion index (desc_idx) while the device wrote the header to
   the address programmed for the buffer's buf_id, the driver can copy
   a header belonging to a different packet. This shows up as
   throughput drop (about 30% drop and large numbers of TCP
   retransmissions) with header-split and HW-GRO both enabled and many
   streams.

2. Header buffer reused while still owned by the device. The driver
   advances bufq->head by one per completion and re-posts buffers based
   on that. Arrival of N RX completions only guarantees that at least N
   RX buffer descriptors have been read by the device. It does not
   guarantee that the device has relinquished the ownership of all the
   buffers corresponding to those N descriptors. With out-of-order
   completions (e.g. the completion for a packet copied into buffer N
   arrives before the completion for a packet copied into buffer N-1),
   the driver can re-post and overwrite a header buffer that the device
   is still going to write into, corrupting the header of a packet
   whose completion has not yet been processed.

Fix both issues by indexing the header buffer by buf_id on both the post
and read paths. Reading from buf_id's slot is therefore always correct
regardless of completion ordering (fixes problem 1).

Indexing by buf_id also ties each header slot to the lifetime of its
buffer state. A buffer state is only returned to the free/recycle lists
when its own completion (buf_id) is processed, so its header slot can
only be re-posted after the device is done with it. This makes header
slot reuse safe under out-of-order completions (fixes problem 2).

Allocate (gve_rx_alloc_hdr_bufs) and free (gve_rx_free_hdr_bufs) the
header buffers based on num_buf_states to match the buf_id indexing.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260617013208.3781453-1-joshwash@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(backported from commit d676c9a73bdcd8237425dbb826f2bd1a25c36e40)
[rickey.castillo: Fixed conflict in drivers/net/ethernet/google/gve/gve_rx_dqo.c
 because this kernel is missing the commit:
 ebdfae0d377b ("gve: adopt page pool for DQ RDA mode") which relocated some
 lines from gve_rx_post_buffers_dqo() to a new function gve_alloc_buffer()]
Signed-off-by: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 27 ++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8df733a7e2ef..e6decc0e7a30 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -202,11 +202,13 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 {
 	struct device *hdev = &priv->pdev->dev;
-	int buf_count = rx->dqo.bufq.mask + 1;
 
 	if (rx->dqo.hdr_bufs.data) {
-		dma_free_coherent(hdev, priv->header_buf_size * buf_count,
-				  rx->dqo.hdr_bufs.data, rx->dqo.hdr_bufs.addr);
+		size_t size =
+			(size_t)priv->header_buf_size * rx->dqo.num_buf_states;
+
+		dma_free_coherent(hdev, size, rx->dqo.hdr_bufs.data,
+				  rx->dqo.hdr_bufs.addr);
 		rx->dqo.hdr_bufs.data = NULL;
 	}
 }
@@ -405,7 +407,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	/* Allocate header buffers for header-split */
 	if (cfg->enable_header_split)
-		if (gve_rx_alloc_hdr_bufs(priv, rx, buffer_queue_slots))
+		if (gve_rx_alloc_hdr_bufs(priv, rx, rx->dqo.num_buf_states))
 			goto err;
 
 	/* Allocate RX completion queue */
@@ -539,10 +541,12 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 		desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
 		desc->buf_addr = cpu_to_le64(buf_state->addr +
 					     buf_state->page_info.page_offset);
-		if (rx->dqo.hdr_bufs.data)
+		if (rx->dqo.hdr_bufs.data) {
+			u16 buf_id = le16_to_cpu(desc->buf_id);
 			desc->header_buf_addr =
 				cpu_to_le64(rx->dqo.hdr_bufs.addr +
-					    priv->header_buf_size * bufq->tail);
+					(size_t)priv->header_buf_size * buf_id);
+		}
 
 		bufq->tail = (bufq->tail + 1) & bufq->mask;
 		complq->num_free_slots--;
@@ -789,10 +793,13 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		int unsplit = 0;
 
 		if (hdr_len && !hbo) {
-			rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
-							    rx->dqo.hdr_bufs.data +
-							    desc_idx * priv->header_buf_size,
-							    hdr_len);
+			size_t offset =
+				(size_t)buffer_id * priv->header_buf_size;
+
+			rx->ctx.skb_head =
+				gve_rx_copy_data(priv->dev, napi,
+						 rx->dqo.hdr_bufs.data + offset,
+						 hdr_len);
 			if (unlikely(!rx->ctx.skb_head))
 				goto error;
 			rx->ctx.skb_tail = rx->ctx.skb_head;
-- 
2.53.0

