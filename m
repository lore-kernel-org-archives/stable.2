Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AF52CCFA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689570; cv=none; b=ACNkVP2l0kPes3Jl/3QL6PYjnYIwihfy8csA3kJSM0S4MXpXX+7fR1PUJd3J+3a3DYu43W337E2fJZ9neT3Sd9P41LhvaHaAl/XaIDtIy2OlWFgNUPk74+uBxHi6D/UcMBCtLOj0PAOqVVzdA36T4Gf2qrE3BcT4sGG4/Plnuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689570; c=relaxed/simple;
	bh=QcUDlziI5Y4nSk5rycGYNANAvrrpLI/YNLGY9sMNINY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9TuklE3WshVG2/k6ZrwVM7/SfNO3BiX4/AV9HRrkDCBw5aB/aJd0avuWDu6l7jnmQUpOtjNWe2aBxdPJASBIgQFc96ECzJgdZsCP/DfdKzY0wZ/1mtVv6cu2igboMNj7LJKrDu9lPE3SCqPhUnoBS52JGIsTQooxAMt5zyTY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHmLweQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHmLweQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085D01F000FF;
	Tue, 29 Sep 2026 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689568;
	bh=kgInl4SIcyypdx11OFeDrE7GTfAz9Ysu52t8IXGuXDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHmLweQQtjVJYZ2oQDLJPtWFtOvta2M6sTexGjcNGKJkAWMZQ5hrBLDjEb07G9JHx
	 ZvnLCiNJ0pJUOz83na58QJ06wgc/q5xfoIXGU0B9OGcj6kHNaUj7wGzZhglkMXCAId
	 9+nLvPR7vq6Y3rfHN1TR+jpRVXGSWMY1dU2WkP2ThuSM9deZqHh8jdJ+Sm9mcF01rY
	 IM7yHECMGgW76ZDzKLBGDSosmvzIrtl7zQVIqPkxp4ay4bh7370nZCcp06zL6glP4p
	 dxhlLoHJVq16zl8KfKViEYJrhHmCz71MA0G3B7HxV5rtgzDuJ/NoBpNTYHr8CD0vGg
	 0i+dW63vJkeKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/5] landlock: Move domain query functions to domain.c
Date: Tue, 29 Sep 2026 09:46:02 -0400
Message-ID: <20260929134605.3516662-2-sashal@kernel.org>
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

[ Upstream commit 2bbba0905a795b46c20159cecf44033c96b87d22 ]

Grouping domain-specific code in one compilation unit reduces coupling
between domain and ruleset implementations.

Move the access-check functions that only operate on a domain (rule
lookup, layer unmasking, layer-mask init, access-mask union) from
ruleset.[ch] to domain.[ch].  They evaluate whether a domain grants a
requested access during the pathwalk and network checks and do not
modify the domain.

The merge and inherit chain stays in ruleset.c for now because it calls
the static create_ruleset() allocator; a following commit moves it once
the domain type switch eliminates that dependency.

No behavioral change.  The functions move with unchanged signatures and
bodies.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Link: https://patch.msgid.link/20260811094338.288094-3-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Stable-dep-of: c4e941bb7654 ("landlock: Work around gcc-16 -Wuninitialized warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/domain.c  | 162 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h  |  38 +++++++++
 security/landlock/net.c     |   1 +
 security/landlock/ruleset.c | 150 ---------------------------------
 security/landlock/ruleset.h |  38 ---------
 5 files changed, 201 insertions(+), 188 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a8680ca2ac368..3068576d14eae 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -11,11 +11,15 @@
 #include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/cred.h>
+#include <linux/err.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/path.h>
 #include <linux/pid.h>
+#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
@@ -27,6 +31,7 @@
 #include "common.h"
 #include "domain.h"
 #include "id.h"
+#include "limits.h"
 #include "ruleset.h"
 
 static void free_domain(struct landlock_domain *const domain)
@@ -60,6 +65,163 @@ void landlock_put_domain_deferred(struct landlock_domain *const domain)
 	}
 }
 
