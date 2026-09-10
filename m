Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED44A2A64
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049536; cv=none; b=FNVrfld4rOD92+nDj6lJRYg0PerenIBNDLqX8Ys5WRrjS+nOLVAMY3CtLvZ1NOhwR/LVBfMQRhlnVqFXmbQcVi1yo359ph97iYS5oSmdwXgpoCcBSuLivwkvpXU9dj+pvycBwu3MObApwuvBfekON9tRCvn6adkK/yk7HEVFSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049536; c=relaxed/simple;
	bh=oVdb5YK+v4o475YbC7On+ZqCVg0VY5s6e+Izz4zOfz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjW928cEgO6Tpb/zURvaX0RiRdgDzhNjk1kg7ymiv/WrJJwukbEf4DBjx+5jkjqF7bOFkKUX17MvWIvjvAb+iZCAL2S86VC1EXw2zFu+WTC/tlBZ8eo2DjcJ0ZVvWtB6yQtgNs7oTiB2sUYzlX1ToOeWECayUzCEuhim3/qmORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLyRpeR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLyRpeR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27361F000FF;
	Thu, 10 Sep 2026 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049535;
	bh=B1/p+9fEC0Jxbr45q/49ox7J/8CS0W/R4efGGt1Ff5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fLyRpeR0ELIrDXu87gzRxkL2kS+ovUFnf3wOcfga/IFARwMZs0RYdSyzwBIIWcuLt
	 IEk+pLtucogtFlpK6QhQDvqBlXwOByftZjGmc9YJUKUh+svP7jBas2AutcEu+GpR2h
	 rgX6XdcQ1om7mGa+KYk+ziv9pOtJXIk0nM+HulLW9KMR5tgDJ5UZwOjei+m90OCzA7
	 pNL4OP0BeBewxYVIAsgE4PXTU64lLmQzbEMMKZjJj2w8PEO4HFYiXcsfwYDKc6P4C6
	 vcBcJ9EaCaBGZTMezxH/UxI7FdrtQaRuy2R8BcDtyL5HmuaeZogfUIor5jitsRgg36
	 n0aCVIB4ojIqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ftrace: Synchronize the initialization of ftrace_ops
Date: Thu, 10 Sep 2026 10:12:12 -0400
Message-ID: <20260910141212.642140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090829-rundown-turbofan-bc25@gregkh>
References: <2026090829-rundown-turbofan-bc25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4617721c502b2ddaa4e324e86da4997edf738fa5 ]

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
[ adjusted INIT_OPS_HASH macro context for the missing subop_list member. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a5ddc3f7aefaa..c7e9ce10f506c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -75,6 +75,8 @@
 #define INIT_OPS_HASH(opsname)	\
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+/* Used only to synchronize the initialization of ftrace_ops */
+static DEFINE_MUTEX(ops_mutex);
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -159,10 +161,17 @@ const struct ftrace_ops ftrace_nop_ops = {
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
 		ops->func_hash = &ops->local_hash;
-		ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		flags = ops->flags | FTRACE_OPS_FL_INITIALIZED;
+		smp_store_release(&ops->flags, flags);
 	}
 #endif
 }
-- 
2.53.0

