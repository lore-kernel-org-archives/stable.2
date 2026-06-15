Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450133FF8B0
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535677; cv=none; b=s+f8oFQHIIx+XzVcWrAxS/bCXZULcGtQ6xMsOK+10R/3DMJTJ2HmOglkLYVXEyKWcGbMOA9Q/b9iK25oU0KCODDLgx9CllpYiEjQcV3K3dW5ZWfBhODbDHqf9a+3OYrD1Uq6itopQSQ58g2gKLY0DNdZglxnpjXHldUSs1ZEmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535677; c=relaxed/simple;
	bh=usCgJBs2ZEcaeIKGQxBoi3hhAqjPIERUW7n12UJneHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fde6JYricFyaUgnX/fv3JLMJt4dIzFkUtz577UsMRhYJbcR6EIYYzHiq9EqFNwW7JuuogEDIA67nyxKtUHcBnntZkg9os8xs1bCplRtzSzlFUJT1LhXyC5JYhDozHOXvxLjbxr5l4mLWDQJLM66JneZ2Qebc1Hy39SVPvefMC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=N7gEXVBI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="N7gEXVBI"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so4392266e87.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1781535671; x=1782140471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11kq7WU3cShcIS3SBeSPsFjxf0dv/lp/snMdSQFHRt8=;
        b=N7gEXVBITq2S50UHEdkqrLntCTmm/LIiEIY6MLcLGb69/5lvyp/eyDwEPZlP1b70fE
         jv7yoAJEDs4Q3sZjj79oRBVAGtaKJZZnL48TMDJOQ2vHnlV+ZuK9MUhf1ZGhunUBGSnJ
         Qe5fb9aNObLP/v8Bmbvt9AM334P6SyLHqV30sAXiwu5UKknyeYOzjmyKTy+/+2ZJN0hj
         uyQlQouul8e4TV2/ezlxZM4MwenrrBtt/Yb8J7xXC/Tu90vo91Mxu4kbeBa7F7XKx3Lm
         c9Y+H+R5KyL3naxECcB0Er7vAWGpIeN0Yoo5wZ03gDffZ10rPXjIy2A/8tIDMs81xVyk
         0F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535671; x=1782140471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11kq7WU3cShcIS3SBeSPsFjxf0dv/lp/snMdSQFHRt8=;
        b=Vvw7o7FHgjq9PA6ktVcDEcgckoEggDpoaHFBYryOLUgUpdfLckTr6/Ei3W0F/2slLD
         rgth/P6TtSBupR3BpeC439iYbuVLm0bDWr4qNIYh4bLwJNusYulzpZiv8S6LpenwigRk
         71Z1xWz5zqTvaSEV5WKE6Cr1KpF2By4eXWGdvsUSUjl6cFJp/wLrZcRkU+2v7nhEAN1K
         7NqtuddWpcmp8hq9qFckG5hfHRLvjIYv3OvKpC3HBtGYNprg/zSb76/55OP+OOAQBB2F
         MsVTbwuM2bz6qjOzcmcAv/8JDCgiitVqe15PcY9BAuTnQmDn8cW8Z6YeMBRVKl7lCZsM
         Y1jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5YpLg1TxtAy4D8E0gsvvCdyj6whoOjbFT/5+QLKzqSFbhdkOd4dXcxPt0hVOIFjR6DUr/JhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ccz8/Bt5lHSU+sbDswX7eB7AwX+6dzCxwF1+QSD6RyiOnZSm
	5hjGO5CYt7Ds70bxfSr89KDmigNm4R5QYy/YXK5BSnZ+kb8CX9vJtf906uUZgNFR0ErI
X-Gm-Gg: Acq92OEp6iFAlPFhfiKLqnDExfEDB5+b/2NoX8nqYmu0rBkXD0kfGsrxMSieOVjFGRS
	hRE8dVqjvJnTAt1gNyZht5LfdiRxTD3+5WviHsPiS7KJROqEaPjH0V03fl/vbaBwJGx4nQOvkVZ
	g63DkrobAhcY6IjE9nDhYaMa1sfjcFRDJ1kzbRg3Yw6PUqkRKDtnXmlD7y1MTbalD5n9wZyvHsz
	eFobVylEJ9s/QdomQu+zuNKH3CCYNgQWsJjar4Bkq3ROkphhF1tSpNXxl+y7bgVXr3djZPstdza
	ScVc1Vr1kIRRAw0YPHc7M50K94o5218b/Nz4uUdPUjtt12T8GXxrvftrUgdJrJmzkISnPhkSSR4
	VP1xDsveBX6iI4q62fHBPwr8VOWyqpAj2TovIuY0rx3W9hWvNBzj1ENtZXGReOs3A5C8IZ6/+Gf
	uy7WKn0w38/IY=
