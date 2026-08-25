Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21053515DA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687288; cv=none; b=kHSPjsP++LcwVJIOjuCFckTkNPULnQZcv/BlGTzdD6pCQZ6Ezua+KIycuUc7wGuNgfCC8tbpxx8wi8oeJHXFKjYLuVgkd1LE8YNOBiYrbX6GO74+hJH3TJMMuoKu6KTVq00noq7i8lQ+ivXz3VtVIOWyRnx3NEz09oKBA1m+TzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687288; c=relaxed/simple;
	bh=oz/Fo2PB7zACysEUIvKC3Ku9Yo2nEwikNCkasvIGiC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G34UALqoCkrOr0UvZVKPVIlK1KA9yv3YCLC1Viq+GIkBGci9usozN8zHNsYCG36ACFwNXaUgzVB+pHW9dZCFU8DlBCb3PnNl1J6aIP2Mnxs35W4oW9eBa9jSaAz1fMM8qUtHUHorNBapmkaln09iN1viK7IAJzeZ+f09R+uUD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN1e6RlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN1e6RlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F11F000E9;
	Tue, 25 Aug 2026 19:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687286;
	bh=CZrAWuuMikVEIAzgUlYX6ciSJkaemQFABBMoqWJBing=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MN1e6RlVlm79MDxOMVvZzyVd13E2o9Mn4HjHe0/Rr8mScZCPmaxxNnkyZ8F93Gqm9
	 bzMeYyecAq6duNziKARaVMVhDh/RnqQp7IVVtYK4OVOEZtn//Rm9O6cqBWjGvpBMkw
	 hFKXNOWAla2sX5eLQyXyitADyQf3zJX9rUja4pg0YvqcohmoC7Lke+tYtp2lQqt/8H
	 ZpyrKXiq1YFuVN2mkFZ+6iXQ7ZYBiA7yWF6omP36pnhYOi6v79yIek6zgTKKqpxq4/
	 5CeQIOdVhX+PbAZDZXrjWhzT1iIghHXX7dv5okB2Eeq4OAKCoWvjLeVyw2hge6OnZ6
	 G/EHYNz7n9PWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] selinux: use known type instead of void pointer
Date: Tue, 25 Aug 2026 15:48:01 -0400
Message-ID: <20260825194804.376152-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082023-agreeing-overbook-66d4@gregkh>
References: <2026082023-agreeing-overbook-66d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit f07586160fd5492f8d48e7667e7a5d8797aa5090 ]

Improve type safety and readability by using the known type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/avtab.c       |  8 +--
 security/selinux/ss/avtab.h       | 10 ++--
 security/selinux/ss/conditional.c | 12 ++--
 security/selinux/ss/conditional.h |  6 +-
 security/selinux/ss/ebitmap.c     |  4 +-
 security/selinux/ss/ebitmap.h     |  5 +-
 security/selinux/ss/policydb.c    | 92 ++++++++++++++++---------------
 security/selinux/ss/policydb.h    | 16 +++---
 8 files changed, 79 insertions(+), 74 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c97695ae508f1..ada24c8c2bf94 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -397,7 +397,7 @@ static uint16_t spec_order[] = {
 	AVTAB_XPERMS_DONTAUDIT
 };
 
-int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
+int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
 		    void *p)
@@ -565,7 +565,7 @@ static int avtab_insertf(struct avtab *a, const struct avtab_key *k,
 	return avtab_insert(a, k, d);
 }
 
-int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
+int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
 {
 	int rc;
 	__le32 buf[1];
@@ -609,7 +609,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 	goto out;
 }
 
-int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
+int avtab_write_item(struct policydb *p, const struct avtab_node *cur, struct policy_file *fp)
 {
 	__le16 buf16[4];
 	__le32 buf32[ARRAY_SIZE(cur->datum.u.xperms->perms.p)];
@@ -644,7 +644,7 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 	return 0;
 }
 
-int avtab_write(struct policydb *p, struct avtab *a, void *fp)
+int avtab_write(struct policydb *p, struct avtab *a, struct policy_file *fp)
 {
 	unsigned int i;
 	int rc = 0;
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d3ebea8d146f2..2d60ef7530f8b 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -95,14 +95,16 @@ void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
 
 struct policydb;
-int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
+struct policy_file;
+int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
 		    int (*insert)(struct avtab *a, const struct avtab_key *k,
 				  const struct avtab_datum *d, void *p),
 		    void *p);
 
-int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
-int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp);
-int avtab_write(struct policydb *p, struct avtab *a, void *fp);
+int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol);
+int avtab_write_item(struct policydb *p, const struct avtab_node *cur,
+		     struct policy_file *fp);
+int avtab_write(struct policydb *p, struct avtab *a, struct policy_file *fp);
 
 struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 					  const struct avtab_key *key,
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index feb206f3acb4a..7e4f1f0b4318a 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -205,7 +205,7 @@ static int bool_isvalid(struct cond_bool_datum *b)
 	return 1;
 }
 
