Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859733B2FD6
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854062; cv=none; b=RwQRXzFx2TWI47V08lsED4POkWI025E9JFt4N0yZ6u8nM36EbhNp6IkLudZNmXN6LA4uO/AHc1eSgar/cY3XSxCSskurqz+wbTS6S0jNWoB1kU55YaDkGNIzqribyxg8lQF2emN3cWHbsg/0QZRXJr6/61WrpS0aH+pxdDTARzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854062; c=relaxed/simple;
	bh=faBKhLJMekMZCSd8bS0XTebdD0iZZEd6IQ6c0H2bj/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=og/WRnThPmsX/j5juBSNNqzdXPwLr8veGSv7CrW8/5uaSrdDcrWBTbwAWyZDWrkixGUN4jDjIbvO0WscmiAI7OO1fvWHrTm1K5X9JKYxeTsE9oeJMGY4mHGICKYjyfbxocowsQvCP5PQ3xMJA0qK4AfaBpTtu19GQRIF7u6dzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ndHpFEu6; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ndHpFEu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787854006;
	bh=KoERXHsYf3o62AzokzJgSi6/ZTBuFSwRa0N+VBbrWrY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ndHpFEu6LpB2iIRL/K/v8uy4djdiRypiVqcJsj2k/bXdDe2OTL8FZHeMDxi81rH5U
	 hpOv6x1dd1dMdzGrFoYzex1weNZmRWNd04TxQQPaFKux/XLcf5rjws55f81oQa0UUy
	 AlHMNYt67b5bZLk4LIK1AU3djG3yh4RiJbvmuB+g=
X-QQ-mid: zesmtpsz9t1787854001t19ab6ffa
X-QQ-Originating-IP: 3g+EL5ebZ7oiKIqvr1oRkDA66UpM1bkrJkjQQXmgKjA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 02:06:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6494707675070323830
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
Subject: [PATCH 6.18.y v2 2/5] selinux: use u16 for security classes
Date: Fri, 28 Aug 2026 02:06:04 +0800
Message-Id: <20260827180605.4187309-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827180605.4187309-1-guanwentao@uniontech.com>
References: <20260827180605.4187309-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NTuwEH/sZrTsNZgOMsDvPvdl9ntxbDP2FdZFFkW5n9tZG2BmctBpHrxo
	drrq+kYksINiU7E9lauiiTwBbWNo893mJnH1ZRSv3RabFe2USCKuVHfriFrAoq+0R61aHPy
	FGgcHpibgO1kPBPCfvSEKm1T3IR6fNp2ftMNnc6iMQyua7WLOWyR2oSape4UZJ5JluHYsBE
	sJUIJUBvZ9Mm5UvEtMo1Z9RHOAh1Vdq8NkUYYLphbhQrztG3rkvTXhgWEu78LY5Hobrh4S3
	Jz9B9ZtWnbBJPZcCGICcXEXbBAuxqbkast3f5qPLDorSvqnR/gcMHo/wugFXrbDjaI1zYcM
	UCAtde+6dPO+UNTqVFb+Wirkd2lHBVwiXYqwn8/0ducpVytOWKk8SsFLFnL3xccp25FyhGI
	9lncfoEBzluzllgLw4N2HIfwBZhFw7fqtVkw7eyV5wb3gOHwHA6X79JJhXJmZquASR4QohK
	SD9Vu8BUVsL6XMGpht7Yvq3XtRJCCdlfl5y+hs5P6AjVvXsb0SRU60wqVBdFrpEZk1xkZu9
	kuDbDm+HvtgJog1Mza0hn/vVNBZssM6X13GM1rPqXSl0mhqyUa1FIdDfjS0M+t0tWDInT/e
	Vh1W8hqUxJmgDYIx6h/rl3dDorEk4bDgqqOFdyhaQiLo/g7v39HIKqIi6gYkGi5m64+ITpX
	KlY2o13tFqAZh/tuwOrR1iYBqHWVbSS/1/PKR+BNo4Hfz1b6CtEliACpDNV8iTcST/YbGsX
	BdLRF2ES2EajE2BQEOm6Ip+YenxIVQaiGB9IBIUodxdz8ua3yp3pmhNeXQiLPZ23mirGFUr
	XkOCadjKMOGP0vBjB9Q6pOMV8KgmnZxn8eoCVMNaKp26mESBaKd7ej8UU+huO87E9HmBobK
	9VaTKjNa/8iGOLxNP2zlecn/0IL436yAf5BR675tRyhPvOcGLPdB4X9b3sz3ZJ4BiJ6iRYR
	yC8XuLVmTg9Xtv1jH29PtPZOdLyVb1r+RNfRT1LdbJqcTZCxCL9XGDb9qn62sUujOS6/rUi
	SQXbY/0RPCeGTt0WVjBjn6kbXpiC4HBi1PNX5+9FFdx/IgP6pDfbFs8SGZFjIIAFiPfP7I/
	S+jZxeZicMPweEuWfrbSL2y3O/aivmzmbF61HJkkKnUpQLAzpIfsE0uUXehHn1JN037ZOYk
	9oC5D9Dr6ZEs1TZI39PPkNGTSA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index 69c19ef4b8817..4c3cc98f87752 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -951,7 +951,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -2039,7 +2039,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
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
index 82608b34260fd..cbc101b095a30 100644
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

