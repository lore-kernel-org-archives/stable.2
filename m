Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B135F5F8
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820009; cv=none; b=P+GTP7IDHp8P4JSoSFbhGXZKWT6BFNEmv0nP4vG4kBodUDEmL8JoxAWN+PFA08Rbn6IbUgsm3KXs4b3NFTgqaK9HcBZCK/rNYkdZ65ZBQD8cc3dVDwr9eFOvsB7fJcWg8z59EWhvZ7TvsRBPiV9f6FF9EmsVp3A2vJW2vXEuB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820009; c=relaxed/simple;
	bh=DmwsUrdDR4ibFVydQ20mBzaPW2Wlv1PoT79ZsfAtN8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uflVcTTj1IUpc9Xp8cXWCmBPUH1QwAxjqbZUXJZn67vN1xP4y1VYLM3bERNey7a8pD7GrFMa1dyHC1E8qz6UqbDb1bHbOzshillN1Xh7woCEpyBFb/Cxk1EE0bFeEfJejaJvJYbWljn4qXf5V/hfH/uM33gNLU8c0qjP2F52G6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ONXO5di8; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ONXO5di8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787819974;
	bh=kmqBE8PCCtzBK8cVUkLMuD2SBbMO7/XX/DD+t52KuBw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ONXO5di8WEbg5Po8HtCPsSINFroxhRa8GPbxybeBafFRezjhKurdv6JfmbGQ68Oee
	 LK/BYD0bM0T/fZK4uMWJ2ZF8gEi/LNYrHjatG/AxOhIQ5Z2360346HiRFFN+ADoJJB
	 3vckeBanB6p+0FHqppBQsNNc28x0PxRKkfEFB1Bo=
X-QQ-mid: zesmtpsz5t1787819969t5f8de175
X-QQ-Originating-IP: fu0oEU8EKszZmssOphaLdMSlB/UCg83/WlPhBTCLU5M=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:38:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13908119809336768337
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.47-rc1 02/10] Revert "selinux: more strict policy parsing"
Date: Thu, 27 Aug 2026 16:37:57 +0800
Message-Id: <20260827083802.4044165-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827050834.10002.stable-daily@kernel.org>
References: <20260827050834.10002.stable-daily@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mtj8kmNZi50gafak30B+TM9BAhvkgYLL+TnIdsPAXLz39kaeoIU+WEt3
	4ELL61nOGrwJ/XUr8uEeHWXtF5YzsCkyw/+BJgX9wToZw2+iprOk1lWfnavFxHNT3UxaBnK
	UjHZ6RrKCpYcaFEe6CVo948NJ4DRRcjTJAaqoQTBr4zirJhU8vhRgsy8gSgRFce3DwfQXoO
	pWINvzmed6y0HBEsssjbfV5ovTKLFW4T56MW+hSEbM3y6j7p0VeTfCpQfd1IL8L70shuNe7
	UKRjvxWki9gMT4Zuzax/Ing+1Gns6fwm99jaAeh6O5ZHoexxEItE8HMktIr4u8eUNIf5Fcp
	x+hc6WLpb6z8YEZOql7NejwJ07zHUrbhcaSuA6aj0GrgFLmbDrVtTIaJSynowmmXqgYo97R
	b9fV7eYQmysrrAjpNwXpKoPrsPIy14AsKVAbixmZAtljQ471I3JTd5HwRxUJx3Q68qAx9tp
	3HN8nhR7M8MEHuOdkw7yo8OfAaILRCMpnTh1XKrFsAJjKqY8Xr6vGM3EEjCd5mkDz1/4B8y
	raewZkT3fftQWYMuqpiodRR3s1eN/yYKkOms+6aDuNddwIt3YA/AjBg9FHxZ/yUhRuJNj4C
	h4GJymuvXS+xXSV/RKUFf4HZD3EAbJKG1SObKZjNpP6EFEVF938nQWiyG1AVlr6iGeKVfpv
	2D+UOvOEvoLLG9lth8i1WX5F6pChNBYPIkjTMbaVzG2mImfjAkYItrjzAwOsBvSPLs0unAK
	cu/QpWTqNn49JCuuDA/C/ho9LFAP2+wC5+Tqbmhg1SsmiUbsN0LpnCPQYq4GW/hctc4HecQ
	hDvGZMWGmKlWJte5vtdpt/P9vEDmyJF0IBXxJ3/vpOuGGVGmVSWmulg0f/GT5iV9Av4YowQ
	5DnSODpA/eSLvGdXyo7m4Btnm9cpQyfQ2JOoGr/xG4SE11QyI5BMlmImW6PmR5WrFXrZmPq
	pK0OgDaRekI9np9AS32dyOFmWjhn5GSaE1es5qNtMnzlYkpJQhw/swApI9Hil74B06dq0U6
	zO/NYXcSWNEaUdnSVJLqpoyI/ANJwhrTpLO1ZZCEI1VkmcfVca7py8jcMv6VImBpy//2s6h
	mVq1qyIGOVM3fDyfvxheqFW1ffha/1t5g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

