Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405683;
	b=fe+wIRtR03KN22R0YIvTp/B1uZiupUv+Tj6BI151tj0rfh8YHkfrOah2iG1bPgXFFKzq
	 mOdu6FjG23N1VyOXN+7q8OClX32Lf8enaF9qC/w9IKpsYX5dBFHGknB8sUz8g7y0+7mtf
	 SwpWYZuFA/+qj1/kxolC6VUJDFE5iLi352bfkvJcVMitZkaL7Ww1Gf2bhs5N3Kk8z1eom
	 GFRpcNvWychBBkJmoxxSAeihxgRZkdGaW8YPh+9sDs6aKh5a/MwTn4hbjeNGhE5vICagu
	 EoKejgHM2x7G5Ck068iqOONsFHaocs/Q82AS/OOEaXlC1k1Vpejr1EFLaEIQTrYtndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405683;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MsrGKQGzP+EEZyfx8T7spQGnVkdm377jBo1ms48nKBs=;
	b=ozIBh4smibDS5dT7BLw0yvrqy/RHCrouqQONmeS8tZZ14JOE8NhmmBG90PRp9kjCUpxl
	 89CLc7FLH8/iPLB+SfPSaxT7/EbO9GaPc22FizipvthwtVI2ztQ0EWja926FV5i+8OYc9
	 Zh7SmgXdpgyxFTikSGI8Pc48W0DKKXyuSUSeZz7Ue0tG9huN0fPjnLdExoaWw7ZymvyBL
	 efui5KtxWHUMnVz3Iebh7b7gCO20YnX3x6AqfRzNwy1H4ruMZ0RHMpCjG1Nod5wFUSd+M
	 KdwzcCD0NCK7rg1+F+bm4UGnwKSD/yReryglFMgpJDll04q5sVx+6i53X4UXF6+Tkvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xo8ss3cl;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E2606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 664E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xo8ss3cl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795405671; bh=MsrGKQGzP+EEZyfx8T7spQGnVkdm377jBo1ms48nKBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xo8ss3clFZ4gxYyauA1YzXZqrLA0ZyVvw2VMEW+8JntkD4JyUrKj3s1DAOSLCLxHt
	 Nk7/d9KGTXZJVsy/uKr8yWCXQRrweZnnpuk11TjOMjPHkPH0pCJthgaIuEyEYes6PL
	 fQEB86wh9Fx9hw2Ox5Wnf0ra9CYiBXsVUAlYc1Yk=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id BF083E63; Mon, 23 Nov 2026 11:47:48 +0800
X-QQ-mid: xmsmtpt1795405668tqjo36uf2
Message-ID: <tencent_8BA4FF587EE5579AB67149C5062618DC7109@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JumeUkE1gRqM72suL6ijtrDDc9aZgBbFWMkMQmDbzihCOKF+oGC9
	 Ps+IHliJmhXho+7NzR5WzABe5kEEev7XR47AWfBZ0oZdezu0UPECjqxhnXeJ9/QWR+X2R8OwFjPZ
	 thMLvjYDIzz24W8JAdB4Gos+sSFD8Y3GwqikxiLgU3KVGQw8W5dpeoOULv8WT4yZ8QAg7L+QTIGb
	 /sv1FjmB9whl0gwHlBXNIM29K8DiWh5uwr3gJox7M8toSLpANMa1aIIKrL5sMhwGwd+Si+F+Ht76
	 V787l8MHmk+J84Uy6z2visyXCAvAGHnu8ZNnOL5QObMzElXRK4B2b2SyppOJGmUZEGSDF1HuzJyh
	 b7KuFOo6HosPJsQgPbiRlCpuJKZCiPBSbnmdhqTHcoSEoEU8XwjDi1FMtpMsErOLtCJK2a17OSbT
	 hMS2ofXExK9d/m/H/L+wQyvc1VzqjA3gU7uThncBHz4wJCX3qjoUElREKqgSv4ucRClq3cZ/kSEq
	 qdcSHT4xTVpfi6LmnFz3yL/+SnsSxeIkdWJvmEXDH+MJzzb/0Aw1VysI4MUdFAEP+z7BoGLfoiqk
	 M6fuNRDdaTmd0lYuzCZWo2HbL4NNTgXj0f71hKtKDtKBX95EW7NXwfiv0ybUVGvL81m0jxV5DUPW
	 LINlbBXZj4HxDQLcENtYlrm8//HAOmIS8Qf4jS/ftX75eoKTd1/Pwdw3Z0/MS0AS6BRKPVPfSphd
	 nRbbwB0CnwtSTB/Xhh/rEheBY/DsQuoQNErCPQTDpQVA3HQHUJogVKwBPhgeVUwMrikm7oh30A5k
	 uKuKKx/jOGILTUARUmVtlDp0OolbtWKs09tkPw4qZPkVrivlH4Aw+A/ceX8YVgN8sdcueiyyBzqn
	 Aw5bPfB4cjImsKzsmZbJu6F+w2VQRawaJwzQtl3wnx+dxMX1FbeHA2OIrvkzdrIt9LUVaGHItCmT
	 LSHmUaceEdTyF9ww18slfAfYt4jV99L3rBhRg+kkXQBGPThEz37s8Pz5JxWEyfIaKpqk+u8Nr946
	 g9uGsdsZjb7+um3JiLzEtHTmTfLWqFU6aEJIDleGU61Zad/sXzX4eoYmKlwwNTHou21aGfnahvJY
	 d6ihNeAZFUoQamOL6MTDNeLDcxjg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Shuai Liu <847807867@qq.com>
