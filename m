Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F8395D8E
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813977; cv=none; b=akL0AsSlzwZAOHD0WBGcQSiWQmQBGbqfOaBDO3OgjAvIOu5Z4JnMDLbMmjw/sEudS0J/LeIWICVvKd8zXxEGWXZc7sxevchIlYQccJagUwbP7bMjTTE/eGfzmefpX8hdqQVGBVN0nZg2bBhJOl/H2VlZ2MLo897IRJP8LmWSnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813977; c=relaxed/simple;
	bh=gGQAAIyoD+h7Z9llH2gkofmyWJfpV6p3d7RJw6eTTPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGOh7/abDGf9tPUWqbN4sAob/z9wbAZasYILQhQswcgqAq+EKg4R7OG5+uhziSqDyV70yHZrqKQlU9jdcueazHu1ZSFN4x/7qF1yH/iym6FW1y44WTaJSYGhpirA0b8TOhfCfdhmk3+HrUFY/Y9oabqY94PNTzwRL1LKG0uP+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La8v0TyG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La8v0TyG"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so36224935e9.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813974; x=1783418774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtwliPDiq/xVOyMkLB16zfgx4HPYeHz9vWwy4071LTQ=;
        b=La8v0TyGyU1+S5DtP1r3uZKe5jaL9yAsZNs2/O5nDUZaNlJxF3oXnStG3vWZOD9JRY
         DaRIA40HLcLkW/SR3dFSLfHKImNoMDmWcaugm93KAG2LBUe2Y16PxMtFFXqtNLwvqU+W
         +WBP23ZcCE8rLiEeTvuUEHKIM8YoCL5FlD33262Pt0a/SwGH6ScdrfOT9HJS2wJsVkBc
         HNeJjLsHtVeXMiAD7XsPRKgVzZI83jlPj8HmAGxc9YDL3vlR0jIejTGcmrDOnJAUsRJI
         ARHAm56CfTwrAA5V7yYmWma6Fpgtpwc5jRui3En+V+ujsQdwSwctwWYyuU+o+mzvOTFP
         qQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813974; x=1783418774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtwliPDiq/xVOyMkLB16zfgx4HPYeHz9vWwy4071LTQ=;
        b=ZRwA81kNjqL/4OmP+Rfv6myXrwj1vcf7TpZPXKYZkIjRvAfQLAmwHPBgLH7JGwyxWu
         HHSqoheJD26oYSjpD8jucJ8ZLAujIgJ9yruOVVEGINdq8NooywgvcFDqSEXEL8nexTjX
         GQdKrJPRX5LYiXb04o0hfkBoEDymXSYstKSCA848Tf4l885OUBEhHWiJSahchaKf/4mK
         j0vZPiE5svglJKLdvsPKrue/s2njGZMEaB3IALd0LRfjlhhDGLiDH4FDVl/JZPeKvHLk
         w+IwF1/FTpvgQGpPa6mzgjy2zUcnoIyZnIwMztUJ0bw4sZ9JHL05AXXMCIn+b73LFrzn
         vg0w==
X-Forwarded-Encrypted: i=1; AFNElJ+hfXUI9bwzI0UBIoDnfwM7ne3ZYqst22g/UFTPfZN0Qk8Oa1wNoRvST7RlzU3z6PYvF/U0ruM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2CTc0+ubSwZVvYKpFzMEWjQExfGTo7rwQinWpyrxE/uW02JY
	2pa4/ZayhRIx/mkWx2NREJJtHerzevWOVKZhxgVWUHHGAqcmCy0hz21T
X-Gm-Gg: AfdE7clBcLZunjyuua+2+OF/jtTMqjKBm3uZClSErOd3kf4UrxX3XqV4HmmxbPTvfIQ
	9ecsEqCoC/yop/xIXiEDy3g2/aDSDFqvKx68odIDwo6E4J+tS5Oprr4m2V7RZSK/GB0bOkhJSbJ
	tP3yIEX1fvjIwTh1FdgjNNjyTdpeQGrWo9zPFHSnCSytV837Qbip9Qpysf2d9Tq3sx3MVi8s0qi
	rtFIqoyCGDd4KbpBVztOabn3ws0W5qTv4Z90HjXBwnDr8SfqzY+ZB4c6P70lVasU+Hrebat4/kP
	GiFz9Iv7IK+8guc7fBo/vJ3GqxDlT0l262vbA0coiSD9y8wgoaDwyTxjYOjXHLs1h9SvDlR0QK/
	R6IsdWKZJLwAY1QjljI5dUXI0+N8aBStcLcv8eU/HMcciXsdGWgnwrBunDpia2IusuIsFi+ggu0
	7tp/3PdlSpKyBwnN8Q2PAaG+P15A==
X-Received: by 2002:a05:600c:6290:b0:492:5030:5e7b with SMTP id 5b1f17b1804b1-493b8288851mr43492795e9.10.1782813973931;
        Tue, 30 Jun 2026 03:06:13 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0afacsm63712565e9.12.2026.06.30.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:06:13 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] xfs: use null daddr for unset first bad log block
Date: Tue, 30 Jun 2026 12:06:07 +0200
Message-ID: <20260630100607.7150-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xlog_do_recovery_pass() may return before setting first_bad.  The caller
must distinguish that case from an error at a valid log block, including
block zero after the log wraps.

Initialize first_bad to XFS_BUF_DADDR_NULL and test it explicitly before
treating the error as a torn write.

Fixes: 7088c4136fa1 ("xfs: detect and trim torn writes during log recovery")
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b7dfbed0c6c2b5e9fd34
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Use XFS_BUF_DADDR_NULL instead of zero as the unset sentinel.
- Test the sentinel explicitly before handling a torn write.

 fs/xfs/xfs_log_recover.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 09e6678ca487..5f984bf5698a 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1028,7 +1028,7 @@ xlog_verify_head(
 {
 	struct xlog_rec_header	*tmp_rhead;
 	char			*tmp_buffer;
-	xfs_daddr_t		first_bad;
+	xfs_daddr_t		first_bad = XFS_BUF_DADDR_NULL;
 	xfs_daddr_t		tmp_rhead_blk;
 	int			found;
 	int			error;
@@ -1057,7 +1057,8 @@ xlog_verify_head(
 	 */
 	error = xlog_do_recovery_pass(log, *head_blk, tmp_rhead_blk,
 				      XLOG_RECOVER_CRCPASS, &first_bad);
-	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) && first_bad) {
+	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) &&
+	    first_bad != XFS_BUF_DADDR_NULL) {
 		/*
 		 * We've hit a potential torn write. Reset the error and warn
 		 * about it.
@@ -3575,4 +3576,3 @@ xlog_recover_cancel(
 	if (xlog_recovery_needed(log))
 		xlog_recover_cancel_intents(log);
 }
-
-- 
2.54.0
