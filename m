Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311C22370A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657086; cv=none; b=UVPkRt7pEMVgbM86fEaln6qmGFF3JDYL8FR5pQYFuYijs2SuTO53Z9IgsbNtUWxU4a2oewkbF9TNLkNKl2ZkDTRUqLW5X+J132K2EjPlPgka9SBb0mvTO4o7ECAEBok2ecyy2m3dIE//MyRX016txw4IO8lXnwhafZ0h8lqFwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657086; c=relaxed/simple;
	bh=hJsDzMSsQLOnBZYjd4sESD8JHUzSxjTtOnG/t9zDA+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXwx4yqixTVctqA5BfutdXdLOUpf5yj0g8wBc2WMPCkuGjJk/pve4L+fN3IQKzi7lvDwActS5eUB1vnAhQAG4TKU6pL0g3uSlu89TVpEKjD1Ze9aowdOBiVJpHZ1/J75j0xf/nwTubbq7BWuX0viqQsDw98ElflQ9Td6yaoJXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5nVHVGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5nVHVGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E9D1F00A3D;
	Tue, 25 Aug 2026 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657084;
	bh=qaUTZY36+xmp811/XNaf/PEsamtF9gipzrQs32ukmvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5nVHVGpG3FL3bSjaCxExRHFbKsvZab+F1jumtKOnP0wBVeDKwZUp1Y9LdiRgk2YE
	 kW/VpmH5s96Zv3NpU8fxZ3Gd93R6HtnmDBaFXfRUV30b0k74BG1rPTDt9VsPLugs7T
	 G4qzNZFO7KGD/aHC6Up42EnygTT+fS0Eo6kTU9Mbrf1PfXoebNUo2TfoimG6bfGOuE
	 J6Mpn6I92HQ/qz0rV/7sSwHiw2kgF+FX+kJQv9SG5r42xn9X+fCyUHPO261gulLVd9
	 6YYkOD8nkvgKM2O4jGDTwwYTvaJjxRKoePrVpZZ2CFtWEp1ypfIl/ficqd6tneDkc6
	 avgG3C7WtfVxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/9] selinux: use known type instead of void pointer
Date: Tue, 25 Aug 2026 07:24:34 -0400
Message-ID: <20260825112440.3543785-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825112440.3543785-1-sashal@kernel.org>
References: <2026082022-circle-gooey-f888@gregkh>
 <20260825112440.3543785-1-sashal@kernel.org>
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
 security/selinux/ss/policydb.c    | 91 ++++++++++++++++---------------
 security/selinux/ss/policydb.h    | 16 +++---
 8 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 86d98a8e291b4..ca747e3567a05 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -367,7 +367,7 @@ static const uint16_t spec_order[] = {
 	AVTAB_XPERMS_DONTAUDIT
 };
 
-int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
+int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
 		    void *p)
@@ -535,7 +535,7 @@ static int avtab_insertf(struct avtab *a, const struct avtab_key *k,
 	return avtab_insert(a, k, d);
 }
 
-int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
+int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
 {
 	int rc;
 	__le32 buf[1];
@@ -579,7 +579,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 	goto out;
 }
 
-int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
+int avtab_write_item(struct policydb *p, const struct avtab_node *cur, struct policy_file *fp)
 {
 	__le16 buf16[4];
 	__le32 buf32[ARRAY_SIZE(cur->datum.u.xperms->perms.p)];
@@ -614,7 +614,7 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 	return 0;
 }
 
-int avtab_write(struct policydb *p, struct avtab *a, void *fp)
+int avtab_write(struct policydb *p, struct avtab *a, struct policy_file *fp)
 {
 	u32 i;
 	int rc = 0;
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 3c3904bf02b0f..ee0f6a8035f17 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -101,14 +101,16 @@ static inline void avtab_hash_eval(struct avtab *h, const char *tag)
 #endif
 
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
index 81ff676f209a8..69839eeadc38b 100644
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
index 5a7b51278dc6e..25f69809910f0 100644
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
index 77875ad355f70..4c3c49b19aa4f 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -362,7 +362,7 @@ void ebitmap_destroy(struct ebitmap *e)
 	e->node = NULL;
 }
 
