Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9533F5B3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950362; cv=none; b=cIiaQk8xeCyf1bwZGq9+5xjZgEd542hRNrBvxKmS5fzOoNrIjtvMBWv3M0HX//wvBC6q3XSxp6ktJmWth5y9IVZtl6YIHXXGQ3+OOdcawMZj9405dS510Cj0MHrDbPzKRLO1oNeqzREihMFKwoQ4L4u/8BDFvvjcjKpIa44Qyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950362; c=relaxed/simple;
	bh=vNb4z/Gk/NfoK3q7CSDEWhD1Zm5EfvzsQO6qHdXHLgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpJpQKediMuYd2PDcNbdU8J22MAOe4Jzu+6U89T1YMpIi8m/4mnfxaYyrPmiIhhw4Ie+PrYLuM/g+zpAPoTNqn1yskY4hx5ZXWh9p993l/kuNV8mpUzEbgrBAmyKBTK0p2Il+33kwdokAniBCsjpZuymiTfpLML24Fu3hNdtj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=N+mem9J9; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="N+mem9J9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950322;
	bh=1+k0khE99dFenLbgwaRKzRdcOabnDSSLYlQ3C4bZQrM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=N+mem9J9gIq9ivNvq7FsZGEBasKevz6sOxdPxNodf63Wcmb6UAvgnue5cO4u3XngN
	 n0e5FEpWUtjtr8BPjlOJiXu/mYXdRTg2hV+Aj4H3EM2x0Yp/Zi5EFMCju9y8Sv+bED
	 0bexvbOHmHrxZbngsJ1CtK+FfffGnVbXh5DoJ+jc=
X-QQ-mid: esmtpgz12t1785950302ta29b35ea
X-QQ-Originating-IP: C0s5ZvXpqQzbmG5lp6tgxSqhCFuUnKJe0wyn3kp6c8c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:18:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4740848146357618269
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
Subject: [PATCH 6.18.y v2 2/7] file: ensure cleanup
Date: Thu,  6 Aug 2026 01:17:39 +0800
Message-Id: <20260805171742.654530-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805171742.654530-1-guanwentao@uniontech.com>
References: <20260805171742.654530-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NC74F6DjQwUfTsCjOIfQIy7NCTvDr/pbxbblNQYy/lRY9Jn8TPXQWru1
	KG6K9ZE/7R3IkEDJStLMIpECwenhPP+MMDCh2cuhwpgvJec0/59K1/h93C3QJtn98qB6f/v
	W/048HgSuQ0poT6Nasj/eqd1iNsNAwt1t6HtBfO4EO2rkPVTsxPMKhDW93rRSWnyWgmrQqO
	KYKQJ5xHiix5N5ADtfR8QpoaT99FY1X9Q8g+9gFLvOxLzZDkkVeebw235t6ZPTHeVfSpEEm
	BK1m3QFOWnjTxY36eN9Nr7qx9Fqz5OQ/xhELmR0B4DZF8vXbZTB1yGf/wSb4seZ6LK2rStS
	Ip5A5NRKZVCWXPKF5zdLTBPHC5PKgiW3sqrnbOwUPlbn9xzG5fSZmQaDFLFpHLBuL9aetbo
	cXRFD9X+WG5KiBeZPs30mVZgl21zIjBUG+lbGdrBiJgemkRDkr9qZq/fBJKXR4vc7JXZPfP
	ni7ASEL2eHqZZYiWt6TM2wNVkMUlCeK1mtFAxb9Kn11DVl3zfKW40DqTw6TWMuIdqqx+/6I
	2XZ3d7Vv/fz9f36CCSFU2QP6JttAV14oveqRjxFF34Dvim6+PsWG0cO9dkt2hd91TTlLz1X
	NVWYZrP+02tPqjTon+3FxGtOd7X5fiK6z01R0yEqwT9qzedNEyUiyFyi/n6de2zMEtUeQCq
	LEPrMkKXkwlkRuOvj+REJ+sHvFM0zH3rxq5q2YbRcVdApdlBvvOdKIYQer+Mjn2RQ1uxker
	28gcWuZxOGIqVUAgaJzi4THMMFvKe+mHrJvYgFmzvWF/R+FWgBrUICWvhroBg111/RB66aD
	d9x9QwcO9yo2+o/0Xa/yzm16TySh8AWRzwITTohkFn3OiewjydBvVIvho+NNSDamH4eSVhJ
	zhuBK2pyszH06ucBNrEq7tooKhTdF8IBUYYbF9EjYRO3hd8toFlFyrp26Z1Qr11qevpF4Lj
	fCxc4FMW3eS5Ok9wZrtH4UCsAZgbXaTuOiF0bC/JykcYaUDX4ZZ+mZ1hg38AlPdOJocc6Qc
	wrdj6d1yi1W2xG1UmB1fGzOByHKucwDnfzrscvCtospLsy5UkJHXCnBBnFugI9KW/ZBluY3
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

