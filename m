Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E028282F14
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809739; cv=none; b=M4aALY8nbQHHvJHwFBOY/6607LgH41JBIbUqnIqCJKOD4txcSTcRf4yzWM5Zh/iHVw1aVgja80PKx2w/6zkJa4+/yKEln/hHYQr6+fNPIuIRxfpzyGz/G27FwUuYDnICiXzCBiljXnd+EVf3xKADZJJPkUfY5dZJryk1cu05EGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809739; c=relaxed/simple;
	bh=FTz8wjxgZURiDTGeQ/oQIYi7PfklZfqyLmdHt7dIf5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCuYGEhTqTNZ0t/EHeMmuB0w5X5IVePpJoUcZudreeKVphZGU81oJSs1MB7cLLy++yUOBRZlZ8rVqNGZDqZCfg38pKnYJ7XY6AdzD9IUpiUIuxrHVz7QHyCQ8FRPLaZKiUZTQFjIAmoWrzC7Mr2CTUCAryuSIUUSeY0QxOljVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ki+nHfLt; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ki+nHfLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787809661;
	bh=TfTPHlulqPWqa2o/pQsU/8x970gY+4NRGa7Lr5YrhNM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ki+nHfLtJOtmHsXCs+uGrUkYVB537Up3JNf3hgHFtOMiWSGD6q5RY2YPdm5fyk2kz
	 6Ggur3EdBmbKF9zzmG7uQGxm/Lcr9I5GUm7DeM9HCsXQEbFRqbUwi8uPJ2/p2Vd+PW
	 Dv8noDse0L9vbocIFRqFOiwpc2xBzlnYT/+gsnnQ=
X-QQ-mid: esmtpgz13t1787809643t403de578
X-QQ-Originating-IP: wjM3HVkaQkuUNvn4oXBj/ukk8C9nKuC/sTyNGi4VMCo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 13:47:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3394571928269983798
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 7.1.y 1/5] selinux: use u16 for security classes
Date: Thu, 27 Aug 2026 13:47:06 +0800
Message-Id: <20260827054709.4027356-1-guanwentao@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nvas3ZbWNmzso7WXpSDX90vAiHBFIZy87cfoANv4SoSMdnsStWUOY/HE
	oBiCPLE4us8aAhVFCzLSVRN95+OwC0EAThDOiem+DsLMdH5f5ev8Tekx8mK6RrnUOOe2hMw
	ptcd/GFIq/hEdrCiNVi6bNweKOgJVDsn+H/b+XkL+SF4TVhfP9VXiFpnWWFE0KsoPzyt/ar
	NJl9IyM9VuMVSgDue+9bUR8s8Trh+UHBFLlSM4tVt9XEXUiFtyvwtMna7dF2MrrKUEZGtcY
	fJPL42fUqpPENAXd6kGp1v+QavF/b0NHHN4naE7PxBQqSCp3LVe/P9pwT3BQgrU8ZlUx5gy
	VVGTeQ+7EjvFTh5/3jTUy0S3m8TfmXAyVE/e/AssKVzN4RNBJ6Xe2pKbJOg2/Guy2xEqfqm
	ntKQjbsLw5C1lyXnJ5k0nzRfWLcdVc5qNfaUKNuI4Q09gkllEBlQ/ia9kFmGB4s/zsUafbV
	wruV8TH1isy132SJmbLwsLrQkzzj+It5yjxlU3Wh2bQkV31IdUzLc/4SdQ1Lhqp+hXzM2kA
	VxAZvMzHiXyk/TohO7pZ9FCAisnYdLi4y/LAGTZlJ8nrtrBUS3ezaGGPkWM09rnpjBJJFoS
	x9i5dhRXUf9yMNXe9O9ErpmD7tSPZromJI0kDPLEQkSEytjNsB/GbyK19dEBdnm94eGBBu7
	LIWcq2itBOlVhU4p6xEwB+tGxOF7wPDIyJpsqzUcm82Onw9OFficm0NuULwvooNr+cE6Rqe
	gT5Dt3S31GT9tMuRK0NPFq7rMQzwGfxbvz0bFGiYqDx23TRsMrrT8nzice2A2XAoH9cElvW
	IM9W/DIbNISnHpBeYG8DXf97PGBAixwUAk2RZVCWVHwr07llm5Gy/xAlWU5UdFCyuGSgim7
	jd7QnVB2jF11tL7dY58eLctdVBn36aA/aVfzY7cM49/e4UyDavsf+v/b5NaRyvLMgYH/lYP
	iyv9iDveL/t66lCsdx4e8MeFyJL6Hh5pdBGRfSVND2tJqrHVlELSyZLrrKx5JnqTDlXPE7Z
	birJLg4YAKj5HrQIEAHyzENf/ZilMrXPvlUFVyewT0ehiVgnKaSRxHArkcHMm2JWwGKJKiE
	w==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index 738fd47f33e68..3afea36dfcdf0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -931,7 +931,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -2005,7 +2005,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
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
index 143021c5e326d..b84d99c3fed98 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3288,7 +3288,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u32 value = datum->value - 1;
+	u16 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.30.2

