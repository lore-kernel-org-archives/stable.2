Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEE230BE9
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608827; cv=none; b=n469MVKTnlN4+k3q1In01i/mSa3KZs4mVzq4q8cRnyY/5O7tYOA/UD7RtWUTssR1K9E44GpisG7bd64ywBqvjHflB0WEDHVizTifoBP10A3gKwfHLtjhg7A29jTeeZN9F+knWcue8MbQpvwdqfYU0ZU/d2tNBXZhTSPsxLzzy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608827; c=relaxed/simple;
	bh=WWOVULXSQpdJy8QksG+6CTEdjlp59ZS01+AKrNMq1rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcgSn2TEjvZaWT6eEDCUkJOpDkpwTCOCB+jr3vZ7AuCucbFg7BHbsxUgXOCh7bohK+c+q2bs9u39aPDqg+N4L/OZc9fTpdET728Ka0gF0WHkbOpm8w1U8BvRP72UNSZmsFRaLAzGToPWwMtWX6ekGS49J3GSSo0GCw0ior9VGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4tVVnWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4tVVnWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B281F00A3D;
	Mon, 24 Aug 2026 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608825;
	bh=5ZLX53SCuDWs36uLafOtIVu37uYMq0A1xOrGwyJ43y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4tVVnWUPE9QVvTJyEpqBtvFvhiJE9NjiOpGEO91EOT3wFcTkl6/A08raGjvSdcUQ
	 k92RdutJK5mWBK2FN9h6my0+RHstu4wCv2IS0RenPlF9+ca0yK7QDEDm2Iom6FwhO/
	 BeT6k+x7tfXVzJUdrbFuSw+dIQAwWbij3rYcRcfXRcAmzg8NABPpxhoxLd+yZ/Vkbu
	 QrMHq8qgCoRC6wr+u39QP3II68P02NHQ7q2mKwNKhY2JW+EwXfyx2RqEs9+puECBF+
	 +MdKy42DeR+zK/arHTcY347ppZBhWO0tLhyX0keRU29xwxCcxOzsb4K1KTWZIWWS2E
	 wh8p0lcrHU32A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] selinux: more strict policy parsing
Date: Mon, 24 Aug 2026 18:00:21 -0400
Message-ID: <20260824220022.435960-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824220022.435960-1-sashal@kernel.org>
References: <2026082020-deputize-mosaic-579e@gregkh>
 <20260824220022.435960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 18fa21f10d008a0fc22565109c7d38f304295912 ]

Be more strict during parsing of policies and reject invalid values.

Add some error messages in the case of policy parse failures, to
enhance debugging, either on a malformed policy or a too strict check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: fixed checkpatch.pl warnings, style problems]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/include/security.h |   1 +
 security/selinux/ss/avtab.c         |  35 ++++-
 security/selinux/ss/avtab.h         |  13 ++
 security/selinux/ss/conditional.c   |  18 +--
 security/selinux/ss/constraint.h    |   1 +
 security/selinux/ss/policydb.c      | 196 +++++++++++++++++++++++-----
 security/selinux/ss/policydb.h      |  23 +++-
 security/selinux/ss/services.c      |   6 +-
 8 files changed, 233 insertions(+), 60 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 30e3fa962f6fa..f698ff7962282 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -225,6 +225,7 @@ int security_read_policy(void **data, size_t *len);
 int security_read_state_kernel(void **data, size_t *len);
 int security_policycap_supported(unsigned int req_cap);
 
+/* Maximum supported number of permissions per class */
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c2c31521cace1..33556922f15ed 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -349,7 +349,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
 	int rc;
-	unsigned int set, vers = pol->policyvers;
+	unsigned int vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -360,9 +360,12 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
+		/* Read five or more items: source type, target type,
+		 * target class, AV type, and at least one datum.
+		 */
 		items2 = le32_to_cpu(buf32[0]);
-		if (items2 > ARRAY_SIZE(buf32)) {
-			pr_err("SELinux: avtab: entry overflow\n");
+		if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
+			pr_err("SELinux: avtab: invalid item count\n");
 			return -EINVAL;
 		}
 		rc = next_entry(buf32, fp, sizeof(u32) * items2);
@@ -391,6 +394,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			return -EINVAL;
 		}
 
+		if (!policydb_type_isvalid(pol, key.source_type) ||
+		    !policydb_type_isvalid(pol, key.target_type) ||
+		    !policydb_class_isvalid(pol, key.target_class)) {
+			pr_err("SELinux: avtab: invalid type or class\n");
+			return -EINVAL;
+		}
+
 		val = le32_to_cpu(buf32[items++]);
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
@@ -409,6 +419,11 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 
 		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
