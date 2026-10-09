Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A14FC8F3
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576816; cv=none; b=jyqHbFX8nSRfJLp9iuPQWYyxw4Ogjtgs3o2IVVV4OUF+SEXqXygmO/iXyhRu6kQCKFeYp+u66fqWmsK7VkjTTRB03q5iKTw0l25leLx8vP0z9DTKmWv7A4XGh0Bs/hct2jRM5f7wve+cdACMGXT0hqEPNWa8PXMjXuIHRV85pvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576816; c=relaxed/simple;
	bh=B4abBiBMOr8FpVGWSiPY+AlAhfLUtOGgs4efP0oaI+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGLFW9yrZAMoIpdVonYU5SYbPNQLFzFr3LAz50KiPVIbsIvfHxoQlvef1y87IEwn/+oEzE0712AZPoa4Rv/YDf8Dwx07CTuwE+xRwkgpkgyLCufY88voXBiLpbx3FM8naWZpx3aLs91jbE0+yDWqCSf87E34q9g96uidjFhqcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5cVBwNj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5cVBwNj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a005aa0838so240675e9.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791576812; x=1792181612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKN9eafnkQU+L/X9le7R4gJOYTiFO/IRpcYDsJ5kSDg=;
        b=o5cVBwNjD51A7PqsTtcxGG4F8tpsrX3xoNE0vnOEYrTH9LjEQ4BHiuv5KGHh5T8K6V
         sJeDvtRwsYfanvTsD18vMDU90iS1hTNvkyZXx8NsJOXNlZmODudvdZ9kl7aHMsVgnFQ8
         cNk33/1J5P8vD2/ydiC3OBMkeVzEZ3PxvYtn+NkHyS9zKI4UeQaXlcDSesDeQhHZITSx
         64CFmudjZd4GrYJ8mtO3rE76RSpq+zC69LWs/5JNa3956kHbtXQ0KZEuFd0WQpJ/aOs3
         3EXtKF7rsKjrTWTNNqryROVoyQ0p69t81tcWlhfm7pBAbSazzMLxb/CkulU8re/3dUff
         mFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576812; x=1792181612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OKN9eafnkQU+L/X9le7R4gJOYTiFO/IRpcYDsJ5kSDg=;
        b=wrZ0B9KvOmKO9u2Jn7gfjNjOgPQeWBfv8SVcZm01DQjXzRuHsGErlD1fBLjBF0z4ha
         wQKc8kOz3NJSVWxJZ1UWJD4fEX/fRgMPPHLAzGsmTOGgpoirpBUP01AXpmShYy0HwFVW
         ovys8hHl1cttDn3OQciHhKwH+JULJal9mGbvPnfHmtYh1CpLJjmuFUN027rGNXx+4TJS
         nQOYPn0Dc5lhpiTBlyMFPTi6I7xc6WVxYNqzJEWVCt+A1HMsqbu7Cs9Y1h+xj4Fp7RZB
         P0ZirjVJKbX5ZrHs9syk+06ctpSkYdoj9j+uou8MqNpax5b7DOzYrlenOIj+d3if30u+
         BnTw==
X-Forwarded-Encrypted: i=1; AKwUvBzNMY4RGDSFYwZ3sz80l5n6s5n9FSxNjXjrv4EHaWRfM7BOrGq+q7FlpDQxH+h8OtbyUYtbH2k=@vger.kernel.org
X-Gm-Message-State: AFuF++l86hEj+9+dKLrNtvWaiou6pnw84vzQYxWRB8lGEaUHBAWk2Hry
	1fWjir5wmwN4+1fGVp/ytd/0mcNqI8C9yXZ05uqPfmZLeIPsHLCDUYAw