This reverts commit f750d11bcf18ed4774cd1f160ec7f7be9da2d52b.
NOTE the patch revert commit which in stable-rc/linux-6.18.y.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/include/security.h |   1 -
 security/selinux/ss/avtab.c         |  35 +----
 security/selinux/ss/avtab.h         |  13 --
 security/selinux/ss/conditional.c   |  18 ++-
 security/selinux/ss/constraint.h    |   1 -
 security/selinux/ss/policydb.c      | 196 +++++-----------------------
 security/selinux/ss/policydb.h      |  23 +---
 security/selinux/ss/services.c      |   6 +-
 8 files changed, 60 insertions(+), 233 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f698ff7962282..30e3fa962f6fa 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -225,7 +225,6 @@ int security_read_policy(void **data, size_t *len);
 int security_read_state_kernel(void **data, size_t *len);
 int security_policycap_supported(unsigned int req_cap);
 
-/* Maximum supported number of permissions per class */
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 33556922f15ed..c2c31521cace1 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -349,7 +349,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
 	int rc;
-	unsigned int vers = pol->policyvers;
+	unsigned int set, vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -360,12 +360,9 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
-		/* Read five or more items: source type, target type,
-		 * target class, AV type, and at least one datum.
-		 */
 		items2 = le32_to_cpu(buf32[0]);
-		if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
-			pr_err("SELinux: avtab: invalid item count\n");
+		if (items2 > ARRAY_SIZE(buf32)) {
+			pr_err("SELinux: avtab: entry overflow\n");
 			return -EINVAL;
 		}
 		rc = next_entry(buf32, fp, sizeof(u32) * items2);
@@ -394,13 +391,6 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			return -EINVAL;
 		}
 
-		if (!policydb_type_isvalid(pol, key.source_type) ||
-		    !policydb_type_isvalid(pol, key.target_type) ||
-		    !policydb_class_isvalid(pol, key.target_class)) {
-			pr_err("SELinux: avtab: invalid type or class\n");
-			return -EINVAL;
-		}
-
 		val = le32_to_cpu(buf32[items++]);
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
@@ -419,11 +409,6 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 
 		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
-				if (items >= items2) {
-					pr_err("SELinux: avtab: entry has too many items (%d/%d)\n",
-					       items + 1, items2);
-					return -EINVAL;
-				}
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
@@ -459,13 +444,9 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 		return -EINVAL;
 	}
 
