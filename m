Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131A48EC81
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051179; cv=none; b=HPQV8gUYyLmDRhQKCDDHwdJyj1Da316k+Km4af9LmcS2kIGgAo15FkI2j1EZwxXQ1EH1jYxc+DCqR+CWkBvR2eqyYa9jPuoC4WRiwHjf0ll47IoNo8ZUmWzRc0VJC4VSniGSUkQKuWIvWpMQFwri98Khpry5C2eDpkyNBLPwIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051179; c=relaxed/simple;
	bh=w7YbxqbAJlwjHqCxWp6DwgFIeq6cY4LDcTihsXzl7YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8OMucZjeLrPexmvPqwYE1IRjzrFgt+UVlNFMmxprLXf3cUKLgHZ6ZrXlhFEI0vxfHO6qzPFNOsSdeVlOIXsjSjPjuvczzdPNp40jyVHiQnJzIpZ9kljwHNzKz5IepgJjbB99E+POmJdVrxl4PRtAf79Wx6g2llTHxWZNWOcE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhAlbAxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhAlbAxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA901F0089B;
	Thu, 10 Sep 2026 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051177;
	bh=dTTcVmu9Xhki5UVLa7K3WfY34XLCI+LSG/KEcvCpJ5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NhAlbAxkhicXtGUXLW9mABxxEbF0NJ/1SH1xdLHt9WcesVxqGZR7mUB6cUVB8kQOb
	 aCO7CFYpkUlvK0M7aA8P/vQ3Sx1fJbd86RBwlHZAsSAXpMuRNZlo5YX2lHOGNAlXBS
	 UC5ZXjlObtVdiAwBypexOJVXcO0pAfFa3cU57sQ/4h5MLQKyPKyN5FstRNwfOl58mY
	 V7nXpTCcnTnq6hLiKFc1JV2TW/b8XrV61VC49gIygWKQPUrZVnFZd0Ph+WmsFy98pu
	 2s8pxcZXwmn8uhj82WMiwNmI/ue0lf7qZ4WxUWoyT/FtCbqXF9EbI4wU1ypbVtwcu3
	 ri9UPO8Y0MiTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ftrace: Synchronize the initialization of ftrace_ops
Date: Thu, 10 Sep 2026 10:39:35 -0400
Message-ID: <20260910143935.771514-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090830-salsa-spoiler-5c6d@gregkh>
References: <2026090830-salsa-spoiler-5c6d@gregkh>
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
index f45022df3f816..2a17499894089 100644
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

