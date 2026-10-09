Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C84FE2D9
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576816; cv=none; b=p4TeEHGLztitZGDHxNHqaBK8mUsaU8e/3s+aySuyjcZ0Tbc12A7agdQzxPb4vlI/Q/+RwfKTxJIv1XA3+dl+vFe1yn3HbH0xQjKy4RIpR6gA/Kc2GCPbFXPbQ9M2KlHR2KKoB37TxKPm7Xid5WvE0BbtQoFrune6rQF79wqv10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576816; c=relaxed/simple;
	bh=l42zEUIyms5oJCB2hQLmWeIQD6tN9gDHjof/RuKLr8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruzJ8GqeMwOyFOuuP3mz8XG6JbscmsN50BJMoDo5L8+AhfZgFN7aXjr3EPeZc1IgUCd2mO24Mh6oHFXTkoobgeQ7oPjCxwAeHPErvI5RbT5XdVcGFvOtsTxMTgquGJ6GGoBxq1eDKfkVjifC5uvr8dHTfRi0vJO7Vu7oW38iw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq2ZawI5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq2ZawI5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a005aa0838so240705e9.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791576813; x=1792181613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOAyhgny1QsizGc6HqDS5JHkUYeIBh6QUXQ9g7Bpohc=;
        b=bq2ZawI5fthdRllHaJCuGcs5nUGeR0XhhQM/dbrZb4TovKsI8e8nKnBEnh9Y2OcKmP
         4UFg65CRqr41lc6igr7tFf4pqiUsl7k/FFAp2Z3Q0bMnxbgSCl7aSMm+Dm1ZZIqo21hv
         9VM9gB6hZdUAfbJuXeEnacGBfgvxM/N5U2fndE3E/Pk4otBYWk3LAmcGG/+2EYaIdcwW
         r0yM9ZW9NtQ3j695sPujw+bRNUF913eLvHx1rCmB/pQhpfs+5L/GsNNffxiPuyBT4PTZ
         vEiGXeDpNu/KhIuvFb9+nPhWuoQbjjpswZWathYLUj2h3Kk1btcQbRnfYeuri6nGsfUN
         tmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576813; x=1792181613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOAyhgny1QsizGc6HqDS5JHkUYeIBh6QUXQ9g7Bpohc=;
        b=xOED9LuF7zn+4thDJHLXAw3mnkV4/NaIdaTmPIFQ2+IpBeBXMc6TsM6FWkF/QTeSUk
         FAJiiQhxrI+Zb+k1Eb32Kxok2Eyvjb6WPXI3APHbatGn2twUct46tIo39v4UuQpVxxho
         urif4tQPrgFSIpFpdcuN1dh8jQbn2BMSOD6xM+h0uQNnQHy5e9G9uh1rrqumSdZY3M+i
         vHvZ1zeXJ52+BBQ1ubIT3lVP5Y99c9EwVoz0Ot2dLVa459QRkPoUv2rE+jlLuKBErK5y
         mNQoHjHr/IephOVcNxPW43Nc3st1I4UnVZeXLLJ/uJwy6A635YPx5UDUSgTu7mG0NZ/W
         jJDA==
X-Forwarded-Encrypted: i=1; AKwUvByWUgFUW2qrmkYPpV6WvCrmcDmv8DeDKAKByt/Y6e3/r8rGB+09xtAqQbMPfDPVTiUZWj8AXps=@vger.kernel.org
X-Gm-Message-State: AFuF++l9Yw8Ioq3BWW2trwaNeJ2PBk4DSBndezWx2/sA3mwoaOeGnHdw
	3/qFMdY70TOr8CvPWWmbR/cHfd9tQTmuDVAM7lsc6iPJIq4PqQPvFmi/