-	if (hweight16(key.specified & ~AVTAB_ENABLED) != 1) {
-		pr_err("SELinux:  avtab:  not exactly one specifier\n");
-		return -EINVAL;
-	}
-
-	if (key.specified & ~AVTAB_SPECIFIER_MASK) {
-		pr_err("SELinux:  avtab:  invalid specifier\n");
+	set = hweight16(key.specified & (AVTAB_XPERMS | AVTAB_TYPE | AVTAB_AV));
+	if (!set || set > 1) {
+		pr_err("SELinux:  avtab:  more than one specifier\n");
 		return -EINVAL;
 	}
 
@@ -490,10 +471,6 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
-		if (!avtab_is_valid_xperm_specified(xperms.specified))
-			pr_warn_once_policyload(pol,
-						"SELinux: avtab: unsupported xperm specifier %#x\n",
-						xperms.specified);
 		rc = next_entry(&xperms.driver, fp, sizeof(u8));
 		if (rc) {
 			pr_err("SELinux: avtab: truncated entry\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 1de4cce288a76..850b3453f2598 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -44,7 +44,6 @@ struct avtab_key {
 	 AVTAB_XPERMS_DONTAUDIT)
 #define AVTAB_ENABLED_OLD 0x80000000 /* reserved for used in cond_avtab */
 #define AVTAB_ENABLED	  0x8000 /* reserved for used in cond_avtab */
-#define AVTAB_SPECIFIER_MASK (AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTAB_ENABLED)
 	u16 specified; /* what field is specified */
 };
 
@@ -69,18 +68,6 @@ struct avtab_extended_perms {
 	struct extended_perms_data perms;
 };
 
-static inline bool avtab_is_valid_xperm_specified(u8 specified)
-{
-	switch (specified) {
-	case AVTAB_XPERMS_IOCTLFUNCTION:
-	case AVTAB_XPERMS_IOCTLDRIVER:
-	case AVTAB_XPERMS_NLMSG:
-		return true;
-	default:
-		return false;
-	}
-}
-
 struct avtab_datum {
 	union {
 		u32 data; /* access vector or type value */
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index db30462ed6a32..1bebfcb9c6a12 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -199,12 +199,19 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	return 0;
 }
 
+static int bool_isvalid(struct cond_bool_datum *b)
+{
+	if (!(b->state == 0 || b->state == 1))
+		return 0;
+	return 1;
+}
+
 int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
 	__le32 buf[3];
-	u32 len, val;
+	u32 len;
 	int rc;
 
 	booldatum = kzalloc(sizeof(*booldatum), GFP_KERNEL);
@@ -216,12 +223,11 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 		goto err;
 
 	booldatum->value = le32_to_cpu(buf[0]);
-	val = le32_to_cpu(buf[1]);
+	booldatum->state = le32_to_cpu(buf[1]);
 
 	rc = -EINVAL;
-	if (!val_is_boolean(val))
+	if (!bool_isvalid(booldatum))
 		goto err;
-	booldatum->state = (int)val;
 
 	len = le32_to_cpu(buf[2]);
 
@@ -235,7 +241,6 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 
 	return 0;
 err:
-	pr_err("SELinux: conditional: failed to read boolean\n");
 	cond_destroy_bool(key, booldatum, NULL);
 	return rc;
 }
@@ -357,8 +362,7 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 		return 0;
 	}
 
-	if (expr->expr_type == COND_BOOL &&
-	    (expr->boolean == 0 || expr->boolean > p->p_bools.nprim)) {
+	if (expr->boolean > p->p_bools.nprim) {
 		pr_err("SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 1d75a8a044df9..203033cfad672 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -50,7 +50,6 @@ struct constraint_expr {
 	u32 op; /* operator */
 
 	struct ebitmap names; /* names */
-	/* internally unused, only forwarded via policydb_write() */
 	struct type_set *type_names;
 
 	struct constraint_expr *next; /* next expression */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index fac3b61bfa202..37e0735b0dc8d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -638,11 +638,13 @@ static int sens_index(void *key, void *datum, void *datap)
 	levdatum = datum;
 	p = datap;
 
-	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim)
-		return -EINVAL;
+	if (!levdatum->isalias) {
+		if (!levdatum->level.sens ||
+		    levdatum->level.sens > p->p_levels.nprim)
+			return -EINVAL;
 
-	if (!levdatum->isalias)
 		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
+	}
 
 	return 0;
 }
@@ -655,11 +657,12 @@ static int cat_index(void *key, void *datum, void *datap)
 	catdatum = datum;
 	p = datap;
 
-	if (!catdatum->value || catdatum->value > p->p_cats.nprim)
-		return -EINVAL;
+	if (!catdatum->isalias) {
+		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+			return -EINVAL;
 
-	if (!catdatum->isalias)
 		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
+	}
 
 	return 0;
 }
@@ -1157,9 +1160,6 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
-	rc = -EINVAL;
-	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
-		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1197,9 +1197,6 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[3]);
-	rc = -EINVAL;
-	if (nel > SEL_VEC_MAX)
-		goto bad;
 
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
@@ -1351,7 +1348,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1364,16 +1361,8 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
+	cladatum->value = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[4]);
-	rc = -EINVAL;
-	if (nel > SEL_VEC_MAX)
-		goto bad;
-
-	val = le32_to_cpu(buf[2]);
-	rc = -EINVAL;
-	if (val > U16_MAX)
-		goto bad;
-	cladatum->value = val;
 
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
@@ -1441,59 +1430,16 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		if (rc)
 			goto bad;
 