+				if (items >= items2) {
+					pr_err("SELinux: avtab: entry has too many items (%d/%d)\n",
+					       items + 1, items2);
+					return -EINVAL;
+				}
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
@@ -444,9 +459,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 		return -EINVAL;
 	}
 
-	set = hweight16(key.specified & (AVTAB_XPERMS | AVTAB_TYPE | AVTAB_AV));
-	if (!set || set > 1) {
-		pr_err("SELinux:  avtab:  more than one specifier\n");
+	if (hweight16(key.specified & ~AVTAB_ENABLED) != 1) {
+		pr_err("SELinux:  avtab:  not exactly one specifier\n");
+		return -EINVAL;
+	}
+
+	if (key.specified & ~AVTAB_SPECIFIER_MASK) {
+		pr_err("SELinux:  avtab:  invalid specifier\n");
 		return -EINVAL;
 	}
 
@@ -471,6 +490,10 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
+		if (!avtab_is_valid_xperm_specified(xperms.specified))
+			pr_warn_once_policyload(pol,
+						"SELinux: avtab: unsupported xperm specifier %#x\n",
+						xperms.specified);
 		rc = next_entry(&xperms.driver, fp, sizeof(u8));
 		if (rc) {
 			pr_err("SELinux: avtab: truncated entry\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 850b3453f2598..1de4cce288a76 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -44,6 +44,7 @@ struct avtab_key {
 	 AVTAB_XPERMS_DONTAUDIT)
 #define AVTAB_ENABLED_OLD 0x80000000 /* reserved for used in cond_avtab */
 #define AVTAB_ENABLED	  0x8000 /* reserved for used in cond_avtab */
+#define AVTAB_SPECIFIER_MASK (AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTAB_ENABLED)
 	u16 specified; /* what field is specified */
 };
 
@@ -68,6 +69,18 @@ struct avtab_extended_perms {
 	struct extended_perms_data perms;
 };
 
+static inline bool avtab_is_valid_xperm_specified(u8 specified)
+{
+	switch (specified) {
+	case AVTAB_XPERMS_IOCTLFUNCTION:
+	case AVTAB_XPERMS_IOCTLDRIVER:
+	case AVTAB_XPERMS_NLMSG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 struct avtab_datum {
 	union {
 		u32 data; /* access vector or type value */
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 1bebfcb9c6a12..db30462ed6a32 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -199,19 +199,12 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	return 0;
 }
 
-static int bool_isvalid(struct cond_bool_datum *b)
-{
-	if (!(b->state == 0 || b->state == 1))
-		return 0;
-	return 1;
-}
-
 int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
 	__le32 buf[3];
-	u32 len;
+	u32 len, val;
 	int rc;
 
 	booldatum = kzalloc(sizeof(*booldatum), GFP_KERNEL);
@@ -223,11 +216,12 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 		goto err;
 
 	booldatum->value = le32_to_cpu(buf[0]);
-	booldatum->state = le32_to_cpu(buf[1]);
+	val = le32_to_cpu(buf[1]);
 
 	rc = -EINVAL;
-	if (!bool_isvalid(booldatum))
+	if (!val_is_boolean(val))
 		goto err;
+	booldatum->state = (int)val;
 
 	len = le32_to_cpu(buf[2]);
 
@@ -241,6 +235,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 
 	return 0;
 err:
+	pr_err("SELinux: conditional: failed to read boolean\n");
 	cond_destroy_bool(key, booldatum, NULL);
 	return rc;
 }
@@ -362,7 +357,8 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 		return 0;
 	}
 
-	if (expr->boolean > p->p_bools.nprim) {
+	if (expr->expr_type == COND_BOOL &&
+	    (expr->boolean == 0 || expr->boolean > p->p_bools.nprim)) {
 		pr_err("SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 203033cfad672..1d75a8a044df9 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -50,6 +50,7 @@ struct constraint_expr {
 	u32 op; /* operator */
 
 	struct ebitmap names; /* names */
+	/* internally unused, only forwarded via policydb_write() */
 	struct type_set *type_names;
 
 	struct constraint_expr *next; /* next expression */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 37e0735b0dc8d..fac3b61bfa202 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -638,13 +638,11 @@ static int sens_index(void *key, void *datum, void *datap)
 	levdatum = datum;
 	p = datap;
 
-	if (!levdatum->isalias) {
-		if (!levdatum->level.sens ||
-		    levdatum->level.sens > p->p_levels.nprim)
-			return -EINVAL;
+	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim)
+		return -EINVAL;
 
+	if (!levdatum->isalias)
 		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
-	}
 
 	return 0;
 }
@@ -657,12 +655,11 @@ static int cat_index(void *key, void *datum, void *datap)
 	catdatum = datum;
 	p = datap;
 
-	if (!catdatum->isalias) {
-		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
-			return -EINVAL;
+	if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+		return -EINVAL;
 
+	if (!catdatum->isalias)
 		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
-	}
 
 	return 0;
 }
@@ -1160,6 +1157,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1197,6 +1197,9 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[3]);
+	rc = -EINVAL;
+	if (nel > SEL_VEC_MAX)
+		goto bad;
 
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
@@ -1348,7 +1351,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel;
+	u32 i, len, len2, ncons, nel, val;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1361,8 +1364,16 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
-	cladatum->value = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[4]);
+	rc = -EINVAL;
+	if (nel > SEL_VEC_MAX)
+		goto bad;
+
+	val = le32_to_cpu(buf[2]);
+	rc = -EINVAL;
+	if (val > U16_MAX)
+		goto bad;
+	cladatum->value = val;
 
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
@@ -1430,16 +1441,59 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		if (rc)
 			goto bad;
 
