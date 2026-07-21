Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5F3FE65D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598986; cv=none; b=LfPJTauUr3mR5bFArUyMxEhRMvP7+myeUOGblAbyipWR0hnWG5MvqIhTVmXsQYGNotwxCH96ryLC0AOXOOVnWSyGQhCS62JdQv7rlcGt02Ya0LDuV2yYHWtuchLeoCdUJlIpqSPkvJjyb9129irB2mVtwabZo1XQALgwLYIUBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598986; c=relaxed/simple;
	bh=kfcA0jtQM2vxhoUMmTZaEx+SFxxAGDbBXmXwON70ieU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2ewzNLbpxaRAo+12lJQG/teVRZG5SbnTtCS81KbJxptQDqPP4o9HgM21+O4DMfGSNPPGFWFPz5yEamklLC+I1QXfJmt3bJYhf24Df25qa0N6yrBJ6Yek+vS3/GhoA0eFgS9kRlYSmZerfq+ahc6g3VZ1zugPRIVIyfm/EOl1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=d+L9zjcA; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="d+L9zjcA"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ff88549786so133039546d6.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784598984; x=1785203784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvfid7rw/l1nHM0s2D/GVV5QJykAVKQqpYZKzlHL3SE=;
        b=d+L9zjcAogt5hQxlRwYCDEx9cdBMgvQcDEAXPvUvZqdDBEEbgb9zNgc/PKbLELl8ck
         3E2vxI2vRqcda5ot9VvkmSqApxSkpX+5FaDlDZdL9qKKerOS+mU84+HdGMxUzLgW7JK+
         hkhRUnGAbT8kxRg+afx0ity60L5a1E61lPlqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598984; x=1785203784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvfid7rw/l1nHM0s2D/GVV5QJykAVKQqpYZKzlHL3SE=;
        b=byBd+ZvdBWOgYr/77i0nvf0tMrMjTQzjUa5DwVwhfTblYdI6NlVQaNMzakbO+mCiKB
         nvNjpeyyLMAZ6PWPBFAANwE9DLbqult/tq3TukHhJ0g2BeVPbCsIT1BQVXr9Nf20aDeZ
         Q0DRgejgtWLobEigC/szUO0qMrbYC/Mb9qfHkSJHupnUt3sDunlbTcUCwpbyq46Rzb/n
         XBy1zsDJu7MAQQ6i0I3kTGi5EQHmk74q6G6EuZMrVSJb5BN6hBV6NkQclW2+Dqk+7kbk
         Vh9VNOyYf7KuaToMnwMzd3naQcvyB20wZzcEi5pYNw4e//5nn2kwgGYVQ6FjfbwJ09Ng
         1Uyg==
X-Gm-Message-State: AOJu0YwjBu+zmmlp0gDAmclJ4yymryFeTY8Xfirpfk14icK8TWD4enQV
	kFXcDGDc9VgC4b41ACXiREk0g/NmEwqIKVghzAdkV4asNUr/CGsPz93el18FK+4P/rs=
X-Gm-Gg: AR+sD13iPPmra2RN9GQrM9LXMl+a1pebYAX7d+IodzX49shrlV2Sd1Q7LxWMvLbgyzd
	vPJGkv6Y664kqUiMEZOgvbsw3F34XWqqtpYyMsbcjBuLxwfne9wQWdKF6swiiLsbT78Xa8uGhvW
	aPDyNN9z0x4tC3zG7yrMqWJjp5sG9Wk/G1m+klwb/3ZnIy4eGxJoq8HZcCT4HWOgKsLGveY6hRL
	HQ6kCmv728w/WlBdJFhRwiGF8Bm79Qc9MUrYWG9QBOztnkl1OcTyfUUjbg+NIAmyzAPL3dksiQf
	vquH2NIXq9FhTHkBC0PreYBnkQcvKiId2AWj73gL8j2dFR6QLfv/fyipmTHiR0aMgq1Ixcc+/Pn
	6ckpgf6tdOBVOQ1cyMT1YMKcQziPNTbK33o2Pe65exkqj2bQgxDt0l4SJBSILbJS65t7QdnIyHU
	K00uBxawAGTn9wifAO2iYOWFGpKuz4IC6FtpEq78sDXzapQ2NOniB15gp2SQPRtybHi2+HvGEI5
	Qis1fYk
X-Received: by 2002:a05:6214:d6d:b0:8ef:4749:b1cb with SMTP id 6a1803df08f44-9077831388cmr182263386d6.6.1784598983949;
        Mon, 20 Jul 2026 18:56:23 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778543d85sm104247446d6.3.2026.07.20.18.56.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 18:56:23 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: stable@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net] net/packet: defer vmalloc TX_RING free until skbs finish
Date: Mon, 20 Jul 2026 18:56:18 -0700
Message-ID: <20260721015618.44688-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
page references preserve page-backed ring blocks after pg_vec is freed,
but they do not preserve a vmalloc mapping.

tpacket_destruct_skb() currently drops the pending reference before
writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
decrement after those stores. The smp_wmb() in __packet_set_status()
orders the frame stores before the decrement.

