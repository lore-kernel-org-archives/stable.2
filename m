Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA1313E38
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599111; cv=none; b=ZTjyvumFEyzR3yM8QDhLFQeH7zMeIIDtWTCCLf0FMresKaXWJaHpJmm1x3XuTJKLgImkkKOiCFt8KE4LNptDUqcp3jIkZrYdi8DUU3LgUQ/h4JDFmuh+9MYbwgMnY5+r8Ehv4obYj3CHd3mu4+Xuw8xlEIWsI2gxZTz/Fa53Hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599111; c=relaxed/simple;
	bh=kfcA0jtQM2vxhoUMmTZaEx+SFxxAGDbBXmXwON70ieU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtpQahSGiOgRfxOGJdUjaoCteWbcKR6WhirlOlu6zoj4ep7Lor+/TVR+aHgfSy8OEGOPVX2uYyd086R30ig8+JglqXRe88cGJTqIAlfUSSnhbsJn1eRWTlN1aevdmPQZ3GCrnffBgYOsNsWvsDkSxT20a5c5Rt/qNNYfBb305tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=N5G03A+f; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="N5G03A+f"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2a818fc4so91720981cf.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784599109; x=1785203909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvfid7rw/l1nHM0s2D/GVV5QJykAVKQqpYZKzlHL3SE=;
        b=N5G03A+fG9/GlYMdhKRuHKgKKLXQZaAboT50X/Rzcq9c45wDBMVflYY/k6jTQGB59t
         8oX408a2wmfvjcJ21X9q/RODA2skyu77M/2YKBnQv434bvd3bI3bV5zMmE+EPFr5uSuI
         OS5o4QOlNKypOD7Rdj4ZlZAsrVXwKET8i93UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599109; x=1785203909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvfid7rw/l1nHM0s2D/GVV5QJykAVKQqpYZKzlHL3SE=;
        b=aCjz5BvhlKruWNX9XyhLOgX3jHhHIeEHl5P+GoZQmFvdq920TMPSJYFZmg1XSVHmUp
         eZ0ogsR9oUw4W0t0SS0BaYJF6zIH73nAPFonlKhkz4kCyBweubOQeevkuy4Wsv0L5WMd
         XqfyAJDsEJC4+aR5p0tRsBLRL990q8N6OzgPI3dhiBhG9roXlTvkUKq3ZE52tFEORY4g
         gKONpbZuPVUwjyHawTJaAz6v+HkQik33f4H7GbCcBAL4WnRQdDekAsTdhBUjw/o/P1k0
         oHSuuAB1J/COCDZ8ao07H8BDuSkX08JVu9/Px0k8jyCI60mreClw0thheZsX4mqUe4xT
         LrYA==
X-Forwarded-Encrypted: i=1; AHgh+RrEwF+3iQBqSAhocUISGeNO2U4kxkWgthn9XMpvdEtM5fgZgdbaXaTqfMdS7NNGJ/fiPHOgNGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGt1tGd7sHtI9gEHHunYLSql1wXqjQXLEEkP51RHe1JBRoAlc
	QUMKldlFVnHRchwF5H3F0QtEsUXHotI0lnv2lkFp0e6KORWtQIOB43/0PO4q6TvuBsI=
X-Gm-Gg: AfdE7cknn0Z/ZEc+OhTf4dMVh0BqKX5Hu0VjrEC6hXpSDosIn7qBH5KRxLequ8Tgaxb
	OSaxraRBuD+Z+apyuqaGJQTWHDgGwS/1DpXdwB5+CKl3pVKB+h54bmyDfd47tBqxX2qFRF1V9nN
	e4dOAenirSGV22BrkdSFkwJJIjrSzKzFB21KtvUp0HaEKNcJ1NAFVoGS49SL97DBXiVoYAJAe/Z
	CvVoKoE36qoK3lRCNDOPnCFshx7TMqPB9UPheZenL1moT2NcHoTIb3c98jl7Jk8P1ZemPflv3jL
	a2wl5HAfIATxh1SfqsTCtx++p+cQhFRz9MUAMsxRXUJN8Zp6XUw5og3wBKEgPP9i4kf+w8m+Est
	2gTyzaMwPPZ7RW+MzG3poiEFLX2vvNxFb+N9ORZyZ7kq4N+Kvwq3UV9zotN0XG0g/ntik/pKRrU
	nzAs6hhv52nulpnuwU2sT2vgN71c7Ba8i6nupJeKoZwXi1zLd58sdi3/KUFchIaw5bqxbgNAWhA
	gxAqpDI9gGAsj5JxEA=
X-Received: by 2002:ac8:7d0c:0:b0:51c:94f:8ce with SMTP id d75a77b69052e-5213c201a70mr153244191cf.34.1784599109046;
        Mon, 20 Jul 2026 18:58:29 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907785839f9sm103728686d6.18.2026.07.20.18.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 18:58:28 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/packet: defer vmalloc TX_RING free until skbs finish
Date: Mon, 20 Jul 2026 18:58:24 -0700
Message-ID: <20260721015824.45829-1-kylebot@openai.com>
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

