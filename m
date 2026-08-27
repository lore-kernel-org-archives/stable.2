Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61F314D34
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819963; cv=none; b=Rnny6m7SMEdcY5naIyi+0W/xiVlRUKABX3weKcSZTMgvmEuVTiBrdYpPL0RRVA+/4XNMtOJhJo8W4zI2x81qWTxseV+YAenXJd3+WdgFD+4h6vV9xlNUcz762nMDVRxibQheEtTkkPw+l61vWXBF+E23UE7serXF4Ixay2Gl3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819963; c=relaxed/simple;
	bh=F23SEiDMCKcjoI2aXeggiKB8pZd9OpM/I4tP2asSIwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cj6E7g45zqqlzL9EZ6wuqrUORMl9WzG0KgxuGP9qaNhAd08gqjB4q9LT20XDy3f6D/Lxho3izspHo4wPdbjfQAaPi3YNif7bTgFMF59yiJGSMElrENf6e56VHaGX4CMqxTsWtiHuXCzwBqK5GkbTNLlT/PMlGhJBU42LggYc0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lgm3Jsqf; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lgm3Jsqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787819924;
	bh=RPlgr+2xrRr91MIhAlfGw9G9RVvGoSL/lKr2pVFxb4s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lgm3JsqfiFyL0UpffT6naSkN4JNsjHrzCtbBM9oCtDm3qQahaGbwWJOd+Xpyk6cyn
	 OdUqbx1AEpmw3BTtt2d1WX49H3optEnEpK9aqbJVGJOYgeJJ59cVuj/h3snEZDo3qv
	 KKN4gbnT+IW9+C2gEqtA3qgb5kkCp7g0qiHWfrVg=
X-QQ-mid: zesmtpsz5t1787819919t8c7cc3fb
X-QQ-Originating-IP: Pbl4DUmoMwLDAIml0z46v7UcIOxxlyyVFx5yzYvWf9Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:38:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12930995573166101192
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's permission values to cover its permission count"
Date: Thu, 27 Aug 2026 16:37:55 +0800
Message-Id: <20260827083802.4044165-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: OddG9bJrw+wO6nKwIB76sI9FWzZjlQrDuW7DLzXZn/QKOBOHCKUq+/5l
	qcNjg0AJL0zGe7Mary808eJpY4KjetsjBv7WJZ3ilVT2OQBGa9/3olSsNbGNNg1wLgyzLNI
	pj1DAj0zBmIKLYBYlKSwdMCeiMTLXHrne231HLHdoGQ/PyBhYRzg9zs3dsZ36he7lGi83A7
	8lVfKQtU4iSlIWPTl71jYatCtpvD1v1IAcuJc6g5KdPhQxOfW4KT8GI2kUkProqX40B3956
	HJzkJEEc2poRQH/Rz74UN6Kg0jJkZq3zGiitDiSthebwK3KPQ756oLj9hm5L1a5+Ue2dsyq
	R9Z+FzVPV9Er1H5O7FQRtKBuGKVUybAsQYTJqYsfN4RngM2AoQ0s4MOMwVM8LBypyUwEXQ1
	LtycYW31odjgauKJIiQEfIQK/TRHtAbN7IrUoJKrYdY9OYAv+P/RVflQg/6ZOJbSiVR9hGV
	2/ThwGzoZIJfqYY0mpWnMrnoVwhwOLO96aobtnCQukxD8etYJAFajXY1d/DR9btmEcMy2GA
	XX73XsKreGuBjz2Tq0RJz36lchXf7LO7BsFclpuPxfgoZfEeVvRDSAbLYtSjjlFNfL6ocSV
	drYow7Qy61yMrCkS4k0Faq3uMf8gQAgsw4q0EWMy0OI+AMz1zuuXeOjIpW0B4rRBRK4/6oN
	7OOE3R7kms8mtFTJZk5dt2a0VQVFWaUdvEGpriQlT01gXOIncGZlzuTyXfwI1Giep+j57FE
	/TphoHJH0UyJGTZmOrgZnaxgS0Z0Ma00rHKStpKB1OXPoOGUVwLYT0x274NXtfkXtQj9Vff
	P5fO1ZSa+oof5BZOAcugtSWpA4TTFJ0E6VLcc6diFiu82vDxQBgeu/d/R1VjcHDF6wpsMSM
	9M6m7l9g4HFJi8wfcs7UFNZpqk+FGtr8yfF7gHnRc446eqEg6747o8vL0I7S3Rzcd9Xvzc4
	5hx4CSN/xRq55ugyFBiXMkkvksXGfCQQO0ed10zrX83dX0xqZyDHmF6yC9h1cwFx5BGSc+K
	4IP0zPXkVoPxAZSSgBXkHPRScWM4eMnX8E5F20Rt/d2vEmIAyVw8MvBnAJ4/pLeJua5xwEC
	w==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This reverts commit b6336a9b52baa35136f024ab30929fdda83b3160.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 51 ++++------------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ef7f767a682b3..fac3b61bfa202 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1139,18 +1139,7 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	return 0;
 }
 
