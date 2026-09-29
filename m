Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4124C33C3;
	Tue, 29 Sep 2026 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672916; cv=none; b=Qvd8PvJYnXNTNkyS8Cyn7DU8aYxoZLR+YkITzHZ9fk5rZ62Sk2UkO6iHLnZviZRjIACsAXzlIg+kLOEcpiJ+Pn36MegB73QGTkxb6ZuWFQoVQVMdwZEK0btjzEv9oWpDFNfKHT8FLUapCAX3ggXepkzhbCxBds808Bt5Yu5EqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672916; c=relaxed/simple;
	bh=auz823zpK+zZLkyLOneZiWMEhEYX+Om9aDoyFnpfTVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JespQKplMYzUVWtIZcd6Wcp7ATR8UQa0igPuOFmc8/j+M6rzz5D/dbo4ti6kEJT795VpHD7GUogNyuQTLWOtuqOxpPIszmplCLN4oeChmgM/q6Av43A4T7pVv8EaSARfTtf2WiQostTssIrwfiPXDF+BODAPVGX4pnsGxu5sLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez2tLcAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez2tLcAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E391F00893;
	Tue, 29 Sep 2026 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672903;
	bh=OuzsjD4FW/Wn/ULAzF6QSlYqXQCU3/sGdw/8Yrln8NM=;
	h=From:To:Cc:Subject:Date;
	b=ez2tLcAi4nNrMyId+j5Wf2MBr3Y+AYzCFz5C58SgjMOz7F/aqoOiN7vgl2/843+D/
	 FCJXHJVIu4kw31WaBnf0PdbPQ6PZnxPxZuLo3LW2VZmJ84Fyv9ObX7/F4uYCBnjpWq
	 aX4/6dJaubqA0E9b7ceiRE4BU4JV3nQdE4xedQDfY3vfCTkh7RvXALX2SFO+RGrck4
	 11+lhhROhjvXvdMK6WSl1ZphkLtMMhdzuimXm7ZipnzUGijCbFMZxt46bOEeDA0QSa
	 0aJRLOP/O9/cRv6oE2OEJ21VqBZydZTol7ACUZRVbVmQDp50Zt1CxpAiBvCvyPdhqX
	 5USAp9VKDm0Ew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>
Subject: [STABLE v5.15.y v2 1/9] eventpoll: don't decrement ep refcount while still holding the ep mutex
Date: Tue, 29 Sep 2026 09:07:08 +0000
Message-ID: <20260929090724.1461557-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2 upstream.

Jann Horn points out that epoll is decrementing the ep refcount and then
doing a

    mutex_unlock(&ep->mtx);

afterwards. That's very wrong, because it can lead to a use-after-free.

That pattern is actually fine for the very last reference, because the
code in question will delay the actual call to "ep_free(ep)" until after
it has unlocked the mutex.

But it's wrong for the much subtler "next to last" case when somebody
*else* may also be dropping their reference and free the ep while we're
still using the mutex.

Note that this is true even if that other user is also using the same ep
mutex: mutexes, unlike spinlocks, can not be used for object ownership,
even if they guarantee mutual exclusion.

A mutex "unlock" operation is not atomic, and as one user is still
accessing the mutex as part of unlocking it, another user can come in
and get the now released mutex and free the data structure while the
first user is still cleaning up.

See our mutex documentation in Documentation/locking/mutex-design.rst,
in particular the section [1] about semantics:

	"mutex_unlock() may access the mutex structure even after it has
	 internally released the lock already - so it's not safe for
	 another context to acquire the mutex and assume that the
	 mutex_unlock() context is not using the structure anymore"

So if we drop our ep ref before the mutex unlock, but we weren't the
last one, we may then unlock the mutex, another user comes in, drops
_their_ reference and releases the 'ep' as it now has no users - all
while the mutex_unlock() is still accessing it.

Fix this by simply moving the ep refcount dropping to outside the mutex:
the refcount itself is atomic, and doesn't need mutex protection (that's
the whole _point_ of refcounts: unlike mutexes, they are inherently
about object lifetimes).

Reported-by: Jann Horn <jannh@google.com>
Link: https://docs.kernel.org/locking/mutex-design.html#semantics [1]
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit b0821ec902d39062356cb644c16e17a705d1c9f5)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 fs/eventpoll.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8762d0908637..9e63923196fc 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -770,7 +770,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	call_rcu(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
-	return ep_refcount_dec_and_test(ep);
+	return true;
 }
 
 /*
@@ -778,14 +778,14 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
  */
 static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 {
-	WARN_ON_ONCE(__ep_remove(ep, epi, false));
+	if (__ep_remove(ep, epi, false))
+		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
 static void ep_clear_and_put(struct eventpoll *ep)
 {
 	struct rb_node *rbp, *next;
 	struct epitem *epi;
-	bool dispose;
 
 	/* We need to release all tasks waiting for these file */
 	if (waitqueue_active(&ep->poll_wait))
@@ -818,10 +818,8 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		cond_resched();
 	}
 
-	dispose = ep_refcount_dec_and_test(ep);
 	mutex_unlock(&ep->mtx);
-
-	if (dispose)
+	if (ep_refcount_dec_and_test(ep))
 		ep_free(ep);
 }
 
@@ -1001,7 +999,7 @@ void eventpoll_release_file(struct file *file)
 		dispose = __ep_remove(ep, epi, true);
 		mutex_unlock(&ep->mtx);
 
-		if (dispose)
+		if (dispose && ep_refcount_dec_and_test(ep))
 			ep_free(ep);
 		goto again;
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