X-Gm-Gg: AYBFou23JdtvKI/JlZNFcOAvTd7BSsZNveSE+VdYaQXCVc/fv+AxbhaY0LCFCgfYDyX
	hofevOSdQAIYVVLfN9Gxz7bpvQcRDAr7pHlTGjoyH/Xd1MfBchKcIxNp2mDG0ObDw72uOfi8NQ5
	SwzPUbwUTiKm/UElClSbYdEFaMuJoq6oQ8cnyjGPFt6IFvht35fc2mOKMwyxjdLKKGS964PHyTY
	Xz2ktJ+/a65dx4qTaAs8vKqbt760KlT4p+T+ICni94H4vnDX7//At2lleq5+5Wu0R8RbktI1HYQ
	zru2AO03dUSFAqQSqRzG/YlGsQ7Y14cT2xcrnsGEsTl4Z9HmlEFhyMm33xCX+N6i/S5ixl/SQuZ
	6BB5HziDp7ALBeKiYaLInObfo68OHcvQDl1d1Z0cXe8I7tnzvI6RoTSM5ik7CW1Gifk8XOCSNjf
	0wZPeJDn5axCAH+vlxqSU6+9LAATrxxSk3jci7z763MvN5Gj+08+zG78a+D9BAtMq+mEpoUQCrj
	iWzKVC5owBrMXpkCVQjd1Iy5F/vZ3XPHJnJxkUJTx8PJ1DanJZL1jIEfyIzNS+PH0bLDGdbZDfy
	Gg+qASO1KWhJtr+R5i1JhHlHouIQBY/OvwFoIYhazN0=
X-Received: by 2002:a05:600c:3b29:b0:4a1:813f:2a5a with SMTP id 5b1f17b1804b1-4a18e477757mr58397105e9.2.1791576811488;
        Fri, 09 Oct 2026 13:13:31 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-093-130-185-162.93.130.pool.telefonica.de. [93.130.185.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18d12fe04sm47053065e9.4.2026.10.09.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:13:30 -0700 (PDT)
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
	xiexinet@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: [PATCH net v7 2/4] net: hsr: preserve submission order without a forwarding lock
Date: Fri,  9 Oct 2026 22:13:22 +0200
Message-ID: <20261009201324.17-3-xiexinet@gmail.com>
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

Holding seqnr_lock across dev_queue_xmit() serializes numbering and
submission, but creates transmit-lock dependencies that can deadlock
stacked HSR devices. Merely shrinking the lock to the counter lets
one CPU send frame N after another has sent N+1; old HSR peers discard
the late N as stale.

Use one consumer for master TX, interlink RX and internally generated
supervision frames. An idle caller processes its own input inline;
contended inputs wait in a FIFO drained by one BH work item. Allocate
sequence numbers only when the consumer executes a frame, and submit
it to every lower before numbering the next frame. The short counter
lock is released before forwarding.

Limit queued inputs to 1024 jobs and 8 MiB, reserving capacity for
internal supervision. Carry transmit recursion depth across deferred
execution, cancel the worker and purge the queue on teardown, and count
queue drops once through core per-CPU statistics. LAN A/B reception
stays synchronous and tagged frames retain their received numbers.
The ordering guarantee is per-lower submission, not physical wire
order across multiple TX queues.

On PREEMPT_RT, high-priority load preempted both the inline consumer
and BH worker while another CPU continued to enqueue inputs. All
2118 inputs completed without drops; the finite data workload
completed 4.07 seconds after the load ended.

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/Makefile            |   3 +-
 net/hsr/hsr_device.c        |  64 +++++---
 net/hsr/hsr_forward.c       |  87 +++++++---
 net/hsr/hsr_forward.h       |  32 ++++
 net/hsr/hsr_forward_queue.c | 306 ++++++++++++++++++++++++++++++++++++
 net/hsr/hsr_main.h          |  18 +++
 net/hsr/hsr_netlink.c       |   4 +-
 net/hsr/hsr_slave.c         |  13 +-
 8 files changed, 470 insertions(+), 57 deletions(-)
 create mode 100644 net/hsr/hsr_forward_queue.c

diff --git a/net/hsr/Makefile b/net/hsr/Makefile
index 34e581db5c41..223b66fe8577 100644
--- a/net/hsr/Makefile
+++ b/net/hsr/Makefile
@@ -6,7 +6,8 @@
 obj-$(CONFIG_HSR)	+= hsr.o
 
 hsr-y			:= hsr_main.o hsr_framereg.o hsr_device.o \
-			   hsr_netlink.o hsr_slave.o hsr_forward.o
+			   hsr_netlink.o hsr_slave.o hsr_forward.o \
+			   hsr_forward_queue.o
 hsr-$(CONFIG_DEBUG_FS) += hsr_debugfs.o
 
 obj-$(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST) += prp_dup_discard_test.o
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d14de44e14b7..68cd64a865fd 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -290,6 +288,31 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master, int extra)
 	return NULL;
 }
 