-		cladatum->default_user = le32_to_cpu(buf[0]);
-		cladatum->default_role = le32_to_cpu(buf[1]);
-		cladatum->default_range = le32_to_cpu(buf[2]);
+		rc = -EINVAL;
+		val = le32_to_cpu(buf[0]);
+		switch (val) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			cladatum->default_user = val;
+			break;
+		default:
+			goto bad;
+		}
+		val = le32_to_cpu(buf[1]);
+		switch (val) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			cladatum->default_role = val;
+			break;
+		default:
+			goto bad;
+		}
+		val = le32_to_cpu(buf[2]);
+		switch (val) {
+		case 0:
+		case DEFAULT_SOURCE_LOW:
+		case DEFAULT_SOURCE_HIGH:
+		case DEFAULT_SOURCE_LOW_HIGH:
+		case DEFAULT_TARGET_LOW:
+		case DEFAULT_TARGET_HIGH:
+		case DEFAULT_TARGET_LOW_HIGH:
+		case DEFAULT_GLBLUB:
+			cladatum->default_range = val;
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	if (p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) {
 		rc = next_entry(buf, fp, sizeof(u32) * 1);
 		if (rc)
 			goto bad;
-		cladatum->default_type = le32_to_cpu(buf[0]);
+		rc = -EINVAL;
+		val = le32_to_cpu(buf[0]);
+		switch (val) {
+		case 0:
+		case DEFAULT_TARGET:
+		case DEFAULT_SOURCE:
+			cladatum->default_type = val;
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	rc = symtab_insert(s, key, cladatum);
@@ -1449,6 +1503,8 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	return 0;
 bad:
 	cls_destroy(key, cladatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid class\n");
 	return rc;
 }
 
@@ -1640,7 +1696,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	struct level_datum *levdatum;
 	int rc;
 	__le32 buf[2];
-	u32 len;
+	u32 len, val;
 
 	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
 	if (!levdatum)
@@ -1651,7 +1707,11 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	levdatum->isalias = le32_to_cpu(buf[1]);
+	val = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (!val_is_boolean(val))
+		goto bad;
+	levdatum->isalias = val;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1667,6 +1727,8 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	return 0;
 bad:
 	sens_destroy(key, levdatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid sensitivity\n");
 	return rc;
 }
 
@@ -1676,7 +1738,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	struct cat_datum *catdatum;
 	int rc;
 	__le32 buf[3];
-	u32 len;
+	u32 len, val;
 
 	catdatum = kzalloc(sizeof(*catdatum), GFP_KERNEL);
 	if (!catdatum)
@@ -1688,7 +1750,11 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 
 	len = le32_to_cpu(buf[0]);
 	catdatum->value = le32_to_cpu(buf[1]);
-	catdatum->isalias = le32_to_cpu(buf[2]);
+	val = le32_to_cpu(buf[2]);
+	rc = -EINVAL;
+	if (!val_is_boolean(val))
+		goto bad;
+	catdatum->isalias = val;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1700,6 +1766,8 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	return 0;
 bad:
 	cat_destroy(key, catdatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid category\n");
 	return rc;
 }
 
@@ -1881,7 +1949,7 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 	struct mls_range *r = NULL;
 	int rc;
 	__le32 buf[2];
-	u32 i, nel;
+	u32 i, nel, val;
 
 	if (p->policyvers < POLICYDB_VERSION_MLS)
 		return 0;
@@ -1912,7 +1980,11 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto out;
-			rt->target_class = le32_to_cpu(buf[0]);
+			rc = -EINVAL;
+			val = le32_to_cpu(buf[0]);
+			if (val > U16_MAX)
+				goto out;
+			rt->target_class = val;
 		} else
 			rt->target_class = p->process_class;
 
@@ -1949,6 +2021,8 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 out:
 	kfree(rt);
 	kfree(r);
+	if (rc)
+		pr_err("SELinux:  invalid range\n");
 	return rc;
 }
 
@@ -1957,7 +2031,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	struct filename_trans_key key, *ft = NULL;
 	struct filename_trans_datum *last, *datum = NULL;
 	char *name = NULL;
-	u32 len, stype, otype;
+	u32 len, stype, otype, val;
 	__le32 buf[4];
 	int rc;
 
@@ -1976,9 +2050,17 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	if (rc)
 		goto out;
 
+	rc = -EINVAL;
 	stype = le32_to_cpu(buf[0]);
+	if (!policydb_type_isvalid(p, stype))
+		goto out;
 	key.ttype = le32_to_cpu(buf[1]);
-	key.tclass = le32_to_cpu(buf[2]);
+	if (!policydb_type_isvalid(p, key.ttype))
+		goto out;
+	val = le32_to_cpu(buf[2]);
+	if (val > U16_MAX || !policydb_class_isvalid(p, val))
+		goto out;
+	key.tclass = val;
 	key.name = name;
 
 	otype = le32_to_cpu(buf[3]);
@@ -2034,6 +2116,9 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	kfree(ft);
 	kfree(name);
 	kfree(datum);
+
+	if (rc)
+		pr_err("SELinux:  invalid compat filename transition\n");
 	return rc;
 }
 
