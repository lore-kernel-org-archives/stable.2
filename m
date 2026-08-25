Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CE3B3880
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687246; cv=none; b=rNjusqDBXdhgqnN70NhAzNAHznQyvh5hylwic+72bmIfHPLCYx7X247iM+OiICNqRZZjmczsZo0l/dKk7HEBqPVrrcyeKSJMA/LlyVrgOejJyxoJlN/xPRV2NYEZwU3Ku/+i9DDf68xF6ppzDyXjKG/KkroQGR3RnXjBi72Wb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687246; c=relaxed/simple;
	bh=oIliOgPMcH26ekYw933g9x36REg3lfRsmLcGNhIU8oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqEOqKmLujk283gnnsPxC8BD76mqSiBKVyUZT9nbNuOFkeuX2N0TYhatyv24oxCQ+99VsbPqsaO49zTkycmfytnHDjBxNjBY+kC+2wEmUXqYdqV9cN3AUaoS+MEgapElSWtoQMqXjSsIctWSyBBviMggTwFY0xB54Mc0MvGg+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPvJTivk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPvJTivk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB1E1F000E9;
	Tue, 25 Aug 2026 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687245;
	bh=kKC7UKc8BDwgBIQOMTYECt8X1og+lGXV8rOkp8+WAqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPvJTivkEJDr3uEmZOoOfds9BmhZqWNC4/26FeWRKe0jwtIk8pXGiyzc1vhP/J8B1
	 zR+t2MmwMP78UhjHJCQMMPIs/joZnjGSWw7c5DCwNinMnd3dvvmK6uhGpRHws5lKJY
	 h/Q+r8I1LoiYtgVtySsF1au2DuDH+95IdS9DRq8QWOGsxjIU1NEFVrczkf/c2R/jED
	 ZgJgaHkmIG71nVOq8LQZNppLB0UkF86YsNNj40/ScgWiLqSvfNcBMAx4egxCRwKN7P
	 qgRoqMpEavBb8xvyofwSuEGGbltQV3NMbE4RDfGQyC4iXvAFEM5DBzus0l/RUYEY5L
	 N4jcDLXj3NF0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] selinux: avoid implicit conversions in services code
Date: Tue, 25 Aug 2026 15:47:21 -0400
Message-ID: <20260825194722.374513-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082040-litmus-embargo-428a@gregkh>
References: <2026082040-litmus-embargo-428a@gregkh>
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
index c0d966020ebdd..caccd6d80a09f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -375,9 +375,9 @@ int security_net_peersid_resolve(struct selinux_state *state,
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
index 13be7826ae804..eabfd68f87156 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1870,7 +1870,8 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 			char *objclass, int classvalue,
 			struct dentry *dir)
 {
-	int i, rc, nperms;
+	u32 i, nperms;
+	int rc;
 	char **perms;
 
 	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
@@ -1943,8 +1944,8 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
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
index 2b3e0e305ba99..d2c2835e5c8d4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -871,7 +871,7 @@ int security_bounded_transition(struct selinux_state *state,
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
 	struct type_datum *type;
-	int index;
+	u32 index;
 	int rc;
 
 	if (!selinux_initialized(state))
@@ -1539,7 +1539,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		return -ENOMEM;
 
 	if (!selinux_initialized(state)) {
-		int i;
+		u32 i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
 			const char *s = initial_sid_to_string[i];
@@ -2883,7 +2883,6 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	int len;
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -2905,7 +2904,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 		return -ENOENT;
 
 	for (c = genfs->head; c; c = c->next) {
-		len = strlen(c->u.name);
+		size_t len = strlen(c->u.name);
 		if ((!c->v.sclass || sclass == c->v.sclass) &&
 		    (strncmp(c->u.name, path, len) == 0))
 			break;
@@ -3399,7 +3398,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
@@ -3409,7 +3408,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 }
 
 int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, int *nclasses)
+			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
 	int rc;
@@ -3425,7 +3424,8 @@ int security_get_classes(struct selinux_policy *policy,
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
 	if (rc) {
-		int i;
+		u32 i;
+
 		for (i = 0; i < *nclasses; i++)
 			kfree((*classes)[i]);
 		kfree(*classes);
@@ -3439,7 +3439,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 {
 	struct perm_datum *datum = d;
 	char *name = k, **perms = args;
-	int value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	perms[value] = kstrdup(name, GFP_ATOMIC);
 	if (!perms[value])
@@ -3449,10 +3449,11 @@ static int get_permissions_callback(void *k, void *d, void *args)
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
@@ -3672,7 +3673,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 /* Check to see if the rule contains any selinux fields */
 int selinux_audit_rule_known(struct audit_krule *rule)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
-- 
2.53.0

