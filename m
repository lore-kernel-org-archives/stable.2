Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B70357CF4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951708; cv=none; b=n740zb4jjyeaZhRFYPl1UKayCY5PA+aHL76lqKfgdckazT9FlzlnX5VU24rpeCxbtUOQC1Vox/ZQnbdG2Ke0UhJ0NOVq9JFJDUDNw3KEx4nC1FAfiAYB3Xl6PCiZSlMEK1ZwaLoTREQ2JP0F2fdlwUyooGgJ0JtN5EKdrLH4BVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951708; c=relaxed/simple;
	bh=vNb4z/Gk/NfoK3q7CSDEWhD1Zm5EfvzsQO6qHdXHLgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pz1TBMPVtPO4DUduJ5t/TTDBMLXr9TuJ3TlJi4bnS+1m5byyPE5BeO/PRpw0xU2G/XAwb3sqPwOqFivt35aD/PHaMhVMAWcNfc2Kik1nMMIoPh2nwq+csKozBIOUhH8T9EwEYTYslmRIaikHiYbVYq83YoHglM7nnk6Oy69wKMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qHQaujaC; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qHQaujaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951674;
	bh=1+k0khE99dFenLbgwaRKzRdcOabnDSSLYlQ3C4bZQrM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=qHQaujaCENnDbaY5mkYhhOb4sL8V7Am6pT58qSEsFF+oTdsCEtm+kGHek9JNMKJta
	 gtJRoUnzgbPJx//WlVZSRZiFIUix7WIUiv6PlpzBwYog6m988867uwFGIS3YG25Ooz
	 blYfQhCusrgIE021xk/PKFFC7lS2ynlL22sXWQgs=
X-QQ-mid: esmtpgz16t1785951654tbb9298bf
X-QQ-Originating-IP: gs6r2cwE8XtJObA4uaAfm81/iqIBfdRVGzkkSCyOcuU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:40:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3183735670474334919
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 2/8] file: ensure cleanup
Date: Thu,  6 Aug 2026 01:39:54 +0800
Message-Id: <20260805173958.660310-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nm2MClTYkkzhjDfb3OlqWMaMUpPXL1FfQ5bFMw2nh9dRjwjX+1sQeKdK
	sYaoUUAsOw3J2ppELbdsvF/yD76Sa84yPfDY17Wg+Ly1qwQ7bTnsEs55jPqqhnlEGvF/Pp+
	6/EHvXLvW5E8sxlkYf7nzg7w6CXBmcvOfEOOppmZFC3L0N8WwlHz3Qb25/Sn4l645TMDGz6
	Ok5B2hGsl0zpooLbrqc7sXkCjU+P3mtJtuxo+S53jfGB4U2w13MwFr/Ka5PMOs2lhihEJCQ
	/+lrdkoUMtS5V2RpGmMN/GNqab2vbRH6jxMJiB4+j+cEBlM9VMX8RP4QnNZmJsb5agWLwbI
	ke7Pf8W9Vw9PbcfjznkCcg5H4cfYFrGc4QiQTh86h7G8K+aq0QtofRfLOK2vPPq+Us9DOQc
	mKRTqpGwjzvsf2dz7g4NLt5lI54yOV1AG6zbpUP84K+APC6m/Y414DLa26z421SzriduKhs
	zpIlEvUeuZxhdRZdLGmRfrgejU7QmqhPLx/zrV0QWT/Qi47oPuM+X37PXKTfyUIOWwujIgr
	6hVpITHKJCmzdcDuKc9TFnCkB498f1ov/2KShi2LGGq9HexCBNGPVvQC7KjtIBKguPzl1ft
	OLFS9IebwIkxhKPDS5v/jPkoiADHgeGPeHIKePQx/c4NUWFRnZtEnpo+SCkLKCmsSeCWbpd
	LNT4EnQNkYvebdPRiP+BF+AeYshti/sFOcyGQB5tN55jWw4V/KETgHvhAYk6R5nm5J+lFyX
	WpcmXWHDwbqzlGaHpLRbiGuTciHGy7JMk73krCX7fHrYoKeokAaiVeM8+4jfpYC2bN89UHt
	d/SoLPU32MAdZuYvQrtMzHhfV1ASZwqxOWOWwXnfLKtntPejDlKM+s4Sf6S3LM0jlvZEZQf
	UT6ce2mKKdAwdE/IY6e2HYdgKnbayE3bOdNT8yyU83L8h7PHcbqhtm05W1I+XQ3Xdr2A3ZV
	FRq2sdmxitW6bXq0GJV4Hm4Tf0oc/tcrsvkEyIyAY0HLb9uBJvCp4hlGEc9oeV5BFM7Jfvx
	z337m4+6x9pSvBItH6NTLNbCTy0vEz2d5LDRYFFdZD4jqcB2SosV8KP4TksG2v9xCtGNV0h
	/VZJdjM+IJsHmCHIexaM89HqaEj46kGu3VbM6tbBjzKJWrmbbna5vNLaIw4rpDvSp68Bk+j
	yd8QYx8fULcbshHoXa29A6uLJcncqVu55tpZYgFcHvuAMFXwCKa/VaCMlA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

Brown paper bag time. This is a silly oversight where I missed to drop
the error condition checking to ensure we clean up on early error
returns. I have an internal unit testset coming up for this which will
catch all such issues going forward.

Reported-by: Chris Mason <clm@fb.com>
Reported-by: Jeff Layton <jlayton@kernel.org>
Fixes: 011703a9acd7 ("file: add FD_{ADD,PREPARE}()")
Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit d2ea4d254d04a89e17504af0230c7268e3cac6bf)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/file.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index cf389fde9bc28..27484b444d315 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -161,12 +161,10 @@ typedef struct fd_prepare class_fd_prepare_t;
 /* Do not use directly. */
 static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
 {
-	if (unlikely(fdf->err)) {
-		if (likely(fdf->__fd >= 0))
-			put_unused_fd(fdf->__fd);
-		if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
-			fput(fdf->__file);
-	}
+	if (unlikely(fdf->__fd >= 0))
+		put_unused_fd(fdf->__fd);
+	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
+		fput(fdf->__file);
 }
 
 /* Do not use directly. */
@@ -230,7 +228,8 @@ static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
 		VFS_WARN_ON_ONCE(fdp->__fd < 0);               \
 		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(fdp->__file)); \
 		fd_install(fdp->__fd, fdp->__file);            \
-		fdp->__fd;                                     \
+		retain_and_null_ptr(fdp->__file);              \
+		take_fd(fdp->__fd);                            \
 	})
 
 /* Do not use directly. */
-- 
2.30.2

