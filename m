Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA741BA61
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858097; cv=none; b=KOb5GupavP+WBV4EPGsLOE1DJP28qBuLJjg3UTjm5FV/K82iNgfhUAjPvJlQ8k2nJpZFxUUnweOWLQK96RD+7UIbVf7iLwmEW1IgEvuogRsj0QPCdZ2w/3y++IQn1v/x0cS6+B5RjfA+grE2qPq7D92EWVoxHUVJZU78paTyGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858097; c=relaxed/simple;
	bh=tBnzkueQWoVusvnN3zQB6x0IV8A1rfcLEyJ9Xm6GLec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP2j5JxRMhWr3OLqN0IvW16TB2zixvE+/lQxfPEo1Bghs4OPcUHEfNVLZA1i5Nq2uQqs3qs1HiX+LV7YwH8rqMGM2l+tJqdoyTtXLMSrRr2iJk4dU+sSNDkLWYgDdQ+2RYso+lnsuv7QYnNPY6dFNoRu9/5MngGa2jaBO656OfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OkJlqRNb; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OkJlqRNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858047;
	bh=xcIHcbLWZ5suiyPAxyTHATGjWg8iD2KXk+/KRfBBv4A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OkJlqRNb4tu32svO2ZcSbP1lpprtiDHBQAXYR8qaR8pwTl/2kzbNPHdBjAQiPLUiR
	 Ki4Ajt9O6daAAxTcOgWBeBIXJxGP0QfgQsbHrrnRNq2/+tu+TJsShCIZbJ5Qu2K/FI
	 /7VQosEql7lEbRe/JL457aHR6nLWr6s1cxjUbheY=
X-QQ-mid: esmtpgz15t1787858029t3c7cab1d
X-QQ-Originating-IP: EbB/peMXCDpOcH8MNFcUky4veo3o2ZqI5BbP7kwKtEU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:13:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1186095464526028897
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 6.12.y 2/7] selinux: avoid unnecessary indirection in struct level_datum
Date: Fri, 28 Aug 2026 03:13:14 +0800
Message-Id: <20260827191317.18119-3-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: N0abMa1jyQCF52bKawP184wrSwCwXoLY4zt3QHWfWDIJdj0bSlZ1+bBb
	hg2qbnGjYqX1TUb3BW/5JZJZVMMZznJuxzHtJFFHx6OAThIr2f4a0Obt3iIyGkl9fVxvZOC
	tLvSm4pdJ46l0Ol9ZsvJgDAFockVaP8Grz2gqPh+7ALniX6UY6k5cGvPzEj/ZdZ5WlqIFOI
	Kq9plnhx/Kj7+WpUv43MngNnAAqamL8WWOD697ggSQ2nCslLpEhkfCWWsjcSriWttk7qNWA
	zkTu4JdTs00HaGnSim+h4ic0mb6cEzVXjC8lsZc0pfKXhHoIhGEbciVAOhtessub0onZAY+
	Fce6xGIUwNVUizYlWp1SPIJCISL0wPWoLx2FUTROdKjIaaSvdP4r40k//kXJk77rr2Sf9sL
	YY5/Jy9O97Zgfz/6dRdUp6mwSTIikseKzd+KAQl9EBASMgMaN66MtAhhodE0UtagMGlCwz+
	tRd/1uE9qrt8ku53iaLoDn7ZWmdcB+0Ko3lzVOdwg9/pvOvWZ81KBoJOA8tcf1uIXkC9ZCq
	XyToVE+sTbo8GBZzrkBAb9dzWuNKrzMTl4HscUnyFqvaO0IcZCoSH+kX+QQ5izeZaz1EBu4
	iaU2CYyl2SRVNfCbfgRDSDbDZjg/s3Ip1BSq3WP8YOzvAfxAUWyd5s1gjb28OLI1aNar2hZ
	8sD2Fk6jJNdxMUDLp7+Fnd7CoogECb2LcQcy5hn8f9+HyF9h8qBzpUGsKOxvoFs8s41SeTK
	J+mgvzoB1x20raOWuGA0dapndxN61DW1yuatFLbOjstAE+7Pur+9mYLq3DOaKVVM5UBkJrq
	a5mJG+gX/CCohrlFH2NK1O03fBWGLdETcVAVp4sX1uk88LFdH1OmsEiwz1yE6xfjKpkVNvH
	jsxobTbkJ1rjDPfanDeA121CExZOYgVK3YyUbNqe/sg1L+fYUSbG14/LJVrGVKKMeyXCkT2
	xrHcNt32p/lP/BhEt4G7eB5qIttjDjtNdlDEIPzP/ihdJwmQBIuq5temI8pjNh0+yLWkiCQ
	mvc0bvH5bWmHXe/RtJBd5eZLNLHdLIeKM9VRq92LPKUM62N1cK2rDq2EkhZJRjsy7vJtrif
	1zwmSMlNI2oZaWehQ+4vAJaEIVwEPoNEB4NVK2ZsJTOZEIWy3HwSeUbXCDeJ+1g6ByXFHtV
	Lqt8
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Christian Göttsche <cgzones@googlemail.com>

