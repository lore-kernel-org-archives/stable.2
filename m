Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C8337BA4;
	Sun,  6 Sep 2026 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659051; cv=none; b=lvmdKfVlC2KoSsMrZahX89+S6wJDqleSBf8bnZU/JAXzgYK3VoJE3DIsBS0eVCUhHbOo3gF4w8O2Jlb+1VPqM/wHJcl3GiGLbMhcSbzG2eJ5vwUL/E+62fiDByU6lmIi/4l0fJPAiPTyMgcTj0q0U/O+liM8pI18gi0NMgF2sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659051; c=relaxed/simple;
	bh=KpL3Y5PEKdflnZITTtl3R8Jts6F89kSv5DxuB5B3psQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rJw+mKk2F3QEG0OjA5O6J6W4ee/YiwUSLGaaqOKIQajTfuK/ALtEyDlL02GpqX3Tn5sVns5KGxetbhxCEFl4SyHnun9Wv3kdoQAMf4929t/+yoaQzhfBRQhFOYHskUuGcOKnmwc+EeYbnNd6lMW1MLpiGVIf2Wa9AwyIcxTSBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msTlLYyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msTlLYyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889381F00A3D;
	Sun,  6 Sep 2026 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659049;
	bh=mJLEZSIIo7/+3swM0NPSAFKKDshxwBAUalNJtrrZRZ0=;
	h=Date:From:To:Cc:Subject:References;
	b=msTlLYyAieKPXd92WSJJl8sF/gUXVWCfsXJJftD/D/fVnlVgLa1h74ujZpyULKdap
	 cx+6ONvD1mJKxEnJu7DOy5ZxWi9bcqxkrG273aDKrX35eNyY3jNtufNMdBLEqNUneP
	 sThnvMOoK/KQC8539MNeHrvt40qvKFGt1Dor6uZkbBNrjlVoQaTcFQBKSl5K1NeH4A
	 a/Zf5XrGCNIf2sQpHjblxt0aIIPQTzQsS9cEL0oCai5LDj9ZVqXleJV3cuMSoiBLts
	 v37v2CH+OX48TUx8jF4g9Rh2Ew+/POeLZxSqIh1kQnmy6kG6w++U+jm344+AUoJXQw
	 pxnaQgerVEGbw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x2whP-00000006J9g-1Ucj;
	Sat, 05 Sep 2026 16:09:15 -0400
Message-ID: <20260905200915.210359578@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 16:08:30 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [for-linus][PATCH 03/12] ftrace: Synchronize the initialization of ftrace_ops
References: <20260905200827.773347757@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

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
---
 kernel/trace/ftrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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
-- 
2.53.0