-		rc = -EINVAL;
-		val = le32_to_cpu(buf[0]);
-		switch (val) {
-		case 0:
-		case DEFAULT_SOURCE:
-		case DEFAULT_TARGET:
-			cladatum->default_user = val;
-			break;
-		default:
-			goto bad;
-		}
-		val = le32_to_cpu(buf[1]);
-		switch (val) {
-		case 0:
-		case DEFAULT_SOURCE:
-		case DEFAULT_TARGET:
-			cladatum->default_role = val;
-			break;
-		default:
-			goto bad;
-		}
-		val = le32_to_cpu(buf[2]);
-		switch (val) {
-		case 0:
-		case DEFAULT_SOURCE_LOW:
-		case DEFAULT_SOURCE_HIGH:
-		case DEFAULT_SOURCE_LOW_HIGH:
-		case DEFAULT_TARGET_LOW:
-		case DEFAULT_TARGET_HIGH:
-		case DEFAULT_TARGET_LOW_HIGH:
-		case DEFAULT_GLBLUB:
-			cladatum->default_range = val;
-			break;
-		default:
-			goto bad;
-		}
+		cladatum->default_user = le32_to_cpu(buf[0]);
+		cladatum->default_role = le32_to_cpu(buf[1]);
+		cladatum->default_range = le32_to_cpu(buf[2]);
 	}
 
 	if (p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) {
 		rc = next_entry(buf, fp, sizeof(u32) * 1);
 		if (rc)
 			goto bad;
-		rc = -EINVAL;
-		val = le32_to_cpu(buf[0]);
-		switch (val) {
-		case 0:
-		case DEFAULT_TARGET:
-		case DEFAULT_SOURCE:
-			cladatum->default_type = val;
-			break;
-		default:
-			goto bad;
-		}
+		cladatum->default_type = le32_to_cpu(buf[0]);
 	}
 
 	rc = symtab_insert(s, key, cladatum);
@@ -1503,8 +1449,6 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	return 0;
 bad:
 	cls_destroy(key, cladatum, NULL);
-	if (rc)
-		pr_err("SELinux:  invalid class\n");
 	return rc;
 }
 
@@ -1696,7 +1640,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	struct level_datum *levdatum;
 	int rc;
 	__le32 buf[2];
-	u32 len, val;
+	u32 len;
 
 	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
 	if (!levdatum)
@@ -1707,11 +1651,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	val = le32_to_cpu(buf[1]);
-	rc = -EINVAL;
-	if (!val_is_boolean(val))
-		goto bad;
-	levdatum->isalias = val;
+	levdatum->isalias = le32_to_cpu(buf[1]);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1727,8 +1667,6 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	return 0;
 bad:
 	sens_destroy(key, levdatum, NULL);
-	if (rc)
-		pr_err("SELinux:  invalid sensitivity\n");
 	return rc;
 }
 
@@ -1738,7 +1676,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	struct cat_datum *catdatum;
 	int rc;
 	__le32 buf[3];
-	u32 len, val;
+	u32 len;
 
 	catdatum = kzalloc(sizeof(*catdatum), GFP_KERNEL);
 	if (!catdatum)
@@ -1750,11 +1688,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 
 	len = le32_to_cpu(buf[0]);
 	catdatum->value = le32_to_cpu(buf[1]);
-	val = le32_to_cpu(buf[2]);
-	rc = -EINVAL;
-	if (!val_is_boolean(val))
-		goto bad;
-	catdatum->isalias = val;
+	catdatum->isalias = le32_to_cpu(buf[2]);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1766,8 +1700,6 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	return 0;
 bad:
 	cat_destroy(key, catdatum, NULL);
-	if (rc)
-		pr_err("SELinux:  invalid category\n");
 	return rc;
 }
 
@@ -1949,7 +1881,7 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 	struct mls_range *r = NULL;
 	int rc;
 	__le32 buf[2];
-	u32 i, nel, val;
+	u32 i, nel;
 
 	if (p->policyvers < POLICYDB_VERSION_MLS)
 		return 0;
@@ -1980,11 +1912,7 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto out;
-			rc = -EINVAL;
-			val = le32_to_cpu(buf[0]);
-			if (val > U16_MAX)
-				goto out;
-			rt->target_class = val;
+			rt->target_class = le32_to_cpu(buf[0]);
 		} else
 			rt->target_class = p->process_class;
 
@@ -2021,8 +1949,6 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 out:
 	kfree(rt);
 	kfree(r);
-	if (rc)
-		pr_err("SELinux:  invalid range\n");
 	return rc;
 }
 
