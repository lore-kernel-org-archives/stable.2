Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03C1A5B8A
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809706; cv=none; b=SuvFOHjAAAQuCpkfZvR9Gts69abNuQs3q/FDfUAu/ul9QUHcQ9Yh39cGcXDFZjx8ZxXV6aITfxn9Ct5ZgtQPz7FI7UTgd+q1FzM83YZiJI5bguJLImKo4MlGRdmhGZdIFN9zCiwFT0Jbhbs9P1g8+A1WxLiebt5E8yvUuBV9a2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809706; c=relaxed/simple;
	bh=+p0wB2Q6n7mLTyahB9rkL70hZqV95S/b5n06+OBMylQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8XrrjLGqAYRn0szabm+lCBMsfaXBVzDiAQWbn9R5i3JP9+qL/PCoS8RFIlxiQR0Bcz5mdbLJE91UKJOMTrlt3hAX5ODNspLhyfG3sairufFMschLfz2VGzBVXrSzROOyLqqT8cH3WgRfuU0eV4Ls9DFnO/AeYBrNe89oDErn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=foXEs0HV; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="foXEs0HV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787809674;
	bh=cu+rdKNqEj9W4XC8VeG7CoxrlVfBbnEBtXTxHt5ygNk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=foXEs0HVW+A9glV32pV2ndlFGiUAYOsAjNqF1Xt4LTo8TPJrkdIN62dncGn6St9ix
	 aGrvSd1DevYhE0LfR0Sos/RY2wwiOKKt+AlvOI5sPLAXLjsDjAaIR6xAGhc52Xz8cc
	 MRtZN0MvU5fgIL7lyp7WxL+7ctTwwrkFTKq1P1eQ=
X-QQ-mid: esmtpgz13t1787809669t46b54ece
X-QQ-Originating-IP: 6Q1+5rT2ts9q8ct+XvyQwFLwuhHLNribzErJIS9gGNg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 13:47:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18135225362963407065
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 7.1.y 3/5] selinux: reject a permission value exceeding the class permission count
Date: Thu, 27 Aug 2026 13:47:10 +0800
Message-Id: <20260827054709.4027356-3-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: OO2wLqYBHUeBkxucrQIDehusGpEWih9SGT5t0RBDcUOpmhM/pRzgAFtX
	xwg3lTT2c1QT0/C1Bu5RB7BJ4dptW5MAPa8PfsD/QiE62/PQfk8XsbLBLd2YZan2TnYeGli
	7rOQm36eo75DaW6XNIIq7qN49KfG5UHta3HnU9YHM0DxwAQLH+DlJ75KX6EBV11A5Z/nIMH
	UY6PMSljT1xuu7oltvobi5p0BqcBbd7MM0HOhcXNYT85hvsWAsqDlOXA6lhGuBOj7qDvjx/
	JCdNJ3P3pmxZTvO+ELTmW+1qRRVxID0/xwPSQKiCAMF/x1JfJ75uIlktFurzqWrbNOefuaX
	JvUXN2hSbfzuAlJuKSu7pyCj0DayJXvGIi/qiXA7OeFkQB9zU/wgRYP317DMhSssinTD+hr
	nCSFoKMoL7/e+uEQK16qYTrmPpl0+l0AfZLIL1VjEH4mnIzCH7OhwVMCEJ5/hp2o3VnXHog
	yJReXLkTVFLygyTvUU5H7XwgtEdKADTOBBkHgJsCkotvcO33BPRfztM6CuLDXa3PtXaZCaL
	OhrSzrJOxe2zxCSosjU1B4UWRJKJ/gqE4NjNOBpEVQDsSz/FfajjBFgVARbDR+332HYKQ+p
	dfMqBQ6eB5Kotlqq0q1MgUrnfWg7QFxZ7wo70XBcltuwIydPm55nWkgALIiTEM1vJ03lRb0
	YebOZCklWCPMvUk6uXJDi2AfNDpf+/NCy6OipEc6SKdKq2MjfjQ4WH4T9bs1HHKVEO84G76
	ioYoS3vZs+OQc5P6cHgXsqrsXf5FNnCXJVV4IwFBHxDQRck+AdItD1lQabPonRR9SvmOjP8
	f4gDH2FPceX09vrdW6/AIB7tcmO3xLvpoR8JX/KkyO8I+oxLaLKiSkh0OIrMYtYvb6yxLcj
	JlcTDUCWBU8/Fo4Xrnpky3lB2eooJtURmA+fZeTQa9vcJgj89/D031GCdl0915Z0WAKlcHl
	7lSl6cz7CMAj2iNPmiujKRT8StHygy7thGOBwg6HjSpim4MLeIBNW+XYvqUoGOnT14jDmEo
	2OA4P2P5iOyJ6OqaSUDayOAXmIloOgZ4lFqE8nctDyr0Bq+3cH4JTvJwdEHaW97o3GLXtsw
	POWoERC5vje
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index f0be99481c585..73fd6f06ec98a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1140,6 +1140,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
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