+/* Assign the supervision sequence number at execution time in the
+ * single consumer.  Internally built supervision frames carry
+ * ETH_P_PRP with the supervision tag right after the Ethernet
+ * header.  HSRv0 shares the data counter, later versions use the
+ * dedicated supervision counter.
+ */
+void hsr_assign_sup_seq(struct sk_buff *skb, struct hsr_priv *hsr,
+			enum hsr_exec_source source)
+{
+	struct hsr_sup_tag *hsr_stag;
+
+	WARN_ON_ONCE(source == HSR_EXEC_DIRECT_LAN);
+
+	hsr_stag = (struct hsr_sup_tag *)(skb_mac_header(skb) + ETH_HLEN);
+	spin_lock_bh(&hsr->seqnr_lock);
+	if (hsr->prot_version > 0) {
+		hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
+		WRITE_ONCE(hsr->sup_sequence_nr, hsr->sup_sequence_nr + 1);
+	} else {
+		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
+		WRITE_ONCE(hsr->sequence_nr, hsr->sequence_nr + 1);
+	}
+	spin_unlock_bh(&hsr->seqnr_lock);
+}
+
 static void send_hsr_supervision_frame(struct hsr_port *port,
 				       unsigned long *interval,
 				       const unsigned char *addr)
@@ -326,15 +349,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	set_hsr_stag_path(hsr_stag, (hsr->prot_version ? 0x0 : 0xf));
 	set_hsr_stag_HSR_ver(hsr_stag, hsr->prot_version);
 
-	/* From HSRv1 on we have separate supervision sequence numbers. */
-	spin_lock_bh(&hsr->seqnr_lock);
-	if (hsr->prot_version > 0) {
-		hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
-		hsr->sup_sequence_nr++;
-	} else {
-		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
-		hsr->sequence_nr++;
-	}
+	/* The sequence number is assigned by the consumer at execution
+	 * time; zero placeholder until then.
+	 */
+	hsr_stag->sequence_nr = 0;
 
 	hsr_stag->tlv.HSR_TLV_type = type;
 	/* HSRv0 has 6 unused bytes after the MAC */
@@ -356,13 +374,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
-	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
+	hsr_forward_sup_skb(skb, port);
 	return;
 }
 
@@ -397,10 +412,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	set_hsr_stag_path(hsr_stag, (hsr->prot_version ? 0x0 : 0xf));
 	set_hsr_stag_HSR_ver(hsr_stag, (hsr->prot_version ? 1 : 0));
 
-	/* From HSRv1 on we have separate supervision sequence numbers. */
-	spin_lock_bh(&hsr->seqnr_lock);
-	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
-	hsr->sup_sequence_nr++;
+	/* The sequence number is assigned by the consumer at execution
+	 * time; zero placeholder until then.
+	 */
+	hsr_stag->sequence_nr = 0;
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
@@ -424,13 +439,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 		hsr_stlv->HSR_TLV_length = 0;
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
-	hsr_forward_skb(skb, master);
-	spin_unlock_bh(&hsr->seqnr_lock);
+	hsr_forward_sup_skb(skb, master);
 }
 
 /* Announce (supervision frame) timer function
@@ -778,6 +790,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		return res;
 
 	spin_lock_init(&hsr->seqnr_lock);
+	hsr_forward_init(hsr);
 	/* Overflow soon to find bugs easier: */
 	hsr->sequence_nr = HSR_SEQNR_START;
 	hsr->sup_sequence_nr = HSR_SUP_SEQNR_START;
@@ -851,6 +864,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	return 0;
 
 err_unregister:
+	hsr_forward_stop(hsr);
 	hsr_del_ports(hsr);
 err_add_master:
 	hsr_del_self_node(hsr);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 7734a521a96c..e8b53367bf3e 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -627,11 +627,23 @@ static void check_local_dest(struct hsr_priv *hsr, struct sk_buff *skb,
 	}
 }
 
