Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051464;
	b=t+p2ytNb9dNOIAT88RtrWfzFpu2F7RjA44eoLov27mbE4dHfyGQUObYloDGdCrgo1x01
	 Ash8x+/3YfYneOFjEJjHET1GIRMouHJkupuhU/27tlVxb4iZ1NbrEjta7ItGSezWIIFoS
	 QiED9FqRCnmWOhrXzc/nuCvy63VJ6+7YLgxg1JvEXuA9ReSfoVVuDb29tjK+eK6wY8Zz2
	 e6//X38UoQyEpZxaTkGgprdGvoS1HbzILx0FFIcFqWHqHTJHZJ/N+3jhk1andzmiz5Lfc
	 HSIIYq/9S/x0t/ot69VVHSZ80n+SMWJ+WRsJp5rk7HbW7KNe2yThLtu+8KdPNRUmNnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051464;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OmyQOfyTjGdM8xfyGFI74begtamX5Hd2NCop4lVP+rk=;
	b=GDyAbwl3Rt6ktrycUCNuP1rImG/QQoASxHasQLWeZoB+IzyXFJkoA6vyzVUoeL4k4y8+
	 n0ezJ3tEkLxuExl8PDWCNt95+8+ewt8n5VmO6X9Q1F1yxHLuTAUgkAG0VreCsrmUKXby9
	 BAReKRxZLIpxbznlw33vW1PTzdDUHJl2ExMj+Y2ilzithSYjpwnurIWXzMbgaBV4AISiZ
	 vhXFiwT34PU3B/RzGR0kCJ+UbzKGVqfiRqjwQveU0MoSjcxF0nGKNcc6ejseCHGR1aRAn
	 R+6uC9TuM+940CsAfK7JW60u2C/e0H9uZWq1Hpsju6L66GcFdqiz4vmth/vn5X4cXTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jLllVLhG;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4C606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F4C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jLllVLhG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795051458; bh=OmyQOfyTjGdM8xfyGFI74begtamX5Hd2NCop4lVP+rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLllVLhG+WTHiXoj/oWDT3d5sC3jJThLbAzZIqQQNlrn1V7Tjzj3KuhyTaDHiLd8M
	 EXwOmW6NA9qulJDg6wmIge/C/16ckqtFvS9lgFh7Lc56JCTnWTSeLfwIEwJofP9XQn
	 6Pt4dL2hJCordlVw87pjYtv2nNjA/PmFEzrwbcgM=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 60F84486; Thu, 19 Nov 2026 09:24:15 +0800
X-QQ-mid: xmsmtpt1795051455ty011zs6a
Message-ID: <tencent_EC124B80BC53531B2EAB18DD04B37BAE7406@qq.com>
X-QQ-XMAILINFO: M+LbSN6IdDJLPI2xR/RX/zobdXc1EBLawdeXCEfqnUDblmTzKeLg6eEvznj92v
	 aUiC3ZlhSPVy99oQZgfmI0EaLdDmZqkNHyL0boy6oY0xMRDoJ2bUIK5iSIH1ygrkiWzb2xuybJLQ
	 zRaS1Os+67oq9B15m6Jg/fGnVj8495eJ/J09QHg11qd3BUiQkr9ecZAFJKqbk/4AOzgO2jYJyZuJ
	 CCvgNyEXOS07evAcjTbhTsZ6zWImwG5LyWr5Hd009DqtSHBow2Bx/sP9We9ZdGLfoO+wHhqfNUGr
	 XzTINdb6Ps3DYox5RE/aHrSRwDtgoa+DGWpIPs8floaN3WbqSkqW4Wdp/1Ojlvo7PnjO2n6Pe9M1
	 QCtknj1t1SdVlfR5Txr+v7vyT7k2er87S9Qo/OezBzJEAuuG91M2/6/B1gvCHqRg/pFFKrYg+lDv
	 KS3jOTPC/TjjaN+BmVHJNVX2RP/r7z2+diwfO3g4/JTTkIlBT4ej4aO25z7R9G0uzVGEuRpU20ty
	 lIz51DvTkM3ubMR0AfZ/+7XW82p39N2I/rEfZ4zWoeWM98oGx4WhX1Jz5JBG4mBRHaT9XSauXoO7
	 swKY5ardaLDjz5raEG1Mq5wGi815RPapNY8ADMBB6Wc9WkziFLjM6aQVijfFqca35A0GXly/Kzs5
	 6byrqdRXGsfOLpiDK9EL3m/flqip26IrJEvMUasW9tx0JD8XeFmkuY5PS/hlmoSddiyRKwLQ+WjH
	 4u34BUEeT7wZ6T8wgZ/Y+oHoDKFhfyRTeRk1iwgd87u75hQ4zW2GeK+NyYjrG/6j595raudrp6cX
	 t/9TJw+uGjq8nz/8NzHhTO53809AtllRh9itiegrBXyfKt9ObiPmloQUPiXXBkdQxUgyucQAPQi5
	 E6kVseDPr+ux8xATir3cbKdtUA/ftnswcMvU7ycfpzr8ML/Li6j6Rg0kQNvwtYyl6bynuNcq2WMo
	 00AWgolNRyPWFpuZJkitee1B4fjIPWLm15dV/+0ZnEbemHYVGCgJkHSdRIW71htpth1FY/+EtxyO
	 Q1ww4/sMEKqJhIB2Fryf5WZeSTrtXra8bY2Ig3Qq+2c9WfXaM9uz57EzJiUCF4rBXcxJFTQg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Date: Thu, 19 Nov 2026 09:24:15 +0800
X-OQ-MSGID: <20261119012415.1393808-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179502692151.3136.18288735873132919768@kernel.org>
References: <179502692151.3136.18288735873132919768@kernel.org>
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

 include/net/x25.h  |  3 +++
 net/x25/af_x25.c   | 11 ++++++++++-
 net/x25/x25_link.c | 28 +++++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 4 deletions(-)

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
index f45c9ec7d2c68..a1a8bc203a24f 100644
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
@@ -1790,9 +1791,13 @@ static int __init x25_init(void)
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
@@ -1825,6 +1830,8 @@ static int __init x25_init(void)
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
+out_wq:
+	destroy_workqueue(x25_wq);
 	goto out;
 }
 module_init(x25_init);
@@ -1843,6 +1850,8 @@ static void __exit x25_exit(void)
 
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

