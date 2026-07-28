Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314E3806B4
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256767; cv=pass; b=nhk0FJdMGUBfgwIA7fJKJLS9KPkuw0oKGRxzYAmJwobAhu/xUZ2b1oFbktH78/CR28qyy5HenjTEEBG/IZ/bWBntMkYTiF/NodvuCPXXb3nj5dDUDgB5Z3kRcNVDXmRz6XiVDqr2xVJfPz/LytCBSFArNL+IV7OHDELB+WsWmyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256767; c=relaxed/simple;
	bh=77MiL2U/YCApohB8H2cxzT/yviJwxN5JiOoq1SmOI9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsaqJAGtpnCC4wc4+ieqj6v0vm+zIH/zSBgjmDm+Ajx8o6PfUjdlMzkBQQGQC2nDQ/Eazg8/3I+sRhLQ3oZJbwb8TZ79AfGQToWntEYMDAaCx0vuSmDLoYBXcOK2obA5Rw4z2cFlXV113b+GTs4wp8j4y5x9O/hb+BsuI+C94HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GhqQuyOG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nmYFP034; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GhqQuyOG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nmYFP034"
ARC-Seal: i=1; a=rsa-sha256; t=1785256757; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F8ZGPPFda8sTPPbmRjzl2JpeK8wOkNwj7hbdJLLMq/me329ocbrk+ASj1FuH69813E
    qt6oHVBIPGlBlfDVFjkv3ciGJPnIwnp+9rsJBMbGBnsyzc+Xg5Zi3bSLBD6oq0Zk0w9B
    Np5A/jJVcBcb30Ta3iD1JVKpf4PAMgpteYQhwgGoX0AnT9EvlcsNlcu5zPuJ4o1xStOM
    WEPV4vRsWZCTBZX1tvL6OnQgQQPDv80L3vTaAo/NfCh/NwsXzOgnCOcPWjWl93WKTUST
    3kcghSTLQQy1Ua7NCb4ti908gURIk60f86PUlVweq2aq0u5f7sYsoS+BNNDxCqgJPL1p
    cTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785256757;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=M4UR6YwhMNzPii+70QOqGfqKOtll55m2UKZ+0m84Lcw=;
    b=qNVi31zkjOLLbrFO/ApYW+GL/5Mud6Xp8UkKf5EyT2DDx9glfNo9m12RsW1DXj+QEt
    FTpjZWiFRyLhAkiPGXldidKyAlxzuVAQV3ba//fsojqXHMdODo2k9ZX5SNd7x2L/yQAt
    W4l04u5cIE64HAejGYCB6+k/0m7WSUVloYtaH9oWeNf4Wy3B+RB0n+OvvhqSgte0YBMI
    d/oN4sXj06lC9u0MP1RKLAhg4NV6yITiP3J5nrxph4ByT4IX1U9LlFzcjWe0WYoCCuUt
    zFJELFJFRrlvdAOz3rWS3BUmJzByfhaB3mMqNgPrzKMeQn7QT13E08r6Add6IplpiaQ5
    mjIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785256757;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=M4UR6YwhMNzPii+70QOqGfqKOtll55m2UKZ+0m84Lcw=;
    b=GhqQuyOGwSO1kgvHqclki9nOrLJYqiC5WGxZyJXYyWb4Z0mzVhqDAd9FEoUvCwjzvm
    wQ5Y491B5iNn/CumvIznYGtrPP0SYv+q6IhW4teXHV6hL0jO3Y7cxH/pVL5WQmOer+PT
    Oxloi245K/THZdZsIOsckxUxcv6rRjELbUexXl/dpT2snZFiskvdDMZgcHeWu9lCrr40
    1oyKJW5yjsB7tOx14Kpl0UYCqQnnGHcBwDxo6pFRNBuxAj8CpOBkB/rx9R7nkeW7k3Iy
    7ASPwMeI4C3ETreyK/oq3v1duGhogSMzT12xeKAqJGjKWldIb2zI1S7oMso9Yt8qkNfM
    ZgIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785256757;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=M4UR6YwhMNzPii+70QOqGfqKOtll55m2UKZ+0m84Lcw=;
    b=nmYFP034jl+EbAwhAqRZUt0nz17V5cuDwsLQncoWQCy4XdrVBcaFGD3q0vtduZj5I5
    11gF43aiG4HU6dVPyvBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926SGdHNDX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jul 2026 18:39:17 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y v2 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Tue, 28 Jul 2026 18:39:02 +0200
Message-ID: <20260728163902.24067-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072013-angled-grafted-e9e4@gregkh>
References: <2026072013-angled-grafted-e9e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Lee Jones <lee@kernel.org>

