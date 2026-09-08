Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007141DE11
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874225; cv=none; b=byxbyhJwzdseoKNYt6SkHOv3HUWwWNSRfSK1+mpi5/Lq3dxfp3pUAz5WPZ7+Pqc4tV9cePh8w0tYd/2Xl4b1LNyo6jqQWCU97QC651Z/5yD9IY2EiLJfyKOIAxlywK2uGs7MECSVkeBM1nQG8sDqk0jGdZ/iZmkXixskWc9rRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874225; c=relaxed/simple;
	bh=r3pbUwKh1TzY73paIQf89o54CzlXCqEY4scpPPDk50w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gSmnNv9HxdjFiWESU0x7Tv7hcyyhUu02GcgS4821U7/3oxJEmt7KDJLKs1VBry6KQu68extEngU8RoGJlwDdSYrAnqL7IKw7aQWj7vD5mWjn1RE+5Ki10lwstuUQ+n2xyVe0aU8AL5y5COycfVpzAV7X6RNo8opnNpQ5OfwQCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YMCmsgqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YMCmsgqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E0E1F00A3E;
	Tue,  8 Sep 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874219;
	bh=1NzLINKNhnFFjMhqpWMnfSrmjsWogIiU86QyHduqWbM=;
	h=Subject:To:Cc:From:Date;
	b=YMCmsgqJq/XriIlcenhDCo+kVoDCEfD7PXBa8bOhknDNNhb8NO34XbYyrjokEHICE
	 vDk1R3a97c9b0Eie/0FU/zKqj363YXtOqnLQUplGhJvaMAijwKTmXlFByrsl0RlDIT
	 5mUqkhOJN1riL+tqPDJrmYHLNcoo5RQ1Exb01ORU=
Subject: FAILED: patch "[PATCH] ftrace: Synchronize the initialization of ftrace_ops" failed to apply to 6.1-stable tree
To: rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:19:29 +0200
Message-ID: <2026090829-luminous-distort-6af9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4617721c502b2ddaa4e324e86da4997edf738fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090829-luminous-distort-6af9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

