Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4441DDE5
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858161; cv=none; b=Y/1/ZPDO+0H2f8WNjAyFa6wlqRzYcC8P+DEsIa9LTjUjiyoGuqMhOeJ8wxQN65ZpUGoHYaLG3kaL4eAAtFukdCXoqOAPoSIXNCSwWkEDKF5EuQaM2C7xZeezy9jJkEu2FuTt/Tod/vHccEuE4ujQGk4OXtqSY0mFOOwcwbGWjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858161; c=relaxed/simple;
	bh=6FGiplFS0PDPmhzOGWvwT2A0VHqpdcx456DsSKjTm/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhXFBKlBziaiaVGro8Ep7IGTmW931uY88onlg3dtUC9lGzbSvZm/GT8FVqCYmLKvaIxu9OiLbu+RmbnWSxLmqQsqKIRzPXejkum2dd3G7iAxydBrrU68rm4EzIvgnItUSUcMoqvpK0LSyCmtZhsdv9Cf3VTQRLtNp6i3wfS1Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZX2c+84i; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZX2c+84i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858116;
	bh=SAUzBYq9taxXghTxKxGoz4mGITjhJTIVae+/V3Xb5dU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZX2c+84ib4Z8ptTnoCXbWD1PDekw/RZWv3YawXEARlct+Gp8kWEExnDDHQWHCRAGi
	 o3troH1Uze0URJb+ycIjFbCreO/cblXD/u8G/QbgxgtKzs/bJiKksCXh8LaAxOzlOV
	 qh5QkXd8DneFfKDgoZ//uikdp+n887urr+DkYKN8=
X-QQ-mid: esmtpgz15t1787858097tfd018a9c
X-QQ-Originating-IP: 73ZAEjuy+9WcmhEsSN0wC6JAMWIgB12ydY6U7KVAoes=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:14:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1701920421467550347
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6.12.y 7/7] selinux: require a class's permission values to cover its permission count
Date: Fri, 28 Aug 2026 03:13:24 +0800
Message-Id: <20260827191317.18119-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827191317.18119-1-guanwentao@uniontech.com>
References: <20260827191317.18119-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MLTNW9da3g2Os9Xpq2RPcKeSne5ayBhjYaHuFZKN+9TIA4EF8SdA7pFt
	xRUB5dZP7qCL9qTSQhXHaTB70jkSiynS7MEo2aOctxlJ9xKxnMl0y+XFK+/yRiJVd5qM3n6
	I8vUQrwyLEzm4lSpxsieyxRKu6Piy3pQFXbGsT3g0kGhkTgpjayKFiIlbEd8N4cHLhGUbBh
	fBQg0OUtpKhIyboImevjqQumyxkssU444WSwwxlr5Tb1uvX8OVGx+4D46AtWAL/gwD1k62i
	RdKTl5ib2iRCdjorvc1EEZ2hH0ljU1y22Mxnewl5y/OkUV2Zxcil6QJp/ZdDYCkokiwDqp8
	JP5XdqMTQEOf7k29GS3axEN5BBU5vhAhFwvXchKchpZIpG30L4/1tglFnHWhcNFotPkfmdG
	6Mc+BE0W3bKW4t8+g07uUNdiNZoI8SWw7K8gcmGH2itqbFXIqwo6iXlqg4K4YbwzZTf1voG
	s01T0OLnpysG5Wlj+InLXXrPScu16O1xg7okFO5FE0qSPL1PaAro82QyrRNMZs4PXuIDkTl
	ITqHoZX5j0u3ssEqGbfI3pDjtlgTa4XtSayh0s56ncPXGcSyngnvBwohw0hKa6OQLq0o+OL
	Vw1Rl4n9vh81Uj0v0VkQtjNcc0+M3M9WPg2sC5sWQDQGiKo7YbukMz9eVO66Gv2SA7whJeE
	GryAV5T24OuE3XgCno5LvqbwO9MexAKQ9bSaWTV5P7qtnn0mF1lGKQzQ0TBMkEp4/mfYmXO
	6ZRYRrtOjFWqRG9UYmGDfQWr9ivfS1ckHmtYRiGjAxtJWhHQz/bXCuoq4xl33QBk9SPR9Qd
	qbUxBfZEYwlo75+9UYTF1lNW0M3ryDnBaHi7V7VyOYp3IcoTT/fWpGTwdxMUIFJV42jdgw2
	1rZqFQcUlYYH4VAvSX5xfhW6RCyobtXxObtZku6vLWpJgiWLzuGONFdafHqrRMLZXYKv7tr
	n6L2D1kz3c5LnPjy6/ge+2FPf/qYdlNMHzrO8rbJ3tuSvJKOvADciWiv/GWGOig21jiQKoD
	pERTHSiOiV+8tvatLM6US5vBrwIpmzDWYjTAqZs4RCaK4mkU7k44IGvAIP/1df/1nTS39sK
	EZhZKoLKHpytZUBR1s+q4RxFWEAO3DnWpkbaq+H64hleUjOGB9/zBzmivipct4QK8ZRUPwy
	8MTZBFaLDAPstbg7/hsJANcTpQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Bryam Vargas <hexlabsecurity@proton.me>

