Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBA519939
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874251; cv=none; b=pgAzwbB5pB7cjW+q4+iNDFAiHb34CRtzIe2UoMM2agJEe34UVnwelG0c1M5Q5VQAuU8Lt6stnwpq88M2oYePB2gkViVFl46NR7JdDjAKnvoTD1Gnl2XE/ly/Sta+x5lX2GslVg3/f5g2q9IAe2fVhyKfOawnt0C/KciCJNnaFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874251; c=relaxed/simple;
	bh=Z2fV1zGf6qtV9KEJs2TbCy/zKLPklBHCwMHVQ/RqWIM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XUgdvxiUjODGK+2LIlZliwHKb3iB9wGrPz9tDnPPHOCQIfN+Cou32zRrg+7iGCsVGTjeYMOrUg4eqfbM2lVDbqGatsusgmnW11tS4/q1sfJDRglxnzMRr9ov8f/qRWcTZCx7FdNFYYU7Ra+WmmJ0ulU3kYZaF8a4bI1wwinyKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=05r7tEoq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05r7tEoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20C1F00ACF;
	Tue,  8 Sep 2026 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874229;
	bh=11fj7gd34BEOLV0puAiSvhJVG6eBv5TguYHA2uUmcrA=;
	h=Subject:To:Cc:From:Date;
	b=05r7tEoqBvdjOxkIjUEANeU+ESuRx0YqWZsOTV2LTcG5DSAPAFnI1tsMf9dVAQSA3
	 aIPjaeXEN0KEbR6GUZWhgcfJJHPSryE0HrJmOCYlLryV9M9Yv+ZOLL3IXr1693+0PG
	 Q6myCg136BWuBIVIbpHnY6Tq8HU5cIwutrXptKqY=
Subject: FAILED: patch "[PATCH] ftrace: Synchronize the initialization of ftrace_ops" failed to apply to 5.15-stable tree
To: rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:19:30 +0200
Message-ID: <2026090830-bonus-gaining-b7d0@gregkh>
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
git cherry-pick -x 4617721c502b2ddaa4e324e86da4997edf738fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090830-bonus-gaining-b7d0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4617721c502b2ddaa4e324e86da4997edf738fa5 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 2 Sep 2026 09:55:01 -0400
Subject: [PATCH] ftrace: Synchronize the initialization of ftrace_ops

There's some internal state that ftrace_ops needs to have set, but since
it can be declared outside of the ftrace.c code, it calls
ftrace_ops_init() on the ops in every global function. The issue is that
if two tasks call it on the same ops at the same time it is possible to
have the initialization of one corrupt the initialization of the other
call.

Create a ops_mutex to use to synchronize every initialization of the
ftrace_ops. The mutex is taken within checking the ftrace_ops flag that
states it was initializied but the flag is checked again after the mutex
has been taken. Checking first outside the mutex allows it to shortcut
having to take the mutex. But then the check needs to be done again after
the mute is taken in case of races.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260902095501.6b59af20@gandalf.local.home
Fixes: f04f24fb7e48d ("ftrace, kprobes: Fix a deadlock on ftrace_regex_lock")
Reported-by: sashiko-bot@kernel.org
Close: https://lore.kernel.org/all/20260829025528.49A831F000E9@smtp.kernel.org/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7cf36f2dd7b..53d5db60bfa5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -75,6 +75,8 @@
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock), \
 	.subop_list		= LIST_HEAD_INIT(opsname.subop_list),
+/* Used only to synchronize the initialization of ftrace_ops */
+static DEFINE_MUTEX(ops_mutex);
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -159,11 +161,18 @@ const struct ftrace_ops ftrace_nop_ops = {
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
-	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
+	unsigned long flags = smp_load_acquire(&ops->flags);
+
+	if (!(flags & FTRACE_OPS_FL_INITIALIZED)) {
+		guard(mutex)(&ops_mutex);
+		/* Could have been initialized before lock taken */
+		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+			return;
 		mutex_init(&ops->local_hash.regex_lock);
 		INIT_LIST_HEAD(&ops->subop_list);
 		ops->func_hash = &ops->local_hash;
-		ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		flags = ops->flags | FTRACE_OPS_FL_INITIALIZED;
+		smp_store_release(&ops->flags, flags);
 	}
 #endif
 }