+/* Local numbering condition, shared with the consumer routing
+ * decision: exactly the master and interlink entries carry locally
+ * generated frames.
+ */
+static bool hsr_needs_local_numbering(const struct hsr_port *port)
+{
+	return port->type == HSR_PT_MASTER ||
+	       port->type == HSR_PT_INTERLINK;
+}
+
 static void handle_std_frame(struct sk_buff *skb,
-			     struct hsr_frame_info *frame)
+			     struct hsr_frame_info *frame,
+			     enum hsr_exec_source source)
 {
 	struct hsr_port *port = frame->port_rcv;
 	struct hsr_priv *hsr = port->hsr;
+	u16 seq;
 
 	frame->skb_hsr = NULL;
 	frame->skb_prp = NULL;
@@ -640,13 +652,20 @@ static void handle_std_frame(struct sk_buff *skb,
 	if (port->type != HSR_PT_MASTER)
 		frame->is_from_san = true;
 
-	if (port->type == HSR_PT_MASTER ||
-	    port->type == HSR_PT_INTERLINK) {
-		/* Sequence nr for the master/interlink node */
-		lockdep_assert_held(&hsr->seqnr_lock);
-		frame->sequence_nr = hsr->sequence_nr;
-		hsr->sequence_nr++;
-	}
+	if (!hsr_needs_local_numbering(port))
+		return;
+
+	/* Sequence nr for the master/interlink node.  Local sequence
+	 * numbers are assigned only by the single consumer; the
+	 * explicit call-chain source proves it, shared ownership state
+	 * does not.
+	 */
+	WARN_ON_ONCE(source == HSR_EXEC_DIRECT_LAN);
+	spin_lock_bh(&hsr->seqnr_lock);
+	seq = hsr->sequence_nr;
+	WRITE_ONCE(hsr->sequence_nr, seq + 1);
+	spin_unlock_bh(&hsr->seqnr_lock);
+	frame->sequence_nr = seq;
 }
 
 int hsr_fill_frame_info(__be16 proto, struct sk_buff *skb,
@@ -670,10 +689,10 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *skb,
 		return 0;
 	}
 
-	/* Standard frame or PRP from master port */
-	handle_std_frame(skb, frame);
-
-	return 0;
+	/* Standard frame or PRP from master port: the caller completes
+	 * untagged input with its explicit execution source.
+	 */
+	return HSR_FRAME_PLAIN;
 }
 
 int prp_fill_frame_info(__be16 proto, struct sk_buff *skb,
@@ -690,13 +709,12 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *skb,
 		frame->sequence_nr = prp_get_skb_sequence_nr(rct);
 		return 0;
 	}
-	handle_std_frame(skb, frame);
-
-	return 0;
+	return HSR_FRAME_PLAIN;
 }
 
 static int fill_frame_info(struct hsr_frame_info *frame,
-			   struct sk_buff *skb, struct hsr_port *port)
+			   struct sk_buff *skb, struct hsr_port *port,
+			   enum hsr_exec_source source)
 {
 	struct hsr_priv *hsr = port->hsr;
 	struct hsr_vlan_ethhdr *vlan_hdr;
@@ -756,7 +774,9 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	frame->is_from_san = false;
 	frame->port_rcv = port;
 	ret = hsr->proto_ops->fill_frame_info(proto, skb, frame);
-	if (ret)
+	if (ret == HSR_FRAME_PLAIN)
+		handle_std_frame(skb, frame, source);
+	else if (ret)
 		return ret;
 
 	check_local_dest(port->hsr, skb, frame);
@@ -764,13 +784,16 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	return 0;
 }
 
-/* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+/* Per-frame forwarding path.  Must be called holding rcu read lock
+ * (because of the port parameter).
+ */
+void hsr_forward_frame(struct sk_buff *skb, struct hsr_port *port,
+		       enum hsr_exec_source source)
 {
 	struct hsr_frame_info frame;
 
 	rcu_read_lock();
-	if (fill_frame_info(&frame, skb, port) < 0)
+	if (fill_frame_info(&frame, skb, port, source) < 0)
 		goto out_drop;
 
 	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
@@ -779,7 +802,7 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	/* Gets called for ingress frames as well as egress from master port.
 	 * So check and increment stats for master port only here.
 	 */
-	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
+	if (hsr_needs_local_numbering(port)) {
 		port->dev->stats.tx_packets++;
 		port->dev->stats.tx_bytes += skb->len;
 	}
@@ -794,3 +817,25 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	port->dev->stats.tx_dropped++;
 	kfree_skb(skb);
 }
