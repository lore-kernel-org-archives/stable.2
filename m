Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71123507B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652328; cv=none; b=RcnxPJ8DUIkmiW5LBYu7qpmOdP8JAwed6m+Eos4ui8p8mChbPJBxGfQZ+dvtlS8S0C7K1nLIKIjP6F6/WhM9aRWelIbvlBdg17xoisyXpI1qVrrrFsajsz0kZp0KTon8/RFVZlND9cauxIcRnx12PMeAYvJHKZKWxEwTtvjIAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652328; c=relaxed/simple;
	bh=9lY2BwgtWWTKSt/tRAIlT0EdtWdVuIVsAR6iBf98uBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t739Nc/UWCVrAM4cCAyFGM+9A/olU6UUdVpxlXhVJGXO4oAZczRA6dW+mxGzcBkn305KJXIDSrhYuvcwMtr3/ivep/dMM60IadzBj9dQeP/IUCG0Jf4ufp+LcLVoFWisCYa2//8kWDztUdf9yXaVaRgNBGFtvAzw1Igef1MlIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MrGll7pl; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MrGll7pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652274;
	bh=oFmTI5qoXltyvyaJBVnzQv5WxdbMGpTL2KkcSCARr54=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MrGll7plP6U/xeD7ND6SQRlPLnDRxcUh+IUeAa/g5Ls1OCcKKPJeqRcLRK1h/PCf5
	 WK5UNGNc1ZN0FufzqgG9L1f3vLy2PVi0Oq8mJwnYrMt++hbjTYBG0LPHzOhoPtLvzR
	 ZbNfFReFXhzFyA7l3PvCUWNNThiPCl+XFwnNOdEY=
X-QQ-mid: esmtpgz12t1787652255te8aa0c8a
X-QQ-Originating-IP: QfkwEEE5Y4ZE8g3+q0JJIQ+OYiNqurQmpphwTtdrsDM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:04:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9197370875519736011
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 3/7] selinux: use u16 for security classes
Date: Tue, 25 Aug 2026 18:03:37 +0800
Message-Id: <20260825100338.4039846-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260824220022.435960-3-sashal@kernel.org>
References: <20260824220022.435960-3-sashal@kernel.org>
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
X-QQ-XMAILINFO: MgQY1K25Ph0mwgKPL21KkvIKWU5BB0wvskZcQaiLRaU0leFJv5oSDigJ
	XtxhccVLklWgr/AniY0Wb1PNelAqHTuBK0IeODChmNfzcUJR/od8tI18OsK8OqZd76vADHN
	nnFd9Jg+9dQAbLG6WewnwzIzRXdVCu8Zss80+btStHzBrUnVKJuKckNYeN30VGCa9/rguSY
	GuN9FITv2Gg2lm6eymIcdn9eZ2JYmlRz0NwX8Sh9Wa4MLkD2fZQzsEqw+fIrRkFmz3XeAit
	O21LXjhvHfu9u7SIz/83TEzQLRu1f63cAjESEyqVQsB1+05fYCa/5HQMhOQlxpbgFysByFt
	quaqqNjV78V7qSizPubMBdeed1AqluqYbxsP/PnZMB/ePSXPWxwRKYm4gPc+CNkj8CymZwo
	EBAkJ75W54igV0smuWaP3Ae4asLwEvU7CjmB0GN4aSvJQTiLrD0cge9hUvMSm5RRxj8cru4
	QeGY4uzdsV83W+Fn2LTcJWf+ffkB0qZhS9HDfrL8EOsSL8XeEIi9qA5gTe3gQcpDKmZ8Q20
	uZ8bm6JLYUW4/rztvi7lkzlJkQfGd+SsTieQ4suoMCTCwpgXR5mNU5a9zkFdeXu99ghoZW2
	/XSwAoDBCretBHv9F8/kM+hctkj9f23EY7/fq3aTSi5j1i6FaPD51M5X3foJ0xmb28Yydg8
	YktpAfl1Q9oAbtoNFfpf+sWNwhnDQsnwgzMgXeomv4dz8tIaDFe1i/kXDvnqgYcjtgkNOpa
	Dmc8A6PBTI6NkyKvjKhYDFMMWra7XxEpjC8MFI6+TuiD9FxVH1z0+ph3usGGs2NFQ5jznTW
	apvAuCb6mmpoAfLp8WXNxQvYm4WDj5lwVkpzQU+Uvneb7KNz1cwtq5TvEEsPmo7I5wa8nQr
	p6qSeGPLQK8MFOOXYPvO0/JxlCc7lpOB3yGRWwC+MlrpvwefZUqHLu5kwnSi9dMzgB3WjwH
	scZJ4sSHdjmu3alj3q+l366dhBNznwtl9BpnwEyiM8I+bpvB02Okx5x630SCydmUDlkXHCr
	wvK/CQy8cczTtv/eID7P9CyL5giw4vOljB59q+YOSOam7qpTJIx6HGnkNzeLjEeFS/8wYvX
	QTn0pYhrB9HYVTtNEfS4dE=
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
index 48ee87070ab0d..fdee7e22462aa 100644
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

