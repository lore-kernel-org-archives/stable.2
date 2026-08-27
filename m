Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B224ADD8D
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853220; cv=none; b=Jhahm08miY/jyleCHLyNBT2oJ4ijWWWK25BEd30DI0dTPSK5EtzuPbzeC1SSUx6x06Ig6DZqSq5X6Y/qomQxaSLkXlNTK6XezaATH8NVQy4bfxs4PUew6MlkkeuiPg+aMnt0TURQV2X1hAq9FJ/6O3kbAuywN9Q5Wggu9WBymOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853220; c=relaxed/simple;
	bh=kME2uvWNfipXbvDyySkw84qMKmU1iwqStKUrYf4OroM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEhPGVdrWPqf1Vc/yhK96e1OZwJeKnOoWhTnAOXDzLUWNyfzuS/lOIwiQWroily8N1o4Uck8jWFxIazyxZBLDTG6N9ucIg3g54f1pKT1tuOnlqfPGQ3AZFtevdulI7BPHpjsstvNPvvHaOdJWwB+gg/t3BU5TemjIqr8IN1+xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=O0XFc63c; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="O0XFc63c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853184;
	bh=R+U+qeKfeltoTA1hK4law8Lv3n4UdhN8liZEs7N/Q/A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=O0XFc63c563lZYjoRUmsmtVz2/S3s+gcxJ1oo4xjWguPKoIdg0WtC4LJlcU0m1TDl
	 bAL2+jaVUz29+Ao/yZCwfP1tCBwiWtWLj+s7RP/BtJTZEghFS73nb5EHV3GiXvfvpK
	 yILspfqwi6iV8h93kg9KBxwgBEW22GPmhUghEaCw=
X-QQ-mid: esmtpgz15t1787853166t22cc18cc
X-QQ-Originating-IP: 2Nu5JpjjCelg6HFLC1rleoEoZnieD6eQmVY3WoHWXmU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 01:52:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12549172429292100936
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 7.1.y 4/5] selinux: reject a permission value exceeding the class permission count
Date: Fri, 28 Aug 2026 01:51:47 +0800
Message-Id: <20260827175144.4174620-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827175144.4174620-1-guanwentao@uniontech.com>
References: <20260827175144.4174620-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OE2SNMSfMbmOznHFezR2+q3IjpPnL2e5wNWznhoW5aeeiKPb5d1T81ga
	NxJJYDVyFr7f/5phHjEmWelclL5O0u0QNX1S2ynE9uvgbvfC8Muxi7PDL8HGmYB5fDlCTT3
	tJZm4nWNvP84y99MUjbW+PKTdLx/bYb9jeRr5TUWh3OxedGEuv76rgtAGDhMi1b/BqxQ2XH
	SQQROMfizhDEx1zAvjRdNSt3mwQSIo/p0QDrUds084NTwqmYxdqQxNaSH381ePV1JUzpezm
	n3VUKKeAwBmqzhzVg/hspyYTzc2jR0W19slyjnIHU55yGLETVqP6GMKDZxwzJUhMMcHmZYt
	DZ6Vdx++izE+az7WwjLi7c+o4zhlS7pQ+rJ2+SFBH9JeyvRDpgT41gvPAI3n5NyrRLUacpD
	VxMWuUTUP47nVCGRiIL+m2PVe0M3/z3BLqkXP15baiGgi5Y77LOFfvkZBW3tsU9NeGwiTjr
	CHt1MpY4rvsp2h/mSGlSYqNIqLA9tq2p5mO0JwY1TyxEL9bWH3wSz45FEsiGqvNRL7gNBGa
	HfEJoeG7XYLVyR+TwnvgyOQCCTFvCKP0I/aSAj0gHJEYHDKY7Xo1Cyu4CYfXIGIda+WbqQT
	a7R4sYzYjxENjAL0e8XgcNrO6Us4JULpYCDeXcudazL1UItnfUZs/EZLpuhIKlNe64ew51x
	tLria3+RUOSQ9NvUD8Cp1vdYFDuKJRyoKei7aW4vjSLLfZOd0QC45q1KylruRzLVASjjLKH
	o8gZ7FYKbNzJp/46GiDlxeZ8l4aygIhB8zt2MWFRAqqUbwDqm2iftVyfA2xJQl9LdIh2D1w
	0e7JYvGxmp3bHSnLD8ocDL4xAmfKfxJ9KBh+WH6PcVquxnhly/uz8InArT3/ekUHmowKqTQ
	QLWQEjF6ZxbMZEIZvkb98n0EFEs1Nm4r1nSFddw2XzTqyx02e+Be0DAmVPe4kVq7ioSdjJw
	UL59GSj5YAGAwA3uhMAwBTk3nO4kPPhefPT+5+efm90+hqdp4v0RTDwi6ovEssh86b3evYx
	WCysSg1KUr7AWzLoRcxhpwp6hXdTDwyyd6tLxhHZiKmGPA85lKcl0ztSP7/itDl2SP53i2k
	Sw67Uqf/Pyr
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Bryam Vargas <hexlabsecurity@proton.me>

perm_read() bounds a permission value by SEL_VEC_MAX but never by the
nprim of the owning class or common, which is taken verbatim from the
policy image.  security_get_permissions() then writes perms[value - 1]
into an nprim-sized kcalloc() array, so a class declaring fewer
permissions than its largest permission value drives an out-of-bounds
heap write.  The top-level symbol tables are validated this way; the
nested per-class permission table is not.

Reject a permission whose value exceeds nprim, which is already set when
perm_read() runs.  Well-formed policies are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: tweak comment for line length]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit d14b5d0e97fccd27974fedc03b903408872907fd)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ef5bd0736748c..6f91f2bec80cc 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1159,6 +1159,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = -EINVAL;
 	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
 		goto bad;
+	/* indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
-- 
2.30.2

