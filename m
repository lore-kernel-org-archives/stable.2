Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350491;
	b=jNhmBVCd3bdzMjf5trblreJry6UskjO5Olk0prtSWxMSGoXlOGx9UAjEX8JQbaRfv7NK
	 ulSTkoB3Y3aXScGvcsFsWWsmNnnJwJVe96A/r9oljRTD+K0Xw0SJQkf5N1PhDfMRQhLSK
	 9XUSX6ANlIJhIq/Jlco3VQtveVcci8W0rPR4GV6TEHtMK3yPSlX+PjvOd9AeDa4csXmaG
	 dMQwhd7rtVob1jGGfg0Gfdcppt+yAQbf8rY4shup+bVPd3gQGdEk+I6z4SqGtN3vKLY+A
	 bB48E4TvFupZV5c3Bl1OQWD31JBes2MB4gsZU5aX75lAPtmnB1o8O0R/bVNbWHd0FJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g9wm6/lCShYNXe+XTSX7mI6EGzIWaMRnExEbInoAULA=;
	b=d8pcKKGD2pDmOJFL+gBbCEiVMUqXfujwgjYZKV4lGHf35pZHWHQ5jD42DgDMXyZKzbCk
	 qjzMfeWcLpB4YZKmdW9BX9u9bMCN57QdVxfj4Y70Xl+2hDkqlNoo7du2nlgIPjIFkgXlc
	 lsiyNH3WBWErAve1hi7dettBeSH89Zlcfm0XaMa6S8+W9LG8kmU7rhTiQKqO7RL8pMNs3
	 PXuqvWBah3NO59mdRpVQlnB1t4dIjFo/1W+UYvVAt4De8izdtagYlMo8UimIqmVSldcZC
	 1YB8wJxXDErJxj0oQ5+iRR2QhGadSiDW4Zmu+MG2dLSx5qZE/cUnX7YPjFbOedhhYBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGOxQN3Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B42606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGOxQN3Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F349A1F008A2;
	Tue, 10 Nov 2026 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350490;
	bh=g9wm6/lCShYNXe+XTSX7mI6EGzIWaMRnExEbInoAULA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGOxQN3ZQHA9/xtOa0+HqSpdc9kLiYPnglGwqU830N9cSM1olOZg62H0tBT8Hql0x
	 g23fCWWmjWJpKJTC0oSXE+Fr+WjJyO0jP89jLViamCbs/wDAbVdm5W4Lcwkae8jKwy
	 B/BC3W59x3/6XvsZLHABrSQSYfkQKLnF6mRFO1pVqh2Pi/af3ezQ2SXAJh5EQNB+xQ
	 tASJRsFAuFCO8CxNHAHxiwW2cUgcZNTyQduuphtgiWayd29HRGyBBr6k5HqHv3J4pQ
	 APkeVStzxPEzaYu9fDX9uSXaZZBKj8Mwg93Ca039nvwR5qSXZxK3cbNrV8Qk8vS/97
	 q0s15hWHfGOBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrei Vagin <avagin@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexey Gladkov <legion@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] signal: restore the override_rlimit logic
Date: Tue, 10 Nov 2026 17:41:24 -0500
Message-ID: <20261110223252.3777469-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110223252.3777469-1-sashal@kernel.org>
References: <20261107061036-failed-5.15-b14fcabd34e0@kernel.org>
 <20261110223252.3777469-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Gushchin <roman.gushchin@linux.dev>

[ Upstream commit 9e05e5c7ee8758141d2db7e8fea2cab34500c6ed ]

Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class of
signals.  However now it's enforced unconditionally, even if
override_rlimit is set.  This behavior change caused production issues.

For example, if the limit is reached and a process receives a SIGSEGV
signal, sigqueue_alloc fails to allocate the necessary resources for the
signal delivery, preventing the signal from being delivered with siginfo.
This prevents the process from correctly identifying the fault address and
handling the error.  From the user-space perspective, applications are
unaware that the limit has been reached and that the siginfo is
effectively 'corrupted'.  This can lead to unpredictable behavior and
crashes, as we observed with java applications.

Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and skip
the comparison to max there if override_rlimit is set.  This effectively
restores the old behavior.

Link: https://lkml.kernel.org/r/20241104195419.3962584-1-roman.gushchin@linux.dev
Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Co-developed-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Alexey Gladkov <legion@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

override_rlimit is set.  This behavior change caused production issues.

For example, if the limit is reached and a process receives a SIGSEGV
signal, sigqueue_alloc fails to allocate the necessary resources for the
signal delivery, preventing the signal from being delivered with siginfo.

Stable-dep-of: b14fcabd34e0 ("ucount: take the rlimit reference before checking the limit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/user_namespace.h | 3 ++-
 kernel/signal.c                | 3 ++-
 kernel/ucount.c                | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 45f09bec02c48..733f2a97589b2 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -131,7 +131,8 @@ static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type ty
 
 long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
 bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
+			    bool override_rlimit);
 void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
 bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index c4091812ea89b..5d110fd089d10 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -426,7 +426,8 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	 */
 	rcu_read_lock();
 	ucounts = task_ucounts(t);
-	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
+	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING,
+					    override_rlimit);
 	rcu_read_unlock();
 	if (!sigpending)
 		return NULL;
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 2e2c9c2096781..1459c1c579dc0 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -301,7 +301,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
 }
 
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
+			    bool override_rlimit)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
@@ -314,7 +315,8 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 			goto dec_unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = get_userns_rlimit_max(iter->ns, type);
+		if (!override_rlimit)
+			max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
-- 
2.53.0