commit 68973f9db76144825e4f35dfdc80fb8279eb2d57 upstream.

Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
synchronize_rcu()") replaced synchronize_rcu() in bcm_delete_rx_op()
with call_rcu() and introduced the RX_NO_AUTOTIMER flag.

However, this flag check was omitted for thrtimer in the packet rx
fast-path. During BCM RX operation teardown, a concurrent RCU reader
(bcm_rx_handler) can race and re-arm thrtimer via
bcm_rx_update_and_send() after call_rcu() has been scheduled.  Once
the RCU grace period elapses, bcm_op is freed.  The subsequently
firing thrtimer then dereferences the deallocated op, causing a UAF.

Adding flag checks to the rx fast-path (bcm_rx_update_and_send) does not
fully close the TOCTOU race and introduces latency for every CAN frame.
Conversely, calling hrtimer_cancel() directly inside the RCU callback
(softirq context) is fatal as hrtimer_cancel() can sleep, triggering
a "scheduling while atomic" panic.

Resolve this by deferring the timer cancellation and memory free to a
dedicated unbound workqueue (bcm_wq).  The RCU callback now queues a
work item to bcm_wq, which safely cancels both timers and deallocates
memory in sleepable process context.  A dedicated workqueue is used to
prevent system-wide WQ saturation and is cleanly flushed/destroyed
on module unload to avoid rmmod page faults.

Since the deferred work can now outlive the calling context by an
unbounded amount, also take a reference on op->sk when it is assigned
and drop it only once the deferred work has cancelled both timers, so a
socket can no longer be freed out from under a still-armed timer whose
callback (bcm_send_to_user()) dereferences op->sk.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Tested-by: Feng Xue <feng.xue@outlook.com>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-1-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 06ee3bfe87c9..ee2b14e56b17 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -56,10 +56,11 @@
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
 /*
@@ -87,10 +88,12 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_ALIAS("can-proto-2");
 
 #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
 
+static struct workqueue_struct *bcm_wq;
+
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
  * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
  */
@@ -100,10 +103,11 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 }
 
 struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct work_struct work;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
 	unsigned long frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
@@ -738,23 +742,40 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 	}
 
 	return NULL;
 }
 
-static void bcm_free_op_rcu(struct rcu_head *rcu_head)
+static void bcm_free_op_work(struct work_struct *work)
 {
-	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
+	struct bcm_op *op = container_of(work, struct bcm_op, work);
+
+	hrtimer_cancel(&op->timer);
+	hrtimer_cancel(&op->thrtimer);
 
 	if ((op->frames) && (op->frames != &op->sframe))
 		kfree(op->frames);
 
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
+	/* the last possible access to op->timer/op->thrtimer has now
+	 * happened above via hrtimer_cancel() - op->sk is no longer
+	 * needed by any pending timer callback, so drop our reference
+	 */
+	sock_put(op->sk);
+
 	kfree(op);
 }
 
+static void bcm_free_op_rcu(struct rcu_head *rcu_head)
+{
+	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
+
+	INIT_WORK(&op->work, bcm_free_op_work);
+	queue_work(bcm_wq, &op->work);
+}
+
 static void bcm_remove_op(struct bcm_op *op)
 {
 	hrtimer_cancel(&op->timer);
 	hrtimer_cancel(&op->thrtimer);
 
@@ -1006,10 +1027,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* tx_ops never compare with previous received messages */
 		op->last_frames = NULL;
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* initialize uninitialized (kzalloc) structure */
 		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL_SOFT);
@@ -1171,10 +1193,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* ifindex for timeout events w/o previous frame reception */
 		op->rx_ifindex = ifindex;
 
@@ -1828,15 +1851,20 @@ static struct notifier_block canbcm_notifier = {
 
 static int __init bcm_module_init(void)
 {
 	int err;
 
+	bcm_wq = alloc_workqueue("can-bcm-wq", WQ_UNBOUND, 0);
+	if (!bcm_wq)
+		return -ENOMEM;
+
 	pr_info("can: broadcast manager protocol\n");
 
 	err = can_proto_register(&bcm_can_proto);
 	if (err < 0) {
 		printk(KERN_ERR "can: registration of bcm protocol failed\n");
+		destroy_workqueue(bcm_wq);
 		return err;
 	}
 
 	register_pernet_subsys(&canbcm_pernet_ops);
 	register_netdevice_notifier(&canbcm_notifier);
@@ -1846,9 +1874,11 @@ static int __init bcm_module_init(void)
 static void __exit bcm_module_exit(void)
 {
 	can_proto_unregister(&bcm_can_proto);
 	unregister_netdevice_notifier(&canbcm_notifier);
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+	rcu_barrier();
+	destroy_workqueue(bcm_wq);
 }
 
 module_init(bcm_module_init);
 module_exit(bcm_module_exit);
-- 
2.53.0