X-Gm-Gg: AYBFou0Xc68K3lShQR6GBPGTJ45287x7PBMQYvQxveCyd0FZxZILuuqeV1q4xfnK7FR
	9ZFNFiVdAnYk5bi13lYi4dcNoUG3CpEpjGz7vapNrXqRQKzqJNC4XjKYLYXRyJzTz1DoAaQyXHU
	+2UWNA0nU7doydMiyAytYLa31yMnvyQWGplXcE/ieEedOqHa6jV8RKueomRLD0izlBwRB6gNbsV
	LBzUqCAcNKmzS3gIXROnVA5JHQDzp/DkSUSF3PXmsM1m7gefhli9q4cR+85vKl/zYEVYEKjE8yG
	aGriI86guhGOrXHFFgOGZMRpbhIiOLlz4q4bDtn4uSIqVd5+8sdp+3fL2dTc1+IC80K/RNUS89N
	bVOGBLYcnczr+Mok7MVdNWzGegnLRC24XykuBbxFHWgQUMdYSZmuJIwRiQRSAJJO+tHcxNHWWgp
	g3PIki62UJiUKGWrHMj0Eh/OIHugUms7dJ8qQ0/Y+xEjk/hoF0utABrIXGQFQ3Yq+UBR4gTtJTz
	EY/dr+GVGTo86jwUqDHJTySmz2J51qjCUwZTn16BtUVhDW9LbsALaHumLGhsBfnWSjwtlLtvec+
	2FuEUbODHwwJXAN3vmIt3OiKbx24jJDF