+
+/* Submission entry.  Inputs that need a local sequence number go to
+ * the single consumer before any numbering happens; the synchronous
+ * LAN A/B receive path keeps its original behavior.
+ */
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+{
+	if (hsr_needs_local_numbering(port)) {
+		hsr_queue_submit(skb, port, HSR_JOB_NORMAL);
+		return;
+	}
+	hsr_forward_frame(skb, port, HSR_EXEC_DIRECT_LAN);
+}
+
+/* Internally generated supervision frames always take the common
+ * submit point; their sequence numbers are assigned by the consumer
+ * at execution time.
+ */
+void hsr_forward_sup_skb(struct sk_buff *skb, struct hsr_port *port)
+{
+	hsr_queue_submit(skb, port, HSR_JOB_INTERNAL_SUP);
+}
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 206636750b30..0fde1972c0a5 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -13,7 +13,39 @@
 #include <linux/netdevice.h>
 #include "hsr_main.h"
 
+/* Per-frame execution source, carried explicitly down the call chain. */
+enum hsr_exec_source {
+	HSR_EXEC_DIRECT_LAN,	/* synchronous LAN A/B receive path */
+	HSR_EXEC_INLINE,	/* inline consumer activation */
+	HSR_EXEC_WORKER,	/* BH worker consumer */
+};
+
+/* Input class, stored with the immutable queue charge. */
+enum hsr_job_class {
+	HSR_JOB_NORMAL,
+	HSR_JOB_INTERNAL_SUP,
+};
+
+/* Return codes of proto_ops->fill_frame_info(): frame completed from a
+ * wire tag/RCT (0), untagged input left for the caller to complete with
+ * its execution source (HSR_FRAME_PLAIN), or error (< 0).
+ */
+#define HSR_FRAME_PLAIN	1
+
 void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
+void hsr_forward_sup_skb(struct sk_buff *skb, struct hsr_port *port);
+void hsr_forward_frame(struct sk_buff *skb, struct hsr_port *port,
+		       enum hsr_exec_source source);
+void hsr_assign_sup_seq(struct sk_buff *skb, struct hsr_priv *hsr,
+			enum hsr_exec_source source);
+
+/* Ordered forwarding queue (hsr_forward_queue.c) */
+void hsr_queue_submit(struct sk_buff *skb, struct hsr_port *port,
+		      enum hsr_job_class class);
+void hsr_forward_init(struct hsr_priv *hsr);
+void hsr_forward_stop(struct hsr_priv *hsr);
+void hsr_forward_forget_port(struct hsr_priv *hsr, struct net_device *dev);
+
 struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 					struct hsr_port *port);
 struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
