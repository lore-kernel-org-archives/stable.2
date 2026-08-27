Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDF1A5B8A
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809739; cv=none; b=Bcyfs19tBULJj7iEK5LBlnZH6IIRjsIHEo5eHbwVirJ4/vtYANPyfdUP/F28Gayd/DjW8R2eMzc7Lhgn6ng1zHa91qC28lE80wjxOu5CN+mr4rk/Rb8Cu25BrWPUrytLNRdGHJnK3dvsgvJbBKNmym0rFE5OW4wpGGgBgpLNCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809739; c=relaxed/simple;
	bh=kvwPaPnP88YB+KZOm6tFDAl1zLi/dv5DtxnsSbDph8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StKKStNg5iW8+EjK0bEol8mIYxQI0iw8/zLSPbcZwJ7saZg3X4zj6z12dK5TpMs1smYI4NcMzXPgAj81t3o70FS5F6BsxsXqWQBRU03yZfF0jPsg9AJ17WKwpgwtedxfOMGUVwVPFXGq5R7i3b4Tya15GpVoBI1Q85vJGtruoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jQslLnIv; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jQslLnIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787809699;
	bh=rrbVPI6A7xhz3aIN3233wbYX52UlMYFFd3xSIOjDMqw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jQslLnIvnl9gqqv6G0kokpk1Yu8KJXaY7UYyvX+wdP6zpJfzI9d55viJCKHuDWE9y
	 3wPKpV7q7ozTb9/wWQm6fH2eBISz4S1eFDYJX4n6fn9Jup94f6jRBs/aWiDij7Fn71
	 M+OFsIY7wEU8FNHozes6TcWELQidIXk7ZMF/slh0=
X-QQ-mid: esmtpgz13t1787809694t81cd4919
X-QQ-Originating-IP: d+YySLhmR9hVwdZGL/g8aHUfKDymkHuPbtw6VjCFgmM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 13:48:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18187850542018286572
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 7.1.y 5/5] selinux: require a class's permission values to cover its permission count
Date: Thu, 27 Aug 2026 13:47:14 +0800
Message-Id: <20260827054709.4027356-5-guanwentao@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OcIiaahx2ZjK1qTsDT0OBJ1H7bNyVBIULb+P43FPrypQlY8kS3HBRi0Q
	k3TDCKqHFaPDP8d5obZrDNYXMZSe+OJIbSH+38zYak0APHBx84+2OCx+WrwOq0nwevPyCKL
	T/7WfBQV84ev3NHHyxifZtfN/qeYTYEdrOtjM5GuUj47hY9Cv5gsXqZt1AcCjoOuqb60MoY
	ZXX+iGy8jHEnykhuzzCRnR7NyrgBmFQ+qFL/rhYuWCNQj7WKPgeQYJ1Yc2fOd4C9JicNqeP
	pSyT0dyaesQbvT4+rPw/7pUh8QlztOzMwUoXncvd1di3p//N7ZsRTQeNcamlyfBgslvgU4a
	9OLbjrMrbYZFoUnNrWEPL65sHqDrmx2q05xzy6RrlTSQxxLSrR9W65O4yzIxxy8U+/No27b
	ntr7QCv6LmUvkKAmOXSq1tfSmcQTZj8BvtV4rXvMHuNKbTMMNeHu1Fr6ogNVIvuwURM2E5S
	TaBW0e24VstyDNlNq2zmm447aqQPLWYvfg4nGImyiLOzFv/6HaUqR1spIop60567iMXhVDW
	0d05SA0j659DlX5mjk8kvMmjEg3OuyUCii6jj0Se1x/bBZJkVw97Tvhu9H0mjs0uE1+8PjF
	JXrlBGMvV6De5VDJsafpcUyEkao1lvYE5gPVTiMr7g1LOiJL3R10HwQ5e49bh3a4UJ3U+bE
	k23aTqSX5YvEcJKbrtu7n/xd7KAIpm1x1yaTisNDHHdTdEzejliA49+x5OQX9UOU+SoF7xw
	eJ9jEISY8gBEyhMPFu4FB4jg5LvlzkQnVJR89k9AVLtFTYYAUeZO4hrpepyw8OK41YDNJ90
	acgQzmgX713k2bzY4vB/AXnd6iAXAjJRMdxAhbwyKooC3RPV0245qiKFWGNsDP3tz1JpUbv
	zbwvqCIY79XH3CRC7AT3+MsQZV2dM++XCnNmhB7Vvx2PhIlaDPidZe0Ta7W+5YCSLDWL5Rs
	Lyqs8d9SHrDcdTofu0+GATh0kNIfCR6SICYIQ0aGhuWsho734DDFenu4DXHUjbhsTjpYmSh
	UWeu/zUd/1Qzl6oimVtpZnA0LzHjyN2c8KKVJW2GvQRmV64KiD9jYdAcKd7Fn38ynGuByKN
	tqAjsetnnISp2lndNvPAthT6Fqsk2JZVpgJOLWIC5Ef
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index 6f085f4307bf2..0867c0af1d6a7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1119,7 +1119,18 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
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
@@ -1143,6 +1154,10 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
+	/* two permissions cannot share one slot of that array */
+	if (*claimed & (1U << (perdatum->value - 1)))
+		goto bad;
+	*claimed |= 1U << (perdatum->value - 1);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1163,7 +1178,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel;
+	u32 i, len, nel, claimed = 0;
 	int rc;
 
 	comdatum = kzalloc_obj(*comdatum);
@@ -1185,17 +1200,28 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
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
@@ -1329,7 +1355,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
 	int rc;
 
 	cladatum = kzalloc_obj(*cladatum);
@@ -1357,6 +1383,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (cladatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1391,11 +1421,22 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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

