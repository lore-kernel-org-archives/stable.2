Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D2490C0E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050929; cv=none; b=CiGdnlXdlqfybwniAfeewwzB11O88FLweQpaQFaIzdEtYFZTkEtk+zigpgSlH+EDUKhlnnRjb+0zvuuEL6n17VAHI1EL03oUQDaVqHu5i/xqLg7N6Z9HtqUNn2s/h7lYa0y/V8Nhou5tqBSi1VlEZSuPU+51JHve/x5lIJ6vhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050929; c=relaxed/simple;
	bh=pgnv5RL8IaIjrZ2vX109n2cUYrvZOkyj5OObyv/tJ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDO69tlCnb6ba/HACyMZnmDMezEDDybxsLPiehlo0uNrafD3445pV1B8fOLaNCiUlt4XdaW5IuGLSHo5hj2E3pQiWmk0cHQvIWpaDQF71hZ0lnfkpTLiv8gVu3HOO4iFi1NvShbOsg8U8rhL91SvOoHfMxQLhMFe6Wex1CeQNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMkN48qR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMkN48qR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35C91F000FF;
	Thu, 10 Sep 2026 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050927;
	bh=BQk7xUNzaH8pm3K17B2wCcgHVSQ5yVyR1zV1OS23oWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMkN48qRDeuixRv3PoJ7jkk52AOFkQ+iDunqadFYM702jTI88wLH+KIXoRs3j6EBN
	 eHPRJSs7RgenJ3YsefcvGnINhBcMG4CDTWYZBUEo3OIP2cWFdNzzKVP2YOXKbnHMxU
	 sfMNvj4CcaOLVtlqVeZ3st0bP93cd+HzLK9haL3JcdhwokPZrPYuBW/LrpMyttE1gs
	 J27KTzfH/e4VvHDXziXBYHgDbM5HjLEMMRc0WbEmhR5YSbcTREItkiPulGwwMvN08q
	 mrbXeWfPTh0HTvzhxZhgHFlakYYR9avqo5OG1hlMRS+FHo7Z0MWRMfGUYiRVDC3G79
	 at8NLUFN2Gmiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ftrace: Synchronize the initialization of ftrace_ops
Date: Thu, 10 Sep 2026 10:35:24 -0400
Message-ID: <20260910143524.740150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090830-bonus-gaining-b7d0@gregkh>
References: <2026090830-bonus-gaining-b7d0@gregkh>
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
index 0e5d6264735c0..dd51aef80f921 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -69,6 +69,8 @@
 #define INIT_OPS_HASH(opsname)	\
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+/* Used only to synchronize the initialization of ftrace_ops */
+static DEFINE_MUTEX(ops_mutex);
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -131,10 +133,17 @@ static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
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

