Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685713;
	b=VcnEOgrquU/Gz7Sw1KiBHGTurPi+9EAeLNDn3UuzhN3296dKLmGhksLUh9CIBC9zdlN9
	 k668/Fci1c9KDqp+jCiNHm9NMiLl++IaG6kMgD+0S/+03WCgiE7Iuq2ih6FOVQpu5qmhl
	 bI1m6h5Y+Hq48BNkW4Z3M7c5Fn1Yijpn/8kmRmobeODtqgkcSlWhm1hEDV4pf8gVS07WK
	 SqzbNQ5XKHhTmMgN3SVe2dgm3Du5G1+4vPZNKELEdqGdL9W+k/NQD2uC2zcwbnkmmXkyX
	 E2A3DrDEfNP0QRsa9hKLttQIrhv79x1ILFiTSGasNVMDdcyBrT+OAvz4GIvq37IwGdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685713;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SjEZv2obAaFvcdVr5OP97e3Hqrjlod99k7xpnry2pTU=;
	b=CMVhgXN0uRukajbn/A9QMurbzwRYnhFDpAIDU155ySDT/uZnJw2wsRlTOYwMNdB8Nzoz
	 OYC3WEGfheogO8akePntVNqL+UYpawuszslUvox49gU2P+EOsjgarWpEThD4f5Vo3cBpt
	 e+LVXiMfSytXHlruhdbI5P+1ZvR4rpnDe2HTakrxBfzX8jRAHyEezPuQDjDOVDEHbnMlL
	 3GCUI/O93xRlVIWdNkZQ06kgaT2uQ3ZNEyZCFBDn8DKVw8yhKVNImMkuHaCbaWw88C8ES
	 r071eaaystboAh50AdMNJfwUZNw5A+1baJL/bvm11/EJ7TlssvA8dWGU4Nd3J73mXZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D029zAPs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E68606A322
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D029zAPs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77721F031E1;
	Thu, 22 Oct 2026 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685713;
	bh=SjEZv2obAaFvcdVr5OP97e3Hqrjlod99k7xpnry2pTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D029zAPsBRnntUyfxB4Jg4LawmJK470rgq6lneG7u4VoDDg+jzO75pjDRw8ONTXVk
	 LjjNYMZ4jalTlMvjuSpHY3s1IzTkYlJ+06QiAEv9HJbFuH0EsdhlZZyxeMGsKQrM2b
	 4UBKldZJCLGRF3MvcLZrgYx4MxZYjl3br/zbuBFF/yTLYaz6rlLMKpuo0dexlsEopG
	 ndLe3Nnl+QrvjbLOuzp/XMN2BpVnQjqv5nQFmu3E+Rg5WaQvoL2RgTk0NKPcF3zY+c
	 jjwsrjgvNVBvgl59231KxqKMKR3rtKwmvRBSedWmH1IjTAlKUfjWONSdh0ay5O+04l
	 9u+LnJSdwv+cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Kai <yaokai34@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] workqueue: Fix unbound pool lifetime for pending pwqs
Date: Thu, 22 Oct 2026 12:15:09 -0400
Message-ID: <20261022161457.1728158-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022161457.1728158-1-sashal@kernel.org>
References: <2026102148-unadorned-icon-a748@gregkh>
 <20261022161457.1728158-1-sashal@kernel.org>
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

From: Yao Kai <yaokai34@huawei.com>

[ Upstream commit cf9c8aaea0d47410df8708bec195889f3a85cd3c ]

KASAN reports a use-after-free of an unbound worker_pool in
node_activate_pending_pwq():

  BUG: KASAN: slab-use-after-free in _raw_spin_trylock+0x6d/0x120
  Read of size 4 at addr ffff8880089ce000 by task kworker/u22:0/318

  CPU: 1 UID: 0 PID: 318 Comm: kworker/u22:0 Not tainted 7.2.0 #1 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Workqueue:  0x0 (flush-8:0)
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xce/0x610
   kasan_report+0xce/0x100
   _raw_spin_trylock+0x6d/0x120
   pwq_dec_nr_in_flight+0x4b4/0xcb0
   process_one_work+0x921/0x11a0
   worker_thread+0x4d0/0xd20
   kthread+0x2de/0x3c0
   ret_from_fork+0x3aa/0x620
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 311:
   alloc_pwq+0x439/0xca0
   apply_wqattrs_prepare+0x75e/0xd10
   apply_workqueue_attrs_locked+0x44/0xa0
   wq_nice_store+0x350/0x450

  Freed by task 0:
   kfree+0x127/0x3b0
   rcu_core+0x523/0x1780
   handle_softirqs+0x1b3/0x610

  Last potentially related work creation:
   put_unbound_pool+0x3f3/0x7d0
   pwq_release_workfn+0x494/0x8e0
   kthread_worker_fn+0x1ff/0x790

Canceling the last inactive work skips pwq_dec_nr_active(), so an empty
pwq can remain on pending_pwqs when its refcnt reaches zero.
pwq_release_workfn() currently puts the pool before removing that pwq.
If this drops the last pool reference, the pool can be RCU-freed while
the pwq remains reachable, and node_activate_pending_pwq() may trylock
the freed pool->lock.

Remove the pwq from pending_pwqs before putting the pool.

Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Kai <yaokai34@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 14a3d1775c2ff..f6dde83c9466f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5123,12 +5123,6 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_unlock(&wq->mutex);
 	}
 
-	if (!is_percpu_pool(pool)) {
-		mutex_lock(&wq_pool_mutex);
-		put_unbound_pool(pool);
-		mutex_unlock(&wq_pool_mutex);
-	}
-
 	if (!list_empty(&pwq->pending_node)) {
 		struct wq_node_nr_active *nna =
 			wq_node_nr_active(pwq->wq, pwq->pool->node);
@@ -5138,6 +5132,12 @@ static void pwq_release_workfn(struct kthread_work *work)
 		raw_spin_unlock_irq(&nna->lock);
 	}
 
+	if (!is_percpu_pool(pool)) {
+		mutex_lock(&wq_pool_mutex);
+		put_unbound_pool(pool);
+		mutex_unlock(&wq_pool_mutex);
+	}
+
 	kfree_rcu(pwq, rcu);
 
 	/*
-- 
2.53.0