-int ebitmap_read(struct ebitmap *e, void *fp)
+int ebitmap_read(struct ebitmap *e, struct policy_file *fp)
 {
 	struct ebitmap_node *n = NULL;
 	u32 mapunit, count, startbit, index;
@@ -468,7 +468,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	goto out;
 }
 
-int ebitmap_write(const struct ebitmap *e, void *fp)
+int ebitmap_write(const struct ebitmap *e, struct policy_file *fp)
 {
 	struct ebitmap_node *n;
 	u32 count;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e3c807cfad90b..8be8cade409f8 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -129,8 +129,9 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 las
 int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit);
 int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
-int ebitmap_read(struct ebitmap *e, void *fp);
-int ebitmap_write(const struct ebitmap *e, void *fp);
+struct policy_file;
+int ebitmap_read(struct ebitmap *e, struct policy_file *fp);
+int ebitmap_write(const struct ebitmap *e, struct policy_file *fp);
 u32 ebitmap_hash(const struct ebitmap *e, u32 hash);
 
 #ifdef CONFIG_NETLABEL
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 42ae225db69cb..3e96d7119c3f2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -983,7 +983,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
  * Read a MLS range structure from a policydb binary
  * representation file.
  */
-static int mls_read_range_helper(struct mls_range *r, void *fp)
+static int mls_read_range_helper(struct mls_range *r, struct policy_file *fp)
 {
 	__le32 buf[2];
 	u32 items;
@@ -1043,7 +1043,7 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
  * from a policydb binary representation file.
  */
 static int context_read_and_validate(struct context *c, struct policydb *p,
-				     void *fp)
+				     struct policy_file *fp)
 {
 	__le32 buf[3];
 	int rc;
@@ -1081,7 +1081,7 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -1104,7 +1104,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	return 0;
 }
 
-static int perm_read(struct policydb *p, struct symtab *s, void *fp)
+static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1137,7 +1137,7 @@ static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int common_read(struct policydb *p, struct symtab *s, void *fp)
+static int common_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
@@ -1187,7 +1187,7 @@ static void type_set_init(struct type_set *t)
 	ebitmap_init(&t->negset);
 }
 
-static int type_set_read(struct type_set *t, void *fp)
+static int type_set_read(struct type_set *t, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1206,7 +1206,7 @@ static int type_set_read(struct type_set *t, void *fp)
 }
 
 static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
-			    u32 ncons, int allowxtarget, void *fp)
+			    u32 ncons, int allowxtarget, struct policy_file *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
@@ -1300,7 +1300,7 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
 	return 0;
 }
 
-static int class_read(struct policydb *p, struct symtab *s, void *fp)
+static int class_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
@@ -1407,7 +1407,7 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int role_read(struct policydb *p, struct symtab *s, void *fp)
+static int role_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
@@ -1464,7 +1464,7 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int type_read(struct policydb *p, struct symtab *s, void *fp)
+static int type_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
@@ -1516,7 +1516,7 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
  * Read a MLS level structure from a policydb binary
  * representation file.
  */
-static int mls_read_level(struct mls_level *lp, void *fp)
+static int mls_read_level(struct mls_level *lp, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1538,7 +1538,7 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	return 0;
 }
 
-static int user_read(struct policydb *p, struct symtab *s, void *fp)
+static int user_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
@@ -1589,7 +1589,7 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int sens_read(struct policydb *p, struct symtab *s, void *fp)
+static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct level_datum *levdatum;
@@ -1630,7 +1630,7 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int cat_read(struct policydb *p, struct symtab *s, void *fp)
+static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct cat_datum *catdatum;
@@ -1665,7 +1665,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 
 /* clang-format off */
 static int (*const read_f[SYM_NUM])(struct policydb *p, struct symtab *s,
-				    void *fp) = {
+				    struct policy_file *fp) = {
 	common_read,
 	class_read,
 	role_read,
@@ -1835,7 +1835,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	return 1U << (perdatum->value - 1);
 }
 
