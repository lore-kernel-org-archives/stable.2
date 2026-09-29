Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616D4F3903;
	Tue, 29 Sep 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672951; cv=none; b=Ixs3n7NMmqMqj9hHVvhhd98B+5sFk40p4rZGGBVGNAluR+bGH1O7CdjoetXCt+7NouBbIhVZR6jnGywxyvrvcu4S5s9pZKmXZ1CQkO6zp/z2YfvCME8e4KjL5yfr9fGc3t3oqFU4b3umUpdfbtpoB9tqGvbTM8DAF5ZSrglspyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672951; c=relaxed/simple;
	bh=+5lWwUcl+c4c5RGmHpivw5aoH1wMUoZfhSqoS/58h2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBSK/rXJRttEELKjmDXnz/NFQURDYsoM5fQ2HxmuM7yz62w4S6xHn+45TTnb4byd9l/LJe32dT4eRAdN1CPisAT3TiKhj2HVJpR+63BXNZQjGjP9P4wSTc6Mqgf9dI5KoRXZq3uf7Q6dy0IsmLYpVKhQS9FIE6Us2tRJ5Yb/rhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilhN34JV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilhN34JV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404D91F0089B;
	Tue, 29 Sep 2026 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672934;
	bh=5/5sbJj2UOjTM0MY6dPTxrHU4W58D8Vo5wYa7xw7MQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ilhN34JVzpNBWeHqaumUjwnaZLjwOPszZnZLA6oEzjeco2LKYfxM28ZmsXzuR6Saz
	 T+RW5zb3ayvVsR8AvmoHjOiqoDKX0iF3OHCj3fXe9cj+SUsQmCzSTrDZDGflmf2T/7
	 kw1XmKkNkE1wQYUhQ8c0iB7v89Il7txrv60k8Gi5ECsXEVjGqrvS1EZMzoSih5ux/c
	 Fk+DkULaDsXlOyS8kTUEKlTPHqPH9s7/SS0L5WDvKWtQ1mNxFFsRcN0tvgbsCKXYsd
	 mY0BmsrzpqvtCuaHDHfaFsGMLtvslm+hRemFNkR8UhnUjx9c8B8wFwZ8v17GcaK/WN
	 nMl5Iuh0Fy2pg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [STABLE v5.15.y v2 9/9] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Tue, 29 Sep 2026 09:07:16 +0000
Message-ID: <20260929090724.1461557-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929090724.1461557-1-lee@kernel.org>
References: <20260929090724.1461557-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a6dc643c69311677c574a0f17a3f4d66a5f3744b ]

ep_remove() (via ep_remove_file()) cleared file->f_ep under
file->f_lock but then kept using @file inside the critical section
(is_file_epoll(), hlist_del_rcu() through the head, spin_unlock).
A concurrent __fput() taking the eventpoll_release() fastpath in
that window observed the transient NULL, skipped
eventpoll_release_file() and ran to f_op->release / file_free().

For the epoll-watches-epoll case, f_op->release is
ep_eventpoll_release() -> ep_clear_and_put() -> ep_free(), which
kfree()s the watched struct eventpoll. Its embedded ->refs
hlist_head is exactly where epi->fllink.pprev points, so the
subsequent hlist_del_rcu()'s "*pprev = next" scribbles into freed
kmalloc-192 memory.

In addition, struct file is SLAB_TYPESAFE_BY_RCU, so the slot
backing @file could be recycled by alloc_empty_file() --
reinitializing f_lock and f_ep -- while ep_remove() is still
nominally inside that lock. The upshot is an attacker-controllable
kmem_cache_free() against the wrong slab cache.

Pin @file via epi_fget() at the top of ep_remove() and gate the
critical section on the pin succeeding. With the pin held @file
cannot reach refcount zero, which holds __fput() off and
transitively keeps the watched struct eventpoll alive across the
hlist_del_rcu() and the f_lock use, closing both UAFs.

If the pin fails @file has already reached refcount zero and its
__fput() is in flight. Because we bailed before clearing f_ep,
that path takes the eventpoll_release() slow path into
eventpoll_release_file() and blocks on ep->mtx until the waiter
side's ep_clear_and_put() drops it. The bailed epi's share of
ep->refcount stays intact, so the trailing ep_refcount_dec_and_test()
in ep_clear_and_put() cannot free the eventpoll out from under
eventpoll_release_file(); the orphaned epi is then cleaned up
there.

A successful pin also proves we are not racing
eventpoll_release_file() on this epi, so drop the now-redundant
re-check of epi->dying under f_lock. The cheap lockless
READ_ONCE(epi->dying) fast-path bailout stays.

Fixes: 58c9b016e128 ("epoll: use refcount to reduce ep_mutex contention")
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-6-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
(cherry picked from commit a6dc643c69311677c574a0f17a3f4d66a5f3744b)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3e1144d2515d28e4312e663ea05eac203101491d)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 95d31d23db60..50df3717f908 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -794,22 +794,26 @@ static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
  */
 static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
-	struct file *file = epi->ffd.file;
+	struct file *file __free(fput) = NULL;
 
 	lockdep_assert_irqs_enabled();
 	lockdep_assert_held(&ep->mtx);
 
 	ep_unregister_pollwait(ep, epi);
 
-	/* sync with eventpoll_release_file() */
+	/* cheap sync with eventpoll_release_file() */
 	if (unlikely(READ_ONCE(epi->dying)))
 		return;
 
-	spin_lock(&file->f_lock);
-	if (epi->dying) {
-		spin_unlock(&file->f_lock);
+	/*
+	 * If we manage to grab a reference it means we're not in
+	 * eventpoll_release_file() and aren't going to be.
+	 */
+	file = epi_fget(epi);
+	if (!file)
 		return;
-	}
+
+	spin_lock(&file->f_lock);
 	ep_remove_file(ep, epi, file);
 
 	if (ep_remove_epi(ep, epi))
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