X-Received: by 2002:a05:600c:1e0f:b0:4a1:8469:e6c8 with SMTP id 5b1f17b1804b1-4a18e46f48fmr57281695e9.1.1791576812845;
        Fri, 09 Oct 2026 13:13:32 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-093-130-185-162.93.130.pool.telefonica.de. [93.130.185.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18d12fe04sm47053065e9.4.2026.10.09.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:13:32 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	xiexinet@gmail.com
Subject: [PATCH net v7 3/4] net: hsr: segment GSO before per-frame forwarding
Date: Fri,  9 Oct 2026 22:13:23 +0200
Message-ID: <20261009201324.17-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009201324.17-1-xiexinet@gmail.com>
References: <20261009201324.17-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP require a tag/RCT and sequence number for each wire frame.
Adding them to a GSO aggregate before segmentation cannot provide
valid per-frame metadata.

Use the core GSO segmenter before normal per-frame processing.
Each segment follows the usual local-delivery and forwarding paths.
Remove GSO_MASK types from the master's hw_features so core TX also
segments local traffic before ndo_start_xmit().

Classify by inner protocol, not ingress port. Use the core's bounded
VLAN decoder for 802.1Q, 802.1AD and nested or accelerated tags.
Reject inner HSR/PRP aggregates, unreadable fragments and undecodable
headers. Also reject trailing bytes beyond a known nonzero IP length:
otherwise an old PRP sender's erroneous whole-aggregate RCT becomes
transport payload. This check also rejects locally destined malformed
inputs that the base kernel accepted. Zero IP lengths and GSO_PARTIAL
are left to the segmenter because they provide no full IP extent for
this check.

The preceding ordered-consumer patch is required for per-segment
local numbering. Charge the worker budget by the actual segment count,
or one on failure, and count each rejected input once through core
per-CPU statistics on its entry device.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c        |   2 +-
 net/hsr/hsr_forward.c       | 148 +++++++++++++++++++++++++++++++++++-
 net/hsr/hsr_forward.h       |   5 ++
 net/hsr/hsr_forward_queue.c |  22 ++----
 4 files changed, 158 insertions(+), 19 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 68cd64a865fd..a67d85551abe 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -698,7 +698,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
-			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
+			   NETIF_F_HW_CSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index e8b53367bf3e..0c227a20b7d8 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,9 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/gso.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
@@ -818,6 +821,149 @@ void hsr_forward_frame(struct sk_buff *skb, struct hsr_port *port,
 	kfree_skb(skb);
 }
 
+/* Shared drop mapping for the new queue and GSO gate stages: one
+ * count per dropped original input.  Ordinary master TX and all
+ * internal supervision (local and proxy) are TX drops on the entry
+ * device; ordinary slave A/B and interlink RX are RX drops.
+ * Internal supervision keeps the TX mapping regardless of its
+ * entry role.
+ */
+void hsr_fwd_drop_stat(struct net_device *dev, enum hsr_port_type type,
+		       enum hsr_job_class class)
+{
+	if (class == HSR_JOB_NORMAL && type != HSR_PT_MASTER)
+		dev_core_stats_rx_dropped_inc(dev);
+	else
+		dev_core_stats_tx_dropped_inc(dev);
+}
+
+/* Return the inner EtherType using the core's bounded 802.1Q/802.1AD
+ * decoder. An accelerated outer tag is metadata, not frame bytes.
+ */
+static __be16 hsr_gso_effective_proto(const struct sk_buff *skb, int *l3off)
+{
+	struct ethhdr eh;
+	const struct ethhdr *eth;
+
+	if (skb_vlan_tag_present(skb) &&
+	    !eth_type_vlan(skb->vlan_proto))
+		return 0;
+
+	eth = skb_header_pointer(skb, 0, sizeof(eh), &eh);
+	if (!eth)
+		return 0;
+
+	return __vlan_get_protocol(skb, eth->h_proto, l3off);
+}
+
+/* Bytes beyond the IP datagram must not become segment payload. Older
+ * PRP senders can append an RCT to a whole GSO skb. Zero IP lengths and
+ * GSO_PARTIAL headers do not provide the full aggregate length here.
+ */
+static bool hsr_gso_trailing_data(const struct sk_buff *skb, __be16 proto,
+				  int l3off)
+{
+	unsigned int l3len;
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL)
+		return false;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr buffer;
+		const struct iphdr *iph;
+
+		iph = skb_header_pointer(skb, l3off, sizeof(buffer), &buffer);
+		if (!iph)
+			return true;
+		l3len = ntohs(iph->tot_len);
+	} else if (proto == htons(ETH_P_IPV6)) {
+		struct ipv6hdr buffer;
+		const struct ipv6hdr *ip6h;
+
+		ip6h = skb_header_pointer(skb, l3off, sizeof(buffer), &buffer);
+		if (!ip6h)
+			return true;
+		l3len = ntohs(ip6h->payload_len);
+		if (l3len)
+			l3len += sizeof(*ip6h);
+	} else {
+		return false;
+	}
+
+	return l3len && l3off + l3len < skb->len;
+}
+
+/* GSO fan-out funnel: unfold super-packets before per-frame
+ * processing so each wire frame gets its own HSR/PRP tag and
+ * sequence number.  Returns the number of per-frame units actually
+ * processed (one for a single-frame input or a failed aggregate).
+ */
+unsigned int hsr_forward_input(struct sk_buff *skb, struct hsr_port *port,
+			       enum hsr_job_class class,
+			       enum hsr_exec_source source)
+{
+	struct sk_buff *segs, *next;
+	unsigned int count = 0;
+	__be16 proto;
+	int l3off;
+
+	if (likely(!skb_is_gso(skb))) {
+		hsr_forward_frame(skb, port, source);
+		return 1;
+	}
+
+	/* Conforming plain-protocol GSO super-packets carry
+	 * trailer-free sender payload and are segmented here: each
+	 * segment is delivered or forwarded as its own wire frame, on
+	 * any ingress role.
+	 *
+	 * The gate is content-based, not port-based.  An aggregate
+	 * whose effective protocol is ETH_P_HSR or ETH_P_PRP cannot be
+	 * safely segmented and is dropped, as is any skb whose headers
+	 * cannot be read or whose fragments are unreadable net_iov
+	 * (device-memory) pages: software segmentation cannot read
+	 * their payload, so each segment would inherit the unreadable
+	 * flag and carry uninitialized data.  Ordinary VLAN GSO
+	 * (802.1Q/802.1AD at any reachable tag depth, accelerated or
+	 * in-band) is classified to its inner protocol through the core
+	 * VLAN decoder and segmented like plain input.  With
+	 * NETIF_F_HW_HSR_TAG_RM the lower has already stripped the tag,
+	 * so such aggregates arrive plain and are segmented.
+	 */
+	if (!skb_frags_readable(skb))
+		goto drop_gso; /* net_iov frags are not host-readable */
+	proto = hsr_gso_effective_proto(skb, &l3off);
+	if (!proto)
+		goto drop_gso; /* classification failure, fail-safe */
+	if (proto == htons(ETH_P_HSR) || proto == htons(ETH_P_PRP))
+		goto drop_gso;
+	if (hsr_gso_trailing_data(skb, proto, l3off))
+		goto drop_gso;
+
+	/* features = 0: request full software segmentation.  tx_path is
+	 * true only for locally generated traffic on the master; ingress
+	 * follows RX checksum semantics.
+	 */
+	segs = __skb_gso_segment(skb, 0, port->type == HSR_PT_MASTER);
+	if (IS_ERR(segs) || unlikely(!segs))
+		goto drop_gso;
+
+	consume_skb(skb);
+	while (segs) {
+		next = segs->next;
+		segs->next = NULL;
+		hsr_forward_frame(segs, port, source);
+		count++;
+		segs = next;
+	}
+	return count;
+
+drop_gso:
+	hsr_fwd_drop_stat(port->dev, port->type, class);
+	kfree_skb(skb);
+	return 1;
+}
+
 /* Submission entry.  Inputs that need a local sequence number go to
  * the single consumer before any numbering happens; the synchronous
  * LAN A/B receive path keeps its original behavior.
@@ -828,7 +974,7 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 		hsr_queue_submit(skb, port, HSR_JOB_NORMAL);
 		return;
 	}
-	hsr_forward_frame(skb, port, HSR_EXEC_DIRECT_LAN);
+	hsr_forward_input(skb, port, HSR_JOB_NORMAL, HSR_EXEC_DIRECT_LAN);
 }
 
 /* Internally generated supervision frames always take the common
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 0fde1972c0a5..12fdf1bff4a3 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -36,6 +36,11 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
 void hsr_forward_sup_skb(struct sk_buff *skb, struct hsr_port *port);
 void hsr_forward_frame(struct sk_buff *skb, struct hsr_port *port,
 		       enum hsr_exec_source source);
+unsigned int hsr_forward_input(struct sk_buff *skb, struct hsr_port *port,
+			       enum hsr_job_class class,
+			       enum hsr_exec_source source);
+void hsr_fwd_drop_stat(struct net_device *dev, enum hsr_port_type type,
+		       enum hsr_job_class class);
 void hsr_assign_sup_seq(struct sk_buff *skb, struct hsr_priv *hsr,
 			enum hsr_exec_source source);
 
diff --git a/net/hsr/hsr_forward_queue.c b/net/hsr/hsr_forward_queue.c
index 5e96c24dec00..c97cc722eaca 100644
--- a/net/hsr/hsr_forward_queue.c
+++ b/net/hsr/hsr_forward_queue.c
@@ -28,18 +28,7 @@ struct hsr_job {
 	unsigned int		charge;	/* immutable skb->truesize */
 };
 
