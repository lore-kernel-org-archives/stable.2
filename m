Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1252CCEA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689574; cv=none; b=ZYhAwom/JaQ5dr4uIQsNvoUKhxLFS0A5wiW2OwrKBF4tKgEktOZlFbNjUKPk9hd1RyrOsF5dVLvO0AHg4fBwzqFjP052vzzsLiP0uo3sSyw/Qyo0s0WrdqASEC4GPja8doF8n8IcIvxAy4SLVD4O5xF3B1DtEBi675yAxvLZuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689574; c=relaxed/simple;
	bh=+N0E9T27vBFRvrzWxZbdOTdLqdoEcja6viHth+wHlk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLlbchpZ2/AXR4rKV+DgBmxn2G1cTcS2RHNd94qFYFYo2IHvxYtg6BGg3YzHBeTqpUHJnQyBRtEzfWt1s1yIMcwIDy0Eh9mjy6sIgJR4TzU4p63cOWhSeG1j94SaBOOqg2kmEM89LHbM0ug+oYtq/viw/lVR82ajgIi7WHE2fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nor/7xIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nor/7xIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5E21F00898;
	Tue, 29 Sep 2026 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689569;
	bh=qgrRHtScisJj5ZjTU83vI9Dk5Zi90nepbf5zU7hdk7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nor/7xIzkFokM1ghXtcNR80rqJElw6k5fhMojy7Gcc7BSaFN6xlcefhMADn0NXVn7
	 Q0sZWfx05AB4BZOuIPaHzz0VU7K559XtnHSg4oye4aC+JNW6ivBdZ68jI8fXpVNOm+
	 /RObdES9KPzGP+LeLUCGL2pL7sot7aGH2QIc9DP6nQI9hI62l22iJiKPEdyXZC9fpn
	 D0J2Oej3p2X4XsLAezGKjmD/v1m9ReTacJf60BF7+jCIzB23A+BXtUeirm6+wyBlOv
	 BFJsnbrCMLFvDyKPE0NC0Y+ul3/BiEkPT4xUlq5ROoX8hMlOmaQ7rPhp/D8VKci7G/
	 wjm26mXzMeqMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/5] landlock: Split struct landlock_domain from struct landlock_ruleset
Date: Tue, 29 Sep 2026 09:46:03 -0400
Message-ID: <20260929134605.3516662-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929134605.3516662-1-sashal@kernel.org>
References: <2026092944-secrecy-crouch-5bf3@gregkh>
 <20260929134605.3516662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 38411604162e6abe02741d3c364a4df46d6f612f ]

Switch all domain users to the new struct landlock_domain type
introduced by a previous commit, eliminating the conflation between
mutable rulesets and immutable domains. landlock_merge_ruleset() now
returns and allocates a struct landlock_domain, and the merge and
inherit helpers move next to it; the former static insert_rule() is
exported as landlock_store_rule() for its new caller across the
translation-unit boundary.

The merge destination is now a private struct landlock_domain still
under construction (owned by the calling thread, not yet shared), so the
merge and inherit helpers lock only the source ruleset: the previous
lock of both destination and source collapses to a single
mutex_lock(&src->lock).

Rename the per-layer access-mask field from access_masks to
handled_masks, naming it by the role it plays (the rights each layer
handles) rather than by its type, paralleling the struct access_masks
quiet_masks field.  Drop the now domain-only fields (hierarchy,
work_free, num_layers) from struct landlock_ruleset.

The new struct landlock_domain field in cred.h pulls in domain.h, which
includes audit.h, which previously included cred.h, forming an include
cycle.  Break it by having audit.h forward-declare the struct
landlock_cred_security and struct landlock_hierarchy it uses instead of
including cred.h.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Link: https://patch.msgid.link/20260811094338.288094-4-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Stable-dep-of: c4e941bb7654 ("landlock: Work around gcc-16 -Wuninitialized warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/access.h   |   2 +-
 security/landlock/audit.c    |  12 +-
 security/landlock/audit.h    |   4 +-
 security/landlock/cred.c     |   6 +-
 security/landlock/cred.h     |  21 ++-
 security/landlock/domain.c   | 258 +++++++++++++++++++++++++-
 security/landlock/domain.h   |  43 ++++-
 security/landlock/fs.c       |  25 ++-
 security/landlock/net.c      |   3 +-
 security/landlock/ruleset.c  | 338 +++++------------------------------
 security/landlock/ruleset.h  | 141 +++------------
 security/landlock/syscalls.c |  10 +-
 security/landlock/task.c     |  20 +--
 13 files changed, 403 insertions(+), 480 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index d926078bf0a5f..1a8227a709d93 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -19,7 +19,7 @@
 
 /*
  * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
+ * by a ruleset/layer.  This must be ORed with all domain->handled_masks[]
  * entries when we need to get the absolute handled access masks, see
  * landlock_upgrade_handled_access_masks().
  */
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 50536c5685262..7cb00619a741d 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -138,7 +138,7 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
 }
 
 static struct landlock_hierarchy *
-get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
+get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
 {
 	struct landlock_hierarchy *hierarchy = domain->hierarchy;
 	ssize_t i;
@@ -171,7 +171,7 @@ static void test_get_hierarchy(struct kunit *const test)
 		.parent = &dom1_hierarchy,
 		.id = 30,
 	};
