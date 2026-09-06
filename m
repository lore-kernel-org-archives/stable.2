Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D533ADB3;
	Sun,  6 Sep 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659150; cv=none; b=T2F2EABgx/f1jhRrB74TOiNWI8xbffJpUEqDLs2cUHNyoozX5yC3vwxXKPWB2toDdMEQrQ+hNe3ELHIvk93rTOodW5WwANpaOhx0hdLxQIZLC6br1kGftc2yo2imMQLh8DXPVFRYtS7c3OsUmPk1jQb6c+smGiKwVNAAHFXNGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659150; c=relaxed/simple;
	bh=KpL3Y5PEKdflnZITTtl3R8Jts6F89kSv5DxuB5B3psQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TLVgyCi+erRZ2PlrZmNL/DfcmayTtCIC3rQYyR2qs2L2otad0PAG8UYCs2pLmPanY/F9oOQ4KpHsRWarS4jFKrtnIFqJMM9MNK0gz7XmqUL7T3aZa75Uf/yV5PK/rPzEeYeQlOt7nzXHmtXDHMngQpVWuI6+tRbOCSPBRw/h6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh5J4n99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh5J4n99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE95F1F00A3F;
	Sun,  6 Sep 2026 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659146;
	bh=mJLEZSIIo7/+3swM0NPSAFKKDshxwBAUalNJtrrZRZ0=;
	h=Date:From:To:Cc:Subject:References;
	b=Vh5J4n99SZuOIOcWDDRf8N5bYtbt8eYgZ6VHzJgQpT2cvvju4/JHk80BPHjNPllXE
	 sha7TKj//7WNOBnOnf9htZ396arx80pUpE3PkjX3uoOVjDMEqRNz3Pz36ZnQM3JDTy
	 /t7pY2D+riwRcb2TqXKjVGOLwbbHKYVJDG0/DTxfdxDSJZYYnPCUS6QArQjs6pa8m8
	 1i04BIlozYfQtSZjdLGAvdOD0b2JvXDJul5AGOosoWEVZFWY7d6bblmakzFNw7Q16E
	 2dHEjeYsXGAi+YMfW5zSprV4Gv7ju3HWRXH7F1uq6ah8ndVGUqrecSByJ6j262tKry
	 2V+0Hbfm7afsw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x31yB-00000006POf-31NE;
	Sat, 05 Sep 2026 21:46:55 -0400
Message-ID: <20260906014655.571889474@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 21:45:34 -0400
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
References: <20260906014531.720267751@kernel.org>
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