To: ms@dev.tdt.de,
	linux-x25@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	847807867@qq.com,
	netdev-bot+sashiko@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x25: defer socket cleanup on link termination to process context
Date: Mon, 23 Nov 2026 11:47:48 +0800
X-OQ-MSGID: <20261123034748.1269213-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179539800759.3135.17245752044060918891@kernel.org>
References: <179539800759.3135.17245752044060918891@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_kill_by_neigh() walks all sockets bound to a neighbour and calls
lock_sock() and x25_disconnect() on each one.  It is invoked from
x25_link_terminated() and x25_link_control(), which both run in softirq
context when the LAPB link goes down or a restart frame arrives, e.g.
from the lapbether NAPI poll path.

lock_sock() takes a mutex in its slow path, so calling it from softirq
sleeps in atomic context:

  BUG: sleeping function called from invalid context at net/core/sock.c:3839
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name: ksoftirqd/0
    ...
    lock_sock_nested+0x66/0x70
    x25_kill_by_neigh+0x90/0x110
    x25_link_terminated+0x18/0x50
    x25_lapb_receive_frame+0x1c2/0x1f0

and lockdep flags the sk_lock-AF_X25 usage violation because the same
lock is registered in process context by x25_bind():

  WARNING: inconsistent lock state
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    ksoftirqd/0/14 [HC0[0]:SC1[1]:HE1:SE0] takes:
    ...
    x25_kill_by_neigh+0x90/0x110
    x25_link_terminated+0x18/0x50
    x25_lapb_receive_frame+0x1c2/0x1f0

Defer the neighbour socket cleanup to a per-neighbour work item so it
always runs in process context.  The work item holds a reference on the
neighbour and on its net_device, so the deferred cleanup cannot race
with neighbour or device teardown; both references are dropped again if
queueing fails because the work is already pending.  A dedicated
workqueue is drained in x25_exit() so that the module stays loaded until
pending work has run, and NETDEV_DOWN flushes the work to keep device
teardown synchronous as before.

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Reported-by: syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Liu <847807867@qq.com>
---

Changes in v2:
  - Use a dedicated workqueue and drain it in x25_exit() so the module
    stays loaded until pending work has run (Sashiko)
  - Hold a reference on the neighbour's net_device for the deferred work,
    and drop it again when queueing fails because the work is already
    pending (Sashiko)
  - Flush the work in NETDEV_DOWN to keep device teardown synchronous
    (Sashiko)
  - Explicitly request WQ_PERCPU to satisfy the workqueue API
  - Add Fixes tag and Cc stable

Changes in v3:
  - Flush kill_work in NETDEV_CHANGE as well, restoring synchronous
    socket cleanup for both process-context notifier events (Sashiko)

 include/net/x25.h  |  3 +++
 net/x25/af_x25.c   | 12 +++++++++++-
 net/x25/x25_link.c | 28 +++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 414f3fd993454..125803d4f0ee7 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -13,6 +13,7 @@
 #include <linux/x25.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 #include <net/sock.h>
 
 #define	X25_ADDR_LEN			16
@@ -143,6 +144,7 @@ struct x25_neigh {
 	struct sk_buff_head	queue;
 	unsigned long		t20;
 	struct timer_list	t20timer;
+	struct work_struct	kill_work;
 	unsigned long		global_facil_mask;
 	refcount_t		refcnt;
 };
