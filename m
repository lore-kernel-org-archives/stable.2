Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E41FC0
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854106; cv=none; b=C3liTCtfJeZ1tcSSGAhrLGNL1SyGNX97dYYV2KlD6o4bbCyC0u3/vEPxNOyzQYWwmKfAjdvgZ6nGg+l3R3b0Jy/iGq/hHAXt7rabgfEokUFZvOeoSAAhDnjWNkb923FkXD3A24aNUFROYBpdjlRyhyEUgn1z98Mp8PO6E/bJyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854106; c=relaxed/simple;
	bh=9kIvFghEcFfXTkbF1WNY/VJMZUTJ0xIkLY62JxBFXHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GE3PrBXAFKEMBTO33DDQkpUisGS05Xo4c3CQaPfeoy7huvHNmhssPF8zTDpGKqniBts2UgTmJpsxo/17ozahNurpbe0Pixdc60ZNvlhVHK0NC87RUl+S9WXHm+YCds10AU/rNuHrtNkmjaWn1effv3rdaE91uAzN4y8+PouIkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MkOTROfE; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MkOTROfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787854061;
	bh=eVDBEU9oSJsjPFTxry7jteJuPXySjoLrYjwG8ovYT/E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MkOTROfExikLlHcD5Tp5BYDPLrUlZQhNTu84L7/I+FzXBh59hm1DJRdtMbGqPx8jv
	 Lzq+crhXS0MmNPPOeBaOVyQALnW7SKxztQgGu64CvFgURVNORFYwfyDX6dfhkjDdUo
	 1xu8hI1HKd8/316xbIlIa/cMZftacrHBSjYvdZcQ=
X-QQ-mid: zesmtpsz9t1787854043taa12144c
X-QQ-Originating-IP: IdbU3m+/0jqhD8fJxNfvCT0v3548nD5XHaf6u0aZf1Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 02:07:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13738423503782069906
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6.18.y v2 5/5] selinux: require a class's permission values to cover its permission count
Date: Fri, 28 Aug 2026 02:06:10 +0800
Message-Id: <20260827180605.4187309-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827180605.4187309-1-guanwentao@uniontech.com>
References: <20260827180605.4187309-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MjR8AxUJ99Q7yqcAqu/RVs1o/uCFa+APBnct9jjZZXvMTcceDLWPxPak
	ap0wz5rTUKZ4jpCjeMfXwW666XUERaqXxOIg1ecpectFQrGaQ3LZsFTYjqgQrNVYaZP6RiP
	Zsk+fvqAqEaU5Vg71CnPMX27I3OVcrbUPheSwqYFxSp7jzq+LOCs9oF7iILLb396k5nv5dD
	/wgW0+fur+ozj/UeQPAhQTxBnlyfQHQHlZpO11jKbMrbTtnSrADqDfJJ2EnKRu3oLR4faBF
	kS+qPgNoOdkStC4DYSpnWOXE2AqlbGzzQBJWOn5Lj6lc8kr6DLJ3Hq0/yECZVbe+2pUINQN
	+Efz3W/dIAFl3HqCEW0po+BJNNLDvR5ve9qkFPvvZWOTN4lFVqC2lLYAKCbgBX+1A2W3pV7
	YPO5kxq/QUQcSoHODlEAkr+6lfMiPbE0mTQG5WfnGOzDqagsoBWeUbapEhsxFQVGbLhCaU/
	xRerGmpmqyuB0T2UaZkNSkkv9gRxsbYGm5BSt9OOIEDAVqsN7EJPJfuaaQnju/ICwq2C8cI
	L5lrZyHCikeAWsINPPWFt4erwCPU1m8OEgyCwjC0Aw8vLkA6f/67lZ8x0j5WDq1nOopPUGZ
	Wyj8S9bxBNG7Hr3cHLDhw9CdzBoRX7eCJbKbodfKnFGqzIgtL5Z/X0SHah5sTYPM6HAJ9++
	y0mZbcUnnSWob+OsBS771N3jk2Jnn1IMbkzu/SyMK/n0xmJkjwF9XUlXLQIg+WXXkn0Vsb9
	7VIl7Vj6wc8jyx6L2qySpZpmQo4ZOKw75/WpKED4jtZrdd19RjJl0g0ZIbdmCewjYztXDuj
	1lt83co/a79RdFodd5d8wBvOKWeGsfB6+ZlnBn1p6QuwvQZOm29Aw5wWSRyMdz7rGSMrYYk
	ELK6cd7pjYDGGwTsbaJZ1TMLAuisT6J5dKVlCXolK7HgCYuHoso4seLCkBvNNh9A+Dwv/f8
	ox/Ij34L5qqXKHs6zRM5UnHEiQUV3VeMeiTXnQqKa4k3F9Sge3PxboJESdQmLBePvyni85S
	ckM3fdKGSLCzPFtA+WvjGIeU5WR/2SL9qyx0dKGehKKoVxvOjSL3NuY4pexkeAV9c4df6lW
	+0jSB1l5+PcOXe/2hamRcJzLdhyu/ar/aE8bNAWm8Qcj1zTqsBaz57z9gJary2A2eafjlUO
	I9qtjjZLiwxlG0UVXY8ecET+6q6teouF8re8
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
index 926dae3731a0d..483d7d54642a3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1139,7 +1139,18 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
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
@@ -1163,6 +1174,10 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
+	/* two permissions cannot share one slot of that array */
+	if (*claimed & (1U << (perdatum->value - 1)))
+		goto bad;
+	*claimed |= 1U << (perdatum->value - 1);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1183,7 +1198,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel;
+	u32 i, len, nel, claimed = 0;
 	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -1205,17 +1220,28 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
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
@@ -1351,7 +1377,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1379,6 +1405,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (cladatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1413,11 +1443,22 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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

