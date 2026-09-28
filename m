Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245E44A3F0
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577780; cv=none; b=Csc/7dHQQyr7emSiTL2DhyDAFg99VV2I4CcJxBX3Gah6FQr9cs9HMoU7raUZ11JXcCn+JzkG7NL5LRpgJyRJOc54hFYu3GQC41ofuRgJLcxA+4oKKW1LQkfYMshgDXhKko79kNBc7koSvcUGMTHcvEjpoGmM9rk8lpXwN7ycjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577780; c=relaxed/simple;
	bh=MyorId+LNXDQ3tBXVrKOG34/XwgfgE8q2c/oj8aOYQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j75pkqOovzXv6CBObkci8B+JhAep+6+0TjiH2QDgMkrabXyJ2KpmAlYYEUhYDdu6RlYSakYXuyP5rQ0qRvKpFoNvrjAID6TWlsG1mEMsVMBdEq+TO+Mi4CJ0yvtpRTd35oZV2KuhtwUp1kP+KKAXFR6CyxcM9FlsvMqsgtX063Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHTim2KB; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHTim2KB"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f6cf16bso1554966f8f.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577776; x=1791182576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nf3oV330ckZwsw/LTGlRTnwET/Uw246suYw2VNp67Og=;
        b=YHTim2KBMbvqW33SiIfC8KTjygBmq5593rctZM1E5bnqhT8BRn2lOE0yHsky3OSOvi
         Q0+F3KqiIv7BpOy44YhbEScQZKi+EGf4sgwErJaJV+uPLvyw13Z8o2HnwptR2gk/P85r
         uzE5iUETSYMae9NBVmqBDlt9UNlal72/Us+VJJJHTZtEaGSmXt2lNEv6LLRIZc1uWSlh
         PpZw+I9C2bcJsuhCwNsxNAHDnnpBkZZNlKozqopOCZBaJuKNm10grlCwnlgRXioU0jwB
         BSi+zJjMx+3UdwWHHwWliySPJGOjVGYUwNx14q86FlpPo4J+Ydu2Xk6bNPqnhTYXjh7d
         Q3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577776; x=1791182576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nf3oV330ckZwsw/LTGlRTnwET/Uw246suYw2VNp67Og=;
        b=CTMORZAK8V6MdFe/YhtLKbuvU45uJG8tEE4mTA5DyxIaMt4CMLEVidrESm3lt18X7b
         XtSo+gwh3tOtBZ3wXLdMJ5SnEG16fmHuzC5FECkKRIKElIn0ADoIpuPLw/rPx85qs22W
         eF7F0Wz1nKS1sBLa169nRXSVfQRUnxAruHUMownkDQmobXSR6OEG9UHyRvA1OYxoK17y
         34RbdrQ+prFjfNAEBRJPaRjGQB+IJ3SpGiYD+F8L71AGD9W1Be4mMvJ76vSeTL37DxwZ
         RPI/NMhpAlWV1IXX6hvmtvnV4gLPEucgH6ZP9XGaH/DlIzA4I3bN7gKWykIm9dXCZLTJ
         8AjA==
X-Forwarded-Encrypted: i=1; AKwUvBzIzkAd7h0lawP7FyavRo/CNVtfbIQWMtI3Zo7OwqAuY1rWvlUuOv6SGwo2yJhafvwhCA6Lerc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd//Khao3+5UPcj/Ce21BbCt8lLTutHQdpBIunv/noFJfr1d55
	qvFg4FWTQI6nrDRDIM5oVKj1inXALWEDykQDh59hZLbspYmVlHWs84lN
X-Gm-Gg: AYBFou2Vu6f4jdvti2qJouNs4bTL9if4YwTMt+OfVY1Ctmp4Up9Uf5Dxier2aOw2ooI
	81ehYLlMYpE8Dc+ER2VplYDje/PKOuA31EgC2FkfgXn0kowSvV8bLODaXH6obvcxrzQXdGI658R
	HLnvfu57cYrkffGFK21OTrXJmFxKxt9hYU0UKe33sGvX3L+nqmI6hhkFQI1qANQfhkpZfbO6Ffz
	Z6whVRD/nR+gX1QMdAgA/lJuKHVbUtdY8SzCaVx7ljFxk3n4aBnrt0K7dPSEr8GVCvFNU0eVVPB
	041+TkqR6iYqJ3iCMr0FHj7tK/E8u39ilWet2ZaAykHYNhLSrMqyCE8CEcn8McW/nENOH0Upiw/
	MK3Nh/fordECwdAicQBbkYh5YoJeM9ysyouo/wSfOi40Kcjbo+goUESl6eCCqNug6V+E37Bn0CC
	bvH4fvlM8vmZsw/MYaQMteL8PeN+2K2kXCXdwjeBJ/jtnkT2EsWAH787y1FTYvxMnVarou4p7Je
	bFDkmMi3/wilT9GmhNsKmZf6dP+rExMUjltrMHyk21Fd1s/54trMhogoTzWMlXZ9zqaau6G1QAi
	NoEOX993LXM3O9LQzNzKFue8G3jTHYQ8Kg+RwtrAJN9IR3M/H/Fcakd6zcckTjSBtkRvYNw6ypk
	JvSHiPg==
