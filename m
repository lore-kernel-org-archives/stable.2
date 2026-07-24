Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735941D647
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888057; cv=pass; b=BeF3AZMQYoN0YSIuevd8eOH/m9f+Z5VNvLesoEqlH89AyGiz5VFZp3R1jlbrDv2JekwSgmdbHYZzDRNJj6VixX72udS+Nnsq5MRdSph0d7zSx1jIv7EK1ChEuA2tVqdg8zF4w768ZkViDNBlKUmXGsqLAtHUdhLxW5jQ33LNeto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888057; c=relaxed/simple;
	bh=44PX0YRp+RbvY59/QbmDeA34raxv1RZbSZuZIoXabjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPaqeuI7md7PKM3HNjtVbWYK4oiJNCabDHB3opdOY25uHWACyQMD/86hxq5b6csuSkPhjWq52S56JSPgWx97IrrF8mIiQOYCCCGvc/GmJ6uRnvQetjZbJz/I35OftRRbdZHYmAmSSUa1jV0SqBS5zMCugXEoXJaiHBP4Y3YfmHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NaGgz3u9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dwMfpfry; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NaGgz3u9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dwMfpfry"
ARC-Seal: i=1; a=rsa-sha256; t=1784888045; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=izuLOoq1656N5lvWI93Un8YPyZyZtCfZN5UCceUb/e2dy1tp7+GNmce4lhH2VVs9SV
    EqZAqcr+oCM//stMXq96p6aJPusFipRSILArGrSb+agcCjVAk45+T4hq///ve/huKE9k
    lD/XK/ExFlRIowVP051p7rSTZOTulmhhpGsN0q7hBRsQV0JKNFcxyOntEqRukte4UB6v
    ODwYig5UrQRCHG0O0Nf6GszjP5sB/mXcow/of2EmMb0GaF6UEeKkTYKjN2BZaq4HgNLS
    Ryy7mvHKqMG6OdSy/o1XABDDFEHODVDt/62K37SqNWnsMO9m1eqg6aAf2d4JS3YnQhf2
    njcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888045;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wmRsTejdUQt1tchcFSNc+Z/TMRxlJQrvo9dGKm1IXxQ=;
    b=C4yyguvK3Dtwe27AleloG8Et06nJdK8+8nOWnNcMukvGDR4VY1cX8/gqNrjGyY8WfO
    rXlsjVB011KmVxAeBZcz4JxBoPnsz6DYt3Jn4MVJOnRmLH7KpYKW0bng7QpDYrcZMqaI
    IzSe0SnczoZ76QbfOXszk+7qHy0f1v3o1xEYUcw3ipDFufhVqgfTbqBB3x1zY0KH77gP
    x+p1nwn5e/8mnZ9BcGqbvTTsKWPeFGGUCgDjxYcuuMFSOdtbiSmly3QsWIX0SGZ/lUch
    8GsMAqbw/CpnX52PbFDPI/4NNDM9vUK8RenoE/dl9pzCHTtP2X2eQpvfYE2SPGgfUg+j
    XWeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888045;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wmRsTejdUQt1tchcFSNc+Z/TMRxlJQrvo9dGKm1IXxQ=;
    b=NaGgz3u9MfpnqZ/8iXa8Dap2Wnayo2l3Jak6aI16XZ7bVx1JT//r507wz9Ry1trAvi
    wfocpJ3VRGXy3cGoMqRgrS1in1aDcMUZT6SuMsWXUpVPTSuZFV76henWUmkkf06k9iKE
    n1t2o043ymKowKbSjadq8upoPCplzgGjHp98js0YVroxzGQ0EVzZZzJQ6b/+Sl5r1+SI
    i3oWPXYL/yXQ07eZu5OqfqyBnhm4YMvetscDXyAQW72MN44NPpDu4vmYjhs7xHalHRjU
    ufiICyNXmrUHlywGx/Ld53KXvbP6ISMABZki8dLE8EDQJjpnr98j84Kw91Ugqt8TE7kn
    8+kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888045;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wmRsTejdUQt1tchcFSNc+Z/TMRxlJQrvo9dGKm1IXxQ=;
    b=dwMfpfryPqNlHdKZ/qH8XRGBubSNUwUSyw3mOBW89wam/WZDFIVn7C9h8gmO7o+VaA
    gvQ741/IDPU4K2VFxcCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAE5tFB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:14:05 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10.y 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Fri, 24 Jul 2026 12:13:34 +0200
Message-ID: <20260724101342.16000-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072037-bagginess-bluish-c081@gregkh>
References: <2026072037-bagginess-bluish-c081@gregkh>
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
 net/can/bcm.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 06ee3bf..859816d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
@@ -89,6 +90,8 @@ MODULE_ALIAS("can-proto-2");
 
 #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
 
+static struct workqueue_struct *bcm_wq;
+
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
@@ -102,6 +105,7 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct work_struct work;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
@@ -740,9 +744,12 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
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
@@ -750,9 +757,23 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_head)
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
@@ -1008,6 +1029,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* initialize uninitialized (kzalloc) structure */
@@ -1173,6 +1195,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* ifindex for timeout events w/o previous frame reception */
@@ -1699,7 +1722,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 #if IS_ENABLED(CONFIG_PROC_FS)
 	if (net->can.bcmproc_dir) {
 		/* unique socket address as filename */
-		sprintf(bo->procname, "%lu", sock_i_ino(sk));
+		sprintf(bo->procname, "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
@@ -1830,11 +1853,16 @@ static int __init bcm_module_init(void)
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
 
@@ -1848,6 +1876,8 @@ static void __exit bcm_module_exit(void)
 	can_proto_unregister(&bcm_can_proto);
 	unregister_netdevice_notifier(&canbcm_notifier);
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+	rcu_barrier();
+	destroy_workqueue(bcm_wq);
 }
 
 module_init(bcm_module_init);
-- 
2.43.0