security_get_permissions() sizes an array by the class's permissions.nprim
and fills it at value - 1, from the inherited common's permission table and
then the class's own. A value no permission defines leaves a NULL that
sel_make_perm_files() passes to d_alloc_name(), an oops inside
sel_write_load() that strands selinux_state.policy_mutex and leaves every
later load in uninterruptible sleep; two permissions sharing a value
overwrite the first kstrdup(). Bounding each value by nprim catches
neither, and neither would a count: the symbol table is keyed on the
permission name, so duplicates pass.

Track the values each permission table claims and require them to cover
exactly what its count declares, rejecting a count no value can reach.
Conforming policies are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit b98a8ac50775540f3804397ed08f61ef9910bcab)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 51 ++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3dc6d3057a89a..9df804f8625fd 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1127,7 +1127,18 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	return 0;
 }
 
-static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
+/*
+ * Bitmap of the permission values a symtab has claimed.  Values are 1-based
+ * and bounded by SEL_VEC_MAX, the width of an access vector, so the whole set
+ * fits in a u32 and the callers reject an nprim past that width.
+ */
+static u32 perm_claimed_mask(u32 nprim)
+{
+	return nprim ? U32_MAX >> (SEL_VEC_MAX - nprim) : 0;
+}
+
+static int perm_read(struct policydb *p, struct symtab *s,
+		     struct policy_file *fp, u32 *claimed)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1151,6 +1162,10 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
+	/* two permissions cannot share one slot of that array */
+	if (*claimed & (1U << (perdatum->value - 1)))
+		goto bad;
+	*claimed |= 1U << (perdatum->value - 1);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1171,7 +1186,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel;
+	u32 i, len, nel, claimed = 0;
 	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -1193,17 +1208,28 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	if (rc)
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (comdatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &comdatum->permissions, fp);
+		rc = perm_read(p, &comdatum->permissions, fp, &claimed);
 		if (rc)
 			goto bad;
 	}
 
+	rc = -EINVAL;
+	if (claimed != perm_claimed_mask(comdatum->permissions.nprim)) {
+		pr_err("SELinux:  common %s does not define every permission it declares\n",
+		       key);
+		goto bad;
+	}
+
 	hash_eval(&comdatum->permissions.table, "common_permissions", key);
 
 	rc = symtab_insert(s, key, comdatum);
@@ -1339,7 +1365,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1367,6 +1393,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (cladatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1401,11 +1431,22 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &cladatum->permissions, fp);
+		rc = perm_read(p, &cladatum->permissions, fp, &claimed);
 		if (rc)
 			goto bad;
 	}
 
+	/* the class's own permissions must claim the slots the common leaves */
+	if (cladatum->comdatum)
+		inherited = cladatum->comdatum->permissions.nprim;
+	rc = -EINVAL;
+	if (claimed != (perm_claimed_mask(cladatum->permissions.nprim) &
+			~perm_claimed_mask(inherited))) {
+		pr_err("SELinux:  class %s does not define every permission it declares\n",
+		       key);
+		goto bad;
+	}
+
 	hash_eval(&cladatum->permissions.table, "class_permissions", key);
 
 	rc = read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
-- 
2.30.2

