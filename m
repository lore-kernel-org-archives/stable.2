Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B303B4E81
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820119; cv=none; b=bpYVo/PzIhOAi+LrBKv+NwZ4r5kaSgBobZfhD+N+6vvSuzGeGf8xtBwTMK7fy6yMI7hyRJGH8HnBFPbYbpRlvp/vvq4HrK1EmwbUZZfZJG6OIeYjBSEGxS8Sa6vj477TgyHAyt8EdT+dQjcfbcKUX8t7tWXAAJjNaeerfW3y9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820119; c=relaxed/simple;
	bh=ZiKtsjFrYmD9eu+0omaWAVGrwZPATDIIFfmJpEmQJwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afGgKX0ZRqnEhlaNRZORlSJq+S2bIxOV6Sqsm68/zeV+yAFYnXp6AX+g7RqcIAX18d7s8pn+hfjhDcN8Vpx943qt0mi4zeqQWwa+Pz5JWrBR8ajmbgk6Bv3vxRJ/FHUzYMMTjZhOfl9ma2IDUoapsbtW9DMuz8wJ8Zj0wXX/Qbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iMO33XjL; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iMO33XjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820083;
	bh=Jc9vpAiaebZkbbADANJ3PXLqG7hZGEdC6jb8QDqEohs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=iMO33XjLCF5+wWjTP3tB9Qqftfd51mle5IN4yXMl1+ZjwPVVgUWV00GxmTU/uHOyp
	 cqx7rL3GqnpQzeJp2e6p7v7Bkv/fYVD+2WwPatGwbpSqjUtfdqsbGOJXqsNEadzw2d
	 BoSKMtP9Vhs6eyQZUADOFcMCV+tJNjHzck3FvglE=
X-QQ-mid: zesmtpsz5t1787820078t3f945f3f
X-QQ-Originating-IP: 7zw7w5xC+g+8ugLf1eavPUvd8HmbcvYLAjEDPuJq3d8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:41:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12647037967849925747
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.y 09/10] selinux: reject a class permission count below its inherited common
Date: Thu, 27 Aug 2026 16:38:12 +0800
Message-Id: <20260827083802.4044165-9-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MUpUvtPfl+lLCkVyIICUMui+kIc5G1IZeujLSXiTQ5GliIQBgvvkk4PT
	fHQWC5Y/pZp5jY38kQ/Amja8Fvb8RLXktKAox55jUvABDKm1AmqpVOab+0VSnVWpTPoByxw
	2eIiuwZRruyEmmI7entEA+U7cTbEYadgSe+VA+hnEEd9KFbbNVCUQTFa96Sr5egn+JmQpvo
	qKEwluq7mEiXGt5hotoT2Sqi2XqgQQHDyXuyYSvk8erI7keGWdFiZqZsdv4LdLvaElF0TZ1
	L5JKUD7xpvGgxvA4CXl1fn5ZPUFvY59Cl9Ef1owtDquqbvvDyu1pZEwf07FjI5D+7ce+nyJ
	AoMKV7RquViGWxG8yL2RQV2YJj6f5y0n82zmlgmIPG4uevj/GxhE+HGmhVUWQwRCgmTEchx
	xo8oiYtRawcM+bHbTNrpdl1XD9U/LOiCg94Ssto1pAk1rXVd7F0JkeSofksZnKMVybvrHXX
	oLQ4wb+x/Ipu7Ycl7rdVOinG38uS1SdZSUWVBSiX9SHi9xnIo/PO737XqS1zG+shvpgARHW
	jhOV0zg7e9gg4NwCwL+uxVpUREAOybA5XlnTIUj+ncBue/bWuPLJhg1jB2+9LQoJug1kACC
	XUnVcYYIJ1wiA5zTG4YyHh5Bbo+ADwN/sewTGwOLXUQB7LGCEKduRmBSYLBE+q9yWPXy/ZU
	mcfZeLZMVeAmLcZfEMFnlJV1gCN0mCcCGbjjrI/lZ7mrGOpqtYaJQnbl2Dce2ZMF9vmtmLw
	cjZlf0n6lUD39+O1M5XUhWu0Ass0yUy/zv7qzL1q/uNwMznKGeWlUdhsPGeUGPr9ff5u5mS
	rClV+7nanEcuL3CqQhld5AIeJEIJx/Oew3JDXxPmqThdwTx6/9P/PP+ts2LIQsBms/qzllZ
	nEryzBnasp3g+vrLSsptQOnykvGt+rDQHdLuUeQeG5FH76o5uN3nkW59WKViXC9h73K9XnZ
	Mbvmk3TUGaT8W6DZ3YFg3/4EKMK29Y07/EzHHnHwO6OKO8OFTDGSD8+NcgU2mHfpHRk3Ixj
	QIRne2nPaDibOtzxGO8I65BWIKQtmizS72CF0wt5qCPIJbDygkjE4BV/ZBbom+gYFBdGIS1
	Cstuk7GCR6GdbOxb7+lMjfx0kSc7ZXeOnWja+zetBXpjCOrsD5p72cGwL9jP1a0lSqgeZRt
	riJ2
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index a3d52beb65487..926dae3731a0d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1399,6 +1399,18 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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