@@ -2031,7 +1957,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	struct filename_trans_key key, *ft = NULL;
 	struct filename_trans_datum *last, *datum = NULL;
 	char *name = NULL;
-	u32 len, stype, otype, val;
+	u32 len, stype, otype;
 	__le32 buf[4];
 	int rc;
 
@@ -2050,17 +1976,9 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	if (rc)
 		goto out;
 
-	rc = -EINVAL;
 	stype = le32_to_cpu(buf[0]);
-	if (!policydb_type_isvalid(p, stype))
-		goto out;
 	key.ttype = le32_to_cpu(buf[1]);
-	if (!policydb_type_isvalid(p, key.ttype))
-		goto out;
-	val = le32_to_cpu(buf[2]);
-	if (val > U16_MAX || !policydb_class_isvalid(p, val))
-		goto out;
-	key.tclass = val;
+	key.tclass = le32_to_cpu(buf[2]);
 	key.name = name;
 
 	otype = le32_to_cpu(buf[3]);
@@ -2116,9 +2034,6 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	kfree(ft);
 	kfree(name);
 	kfree(datum);
-
-	if (rc)
-		pr_err("SELinux:  invalid compat filename transition\n");
 	return rc;
 }
 
@@ -2127,7 +2042,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, ndatum, i, val;
+	u32 len, ttype, ndatum, i;
 	u16 tclass;
 	__le32 buf[3];
 	int rc;
@@ -2147,15 +2062,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	if (rc)
 		goto out;
 
-	rc = -EINVAL;
 	ttype = le32_to_cpu(buf[0]);
-	if (!policydb_type_isvalid(p, ttype))
-		goto out;
-	val = le32_to_cpu(buf[1]);
-	rc = -EINVAL;
-	if (val > U16_MAX || !policydb_class_isvalid(p, val))
-		goto out;
-	tclass = val;
+	tclass = le32_to_cpu(buf[1]);
 
 	ndatum = le32_to_cpu(buf[2]);
 	if (ndatum == 0) {
@@ -2185,10 +2093,6 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 
 		datum->otype = le32_to_cpu(buf[0]);
 
-		rc = -EINVAL;
-		if (!policydb_type_isvalid(p, datum->otype))
-			goto out;
-
 		dst = &datum->next;
 	}
 
@@ -2220,9 +2124,6 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		ebitmap_destroy(&datum->stypes);
 		kfree(datum);
 	}
-
-	if (rc)
-		pr_err("SELinux:  invalid filename transition\n");
 	return rc;
 }
 
@@ -2270,7 +2171,7 @@ static int filename_trans_read(struct policydb *p, struct policy_file *fp)
 static int genfs_read(struct policydb *p, struct policy_file *fp)
 {
 	int rc;
-	u32 i, j, nel, nel2, len, len2, val;
+	u32 i, j, nel, nel2, len, len2;
 	__le32 buf[1];
 	struct ocontext *l, *c;
 	struct ocontext *newc = NULL;
@@ -2340,11 +2241,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 			if (rc)
 				goto out;
 
-			rc = -EINVAL;
-			val = le32_to_cpu(buf[0]);
-			if (val > U16_MAX || (val != 0 && !policydb_class_isvalid(p, val)))
-				goto out;
-			newc->v.sclass = val;
+			newc->v.sclass = le32_to_cpu(buf[0]);
 			rc = context_read_and_validate(&newc->context[0], p,
 						       fp);
 			if (rc)
@@ -2381,9 +2278,6 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 	}
 	ocontext_destroy(newc, OCON_FSUSE);
 
-	if (rc)
-		pr_err("SELinux:  invalid genfs\n");
-
 	return rc;
 }
 
