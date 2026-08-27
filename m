Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA8437136
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858100; cv=none; b=TJGSrRzjcwpB5pbIVUvYGrOofpH4YegKB5toyqdbtzdi3My5rDJNZ7upua09z9tDC/mcKGhk9zFjxaleTdgk3ODNYmuq4mtVXxh+lp7gShAN3U84yfRzyYWaGPe+yIFBOq7sZgDlZDVmCcnzpzFMomrwOXBfzhne7ktxqKHw06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858100; c=relaxed/simple;
	bh=K9UGSb4UhvgiNMjuEHhCG8cpkK7tPeMfPKXmXoQ7ENc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=es9jkl5WousIK0DrSK88Fq+01FxJ5WDMXz8K6qAbkgLQ5r/Z8mDtlDjdwEzPAYKAkDpXN/zvYBdChIyWvzYkFjRedlL6cFicuEU3OsFNQCYgXfporEJfOVe1E6L/ZYiW1CPLPCAhIaHF/pMNAv+uojq5qRyxMrDC7wtqeCkQnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZzYQ3EXM; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZzYQ3EXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858061;
	bh=0Nf9ID9mmSKbTwAPZN8Jg2jxLiHEuA33lfOlawckCZc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZzYQ3EXMvJnW/YeAt60YeSP8A9os7VXLVCfGQFgXlCQjq9q+Nfcnbk4MeqVrSgR4f
	 7hv6yYeD9rSDjm2nDOcer90H9LYtseNjurhAeWpP2FrlrLA+II4GXAiBOlsKPCSfHc
	 oSt4RRPqIClISXaw/RUyvctiSHfANSvssFMND2n4=
X-QQ-mid: esmtpgz15t1787858055t26524009
X-QQ-Originating-IP: kHCnb+5jpOSakwKv/0gXEZ/a8sPSQm8Q7CCkvioFPos=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:14:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11474431422798365426
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6.12.y 4/7] selinux: use u16 for security classes
Date: Fri, 28 Aug 2026 03:13:18 +0800
Message-Id: <20260827191317.18119-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827191317.18119-1-guanwentao@uniontech.com>
References: <20260827191317.18119-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NtXDDztI2UxXq14uTaSBB2y6fSOHP+yVAd1oRsQmLGPH8jRP2ZMoZVvu
	M4wv7W61Mz5jBHOm7xvT000hBtpsAFw6zYHSRs+6oz//uEx0TQyX65+1n1RTQn1c5L5bN6X
	ViPkBECqKFmN+MfM6SFG7hzS/fQtzgCE/A4GG73Dl3/HHf8ZlPDNZpB3k/jeY3cqI7iR6RV
	JKUX1iQfxy4l95nGIP+vM1UFbo4JOqau0VXaRaa5NhnZOZD1JQ0+KvnBdC6KJeQjZ5dZ1qn
	0vquTMryLFmZmahPhvRotuyinRFxvO3mgLSrrsEH1FOFzdr8lh353AYeMshxJEYroJi/GoQ
	BPaqu77YbQDvGwCYFoX2gCqFKODLkMQUhDJ622CdH8uUMv2XEAZVOEykIfpJUoH/RwwME+k
	7ATXH+CTOxi0vDq3Z25d73dRwzMpgXhYbCHWz4kc/GSdi3kYmeqZtjM12daM4GzGWUxhCKx
	V/AEH/IBkkDKfkzFwy4kL/APNXBbUkrzsG6/Y8LQMkYIV0l6KK87eK2oSUntWeZVU3yLVTS
	y2807+E9t2wktydsdrjUpkgjrXOSkwb6RQ86twt5h9pK8iZbB+5NAqNP2BJoj5fshCjgCZP
	1wKFusnDHTPUzaRyxGLEinoTX5nTcnhcrV4tDGvrFeGdXZ4YVWCtZ9uoREOwvPFDlyikcSO
	KoUckmcTGiCurOgQmpipcWoRUuzN/sCpG6KnrpdvHViCN4cVbSvCVcQ9GI+rHVE0YriCvEb
	NxIP0fCP64wbT6bvh6820AmTYaOyGWVnmJy9vNZVxG/MrAHor9aYxcDglcwyCmgm9dMdmZQ
	bak88z99kNW4t8Znd8XOU5fG9WHw4GslUlTufB8SSJ4I/Ua5v2Cx0zU57FuvHZl+pPy+eqV
	tu8WrhAn4+PFdm4T5IL0AL2iLSWN1Oya0TC+BQ6MvmwTSUL+N0dSZAMns7Uz9Zjfi3YrPsm
	tEA0D9shC+8piDIjgujLmYdak5MJp0AkHOXyXX7771SFIu+cc1PaAjvvEpAkP3MMyex7/dx
	r5cAbymiHJHCYDGY2hOeRlJH6a+7mwHQXNw9g9pYuR3ivgb9l9FPKr8g/HqBfJu/kRjpYmm
	OJM7l4iXUvc8w2oxvUgq1GSHDVxWLOgYvbRQTSh+Ig3B5l0n00ShkoUmjNgKLge1WAKfMeO
	kNcPfy0mHUV2y2Y=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Christian Göttsche <cgzones@googlemail.com>

Security class identifiers are limited to 2^16, thus use the appropriate
type u16 consistently.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit fa79a596848fe38c55ccab8832ac35dac07fb00c)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c |  5 +++--
 security/selinux/ss/policydb.h | 10 +++++-----
 security/selinux/ss/services.c |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index db200b7518fc7..6271e083c9400 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -939,7 +939,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -2027,7 +2027,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, tclass, ndatum, i;
+	u32 len, ttype, ndatum, i;
+	u16 tclass;
 	__le32 buf[3];
 	int rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index d95a3941f327c..06df7da747791 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -48,7 +48,7 @@ struct common_datum {
 
 /* Class attributes */
 struct class_datum {
-	u32 value; /* class value */
+	u16 value; /* class value */
 	char *comkey; /* common name */
 	struct common_datum *comdatum; /* common datum */
 	struct symtab permissions; /* class-specific permission symbol table */
@@ -82,7 +82,7 @@ struct role_datum {
 struct role_trans_key {
 	u32 role; /* current role */
 	u32 type; /* program executable type, or new object type */
-	u32 tclass; /* process class, or new object class */
+	u16 tclass; /* process class, or new object class */
 };
 
 struct role_trans_datum {
@@ -139,7 +139,7 @@ struct cat_datum {
 struct range_trans {
 	u32 source_type;
 	u32 target_type;
-	u32 target_class;
+	u16 target_class;
 };
 
 /* Boolean data type */
@@ -195,7 +195,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u32 sclass; /* security class for genfs */
+		u16 sclass; /* security class for genfs */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
@@ -320,7 +320,7 @@ struct policy_file {
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
-extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
+extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1a883471d5383..8b3c804d231ea 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3354,7 +3354,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u32 value = datum->value - 1;
+	u16 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.30.2

