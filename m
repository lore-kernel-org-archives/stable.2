Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAE41D65D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888525; cv=pass; b=dUDrEtbiTjrzPbTYJQoT/R2J6Y03MlOVmim2WlnjXZv9o6MRnLFxV1oclFAzu+f+6XkugxvCNoTmxr3iepCwvh20eRNBOvkeFn/+rHbGJ+gE9IS6MD+fTGW7Zov0vzL7ojzc2raXBvr/Bos90CPNIW6ftBuMMqOPD0f2lHyxQLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888525; c=relaxed/simple;
	bh=Ikmf1ngB/fGVYj1gu2ECeq275kxS8FxaL1rAdHeEFoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9zqkOWSc3x4DMBTM1lipcld6Vptb947eY8v6YgZy50waFB1vHzKogHARM3O5M+TwCaexG09ZGQx7XmhsXQdRgmVwMvJNtAuNscsCWr1G/HyTfnYRyP/9nkKlEnm27ahuxQpHlLjKLIIiohbjUHhoZwE/pl8mskk0jjVn6DYfI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JebIEpGK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4NxBDfnR; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JebIEpGK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4NxBDfnR"
ARC-Seal: i=1; a=rsa-sha256; t=1784888519; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n9urWKLPErq5MifIF5WwEXNcX1dKKX05oWhSwbDlb1mEJE0ar4B2dJNhRMgygr3Rnr
    iFoFT+3X7iVmQ2FDIFXjFYwjGaFhLr3afLdCbjH6s0axerae7eEyKy6ECuL9cG+DWfMz
    FCSpDOXf9cMzIm7EbhtgDC8kfOm2S1xO7mSX67yv2MTx97tDwpSZcn3TYdMb5IvDa/cv
    MO8LMRKWRNaPMrow4E9RXJkJn7SNF+IRXXUAQlO8BtOPBH3/doPJlKI4hbJY/iZPN4AJ
    qMd5pUAlkxvD7UG+icoabKrtVKRajIYXfvIGYh06dDy47SWFe/gPu37Nr1lJEGwmNKt9
    DDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888519;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NKGY9n0Dgtal55ynXjPcFt9y0bl/A04ngI4Sgi4egXU=;
    b=c9f3ipLLUzIJDU9eovDienhQWfFRnGESKiR3FUsmqanL5glu9OXmvXORGTlEmCUYrg
    +7DjjstTkaENjEeBJ0MY+P7zwCFOqiOkdNr7SR3EMagfEfGfZoCXznGHJvk2Z+IPmTjs
    HGNjuB13cSpvaPi7goDCAr67jhIqFdoOOmUaK/DF0zM6/feyBYimAgB1kZqkhXlGY2b6
    2yQydbtBaDZcDwr4ofnG/XErwcCUXTgQVB7acsD+NHhaoO+vzx7taGuk3R9kxvnMLzoU
    CByb/WVQi67gLkqZQbRR9raq4TvmeJcrTNyuobACzByk24pUiRmcX+MhrbRjAiWyLk5Q
    nFwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888519;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NKGY9n0Dgtal55ynXjPcFt9y0bl/A04ngI4Sgi4egXU=;
    b=JebIEpGKMEPZGuRTrbQZRBcIfYHwS6CcslgJrqgq+NJmfTiUwAaSd9OB9KN/Tz53wr
    0r7HAFqAMoC4XEQWhGHLBkEoLkghjgMP0zvPhpWJEXLZqhC81VBov+demoQS184wGO0a
    6pp7O2ZW44EwNW8QKSyLorfLVXge5RE34nR8zbYRILLCmTmV5h4THlVkLSFygtO4KAtA
    8qZjo+0XCdizDZsUy04ipDi4KzCsilomNUW6dYynCEtg7YXCOMgfJwBgsKV1qJ+s1Sn7
    TfJXw7IhrGiE1GSBSvQE3n6UgVNA60LJg3MfOBsA6HqPtiJpnmK2+T9lN0Wo7qU24VX9
    PM7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888519;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NKGY9n0Dgtal55ynXjPcFt9y0bl/A04ngI4Sgi4egXU=;
    b=4NxBDfnRynz+OqjS8AY7gzrlbdiZD3uivh2ShfrkgStNfSYBw3suA1qMUSTXEWsMX2
    qCQ4rhSyVcVvRbTn3PAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OALxtHa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:21:59 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Fri, 24 Jul 2026 12:21:41 +0200
Message-ID: <20260724102149.16440-1-socketcan@hartkopp.net>
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

