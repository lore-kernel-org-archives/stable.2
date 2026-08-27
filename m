Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D93F44C0
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820065; cv=none; b=GLq1gS5UMAnotOcBcU9RbLvqAokgWz+4kzmU1KZWqA3AdXONHNgU+vqxW/4Fi/K/ienMH4Gv8j5loSz5L+8/WZ7kijGXXMXBHqvSDNixQURX/qa9yrTuOtDy9EceMTiDEP8cQv/jG0VeZgbPk9JvgUQE7MP5mAsg7sVDpvoLHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820065; c=relaxed/simple;
	bh=YqikJddJ+nsACmbS8QHt1ILKOktcUhagv9TUR9L7tio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbqdkgrW0aXYC+o3IzT/nRZvDvOLYtahls6eTxN/62GgBNPHxGCq5/2Z1FDfdQEXl2EFAQ3BY6znhnglV5qKmwlu5WKFn+bdkZuGI6bgKjacQA7BQd2ZDdFyv7ko037i3Q63lWOAJ6380WGj2iGvA5kbVyYXCSwQfWuZtklyMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mqHl5etR; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mqHl5etR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820013;
	bh=Tx3darQ+PkVqePO2SCnjhvTxgORpT85DwVbifMCE9+I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mqHl5etRx1jrjTPdg6XmcytjnZoqrw3v62pCj5YRgL/ZwN+7tB6gtCOFgsmTNiyeT
	 mF6M6wyD7i1msjTXqjqtqedAtV89YRDW2IAi1/oLBX2leSSCG2B3AUUan5XAJQu0BG
	 YxifI7Z8To25D+BS3Q2RDetarI7NrIDpfXHXhlqs=
X-QQ-mid: zesmtpsz5t1787820007t5068cd48
X-QQ-Originating-IP: lEz+pVygJ/4uhI8jmR5uSA3IUujGugbAxh9XiFVTck8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:39:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3432798356390099978
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.47-rc1 03/10] Revert "selinux: use u16 for security classes"
Date: Thu, 27 Aug 2026 16:38:00 +0800
Message-Id: <20260827083802.4044165-3-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MSuk5L0FboZSf87nu0kRJEsY0zA7k/9rDLdnIiG/VSk5/gO8ZaKNLKZW
	gCZec2LrJs4E6UiqXZWG92RQK7WTWK18588okgqgl9/XR62DrRx/LucWURvF8xkXiqv9WV+
	TLOWrOeBz7GruQa/ckNH/yd9Dyd943Ce8aMUP8ftxdQMpu9JFRw6wpv3qy5uGKPLeG5KAwx
	bulqnR+YIwdJmuH/mVspUt7j2FCLfUbFhUvN02yBmVVsH/ekPVVkJxmu4LT3jff7UPFehNJ
	6vH/rgUDul+bYlS5bIIeiVeI21O8fnWNfAN5qqNZvl2G+nTXEP3CC55dhVLEH+cdZDRkhA2
	pv7GH4AzU2xtqXVe5uR8kDL118+4T3lOG2wUueocmrJ/uP76iOKv2c8S1gpSLc8q/oBOkI2
	LqEmZFGmg2pnCbEwSjkoVMdGbKZ6JqdMJgry1bzsXk1ZO/P0Dkuoc9OFCSLNQNLzZzvXlrZ
	cYbyLN7I2rAKedZV2CqJORhmo/2H59xaGVBbP3aGJmqEVJ2V8VbNxrb3sYE+nY3Avspdfqu
	QDrsMZmKPRLJ7iC7+D/It8Q8Im+DZrPQA4JG47E+YQimLrAEeL997/i+ufYZcE7vbPbG2A2
	svnxsaCShje2hA/QuP2N5C0oO0DhZ/PuJKkzjGiIX5Y0hQ7hQL9hNz/90+q4BIXf2uCE2/L
	Pd9shg7U+PG38GdY/5UxhvlEsX43gZ/qLSuLnYuqobPjOWQDDZ2cMJ7fT5Q4t8ycEd0GUHg
	Dj4Ylcy01SOYhVEQDfZKmNM5Yv55lvKO/blT3KnLT3pObGdDrbtWiomfAvlkHD8rROZDuvP
	d3mUyENvcvsTXICpfqy11L9qnVpq2FLzw1znZqgcqw1V4a33VPDBk/Nxo2IJJAvjCLf+D6m
	yE1NfRzfKURu2lYaHLO1803I53x8oeqnJ/iaNXNQZ+MyWHCj0qPRx3f/rMfkS8UTWkE3VH1
	ufAbOuEDlixRfx6B4CHDzNo+/3LUUzOIU0pX7wJt7ELscycnPHPdZpfOvrmRGY4/UZxfyrH
	uV2HWHt21iVUQusluGQd/kYagayayNmSBxmsQzh6HIy+nkM6epYDni70dG99kBup49fbJ4V
	N4mYvPXoquuk7luXKUqW5mLf43l1hTbrVMo1UU32OclcNIyZSVcEzq7B2Vgks4VuA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

This reverts commit 3683f35c14816f827a80e217072018eb6c37422e.
NOTE the commit revert the commit in stable-rc/linux-6.18.y

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c |  5 ++---
 security/selinux/ss/policydb.h | 10 +++++-----
 security/selinux/ss/services.c |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 37e0735b0dc8d..fdb8a62da04ad 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -951,7 +951,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, u16 class)
+int policydb_class_isvalid(struct policydb *p, unsigned int class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -2042,8 +2042,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, ndatum, i;
-	u16 tclass;
+	u32 len, ttype, tclass, ndatum, i;
 	__le32 buf[3];
 	int rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index a49275d1168d8..89a180b1742fb 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -48,7 +48,7 @@ struct common_datum {
 
 /* Class attributes */
 struct class_datum {
-	u16 value; /* class value */
+	u32 value; /* class value */
 	char *comkey; /* common name */
 	struct common_datum *comdatum; /* common datum */
 	struct symtab permissions; /* class-specific permission symbol table */
@@ -82,7 +82,7 @@ struct role_datum {
 struct role_trans_key {
 	u32 role; /* current role */
 	u32 type; /* program executable type, or new object type */
-	u16 tclass; /* process class, or new object class */
+	u32 tclass; /* process class, or new object class */
 };
 
 struct role_trans_datum {
@@ -139,7 +139,7 @@ struct cat_datum {
 struct range_trans {
 	u32 source_type;
 	u32 target_type;
-	u16 target_class;
+	u32 target_class;
 };
 
 /* Boolean data type */
@@ -195,7 +195,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u16 sclass; /* security class for genfs */
+		u32 sclass; /* security class for genfs */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
@@ -322,7 +322,7 @@ struct policy_file {
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
-extern int policydb_class_isvalid(struct policydb *p, u16 class);
+extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cbc101b095a30..82608b34260fd 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3290,7 +3290,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u16 value = datum->value - 1;
+	u32 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.30.2