-	struct landlock_ruleset dom2 = {
+	struct landlock_domain dom2 = {
 		.hierarchy = &dom2_hierarchy,
 		.num_layers = 3,
 	};
@@ -185,7 +185,7 @@ static void test_get_hierarchy(struct kunit *const test)
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
 /* Get the youngest layer that denied the access_request. */
-static size_t get_denied_layer(const struct landlock_ruleset *const domain,
+static size_t get_denied_layer(const struct landlock_domain *const domain,
 			       access_mask_t *const access_request,
 			       const struct layer_masks *masks)
 {
@@ -205,7 +205,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 
 static void test_get_denied_layer(struct kunit *const test)
 {
-	const struct landlock_ruleset dom = {
+	const struct landlock_domain dom = {
 		.num_layers = 5,
 	};
 	const struct layer_masks masks = {
@@ -682,8 +682,8 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
  * Only domains which previously appeared in the audit logs are logged again.
  * This is useful to know when a domain will never show again in the audit log.
  *
- * Called in a work queue scheduled by landlock_put_ruleset_deferred() called
- * by hook_cred_free().
+ * Called in a work queue scheduled by landlock_put_domain_deferred() called by
+ * hook_cred_free().
  */
 void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
 {
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 620f8a24291d5..4617a855712c4 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -12,7 +12,9 @@
 #include <linux/lsm_audit.h>
 
 #include "access.h"
-#include "cred.h"
+
+struct landlock_cred_security;
+struct landlock_hierarchy;
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index cc419de75cd6b..58b544993db49 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -22,7 +22,7 @@ static void hook_cred_transfer(struct cred *const new,
 	const struct landlock_cred_security *const old_llcred =
 		landlock_cred(old);
 
-	landlock_get_ruleset(old_llcred->domain);
+	landlock_get_domain(old_llcred->domain);
 	*landlock_cred(new) = *old_llcred;
 }
 
@@ -35,10 +35,10 @@ static int hook_cred_prepare(struct cred *const new,
 
 static void hook_cred_free(struct cred *const cred)
 {
-	struct landlock_ruleset *const dom = landlock_cred(cred)->domain;
+	struct landlock_domain *const dom = landlock_cred(cred)->domain;
 
 	if (dom)
-		landlock_put_ruleset_deferred(dom);
+		landlock_put_domain_deferred(dom);
 }
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index f287c56b5fd4b..e7830cfed0416 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "ruleset.h"
 #include "setup.h"
@@ -31,9 +32,9 @@
  */
 struct landlock_cred_security {
 	/**
-	 * @domain: Immutable ruleset enforced on a task.
+	 * @domain: Immutable domain enforced on a task.
 	 */
-	struct landlock_ruleset *domain;
+	struct landlock_domain *domain;
 
 #ifdef CONFIG_AUDIT
 	/**
@@ -70,22 +71,20 @@ landlock_cred(const struct cred *cred)
 static inline void landlock_cred_copy(struct landlock_cred_security *dst,
 				      const struct landlock_cred_security *src)
 {
-	landlock_put_ruleset(dst->domain);
+	landlock_put_domain(dst->domain);
 
 	*dst = *src;
 
-	landlock_get_ruleset(src->domain);
+	landlock_get_domain(src->domain);
 }
 
-static inline struct landlock_ruleset *landlock_get_current_domain(void)
+static inline struct landlock_domain *landlock_get_current_domain(void)
 {
 	return landlock_cred(current_cred())->domain;
 }
 
-/*
- * The call needs to come from an RCU read-side critical section.
- */
-static inline const struct landlock_ruleset *
+/* The call needs to come from an RCU read-side critical section. */
+static inline const struct landlock_domain *
 landlock_get_task_domain(const struct task_struct *const task)
 {
 	return landlock_cred(__task_cred(task))->domain;
@@ -126,7 +125,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	const union access_masks_all masks_all = {
 		.masks = masks,
 	};
-	const struct landlock_ruleset *domain;
+	const struct landlock_domain *domain;
 	ssize_t layer_level;
 
 	if (!cred)
@@ -139,7 +138,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	for (layer_level = domain->num_layers - 1; layer_level >= 0;
 	     layer_level--) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->handled_masks[layer_level],
 		};
 
 		if (layer.all & masks_all.all) {
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 3068576d14eae..2fd8b8532c8a8 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -15,7 +15,9 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/path.h>
 #include <linux/pid.h>
@@ -34,6 +36,36 @@
 #include "limits.h"
 #include "ruleset.h"
 
+static void build_check_domain(void)
+{
+	const struct landlock_domain domain = {
+		.num_layers = ~0,
+	};
+
+	BUILD_BUG_ON(domain.num_layers < LANDLOCK_MAX_NUM_LAYERS);
+}
+
+static struct landlock_domain *create_domain(const u32 num_layers)
+{
+	struct landlock_domain *new_domain;
+
+	build_check_domain();
+	new_domain = kzalloc_flex(*new_domain, handled_masks, num_layers,
+				  GFP_KERNEL_ACCOUNT);
+	if (!new_domain)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&new_domain->usage, 1);
+	new_domain->rules.root_inode = RB_ROOT;
+
+#if IS_ENABLED(CONFIG_INET)
+	new_domain->rules.root_net_port = RB_ROOT;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	new_domain->num_layers = num_layers;
+	return new_domain;
+}
+
 static void free_domain(struct landlock_domain *const domain)
 {
 	might_sleep();
@@ -67,13 +99,13 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 
 /* The returned access has the same lifetime as the domain. */
 const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
+landlock_find_rule(const struct landlock_domain *const domain,
 		   const struct landlock_id id)
 {
 	const struct rb_root *root;
 	const struct rb_node *node;
 
-	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
+	root = landlock_get_rule_root((struct landlock_rules *)&domain->rules,
 				      id.type);
 	if (IS_ERR(root))
 		return NULL;
@@ -155,7 +187,7 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 }
 
 typedef access_mask_t
-get_access_mask_t(const struct landlock_ruleset *const ruleset,
+get_access_mask_t(const struct landlock_domain *const domain,
 		  const u16 layer_level);
 
 /**
@@ -174,7 +206,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
  * any of the active layers in @domain.
  */
 access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+landlock_init_layer_masks(const struct landlock_domain *const domain,
 			  const access_mask_t access_request,
 			  struct layer_masks *const masks,
 			  const enum landlock_key_type key_type)
@@ -222,6 +254,224 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 	return handled_accesses;
 }
 
+static int merge_tree(struct landlock_domain *const dst,
+		      struct landlock_ruleset *const src,
+		      const enum landlock_key_type key_type)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	struct rb_root *src_root;
+	int err = 0;
+
+	might_sleep();
+	lockdep_assert_held(&src->lock);
+
+	src_root = landlock_get_rule_root(&src->rules, key_type);
+	if (IS_ERR(src_root))
+		return PTR_ERR(src_root);
+
+	/* Merges the @src tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
+					     node) {
+		struct landlock_layer layers[] = { {
+			.level = dst->num_layers,
+		} };
+		const struct landlock_id id = {
+			.key = walker_rule->key,
+			.type = key_type,
+		};
+
+		if (WARN_ON_ONCE(walker_rule->num_layers != 1))
+			return -EINVAL;
+
+		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0))
+			return -EINVAL;
+
+		layers[0].access = walker_rule->layers[0].access;
+		layers[0].flags = walker_rule->layers[0].flags;
+
+		err = landlock_store_rule(&dst->rules, id, &layers,
+					  ARRAY_SIZE(layers));
+		if (err)
+			return err;
+	}
+	return err;
+}
+
+static int merge_ruleset(struct landlock_domain *const dst,
+			 struct landlock_ruleset *const src)
+{
+	int err = 0;
+
+	might_sleep();
+	/* Should already be checked by landlock_merge_ruleset() */
+	if (WARN_ON_ONCE(!src))
+		return 0;
+	/* Only merge into a domain. */
+	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
+		return -EINVAL;
+
+	mutex_lock(&src->lock);
+
+	/* Stacks the new layer. */
+	if (WARN_ON_ONCE(dst->num_layers < 1)) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+	dst->handled_masks[dst->num_layers - 1] =
+		landlock_upgrade_handled_access_masks(src->handled_masks);
+
+	/* Merges the @src inode tree. */
+	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
+	if (err)
+		goto out_unlock;
+
+#if IS_ENABLED(CONFIG_INET)
+	/* Merges the @src network port tree. */
+	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
+	if (err)
+		goto out_unlock;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+out_unlock:
+	mutex_unlock(&src->lock);
+	return err;
+}
+
+static int inherit_tree(struct landlock_domain *const parent,
+			struct landlock_domain *const child,
+			const enum landlock_key_type key_type)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	struct rb_root *parent_root;
+	int err = 0;
+
+	might_sleep();
+
+	parent_root = landlock_get_rule_root(&parent->rules, key_type);
+	if (IS_ERR(parent_root))
+		return PTR_ERR(parent_root);
+
+	/* Copies the @parent inode or network tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+					     parent_root, node) {
+		const struct landlock_id id = {
+			.key = walker_rule->key,
+			.type = key_type,
+		};
+
+		err = landlock_store_rule(&child->rules, id,
+					  &walker_rule->layers,
+					  walker_rule->num_layers);
+		if (err)
+			return err;
+	}
+	return err;
+}
+
+static int inherit_ruleset(struct landlock_domain *const parent,
+			   struct landlock_domain *const child)
+{
+	int err = 0;
+
+	might_sleep();
+	if (!parent)
+		return 0;
+
+	/* Copies the @parent inode tree. */
+	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
+	if (err)
+		return err;
+
+#if IS_ENABLED(CONFIG_INET)
+	/* Copies the @parent network port tree. */
+	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
+	if (err)
+		return err;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers))
+		return -EINVAL;
+
+	/*
+	 * Copies the parent layer stack and leaves a space for the new layer.
+	 */
+	memcpy(child->handled_masks, parent->handled_masks,
+	       flex_array_size(parent, handled_masks, parent->num_layers));
+
+	if (WARN_ON_ONCE(!parent->hierarchy))
+		return -EINVAL;
+
+	landlock_get_hierarchy(parent->hierarchy);
+	child->hierarchy->parent = parent->hierarchy;
+
+	return 0;
+}
+
+/**
+ * landlock_merge_ruleset - Merge a ruleset with a domain
+ *
+ * @parent: Parent domain.
+ * @ruleset: New ruleset to be merged.
+ *
+ * The current task is requesting to be restricted.  The subjective credentials
+ * must not be in an overridden state. cf. landlock_init_hierarchy_log().
+ *
+ * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR() on
+ * failure.  If @parent is NULL, the new domain duplicates @ruleset.
+ */
+struct landlock_domain *
+landlock_merge_ruleset(struct landlock_domain *const parent,
+		       struct landlock_ruleset *const ruleset)
+{
+	struct landlock_domain *new_dom __free(landlock_put_domain) = NULL;
+	u32 num_layers;
+	int err;
+
+	might_sleep();
+	if (WARN_ON_ONCE(!ruleset))
+		return ERR_PTR(-EINVAL);
+
+	if (parent) {
+		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
+			return ERR_PTR(-E2BIG);
+		num_layers = parent->num_layers + 1;
+	} else {
+		num_layers = 1;
+	}
+
+	/* Creates a new domain... */
+	new_dom = create_domain(num_layers);
+	if (IS_ERR(new_dom))
+		return new_dom;
+
+	new_dom->hierarchy =
+		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
+	if (!new_dom->hierarchy)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&new_dom->hierarchy->usage, 1);
+
+	/* ...as a child of @parent... */
+	err = inherit_ruleset(parent, new_dom);
+	if (err)
+		return ERR_PTR(err);
+
+	/* ...and including @ruleset. */
+	err = merge_ruleset(new_dom, ruleset);
+	if (err)
+		return ERR_PTR(err);
+
+	err = landlock_init_hierarchy_log(new_dom->hierarchy);
+	if (err)
+		return ERR_PTR(err);
+
+#ifdef CONFIG_AUDIT
+	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+#endif /* CONFIG_AUDIT */
+
+	return no_free_ptr(new_dom);
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 315f72b0b34df..7cd6154dd4e4c 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -203,7 +203,7 @@ struct landlock_domain {
 		 * @work_free: Enables to free a domain within a lockless
 		 * section.  This is only used by landlock_put_domain_deferred()
 		 * when @usage reaches zero.  The fields @usage, @num_layers and
-		 * @access_masks are then unused.
+		 * @handled_masks are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -219,7 +219,7 @@ struct landlock_domain {
 			 */
 			u32 num_layers;
 			/**
-			 * @access_masks: Contains the subset of filesystem and
+			 * @handled_masks: Contains the subset of filesystem and
 			 * network actions that are restricted by a domain.  A
 			 * domain saves all layers of merged rulesets in a stack
 			 * (FAM), starting from the first layer to the last one.
@@ -229,28 +229,51 @@ struct landlock_domain {
 			 * overlapping access rights.  These layers are set once
 			 * and never changed for the lifetime of the domain.
 			 */
-			struct access_masks access_masks[];
+			struct access_masks handled_masks[];
 		};
 	};
 };
 
+static inline access_mask_t
+landlock_get_fs_access_mask(const struct landlock_domain *const domain,
+			    const u16 layer_level)
+{
+	/* Handles all initially denied by default access rights. */
+	return domain->handled_masks[layer_level].fs |
+	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+}
+
+static inline access_mask_t
+landlock_get_net_access_mask(const struct landlock_domain *const domain,
+			     const u16 layer_level)
+{
+	return domain->handled_masks[layer_level].net;
+}
+
+static inline access_mask_t
+landlock_get_scope_mask(const struct landlock_domain *const domain,
+			const u16 layer_level)
+{
+	return domain->handled_masks[layer_level].scope;
+}
+
 /**
  * landlock_union_access_masks - Return all access rights handled in the
  *				 domain
  *
- * @domain: Landlock ruleset (used as a domain)
+ * @domain: Landlock domain
  *
  * Return: An access_masks result of the OR of all the domain's access masks.
  */
 static inline struct access_masks
-landlock_union_access_masks(const struct landlock_ruleset *const domain)
+landlock_union_access_masks(const struct landlock_domain *const domain)
 {
 	union access_masks_all matches = {};
 	size_t layer_level;
 
 	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->handled_masks[layer_level],
 		};
 
 		matches.all |= layer.all;
@@ -265,15 +288,19 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain);
 DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))
 
+struct landlock_domain *
+landlock_merge_ruleset(struct landlock_domain *const parent,
+		       struct landlock_ruleset *const ruleset);
+
 const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
+landlock_find_rule(const struct landlock_domain *const domain,
 		   const struct landlock_id id);
 
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    struct layer_masks *masks);
 
 access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+landlock_init_layer_masks(const struct landlock_domain *const domain,
 			  const access_mask_t access_request,
 			  struct layer_masks *masks,
 			  const enum landlock_key_type key_type);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f1c9effc93fe4..0c98862ced424 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -337,12 +337,11 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (!d_is_dir(path->dentry) &&
 	    !access_mask_subset(access_rights, ACCESS_FILE))
 		return -EINVAL;
-	if (WARN_ON_ONCE(ruleset->num_layers != 1))
-		return -EINVAL;
 
 	/* Transforms relative access rights to absolute ones. */
 	access_rights |= LANDLOCK_MASK_ACCESS_FS &
-			 ~landlock_get_fs_access_mask(ruleset, 0);
+			 ~(ruleset->handled_masks.fs |
+			   _LANDLOCK_ACCESS_FS_INITIALLY_DENIED);
 	id.key.object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
@@ -365,7 +364,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
  * Returns NULL if no rule is found or if @dentry is negative.
  */
 static const struct landlock_rule *
-find_rule(const struct landlock_ruleset *const domain,
+find_rule(const struct landlock_domain *const domain,
 	  const struct dentry *const dentry)
 {
 	const struct landlock_rule *rule;
@@ -750,7 +749,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
  * Return: True if the access request is granted, false otherwise.
  */
 static bool
-is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
+is_access_to_paths_allowed(const struct landlock_domain *const domain,
 			   const struct path *const path,
 			   const access_mask_t access_request_parent1,
 			   struct layer_masks *layer_masks_parent1,
@@ -1051,7 +1050,7 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * Return: True if all the domain access rights are allowed for @dir, false if
  * the walk reached @mnt_root.
  */
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
+static bool collect_domain_accesses(const struct landlock_domain *const domain,
 				    const struct dentry *const mnt_root,
 				    struct dentry *dir,
 				    struct layer_masks *layer_masks_dom)
@@ -1618,8 +1617,8 @@ static int hook_path_truncate(const struct path *const path)
  * @masks: Layer access masks to unmask
  * @access: Access bits that control scoping
  */
-static void unmask_scoped_access(const struct landlock_ruleset *const client,
-				 const struct landlock_ruleset *const server,
+static void unmask_scoped_access(const struct landlock_domain *const client,
+				 const struct landlock_domain *const server,
 				 struct layer_masks *const masks,
 				 const access_mask_t access)
 {
@@ -1673,7 +1672,7 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
 static int hook_unix_find(const struct path *const path, struct sock *other,
 			  int flags)
 {
-	const struct landlock_ruleset *dom_other;
+	const struct landlock_domain *dom_other;
 	const struct landlock_cred_security *subject;
 	struct layer_masks layer_masks;
 	struct landlock_request request = {};
@@ -1968,7 +1967,7 @@ static bool control_current_fowner(struct fown_struct *const fown)
 
 static void hook_file_set_fowner(struct file *file)
 {
-	struct landlock_ruleset *prev_dom;
+	struct landlock_domain *prev_dom;
 	struct landlock_cred_security fown_subject = {};
 	struct pid *prev_tg, *fown_tg = NULL;
 	size_t fown_layer = 0;
@@ -1981,7 +1980,7 @@ static void hook_file_set_fowner(struct file *file)
 			landlock_get_applicable_subject(
 				current_cred(), signal_scope, &fown_layer);
 		if (new_subject) {
-			landlock_get_ruleset(new_subject->domain);
+			landlock_get_domain(new_subject->domain);
 			fown_subject = *new_subject;
 			fown_tg = get_pid(task_tgid(current));
 		}
@@ -1996,14 +1995,14 @@ static void hook_file_set_fowner(struct file *file)
 #endif /* CONFIG_AUDIT*/
 
 	/* May be called in an RCU read-side critical section. */
-	landlock_put_ruleset_deferred(prev_dom);
+	landlock_put_domain_deferred(prev_dom);
 	put_pid(prev_tg);
 }
 
 static void hook_file_free_security(struct file *file)
 {
 	put_pid(landlock_file(file)->fown_tg);
-	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
+	landlock_put_domain_deferred(landlock_file(file)->fown_subject.domain);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/net.c b/security/landlock/net.c
index feecc8c77ab4f..7447738ca2e6e 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -33,8 +33,7 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
 	/* Transforms relative access rights to absolute ones. */
-	access_rights |= LANDLOCK_MASK_ACCESS_NET &
-			 ~landlock_get_net_access_mask(ruleset, 0);
+	access_rights |= LANDLOCK_MASK_ACCESS_NET & ~ruleset->handled_masks.net;
 
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 96e65804d2ff4..2b74542ac3d17 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -20,23 +20,28 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
-#include "domain.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
 
-static struct landlock_ruleset *create_ruleset(const u32 num_layers)
+struct landlock_ruleset *
+landlock_create_ruleset(const access_mask_t fs_access_mask,
+			const access_mask_t net_access_mask,
+			const access_mask_t scope_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
-				   GFP_KERNEL_ACCOUNT);
+	/* Informs about useless ruleset. */
+	if (!fs_access_mask && !net_access_mask && !scope_mask)
+		return ERR_PTR(-ENOMSG);
+
+	new_ruleset = kzalloc_obj(*new_ruleset, GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
+
 	refcount_set(&new_ruleset->usage, 1);
 	mutex_init(&new_ruleset->lock);
 	new_ruleset->rules.root_inode = RB_ROOT;
@@ -45,34 +50,27 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 	new_ruleset->rules.root_net_port = RB_ROOT;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-	new_ruleset->num_layers = num_layers;
-	/*
-	 * hierarchy = NULL
-	 * rules.num_rules = 0
-	 * access_masks[] = 0
-	 */
-	return new_ruleset;
-}
+	/* Should already be checked in landlock_create_ruleset(). */
+	if (fs_access_mask) {
+		const access_mask_t mask = fs_access_mask &
+					   LANDLOCK_MASK_ACCESS_FS;
 
-struct landlock_ruleset *
-landlock_create_ruleset(const access_mask_t fs_access_mask,
-			const access_mask_t net_access_mask,
-			const access_mask_t scope_mask)
-{
-	struct landlock_ruleset *new_ruleset;
+		WARN_ON_ONCE(fs_access_mask != mask);
+		new_ruleset->handled_masks.fs |= mask;
+	}
+	if (net_access_mask) {
+		const access_mask_t mask = net_access_mask &
+					   LANDLOCK_MASK_ACCESS_NET;
 
-	/* Informs about useless ruleset. */
-	if (!fs_access_mask && !net_access_mask && !scope_mask)
-		return ERR_PTR(-ENOMSG);
-	new_ruleset = create_ruleset(1);
-	if (IS_ERR(new_ruleset))
-		return new_ruleset;
-	if (fs_access_mask)
-		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
-	if (net_access_mask)
-		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
-	if (scope_mask)
-		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
+		WARN_ON_ONCE(net_access_mask != mask);
+		new_ruleset->handled_masks.net |= mask;
+	}
+	if (scope_mask) {
+		const access_mask_t mask = scope_mask & LANDLOCK_MASK_SCOPE;
+
+		WARN_ON_ONCE(scope_mask != mask);
+		new_ruleset->handled_masks.scope |= mask;
+	}
 	return new_ruleset;
 }
 
@@ -129,7 +127,7 @@ create_rule(const struct landlock_id id,
 		return ERR_PTR(-ENOMEM);
 	RB_CLEAR_NODE(&new_rule->node);
 	if (is_object_pointer(id.type)) {
-		/* This should have been caught by insert_rule(). */
+		/* This should have been caught by landlock_store_rule(). */
 		WARN_ON_ONCE(!id.key.object);
 		landlock_get_object(id.key.object);
 	}
@@ -145,12 +143,6 @@ create_rule(const struct landlock_id id,
 	return new_rule;
 }
 
-static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
-				const enum landlock_key_type key_type)
-{
-	return landlock_get_rule_root(&ruleset->rules, key_type);
-}
-
 static void free_rule(struct landlock_rule *const rule,
 		      const enum landlock_key_type key_type)
 {
@@ -167,16 +159,12 @@ static void build_check_ruleset(void)
 	const struct landlock_rules rules = {
 		.num_rules = ~0,
 	};
-	const struct landlock_ruleset ruleset = {
-		.num_layers = ~0,
-	};
 
 	BUILD_BUG_ON(rules.num_rules < LANDLOCK_MAX_NUM_RULES);
-	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
 }
 
 /**
- * insert_rule - Create and insert a rule into the rule storage
+ * landlock_store_rule - Create and insert a rule into the rule storage
  *
  * @rules: The rule storage to be updated.  The caller is responsible for
  *         any required locking.  For rulesets, this means holding
@@ -198,10 +186,10 @@ static void build_check_ruleset(void)
  *
  * Return: 0 on success, -errno on failure.
  */
-static int insert_rule(struct landlock_rules *const rules,
-		       const struct landlock_id id,
-		       const struct landlock_layer (*layers)[],
-		       const size_t num_layers)
+int landlock_store_rule(struct landlock_rules *const rules,
+			const struct landlock_id id,
+			const struct landlock_layer (*layers)[],
+			const size_t num_layers)
 {
 	struct rb_node **walker_node;
 	struct rb_node *parent_node = NULL;
@@ -241,7 +229,7 @@ static int insert_rule(struct landlock_rules *const rules,
 		if ((*layers)[0].level == 0) {
 			/*
 			 * Extends access rights when the request comes from
-			 * landlock_add_rule(2), i.e. contained by a ruleset.
+			 * landlock_add_rule(2), i.e. @rules is not a domain.
 			 */
 			if (WARN_ON_ONCE(this->num_layers != 1))
 				return -EINVAL;
@@ -303,7 +291,9 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 {
 	struct landlock_layer layers[] = { {
 		.access = access,
-		/* When @level is zero, insert_rule() extends @ruleset. */
+		/*
+		 * When @level is zero, landlock_store_rule() extends @ruleset.
+		 */
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
@@ -312,171 +302,8 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 
 	build_check_layer();
 	lockdep_assert_held(&ruleset->lock);
-	return insert_rule(&ruleset->rules, id, &layers, ARRAY_SIZE(layers));
-}
-
-static int merge_tree(struct landlock_ruleset *const dst,
-		      struct landlock_ruleset *const src,
-		      const enum landlock_key_type key_type)
-{
-	struct landlock_rule *walker_rule, *next_rule;
-	struct rb_root *src_root;
-	int err = 0;
-
-	might_sleep();
-	lockdep_assert_held(&dst->lock);
-	lockdep_assert_held(&src->lock);
-
-	src_root = get_root(src, key_type);
-	if (IS_ERR(src_root))
-		return PTR_ERR(src_root);
-
-	/* Merges the @src tree. */
-	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
-					     node) {
-		struct landlock_layer layers[] = { {
-			.level = dst->num_layers,
-		} };
-		const struct landlock_id id = {
-			.key = walker_rule->key,
-			.type = key_type,
-		};
-
-		if (WARN_ON_ONCE(walker_rule->num_layers != 1))
-			return -EINVAL;
-
-		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0))
-			return -EINVAL;
-
-		layers[0].access = walker_rule->layers[0].access;
-		layers[0].flags = walker_rule->layers[0].flags;
-
-		err = insert_rule(&dst->rules, id, &layers, ARRAY_SIZE(layers));
-		if (err)
-			return err;
-	}
-	return err;
-}
-
-static int merge_ruleset(struct landlock_ruleset *const dst,
-			 struct landlock_ruleset *const src)
-{
-	int err = 0;
-
-	might_sleep();
-	/* Should already be checked by landlock_merge_ruleset() */
-	if (WARN_ON_ONCE(!src))
-		return 0;
-	/* Only merge into a domain. */
-	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
-		return -EINVAL;
-
-	/* Locks @dst first because we are its only owner. */
-	mutex_lock(&dst->lock);
-	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
-
-	/* Stacks the new layer. */
-	if (WARN_ON_ONCE(src->num_layers != 1 || dst->num_layers < 1)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	dst->access_masks[dst->num_layers - 1] =
-		landlock_upgrade_handled_access_masks(src->access_masks[0]);
-
-	/* Merges the @src inode tree. */
-	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
-	if (err)
-		goto out_unlock;
-
-#if IS_ENABLED(CONFIG_INET)
-	/* Merges the @src network port tree. */
-	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
-	if (err)
-		goto out_unlock;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-out_unlock:
-	mutex_unlock(&src->lock);
-	mutex_unlock(&dst->lock);
-	return err;
-}
-
-static int inherit_tree(struct landlock_ruleset *const parent,
-			struct landlock_ruleset *const child,
-			const enum landlock_key_type key_type)
-{
-	struct landlock_rule *walker_rule, *next_rule;
-	struct rb_root *parent_root;
-	int err = 0;
-
-	might_sleep();
-	lockdep_assert_held(&parent->lock);
-	lockdep_assert_held(&child->lock);
-
-	parent_root = get_root(parent, key_type);
-	if (IS_ERR(parent_root))
-		return PTR_ERR(parent_root);
-
-	/* Copies the @parent inode or network tree. */
-	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
-					     parent_root, node) {
-		const struct landlock_id id = {
-			.key = walker_rule->key,
-			.type = key_type,
-		};
-
-		err = insert_rule(&child->rules, id, &walker_rule->layers,
-				  walker_rule->num_layers);
-		if (err)
-			return err;
-	}
-	return err;
-}
-
-static int inherit_ruleset(struct landlock_ruleset *const parent,
-			   struct landlock_ruleset *const child)
-{
-	int err = 0;
-
-	might_sleep();
-	if (!parent)
-		return 0;
-
-	/* Locks @child first because we are its only owner. */
-	mutex_lock(&child->lock);
-	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
-	/* Copies the @parent inode tree. */
-	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
-	if (err)
-		goto out_unlock;
-
-#if IS_ENABLED(CONFIG_INET)
-	/* Copies the @parent network port tree. */
-	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
-	if (err)
-		goto out_unlock;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	/* Copies the parent layer stack and leaves a space for the new layer. */
-	memcpy(child->access_masks, parent->access_masks,
-	       flex_array_size(parent, access_masks, parent->num_layers));
-
-	if (WARN_ON_ONCE(!parent->hierarchy)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	landlock_get_hierarchy(parent->hierarchy);
-	child->hierarchy->parent = parent->hierarchy;
-
-out_unlock:
-	mutex_unlock(&parent->lock);
-	mutex_unlock(&child->lock);
-	return err;
+	return landlock_store_rule(&ruleset->rules, id, &layers,
+				   ARRAY_SIZE(layers));
 }
 
 void landlock_free_rules(struct landlock_rules *const rules)
@@ -499,7 +326,6 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 {
 	might_sleep();
 	landlock_free_rules(&ruleset->rules);
-	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
 
@@ -509,85 +335,3 @@ void landlock_put_ruleset(struct landlock_ruleset *const ruleset)
 	if (ruleset && refcount_dec_and_test(&ruleset->usage))
 		free_ruleset(ruleset);
 }
-
-static void free_ruleset_work(struct work_struct *const work)
-{
-	struct landlock_ruleset *ruleset;
-
-	ruleset = container_of(work, struct landlock_ruleset, work_free);
-	free_ruleset(ruleset);
-}
-
-/* Only called by hook_cred_free(). */
-void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
-{
-	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
-		INIT_WORK(&ruleset->work_free, free_ruleset_work);
-		schedule_work(&ruleset->work_free);
-	}
-}
-
-/**
- * landlock_merge_ruleset - Merge a ruleset with a domain
- *
- * @parent: Parent domain.
- * @ruleset: New ruleset to be merged.
- *
- * The current task is requesting to be restricted.  The subjective credentials
- * must not be in an overridden state. cf. landlock_init_hierarchy_log().
- *
- * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR()
- * on failure.  If @parent is NULL, the new domain duplicates @ruleset.
- */
-struct landlock_ruleset *
-landlock_merge_ruleset(struct landlock_ruleset *const parent,
-		       struct landlock_ruleset *const ruleset)
-{
-	struct landlock_ruleset *new_dom __free(landlock_put_ruleset) = NULL;
-	u32 num_layers;
-	int err;
-
-	might_sleep();
-	if (WARN_ON_ONCE(!ruleset || parent == ruleset))
-		return ERR_PTR(-EINVAL);
-
-	if (parent) {
-		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
-			return ERR_PTR(-E2BIG);
-		num_layers = parent->num_layers + 1;
-	} else {
-		num_layers = 1;
-	}
-
-	/* Creates a new domain... */
-	new_dom = create_ruleset(num_layers);
-	if (IS_ERR(new_dom))
-		return new_dom;
-
-	new_dom->hierarchy =
-		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
-	if (!new_dom->hierarchy)
-		return ERR_PTR(-ENOMEM);
-
-	refcount_set(&new_dom->hierarchy->usage, 1);
-
-	/* ...as a child of @parent... */
-	err = inherit_ruleset(parent, new_dom);
-	if (err)
-		return ERR_PTR(err);
-
-	/* ...and including @ruleset. */
-	err = merge_ruleset(new_dom, ruleset);
-	if (err)
-		return ERR_PTR(err);
-
-	err = landlock_init_hierarchy_log(new_dom->hierarchy);
-	if (err)
-		return ERR_PTR(err);
-
-#ifdef CONFIG_AUDIT
-	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
-#endif /* CONFIG_AUDIT */
-
-	return no_free_ptr(new_dom);
-}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index f9486c06b7ec3..3a9fc39e947c3 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -14,14 +14,11 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
-#include <linux/workqueue.h>
 
 #include "access.h"
 #include "limits.h"
 #include "object.h"
 
-struct landlock_hierarchy;
-
 /**
  * struct landlock_layer - Access rights for a given layer
  */
@@ -158,60 +155,26 @@ struct landlock_ruleset {
 	 * @rules: Red-black tree storage for rules.
 	 */
 	struct landlock_rules rules;
-
 	/**
-	 * @hierarchy: Enables hierarchy identification even when a parent
-	 * domain vanishes.  This is needed for the ptrace protection.
+	 * @lock: Protects against concurrent modifications of @rules, if @usage
+	 * is greater than zero.
 	 */
-	struct landlock_hierarchy *hierarchy;
-	union {
-		/**
-		 * @work_free: Enables to free a ruleset within a lockless
-		 * section.  This is only used by
-		 * landlock_put_ruleset_deferred() when @usage reaches zero.
-		 * The fields @lock, @usage, @num_layers, @quiet_masks and
-		 * @access_masks are then unused.
-		 */
-		struct work_struct work_free;
-		struct {
-			/**
-			 * @lock: Protects against concurrent modifications of
-			 * @root, if @usage is greater than zero.
-			 */
-			struct mutex lock;
-			/**
-			 * @usage: Number of processes (i.e. domains) or file
-			 * descriptors referencing this ruleset.
-			 */
-			refcount_t usage;
-			/**
-			 * @num_layers: Number of layers that are used in this
-			 * ruleset.  This enables to check that all the layers
-			 * allow an access request.  A value of 0 identifies a
-			 * non-merged ruleset (i.e. not a domain).
-			 */
-			u32 num_layers;
-			/**
-			 * @quiet_masks: Stores the quiet flags for an unmerged
-			 * ruleset.  For a merged domain, this is stored in each
-			 * layer's struct landlock_hierarchy instead.
-			 */
-			struct access_masks quiet_masks;
-			/**
-			 * @access_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a ruleset.
-			 * A domain saves all layers of merged rulesets in a
-			 * stack (FAM), starting from the first layer to the
-			 * last one.  These layers are used when merging
-			 * rulesets, for user space backward compatibility
-			 * (i.e. future-proof), and to properly handle merged
-			 * rulesets without overlapping access rights.  These
-			 * layers are set once and never changed for the
-			 * lifetime of the ruleset.
-			 */
-			struct access_masks access_masks[];
-		};
-	};
+	struct mutex lock;
+	/**
+	 * @usage: Number of file descriptors referencing this ruleset.
+	 */
+	refcount_t usage;
+	/**
+	 * @quiet_masks: Stores the quiet flags for an unmerged ruleset.  For a
+	 * merged domain, this is stored in each layer's struct
+	 * landlock_hierarchy instead.
+	 */
+	struct access_masks quiet_masks;
+	/**
+	 * @handled_masks: Contains the subset of filesystem and network actions
+	 * that are handled by this ruleset.
+	 */
+	struct access_masks handled_masks;
 };
 
 struct landlock_ruleset *
@@ -220,7 +183,6 @@ landlock_create_ruleset(const access_mask_t access_mask_fs,
 			const access_mask_t scope_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
-void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 
 DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
@@ -229,11 +191,12 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access, const u32 flags);
 
-void landlock_free_rules(struct landlock_rules *const rules);
+int landlock_store_rule(struct landlock_rules *const rules,
+			const struct landlock_id id,
+			const struct landlock_layer (*layers)[],
+			const size_t num_layers);
 
-struct landlock_ruleset *
-landlock_merge_ruleset(struct landlock_ruleset *const parent,
-		       struct landlock_ruleset *const ruleset);
+void landlock_free_rules(struct landlock_rules *const rules);
 
 /**
  * landlock_get_rule_root - Get the root of a rule tree by key type
@@ -268,62 +231,4 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
-static inline void
-landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
-			    const access_mask_t fs_access_mask,
-			    const u16 layer_level)
-{
-	access_mask_t fs_mask = fs_access_mask & LANDLOCK_MASK_ACCESS_FS;
-
-	/* Should already be checked in sys_landlock_create_ruleset(). */
-	WARN_ON_ONCE(fs_access_mask != fs_mask);
-	ruleset->access_masks[layer_level].fs |= fs_mask;
-}
-
-static inline void
-landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
-			     const access_mask_t net_access_mask,
-			     const u16 layer_level)
-{
-	access_mask_t net_mask = net_access_mask & LANDLOCK_MASK_ACCESS_NET;
-
-	/* Should already be checked in sys_landlock_create_ruleset(). */
-	WARN_ON_ONCE(net_access_mask != net_mask);
-	ruleset->access_masks[layer_level].net |= net_mask;
-}
-
-static inline void
-landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
-			const access_mask_t scope_mask, const u16 layer_level)
-{
-	access_mask_t mask = scope_mask & LANDLOCK_MASK_SCOPE;
-
-	/* Should already be checked in sys_landlock_create_ruleset(). */
-	WARN_ON_ONCE(scope_mask != mask);
-	ruleset->access_masks[layer_level].scope |= mask;
-}
-
-static inline access_mask_t
-landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
-			    const u16 layer_level)
-{
-	/* Handles all initially denied by default access rights. */
-	return ruleset->access_masks[layer_level].fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
-}
-
-static inline access_mask_t
-landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
-			     const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].net;
-}
-
-static inline access_mask_t
-landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
-			const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].scope;
-}
-
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f5..fe8505dc0ba52 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -308,8 +308,6 @@ static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
 	if (!(fd_file(ruleset_f)->f_mode & mode))
 		return ERR_PTR(-EPERM);
 	ruleset = fd_file(ruleset_f)->private_data;
-	if (WARN_ON_ONCE(ruleset->num_layers != 1))
-		return ERR_PTR(-EINVAL);
 	landlock_get_ruleset(ruleset);
 	return ruleset;
 }
@@ -367,7 +365,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->access_masks[0].fs;
+	mask = ruleset->handled_masks.fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
@@ -408,7 +406,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = landlock_get_net_access_mask(ruleset, 0);
+	mask = ruleset->handled_masks.net;
 	if ((net_port_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
@@ -595,7 +593,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		 * manipulating the current credentials because they are
 		 * dedicated per thread.
 		 */
-		struct landlock_ruleset *const new_dom =
+		struct landlock_domain *const new_dom =
 			landlock_merge_ruleset(new_llcred->domain, ruleset);
 		if (IS_ERR(new_dom)) {
 			abort_creds(new_cred);
@@ -610,7 +608,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 #endif /* CONFIG_AUDIT */
 
 		/* Replaces the old (prepared) domain. */
-		landlock_put_ruleset(new_llcred->domain);
+		landlock_put_domain(new_llcred->domain);
 		new_llcred->domain = new_dom;
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 360d226d0f51d..40e6bfa4bc759 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -41,8 +41,8 @@
  * Return: True if @parent is an ancestor of or equal to @child, false
  * otherwise.
  */
-static bool domain_scope_le(const struct landlock_ruleset *const parent,
-			    const struct landlock_ruleset *const child)
+static bool domain_scope_le(const struct landlock_domain *const parent,
+			    const struct landlock_domain *const child)
 {
 	const struct landlock_hierarchy *walker;
 
@@ -63,8 +63,8 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
 	return false;
 }
 
-static int domain_ptrace(const struct landlock_ruleset *const parent,
-			 const struct landlock_ruleset *const child)
+static int domain_ptrace(const struct landlock_domain *const parent,
+			 const struct landlock_domain *const child)
 {
 	if (domain_scope_le(parent, child))
 		return 0;
@@ -96,7 +96,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 		return 0;
 
 	scoped_guard(rcu) {
-		const struct landlock_ruleset *const child_dom =
+		const struct landlock_domain *const child_dom =
 			landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
 	}
@@ -135,7 +135,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
 	const struct landlock_cred_security *parent_subject;
-	const struct landlock_ruleset *child_dom;
+	const struct landlock_domain *child_dom;
 	int err;
 
 	child_dom = landlock_get_current_domain();
@@ -176,8 +176,8 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
  * Return: True if @server is in a different domain from @client and @client
  * is scoped to access @server (i.e. access should be denied), false otherwise.
  */
-static bool domain_is_scoped(const struct landlock_ruleset *const client,
-			     const struct landlock_ruleset *const server,
+static bool domain_is_scoped(const struct landlock_domain *const client,
+			     const struct landlock_domain *const server,
 			     access_mask_t scope)
 {
 	int client_layer, server_layer;
@@ -236,9 +236,9 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 }
 
 static bool sock_is_scoped(struct sock *const other,
-			   const struct landlock_ruleset *const domain)
+			   const struct landlock_domain *const domain)
 {
-	const struct landlock_ruleset *dom_other;
+	const struct landlock_domain *dom_other;
 
 	/* The credentials will not change. */
 	lockdep_assert_held(&unix_sk(other)->lock);
-- 
2.53.0