@@ -2392,7 +2286,7 @@ static int ocontext_read(struct policydb *p,
 {
 	int rc;
 	unsigned int i;
-	u32 j, nel, len, val;
+	u32 j, nel, len;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2456,25 +2350,11 @@ static int ocontext_read(struct policydb *p,
 				rc = next_entry(buf, fp, sizeof(u32) * 3);
 				if (rc)
 					goto out;
-
-				rc = -EINVAL;
-				val = le32_to_cpu(buf[0]);
-				if (val > U8_MAX)
-					goto out;
-				c->u.port.protocol = val;
-				val = le32_to_cpu(buf[1]);
-				if (val > U16_MAX)
-					goto out;
-				c->u.port.low_port = val;
-				val = le32_to_cpu(buf[2]);
-				if (val > U16_MAX)
-					goto out;
-				c->u.port.high_port = val;
-				if (c->u.port.low_port == 0 ||
-				    c->u.port.low_port > c->u.port.high_port)
-					goto out;
-
-				rc = context_read_and_validate(&c->context[0], p, fp);
+				c->u.port.protocol = le32_to_cpu(buf[0]);
+				c->u.port.low_port = le32_to_cpu(buf[1]);
+				c->u.port.high_port = le32_to_cpu(buf[2]);
+				rc = context_read_and_validate(&c->context[0],
+							       p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2592,8 +2472,6 @@ static int ocontext_read(struct policydb *p,
 	}
 	rc = 0;
 out:
-	if (rc)
-		pr_err("SELinux:  invalid ocon\n");
 	return rc;
 }
 
@@ -2608,7 +2486,7 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	struct role_trans_datum *rtd = NULL;
 	int rc;
 	__le32 buf[4];
-	u32 i, j, len, nprim, nel, perm, val;
+	u32 i, j, len, nprim, nel, perm;
 
 	char *policydb_str;
 	const struct policydb_compat_info *info;
@@ -2800,11 +2678,7 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto bad;
-			rc = -EINVAL;
-			val = le32_to_cpu(buf[0]);
-			if (val > U16_MAX)
-				goto bad;
-			rtk->tclass = val;
+			rtk->tclass = le32_to_cpu(buf[0]);
 		} else
 			rtk->tclass = p->process_class;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 20b834581106a..a49275d1168d8 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -74,7 +74,7 @@ struct class_datum {
 /* Role attributes */
 struct role_datum {
 	u32 value; /* internal role value */
-	u32 bounds; /* boundary of role, 0 for none */
+	u32 bounds; /* boundary of role */
 	struct ebitmap dominates; /* set of roles dominated by this role */
 	struct ebitmap types; /* set of authorized types for role */
 };
@@ -110,8 +110,7 @@ struct role_allow {
 /* Type attributes */
 struct type_datum {
 	u32 value; /* internal type value */
-	u32 bounds; /* boundary of type, 0 for none */
-	/* internally unused, only forwarded via policydb_write() */
+	u32 bounds; /* boundary of type */
 	unsigned char primary; /* primary name? */
 	unsigned char attribute; /* attribute ?*/
 };
@@ -119,7 +118,7 @@ struct type_datum {
 /* User attributes */
 struct user_datum {
 	u32 value; /* internal user value */
-	u32 bounds; /* bounds of user, 0 for none */
+	u32 bounds; /* bounds of user */
 	struct ebitmap roles; /* set of authorized roles for user */
 	struct mls_range range; /* MLS range (min - max) for user */
 	struct mls_level dfltlevel; /* default login MLS level for user */
@@ -196,7 +195,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u16 sclass; /* security class for genfs (can be 0 for wildcard) */
+		u16 sclass; /* security class for genfs */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
@@ -389,23 +388,9 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num,
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
-static inline bool val_is_boolean(u32 value)
-{
-	return value == 0 || value == 1;
-}
-
 extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
 
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
-#define pr_warn_once_policyload(policy, fmt, ...)    \
-	do {                                         \
-		static const void *prev_policy__;    \
-		if (prev_policy__ != policy) {       \
-			pr_warn(fmt, ##__VA_ARGS__); \
-			prev_policy__ = policy;      \
-		}                                    \
-	} while (0)
-
 #endif /* _SS_POLICYDB_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index fb150025359b0..cbc101b095a30 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -446,6 +446,8 @@ static int dump_masked_av_helper(void *k, void *d, void *args)
 	struct perm_datum *pdatum = d;
 	char **permission_names = args;
 
+	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
+
 	permission_names[pdatum->value - 1] = (char *)k;
 
 	return 0;
@@ -464,7 +466,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 	char *tclass_name;
 	char *scontext_name = NULL;
 	char *tcontext_name = NULL;
-	char *permission_names[SEL_VEC_MAX];
+	char *permission_names[32];
 	int index;
 	u32 length;
 	bool need_comma = false;
@@ -505,7 +507,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 			 "scontext=%s tcontext=%s tclass=%s perms=",
 			 reason, scontext_name, tcontext_name, tclass_name);
 
-	for (index = 0; index < SEL_VEC_MAX; index++) {
+	for (index = 0; index < 32; index++) {
 		u32 mask = (1 << index);
 
 		if ((mask & permissions) == 0)
-- 
2.30.2

