Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6043DAAA8
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664469; cv=none; b=bjU45CveXMXm8WEODvL9SKuMmZhF3F2zuFBOtodbKFvgE6heGG7YG2+mdsmImSiw7Jqn6yHm6ZJiDIJtoW2h1Mt23GEe3UKLR0vyGPAtgNwK/Pt3t3C/y/tQ1H4r4upt6yrRSYDgEUe/czTZqsa5E6tkxNtUuR6svVlPJTnvEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664469; c=relaxed/simple;
	bh=nCCXkP2Kinxrw5s+UIaUZqOqSZPrMgeBBBvva+5vvNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Si3m7VwalbYG/7M38FiwWqJCbHaFIVbpfxAChEqN9P3eOkdxfGh5ClKyGbYlTghFdCohbnWUkuVj65U79hfebApeyGfXtGXEeHXaZ2XUu+EGcjw2o6c+Bgkv09FS4EIOjuLcndc6dda1UPgbpiBlVSvXzNTMFQRRJ3FFvXKHS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQmxzYnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQmxzYnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C651F00A3D;
	Tue, 25 Aug 2026 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664465;
	bh=4OuSimcTcQmJWBl4B54IsZrfbRzIhZ6PoV2VICE9V9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQmxzYnkJTcRZBES5FeGQ7MbTwUQcse3tPEGfeU+LkIr4nij8Rl2P3sNV8uDo//4o
	 P3+1CSsFGpUJr7t07J+bZAR2nb+og8kBKwM+S3+6GkxMiJpb3ooxfGlTEcv+sx/IJK
	 axMwVVyD4ixBuZH2Ol1CZ69fC2APET17PdAXwW/brOWI0XlF1dQJsnue0cMENf+mug
	 LOHWfUKaN5f7HmaoZHf+8WbDshypVfPCk5v5iYcA+di1IA/zvDVQcNwk5dJUr4qvkg
	 I0mp8oTNe4lTAoLF+z6irwB8M2xljEeesKse9kM4UdX9he9F/Iv6jsWSxVlesGgyz2
	 GCZ16LQdPxPBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] selinux: avoid implicit conversions in services code
Date: Tue, 25 Aug 2026 09:27:41 -0400
Message-ID: <20260825132742.3865669-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825132742.3865669-1-sashal@kernel.org>
References: <2026082039-waffle-overlabor-d7cc@gregkh>
 <20260825132742.3865669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit c50e125d057152bc68dfd5669b73611343653eb7 ]

Use u32 as the output parameter type in security_get_classes() and
security_get_permissions(), based on the type of the symtab nprim
member.

Declare the read-only class string parameter of
security_get_permissions() const.

Avoid several implicit conversions by using the identical type for the
destination.

Use the type identical to the source for local variables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: cleanup extra whitespace in subject]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: 22b05fec62c0 ("selinux: reject an unclaimed class value in security_get_classes()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/include/security.h |  4 ++--
 security/selinux/selinuxfs.c        |  7 ++++---
 security/selinux/ss/services.c      | 23 ++++++++++++-----------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 393aff41d3ef8..38390e3393745 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -379,9 +379,9 @@ int security_net_peersid_resolve(struct selinux_state *state,
 				 u32 *peer_sid);
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses);
+			 char ***classes, u32 *nclasses);
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms);
+			     const char *class, char ***perms, u32 *nperms);
 int security_get_reject_unknown(struct selinux_state *state);
 int security_get_allow_unknown(struct selinux_state *state);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ab804d4ea9117..f74fdabaa541b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1874,7 +1874,8 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 			char *objclass, int classvalue,
 			struct dentry *dir)
 {
-	int i, rc, nperms;
+	u32 i, nperms;
+	int rc;
 	char **perms;
 
 	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
@@ -1944,8 +1945,8 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
 			    unsigned long *last_class_ino)
 {
-
-	int rc, nclasses, i;
+	u32 i, nclasses;
+	int rc;
 	char **classes;
 
 	rc = security_get_classes(newpolicy, &classes, &nclasses);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 48d67b26110bc..077a7af5794e6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -869,7 +869,7 @@ int security_bounded_transition(struct selinux_state *state,
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
 	struct type_datum *type;
-	int index;
+	u32 index;
 	int rc;
 
 	if (!selinux_initialized(state))
@@ -1537,7 +1537,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		return -ENOMEM;
 
 	if (!selinux_initialized(state)) {
-		int i;
+		u32 i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
 			const char *s = initial_sid_to_string[i];
@@ -2886,7 +2886,6 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	int len;
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -2908,7 +2907,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 		return -ENOENT;
 
 	for (c = genfs->head; c; c = c->next) {
-		len = strlen(c->u.name);
+		size_t len = strlen(c->u.name);
 		if ((!c->v.sclass || sclass == c->v.sclass) &&
 		    (strncmp(c->u.name, path, len) == 0))
 			break;
@@ -3402,7 +3401,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
@@ -3412,7 +3411,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 }
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses)
+			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
 	int rc;
@@ -3428,7 +3427,8 @@ int security_get_classes(struct selinux_policy *policy,
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
 	if (rc) {
-		int i;
+		u32 i;
+
 		for (i = 0; i < *nclasses; i++)
 			kfree((*classes)[i]);
 		kfree(*classes);
@@ -3442,7 +3442,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 {
 	struct perm_datum *datum = d;
 	char *name = k, **perms = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	perms[value] = kstrdup(name, GFP_ATOMIC);
 	if (!perms[value])
@@ -3452,10 +3452,11 @@ static int get_permissions_callback(void *k, void *d, void *args)
 }
 
 int security_get_permissions(struct selinux_policy *policy,
-			     char *class, char ***perms, int *nperms)
+			     const char *class, char ***perms, u32 *nperms)
 {
 	struct policydb *policydb;
-	int rc, i;
+	u32 i;
+	int rc;
 	struct class_datum *match;
 
 	policydb = &policy->policydb;
@@ -3675,7 +3676,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 /* Check to see if the rule contains any selinux fields */
 int selinux_audit_rule_known(struct audit_krule *rule)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
-- 
2.53.0

