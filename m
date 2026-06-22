Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17643A4F31
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122168; cv=none; b=a0KWYUNl/9Y2bQGvlEV2Dqfss7+1hHXeYpDIyRX3wk3c+jrMXygJtI1J9zaDWsNjBu+nsMrK4FCTwrayHtH0Hk4e88onQVQ9smGa4saIBlkxnzgpWIhMwdCQHjhhow4JUgDeoHotdygaOY9CqCb2FM3jOD8sj6qF6VwU8BgiMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122168; c=relaxed/simple;
	bh=6/YTeWqo4P+1wOX8lvY2Y/4anoZPkQ9PpjnIsVEFHcY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eNWz94rBp4jt67j+EEiEIulVwHxfJfUxsmeqJ0pP8Ve0M0ElA4sqquRTB1zEj7bUpEKDXfv+BM45FjWqw3GWVPXO1W2qaPXnwTExVIZPdarbf8FZ3nUd8DEDDxoSXFR4zM/REXNA5lG5emjmUOPMfErN36e0cvAgbm86X3IK+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdgRe8gx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdgRe8gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF89F1F000E9;
	Mon, 22 Jun 2026 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122165;
	bh=lKh/o5+T5Q67K0nZxGerkYQ74gixsjJnkagCU4gBEps=;
	h=Date:From:To:Cc:Subject:References;
	b=IdgRe8gxw2NNlQU31FVnPBd/TaryvWIbEQMwHYmL+kQ7piePVhFcLkJDtcHGVN0h2
	 oMpM+we1k9VH6b/aK6RrKZ6llgDp72wTU2iDVkTa1174p6K1KTE/uv1FGA7Z2KHicx
	 CaMZ+G1+QLeaz0PvU12aAODgBnjTro5bL+g9Oe/T094Jz7Ost+zxx7ev5aFqDYSmLJ
	 3FdW7547Y5L65l4Egxjq7YtZZ7H3yrp/4KnC/mOVaJ43rrn1w/UQJa4RYBHbaO/sj7
	 zRV9ApmuvRHhGO60L930TJfWPDYnmZDVzfbXvXu6ym2Foo7GBcpDnzUlwaLPd1u9aP
	 oNYbgBie50wjg==
Date: Mon, 22 Jun 2026 11:56:02 +0200
Message-ID: <20260622094802.257399324@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
 Helen Koike <koike@igalia.com>
Subject: [patch v6.1.y 4/5] debugobjects: Do not fill_pool() if pi_blocked_on
References: <20260622094345.511524619@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Helen Koike <koike@igalia.com>

commit 5f41161059fd0f1bbf18c90f3180e38cc45a14eb upstream.

On RT enabled kernels, fill_pool() ends up calling rtlock_lock(), which
asserts if current::pi_blocked_on is set, because a task can obviously only
block on one lock as otherwise the priority inheritenace chain gets
corrupted.

Prevent this by expanding the conditional to take current::pi_blocked_on
into account.

Fixes: 4bedcc28469a ("debugobjects: Make them PREEMPT_RT aware")
Reported-by: syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com
Signed-off-by: Helen Koike <koike@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260511215359.3351259-1-koike@igalia.com
Closes: https://syzkaller.appspot.com/bug?extid=b8ca586b9fc235f0c0df
---
 lib/debugobjects.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -596,15 +596,25 @@ static struct debug_obj *lookup_object_o
 	return NULL;
 }
 
+static inline bool debug_objects_is_pi_blocked_on(void)
+{
+#ifdef CONFIG_RT_MUTEXES
+	return current->pi_blocked_on != NULL;
+#else
+	return false;
+#endif
+}
+
 static void debug_objects_fill_pool(void)
 {
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context -- for !RT kernels we rely on the fact that spinlock_t and
-	 * raw_spinlock_t are basically the same type and this lock-type
-	 * inversion works just fine.
+	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
+	 * on the fact that spinlock_t and raw_spinlock_t are basically the
+	 * same type and this lock-type inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
+	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching

