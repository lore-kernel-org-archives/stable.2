Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784F421892
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603500; cv=none; b=kg8Ym7ezw3SbgRiEN1//n8xuAIfCraK5ROXUQsm5Zh/hQnTPsiWpttiHgVdB12M4ieKgorQs7JTV6S7LrDX0ga7bzmIEkZL2A9NDbGd9fBEaEnCw4n3ZzJzj5q7DypVCnUWNnZpuZPB6K5/Bd9tx+LUu0D6PuYu8SNLaMLDKwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603500; c=relaxed/simple;
	bh=y37ol3MpuD0d63zIveL7KPQWpXO4o4Lhmg1f0vQbSCI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=msABf4Xt4OiLFPkhvu6VjRQ3cOUxvZleo+cefC6VaDD9qgpfYnnKn7Yy4P0MrwZXSfjLDcV8tq/9Baq2ix/nfG2qX+3xxAvb5JHqedTqUhjGEsgJAE9sUthq3lFYE4zBNaXqd46iV3gb4XyhUagItpZRa4/Rc01y2IZJMFbVHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPsTAhgP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPsTAhgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05641F00A3A;
	Tue, 16 Jun 2026 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781603498;
	bh=VC9l//JEe3ndzbHFRwB5oSj14Fto5CpbttmbMlVgS4k=;
	h=Subject:To:Cc:From:Date;
	b=YPsTAhgPDE5zlVaMNPHLMFrZU6e172rr8rM2uivS2ZToST34+xGmwPpTSzbd/yPaR
	 Cue9Yh1hdA1J8NbJt7b49dsAF/cTWZUbC4SA/xWcoUXsq30S4fIX1MvqEy7edvVbtv
	 OQ1GA4slFCFZm0xZJI0wDWoqUN/vei+YM87IoUS8=
Subject: FAILED: patch "[PATCH] debugobjects: Do not fill_pool() if pi_blocked_on" failed to apply to 5.15-stable tree
To: koike@igalia.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Jun 2026 15:20:12 +0530
Message-ID: <2026061612-blizzard-paced-855b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5f41161059fd0f1bbf18c90f3180e38cc45a14eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061612-blizzard-paced-855b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f41161059fd0f1bbf18c90f3180e38cc45a14eb Mon Sep 17 00:00:00 2001
From: Helen Koike <koike@igalia.com>
Date: Mon, 11 May 2026 18:53:05 -0300
Subject: [PATCH] debugobjects: Do not fill_pool() if pi_blocked_on

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

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12e2e42e6a31..772ddabcbe7d 100644
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

