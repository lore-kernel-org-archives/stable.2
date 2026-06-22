Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705639B943
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122092; cv=none; b=PWB8mKFEpPNPPrI0vbQLI98TYRHltPLoKQBvwUOznRUW7WSsC/h3iOhB6QklW//MKmsv5Wj6vSCqoDiClfINQQ6pmu2T6HqovnHRu/zKdvprHShIwb7TsgychUC/+eGBPgLooNw793pVt/5AA5IBRnlrzVJB8sAa9qyRX0xdru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122092; c=relaxed/simple;
	bh=rhbBsj18Ju3cRk75uvOuxgVx59GBDUVQI00foVUl+uA=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MxOKnbhihu0l+xLAXiusSryci4SYbBORJCHfRur4eF5S/qatjghdG+jOvNQaSr3xAgZyi4cBJ6hzwsfhdqapmDjnyjmFGO9Lz/tAgNXmoAhOSWyWo7Cno/b6Yp8ehVuGn05EVCt3ARC5FFLSCCstNNzK50CXkiuZSwvCyxhvLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAe/upEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAe/upEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CED41F000E9;
	Mon, 22 Jun 2026 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122089;
	bh=0YvRsbPtH8/qa4dC25QI2LFhdrQiSrclNWOe0ymOCe0=;
	h=Date:From:To:Cc:Subject:References;
	b=jAe/upEwM0aNfJABoVSUU7rqovROKf1sEY05dBhGgyVebbo7sqSefAO5PsoJnPI2D
	 RaSZf0ay6C/MsiWcpwWxKIgHsrBwgwTeWZKgNw/ScnY9C29dy5llyUAB+ZqeDk0V6A
	 rusimg22ZzuW2s2nFb9YDCzOw0V5OeGZMEHGoA9y1o4SNzilEplEfxXN1ZIJmbipO9
	 CoMxT829q982m3gCBS9OS+Wjiht7weiGIHeaWRR5vn+RX8M4SWFEsJkUTaaZHt5PvA
	 85n4sHd6VFpm7v23v2NNYKX/AUqLwlAkT8AG/f6L+3R+N0d13RF/g26IFDa8+e+PT/
	 vDZsYyUmlp8rw==
Date: Mon, 22 Jun 2026 11:54:46 +0200
Message-ID: <20260622093321.640886555@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
 Helen Koike <koike@igalia.com>
Subject: [patch v6.18.y 3/4] debugobjects: Do not fill_pool() if pi_blocked_on
References: <20260622093040.582177124@kernel.org>
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
 lib/debugobjects.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)
---
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4343dc5e5c99..cbd025dae5ce 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -711,6 +711,15 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket 
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
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -727,11 +736,12 @@ static void debug_objects_fill_pool(void)
 
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

