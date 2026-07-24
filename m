Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D2F3AD51E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882299; cv=pass; b=cgiNuD3Z7psFE6Y8uQsW3qsQEnP61Q+6XvJl/rEeGnxYkENDm/AOsE89fLIDGJccrwBzi+dEbBbR6BCQAxKSNRb0hmGG7ebIwks1vtDNjCj/lrbFoY3dORRufDfk40HwbMHbuvmBI+IlmhIlMJs6FS2HXIZYGHI1VtBBQ8p4eWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882299; c=relaxed/simple;
	bh=Ikmf1ngB/fGVYj1gu2ECeq275kxS8FxaL1rAdHeEFoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOIIpOFTfFXGOsQzXX3IJI2RTeBQ2+1dAKYk5d04uEBzmvCGjKHr3n0ONR/Kaltz3BTZlYhCJwkjjzwkiSYNNmg4qq1L/WiE1joBabV9nuHTEAX87n1/DXGwDCUL784dkwnsZkoP7iTk2xTHDBsk3wpHPay0DfY9S/FeMl2/5kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N1b3O7Kx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1Nogy3oL; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N1b3O7Kx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1Nogy3oL"
ARC-Seal: i=1; a=rsa-sha256; t=1784882287; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sGMPYM+rERqidhajXZoVL0dPcdCoCB0fdGbQjPC9ze8LyeDHgpsv5zaRC3IPPAPS8V
    q/GPwUFE1D4SF6fwftIKiOlsnnT9CfgsZKBqOZn9XTMSlffPzFhmifXePHHDukBiK8zH
    UstHRdWOnH2O6FO63rrrKIvzF5rbU3u9B7zPwifzcakj0PGqn8lhFmf3CdNRkucjnp10
    oEDyawRuOANuHv5yyMlVAdg6SHPHnWfFwzGfbWZaHK6Y7SqNRGSi3vSAf1ia87j/CROs
    ZppUbnjbJ9UYhbklZXvYz4xe7GfjehMJ9Qnq3ba09AtpVhIGc8kcmggjtygnNzLwgonw
    jgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882287;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NKGY9n0Dgtal55ynXjPcFt9y0bl/A04ngI4Sgi4egXU=;
    b=W7Pq4j+wo7boTkHz8B++AmsMVnaYwFDyffSt2WvqwGByUU2BtHkLJPlW5N8O/7aAiD
    Xg6UPCR2+rfBIvpTZ89QsR1YVsibh/F/3tSbTizAk3Tjg55hGOLLP1vPhGfOKGD2obFf
    6cypoD7JGq2qWCS8Psw/H9vmW6kwCcmntbKNIMav5bDKsbL+oeV8LLagt/Trve8u3BYL
    Fodrv7S7rgAkGvrkIOqKi0u/RBWcSMye1R29C4qFCLvi0kPlWL6QVzrgk5ef88YHP3LW
    R+c5JrZH/TLn/tmiDQf476PUAVllVnGpiwykzxX3/Lej/gmE9B46chMS2EPmPA8glAf5
    /XLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882287;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NKGY9n0Dgtal55ynXjPcFt9y0bl/A04ngI4Sgi4egXU=;
    b=N1b3O7Kx2cKOiBNLFAAbpj6MwNepjh9juuPXXMqAaGNvVzr4onwQ0AMA4zFnzAtBu6
    erM9Bz9bHP3wj6nz+X+QuwJAoz/DNmL880ERiHFam+NqEUzJXT2fgq9b5immqYeoD0zS
    36IBW9t89ErRjkZMaugEa2yF76c3ducMs+UuCxvf0+v4hH4Y+ScBJbzvDOKR9o93EV+Y
    rZUU6VCRgKCKp8JMlMRo3XCsogs6GvvQ7+SB3AVwOB3ODQifju3Ysboa/B01itMQF9a3
    jt9LX592OdKJBV0po5TkoJ3b2jVH8U+p9Eo83KcO7NO3IacyrUCTt1hR/cfOzYSliXbB
    NuNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882287;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NKGY9n0Dgtal55ynXjPcFt9y0bl/A04ngI4Sgi4egXU=;
    b=1Nogy3oLH8fvQDmPbT9Iff+H9XntpHlFrbwuTli36mh04Brdm7H6VkIsHO6cJlCOsa
    yB5fiyY7hmHOUx5Z6xBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8c6rQ0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:38:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Fri, 24 Jul 2026 10:37:48 +0200
Message-ID: <20260724083756.12430-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072036-giving-knee-3a33@gregkh>
References: <2026072036-giving-knee-3a33@gregkh>
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
index 317cd4c..05ef139 100644
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

