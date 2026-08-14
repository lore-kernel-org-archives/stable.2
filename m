Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BF35DA55
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675814; cv=none; b=NVwoBPG1GmSJFPBfsAS8I2kqcAnQ+wiQMyt31pjYTysUnxk0O+1WYfEmawWtNKNyl1iOUOGAtERXtWozNJaF6+ifOyanv+u5/FXMy9GZh+jm62lDvAsvCrd9LBQOBsR5/ciq1dcXK2uiz+wiDNNOQEhYfQiSuhxSvU6H9TPbTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675814; c=relaxed/simple;
	bh=eR3jUjuO1Za+ASq0DovLqz8rhT6iu8+6w/M182r1Rhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzvhThsUreTT3bojtK4NQ3Bw9XF7zT5OZuIkuHXOck3b3Sa5TlOLnknm9lslFgoGpeJ62B1f9qVzy9xWwEDELOmBurVCMUZSda4dBoMypwPzTaFS1GWO513Ff0Im0Nbu6v33PrtistuQLsm4ihVSz/QzH4i5uLbYUbQyOyqLCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR94X0nu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR94X0nu"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeb4508f29so3428566d6.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786675812; x=1787280612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LRwc7YlERJIorjY1Ibj5XixURn1upo7Jd/C+eZrxYAo=;
        b=QR94X0nu93gzyVysp2vJkTMD9gR/I5F6+nODxIEW0d6jni/La68wsAgCusuelZmZWb
         BOn7A2ZUmJPH+J1uc1whsu+k47LSznnxouIojAxT57REtbUVBMEjGI8iVW2Yx1PxilhR
         7ca9h/15PkQKEEUOaLZxWYJT3X9EFZsaFFqoh1GIXKkb3KFydMWjUIoZiADq3B5CSZ/L
         o1CbmtXjccS2vStMoR3pCoIexNYqMyCEr3XnuE9TsVrBVUC4qNusB0/kD5AO2jp9TEmE
         14Or1xpo/R7em2Q1c5J2eyXMfJo/VvIdAcvDG1OJ9wjAdXMxJy4AHQmIn/7ExQZ16rxY
         lveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786675812; x=1787280612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRwc7YlERJIorjY1Ibj5XixURn1upo7Jd/C+eZrxYAo=;
        b=Bsis7Tg/hjebbfOO0qBVFoxzOKumo44r4iiMhxdsWvI1efvtJv+aYl9SDVgNimeARj
         ALV0tU9YZJC1sJQJFwjn4ObgvfbVChAWJJoMg/PTBQKfgOXEOkuXji3RHr7fiq/fHuYH
         TroCMIBihj45a9coQ2wFYj69SNkTLKvOT+Zb53BdmiAnOIaU++Xi0WnscbC1/3pcRgDs
         0LOsJT2NxYhrenMhzHHJILG6dJ2k3lm/6ETkZpJuyrq+N2PlyfHk22+3Jy8fo2/VcuX1
         JOfDHCC0HW5S8YJnF5lO1a7y0TwYCv3Yyufnzyl0el3pQtcdRFBScQSjqn+xxqpgHLeZ
         ejeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzIraJsSViECI/YSUHhl5/Q5jz1UdRaMeqeKyzLhsPx+Xqt2/kKMxcJ6uVrsycPIaODqhfIk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxga4kPxRvgZS2pWBF6PxdCjjvbD1eWPvcIf+SKJBMAXCLuJ8o4
	GAHtwRo4xLAuMa/qatKR7RetRLkrxv2YWyHXlzmBY/iGm8SP5WLAdB/SSf2jAzbW
X-Gm-Gg: AR+sD10YKae/ansM0qrtdu3nRC0o0Ho14CWpnZZ1MewAtC767kE2/DCrfdPInYatrlo
	qn3zHEHDON4tCBEq6zMkXsCp/2WbPTUdHE2FtY2HhjLUn0jnVvcnOlstNIbSC9UOLImzIEKGJX/
	R1aMBwohiGpi2OnK6Dr4+ejqY1WEqyUicCg9vEqvdj5cyaxoMVq5EvS+Pr8/AEBi/9LhCTWjnDq
	v2Yjr2cIe9E5HC6lmSFcwo3cRnzc1fVTc69EiqJOTCOBU1LZOk0LvfTy9rp0JlPDcPd9qu/bQ7i
	qsBvu/KRi4LE51LbcIdopYd5iwtVt0v6RrZMIrxG374iNppaVO11SfBjWovzMwgvxAPeMwgQB1f
	kPob/rbqYrQiMmCDqVDGHBBZ4yeRVn3aGt5Wyha6/sUY8iM6aoQLWuBdCCZ+dVYGQCSh5eRAoZP
	I/51RvejpZt2WelWuV+aiPrrg2lWmzLFfVI8iY6UmpYi0mVgbkwLuWw3Un1UM3p8Hj4tK76FCSI
	lWrMSM/mv8iTV6xZA==
X-Received: by 2002:a05:6214:5402:b0:8ef:aad6:dada with SMTP id 6a1803df08f44-90a91d4a10fmr34127936d6.20.1786675811868;
        Thu, 13 Aug 2026 19:50:11 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm4949026d6.49.2026.08.13.19.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 19:50:11 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] gfs2: Fix use-after-free in glockfd iterator
Date: Thu, 13 Aug 2026 22:49:33 -0400
Message-ID: <20260814024933.2791706-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_glockfd_seq_stop() drops the file and task references held by
the iterator, but leaves both pointers unchanged. seq_file can invoke the
iterator again after stop, for example after a bounded read followed by a
rewind.

The next start then drops the stale task reference again in
gfs2_glockfd_next_task(), and can similarly drop the stale file reference
in gfs2_glockfd_next_file(). A duplicate task put can queue the task_struct
for RCU freeing before fget_task_next() uses it.

Clear both pointers when releasing their references so later iterator
callbacks cannot put them again.

Fixes: 4480c27ca3ea ("gfs2: Add glockfd debugfs file")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 fs/gfs2/glock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a73b..283c5701dc1a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2734,10 +2734,14 @@ static void gfs2_glockfd_seq_stop(struct seq_file *seq, void *iter_ptr)
 {
 	struct gfs2_glockfd_iter *i = seq->private;
 
-	if (i->file)
+	if (i->file) {
 		fput(i->file);
-	if (i->task)
+		i->file = NULL;
+	}
+	if (i->task) {
 		put_task_struct(i->task);
+		i->task = NULL;
+	}
 }
 
 static void gfs2_glockfd_seq_show_flock(struct seq_file *seq,
-- 
2.43.0