+/* The returned access has the same lifetime as the domain. */
+const struct landlock_rule *
+landlock_find_rule(const struct landlock_ruleset *const ruleset,
+		   const struct landlock_id id)
+{
+	const struct rb_root *root;
+	const struct rb_node *node;
+
+	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
+				      id.type);
+	if (IS_ERR(root))
+		return NULL;
+	node = root->rb_node;
+
+	while (node) {
+		struct landlock_rule *this =
+			rb_entry(node, struct landlock_rule, node);
+
+		if (this->key.data == id.key.data)
+			return this;
+		if (this->key.data < id.key.data)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	return NULL;
+}
+
+/**
+ * landlock_unmask_layers - Remove the access rights in @masks which are
+ *                          granted in @rule
+ *
+ * Updates the set of (per-layer) unfulfilled access rights @masks so that all
+ * the access rights granted in @rule are removed from it (because they are now
+ * fulfilled).
+ *
+ * @rule: A rule that grants a set of access rights for each layer.
+ * @masks: A matrix of unfulfilled access rights for each layer.
+ *
+ * Return: True if the request is allowed (i.e. the access rights granted all
+ * remaining unfulfilled access rights and masks has no leftover set bits).
+ */
+bool landlock_unmask_layers(const struct landlock_rule *const rule,
+			    struct layer_masks *masks)
+{
+	if (!masks)
+		return true;
+	if (!rule)
+		return false;
+
+	/*
+	 * An access is granted if, for each policy layer, at least one rule
+	 * encountered on the pathwalk grants the requested access, regardless
+	 * of its position in the layer stack.  We must then check the remaining
+	 * layers for each inode, from the first added layer to the last one.
+	 * When there are multiple requested accesses, for each policy layer,
+	 * the full set of requested accesses may not be granted by only one
+	 * rule, but by the union (binary OR) of multiple rules.  For example,
+	 * /a/b <execute> + /a <read> grants /a/b <execute + read>.
+	 *
+	 * This function is called once per matching rule during the pathwalk,
+	 * progressively clearing bits in @masks.  The overall access decision
+	 * is per-layer: access is granted iff masks->layers[l].access == 0 for
+	 * all layers l.  When two independent mechanisms can each grant access
+	 * within a layer (e.g. a path rule OR a scope exception), the
+	 * composition must evaluate per-layer: FOR-ALL l (A(l) OR B(l)), not
+	 * (FOR-ALL l A(l)) OR (FOR-ALL l B(l)), to prevent bypass when
+	 * different layers grant via different mechanisms.
+	 */
+	for (size_t i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+
+		/* Clear the bits where the layer in the rule grants access. */
+		masks->layers[layer->level - 1].access &= ~layer->access;
+
+#ifdef CONFIG_AUDIT
+		/* Collect rule flags for each layer. */
+		if (layer->flags.quiet)
+			masks->layers[layer->level - 1].quiet = true;
+#endif /* CONFIG_AUDIT */
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
+		if (masks->layers[i].access)
+			return false;
+	}
+	return true;
+}
+
+typedef access_mask_t
+get_access_mask_t(const struct landlock_ruleset *const ruleset,
+		  const u16 layer_level);
+
+/**
+ * landlock_init_layer_masks - Initialize layer masks from an access request
+ *
+ * Populates @masks such that for each access right in @access_request, the bits
+ * for all the layers are set where this access right is handled.  Rule flags
+ * are also zeroed.
+ *
+ * @domain: The domain that defines the current restrictions.
+ * @access_request: The requested access rights to check.
+ * @masks: Layer access masks to populate.
+ * @key_type: The key type to switch between access masks of different types.
+ *
+ * Return: An access mask where each access right bit is set which is handled in
+ * any of the active layers in @domain.
+ */
+access_mask_t
+landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+			  const access_mask_t access_request,
+			  struct layer_masks *const masks,
+			  const enum landlock_key_type key_type)
+{
+	access_mask_t handled_accesses = 0;
+	get_access_mask_t *get_access_mask;
+
+	switch (key_type) {
+	case LANDLOCK_KEY_INODE:
+		get_access_mask = landlock_get_fs_access_mask;
+		break;
+
+#if IS_ENABLED(CONFIG_INET)
+	case LANDLOCK_KEY_NET_PORT:
+		get_access_mask = landlock_get_net_access_mask;
+		break;
+#endif /* IS_ENABLED(CONFIG_INET) */
+
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	/* An empty access request can happen because of O_WRONLY | O_RDWR. */
+	if (!access_request)
+		return 0;
+
+	for (size_t i = 0; i < domain->num_layers; i++) {
+		const access_mask_t handled = get_access_mask(domain, i);
+
+		masks->layers[i].access = access_request & handled;
+		handled_accesses |= masks->layers[i].access;
+#ifdef CONFIG_AUDIT
+		masks->layers[i].quiet = false;
+#endif /* CONFIG_AUDIT */
+	}
+	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
+	     i++) {
+		masks->layers[i].access = 0;
+#ifdef CONFIG_AUDIT
+		masks->layers[i].quiet = false;
+#endif /* CONFIG_AUDIT */
+	}
+
+	return handled_accesses;
+}
+
 #ifdef CONFIG_AUDIT
 
 /**
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 8d6de80a4b294..315f72b0b34df 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -234,12 +234,50 @@ struct landlock_domain {
 	};
 };
 
+/**
+ * landlock_union_access_masks - Return all access rights handled in the
+ *				 domain
+ *
+ * @domain: Landlock ruleset (used as a domain)
+ *
+ * Return: An access_masks result of the OR of all the domain's access masks.
+ */
+static inline struct access_masks
+landlock_union_access_masks(const struct landlock_ruleset *const domain)
+{
+	union access_masks_all matches = {};
+	size_t layer_level;
+
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
+		union access_masks_all layer = {
+			.masks = domain->access_masks[layer_level],
+		};
+
+		matches.all |= layer.all;
+	}
+
+	return matches.masks;
+}
+
 void landlock_put_domain(struct landlock_domain *const domain);
 void landlock_put_domain_deferred(struct landlock_domain *const domain);
 
 DEFINE_FREE(landlock_put_domain, struct landlock_domain *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_domain(_T))
 
