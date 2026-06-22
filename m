Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8B37A493
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122127; cv=none; b=BwBXqtFstQ06Qz2Zj32YW8gYnXv7LTePCfGyJWhJeC/irRAQcP62Zq3YmUD2/szK0LuuBp+gei2VLvqUDBtVICzwh75GxY3ulCMtyLvd6tr0Fsaz9Q/+0zQ97QY+aO5eLEKsOjyVcK6YNP7OpSSCWezD3StDPsrX4QLiM0eLnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122127; c=relaxed/simple;
	bh=6/YTeWqo4P+1wOX8lvY2Y/4anoZPkQ9PpjnIsVEFHcY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KTnGeGqL8UPpx59RFAyK4FNaDuCNOzOVppJlLdPsNhIomJhPx/bSNHfjyhdQiKpSkeD7YQVmhQLmWXHy8FEAPB6zrzPMKSZZwOClphLK5kwXfq3SFZdBF5unopPtxAqtCnQwz/arsupM7cuN3CYlTKSid0+xSg+QeMd3zYaqfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7hKiRUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7hKiRUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF4E1F000E9;
	Mon, 22 Jun 2026 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122125;
	bh=lKh/o5+T5Q67K0nZxGerkYQ74gixsjJnkagCU4gBEps=;
	h=Date:From:To:Cc:Subject:References;
	b=O7hKiRUEJweEG6WQNGwALLEUN/e0g5jcBkVoGEPZeuey0M2dW8F5xRaXStNVlwxKw
	 aVJlnzhVTlL64SFz7+vs9VAbp+lKJas4e/T0M6mP6zht6jnahC9EgKFkMjrXas4uNU
	 yfgjUTpCvetuwj9lMolH/Rvbd/cHwesfCw7uBjYfaMqh2Pi2YUbhYr7CjVFs5aw4Hb
	 PuAdCbNoVHlu5TthSPmrGOA1NcU7e3XciQjnKUwwdNGokVEm1gKf5fiPd5kaGYP9NH
	 qXxH4NP+LpgZgWh07cDAJe88YxsZ9wXpUeO1lq4okyz+v31qlBcSX3U/re6+Tc2Mlt
	 nSaKpJJpgMaSA==
Date: Mon, 22 Jun 2026 11:55:21 +0200
Message-ID: <20260622092952.190546602@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
 Helen Koike <koike@igalia.com>
Subject: [patch v6.6.y,
 v6.12.y 3/4] debugobjects: Do not fill_pool() if pi_blocked_on
References: <20260622092400.929691694@kernel.org>
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

