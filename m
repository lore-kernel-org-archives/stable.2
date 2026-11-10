Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350490;
	b=VH4yb/p69VIlsjgVfNbG2FLQttTGcyiKDSQ18Ogcvt6qxbDPzGoa0SstUWY+/5w9sH3Z
	 FJScoWYF5MXh1zp0oMncEFQCLYAFfsiUJMgpXB7bdwXpJRZ9AKzM+qRTYyPPSDrv7VbLy
	 G8IE1fuFW6ECN62/Qn88nQZE9zvF5+Qv7qdprSwgpmCMkMLMDnTvQxjU7R6MGhvaWaqB1
	 evvT/uaojSyRJrXvPS/NmJdUyj4y90cI1FsLAuJjnF75Eqje3bONVYXArNjsrHYZUqY3Q
	 6F0afVrVroWVZ+M9KtQtdPcNGUE2pryxOlW0Ef+OeUIktIzR5gQwqY2QS/5LRwob5xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0XAJHJYp0VwB5lT3IMXI0DN8L3ynIaTP18MGrJs6O1o=;
	b=sQ/GizyqDX1ZoSZzBQ2B0goltBA25mkCDwh2nv/vNCWs9yGu4wHla1wpsNa/QKylONvV
	 bGS7i5DLpIaIci8On2F8az+ZuHY5JYj9HP8j3abK1rrA5A5pKasHiO+I7+yn72XccBnuw
	 pnF5HUQuGuA+ypUPKxGB0NCsglXQNp+ldqspb/N5jdMApwgnIIO/VGJk9BrLXwWw2EAYZ
	 YBqyCUJH3TyBaT0zbFsOWT7x0on87dkVaxdmO0fsPUl+ref8jOr1vVFe1wXP0qQPs2XsL
	 BNWRNnJeYdjiQwoXu8xm+TzazP1f1x71rwwvlD4eyzwRNA7CHBRIUNrjiAEziUZ6aGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbnOcWHa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361A606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbnOcWHa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3811F008A4;
	Tue, 10 Nov 2026 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350489;
	bh=0XAJHJYp0VwB5lT3IMXI0DN8L3ynIaTP18MGrJs6O1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GbnOcWHadxfBtfeR6Y7HjGEUP29OobR8GFCmSpvznA9Uql3AvWLgQFm3jOtV/7DU5
	 5t1nJlbbAccPG6inSdFgIShoT9WCnZpPHutk9dap0S+c5nFqqL67V7U61lfICjzQzL
	 ZnKuBbbfZjYhO6+hnIv65yLXaFHKi9v2cWHxEsCR/Z4AqL2Q6N6/vm0fiXZ5cYxOqP
	 jX4XNeF5xFSSlTyWFkWCatpglWRauUXCMEZQoRuujFt3QVR6FQPKzup0phbclUh4yh
	 CUoGIO+8ruVYBlOg/I84MbDkN39yAunvgApW8lcQnHrAhW+tuO+tVR+LYpPVMMxum0
	 C26+vPJYTU56Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Gladkov <legion@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] ucounts: Split rlimit and ucount values and max values
Date: Tue, 10 Nov 2026 17:41:23 -0500
Message-ID: <20261110223252.3777469-2-sashal@kernel.org>
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

From: Alexey Gladkov <legion@kernel.org>

[ Upstream commit de399236e240743ad2dd10d719c37b97ddf31996 ]

Since the semantics of maximum rlimit values are different, it would be
better not to mix ucount and rlimit values. This will prevent the error
of using inc_count/dec_ucount for rlimit parameters.

This patch also renames the functions to emphasize the lack of
connection between rlimit and ucount.

v3:
- Fix BUG:KASAN:use-after-free_in_dec_ucount.

v2:
- Fix the array-index-out-of-bounds that was found by the lkp project.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Link: https://lkml.kernel.org/r/20220518171730.l65lmnnjtnxnftpq@example.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Stable-dep-of: b14fcabd34e0 ("ucount: take the rlimit reference before checking the limit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c                      |  2 +-
 fs/proc/array.c                |  2 +-
 include/linux/user_namespace.h | 35 +++++++++++++++++++++-------------
 kernel/fork.c                  | 12 ++++++------
 kernel/sys.c                   |  2 +-
 kernel/ucount.c                | 34 +++++++++++++++------------------
 kernel/user_namespace.c        | 10 +++++-----
 7 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 5efe7ae6f9685..e573d35cb2037 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1914,7 +1914,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * whether NPROC limit is still exceeded.
 	 */
 	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	    is_rlimit_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		retval = -EAGAIN;
 		goto out_ret;
 	}
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65f4e4df785d6..d7101eb734316 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -274,7 +274,7 @@ static inline void task_sig(struct seq_file *m, struct task_struct *p)
 		collect_sigign_sigcatch(p, &ignored, &caught);
 		num_threads = get_nr_threads(p);
 		rcu_read_lock();  /* FIXME: is this correct? */
-		qsize = get_ucounts_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
+		qsize = get_rlimit_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
 		rcu_read_unlock();
 		qlim = task_rlimit(p, RLIMIT_SIGPENDING);
 		unlock_task_sighand(p, &flags);
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f1..45f09bec02c48 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -54,15 +54,17 @@ enum ucount_type {
 	UCOUNT_FANOTIFY_GROUPS,
 	UCOUNT_FANOTIFY_MARKS,
 #endif
+	UCOUNT_COUNTS,
+};
+
+enum rlimit_type {
 	UCOUNT_RLIMIT_NPROC,
 	UCOUNT_RLIMIT_MSGQUEUE,
 	UCOUNT_RLIMIT_SIGPENDING,
 	UCOUNT_RLIMIT_MEMLOCK,
-	UCOUNT_COUNTS,
+	UCOUNT_RLIMIT_COUNTS,
 };
 
