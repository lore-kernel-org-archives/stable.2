Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE95284693
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820081; cv=none; b=WO195dolplhqBAArFlSiHPP3Q2N13R3lOIxyUDkl8Y8MGylcPmQ3YZSTwtNoMwCXU8kVB5FEmiJz0ZvhocXGI1WPZoso0Vm8jqo3YrVqG5nx94DC+8vsQHKgds7V5ArWW2vfAvEU7d044i7BYBjEc87A8rZakW9BsqO07rfcG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820081; c=relaxed/simple;
	bh=rMRHrA6ir2zM+TezKjAejsiB09VUqdtowBQwN0aCJls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoXl20IGLc4Eto8RynU3tuuLNwaR1sYCmfhlhzoiBKo4p+BtqCkEVy1NtJphLn0BwnFM6absbqupLpgM3K0f5BZTj71s/XyrVoHqdmK9VdstyXqvV6Gq2xzc6BzqC8Nul7gm7+4L5S/njkFzVZEDKyExDa6ZVeREA6ePmgX5+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DynL43zo; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DynL43zo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820036;
	bh=HXdQNn90qs9oOdwd1dM7zH5Q4G4ZpU7LIHfu/Kwi0D0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DynL43zorV2Yy9ziZIGSJIHvVZ5fFTJ47TelPK7By05j2iLiDzYhy5KgNGzUob0yV
	 bezVUGBI/lQGqr3z2NKcg7f5VLHhH9DU+H4JW4b8eDSToR0pIlGT7svwyXMQbksNhW
	 evCVDvHIkTEXkPMrqF8U4JLS6vv6qwlsXeQKWCdA=
X-QQ-mid: zesmtpsz5t1787820031tfa2bcc8c
X-QQ-Originating-IP: J8kZNWj+TU0zc1uFiniavF74lo9n6umCYfYeAUk4K9o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:40:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14010151242343005264
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.y 05/10] Revert "selinux: reject a class permission count below its inherited common"
Date: Thu, 27 Aug 2026 16:38:04 +0800
Message-Id: <20260827083802.4044165-5-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MrAhaZlGeV9qs+0WGSDXiw+Zzs/7HguZpxN+J+LV3Ig6xKFFp4wALDxW
	0fd1OF5XNyxHM3YPLElpJbkWWh4MdKTY0hbbM/V+V4YZQxSP8ws2qd+xMxSUvmqaG/YXs/K
	GtSWA7NqCVytYVBG79E408D/6SJmK6JYsJRTejEHP9z1jMHu08VGkCNg2b/aZ6+5/fctHnn
	U1RxfvQ574qiaHIfOxtoB637m156AbzGx1gH1TFDpmdC7aF0i0l2YABzH4fLcZNd/z62eKK
	MS6M6js5PjFQgE1j04851KQ15nCR2kaZU/jUzunSsuLyygwOoUBx7i7BGwpvwO2duA7FApP
	DdP4bqhWo8qi1AvX5zEbeUdCT3AZDN86kQu93RmmnlMQ4+8uc+k9PWeXSjmD0jzxpB6qc9J
	qlfxzQuSUKlf0nPZUL89/eky0+0J0oKR5Fua6qeIO1OTLq1dokfmYSs93gLq5PaykFDe9qF
	pJSEaiOkdcb5q1V2NLlqWk6vmChF21XTGXqnDlppUHJ2Op4ORs0UANn4QPGTB07bWAWANhf
	cLGJOkAEJnvSIuVPOtGVOW+GkWtm2k8g6LFX/eHZgOkcQD4J6XHPNRpOXpqjnbjwrh1oljZ
	G9KkvZej1zumC5NfXAn1jJuW+Et/5LG9FY7bKaMPvNcJ4TqzqMfvjnws1BG3v8Tsb/02Ek7
	z/L0/i4I8EMDU1Y8aE5BuGMM9uykNh83+vKO2FD+fxQ3FJJ1vTG8BFabGv3o5mD7ytDyKyl
	n+K5pQztz5xT6itYRJpLXnFUuRrAJ/DEBnzm484QNTha4DgPPY2ycxkpV4nCkrhsMvQC4gO
	a2qCWE9DDWSDfciTrHnCpLru0OE52TDMx7CWFQe6q7vmNWOov8BUOSlBwNQvzIF6ImYilcm
	49TnVmkxz3BLF/9hsb6+Ub47R+gdD0cPQ3psfxY5PzwV8GbRiahk/94v2jHyvaxmVXEb+7F
	O7f8Q3shVqcJCiCp/WGsiivMVjXm5xA4Pz6JQU/28dm+XtVXzLM7iQIXH0qOyNENGQgx0JC
	46MxSuZemPuKYYinEHRfckqgYhSTeogzuuUk5yO5F6ZyVdNAPa34aQ7WrEJ6TZpLDPitH0r
	W0hQnISe2TkBRY9We4Y47+IgPTO6eLixeL3Y6DnChccoVr9ZyJOpOc=
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