@@ -2042,7 +2127,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, ndatum, i;
+	u32 len, ttype, ndatum, i, val;
 	u16 tclass;
 	__le32 buf[3];
 	int rc;
@@ -2062,8 +2147,15 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	if (rc)
 		goto out;
 
+	rc = -EINVAL;
 	ttype = le32_to_cpu(buf[0]);
-	tclass = le32_to_cpu(buf[1]);
+	if (!policydb_type_isvalid(p, ttype))
+		goto out;
+	val = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (val > U16_MAX || !policydb_class_isvalid(p, val))
+		goto out;
+	tclass = val;
 
 	ndatum = le32_to_cpu(buf[2]);
 	if (ndatum == 0) {
@@ -2093,6 +2185,10 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 
 		datum->otype = le32_to_cpu(buf[0]);
 
+		rc = -EINVAL;
+		if (!policydb_type_isvalid(p, datum->otype))
+			goto out;
+
 		dst = &datum->next;
 	}
 
@@ -2124,6 +2220,9 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		ebitmap_destroy(&datum->stypes);
 		kfree(datum);
 	}
+
+	if (rc)
+		pr_err("SELinux:  invalid filename transition\n");
 	return rc;
 }
 
@@ -2171,7 +2270,7 @@ static int filename_trans_read(struct policydb *p, struct policy_file *fp)
 static int genfs_read(struct policydb *p, struct policy_file *fp)
 {
 	int rc;
-	u32 i, j, nel, nel2, len, len2;
+	u32 i, j, nel, nel2, len, len2, val;
 	__le32 buf[1];
 	struct ocontext *l, *c;
 	struct ocontext *newc = NULL;
@@ -2241,7 +2340,11 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 			if (rc)
 				goto out;
 
-			newc->v.sclass = le32_to_cpu(buf[0]);
+			rc = -EINVAL;
+			val = le32_to_cpu(buf[0]);
+			if (val > U16_MAX || (val != 0 && !policydb_class_isvalid(p, val)))
+				goto out;
+			newc->v.sclass = val;
 			rc = context_read_and_validate(&newc->context[0], p,
 						       fp);
 			if (rc)
@@ -2278,6 +2381,9 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 	}
 	ocontext_destroy(newc, OCON_FSUSE);
 
+	if (rc)
+		pr_err("SELinux:  invalid genfs\n");
+
 	return rc;
 }
 