-#define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
-
 struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
@@ -99,6 +101,7 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+	long rlimit_max[UCOUNT_RLIMIT_COUNTS];
 } __randomize_layout;
 
 struct ucounts {
@@ -107,6 +110,7 @@ struct ucounts {
 	kuid_t uid;
 	atomic_t count;
 	atomic_long_t ucount[UCOUNT_COUNTS];
+	atomic_long_t rlimit[UCOUNT_RLIMIT_COUNTS];
 };
 
 extern struct user_namespace init_user_ns;
@@ -120,21 +124,26 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
 struct ucounts * __must_check get_ucounts(struct ucounts *ucounts);
 void put_ucounts(struct ucounts *ucounts);
 
-static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type type)
+static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type type)
 {
-	return atomic_long_read(&ucounts->ucount[type]);
+	return atomic_long_read(&ucounts->rlimit[type]);
 }
 
-long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
-bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
-void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
+long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
+bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
+void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
+bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
+
+static inline long get_userns_rlimit_max(struct user_namespace *ns, enum rlimit_type type)
+{
+	return READ_ONCE(ns->rlimit_max[type]);
+}
 
-static inline void set_rlimit_ucount_max(struct user_namespace *ns,
-		enum ucount_type type, unsigned long max)
+static inline void set_userns_rlimit_max(struct user_namespace *ns,
+		enum rlimit_type type, unsigned long max)
 {
-	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
+	ns->rlimit_max[type] = max <= LONG_MAX ? max : LONG_MAX;
 }
 
 #ifdef CONFIG_USER_NS
diff --git a/kernel/fork.c b/kernel/fork.c
index 25fb13362d38c..87c08297fbee6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -850,13 +850,13 @@ void __init fork_init(void)
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
+	for (i = 0; i < UCOUNT_COUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
@@ -2176,7 +2176,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_free;
 
 	retval = -EAGAIN;
-	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
diff --git a/kernel/sys.c b/kernel/sys.c
index 3aa55bdcb7e41..89d8c850c13a1 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -489,7 +489,7 @@ static void flag_nproc_exceeded(struct cred *new)
 	 * for programs doing set*uid()+execve() by harmlessly deferring the
 	 * failure to the execve() stage.
 	 */
-	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
+	if (is_rlimit_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
 			new->user != INIT_USER)
 		current->flags |= PF_NPROC_EXCEEDED;
 	else
diff --git a/kernel/ucount.c b/kernel/ucount.c
index a751fb6e94e51..2e2c9c2096781 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -87,10 +87,6 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_fanotify_groups"),
 	UCOUNT_ENTRY("max_fanotify_marks"),
 #endif
-	{ },
-	{ },
-	{ },
-	{ },
 	{ }
 };
 #endif /* CONFIG_SYSCTL */
@@ -257,29 +253,29 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 	put_ucounts(ucounts);
 }
 
-long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
+long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 {
 	struct ucounts *iter;
 	long max = LONG_MAX;
 	long ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long new = atomic_long_add_return(v, &iter->ucount[type]);
+		long new = atomic_long_add_return(v, &iter->rlimit[type]);
 		if (new < 0 || new > max)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return ret;
 }
 
-bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
+bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 {
 	struct ucounts *iter;
 	long new = -1; /* Silence compiler warning */
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long dec = atomic_long_sub_return(v, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(v, &iter->rlimit[type]);
 		WARN_ON_ONCE(dec < 0);
 		if (iter == ucounts)
 			new = dec;
@@ -288,11 +284,11 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 }
 
 static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
-				struct ucounts *last, enum ucount_type type)
+				struct ucounts *last, enum rlimit_type type)
 {
 	struct ucounts *iter, *next;
 	for (iter = ucounts; iter != last; iter = next) {
-		long dec = atomic_long_sub_return(1, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 		WARN_ON_ONCE(dec < 0);
 		next = iter->ns->ucounts;
 		if (dec == 0)
@@ -300,12 +296,12 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
 	}
 }
 
-void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type)
+void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 {
 	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
 }
 
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
@@ -313,12 +309,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	long dec, ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long new = atomic_long_add_return(1, &iter->ucount[type]);
+		long new = atomic_long_add_return(1, &iter->rlimit[type]);
 		if (new < 0 || new > max)
 			goto dec_unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
@@ -330,23 +326,23 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	}
 	return ret;
 dec_unwind:
-	dec = atomic_long_sub_return(1, &iter->ucount[type]);
+	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 	WARN_ON_ONCE(dec < 0);
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
 	return 0;
 }
 
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
+bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long rlimit)
 {
 	struct ucounts *iter;
 	long max = rlimit;
 	if (rlimit > LONG_MAX)
 		max = LONG_MAX;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long val = get_ucounts_value(iter, type);
+		long val = get_rlimit_value(iter, type);
 		if (val < 0 || val > max)
 			return true;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return false;
 }
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5481ba44a8d68..981bb2d10d836 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -131,13 +131,13 @@ int create_user_ns(struct cred *new)
 	ns->owner = owner;
 	ns->group = group;
 	INIT_WORK(&ns->work, free_user_ns);
-	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
+	for (i = 0; i < UCOUNT_COUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, enforced_nproc_rlimit());
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_NPROC, enforced_nproc_rlimit());
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
-- 
2.53.0