-int cond_read_bool(struct policydb *p, struct symtab *s, void *fp)
+int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
@@ -321,7 +321,7 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 	return 0;
 }
 
-static int cond_read_av_list(struct policydb *p, void *fp,
+static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 			     struct cond_av_list *list,
 			     struct cond_av_list *other)
 {
@@ -373,7 +373,7 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 	return 1;
 }
 
-static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
+static int cond_read_node(struct policydb *p, struct cond_node *node, struct policy_file *fp)
 {
 	__le32 buf[2];
 	u32 i, len;
@@ -413,7 +413,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
 }
 
-int cond_read_list(struct policydb *p, void *fp)
+int cond_read_list(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
 	u32 i, len;
@@ -451,7 +451,7 @@ int cond_write_bool(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct cond_bool_datum *booldatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[3];
 	u32 len;
 	int rc;
@@ -534,7 +534,7 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
 	return 0;
 }
 
-int cond_write_list(struct policydb *p, void *fp)
+int cond_write_list(struct policydb *p, struct policy_file *fp)
 {
 	u32 i;
 	__le32 buf[1];
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index e47ec6ddeaf61..c4c60413127cc 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -69,10 +69,10 @@ int cond_destroy_bool(void *key, void *datum, void *p);
 
 int cond_index_bool(void *key, void *datum, void *datap);
 
-int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
-int cond_read_list(struct policydb *p, void *fp);
+int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp);
+int cond_read_list(struct policydb *p, struct policy_file *fp);
 int cond_write_bool(void *key, void *datum, void *ptr);
-int cond_write_list(struct policydb *p, void *fp);
+int cond_write_list(struct policydb *p, struct policy_file *fp);
 
 void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 		struct av_decision *avd, struct extended_perms *xperms);
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 61fcbb8d0f880..6854aeb48289c 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -362,7 +362,7 @@ void ebitmap_destroy(struct ebitmap *e)
 	return;
 }
 
-int ebitmap_read(struct ebitmap *e, void *fp)
+int ebitmap_read(struct ebitmap *e, struct policy_file *fp)
 {
 	struct ebitmap_node *n = NULL;
 	u32 mapunit, count, startbit, index;
@@ -468,7 +468,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	goto out;
 }
 
-int ebitmap_write(struct ebitmap *e, void *fp)
+int ebitmap_write(struct ebitmap *e, struct policy_file *fp)
 {
 	struct ebitmap_node *n;
 	u32 count;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 9eb2d0af2805e..a721cd29ab118 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -129,8 +129,9 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
 int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
 int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
-int ebitmap_read(struct ebitmap *e, void *fp);
-int ebitmap_write(struct ebitmap *e, void *fp);
+struct policy_file;
+int ebitmap_read(struct ebitmap *e, struct policy_file *fp);
+int ebitmap_write(struct ebitmap *e, struct policy_file *fp);
 u32 ebitmap_hash(const struct ebitmap *e, u32 hash);
 
 #ifdef CONFIG_NETLABEL
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3b87ec820d3c4..fcacc56424697 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -992,7 +992,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
  * Read a MLS range structure from a policydb binary
  * representation file.
  */
-static int mls_read_range_helper(struct mls_range *r, void *fp)
+static int mls_read_range_helper(struct mls_range *r, struct policy_file *fp)
 {
 	__le32 buf[2];
 	u32 items;
@@ -1053,7 +1053,7 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
  */
 static int context_read_and_validate(struct context *c,
 				     struct policydb *p,
-				     void *fp)
+				     struct policy_file *fp)
 {
 	__le32 buf[3];
 	int rc;
@@ -1091,7 +1091,7 @@ static int context_read_and_validate(struct context *c,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -1114,7 +1114,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	return 0;
 }
 
-static int perm_read(struct policydb *p, struct symtab *s, void *fp)
+static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1147,7 +1147,7 @@ static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int common_read(struct policydb *p, struct symtab *s, void *fp)
+static int common_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
@@ -1197,7 +1197,7 @@ static void type_set_init(struct type_set *t)
 	ebitmap_init(&t->negset);
 }
 
-static int type_set_read(struct type_set *t, void *fp)
+static int type_set_read(struct type_set *t, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1218,7 +1218,8 @@ static int type_set_read(struct type_set *t, void *fp)
 
 static int read_cons_helper(struct policydb *p,
 				struct constraint_node **nodep,
-				int ncons, int allowxtarget, void *fp)
+				int ncons, int allowxtarget,
+				struct policy_file *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
@@ -1311,7 +1312,7 @@ static int read_cons_helper(struct policydb *p,
 	return 0;
 }
 
-static int class_read(struct policydb *p, struct symtab *s, void *fp)
+static int class_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
@@ -1418,7 +1419,7 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int role_read(struct policydb *p, struct symtab *s, void *fp)
+static int role_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
@@ -1474,7 +1475,7 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int type_read(struct policydb *p, struct symtab *s, void *fp)
+static int type_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
@@ -1526,7 +1527,7 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
  * Read a MLS level structure from a policydb binary
  * representation file.
  */
-static int mls_read_level(struct mls_level *lp, void *fp)
+static int mls_read_level(struct mls_level *lp, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1548,7 +1549,7 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	return 0;
 }
 
-static int user_read(struct policydb *p, struct symtab *s, void *fp)
+static int user_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
@@ -1598,7 +1599,7 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int sens_read(struct policydb *p, struct symtab *s, void *fp)
+static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct level_datum *levdatum;
@@ -1639,7 +1640,7 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int cat_read(struct policydb *p, struct symtab *s, void *fp)
+static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct cat_datum *catdatum;
@@ -1672,7 +1673,8 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) =
+static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s,
+			       struct policy_file *fp) =
 {
 	common_read,
 	class_read,
@@ -1840,7 +1842,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	return 1U << (perdatum->value-1);
 }
 
