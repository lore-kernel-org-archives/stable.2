Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2823EE1FE
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652291; cv=none; b=WKtwdemC1E8TLjdsZZlu+vvzwWj9UrVwvmbGxbiN3bAh/iJvtuQzbf0kb0ADg2QW1uSmaA/2rDhXBTBBQbW2gmzxJifFVwoUMRJUakok1Tk/+y6FFqpp21Tc+d1aXJqRZyeTM1Q6wIpPQUT+iyF6/ZB82kmirfc/ErkaYeqDQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652291; c=relaxed/simple;
	bh=rMRHrA6ir2zM+TezKjAejsiB09VUqdtowBQwN0aCJls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smCSLs/82rzpyc4VJnM/7gEtu+Gy6mN4DIEbkwIKcqbsZuk1Y55cTq2eIGk8XAPkSV7iv2muUr2giOb8H0aeny7I9MpFfVsb1tbhk0JQvU5EPS5V7dVZ+AxMvmKPw8T/oRwXPqg0YxqDLDmyLArwdlsyo44/3Ipt58l6RhhsR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=E2K1Mqqj; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="E2K1Mqqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652248;
	bh=HXdQNn90qs9oOdwd1dM7zH5Q4G4ZpU7LIHfu/Kwi0D0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=E2K1MqqjD6rxO+Nie8yqcmxLw3+BZeBUQBB8lk0tN2E0knpEc7MvN4sfhnNI9H6wZ
	 uNhZFDITNqe29P87YxLPVRy4nD1dG3xhTSxKI1rF7tw0meNzrbUfs9gXdVmepJuvGG
	 B7gigC7b5JkibSGYadSP5wOjbRI8MxJnAsgTWI9E=
X-QQ-mid: esmtpgz12t1787652243t527370d2
X-QQ-Originating-IP: Q+GHNyAcLnYRsJDwMK6mlaCSEL7GnEVMXjreYSwpZCk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:03:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7101500226119012175
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 2/7] Revert "selinux: reject a class permission count below its inherited common"
Date: Tue, 25 Aug 2026 18:03:35 +0800
Message-Id: <20260825100338.4039846-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260824220022.435960-3-sashal@kernel.org>
References: <20260824220022.435960-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MMnP0fEUKo/h+Lhzb5HGgRaK+s4GGcSALaqS4jkLHbvevJOjm9BdVGym
	VW5SalHda6RqPSlTIz3joU9t3HRGOvoEZz9eU24IdifhS6M8qe4bnnaXKjXZvT6QCGoSzDR
	uJHph92JzMZlDcG6O0RgjiQ5GZA83+TWb0sYavr4OV1moyiNibSL3FA5Jx+RSR89BTLNqI2
	HCz9lvygaPl2oZJHcivIpHX5QPYPl66pXb7JRkPJ7HAOiNnbKCMfj8w+HsK/a2bnUcC6f6B
	q86WWiZoW9mqxvY9/sqmT2vR2MZQGkq6IcdbsSg02QlS1D18Hl9M+vr7Oq4g+pcrJCHDdXs
	NcJdTvjK3MM+A10ofmWg+9lUP/NtPPlSzg7oGmswPfvSDDk9I9CKgPXaOdoLOoF51OUKkD2
	TTBKgOBycTrkuzZsVYny8CCZpk8KOz5QiZjXO5dzxgEIRXg8izxY6FppXbI3f9ly1PbfarJ
	c1FvGGmueTzpY/IwsVEF0YSKmBd5R3JN6usMGjd8ceWHgmUq8MOSCl1yyc5jfG/aHKhq0cg
	WGQ9ViTiGonYo1t5mfQDKQoUSpNBXj8G+UuMUbB9iJXi6sixOdtS0RBscZhU0STiJWIfDgc
	vkf2lSGxFdmW93Ze7AHA9ZfiTqPi/uClUeNcvB/niAzacYIo2pANwjhihcvCIDeVlcKapKk
	o6xdEFrX72cfUfvoTJ2nTRUOenuHkXa+IYfu1NI+WEXJdKn5GkCKx6nTK1o7KSorJboJICl
	Z+n4CGD6WrEmmDV25/CfZs59Uf/rGx63sltgrsVl8/fW1dIz78SYrQaTz41jClu81644vkI
	ZCovveP44ruuurIFVCj25cs4QnsGuxFGYFBqo/NZ4oBw9BLDenk7PUhwgfo8szaQ+r+pFQ8
	7w8Hd8ILSR3++7kYB0Thp9d0ZE4U2IbhIAQ3NKoe06N3QGKqVqgH4xC+N5fPGZ6I+p8kFBW
	P9NOp6J5mMgDl6V7oQ/9D/qWQz8IWn12zbFCiCJShI4vBbLLlVOEmz3v2mybaHNtfrdS7k2
	0JP+NWvnRlfiiu5impWcmQs/GPXcfD9P9UCzl9yv5uCaaFi94Xf0J4klKBIwJ8e45lGLl7q
	Sj5M4PAHyT7SfDuA56exOA=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This reverts commit 9f721b5d9e1d956ffe965bc09375989eb51881fd.

This pick was applied without its upstream prerequisites (commit
fa79a596848f "selinux: use u16 for security classes" and commit
18fa21f10d00 "selinux: more strict policy parsing") and is therefore
incomplete. Drop it here; it is re-applied later in this series in the
correct upstream order.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 69c19ef4b8817..48ee87070ab0d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1385,18 +1385,6 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 			       cladatum->comkey);
 			goto bad;
 		}
-
-		/*
-		 * security_get_permissions() maps the common's permissions
-		 * into an array sized by this class's nprim, so a class must
-		 * declare at least as many as the common it inherits.
-		 */
-		if (cladatum->permissions.nprim <
-		    cladatum->comdatum->permissions.nprim) {
-			pr_err("SELinux:  class %s has fewer permissions than common %s\n",
-			       key, cladatum->comkey);
-			goto bad;
-		}
 	}
 	for (i = 0; i < nel; i++) {
 		rc = perm_read(p, &cladatum->permissions, fp);
-- 
2.30.2