X-Received: by 2002:a05:6512:130e:b0:5aa:4bb4:1e9c with SMTP id 2adb3069b0e04-5ad2db4000cmr4493208e87.18.1781535670570;
        Mon, 15 Jun 2026 08:01:10 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b7a3fsm2844185e87.82.2026.06.15.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:01:10 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: Jon Maloy <jmaloy@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Samuel Page <sam@bynar.io>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: free bearer discoverer via RCU to fix tipc_disc_rcv UAF
Date: Mon, 15 Jun 2026 16:00:09 +0100
Message-ID: <20260615150009.1734270-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bearer_disable() tears down a bearer's discovery object with
tipc_disc_delete(), which frees the struct tipc_discoverer with a plain,
synchronous kfree(). The discovery receive path, however, still reads
that object under RCU in softirq context:

  tipc_udp_recv()            // udp_media.c, rcu_dereference(ub->bearer)
    -> tipc_rcv()            // node.c
      -> tipc_disc_rcv()     // discover.c
        -> tipc_disc_addr_trial_msg(b->disc, ...)  // reads d->net etc.

tipc_udp_recv() only gates this path on test_bit(0, &b->up), which is a
TOCTOU check: an RX softirq that observes b->up == 1 before
bearer_disable() does clear_bit_unlock(0, &b->up) can still be executing
inside tipc_disc_rcv() when bearer_disable() reaches

	if (b->disc)
		tipc_disc_delete(b->disc);

and kfree()s the discoverer. The reader then dereferences freed memory
(d->net, inlined into tipc_disc_rcv()) in softirq context [0].

The bearer itself is freed RCU-safely (tipc_bearer_put() ->
kfree_rcu(b, rcu)) because the RX path runs under RCU, but the discoverer
hanging off b->disc is freed synchronously. The same b->disc is also
touched under rcu_read_lock() by
tipc_disc_add_dest()/tipc_disc_remove_dest().

Free the discoverer with the same RCU lifetime as its bearer. Add an
rcu_head to struct tipc_discoverer and defer the kfree_skb()/kfree() to
an RCU callback so any in-flight reader that already loaded b->disc
completes before the memory is released. The timer is still shut down
synchronously up front with timer_shutdown_sync() (which can sleep and
must not run from the RCU callback), and shutting it down before the
grace period prevents the periodic LINK_REQUEST timer from rearming or
re-entering the object.

This mirrors the existing TIPC pattern of pairing call_rcu() with a
cleanup callback (see tipc_node_free()/tipc_aead_free()).

[0]: (trailing page/memory-state dump trimmed)
BUG: KASAN: slab-use-after-free in tipc_disc_addr_trial_msg net/tipc/discover.c:149 [inline]
BUG: KASAN: slab-use-after-free in tipc_disc_rcv+0xe7c/0x103c net/tipc/discover.c:236
Read of size 8 at addr ffff000028f07428 by task ksoftirqd/0/15

CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 7.0.11 #3 PREEMPT
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xb4/0xd4 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x118/0x5d8 mm/kasan/report.c:482
 kasan_report+0xb0/0xf4 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 tipc_disc_addr_trial_msg net/tipc/discover.c:149 [inline]
 tipc_disc_rcv+0xe7c/0x103c net/tipc/discover.c:236
 tipc_rcv+0x1884/0x2b1c net/tipc/node.c:2126
 tipc_udp_recv+0x22c/0x684 net/tipc/udp_media.c:393
 udp_queue_rcv_one_skb+0x898/0x1798 net/ipv4/udp.c:2441
 udp_queue_rcv_skb+0x1b0/0xa44 net/ipv4/udp.c:2518
 udp_unicast_rcv_skb+0x13c/0x348 net/ipv4/udp.c:2678
 __udp4_lib_rcv+0x1aec/0x246c net/ipv4/udp.c:2754
 udp_rcv+0x78/0xa0 net/ipv4/udp.c:2936
 ip_protocol_deliver_rcu+0x68/0x410 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x28c/0x4b4 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_local_deliver+0x29c/0x2ec net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:453 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:439 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_rcv+0x21c/0x258 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core+0x110/0x184 net/core/dev.c:6195
 __netif_receive_skb+0x2c/0x170 net/core/dev.c:6308
 process_backlog+0x178/0x488 net/core/dev.c:6659
 __napi_poll+0xa8/0x540 net/core/dev.c:7726
 napi_poll net/core/dev.c:7789 [inline]
 net_rx_action+0x360/0x964 net/core/dev.c:7946
 handle_softirqs+0x2f0/0x7b0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x6c/0x88 kernel/softirq.c:1055
 smpboot_thread_fn+0x65c/0x958 kernel/smpboot.c:160
 kthread+0x39c/0x444 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 68873:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 kasan_save_track+0x20/0x3c mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x54 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xd4/0xd8 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x1b0/0x458 mm/slub.c:5385
 kmalloc_noprof include/linux/slab.h:950 [inline]
 tipc_disc_create+0xdc/0x5e0 net/tipc/discover.c:356
 tipc_enable_bearer+0x8b8/0xf94 net/tipc/bearer.c:348
 __tipc_nl_bearer_enable+0x2a8/0x398 net/tipc/bearer.c:1047
 tipc_nl_bearer_enable+0x2c/0x48 net/tipc/bearer.c:1056
 genl_family_rcv_msg_doit+0x1e4/0x2c0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x4e8/0x750 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x204/0x3cc net/netlink/af_netlink.c:2550
 genl_rcv+0x3c/0x54 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x638/0x930 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x798/0xc68 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe0/0x128 net/socket.c:742
 __sys_sendto+0x230/0x2f4 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __arm64_sys_sendto+0xc4/0x13c net/socket.c:2209
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x84/0x2a8 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xe4/0x294 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x44/0x5c arch/arm64/kernel/syscall.c:151
 el0_svc+0x38/0xac arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 60072:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 kasan_save_track+0x20/0x3c mm/kasan/common.c:78
 kasan_save_free_info+0x4c/0x74 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x88/0xb8 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6170 [inline]
 kfree+0x14c/0x458 mm/slub.c:6488
 tipc_disc_delete+0x50/0x68 net/tipc/discover.c:393
 bearer_disable+0x18c/0x278 net/tipc/bearer.c:418
 tipc_bearer_stop+0xe0/0x198 net/tipc/bearer.c:757
 tipc_net_stop+0x110/0x178 net/tipc/net.c:159
 tipc_exit_net+0x80/0x19c net/tipc/core.c:112
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x244/0x694 net/core/net_namespace.c:252
 cleanup_net+0x3a0/0x830 net/core/net_namespace.c:702
 process_one_work+0x628/0xd38 kernel/workqueue.c:3289
 process_scheduled_works kernel/workqueue.c:3372 [inline]
 worker_thread+0x7a8/0xac0 kernel/workqueue.c:3453
 kthread+0x39c/0x444 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/tipc/discover.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 3e54d2df5683..844975b691ef 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -49,6 +49,7 @@
 
 /**
  * struct tipc_discoverer - information about an ongoing link setup request
+ * @rcu: RCU head used to free the structure after a grace period
  * @bearer_id: identity of bearer issuing requests
  * @net: network namespace instance
  * @dest: destination address for request messages
@@ -60,6 +61,7 @@
  * @timer_intv: current interval between requests (in ms)
  */
 struct tipc_discoverer {
+	struct rcu_head rcu;
 	u32 bearer_id;
 	struct tipc_media_addr dest;
 	struct net *net;
@@ -382,6 +384,17 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 	return 0;
 }
 
+/* RCU callback: free the discoverer only after any concurrent
+ * tipc_disc_rcv() softirq reader of bearer->disc has finished.
+ */
+static void tipc_disc_free_rcu(struct rcu_head *rp)
+{
+	struct tipc_discoverer *d = container_of(rp, struct tipc_discoverer, rcu);
+
+	kfree_skb(d->skb);
+	kfree(d);
+}
+
 /**
  * tipc_disc_delete - destroy object sending periodic link setup requests
  * @d: ptr to link dest structure
@@ -389,8 +402,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 void tipc_disc_delete(struct tipc_discoverer *d)
 {
 	timer_shutdown_sync(&d->timer);
-	kfree_skb(d->skb);
-	kfree(d);
+	call_rcu(&d->rcu, tipc_disc_free_rcu);
 }
 
 /**

base-commit: 47186409c092cd7dd70350999186c700233e854d
-- 
2.54.0

