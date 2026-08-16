Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCF3E51C5
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924621; cv=none; b=AukRNJtSpjg15PkFroy08m6LMuRmCFScre8YUiqsRKuVuEh3hXJANgelMg2PO1UD2ud610Dvladc64GpXsQ/2lZspmi2Za9/XSf/sxLEXjWW2VZzuR8AGKlvqrKywGeb3eUnKlyeJMVpC/juYQuQ4vLuY9gQwAwdUXEb7O5xoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924621; c=relaxed/simple;
	bh=j8W9v+DMvCm7xwzvpnKfgU4W0xz2PG8pXiICjfmYCyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnhT5xUfCmUWBuOclYtzJofW4TeTzfhFJ5OImItpabn4DU524whbLKEJtKJcGpooFF4ZUbuBBC0khse5yInSsxMo8FrLIsAbaFph3+yZK1EWG/ilq99pRhED1NuyU6DaUhIjxtuJ6120cdQDdZLWWdJD3DApb4IdgDwMkxCJx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ebdLJMSV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ebdLJMSV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d560775ca2so7321685ad.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786924619; x=1787529419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9zkz/bQqiUuqgiqt1pYBMReM2U8h0/2RImPaWmHL0g=;
        b=ebdLJMSVbfAsUWDWm7Qxyt+Wv6MOGUHxUwU3YKuOo5rGzAHIaQv/Y2UXRQLjeVPkxy
         rHh7M/ZsFiJJht/atvOMQnMVQWGbbQRRuLSdUO4tQkJrpM9NQYloUmOCky+TKvlpNXhk
         m6MVwoMmpcVliQw/yof7DcgggN6x1AL+lkW/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786924619; x=1787529419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9zkz/bQqiUuqgiqt1pYBMReM2U8h0/2RImPaWmHL0g=;
        b=FoYOVCl30LBmSgQktBPc94JHPFAJpoNMd+X+VSPzQHJ8JBn7b0kMZYKn7qxXw8LNzo
         E/GBkKcO/as1aYE2AZaITKSaavgu5+5eaauNnHmkiop4cJhdPQTDsCF1+ZaQSvw0rt5P
         yPQrYd6b47zZ3BgVNEDeSCw63pJe051gyR4QHOlKD96KmIvU1r4vfk4oCpWspwomV6kh
         oqRuz+i/wdKA0+V/kOEwWPXeqAJFpfg2uXEuBKlnDNfa2A+0XLSh5VizgYleVxGOCPsc
         ErXfZ68z8i6Z5GivmvS30W6D936DiHrGrCdXhvMbqh4jMwHUYw+1qVHgpcMK68eJVzbI
         uRRg==
X-Forwarded-Encrypted: i=1; AHgh+RqF7UfSShTSibQ5nciX5JG113DZtpux/D/Vp8bO8jZrKETvH48U4302T2NidjoH86sP9HoT9Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4vZGTWdPX7T0Cpntyxjmfjny/ePUZbdqzvoRljeaEXWuSZ/U
	6Iumm1AIJH4tP1Fm56zStddp9FLkVrzZIX3hgaL/ekGuZMdc7mQ5ChVBVB/CBwD2aWs=
X-Gm-Gg: AR+sD11+vYtQ8M4OmuVTzfoYpmArTeb9ddfZ3ZD1eKB/oxzrdMy8IBZKRkfNitQlaoO
	9rQOTPxmsTvveXpLq24xlak6bgVIvEPiqCHs3ZtER8rnpW0allmrUcypgCTVQu1Q/N817HymK5+
	zbG72DB8c0ZJxFcd5RsrG568MLCeuVi19suQh/fI3Ay+D2nfk3AxtjfzWd8XkFuNZ7WQvEZENHW
	cZlgmMlAviJHAoaOuC4oLe2b3F2gyun1MeThnZMln4+eXxexUW6ogHDSsKcFEcZsgq+xgDoa3wV
	2GFAkZsT8tVYKWpZXNCPowyM+bVhN6M6s2/dz+ouK1u18sZQFBwdqJyG5N5SXzNpj/XcNmHalx6
	vc1awk/pmvS9Lmyc/cEsaUN8bIYJWPZMtvP7mZ27GOgjbD1rfvXhI5vtcKh3gc+5O9HNaKwNzwG
	psWgdp0KDs5Jvh6TEaeViOrQr8IxGcnnVSf4xhALt8fe9qzsd2mLKz/18ILSu4Mr4zu0o9FbKO7
	a5e6grAh4O6zSVKfl9Jthr8C0Oz11tjbGQOKrI+xJPi23UtlWS7IEFkx0Hos4Z5kSj+Lqs=