Store the owned member of type struct mls_level directly in the parent
struct instead of an extra heap allocation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 749153636643aaa793f14e84e864fdaf5ed0620d)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/mls.c      |  6 +++---
 security/selinux/ss/policydb.c | 19 ++++++-------------
 security/selinux/ss/policydb.h |  2 +-
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 989c809d310d6..a6e49269f5351 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -171,7 +171,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 	 * levdatum->level->cat and no bit in l->cat is larger than
 	 * p->p_cats.nprim.
 	 */
-	return ebitmap_contains(&levdatum->level->cat, &l->cat,
+	return ebitmap_contains(&levdatum->level.cat, &l->cat,
 				p->p_cats.nprim);
 }
 
@@ -289,7 +289,7 @@ int mls_context_to_sid(struct policydb *pol, char oldc, char *scontext,
 		levdatum = symtab_search(&pol->p_levels, sensitivity);
 		if (!levdatum)
 			return -EINVAL;
-		context->range.level[l].sens = levdatum->level->sens;
+		context->range.level[l].sens = levdatum->level.sens;
 
 		/* Extract category set. */
 		while (next_cat != NULL) {
@@ -456,7 +456,7 @@ int mls_convert_context(struct policydb *oldp, struct policydb *newp,
 
 		if (!levdatum)
 			return -EINVAL;
-		newc->range.level[l].sens = levdatum->level->sens;
+		newc->range.level[l].sens = levdatum->level.sens;
 
 		ebitmap_for_each_positive_bit(&oldc->range.level[l].cat, node,
 					      i)
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 27407cb6f18a8..449458edec732 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -296,9 +296,7 @@ static int sens_destroy(void *key, void *datum, void *p)
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		if (levdatum->level)
-			ebitmap_destroy(&levdatum->level->cat);
-		kfree(levdatum->level);
+		ebitmap_destroy(&levdatum->level.cat);
 	}
 	kfree(datum);
 	return 0;
@@ -630,11 +628,11 @@ static int sens_index(void *key, void *datum, void *datap)
 	p = datap;
 
 	if (!levdatum->isalias) {
-		if (!levdatum->level->sens ||
-		    levdatum->level->sens > p->p_levels.nprim)
+		if (!levdatum->level.sens ||
+		    levdatum->level.sens > p->p_levels.nprim)
 			return -EINVAL;
 
-		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
+		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
 	}
 
 	return 0;
@@ -1644,12 +1642,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (rc)
 		goto bad;
 
-	rc = -ENOMEM;
-	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_KERNEL);
-	if (!levdatum->level)
-		goto bad;
-
-	rc = mls_read_level(levdatum->level, fp);
+	rc = mls_read_level(&levdatum->level, fp);
 	if (rc)
 		goto bad;
 
@@ -2870,7 +2863,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
 	if (rc)
 		return rc;
 
-	rc = mls_write_level(levdatum->level, fp);
+	rc = mls_write_level(&levdatum->level, fp);
 	if (rc)
 		return rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index e01de17e569bf..e7a6f1a6c1461 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -126,7 +126,7 @@ struct user_datum {
 
 /* Sensitivity attributes */
 struct level_datum {
-	struct mls_level *level; /* sensitivity and associated categories */
+	struct mls_level level; /* sensitivity and associated categories */
 	unsigned char isalias; /* is this sensitivity an alias for another? */
 };
 
-- 
2.30.2

