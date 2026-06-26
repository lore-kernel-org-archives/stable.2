Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D882C21DF;
	Fri, 26 Jun 2026 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440078; cv=none; b=RzZ/iu3EvqYEwoVzf7Jd1GGw3Kpx6xlfiqx2L/nhYqET+0mxdKD3uH8ogUHgD0nlQXMERRKjIiuBUjU5vGPYN0TSEv6jvneJLppdlJCqzHmeTSnqUiiXDBjevcrDeSpfD32OpbUOWS697gxtPFBcy/2LnY4cb786A7bmkBad0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440078; c=relaxed/simple;
	bh=odo2qeiMEbS8A/yWNvf06x9KxeN6NKSlu6gwTixzCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ossmwAUBMGXdICvTIPz4nZ9g0DQS5eE6oaMvl3CC7ovtd2/o+Pm0rWZJ0CO1GgBc4ivKxGhzTKs31aAbv6YQ4C0cXU7i/2msDcdab31LEDyPbddAwN2l8QQGDOV4pz08g4e9SWTWPq3/0Xos7PZj6b+m3/fjUvv3lWEgpVxa1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ej4UE7Xt; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ej4UE7Xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782440025;
	bh=a5hzfcY1agv4TmXP7SyF5ysB26HFjfIb0LglhHv0lSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ej4UE7Xtdz6qZmDtV9mrhNK2nJANbquC80Sai/bdYJobVGXBMbluTKr1RTSbqIVyy
	 KiAKVex9p0ZI6MPp2kP0bwO3L7ZF3M27vb5fYLVIqK7AO8L51BstlL1UQm+b51oznE
	 IctDOAnY/fT0laIRk0NEfljHVo+HX5OpalBjb+VE=
X-QQ-mid: esmtpgz16t1782440021t575635e8
X-QQ-Originating-IP: MoEoy4lkfilPPY2vRr5yX8VQ78pqebMiJchDmCFV+EI=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 10:13:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 692030438400580657
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: miquel.raynal@bootlin.com
Cc: richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: virt-concat: free duplicate generated name
Date: Fri, 26 Jun 2026 10:13:38 +0800
Message-ID: <A9EF5AD55FADC312+20260626021338.3744161-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MBKLumFSBSSxcrQuXmw8jLY+gEcfnrdKLz7gNLw9JKo83h69DW02hqTX
	FSdwqgH9CKVPS0QtWTYSG09RfbGneqDWopbMNi51AIbuuMqXoxPcdlXlT9eOvtviQxSqeEe
	PkdnlfIhlCp5sMLqpEAmNiD/DC7VPxwJc1NAShIMi+kaRDQnhZFqOPVqPTwY8OvkhvEI9Ro
	+4heaEcHDRYzq++EktItyVPl+LTTEkjwHGB55wzlXaP2t6WUNFSAVQi1c8HCNTq1COAVls2
	+X94R5mgdrFuZDxey1fG4Fx8zV86i487749nELhltUEoebFPA4DCe1iyIcOwUqyznQXeb6T
	8gxepCeqJ/TmOtHowoccJ0SII6z63Xo3nfrjrVq7iY+a6z1cGTzwGSwJR3BYtmPwhu552Vi
	u1q5TJYHeEtmyA8mf9j//9KmMXijKK8Xyuu2XXn3h3Kov4SsSBkIDl59Mjn/Vtrj8hv/ZPP
	zp+xIPBoiOSGMGHGkj+fQoHJ/ntJAqlSDHuJfEQkrkZdMRRYDcTEIl4q296alDjgSvk0jy3
	TuSVubT08gFITUyI6itF7rsPZhcK71gDV7bRcLPOTxM/vb7tKkbV0O2TM+rDxJquvJNHm40
	I6P9BGRJCF5ZrFIYw5D1+CTss4uLSgRs23BjMXT2o0CwTQH5sPCAFulMsOeiSmLxQo8kDiM
	P61GU5W9veUeEVtFf4M2G8+AILb6/Hff2+hv7cIuTNcDZF8IG77ytLsCOWuloktRRd1dW6T
	WK6KphA0/D+bwtjtlz2JYaiRFQrAElCXYK2QdpfVDmKAKwjhJ3iYlJJNsJ6hcYSIcTEs3Fi
	COO1mQHPJ5+OpUmBaNsUe0Cmjes6UEPj8+e01NhXf3e/b76XVrzarMTBu+sWGtOdNzy8cwV
	XaTukXVma2PO57fPWRloLMfQ8svCy8rMeKgybj810LMyvI/9skqLxz2A11SpGTxpFC/BOJL
	LcnrqGwFroehQEfW8mp0Mk7jWSwt95hd7rdVEGPw3IYWsiUyHqdwTLkSVI3TmBDzdezzzJB
	aHaYcOST4E0u5tr0fqO58Wqjx4nfx3ZWseZCR1MxMJIRvXVKdck3ULcO7nIgh1fXkxLzAyz
	dr3DRYJRaoj
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Every MTD registration runs mtd_virt_concat_create_join().  Once a
virtual concat has already been registered, the function builds the same
name again and takes the equal-name branch.  That branch skips to the
next item without freeing the newly allocated string.

Free the temporary name before continuing.

Fixes: 43db6366fc2d ("mtd: Add driver for concatenating devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Fix the subject prefix for a single patch.

 drivers/mtd/mtd_virt_concat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 37075ead0f33..5db6e648927e 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -321,8 +321,10 @@ int mtd_virt_concat_create_join(void)
 
 			if (concat->mtd.name) {
 				ret = memcmp(concat->mtd.name, name, name_sz);
-				if (ret == 0)
+				if (ret == 0) {
+					kfree(name);
 					continue;
+				}
 			}
 			mtd = mtd_concat_create(concat->subdev, concat->num_subdev, name);
 			if (!mtd) {
-- 
2.50.1