diff --git a/net/hsr/hsr_forward_queue.c b/net/hsr/hsr_forward_queue.c
new file mode 100644
index 000000000000..5e96c24dec00
--- /dev/null
+++ b/net/hsr/hsr_forward_queue.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Ordered forwarding queue for HSR and PRP.
+ *
+ * One bounded FIFO and one consumer per instance preserve the submission
+ * order of locally numbered frames to every lower device without a
+ * forwarding lock.  Master TX, interlink RX and internally generated
+ * supervision frames are submitted before any sequence number is
+ * assigned; an idle caller executes its own input inline, contended
+ * inputs are drained in submission order by one BH work item.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/rcupdate.h>
+#include <net/dst.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "hsr_main.h"
+#include "hsr_forward.h"
+
+struct hsr_job {
+	struct list_head	list;
+	struct sk_buff		*skb;
+	struct net_device	*dev;	/* held entry device */
+	enum hsr_port_type	type;	/* entry role at submit */
+	enum hsr_job_class	class;	/* ordinary / internal supervision */
+	int			depth;	/* dev_recursion_level() at submit */
+	unsigned int		charge;	/* immutable skb->truesize */
+};
+
+/* Queue-stage drop: one count per dropped original input on the held
+ * entry device.  Ordinary interlink RX is an RX drop; master TX and
+ * internally generated supervision frames are TX drops.
+ */
+static void hsr_fwd_drop_stat(struct net_device *dev, enum hsr_port_type type,
+			      enum hsr_job_class class)
+{
+	if (class == HSR_JOB_NORMAL && type == HSR_PT_INTERLINK)
+		dev_core_stats_rx_dropped_inc(dev);
+	else
+		dev_core_stats_tx_dropped_inc(dev);
+}
+
+static void hsr_job_drop(struct hsr_job *job)
+{
+	/* Drop statistics complete before dev_put(). */
+	hsr_fwd_drop_stat(job->dev, job->type, job->class);
+	kfree_skb(job->skb);
+	dev_put(job->dev);
+	kfree(job);
+}
+
+/* Admission under fwd_lock.  Ordinary inputs must fit both the total and
+ * the ordinary-subset bounds; internal supervision may use the reserve
+ * within the total.  Difference comparisons avoid overflow.
+ */
+static bool hsr_queue_fits(struct hsr_priv *hsr, struct hsr_job *job)
+{
+	if (hsr->fwd_jobs >= HSR_FWD_JOBS_MAX)
+		return false;
+	if (job->charge > HSR_FWD_BYTES_MAX - hsr->fwd_bytes)
+		return false;
+	if (job->class == HSR_JOB_NORMAL) {
+		if (hsr->fwd_ord_jobs >= HSR_FWD_ORD_JOBS_MAX)
+			return false;
+		if (job->charge > HSR_FWD_ORD_BYTES_MAX - hsr->fwd_ord_bytes)
+			return false;
+	}
+	return true;
+}
+
+static void hsr_queue_charge_add(struct hsr_priv *hsr, struct hsr_job *job)
+{
+	hsr->fwd_jobs++;
+	hsr->fwd_bytes += job->charge;
+	if (job->class == HSR_JOB_NORMAL) {
+		hsr->fwd_ord_jobs++;
+		hsr->fwd_ord_bytes += job->charge;
+	}
+}
+
+/* Exactly once, on dequeue to active and on purge. */
+static void hsr_queue_charge_del(struct hsr_priv *hsr, struct hsr_job *job)
+{
+	hsr->fwd_jobs--;
+	hsr->fwd_bytes -= job->charge;
+	if (job->class == HSR_JOB_NORMAL) {
+		hsr->fwd_ord_jobs--;
+		hsr->fwd_ord_bytes -= job->charge;
+	}
+}
+
+/* Re-validate role and device under RCU; no bare port/node is kept
+ * across queueing.
+ */
+static struct hsr_port *hsr_job_port(struct hsr_priv *hsr, struct hsr_job *job)
+{
+	struct hsr_port *port;
+
+	hsr_for_each_port(hsr, port)
+		if (port->type == job->type && port->dev == job->dev)
+			return port;
+	return NULL;
+}
+
+/* Complete one input: re-validate the entry under RCU, raise the xmit
+ * recursion depth to the level saved at submit (never lower it), assign
+ * the supervision sequence number if needed, then run the complete
+ * per-frame path.  Returns the budget units this input consumed.
+ */
+static unsigned int hsr_job_process(struct hsr_priv *hsr, struct hsr_job *job,
+				    enum hsr_exec_source source)
+{
+	struct hsr_port *port;
+	unsigned int raised = 0;
+
+	rcu_read_lock();
+	port = hsr_job_port(hsr, job);
+	if (!port) {
+		rcu_read_unlock();
+		hsr_job_drop(job);
+		return 1;
+	}
+
+	while (dev_recursion_level() < job->depth) {
+		dev_xmit_recursion_inc();
+		raised++;
+	}
+
+	if (job->class == HSR_JOB_INTERNAL_SUP)
+		hsr_assign_sup_seq(job->skb, hsr, source);
+	hsr_forward_frame(job->skb, port, source);
+
+	while (raised) {
+		dev_xmit_recursion_dec();
+		raised--;
+	}
+	rcu_read_unlock();
+
+	dev_put(job->dev);
+	kfree(job);
+
+	/* One input is one budget unit; GSO per-frame accounting is
+	 * added by the segmentation change.
+	 */
+	return 1;
+}
+
+static void hsr_queue_owned_release(struct hsr_priv *hsr)
+{
+	if (!hsr->fwd_stopped && !list_empty(&hsr->fwd_queue))
+		queue_work(system_bh_wq, &hsr->fwd_work);
+	else
+		hsr->fwd_owned = false;
+}
+
+static void hsr_queue_work(struct work_struct *work)
+{
+	struct hsr_priv *hsr = container_of(work, struct hsr_priv, fwd_work);
+	unsigned int used = 0;
+
+	while (used < HSR_FWD_BUDGET_MAX) {
+		struct hsr_job *job;
+		unsigned int cost;
+
+		spin_lock_bh(&hsr->fwd_lock);
+		if (hsr->fwd_stopped || list_empty(&hsr->fwd_queue)) {
+			hsr->fwd_owned = false;
+			spin_unlock_bh(&hsr->fwd_lock);
+			return;
+		}
+		job = list_first_entry(&hsr->fwd_queue, struct hsr_job, list);
+		list_del(&job->list);
+		hsr_queue_charge_del(hsr, job);
+		spin_unlock_bh(&hsr->fwd_lock);
+
+		cost = hsr_job_process(hsr, job, HSR_EXEC_WORKER);
+		if (cost >= HSR_FWD_BUDGET_MAX - used)
+			used = HSR_FWD_BUDGET_MAX;
+		else
+			used += cost;
+	}
+
+	/* Budget exhausted with a backlog: keep the ownership and hand
+	 * the queue to the same worker object again.
+	 */
+	spin_lock_bh(&hsr->fwd_lock);
+	hsr_queue_owned_release(hsr);
+	spin_unlock_bh(&hsr->fwd_lock);
+}
+
+static void hsr_queue_inline_one(struct hsr_priv *hsr, struct hsr_job *job)
+{
+	local_bh_disable();
+	hsr_job_process(hsr, job, HSR_EXEC_INLINE);
+	spin_lock_bh(&hsr->fwd_lock);
+	hsr_queue_owned_release(hsr);
+	spin_unlock_bh(&hsr->fwd_lock);
+	local_bh_enable();
+}
+
+void hsr_queue_submit(struct sk_buff *skb, struct hsr_port *port,
+		      enum hsr_job_class class)
+{
+	struct hsr_priv *hsr = port->hsr;
+	struct hsr_job *job;
+	bool inline_owner = false;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "HSR queue submit outside RCU read-side");
+
+	job = kzalloc_obj(*job, GFP_ATOMIC);
+	if (!job) {
+		hsr_fwd_drop_stat(port->dev, port->type, class);
+		kfree_skb(skb);
+		return;
+	}
+	job->skb = skb;
+	job->dev = port->dev;
+	job->type = port->type;
+	job->class = class;
+	job->depth = dev_recursion_level();
+	job->charge = skb->truesize;
+	skb_dst_force(skb);
+	dev_hold(job->dev);
+
+	spin_lock_bh(&hsr->fwd_lock);
+	if (hsr->fwd_stopped) {
+		spin_unlock_bh(&hsr->fwd_lock);
+		hsr_job_drop(job);
+		return;
+	}
+	if (!hsr->fwd_owned) {
+		/* Idle: take the execution ownership and process this
+		 * input directly.  The job never enters the public queue
+		 * and does not consume queued charge.
+		 */
+		hsr->fwd_owned = true;
+		inline_owner = true;
+	} else if (hsr_queue_fits(hsr, job)) {
+		list_add_tail(&job->list, &hsr->fwd_queue);
+		hsr_queue_charge_add(hsr, job);
+	} else {
+		spin_unlock_bh(&hsr->fwd_lock);
+		hsr_job_drop(job);
+		return;
+	}
+	spin_unlock_bh(&hsr->fwd_lock);
+
+	if (inline_owner)
+		hsr_queue_inline_one(hsr, job);
+}
+
+void hsr_forward_forget_port(struct hsr_priv *hsr, struct net_device *dev)
+{
+	struct hsr_job *job, *next;
+	LIST_HEAD(purge);
+
+	spin_lock_bh(&hsr->fwd_lock);
+	list_for_each_entry_safe(job, next, &hsr->fwd_queue, list) {
+		if (job->dev != dev)
+			continue;
+		list_move_tail(&job->list, &purge);
+		hsr_queue_charge_del(hsr, job);
+	}
+	spin_unlock_bh(&hsr->fwd_lock);
+
+	list_for_each_entry_safe(job, next, &purge, list) {
+		list_del(&job->list);
+		hsr_job_drop(job);
+	}
+}
+
+void hsr_forward_stop(struct hsr_priv *hsr)
+{
+	struct hsr_job *job, *next;
+	LIST_HEAD(purge);
+
+	spin_lock_bh(&hsr->fwd_lock);
+	hsr->fwd_stopped = true;
+	spin_unlock_bh(&hsr->fwd_lock);
+
+	synchronize_net();
+	cancel_work_sync(&hsr->fwd_work);
+
+	spin_lock_bh(&hsr->fwd_lock);
+	list_splice_init(&hsr->fwd_queue, &purge);
+	hsr->fwd_jobs = 0;
+	hsr->fwd_ord_jobs = 0;
+	hsr->fwd_bytes = 0;
+	hsr->fwd_ord_bytes = 0;
+	hsr->fwd_owned = false;
+	spin_unlock_bh(&hsr->fwd_lock);
+
+	list_for_each_entry_safe(job, next, &purge, list) {
+		list_del(&job->list);
+		hsr_job_drop(job);
+	}
+}
+
+void hsr_forward_init(struct hsr_priv *hsr)
+{
+	spin_lock_init(&hsr->fwd_lock);
+	INIT_LIST_HEAD(&hsr->fwd_queue);
+	INIT_WORK(&hsr->fwd_work, hsr_queue_work);
+}
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 53e95bae0ee2..294c61f5068d 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/if_vlan.h>
 #include <linux/if_hsr.h>