X-Received: by 2002:a05:6000:2909:b0:487:ff2:14f5 with SMTP id ffacd0b85a97d-4887d9fa53dmr18309491f8f.4.1790577775945;
        Sun, 27 Sep 2026 23:42:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] netpoll: use a raw lock for the deferred transmit queue
Date: Mon, 28 Sep 2026 08:42:38 +0200
Message-Id: <20260928064239.32456-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260928064239.32456-1-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_send_skb() calls __netpoll_send_skb() with hard interrupts
disabled. When direct transmission cannot complete, the latter queues
the skb with skb_queue_tail(). The sk_buff_head lock may sleep on
PREEMPT_RT:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0
  rt_spin_lock
  skb_queue_tail
  netpoll_send_skb

The delayed transmit worker has the same problem when it requeues a busy
skb with skb_queue_head() after disabling interrupts.

Add a dedicated raw spinlock and use the unlocked skb queue helpers under
it. Keep raw critical sections limited to queue operations. During
cleanup, splice the queue to a private list before freeing its skbs.

Fixes: b6cd27ed3388 ("netpoll per device txq")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 75 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1c6b1eec5efd6..e20e0592e9349 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -47,6 +47,7 @@ struct netpoll_info {
 	struct semaphore dev_lock;
 
 	struct sk_buff_head txq;
+	raw_spinlock_t txq_lock;
 
 	struct delayed_work tx_work;
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index fe1e0cda5d6bf..e0cfcb05468e2 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -79,6 +79,68 @@ static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 	return status;
 }
 
+/*
+ * Transmit paths can access txq with hard IRQs disabled. Use a raw lock
+ * because the skb queue lock may sleep on PREEMPT_RT.
+ */
+static bool netpoll_txq_empty(struct netpoll_info *npinfo)
+{
+	unsigned long flags;
+	bool empty;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	empty = skb_queue_empty(&npinfo->txq);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+
+	return empty;
+}
+
+static struct sk_buff *netpoll_txq_dequeue(struct netpoll_info *npinfo)
+{
+	unsigned long flags;
+	struct sk_buff *skb;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	skb = __skb_dequeue(&npinfo->txq);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+
+	return skb;
+}
+
+static void netpoll_txq_queue_head(struct netpoll_info *npinfo,
+				   struct sk_buff *skb)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	__skb_queue_head(&npinfo->txq, skb);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+}
+
+static void netpoll_txq_queue_tail(struct netpoll_info *npinfo,
+				   struct sk_buff *skb)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	__skb_queue_tail(&npinfo->txq, skb);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+}
+
+static void netpoll_txq_purge(struct netpoll_info *npinfo)
+{
+	struct sk_buff_head purge;
+	unsigned long flags;
+
+	__skb_queue_head_init(&purge);
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	skb_queue_splice_init(&npinfo->txq, &purge);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+
+	__skb_queue_purge(&purge);
+}
+
 static void queue_process(struct work_struct *work)
 {
 	struct netpoll_info *npinfo =
@@ -86,7 +148,7 @@ static void queue_process(struct work_struct *work)
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	while ((skb = skb_dequeue(&npinfo->txq))) {
+	while ((skb = netpoll_txq_dequeue(npinfo))) {
 		struct net_device *dev = skb->dev;
 		struct netdev_queue *txq;
 		unsigned int q_index;
@@ -107,7 +169,7 @@ static void queue_process(struct work_struct *work)
 		HARD_TX_LOCK(dev, txq, smp_processor_id());
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
-			skb_queue_head(&npinfo->txq, skb);
+			netpoll_txq_queue_head(npinfo, skb);
 			HARD_TX_UNLOCK(dev, txq);
 			local_irq_restore(flags);
 
@@ -282,7 +344,7 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 
 	/* don't get messages out of order, and no recursion */
-	if (skb_queue_len(&npinfo->txq) == 0 && !netpoll_owner_active(dev)) {
+	if (netpoll_txq_empty(npinfo) && !netpoll_owner_active(dev)) {
 		struct netdev_queue *txq;
 
 		txq = netdev_core_pick_tx(dev, skb, NULL);
@@ -314,7 +376,7 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 
 	if (!dev_xmit_complete(status)) {
-		skb_queue_tail(&npinfo->txq, skb);
+		netpoll_txq_queue_tail(npinfo, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
 	ret = NETDEV_TX_OK;
@@ -362,7 +424,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		}
 
 		sema_init(&npinfo->dev_lock, 1);
-		skb_queue_head_init(&npinfo->txq);
+		__skb_queue_head_init(&npinfo->txq);
+		raw_spin_lock_init(&npinfo->txq_lock);
 		INIT_DELAYED_WORK(&npinfo->tx_work, queue_process);
 
 		refcount_set(&npinfo->refcnt, 1);
@@ -397,7 +460,7 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 	struct netpoll_info *npinfo =
 			container_of(rcu_head, struct netpoll_info, rcu);
 
-	skb_queue_purge(&npinfo->txq);
+	netpoll_txq_purge(npinfo);
 	kfree(npinfo);
 }
 
-- 
2.53.0