@@ -2286,7 +2392,7 @@ static int ocontext_read(struct policydb *p,
 {
 	int rc;
 	unsigned int i;
-	u32 j, nel, len;
+	u32 j, nel, len, val;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2350,11 +2456,25 @@ static int ocontext_read(struct policydb *p,
 				rc = next_entry(buf, fp, sizeof(u32) * 3);
 				if (rc)
 					goto out;
-				c->u.port.protocol = le32_to_cpu(buf[0]);
-				c->u.port.low_port = le32_to_cpu(buf[1]);
-				c->u.port.high_port = le32_to_cpu(buf[2]);
-				rc = context_read_and_validate(&c->context[0],
-							       p, fp);
+
+				rc = -EINVAL;
+				val = le32_to_cpu(buf[0]);
+				if (val > U8_MAX)
+					goto out;
+				c->u.port.protocol = val;
+				val = le32_to_cpu(buf[1]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.low_port = val;
+				val = le32_to_cpu(buf[2]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.high_port = val;
+				if (c->u.port.low_port == 0 ||
+				    c->u.port.low_port > c->u.port.high_port)
+					goto out;
+
+				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2472,6 +2592,8 @@ static int ocontext_read(struct policydb *p,
 	}
 	rc = 0;
 out:
+	if (rc)
+		pr_err("SELinux:  invalid ocon\n");
 	return rc;
 }
 
@@ -2486,7 +2608,7 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	struct role_trans_datum *rtd = NULL;
 	int rc;
 	__le32 buf[4];
-	u32 i, j, len, nprim, nel, perm;
+	u32 i, j, len, nprim, nel, perm, val;
 
 	char *policydb_str;
 	const struct policydb_compat_info *info;
@@ -2678,7 +2800,11 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto bad;
-			rtk->tclass = le32_to_cpu(buf[0]);
+			rc = -EINVAL;
+			val = le32_to_cpu(buf[0]);
+			if (val > U16_MAX)
+				goto bad;
+			rtk->tclass = val;
 		} else
 			rtk->tclass = p->process_class;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index a49275d1168d8..20b834581106a 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -74,7 +74,7 @@ struct class_datum {
 /* Role attributes */
 struct role_datum {
 	u32 value; /* internal role value */
-	u32 bounds; /* boundary of role */
+	u32 bounds; /* boundary of role, 0 for none */
 	struct ebitmap dominates; /* set of roles dominated by this role */
 	struct ebitmap types; /* set of authorized types for role */
 };
@@ -110,7 +110,8 @@ struct role_allow {
 /* Type attributes */
 struct type_datum {
 	u32 value; /* internal type value */
-	u32 bounds; /* boundary of type */
+	u32 bounds; /* boundary of type, 0 for none */
+	/* internally unused, only forwarded via policydb_write() */
 	unsigned char primary; /* primary name? */
 	unsigned char attribute; /* attribute ?*/
 };
@@ -118,7 +119,7 @@ struct type_datum {
 /* User attributes */
 struct user_datum {
 	u32 value; /* internal user value */
-	u32 bounds; /* bounds of user */
+	u32 bounds; /* bounds of user, 0 for none */
 	struct ebitmap roles; /* set of authorized roles for user */
 	struct mls_range range; /* MLS range (min - max) for user */
 	struct mls_level dfltlevel; /* default login MLS level for user */
@@ -195,7 +196,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u16 sclass; /* security class for genfs */
+		u16 sclass; /* security class for genfs (can be 0 for wildcard) */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
@@ -388,9 +389,23 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num,
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
+static inline bool val_is_boolean(u32 value)
+{
+	return value == 0 || value == 1;
+}
+
 extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
 
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
+#define pr_warn_once_policyload(policy, fmt, ...)    \
+	do {                                         \
+		static const void *prev_policy__;    \
+		if (prev_policy__ != policy) {       \
+			pr_warn(fmt, ##__VA_ARGS__); \
+			prev_policy__ = policy;      \
+		}                                    \
+	} while (0)
+
 #endif /* _SS_POLICYDB_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cbc101b095a30..fb150025359b0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -446,8 +446,6 @@ static int dump_masked_av_helper(void *k, void *d, void *args)
 	struct perm_datum *pdatum = d;
 	char **permission_names = args;
 
-	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
-
 	permission_names[pdatum->value - 1] = (char *)k;
 
 	return 0;
@@ -466,7 +464,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 	char *tclass_name;
 	char *scontext_name = NULL;
 	char *tcontext_name = NULL;
-	char *permission_names[32];
+	char *permission_names[SEL_VEC_MAX];
 	int index;
 	u32 length;
 	bool need_comma = false;
@@ -507,7 +505,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 			 "scontext=%s tcontext=%s tclass=%s perms=",
 			 reason, scontext_name, tcontext_name, tclass_name);
 
-	for (index = 0; index < 32; index++) {
+	for (index = 0; index < SEL_VEC_MAX; index++) {
 		u32 mask = (1 << index);
 
 		if ((mask & permissions) == 0)
-- 
2.53.0