X-Received: by 2002:a05:6a20:748a:b0:3c3:a9e1:a819 with SMTP id adf61e73a8af0-3cc71fb5781mr23180089637.24.1786924619000;
        Sun, 16 Aug 2026 16:56:59 -0700 (PDT)
Received: from com-75606.corp.openai.org ([104.241.0.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5ff42b7sm34817537eec.7.2026.08.16.16.56.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 16:56:58 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/packet: defer vmalloc TX_RING free until skbs finish
Date: Sun, 16 Aug 2026 16:56:46 -0700
Message-ID: <20260816235646.76500-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

Also recheck pending TX frames under pg_vec_lock before non-closing
ring replacement, so a racing send cannot add a pending skb between
the initial check and the ring swap.

Ring allocation can produce a mixture of page-backed and vmalloc-backed
blocks. Allocate deferred-work storage during TX ring setup when the
first vmalloc-backed block is encountered, and keep its pointer in the
pg_vec allocation header. If allocation fails, return -ENOMEM from ring
setup. On socket close, a non-NULL pointer identifies a vmalloc-backed
vector without a scan. If TX skbs remain, defer the whole vector to
system_long_wq.

After pg_vec is detached, a late destructor can skip the pending
decrement. Use socket write-memory accounting as the deferred lifetime
gate instead: an skb remains charged through its final sock_wfree(),
after all ring-frame accesses. The delayed work retains a socket
reference and reschedules itself until no TX skbs remain.

Move pending_refcnt release to packet_sock_destruct() so late skb
destructors and deferred cleanup can safely use it after
packet_release(). Page-backed teardown remains synchronous, and no lock
is added to the TX completion hot path.

Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Assisted-by: Codex:gpt-5.6-sol
---
Changes in v2:
- Allocate cleanup work during setup, only for vmalloc-backed TX rings.
- Keep its pointer in the pg_vec allocation header; remove the teardown
  detection scan, allocation, and synchronous fallback.
- Use socket write-memory accounting for both the close-time decision
  and the deferred worker.
- Recheck pending TX frames under pg_vec_lock before non-closing swaps.
- Rebase onto f5bbbfec59b4.

 net/packet/af_packet.c | 96 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 435756877aba..7bb5d8ca1593 100644
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
@@ -1341,6 +1342,8 @@ static void packet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 
+	packet_free_pending(pkt_sk(sk));
+
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_err("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -2534,11 +2537,11 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		__u32 ts;
 
 		ph = skb_zcopy_get_nouarg(skb);
-		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
+		packet_dec_pending(&po->tx_ring);
 		complete(&po->skb_completion);
 	}
 
@@ -3204,7 +3207,6 @@ static int packet_release(struct socket *sock)
 	/* Purge queues */
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	packet_free_pending(po);
 
 	sock_put(sk);
 	return 0;
@@ -4367,11 +4369,26 @@ static const struct vm_operations_struct packet_mmap_ops = {
 	.close	=	packet_mm_close,
 };
 
+struct packet_pg_vec {
+	struct packet_pg_vec_free *deferred;
+	unsigned int order;
+	unsigned int len;
+	struct pgv pg_vec[] __counted_by(len);
+};
+
+struct packet_pg_vec_free {
+	struct delayed_work work;
+	struct sock *sk;
+	struct packet_pg_vec *vec;
+};
+
 static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 			unsigned int len)
 {
+	struct packet_pg_vec *vec;
 	int i;
 
+	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
 	for (i = 0; i < len; i++) {
 		if (likely(pg_vec[i].buffer)) {
 			if (is_vmalloc_addr(pg_vec[i].buffer))
@@ -4382,7 +4399,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 			pg_vec[i].buffer = NULL;
 		}
 	}
-	kfree(pg_vec);
+	kfree(vec->deferred);
+	kfree(vec);
+}
+
+static void packet_free_pg_vec_work(struct work_struct *work)
+{
+	struct packet_pg_vec_free *deferred;
+	struct packet_pg_vec *vec;
+	struct sock *sk;
+
+	deferred = container_of_const(to_delayed_work(work),
+				      struct packet_pg_vec_free, work);
+	vec = deferred->vec;
+	sk = deferred->sk;
+	if (sk_wmem_alloc_get(sk)) {
+		queue_delayed_work(system_long_wq, &deferred->work, 1);
+		return;
+	}
+
+	free_pg_vec(vec->pg_vec, vec->order, vec->len);
+	sock_put(sk);
+}
+
+static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
+				unsigned int order, unsigned int len)
+{
+	struct packet_pg_vec_free *deferred;
+	struct packet_pg_vec *vec;
+
+	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
+	deferred = vec->deferred;
+	if (!deferred || !sk_wmem_alloc_get(sk)) {
+		free_pg_vec(pg_vec, order, len);
+		return;
+	}
+
+	/* A detached ring's pending count can miss late skb destructors. */
+	deferred->sk = sk;
+	sock_hold(sk);
+	queue_delayed_work(system_long_wq, &deferred->work, 0);
 }
 
 static char *alloc_one_pg_vec_page(unsigned long order)
