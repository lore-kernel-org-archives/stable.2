Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8E4C77B3
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853203; cv=none; b=L97A2bDZqLYS4i251M9RUdhTIj7/YseNxL4Zt5NUDppxCihKM1m2ElHju/5ZVqGbVRjYN/zRH3n1sxlHzELgRBl4lRRgx+PqNyRIiyscb+RbLF2WFbao7b9iN3Mq0S8TPvplIPJfgkzT8mT226fJtROcOjGOkYdueCh1SRKXoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853203; c=relaxed/simple;
	bh=L73A1obTdwPvsPP37q3AQHjNQmXMuDsLiFRzMLTgjXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOPJbZ9X/i6ql14O4ciKQW7jCK5Uy54d89836eIJ0Pp0RqqI3mn6ubSGrZkYDF4aSgj2hylBAyomPCQ/iXrf8gcJ2IoYM41SqW2iQMSr5sByfpyp6PsdA2Iut2P/TarB8DmIG7CXxs4ap5mcsSc4dZu1N9ivU7JAhb+NlIf1n2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NMhT67Am; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NMhT67Am"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853145;
	bh=PusA1F9qIhvKe8XHZzM/0JEA89tfLCetQRcLLFkbggg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NMhT67AmffT/fLjyFN0VOMrFZ/D3BoIOQcTXk2Q4MwbWeBiXSq+Ucjm6/sOL5uktF
	 qhYnzvCv+SaF2UfqnzAmmuRVD4IMrJuOsCCZgh+rcjOR1qkPVpGuAgDF0X04vhfW4v
	 UJlXymQC57OMuGSQlccXWgzLMC5yl8eyaPiHcQR4=
X-QQ-mid: esmtpgz15t1787853140t9d963845
X-QQ-Originating-IP: 7B8VFWmP9LlYQulC+MXV/4enU6KxwHRJzsuunstACwg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 01:52:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14929030972212066061
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
Subject: [PATCH 7.1.y 2/5] selinux: use u16 for security classes
Date: Fri, 28 Aug 2026 01:51:43 +0800
Message-Id: <20260827175144.4174620-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827175144.4174620-1-guanwentao@uniontech.com>
References: <20260827175144.4174620-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MIXpHopat2Ia1fxDhmj2ewUz2kh0KCICec1PNM/E6D8dq0LUejPybNEa
	3sR3KHAmoXRiCrirjUEG+bvae0riutuUA8rfkl7fQoknFnDDlvJnc5RWJQISgNVP7UK7Kcx
	Qwm6QvQ4hwMjl2/YGzcDRH0CgrG3eLx79H32Ow5xOAq5YgpskMdtId6ce4Ouk4MFF9g/7en
	Gpb0tkYnoUlDaelVjAUyLhwKyc8LGKsM7L92RbpOWQ/bEJWrEmpjU1/3j+d5fYbLtJpyHti
	f9oGq/NbEiyywO4Tm4wQZzfrMJemiDLuNjOQQ/6YL6yASy1xJBgeRTLw4CFaIEXQ1EBgZBQ
	HXo/mk6UcFwBCejCnLa1lOzUTCQTxLfLFJ2BwCpZI+Lci09eSGwJRNzAY/FI4F+CGnc5M71
	+2NrTWVv8eLmB86KHpVeSJMXABwe7/WZOHBy5mff+ZqKcaet8oTALkWPsZqNlGt5jUw6+S5
	MJHJjdTCaNhPDcp+WTuvRwK4ptlA124XpAPmQMlMSDuPVboLHC/192NVBKejlHZ/TBIWR70
	jMAZIBRXRW7HVTdky3VwhWtRZzxvpvxXiAnHpguY2r6FjjuScaz4FLCbPZSMddxw2QYXpkH
	QRO6SCU4j0aYXEYRHDQ21a229rIbnBRkmW3sU9Y1R9/X5OtVXZtapCm32il9ppUPayXuD4w
	WYO1oblWHu0C6EHbP2BLEMIHjRzcQhah04qm1EpELMlC3H9NHPPz2wrIWMa9NHBRjmDYdip
	G7ro2LL1W1x6nSq+Q0zrUkljLPYMdqfUxPGHbuLjmF/0qiiACBBxDXYEW7u3yuvvRbB8fy1
	y2yUKkGTKHLQV+fvSFK0NJEfXAWPhLpWF1EopTAY1/mojzyUkU82j68DenrIu9p5VieNZ9c
	GxBS9qz2F631yUa1T7+lGVjJSckg/DDr/e0872zRKOm20DiHz4VssfO4EZTS8qCD9ZkW7+/
	NRXBU6RN8XjqB1yiUl5kpan7OSheRRlZe0jbmJ2+xs3yLHjvBW3gakvMzSS5cJa3UkxzNDu
	rqX3LMxP0HUj5y9pZdpMUkSGEvtGTnNgvPjr8XWocfNS50BStpzmj2EmBvw2cUdLSozMCRi
	D0wfvT4/qkB
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
index b788916f5ed07..d36c34cdb5d98 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -950,7 +950,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -2036,7 +2036,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, tclass, ndatum, i;
+	u32 len, ttype, ndatum, i;
+	u16 tclass;
 	__le32 buf[3];
 	int rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 89a180b1742fb..a49275d1168d8 100644
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
@@ -322,7 +322,7 @@ struct policy_file {
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
-extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
+extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a0ccf73a65ddc..e48e5204f8a1c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3290,7 +3290,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u32 value = datum->value - 1;
+	u16 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.30.2

