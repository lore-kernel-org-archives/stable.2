Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BBE41BA61
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858093; cv=none; b=fTyQnMb1VokR8eWLlrE/o05jgwenkzylr++YjruJtup/0CrjsBN0n/LK/z0xD0IND8F3IZOdOlfC74NTQoWH7Cpj6kk1kkycU1Q4wM8eyodaKgY77LVKgVLPwUgxYTTor8EEDCGpdUosnM0LmfM5yIlepggGBmCMW4uR0dPH1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858093; c=relaxed/simple;
	bh=zxKZSToaCxy2kb5EkZXFKZrhhgavzhRpy8Ow7HV1FMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQyJIc5tANCC+4bwGQAq5PUunNRn5psH5sHsN+Xrj7iS+s6RVxKtGK9X0TDY4G/smOPLYpG2Bx8+N2AhVXp07NKL96eBqKnLjw2QqTvYaC7lN5mruuYlFnDuc+qXj1LPhYNI9fJUbIO+7AAAb3roUEUbdnq6CxPmWtC953+sMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LaLoKLEu; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LaLoKLEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858061;
	bh=RzSDVLNTsXnsQklOuaK0tg7kLbF8kaxPSdcCiNCPf9w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LaLoKLEulidQqyltRwuL1EFuLc/H3EG8bjxvLiKFAqJR1pRdIGWObk+TKCmzhKFbq
	 1pun9EuKJj68tcNKG+V1dLtEDzlMQTP+dF6dcNPs37/MC1xlcLnBJMd1s8rSNpNOIB
	 CxX7gEn+NUrRNg5AhsjP+6D1YNfysncMinIaIfSo=
X-QQ-mid: esmtpgz15t1787858043t4e798121
X-QQ-Originating-IP: lVfxajGY5u4x6EGCyVtlagLcytL4NsC45YJpbI7ojWY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:13:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2291408826472805554
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 6.12.y 3/7] selinux: make more use of str_read() when loading the policy
Date: Fri, 28 Aug 2026 03:13:16 +0800
Message-Id: <20260827191317.18119-4-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: OCd5OxnoBMVVk83VN+i6qRLWwQ7A12P9TJbKRebTSXeKEqlXhwzS/pBe
	JJW/LHRpUTHGVxrA9V7WKztl+TV86ZhtwCSGzlGryzl8Iwzu7PGna8Hx7OL7dAF0d5p+sQV
	+nKx+yVPHSsZ4kdzC8S7XrhN/qqcTwBAWN41a1l4RWRkFpFIOff1OrTUrSBThvIJ24ryDiC
	V+w7m/lzkLl5X9T09cBcOFEPFQ9M6jxULy6BhH1HCF74v9N6WU2ROW2rkXF6mplNLuaU3Xl
	KvoYtHRMc1MbnqfsD6d0VuSAiQ4IIFhIbqyBx+uLgqrwDPLVLAS9qYao0IaRmcBe/yGtSG1
	2Q+1MrefFf+uOIM2Z7e5yVyFl1e+mtm4kHf/6K9D0YsY7ipEj/kPuVz2LSVpOVhktCvyfSF
	t14h/hgoeWUt3Q7XS9in6AVMrpud9Jah2lgAmbOjWpbjaA4J7fxP+eBToCorO40LGNNr3iL
	VzGk7dX67MG24YnSbGM1QxsPQS032qz2VQEtPZu7hh4ikizTrsXYwA5FV+73bEakS9W0pk/
	JsQGfBIudqFDQt8ZuxgDDGoT59mgAxOm/5JSOtEI/StIYyAMKF59h3exSOo4J+0kAcMcHZ5
	J5dUjLvvl39n05wgjaoIQH0fVdAQjK49dDlX27wc159cXl4zeTIlS1HGlJmvY07hpSfglC6
	8RdGVAw/6CZj5o74NsNVODnycEHj4zkcK7pbXA6LafUdEez6sneYo7VcPFMeXiWrrQrPlIO
	an3VgGM3V9jdy639ARsdaJftlcW+VptqAvrLlrf2ReHR2n+YTiRZcQyhCbLb5QgHC7HE/YL
	55XcQECHuieNMLs/O4L7+7KeKuyAcoqrW4HpRiq1nRLw28NESm/INq2EMaSfwUIJA/V+vyW
	dy5kBQwJNbXDA2uYWQPbus3CHazAM9oL0UVUsmNSPyphDF8IpPfn19/KC1bhAhbnZVuMLHp
	I3HCSzMWC7FUpbZ5KN+lHGliFSVI0rYChA3iOuUHjO0fArAfwUq/JDKf/sdznxKG7akiliY
	myWC4uEw1FEQeW4quYoSz2/NW20reKutUC4c7kRZGeakpG25kCTJl/o7ZTQJaVmTGVDebDT
	1dRhQ6FUYvRyxch9+3g3POLXmChvCCfuzLewnuvaTMrJ0fIY+5uDVPnDDLng99whg6luPfA
	NY9F
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Christian Göttsche <cgzones@googlemail.com>

Simplify the call sites, and enable future string validation in a single
place.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: subject tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 01c2253a0fbdccb58cd79d4ff9ab39964bfb4474)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/conditional.c | 10 ++--------
 security/selinux/ss/policydb.c    | 22 ++++++++--------------
 security/selinux/ss/policydb.h    |  2 ++
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 244dc82791133..f8a21d10ff929 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -230,17 +230,11 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
-	if (((len == 0) || (len == (u32)-1)))
-		goto err;
 
-	rc = -ENOMEM;
-	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key)
-		goto err;
-	rc = next_entry(key, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto err;
-	key[len] = '\0';
+
 	rc = symtab_insert(s, key, booldatum);
 	if (rc)
 		goto err;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 449458edec732..db200b7518fc7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1107,7 +1107,7 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -2499,24 +2499,18 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	rc = -ENOMEM;
-	policydb_str = kmalloc(len + 1, GFP_KERNEL);
-	if (!policydb_str) {
-		pr_err("SELinux:  unable to allocate memory for policydb "
-		       "string of length %d\n",
-		       len);
-		goto bad;
-	}
-
-	rc = next_entry(policydb_str, fp, len);
+	rc = str_read(&policydb_str, GFP_KERNEL, fp, len);
 	if (rc) {
-		pr_err("SELinux:  truncated policydb string identifier\n");
-		kfree(policydb_str);
+		if (rc == -ENOMEM) {
+			pr_err("SELinux:  unable to allocate memory for policydb string of length %d\n",
+			       len);
+		} else {
+			pr_err("SELinux:  truncated policydb string identifier\n");
+		}
 		goto bad;
 	}
 
 	rc = -EINVAL;
-	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		pr_err("SELinux:  policydb string %s does not match "
 		       "my string %s\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index e7a6f1a6c1461..d95a3941f327c 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -386,6 +386,8 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num,
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
-- 
2.30.2

