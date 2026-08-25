Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC23F328A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652334; cv=none; b=BX9TPz/IUuCRqYAZ7O48xkKHb/0X1QqmQiCsTK/RIzQBayV+hgwwaJ9VCJC9PQ5UNfxzZYuN2AgRjolrNX/zIJk5gp9wHJTyuCyjZcCGmPIr5FjvAUUjg0Bn2fylzjw27GR4IYbaZsbSyv5WI2tWP1WEtChIw3z/7Z/9nQvfLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652334; c=relaxed/simple;
	bh=ZiKtsjFrYmD9eu+0omaWAVGrwZPATDIIFfmJpEmQJwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aj7yxp8VG1CjtCWnJLGga+JgxyhEC+tBB1HKsaFOBxJtm/A2d0a9SWcEWw7kRMRTDHDC9AUmKmdUIEuw0PcIR1MQs+2Ea1ROjSbdW27t/DPjktMyZ2B7xFi4905oakNk/VpISx+Ajuy66QynEcGazClxsIS8ZqT9fhXK+XH9DUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Lddr98up; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Lddr98up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652294;
	bh=Jc9vpAiaebZkbbADANJ3PXLqG7hZGEdC6jb8QDqEohs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Lddr98up0esKFBFSadk9les+i/wlKVC79beZobWGPZQDO2BOxura1dR+kINM/CeQB
	 xr45ZydlVmhOgGZuYzj9jOspgSRa8bewpMpwVCnKlwo6TRPPXv8b1eOFef7WWZcrQZ
	 df1I1W6R1fU0cN1Gmy5JFTCw5NXK16r1FY161BlM=
X-QQ-mid: esmtpgz12t1787652289t6dd7221f
X-QQ-Originating-IP: 2fdQN5hpC60sd/4c1Dd6NRcWmF0XGZRQjP1bBIb8QKc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:04:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17274834587467819073
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 6/7] selinux: reject a class permission count below its inherited common
Date: Tue, 25 Aug 2026 18:03:43 +0800
Message-Id: <20260825100338.4039846-6-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: M0XRuwmLFhqHwfnbJGI1BUwDpIPpIPyXMcb+CitbkNx2PMyXuao6jAj9
	Mdu6moa85brKRB+b+RDl8hxBVHO+sdPZ13/DSHybZ6d96+fBxKcUubIpyzdtsAS2WNN/5OQ
	5qn38IdAHJ3mZATkVsvxX4MIq3nM8IbUVnOxEFAG+5b0IAr2k0hDn0Y5Bjz+HqyHcNzlLj5
	x+SGtWHuj5UkLJEBrPGaRld6NgfeVHbaRehdV+5UvsY5m+yv50mzESqab9e9ARfNmlgRIxJ
	rA3NmuZRpq+9rNMMpP/l/3xuQNx33xAEmts3+WBR9Q3GAxoya7EbZAAdbNtQWkBntBDp8+B
	EBP4bn1wDQuibBFGE7O0yuF6z6SmjMsxIDAnkSGAETRQiL9zXi3EGhwZsP84+/tDtzxmZGX
	47W6H5LlHLaUW/KY511HnMCbjug9keGHInGFvmTOpc24l7S9UbhZ2K+RLESxaveMUAfR63u
	eDl2/4AhZ6jK+fQi9q/4Kgpeq1Q8yg7c56K/i90NHXIHDAyi1Gv42ZeSeEpXZh7yA3pHnJu
	wbyKD8NkBQHUiusAIbqOo0uvywilVJT8DCp3LUHBwIu4a2t3iySumFyDSX5iQWpUZ1Kncxz
	FffnpnB/Cb4Q6dsW6mxcacwTDeAtVZlTluL3wL6PQ8WhoAvkACI0l9/8/nuog6aHfxmNiHr
	iaHPKmnrK6swaxGX8DM2+ON8psqlZp6hhdUGB/ciBBqOlZAdr0pfyHjF/8y0q0lOHqvFke+
	cL4VrMFBr+eGo0lDqs4ErZNqwUeF83q9mTSoHORU99jJ3jozOiv/L3zm9BtdmLNyV8JMdZ6
	Ya64WWkc3tBKQ1LWBcj1Zp5+T8pXEv2dkxGn3OxhzIVtDNNaUbYYFUY8g8OaBA8CNrgixzz
	IWKs4I0PKhlx37ZeIh3OQSXTELjUSmouZ+DwOfeyEnE15iVZ23udSqltJ1RO8xMToC02zi6
	O6uWuqVUuQjV012TJIJcPIrSsykhdVgJpU3/eufgeZg1E+QI0fOkWgNGII6vSGlwLW4Rl/v
	qa4DFcmLSUggJv5xL8zAFCu5HNDvtA75od706kpFksWNXA01HA3BhbPnsMRrt3ON0HBPkjc
	Fd2tGPsdxDIvLm4KIepWId+zArvjpsDP7ZLmOra2NRT
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