+const struct landlock_rule *
+landlock_find_rule(const struct landlock_ruleset *const ruleset,
+		   const struct landlock_id id);
+
+bool landlock_unmask_layers(const struct landlock_rule *const rule,
+			    struct layer_masks *masks);
+
+access_mask_t
+landlock_init_layer_masks(const struct landlock_ruleset *const domain,
+			  const access_mask_t access_request,
+			  struct layer_masks *masks,
+			  const enum landlock_key_type key_type);
+
 static inline void landlock_get_domain(struct landlock_domain *const domain)
 {
 	if (domain)
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 46c17116fcf42..feecc8c77ab4f 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -15,6 +15,7 @@
 #include "audit.h"
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "limits.h"
 #include "net.h"
 #include "ruleset.h"
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 9e560aed64b6f..96e65804d2ff4 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -591,153 +591,3 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 
 	return no_free_ptr(new_dom);
 }
-
-/*
- * The returned access has the same lifetime as @ruleset.
- */
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id)
-{
-	const struct rb_root *root;
-	const struct rb_node *node;
-
-	root = landlock_get_rule_root((struct landlock_rules *)&ruleset->rules,
-				      id.type);
-	if (IS_ERR(root))
-		return NULL;
-	node = root->rb_node;
-
-	while (node) {
-		struct landlock_rule *this =
-			rb_entry(node, struct landlock_rule, node);
-
-		if (this->key.data == id.key.data)
-			return this;
-		if (this->key.data < id.key.data)
-			node = node->rb_right;
-		else
-			node = node->rb_left;
-	}
-	return NULL;
-}
-
-/**
- * landlock_unmask_layers - Remove the access rights in @masks
- *                          which are granted in @rule
- *
- * Updates the set of (per-layer) unfulfilled access rights @masks
- * so that all the access rights granted in @rule are removed from it
- * (because they are now fulfilled).
- *
- * @rule: A rule that grants a set of access rights for each layer
- * @masks: A matrix of unfulfilled access rights for each layer
- *
- * Return: True if the request is allowed (i.e. the access rights granted all
- * remaining unfulfilled access rights and masks has no leftover set bits).
- */
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_masks *masks)
-{
-	if (!masks)
-		return true;
-	if (!rule)
-		return false;
-
-	/*
-	 * An access is granted if, for each policy layer, at least one rule
-	 * encountered on the pathwalk grants the requested access,
-	 * regardless of its position in the layer stack.  We must then check
-	 * the remaining layers for each inode, from the first added layer to
-	 * the last one.  When there is multiple requested accesses, for each
-	 * policy layer, the full set of requested accesses may not be granted
-	 * by only one rule, but by the union (binary OR) of multiple rules.
-	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
-	 */
-	for (size_t i = 0; i < rule->num_layers; i++) {
-		const struct landlock_layer *const layer = &rule->layers[i];
-
-		/* Clear the bits where the layer in the rule grants access. */
-		masks->layers[layer->level - 1].access &= ~layer->access;
-
-#ifdef CONFIG_AUDIT
-		/* Collect rule flags for each layer. */
-		if (layer->flags.quiet)
-			masks->layers[layer->level - 1].quiet = true;
-#endif /* CONFIG_AUDIT */
-	}
-
-	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
-		if (masks->layers[i].access)
-			return false;
-	}
-	return true;
-}
-
-typedef access_mask_t
-get_access_mask_t(const struct landlock_ruleset *const ruleset,
-		  const u16 layer_level);
-
-/**
- * landlock_init_layer_masks - Initialize layer masks from an access request
- *
- * Populates @masks such that for each access right in @access_request, the bits
- * for all the layers are set where this access right is handled.  Rule flags
- * are also zeroed.
- *
- * @domain: The domain that defines the current restrictions.
- * @access_request: The requested access rights to check.
- * @masks: Layer access masks to populate.
- * @key_type: The key type to switch between access masks of different types.
- *
- * Return: An access mask where each access right bit is set which is handled
- * in any of the active layers in @domain.
- */
-access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-			  const access_mask_t access_request,
-			  struct layer_masks *const masks,
-			  const enum landlock_key_type key_type)
-{
-	access_mask_t handled_accesses = 0;
-	get_access_mask_t *get_access_mask;
-
-	switch (key_type) {
-	case LANDLOCK_KEY_INODE:
-		get_access_mask = landlock_get_fs_access_mask;
-		break;
-
-#if IS_ENABLED(CONFIG_INET)
-	case LANDLOCK_KEY_NET_PORT:
-		get_access_mask = landlock_get_net_access_mask;
-		break;
-#endif /* IS_ENABLED(CONFIG_INET) */
-
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	/* An empty access request can happen because of O_WRONLY | O_RDWR. */
-	if (!access_request)
-		return 0;
-
-	for (size_t i = 0; i < domain->num_layers; i++) {
-		const access_mask_t handled = get_access_mask(domain, i);
-
-		masks->layers[i].access = access_request & handled;
-		handled_accesses |= masks->layers[i].access;
-#ifdef CONFIG_AUDIT
-		masks->layers[i].quiet = false;
-#endif /* CONFIG_AUDIT */
-	}
-	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
-	     i++) {
-		masks->layers[i].access = 0;
-#ifdef CONFIG_AUDIT
-		masks->layers[i].quiet = false;
-#endif /* CONFIG_AUDIT */
-	}
-
-	return handled_accesses;
-}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c8c83efff4c58..f9486c06b7ec3 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -235,10 +235,6 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
-const struct landlock_rule *
-landlock_find_rule(const struct landlock_ruleset *const ruleset,
-		   const struct landlock_id id);
-
 /**
  * landlock_get_rule_root - Get the root of a rule tree by key type
  *
@@ -272,31 +268,6 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
-/**
- * landlock_union_access_masks - Return all access rights handled in the
- *				 domain
- *
- * @domain: Landlock ruleset (used as a domain)
- *
- * Return: An access_masks result of the OR of all the domain's access masks.
- */
-static inline struct access_masks
-landlock_union_access_masks(const struct landlock_ruleset *const domain)
-{
-	union access_masks_all matches = {};
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
-		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
-		};
-
-		matches.all |= layer.all;
-	}
-
-	return matches.masks;
-}
-
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -355,13 +326,4 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->access_masks[layer_level].scope;
 }
 
-bool landlock_unmask_layers(const struct landlock_rule *const rule,
-			    struct layer_masks *masks);
-
-access_mask_t
-landlock_init_layer_masks(const struct landlock_ruleset *const domain,
-			  const access_mask_t access_request,
-			  struct layer_masks *masks,
-			  const enum landlock_key_type key_type);
-
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.53.0

