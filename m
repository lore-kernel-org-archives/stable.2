Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C793EB809
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820114; cv=none; b=cR6CqfNEiOJ6nQ2pEx+q0j2FlU9gHYjUz/+pLbxeoK/CgZQs5hJ7wmENsdYBhLjAZ9ILeQEs0UUr4gjxdZY+nV0UAtSR/nmVhOs98oQc+6mcIdPoZhLeyCNETTMHIf/R7yqThNvQOk/E20b95jHgZBhXafWhYmHJfyennV8cF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820114; c=relaxed/simple;
	bh=9lY2BwgtWWTKSt/tRAIlT0EdtWdVuIVsAR6iBf98uBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFA4QD2ES3pCOMyyXWncGvRsa/tYv2EiJ1l3J3xPYdrcHQ5C8+Wg4jwHzV2zCl9D25eCJYF5WOHVMx5G6bJiRspriZShDemBdY0uqRspfyReTKgUDAkjphgpvrzsCGwCoMnzgxzJvqlr6aSEoRjXsikIIrq9Lvg4E5eNk2V+bL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YzNOnAHI; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YzNOnAHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820059;
	bh=oFmTI5qoXltyvyaJBVnzQv5WxdbMGpTL2KkcSCARr54=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YzNOnAHIR2qNNSypxmJmb+7iYS/1FNrmPAjyNVKaJPggNvBJkQQzy71YCcNg/UkOe
	 DYGIoSa/cECxSTNQ3+LrHWe6OTnxCc6bX+kkiVRABl+E5dSbW2/aDmlOwCSWyX+fIh
	 yXyDlRp7E7ePKlllXYvbaQiK9QPzf6XUW2ypqQU0=
X-QQ-mid: zesmtpsz5t1787820042te58bea26
X-QQ-Originating-IP: ID2C5ZIRyRLFJg/s/0VyR3NFTBK1Md3UXA5FUAmMW6o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:40:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4581294390571611329
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 6.18.y 06/10] selinux: use u16 for security classes
Date: Thu, 27 Aug 2026 16:38:06 +0800
Message-Id: <20260827083802.4044165-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827050834.10002.stable-daily@kernel.org>
References: <20260827050834.10002.stable-daily@kernel.org>
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
X-QQ-XMAILINFO: OO4+H9IUzQaLo7wnU72IFZ4STbvzAPEIeA/jWCt/6wdn+6POlHtsIO5L
	8PGQgBeDGWHw5m+Lp2KIdaZSID898tGiOgTZkh2RzrP4biZ5bmW7j46MecsXCPnLXV31gX5
	35axre00w+o6EJjugLOzJoPqTSng8tSogUYj9cCAKMurFqGsQbWzQTINKO++odRsFF4K0n/
	0BrSRj4ckU5zi8jpp7KQbxCiMcsXz4Z4Ddg6jQDeUclYzDOkVeSoh2bjEkCFU3l0ThKicfR
	JPsQeKuwpFYD9/lgApak+dFcnjYAFY2vWRLhsqSccOtJhIUH4kQCfMF4LMqyzOUSSXqrsRg
	fI2HSXszvsn0JFuKvebscika2cfqJH0Lhqb9NzCdIF377GZl17+gKWqEyrarIix5TkRvLC2
	E2YLzRIemsu+egr2eMgNZTYSKPEYSpDdvm12JmjeNwx7PvnrADpMXc5qYQ/mSlpqpkZc2mu
	O+QfO5z+llrkah5HQxW6BcZKKgYExT40KH5hBwdaxgnFiSGEYSTdH8KksHDa043yYDhlB0M
	//4nuNpc2lDQ+TETPnkcSbHqxh6TnyzrXCd3hxs7DFEP4nBFv0R5yFZXcug3564eowdtote
	XAvHU1IL50d/FI54CoYTQVtZVaYnYGuemYjWUCpvDCYB4Y7DgCW0KsUroe7/vxteJpyeq05
	oEpuk/nz4pcvsy9Bj84k6wR+84Hf0s2ubLrzxy8+bCnf0wn4sabty6Pet8THBuDyDXWWJ8R
	Qvf7IG0IbQBQ4L8xMKFbwDiK5WHZWPjCMyInnboN1o6wo7rAD3XWE87aJjQEYHOG4vfNcRB
	k2kHEiG7EmVaH06N1vJKg38h0osFYFs3cjHTt2hno8WKplQCCOjDreSB1vqu3AOi0NsYqrW
	tXRwfJwWi4I7CV7hL4JsFcok9Gmc6lf6XEQV5578aMJgUdi6OzlV4CWId0IPD7XU1YB4Nb6
	kCckmnrxOtn4oUodYP708dTEhBxXxvli6HbE1RQGa5LTY1y6MH1wOESc/S45G7erhsK7xdT
	sZbxCBthDYQj5qX6KrDJG71vGFG/Vx8PKsFUco3VYIAywBN8aHpaTUKp0Tg75QS1gv2RDGq
	NN2LsQoLNTOQ9SjcwxbYjyqRHxSe68iEAonSurqUvcpcGvam2FUetQQpT1KYXfaJA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

