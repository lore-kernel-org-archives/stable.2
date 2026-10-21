Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597274;
	b=xE5nS36Lf9wVWtmYWVEMRUetLxjyGrkF/MdU9nqcdDZXEo0HqwU7ae9K93L2hsEzPMDr
	 IM4K8NcIYSdpDy/Vw+ZknSOP6T9S50mgmLCRnoNsVpG3dIiFBS5EhmmirBgbDd1Ch3VNP
	 C4zfFVox9rm/b3ceZm3qWFJdsvZZvxHkgpFdJEg43uLN2gD7RD3d8eaJoJEk8/WWDb6rE
	 x/7TpIIansd3zyUZzJ7jG2CDESRHjJi93ChhXqzVv/vI1cjy503ZI1OYEIEEJKPZnN9M5
	 AA0FFCqnDu8EV/W//1EWqTON/7tpNe1W8c913dVvLO8hU6v8R4vZxM6Y3MisF793+PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597274;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YnC/Z/lgkcnL5iU7D04K3dYZLZy5OYebem9m4fN7SOk=;
	b=pkYLjtfHtEJZCCnl4CRwGL5kra4EpTQtTO+1kaF7AK4ZTfeHqYVvJVPgQc53b44gZX5p
	 f82A78oG1+vA8jx/1TPFXhw4K3m8EhrugWt6UMM1gYqv52egkAAewkXNOCbcyXMQaYCre
	 cxWR7PDmOIZdlxpB7qfXjSe7e8qo4Inwt9OL3FmOh6RFMLaDstZ58Tp6qUYKlg0rVZIw+
	 jdKrK6i3rJqCa2lWo7xsQPzOSwQbyTYl7MS46gsPxyeOf1PIH0gdt53iKHfQbTX5GRDos
	 vvEWApHJ/vp8jpel3cYWo01y5x9uciwDdEydUNa3IENITvg/coF5nt/p/BE97TRoEoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2iY8QQYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B2606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2iY8QQYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D30B1F000C2;
	Wed, 21 Oct 2026 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792597273;
	bh=YnC/Z/lgkcnL5iU7D04K3dYZLZy5OYebem9m4fN7SOk=;
	h=Subject:To:Cc:From:Date;
	b=2iY8QQYmFZx1fzhRMLMuLxBSAcUjCPV5Kj8d2vStY/Bjmh66SQjDjsNxTVroAfat8
	 LePtg7ImmjP9JNds9MMk/KKBtRmhoEQfRmztkfbk4YiqEH8+d8k2Ueeo3bt8XnU3Ps
	 yivMY3OizC2T9YzA2WmFP0MpymSrBSSrL2dQgi7Q=
Subject: FAILED: patch "[PATCH] workqueue: Fix unbound pool lifetime for pending pwqs" failed to apply to 7.2-stable tree
To: yaokai34@huawei.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:35:47 +0200
Message-ID: <2026102147-clatter-yen-51fa@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x cf9c8aaea0d47410df8708bec195889f3a85cd3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102147-clatter-yen-51fa@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf9c8aaea0d47410df8708bec195889f3a85cd3c Mon Sep 17 00:00:00 2001
From: Yao Kai <yaokai34@huawei.com>
Date: Mon, 24 Aug 2026 11:58:52 +0800
Subject: [PATCH] workqueue: Fix unbound pool lifetime for pending pwqs

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

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f2aed36cf7c0..0ee73dcd4a14 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5294,12 +5294,6 @@ static void pwq_release_workfn(struct kthread_work *work)
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
@@ -5309,6 +5303,12 @@ static void pwq_release_workfn(struct kthread_work *work)
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