-/* Queue-stage drop: one count per dropped original input on the held
- * entry device.  Ordinary interlink RX is an RX drop; master TX and
- * internally generated supervision frames are TX drops.
- */
-static void hsr_fwd_drop_stat(struct net_device *dev, enum hsr_port_type type,
-			      enum hsr_job_class class)
-{
-	if (class == HSR_JOB_NORMAL && type == HSR_PT_INTERLINK)
-		dev_core_stats_rx_dropped_inc(dev);
-	else
-		dev_core_stats_tx_dropped_inc(dev);
-}
+/* Queue-stage drops share the mapping in hsr_forward.c. */
 
 static void hsr_job_drop(struct hsr_job *job)
 {
@@ -113,6 +102,7 @@ static unsigned int hsr_job_process(struct hsr_priv *hsr, struct hsr_job *job,
 {
 	struct hsr_port *port;
 	unsigned int raised = 0;
+	unsigned int cost;
 
 	rcu_read_lock();
 	port = hsr_job_port(hsr, job);
@@ -129,7 +119,7 @@ static unsigned int hsr_job_process(struct hsr_priv *hsr, struct hsr_job *job,
 
 	if (job->class == HSR_JOB_INTERNAL_SUP)
 		hsr_assign_sup_seq(job->skb, hsr, source);
-	hsr_forward_frame(job->skb, port, source);
+	cost = hsr_forward_input(job->skb, port, job->class, source);
 
 	while (raised) {
 		dev_xmit_recursion_dec();
@@ -140,10 +130,8 @@ static unsigned int hsr_job_process(struct hsr_priv *hsr, struct hsr_job *job,
 	dev_put(job->dev);
 	kfree(job);
 
-	/* One input is one budget unit; GSO per-frame accounting is
-	 * added by the segmentation change.
-	 */
-	return 1;
+	/* Actual per-frame units consumed; a failed aggregate costs 1. */
+	return cost;
 }
 
 static void hsr_queue_owned_release(struct hsr_priv *hsr)
-- 
2.43.0