On socket close, scan every pg_vec entry because allocation can produce
a mixture of page-backed and vmalloc-backed blocks. If any block is
vmalloc-backed and TX skbs remain pending, defer the whole vector to
system_long_wq.

After pg_vec is detached, a late destructor can skip the pending
decrement. Use socket write-memory accounting as the deferred lifetime
gate instead: an skb remains charged through its final sock_wfree(),
after all ring-frame accesses. The delayed work retains a socket
reference and reschedules itself until no TX skbs remain. Fall back to
a synchronous wait if the work allocation fails.

Move pending_refcnt release to packet_sock_destruct() so late skb
destructors and deferred cleanup can safely use it after
packet_release(). Page-backed teardown remains synchronous, and no lock
is added to the TX completion hot path.

Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
Cc: stable@vger.kernel.org
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/packet/af_packet.c | 90 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..1a4c548c59ac 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -88,6 +88,7 @@
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 #include <linux/percpu.h>
+#include <linux/workqueue.h>
 #ifdef CONFIG_INET
 #include <net/inet_common.h>
 #endif
@@ -1329,6 +1330,8 @@ static void packet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 
+	packet_free_pending(pkt_sk(sk));
+
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_err("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -2516,14 +2519,12 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		__u32 ts;
 
 		ph = skb_zcopy_get_nouarg(skb);
-		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
-
+		packet_dec_pending(&po->tx_ring);
 		complete(&po->skb_completion);
 	}
-
 	sock_wfree(skb);
 }
 
@@ -3182,7 +3183,6 @@ static int packet_release(struct socket *sock)
 	/* Purge queues */
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	packet_free_pending(po);
 
 	sock_put(sk);
 	return 0;
@@ -4345,8 +4345,16 @@ static const struct vm_operations_struct packet_mmap_ops = {
 	.close	=	packet_mm_close,
 };
 
-static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
-			unsigned int len)
+struct packet_pg_vec_free {
+	struct delayed_work work;
+	struct sock *sk;
+	struct pgv *pg_vec;
+	unsigned int order;
+	unsigned int len;
+};
+
+static void __free_pg_vec(struct pgv *pg_vec, unsigned int order,
+			  unsigned int len)
 {
 	int i;
 
@@ -4363,6 +4371,69 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 	kfree(pg_vec);
 }
 
+static void packet_wait_for_tx_skbs(struct packet_sock *po)
+{
+	while (sk_wmem_alloc_get(&po->sk))
+		wait_for_completion_timeout(&po->skb_completion, 1);
+}
+
+static void packet_free_pg_vec_work(struct work_struct *work)
+{
+	struct packet_pg_vec_free *deferred;
+	struct sock *sk;
+
+	deferred = container_of(to_delayed_work(work),
+				struct packet_pg_vec_free, work);
+	sk = deferred->sk;
+	if (sk_wmem_alloc_get(sk)) {
+		queue_delayed_work(system_long_wq, &deferred->work, 1);
+		return;
+	}
+
+	__free_pg_vec(deferred->pg_vec, deferred->order, deferred->len);
+	kfree(deferred);
+	sock_put(sk);
+}
+
+static bool pg_vec_has_vmalloc(struct pgv *pg_vec, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (pg_vec[i].buffer && is_vmalloc_addr(pg_vec[i].buffer))
+			return true;
+
+	return false;
+}
+
+static void free_pg_vec(struct packet_sock *po, struct pgv *pg_vec,
+			unsigned int order, unsigned int len)
+{
+	struct packet_pg_vec_free *deferred;
+
+	if (!pg_vec_has_vmalloc(pg_vec, len) ||
+	    !packet_read_pending(&po->tx_ring)) {
+		__free_pg_vec(pg_vec, order, len);
+		return;
+	}
+
+	deferred = kmalloc(sizeof(*deferred), GFP_KERNEL);
+	if (!deferred) {
+		packet_wait_for_tx_skbs(po);
+		__free_pg_vec(pg_vec, order, len);
+		return;
+	}
+
+	INIT_DELAYED_WORK(&deferred->work, packet_free_pg_vec_work);
+	deferred->sk = &po->sk;
+	deferred->pg_vec = pg_vec;
+	deferred->order = order;
+	deferred->len = len;
+
+	sock_hold(deferred->sk);
+	queue_delayed_work(system_long_wq, &deferred->work, 0);
+}
+
 static char *alloc_one_pg_vec_page(unsigned long order)
 {
 	char *buffer;
@@ -4408,7 +4479,7 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
 	return pg_vec;
 
 out_free_pgvec:
-	free_pg_vec(pg_vec, order, block_nr);
+	__free_pg_vec(pg_vec, order, block_nr);
 	pg_vec = NULL;
 	goto out;
 }
@@ -4574,7 +4645,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 out_free_pg_vec:
 	if (pg_vec) {
 		bitmap_free(rx_owner_map);
-		free_pg_vec(pg_vec, order, req->tp_block_nr);
+		if (tx_ring && closing)
+			free_pg_vec(po, pg_vec, order, req->tp_block_nr);
+		else
+			__free_pg_vec(pg_vec, order, req->tp_block_nr);
 	}
 out:
 	return err;
-- 
2.54.0