-static int range_read(struct policydb *p, void *fp)
+static int range_read(struct policydb *p, struct policy_file *fp)
 {
 	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
@@ -1912,7 +1912,7 @@ static int range_read(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
+static int filename_trans_read_helper_compat(struct policydb *p, struct policy_file *fp)
 {
 	struct filename_trans_key key, *ft = NULL;
 	struct filename_trans_datum *last, *datum = NULL;
@@ -1996,7 +1996,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int filename_trans_read_helper(struct policydb *p, void *fp)
+static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp)
 {
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
@@ -2085,7 +2085,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int filename_trans_read(struct policydb *p, void *fp)
+static int filename_trans_read(struct policydb *p, struct policy_file *fp)
 {
 	u32 nel, i;
 	__le32 buf[1];
@@ -2126,7 +2126,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int genfs_read(struct policydb *p, void *fp)
+static int genfs_read(struct policydb *p, struct policy_file *fp)
 {
 	int rc;
 	u32 i, j, nel, nel2, len, len2;
@@ -2240,7 +2240,7 @@ static int genfs_read(struct policydb *p, void *fp)
 }
 
 static int ocontext_read(struct policydb *p,
-			 const struct policydb_compat_info *info, void *fp)
+			 const struct policydb_compat_info *info, struct policy_file *fp)
 {
 	int rc;
 	unsigned int i;
@@ -2437,7 +2437,7 @@ static int ocontext_read(struct policydb *p,
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
  */
-int policydb_read(struct policydb *p, void *fp)
+int policydb_read(struct policydb *p, struct policy_file *fp)
 {
 	struct role_allow *ra, *lra;
 	struct role_trans_key *rtk = NULL;
@@ -2758,7 +2758,7 @@ int policydb_read(struct policydb *p, void *fp)
  * Write a MLS level structure to a policydb binary
  * representation file.
  */
-static int mls_write_level(struct mls_level *l, void *fp)
+static int mls_write_level(struct mls_level *l, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -2779,7 +2779,7 @@ static int mls_write_level(struct mls_level *l, void *fp)
  * Write a MLS range structure to a policydb binary
  * representation file.
  */
-static int mls_write_range_helper(struct mls_range *r, void *fp)
+static int mls_write_range_helper(struct mls_range *r, struct policy_file *fp)
 {
 	__le32 buf[3];
 	size_t items;
@@ -2819,7 +2819,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct level_datum *levdatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[2];
 	size_t len;
 	int rc;
@@ -2847,7 +2847,7 @@ static int cat_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct cat_datum *catdatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[3];
 	size_t len;
 	int rc;
@@ -2872,7 +2872,7 @@ static int role_trans_write_one(void *key, void *datum, void *ptr)
 	struct role_trans_key *rtk = key;
 	struct role_trans_datum *rtd = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	__le32 buf[3];
 	int rc;
@@ -2892,7 +2892,7 @@ static int role_trans_write_one(void *key, void *datum, void *ptr)
 	return 0;
 }
 
-static int role_trans_write(struct policydb *p, void *fp)
+static int role_trans_write(struct policydb *p, struct policy_file *fp)
 {
 	struct policy_data pd = { .p = p, .fp = fp };
 	__le32 buf[1];
@@ -2906,7 +2906,7 @@ static int role_trans_write(struct policydb *p, void *fp)
 	return hashtab_map(&p->role_tr, role_trans_write_one, &pd);
 }
 
-static int role_allow_write(struct role_allow *r, void *fp)
+static int role_allow_write(struct role_allow *r, struct policy_file *fp)
 {
 	struct role_allow *ra;
 	__le32 buf[2];
@@ -2934,7 +2934,7 @@ static int role_allow_write(struct role_allow *r, void *fp)
  * Write a security context structure
  * to a policydb binary representation file.
  */
-static int context_write(struct policydb *p, struct context *c, void *fp)
+static int context_write(struct policydb *p, struct context *c, struct policy_file *fp)
 {
 	int rc;
 	__le32 buf[3];
@@ -2987,7 +2987,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct common_datum *comdatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[4];
 	size_t len;
 	int rc;
@@ -3012,7 +3012,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int type_set_write(struct type_set *t, void *fp)
+static int type_set_write(struct type_set *t, struct policy_file *fp)
 {
 	int rc;
 	__le32 buf[1];
@@ -3031,7 +3031,7 @@ static int type_set_write(struct type_set *t, void *fp)
 }
 
 static int write_cons_helper(struct policydb *p, struct constraint_node *node,
-			     void *fp)
+			     struct policy_file *fp)
 {
 	struct constraint_node *c;
 	struct constraint_expr *e;
@@ -3082,7 +3082,7 @@ static int class_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct class_datum *cladatum = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	struct constraint_node *c;
 	__le32 buf[6];
@@ -3167,7 +3167,7 @@ static int role_write(void *vkey, void *datum, void *ptr)
 	char *key = vkey;
 	struct role_datum *role = datum;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	__le32 buf[3];
 	size_t items, len;
@@ -3207,7 +3207,7 @@ static int type_write(void *vkey, void *datum, void *ptr)
 	struct type_datum *typdatum = datum;
 	struct policy_data *pd = ptr;
 	struct policydb *p = pd->p;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[4];
 	int rc;
 	size_t items, len;
@@ -3248,7 +3248,7 @@ static int user_write(void *vkey, void *datum, void *ptr)
 	struct user_datum *usrdatum = datum;
 	struct policy_data *pd = ptr;
 	struct policydb *p = pd->p;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	__le32 buf[3];
 	size_t items, len;
 	int rc;
@@ -3297,7 +3297,8 @@ static int (*const write_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 /* clang-format on */
 
 static int ocontext_write(struct policydb *p,
-			  const struct policydb_compat_info *info, void *fp)
+			  const struct policydb_compat_info *info,
+			  struct policy_file *fp)
 {
 	unsigned int i, j;
 	int rc;
@@ -3433,7 +3434,7 @@ static int ocontext_write(struct policydb *p,
 	return 0;
 }
 
-static int genfs_write(struct policydb *p, void *fp)
+static int genfs_write(struct policydb *p, struct policy_file *fp)
 {
 	struct genfs *genfs;
 	struct ocontext *c;
@@ -3491,7 +3492,7 @@ static int range_write_helper(void *key, void *data, void *ptr)
 	struct range_trans *rt = key;
 	struct mls_range *r = data;
 	struct policy_data *pd = ptr;
-	void *fp = pd->fp;
+	struct policy_file *fp = pd->fp;
 	struct policydb *p = pd->p;
 	int rc;
 
@@ -3513,7 +3514,7 @@ static int range_write_helper(void *key, void *data, void *ptr)
 	return 0;
 }
 
-static int range_write(struct policydb *p, void *fp)
+static int range_write(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -3540,7 +3541,7 @@ static int filename_write_helper_compat(void *key, void *data, void *ptr)
 	struct filename_trans_key *ft = key;
 	struct filename_trans_datum *datum = data;
 	struct ebitmap_node *node;
-	void *fp = ptr;
+	struct policy_file *fp = ptr;
 	__le32 buf[4];
 	int rc;
 	u32 bit, len = strlen(ft->name);
@@ -3577,7 +3578,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 {
 	struct filename_trans_key *ft = key;
 	struct filename_trans_datum *datum;
-	void *fp = ptr;
+	struct policy_file *fp = ptr;
 	__le32 buf[3];
 	int rc;
 	u32 ndatum, len = strlen(ft->name);
@@ -3622,7 +3623,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 	return 0;
 }
 
-static int filename_trans_write(struct policydb *p, void *fp)
+static int filename_trans_write(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -3654,7 +3655,7 @@ static int filename_trans_write(struct policydb *p, void *fp)
  * structure to a policy database binary representation
  * file.
  */
-int policydb_write(struct policydb *p, void *fp)
+int policydb_write(struct policydb *p, struct policy_file *fp)
 {
 	unsigned int num_syms;
 	int rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4bba386264a3d..e01de17e569bf 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -312,14 +312,19 @@ struct policydb {
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
 
 extern struct filename_trans_datum *
 policydb_filenametr_search(struct policydb *p, struct filename_trans_key *key);
@@ -342,14 +347,9 @@ policydb_roletr_search(struct policydb *p, struct role_trans_key *key);
 #define POLICYDB_MAGIC	SELINUX_MAGIC
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