-/*
- * Bitmap of the permission values a symtab has claimed.  Values are 1-based
- * and bounded by SEL_VEC_MAX, the width of an access vector, so the whole set
- * fits in a u32 and the callers reject an nprim past that width.
- */
-static u32 perm_claimed_mask(u32 nprim)
-{
-	return nprim ? U32_MAX >> (SEL_VEC_MAX - nprim) : 0;
-}
-
-static int perm_read(struct policydb *p, struct symtab *s,
-		     struct policy_file *fp, u32 *claimed)
+static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1182,10 +1171,6 @@ static int perm_read(struct policydb *p, struct symtab *s,
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
-	/* two permissions cannot share one slot of that array */
-	if (*claimed & (1U << (perdatum->value - 1)))
-		goto bad;
-	*claimed |= 1U << (perdatum->value - 1);
 
 	return 0;
 bad:
@@ -1198,7 +1183,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel, claimed = 0;
+	u32 i, len, nel;
 	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -1220,28 +1205,17 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	if (rc)
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
-	/* no permission value can reach a slot past SEL_VEC_MAX */
-	rc = -EINVAL;
-	if (comdatum->permissions.nprim > SEL_VEC_MAX)
-		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &comdatum->permissions, fp, &claimed);
+		rc = perm_read(p, &comdatum->permissions, fp);
 		if (rc)
 			goto bad;
 	}
 
-	rc = -EINVAL;
-	if (claimed != perm_claimed_mask(comdatum->permissions.nprim)) {
-		pr_err("SELinux:  common %s does not define every permission it declares\n",
-		       key);
-		goto bad;
-	}
-
 	hash_eval(&comdatum->permissions.table, "common_permissions", key);
 
 	rc = symtab_insert(s, key, comdatum);
@@ -1377,7 +1351,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
+	u32 i, len, len2, ncons, nel, val;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1405,10 +1379,6 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
-	/* no permission value can reach a slot past SEL_VEC_MAX */
-	rc = -EINVAL;
-	if (cladatum->permissions.nprim > SEL_VEC_MAX)
-		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1443,22 +1413,11 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &cladatum->permissions, fp, &claimed);
+		rc = perm_read(p, &cladatum->permissions, fp);
 		if (rc)
 			goto bad;
 	}
 
-	/* the class's own permissions must claim the slots the common leaves */
-	if (cladatum->comdatum)
-		inherited = cladatum->comdatum->permissions.nprim;
-	rc = -EINVAL;
-	if (claimed != (perm_claimed_mask(cladatum->permissions.nprim) &
-			~perm_claimed_mask(inherited))) {
-		pr_err("SELinux:  class %s does not define every permission it declares\n",
-		       key);
-		goto bad;
-	}
-
 	hash_eval(&cladatum->permissions.table, "class_permissions", key);
 
 	rc = read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
-- 
2.30.2

