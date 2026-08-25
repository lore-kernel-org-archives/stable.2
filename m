Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6F3F328F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652342; cv=none; b=tUWGV6Wcrc8Cy0NeiQUeGPijVIaPmHDOiEP7k+pl7I40AkWGOOW4cCYn5bjG2puz87neBXub3/a83xOjmarh+IlPN8AmDRfRgSjF6ClWEMZnstLOWXc+Vj4FQSryEYriu8zwkynFrffT7obGOtT4cSeNoW2e1RskPc6nFDWUek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652342; c=relaxed/simple;
	bh=9kIvFghEcFfXTkbF1WNY/VJMZUTJ0xIkLY62JxBFXHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtW/mziPTe/fkoFat20kz56yRLopVTkMzlozFSPY2U0bsAjSIYBnRj4//0Ev2J2WotNRuXE7Yup5QYklUB2U/C27yjl0FOfaBsHEbTscqDzUH797i7uM5cr4i8hoSnVdkuWdyEWwO/YtpTcCZTA7DFnkwDPvdJqX9swSbDEb4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=brYggHlA; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="brYggHlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652305;
	bh=eVDBEU9oSJsjPFTxry7jteJuPXySjoLrYjwG8ovYT/E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=brYggHlAz8pZyllRo64kKaLqPlZzPusT0BvdygKpBk2bYHo6yTgJWagXqdt++vkx8
	 yIgbFgChcbqMQyg8I9nDw1lcF/GnsiodJSL0jXK5syyObM42TW8S3kJt3Nx6wJrbuB
	 a0uQ5dlaykiQUzRMRinaudGHPTSK0gBYBXbJnN0E=
X-QQ-mid: esmtpgz12t1787652300t5d7fac6c
X-QQ-Originating-IP: x5pwLDhiROb5yJwAFnmIH4ylWUboSsMPZ8ughKYhPAI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:04:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16797180943558310592
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 7/7] selinux: require a class's permission values to cover its permission count
Date: Tue, 25 Aug 2026 18:03:45 +0800
Message-Id: <20260825100338.4039846-7-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260824220022.435960-3-sashal@kernel.org>
References: <20260824220022.435960-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OBfOdZ/atxB3kJUz33hf/jBrb7+Wb1+VcaOae4X+ad2QnkSrk8LcUxVz
	UF2drf0FDaXS6gQh3wD/6OrsVNDxnQ1BXL1Ja/cW/78jnXjnIuZBSep2nZ52w1jXREHeOD/
	J2S+O+es12n787VgKJCPmYALvMq+u+5Svzk0wO2gGYckdF5LuE8lGMMbRtF+C0R77j74TyY
	+cpH2i9nC6lwTSJgmLub5X2OSih/hH9Md2rVpH0/RWiWIh2Jtpl0lb0vhJ446YL5Vn6llfD
	lT9nJaJAxP4Zlt/HRF2TK5FMqFw4TzcupGdPOfQrLyHNUlVi4kd6+00p5Lw0ctAANRp7Ftd
	wER6Q2rK7qJNtgm0NIlFOPJXVX6SBCdISY/Uee8vW6wSQgYJfjoAbwIDSC7VZYWzwq8fKql
	4R4WXO2m5NKWEQYiIXW5Wf7Y11qX+4ek8OagUJIeX38olAASkeSpdGeVoSbqBESc+CvTJdd
	ccd40eSjBuAV5lqdCtIV8iGqV431dtcuW/tFdSBzIZRzuzt0zkHSA+RA+BPre7DP5n6TqID
	WSnfp8gNfvzuIaEjnsx8+8tEpPeCV4FoDG6wnSESCxg9E7m4gGt1GpYJcpeq77agL5KSEdc
	hmOPioq4YOYHFSaoevJLOzs+oScN9ilz/udfnV1Gj3rA4XlNgKx3IA6ACMeFwRNAC940Jfi
	GhiFXNchAws1FUJCwOI0boIzZayir+f5iq0kJKPnF6kzDLNcNZiSJMZ3E1dLaSgrVKGdj03
	0/yoFY24z0CMo5xNkES1TOxu6qn77f4omZKsWwByfgj9bMXOnkYK9I/zT6SCARnWm8Ix9fj
	UVxQJ1LXwg5RwoINMuoXPoD3wnu65BplWNYafftpkZhZm8usFVFhMA6cdjONbtefuU1/NPY
	Id5rIT9vszBkkIq4EgnswYPajG6eVCMxeEfDiXpY+uinBjviHPQ91SqLTbTs3YzhlZUJJFK
	ygxbHqPphXCKSxsmDPwEiqmzGHt1lvjugqb+nxspacR3/6B8SoNDwmGmWu3PFGdkg5AE70H
	S6SGquPJXDG7xVKf7c/mXtTh8ahJnrAKbLI0iTAVZWLetLZN7MCT+6Y1HJEdo9AVMIVJXTV
	MUou5tyVB9d/82CZbf7ok8GAuDOLzF3X/pwBgc/NHcsw05S+mql0JPVvkI9zPsPL0QtTD0S
	n+kJgzH1YoLO9zQ=
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

