Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322992;
	b=MwxIYqJuZIUYgoHWZYto7ZsxWkx5F2vR40ukH5pu4uhyQFjBVjv9cP/+sp4gh0EuHDH9
	 5mFQBoUk/wNJpJ5lhLwK+zxuCqzg5NPfbzdboOPZI8SrQXxLae/jI/kFTDyB4Ic1eNgSb
	 Y722bf51siAEYkm6B94G8And4aEaeVbKM4ktCvQ8K+fghsCVRm6k7Kf9EsL8CkS9ZmNo9
	 5fIEQcYI1yXxqlkJpk4EZy9Pe9GFCoNtRE2hUPkhkwLqEKSVO5iR52TulC2SqKgPADIGW
	 /ZFBfPclLgwt9Th7POt0onQduZwAJrZS5a5BifnXqZojBIe2n3UHrMbwXe+g9jmyO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L9r0BQEBTlNmHrLUrOxeUisLjpByUTQ+An87c3dTi94=;
	b=XeqFjYhiRmaljUfMcOS8Ior436IVSx19uV93jcrfVNLOPJAkht4tltsyJbJR4kt32ZJ3
	 YOtarWPhp13++DM2VEflddCKO9OUsfu9RWCKq1hcCD1bFmEJnn69MAMrTqjlVX7pZahjW
	 72dtxMzg47pBp8z3ZP90SBQ6kkdLU0w/3d5kzPxUX9pbyBVAq5Q+3at1kiPeWvd0n7wwN
	 NP0TeR8YY1rvOxa+QoJFv4X9L7jH0lBFIarL/BKa5T1lUaX6VrpWi+Fs1/hAUlWrPA2oH
	 3NbSmJfYPRrKAdoJCOwg1JBGEX1bD4boEvcUU/XWt3diktseiYsRhABQFaQFPBOsCyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8IhXB+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C77606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8IhXB+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861871F008A2;
	Tue, 10 Nov 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322992;
	bh=L9r0BQEBTlNmHrLUrOxeUisLjpByUTQ+An87c3dTi94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8IhXB+urR3Sg772givKywW7OSZ3GG5CPi1dYHrkyWZutkQIrhGgq3eQDQqiFzsAV
	 HUWpTq/8Eyj8QaFUGYWw2opOQ0efZjsXPKOEqZDUwLl4c6hTWN3W8vgFTqTIgePY3z
	 bp56CuX/GcaC+YQy0H0daT/paY/Pqg3i6pwpSnCFdyMplKe8+n/T01r6uwZifJZIxU
	 mPbcKmMB5hNH+4W1tj37qGYvO95oRy+BbsFfpbdBC+eF10NS+Dkwdd1PIp0YHqNRbQ
	 XF3AyywKMqdhtWbpQ7gWodck7EFOiZcIS4wQU+QHchV+D3ERu6BLMK6VkAjpmAalHV
	 sl+cXQIe+kNoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] cgroup: Expose some cgroup helpers
Date: Tue, 10 Nov 2026 10:03:09 -0500
Message-ID: <20261110150235.2004727-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050942-failed-6.18-15da1e4978dd@kernel.org>
References: <20261107050942-failed-6.18-15da1e4978dd@kernel.org>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 5b30afc20b3fea29b9beb83c6415c4ff06f774aa ]

Expose the following through cgroup.h:

- cgroup_on_dfl()
- cgroup_is_dead()
- cgroup_for_each_live_child()
- cgroup_for_each_live_descendant_pre()
- cgroup_for_each_live_descendant_post()

Until now, these didn't need to be exposed because controllers only cared
about the css hierarchy. The planned sched_ext hierarchical scheduler
support will be based on the default cgroup hierarchy, which is in line
with the existing BPF cgroup support, and thus needs these exposed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 15da1e4978dd ("mm/mglru: fix ineffective memory protection for non-kswapd reclaim")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cgroup.h          | 65 ++++++++++++++++++++++++++++++++-
 kernel/cgroup/cgroup-internal.h |  6 ---
 kernel/cgroup/cgroup.c          | 55 ----------------------------
 3 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 7b2807009155a..e53524027b737 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -42,6 +42,14 @@ struct kernel_clone_args;
 
 #ifdef CONFIG_CGROUPS
 