@@ -317,6 +319,7 @@ extern struct list_head x25_forward_list;
 extern rwlock_t x25_forward_list_lock;
 extern struct list_head x25_neigh_list;
 extern rwlock_t x25_neigh_list_lock;
+extern struct workqueue_struct *x25_wq;
 
 int x25_proc_init(void);
 void x25_proc_exit(void);
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f45c9ec7d2c68..3696414617db1 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -222,6 +222,7 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
 			nb = x25_get_neigh(dev);
 			if (nb) {
 				x25_link_terminated(nb);
+				flush_work(&nb->kill_work);
 				x25_neigh_put(nb);
 			}
 			x25_route_device_down(dev);
@@ -235,6 +236,7 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
 				nb = x25_get_neigh(dev);
 				if (nb) {
 					x25_link_terminated(nb);
+					flush_work(&nb->kill_work);
 					x25_neigh_put(nb);
 				}
 			}
@@ -1790,9 +1792,13 @@ static int __init x25_init(void)
 {
 	int rc;
 
+	x25_wq = alloc_workqueue("x25", WQ_PERCPU, 0);
+	if (!x25_wq)
+		return -ENOMEM;
+
 	rc = proto_register(&x25_proto, 0);
 	if (rc)
-		goto out;
+		goto out_wq;
 
 	rc = sock_register(&x25_family_ops);
 	if (rc)
@@ -1825,6 +1831,8 @@ static int __init x25_init(void)
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
+out_wq:
+	destroy_workqueue(x25_wq);
 	goto out;
 }
 module_init(x25_init);
@@ -1843,6 +1851,8 @@ static void __exit x25_exit(void)
 
 	sock_unregister(AF_X25);
 	proto_unregister(&x25_proto);
+
+	destroy_workqueue(x25_wq);
 }
 module_exit(x25_exit);
 
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index d1e8cd81c2143..424044c1cf974 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -31,6 +31,8 @@
 LIST_HEAD(x25_neigh_list);
 DEFINE_RWLOCK(x25_neigh_list_lock);
 
+struct workqueue_struct *x25_wq;
+
 static void x25_t20timer_expiry(struct timer_list *);
 
 static void x25_transmit_restart_confirmation(struct x25_neigh *nb);
@@ -58,6 +60,25 @@ static inline void x25_stop_t20timer(struct x25_neigh *nb)
 	timer_delete(&nb->t20timer);
 }
 
+static void x25_kill_by_neigh_work(struct work_struct *work)
+{
+	struct x25_neigh *nb = container_of(work, struct x25_neigh, kill_work);
+
+	x25_kill_by_neigh(nb);
+	dev_put(nb->dev);
+	x25_neigh_put(nb);
+}
+
+static void x25_defer_kill_by_neigh(struct x25_neigh *nb)
+{
+	x25_neigh_hold(nb);
+	dev_hold(nb->dev);
+	if (!queue_work(x25_wq, &nb->kill_work)) {
+		dev_put(nb->dev);
+		x25_neigh_put(nb);
+	}
+}
+
 /*
  *	This handles all restart and diagnostic frames.
  */
@@ -82,7 +103,7 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
 			break;
 		case X25_LINK_STATE_3:
 			/* clear existing virtual calls */
-			x25_kill_by_neigh(nb);
+			x25_defer_kill_by_neigh(nb);
 
 			x25_transmit_restart_confirmation(nb);
 			break;
@@ -97,7 +118,7 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
 			break;
 		case X25_LINK_STATE_3:
 			/* clear existing virtual calls */
-			x25_kill_by_neigh(nb);
+			x25_defer_kill_by_neigh(nb);
 
 			x25_transmit_restart_request(nb);
 			nb->state = X25_LINK_STATE_2;
@@ -254,7 +275,7 @@ void x25_link_terminated(struct x25_neigh *nb)
 	x25_stop_t20timer(nb);
 
 	/* Out of order: clear existing virtual calls (X.25 03/93 4.6.3) */
-	x25_kill_by_neigh(nb);
+	x25_defer_kill_by_neigh(nb);
 }
 
 /*
@@ -269,6 +290,7 @@ void x25_link_device_up(struct net_device *dev)
 
 	skb_queue_head_init(&nb->queue);
 	timer_setup(&nb->t20timer, x25_t20timer_expiry, 0);
+	INIT_WORK(&nb->kill_work, x25_kill_by_neigh_work);
 
 	dev_hold(dev);
 	nb->dev      = dev;
-- 
2.43.0

