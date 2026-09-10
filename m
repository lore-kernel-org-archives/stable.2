Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A71493D4F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050238; cv=none; b=ZhLI4dIoWlG0nj7lYJXmAl4ITU1LTpO7RqlppFv2z8Ae7C6g/9hTSo5mD16S9An48mjcJ3nnsNevHeymT6qWQgsRy1GeGrOCoS8sHO37H42Ag1jNQcIjGg6bNyf1JaJ+0ozYjbMQrc+OBKAXelMxxlmDgrgSl5Rkg6DCi7HrZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050238; c=relaxed/simple;
	bh=82CLORQTehejI8o5yAbTUXI+v6cfVPH4GSbjhyBlsQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnfW8ydcaP8gum1FsgUjU6x2GpXMXj0j52lPUrkArGWiWw0L0cVK84HhZUV4W2FvOO7hsMl3isKHU5K6Z0UnQGFh3CobVMdPMl1AGgWVE1UbniFy1Ja90Tkl1yqkYtbroRN3zvp1i0VyeszJb8LDnzcs6bJeOF4QG9OFN+io3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3xbe2gU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3xbe2gU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6071F00893;
	Thu, 10 Sep 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050236;
	bh=9v+WqGLfbH6YYtcLSru6WfvGhuOvauCb4oJO1SexgxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f3xbe2gUMpEt2tsS25yTsyIhGW1AtmXidbq0Pw8MsVtQBxyOMjpK3QHLFAF19nh+K
	 8zUaTCdDxhE1bAJg7Em/3N+n5OU4MTd5GxACOXfU7pRttDT1BGYmpmZ5k+4H1Ah2BB
	 JNteqrlzzSxl1eOm5M16AVBxQi8bB0KSYRHakVNnegstcOmiP4w2aAEMFyIWL5xbXt
	 kIPalXNyjem7h6rhh4cIKlRXnkiFlsRDxy5td59AKbCaiYaRGdnluRdd2NIFE/V/sj
	 ivEW9V2bhNHALLULXukQssi/4tJXabLIRCBL1+oHPk0cfJU6zxPlH+1ESWSOdte7J/
	 swNf6eDGh+IjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ftrace: Synchronize the initialization of ftrace_ops
Date: Thu, 10 Sep 2026 10:23:54 -0400
Message-ID: <20260910142354.675288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090829-luminous-distort-6af9@gregkh>
References: <2026090829-luminous-distort-6af9@gregkh>
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
index ad112022dad78..62f00f576e014 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -71,6 +71,8 @@
 #define INIT_OPS_HASH(opsname)	\
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+/* Used only to synchronize the initialization of ftrace_ops */
+static DEFINE_MUTEX(ops_mutex);
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -128,10 +130,17 @@ void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
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

