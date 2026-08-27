Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197D1A5B8A
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809716; cv=none; b=WzhUHhQ5bRUt91zhSI2g+d4vjqYmjof6BQ/Owz85Cf9Q4EY5ze1Dnx6HS70/c1Qy0HMwTyLOEjBNDoncBoCaJZS9PKrhy/pEgVLio89Qlk/6THtH1w1mrse5qp42F3kY/bsm5+uejZxs/nQWxSLPTxVTPlKAbKFggF8YVjuwKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809716; c=relaxed/simple;
	bh=zLClaVM+YW2OUWUWD2wBGVrmp+BVavYYnCOCPqLWqh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0IRXhctkiEPv3zdsCm5oocfGBvjMw74ug3K0c7pF/4BgmU7PfONItsxkHIBwVb4P1H3vmkrOii8+RdRbozszm4jFb5kOpqAcDtCUTRhAlJD0u4GD+A0oRWRJk1a4oXIdrQhWzr6Hc9XkZAZ/59XOZdnOUfJ9fX3RYxRybfkp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LY5FcO0j; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LY5FcO0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787809688;
	bh=1SdNzIAZxBCda4mRgOx9wNM7QzwvCBBWAPPiduSKQpU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LY5FcO0jsjyGuNL+N2nAvEzPIJSpOmB5Itqk3xmvHQioCUpObyBqdNqil+2isLSL7
	 DCR/lslGNvL0EpYwq5mwY7Nb0CpAEwsuvRldDsRWf28P0tuddlQTeqRZUq48F85E3m
	 Wi9XHAjTR3aevKqdL942n3YXGCur4sDS10hl4p1k=
X-QQ-mid: esmtpgz13t1787809682tc9212d3f
X-QQ-Originating-IP: 2zDDm1ecplyzEJAckVEaCvclqaWbYygtImd5/TFqvrU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 13:47:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9066219241035851612
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 7.1.y 4/5] selinux: reject a class permission count below its inherited common
Date: Thu, 27 Aug 2026 13:47:12 +0800
Message-Id: <20260827054709.4027356-4-guanwentao@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mb1BOhWcNIRMfrdDp2LrTowISxecZAZxO39S/cZ7PjhA0lLuAoXwFJaJ
	GEsmgfok9hYjHwBTnKhvBBzvb+R4Un3wsjv4f7gSiFxs3eKq3AuHGxiTwD1P5kmHee8y+XP
	Wvm9ClwEztiPdlZ7Oq3/vypnCkEaN0y9MR+m0muarnUFhZFQiJ6Deyznkr/24GdjmYubSuK
	6vyFcp1fBBoALQkGJQShXyNj1aUB/NXgN4Qb733Rejb+k+kIZXXREmIvUixjso0d+BaIqUH
	eOH+G7iIxlY0jhNwhy5FLEuI9FoeHVOCkjr33KB3eoP+HDbDkjzmJGBR4UTKUgLbgXIZfMq
	hTRO4UmRVCndZdW72YVf6cMdAXx0Fx/Vk5wt68f8/jjOqT7NwiRuPwy//KfBd95C6fXoEsS
	OK/QawdoyoQMLWK467iliD2lvHF2An6/uJfGwmXyxyMDZdXIs0q8AyjnrHhS89Nl8GWvOlv
	T2KEsgPO0GktqvidWk0a/kjm/Og6x4eL6+u29aFi37tn9raz3KCuXVofo4perwhclFLBids
	D5A2zHri63s+E6ZD2lYY6iubxREOc0luiIQ3BaO/5z1amFu0HL3PSEE84Fl35xUET59QPWw
	KcZCrb5ONyP45eN5yWIu4Q4IGwYLg8x1NYPVRAntZLNQuO89htO7nbt9oK6grEd/kpnoYs/
	9zgftz9LBfBCFa1b6/q/Qr5FcRYjXRhKhQwKieSIbpm/vMnjbRkoOD8gDIz/cbIDjfe6vNy
	ug7tn8Xz5sb5Vif0q6pvWf9DlFwqE+wRyB6oyD6nJ19vdTHYVUX8FERGwMsWzG1ToOKRD5D
	0aEVo84IYzIP1LYqU39MZP6FZFPWioYm0kAEt1auRsJSPbywI9veikIQS1XkXY3QtY0myWe
	1/XvH0lS3qxYDG9vo9Yo3dn3JpWICJzp0RnvqANMKMT8rK6etYbzQUKO9Z6ITh/flOtpXOz
	zm5deZSy2enUnhEFdENbxVYBltO7Th/NgTo4ddrzpiY16Q/CQtwep5p2XKr2+dwPGMshQuZ
	k8GHocd24W8qwsjKB9sgSsMhHo8hX6cmtcsJzEhyk7gSwg3y9Vo86BgXWkSZ+OY11jOQVDS
	CmffyV7RgIbtJArUJM59CFsU92CJ3Ell1wF6QJZclrf
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Bryam Vargas <hexlabsecurity@proton.me>

security_get_permissions() maps an inherited common's permissions into
an array sized by the class's own permissions.nprim, but class_read()
takes that nprim verbatim from the policy image and never checks that it
covers the common.  A class that inherits a common of N permissions while
declaring a smaller nprim is accepted, and on load the common's
permissions are written past the class-sized array -- an out-of-bounds
heap write.

Reject a class whose permission count is below its inherited common's.
Well-formed policies, where the class count already includes the
inherited permissions, are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 9a82dcd98b6e6e11cfd162410967951f12152528)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 73fd6f06ec98a..6f085f4307bf2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1377,6 +1377,18 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 			       cladatum->comkey);
 			goto bad;
 		}
+
+		/*
+		 * security_get_permissions() maps the common's permissions
+		 * into an array sized by this class's nprim, so a class must
+		 * declare at least as many as the common it inherits.
+		 */
+		if (cladatum->permissions.nprim <
+		    cladatum->comdatum->permissions.nprim) {
+			pr_err("SELinux:  class %s has fewer permissions than common %s\n",
+			       key, cladatum->comkey);
+			goto bad;
+		}
 	}
 	for (i = 0; i < nel; i++) {
 		rc = perm_read(p, &cladatum->permissions, fp);
-- 
2.30.2