@@ -4410,20 +4466,35 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 	return NULL;
 }
 
-static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
+static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring)
 {
 	unsigned int block_nr = req->tp_block_nr;
+	struct packet_pg_vec *vec;
 	struct pgv *pg_vec;
 	int i;
 
-	pg_vec = kzalloc_objs(struct pgv, block_nr, GFP_KERNEL | __GFP_NOWARN);
-	if (unlikely(!pg_vec))
-		goto out;
+	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
+	if (unlikely(!vec))
+		return NULL;
+	vec->order = order;
+	vec->len = block_nr;
+	pg_vec = vec->pg_vec;
 
 	for (i = 0; i < block_nr; i++) {
 		pg_vec[i].buffer = alloc_one_pg_vec_page(order);
 		if (unlikely(!pg_vec[i].buffer))
 			goto out_free_pgvec;
+
+		if (tx_ring && !vec->deferred &&
+		    is_vmalloc_addr(pg_vec[i].buffer)) {
+			vec->deferred = kzalloc_obj(*vec->deferred,
+						    GFP_KERNEL | __GFP_NOWARN);
+			if (!vec->deferred)
+				goto out_free_pgvec;
+			vec->deferred->vec = vec;
+			INIT_DELAYED_WORK(&vec->deferred->work,
+					  packet_free_pg_vec_work);
+		}
 	}
 
 out:
@@ -4506,7 +4577,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 		err = -ENOMEM;
 		order = get_order(req->tp_block_size);
-		pg_vec = alloc_pg_vec(req, order);
+		pg_vec = alloc_pg_vec(req, order, tx_ring);
 		if (unlikely(!pg_vec))
 			goto out;
 		switch (po->tp_version) {
@@ -4558,6 +4629,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
 	if (closing || atomic_long_read(&po->mapped) == 0) {
+		if (tx_ring && !closing && packet_read_pending(rb))
+			goto out_unlock;
+
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4579,6 +4653,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			pr_err("packet_mmap: vma is busy: %ld\n",
 			       atomic_long_read(&po->mapped));
 	}
+out_unlock:
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
@@ -4600,7 +4675,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 out_free_pg_vec:
 	if (pg_vec) {
 		bitmap_free(rx_owner_map);
-		free_pg_vec(pg_vec, order, req->tp_block_nr);
+		if (tx_ring && closing)
+			packet_free_tx_ring(sk, pg_vec, order, req->tp_block_nr);
+		else
+			free_pg_vec(pg_vec, order, req->tp_block_nr);
 	}
 out:
 	return err;

base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.55.0.openai.347.g2b0ba75e4a61