+/*
+ * To avoid confusing the compiler (and generating warnings) with code
+ * that attempts to access what would be a 0-element array (i.e. sized
+ * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
+ * constant expression can be added.
+ */
+#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
+
 enum css_task_iter_flags {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
@@ -76,6 +84,7 @@ enum cgroup_lifetime_events {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct blocking_notifier_head cgroup_lifetime_notifier;
 
@@ -103,6 +112,8 @@ extern struct blocking_notifier_head cgroup_lifetime_notifier;
 #define cgroup_subsys_on_dfl(ss)						\
 	static_branch_likely(&ss ## _on_dfl_key)
 
+bool cgroup_on_dfl(const struct cgroup *cgrp);
+
 bool css_has_online_children(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss);
 struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgroup,
@@ -273,6 +284,32 @@ void css_task_iter_end(struct css_task_iter *it);
 	for ((pos) = css_next_descendant_post(NULL, (css)); (pos);	\
 	     (pos) = css_next_descendant_post((pos), (css)))
 
+/* iterate over child cgrps, lock should be held throughout iteration */
+#define cgroup_for_each_live_child(child, cgrp)				\
+	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       cgroup_is_dead(child); }))			\
+			;						\
+		else
+
+/* walk live descendants in pre order */
+#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
+	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
+/* walk live descendants in postorder */
+#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
+	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
 /**
  * cgroup_taskset_for_each - iterate cgroup_taskset
  * @task: the loop cursor
@@ -335,6 +372,27 @@ static inline u64 cgroup_id(const struct cgroup *cgrp)
 	return cgrp->kn->id;
 }
 
+/**
+ * cgroup_css - obtain a cgroup's css for the specified subsystem
+ * @cgrp: the cgroup of interest
+ * @ss: the subsystem of interest (%NULL returns @cgrp->self)
+ *
+ * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
+ * function must be called either under cgroup_mutex or rcu_read_lock() and
+ * the caller is responsible for pinning the returned css if it wants to
+ * keep accessing it outside the said locks.  This function may return
+ * %NULL if @cgrp doesn't have @subsys_id enabled.
+ */
+static inline struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
+						     struct cgroup_subsys *ss)
+{
+	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
+		return rcu_dereference_check(cgrp->subsys[ss->id],
+					lockdep_is_held(&cgroup_mutex));
+	else
+		return &cgrp->self;
+}
+
 /**
  * css_is_dying - test whether the specified css is dying
  * @css: target css
@@ -371,6 +429,11 @@ static inline bool css_is_self(struct cgroup_subsys_state *css)
 	return false;
 }
 
+static inline bool cgroup_is_dead(const struct cgroup *cgrp)
+{
+	return !(cgrp->self.flags & CSS_ONLINE);
+}
+
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
@@ -386,8 +449,6 @@ static inline void cgroup_put(struct cgroup *cgrp)
 	css_put(&cgrp->self);
 }
 
-extern struct mutex cgroup_mutex;
-
 static inline void cgroup_lock(void)
 {
 	mutex_lock(&cgroup_mutex);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 22051b4f1ccbc..e4a872e2e08c2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -184,11 +184,6 @@ extern bool cgrp_dfl_visible;
 	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
 	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
 
-static inline bool cgroup_is_dead(const struct cgroup *cgrp)
-{
-	return !(cgrp->self.flags & CSS_ONLINE);
-}
-
 static inline bool notify_on_release(const struct cgroup *cgrp)
 {
 	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -222,7 +217,6 @@ static inline void get_css_set(struct css_set *cset)
 }
 
 bool cgroup_ssid_enabled(int ssid);
-bool cgroup_on_dfl(const struct cgroup *cgrp);
 
 struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root);
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index aa629b7d76e53..ac7b2103df68a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -70,14 +70,6 @@
 /* let's not notify more than 100 times per second */
 #define CGROUP_FILE_NOTIFY_MIN_INTV	DIV_ROUND_UP(HZ, 100)
 
-/*
- * To avoid confusing the compiler (and generating warnings) with code
- * that attempts to access what would be a 0-element array (i.e. sized
- * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
- * constant expression can be added.
- */
-#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
-
 /*
  * cgroup_mutex is the master lock.  Any modification to cgroup or its
  * hierarchy must be performed while holding it.
@@ -513,27 +505,6 @@ static u16 cgroup_ss_mask(struct cgroup *cgrp)
 	return cgrp->root->subsys_mask;
 }
 
-/**
- * cgroup_css - obtain a cgroup's css for the specified subsystem
- * @cgrp: the cgroup of interest
- * @ss: the subsystem of interest (%NULL returns @cgrp->self)
- *
- * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
- * function must be called either under cgroup_mutex or rcu_read_lock() and
- * the caller is responsible for pinning the returned css if it wants to
- * keep accessing it outside the said locks.  This function may return
- * %NULL if @cgrp doesn't have @subsys_id enabled.
- */
-static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
-					      struct cgroup_subsys *ss)
-{
-	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
-		return rcu_dereference_check(cgrp->subsys[ss->id],
-					lockdep_is_held(&cgroup_mutex));
-	else
-		return &cgrp->self;
-}
-
 /**
  * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
  * @cgrp: the cgroup of interest
@@ -745,32 +716,6 @@ EXPORT_SYMBOL_GPL(of_css);
 	}								\
 } while (false)
 
-/* iterate over child cgrps, lock should be held throughout iteration */
-#define cgroup_for_each_live_child(child, cgrp)				\
-	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       cgroup_is_dead(child); }))			\
-			;						\
-		else
-
-/* walk live descendants in pre order */
-#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
-	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
-/* walk live descendants in postorder */
-#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
-	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
 /*
  * The default css_set - used by init and its children prior to any
  * hierarchies being mounted. It contains a pointer to the root state
-- 
2.53.0