-static int range_read(struct policydb *p, void *fp)
+static int range_read(struct policydb *p, struct policy_file *fp)
 {
 	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
@@ -1917,7 +1919,7 @@ static int range_read(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
+static int filename_trans_read_helper_compat(struct policydb *p, struct policy_file *fp)
 {
 	struct filename_trans_key key, *ft = NULL;
 	struct filename_trans_datum *last, *datum = NULL;
@@ -2001,7 +2003,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int filename_trans_read_helper(struct policydb *p, void *fp)
+static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp)
 {
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
@@ -2090,7 +2092,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int filename_trans_read(struct policydb *p, void *fp)
+static int filename_trans_read(struct policydb *p, struct policy_file *fp)
 {
 	u32 nel;
 	__le32 buf[1];
@@ -2131,7 +2133,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int genfs_read(struct policydb *p, void *fp)
+static int genfs_read(struct policydb *p, struct policy_file *fp)
 {
 	int i, j, rc;
 	u32 nel, nel2, len, len2;
@@ -2245,7 +2247,7 @@ static int genfs_read(struct policydb *p, void *fp)
 }
 
 static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
-			 void *fp)
+			 struct policy_file *fp)
 {
 	int i, j, rc;
 	u32 nel, len;
@@ -2430,7 +2432,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
  */
-int policydb_read(struct policydb *p, void *fp)
+int policydb_read(struct policydb *p, struct policy_file *fp)
 {
 	struct role_allow *ra, *lra;
 	struct role_trans_key *rtk = NULL;
@@ -2748,7 +2750,7 @@ int policydb_read(struct policydb *p, void *fp)
  * Write a MLS level structure to a policydb binary
  * representation file.
  */
-static int mls_write_level(struct mls_level *l, void *fp)
+static int mls_write_level(struct mls_level *l, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -2769,7 +2771,7 @@ static int mls_write_level(struct mls_level *l, void *fp)
  * Write a MLS range structure to a policydb binary
  * representation file.
  */
-static int mls_write_range_helper(struct mls_range *r, void *fp)
+static int mls_write_range_helper(struct mls_range *r, struct policy_file *fp)
 {
 	__le32 buf[3];
 	size_t items;
@@ -2809,7 +2811,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct level_datum *levdatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[2];
 	size_t len;
 	int rc;
@@ -2837,7 +2839,7 @@ static int cat_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct cat_datum *catdatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[3];
 	size_t len;
 	int rc;
@@ -2862,7 +2864,7 @@ static int role_trans_write_one(void *key, void *datum, void *ptr)
 	struct role_trans_key *rtk = key;
 	struct role_trans_datum *rtd = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	__le32 buf[3];
 	int rc;
@@ -2882,7 +2884,7 @@ static int role_trans_write_one(void *key, void *datum, void *ptr)
 	return 0;
 }
 
-static int role_trans_write(struct policydb *p, void *fp)
+static int role_trans_write(struct policydb *p, struct policy_file *fp)
 {
 	struct policy_data pd = { .p = p, .fp = fp };
 	__le32 buf[1];
@@ -2896,7 +2898,7 @@ static int role_trans_write(struct policydb *p, void *fp)
 	return hashtab_map(&p->role_tr, role_trans_write_one, &pd);
 }
 
-static int role_allow_write(struct role_allow *r, void *fp)
+static int role_allow_write(struct role_allow *r, struct policy_file *fp)
 {
 	struct role_allow *ra;
 	__le32 buf[2];
@@ -2925,7 +2927,7 @@ static int role_allow_write(struct role_allow *r, void *fp)
  * to a policydb binary representation file.
  */
 static int context_write(struct policydb *p, struct context *c,
-			 void *fp)
+			 struct policy_file *fp)
 {
 	int rc;
 	__le32 buf[3];
@@ -2978,7 +2980,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct common_datum *comdatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[4];
 	size_t len;
 	int rc;
@@ -3003,7 +3005,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int type_set_write(struct type_set *t, void *fp)
+static int type_set_write(struct type_set *t, struct policy_file *fp)
 {
 	int rc;
 	__le32 buf[1];
@@ -3022,7 +3024,7 @@ static int type_set_write(struct type_set *t, void *fp)
 }
 
 static int write_cons_helper(struct policydb *p, struct constraint_node *node,
-			     void *fp)
+			     struct policy_file *fp)
 {
 	struct constraint_node *c;
 	struct constraint_expr *e;
@@ -3073,7 +3075,7 @@ static int class_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct class_datum *cladatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	struct constraint_node *c;
 	__le32 buf[6];
@@ -3158,7 +3160,7 @@ static int role_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct role_datum *role = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	__le32 buf[3];
 	size_t items, len;
@@ -3198,7 +3200,7 @@ static int type_write(void *vkey, void *datum, void *ptr)
 	struct type_datum *typdatum = datum;
 	struct policy_data *pd = ptr;
 	struct policydb *p = pd->p;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[4];
 	int rc;
 	size_t items, len;
@@ -3239,7 +3241,7 @@ static int user_write(void *vkey, void *datum, void *ptr)
 	struct user_datum *usrdatum = datum;
 	struct policy_data *pd = ptr;
 	struct policydb *p = pd->p;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[3];
 	size_t items, len;
 	int rc;
@@ -3288,7 +3290,7 @@ static int (*write_f[SYM_NUM]) (void *key, void *datum,
 };
 
 static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
-			  void *fp)
+			  struct policy_file *fp)
 {
 	unsigned int i, j, rc;
 	size_t nel, len;
@@ -3417,7 +3419,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 	return 0;
 }
 
-static int genfs_write(struct policydb *p, void *fp)
+static int genfs_write(struct policydb *p, struct policy_file *fp)
 {
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -3475,7 +3477,7 @@ static int range_write_helper(void *key, void *data, void *ptr)
 	struct range_trans *rt = key;
 	struct mls_range *r = data;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	int rc;
 
@@ -3497,7 +3499,7 @@ static int range_write_helper(void *key, void *data, void *ptr)
 	return 0;
 }
 
-static int range_write(struct policydb *p, void *fp)
+static int range_write(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -3524,7 +3526,7 @@ static int filename_write_helper_compat(void *key, void *data, void *ptr)
 	struct filename_trans_key *ft = key;
 	struct filename_trans_datum *datum = data;
 	struct ebitmap_node *node;
-	void *fp = ptr;
+	struct policy_file *fp = ptr;
 	__le32 buf[4];
 	int rc;
 	u32 bit, len = strlen(ft->name);
@@ -3560,7 +3562,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 {
 	struct filename_trans_key *ft = key;
 	struct filename_trans_datum *datum;
-	void *fp = ptr;
+	struct policy_file *fp = ptr;
 	__le32 buf[3];
 	int rc;
 	u32 ndatum, len = strlen(ft->name);
@@ -3605,7 +3607,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 	return 0;
 }
 
-static int filename_trans_write(struct policydb *p, void *fp)
+static int filename_trans_write(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -3637,7 +3639,7 @@ static int filename_trans_write(struct policydb *p, void *fp)
  * structure to a policy database binary representation
  * file.
  */
-int policydb_write(struct policydb *p, void *fp)
+int policydb_write(struct policydb *p, struct policy_file *fp)
 {
 	unsigned int i, num_syms;
 	int rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index ffc4e7bad2054..862b6577e79d7 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -315,14 +315,19 @@ struct policydb {
 	u32 process_trans_perms;
 } __randomize_layout;
 
+struct policy_file {
+	char *data;
+	size_t len;
+};
+
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
 extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
-extern int policydb_read(struct policydb *p, void *fp);
-extern int policydb_write(struct policydb *p, void *fp);
+extern int policydb_read(struct policydb *p, struct policy_file *fp);
+extern int policydb_write(struct policydb *p, struct policy_file *fp);
 
 extern struct filename_trans_datum *policydb_filenametr_search(
 	struct policydb *p, struct filename_trans_key *key);
@@ -345,14 +350,9 @@ extern struct role_trans_datum *policydb_roletr_search(
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
 
-struct policy_file {
-	char *data;
-	size_t len;
-};
-
 struct policy_data {
 	struct policydb *p;
-	void *fp;
+	struct policy_file *fp;
 };
 
 static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
-- 
2.53.0