+#include <linux/workqueue.h>
 
 /* Time constants as specified in the HSR specification (IEC-62439-3 2010)
  * Table 8.
@@ -25,6 +26,13 @@
 #define HSR_ANNOUNCE_INTERVAL		  100 /* ms */
 #define HSR_ENTRY_FORGET_TIME		  400 /* ms */
 
+/* Ordered-forwarding queue and work bounds. */
+#define HSR_FWD_JOBS_MAX		1024
+#define HSR_FWD_ORD_JOBS_MAX		960
+#define HSR_FWD_BYTES_MAX		(8 * 1024 * 1024)
+#define HSR_FWD_ORD_BYTES_MAX		(HSR_FWD_BYTES_MAX - 64 * 1024)
+#define HSR_FWD_BUDGET_MAX		64
+
 /* By how much may slave1 and slave2 timestamps of latest received frame from
  * each node differ before we notify of communication problem?
  */
@@ -202,6 +210,16 @@ struct hsr_priv {
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
 	spinlock_t seqnr_lock;	/* locking for sequence_nr */
 	spinlock_t list_lock;	/* locking for node list */
+	/* Ordered-forwarding queue (hsr_forward_queue.c) */
+	spinlock_t fwd_lock;
+	struct list_head fwd_queue;
+	struct work_struct fwd_work;
+	unsigned int fwd_jobs;
+	unsigned int fwd_ord_jobs;
+	unsigned int fwd_bytes;
+	unsigned int fwd_ord_bytes;
+	bool fwd_owned;		/* consumer execution ownership */
+	bool fwd_stopped;
 	const struct hsr_proto_ops	*proto_ops;
 #define PRP_LAN_ID	0x5     /* 0x1010 for A and 0x1011 for B. Bit 0 is set
 				 * based on SLAVE_A or SLAVE_B
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 88940e8014b2..971751bf38a1 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -12,6 +12,7 @@
 #include <net/rtnetlink.h>
 #include <net/genetlink.h>
 #include "hsr_main.h"
+#include "hsr_forward.h"
 #include "hsr_device.h"
 #include "hsr_framereg.h"
 
@@ -137,6 +138,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 	timer_delete_sync(&hsr->announce_timer);
 	timer_delete_sync(&hsr->announce_proxy_timer);
 
+	hsr_forward_stop(hsr);
 	hsr_debugfs_term(hsr);
 	hsr_del_ports(hsr);
 
@@ -173,7 +175,7 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (nla_put(skb, IFLA_HSR_SUPERVISION_ADDR, ETH_ALEN,
 		    hsr->sup_multicast_addr) ||
-	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, hsr->sequence_nr))
+	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, READ_ONCE(hsr->sequence_nr)))
 		goto nla_put_failure;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 1afcacac6b3c..c93bd12a6749 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -74,16 +74,10 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	}
 	skb_reset_mac_len(skb);
 
-	/* Only the frames received over the interlink port will assign a
-	 * sequence number and require synchronisation vs other sender.
+	/* Interlink RX is locally numbered and takes the ordered
+	 * consumer; the LAN A/B receive path stays synchronous.
 	 */
-	if (port->type == HSR_PT_INTERLINK) {
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		hsr_forward_skb(skb, port);
-	}
+	hsr_forward_skb(skb, port);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;
@@ -289,6 +283,7 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		netdev_rx_handler_unregister(port->dev);
+		hsr_forward_forget_port(hsr, port->dev);
 		if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
 			dev_set_promiscuity(port->dev, -1);
 		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
-- 
2.43.0

