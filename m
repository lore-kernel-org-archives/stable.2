Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC42E3B12
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309307; cv=none; b=BYnFiH9YbzZ6f9a67dYH8GNRcZRVuxmUkLXVXbLEtngvdp2DEzRxpRUF4DhN5SMWAg1/t/XL2shfq0vy2iOOpoTIEvDmbnRJn80W0bYLr653yx3mlmOT5kYDxcACE9yjkAsNDgKLwpz9KGF/RLwhXuNwnw1Lw5Ege9/FsD9xWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309307; c=relaxed/simple;
	bh=h9fj7i8AH506HFL/gfEtWIscVlLumPioFQmf4b+vdGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrqQ3x+QqzejMfU9i2V1RuiS+AIfdi7ZlDVXUzHwrfvTVw1JmOwkI/oMO1yeAN2r/qQqIL4WlpGseVsNdsGhayvBRe8Axl9hhm++nZ/I+0tmXmplWjb/cBHV712JtPcvkVk7490KD2cSzx64dFZuXERv6toIvsaR5ucP3jpMQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7xZOLG7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7xZOLG7"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902f92b8504so74218816d6.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309304; x=1784914104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kk0zvlROK4CGetKUdREFFy369z04aN1QAFj/lbaZkpI=;
        b=r7xZOLG7koitruLOmY7/1AI9nwVRrdJ5fpwl7pRjH4Z8906vcbtspZMhtLZ3mzhk9z
         82Z72OsdIBhXY0LKi46Pb8auAf4hjJT00fJ4s4IDcuzkZb8hm7fbYMC439aicxHmRJ84
         7VUiiAxxb5cCpzdypxvXZAiiZyzRNsbSLt6QmenNGGLon2Ij0NKCEGeBNg87xuApo88O
         egED9neqALBv9DD2yotR/Q81+DnYfidH2M990Ien9ijn15uARI+xco6F8dOryAOfItYH
         EOmvk/u25EJxnhvqSW3b+PnSAfQdFCtADwEES75UndyyzQ9cz1MB7aabOeEvhEXc6jJO
         auBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309304; x=1784914104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kk0zvlROK4CGetKUdREFFy369z04aN1QAFj/lbaZkpI=;
        b=T0SgwRcoNs1mmME8/GvxtaLvH2s9cOjkzZGp9jPfr06gfkHaROUY50683dk0OEw2F2
         K2qGr61S46yIUxwF9gMfxru0/5LARQBt18XGecpRYQxXTXndRYOMpXPKpMuQtCiZylvz
         TnU1kkXl9LLjDsnucoJVVNu6a9+7rAmosS9RXuPF+Y9GCX0a1eR0aeVVpJICX54/AX5A
         7pEEeTyJVGnpOQWC53MCl9G5IFYiCHclgtuiaDLvQtVhSv+1qM7XGzejyoWx0td0EfyP
         MtLrM1YiAr+jrHzdDkRLOJDm+q3oaS2fBxiATFVf5/LF2gajtneNQGiWm1ACyqAwr2ox
         49gg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0iWOgUi9nnAsIaFJ79mExujuDNvSeBlc9idf7q6X+8b2CErfaKOAEDOVeVFNZO5XMbCawNxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka8i9E1/SIIUdMkPDNhgBebbPJ4hYUEDqxjcKMta8jkFglR5v
	e8z9AkOFKGVKAGl+5MmnfPZiuzIB0L2ujvSlaY1iaF6pkBII/cGKSYxV
X-Gm-Gg: AfdE7cmUi9Eo5oIik4xbOSX6TsA1w4Omk2y6px0/5aCrFccUOUfg9b7p+SbSRvPIS3R
	wzX3TEv2TPjfwuZ15X6cNH3ang2M/8x7qTZZpvYrYQSOSsP+wbJ78G5vfFPXDS1+xiXsyB2anhJ
	FlmLEoIgjGd+QQwIiFcdHcPAuqUwJnVU7fS44MpP1YtbiS2+5Y2uW0Hl4FFQ7ZnQ+E+Xn/g6soQ
	tAEVF9YcNJbv0uMuuQzc6R0VbvzUZS8i7ZVG+4F57rPNfQjl5tdJE/umylRDg2ykwNujF2lqKb2
	Hd3hzi26i6ArasmihyF2SbR74dM2oVpj4YzNT6PeZga4r6qoiaZIzM1qB7clw0X1LJd/C5NFWYd
	+02oeZGlcNgiD3I+EanlJrsySHwsyN4dJ0BY+1/A+Tq1CQpI6nY5U/Q4r1Zwrz14thxOkc4c2fU
	6DhAknQJbQvvtGPqGShOD/uGPwqMlNg4oTbALxI+6mXQ==
X-Received: by 2002:a05:6214:212f:b0:8f3:ba0f:e7de with SMTP id 6a1803df08f44-907783541a3mr39136046d6.11.1784309304275;
        Fri, 17 Jul 2026 10:28:24 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786f9de0sm21502666d6.40.2026.07.17.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:28:24 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	cel@kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] lockd: fix NULL dereference on lockowner allocation failure
Date: Fri, 17 Jul 2026 13:28:09 -0400
Message-ID: <20260717172809.1591290-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nlmclnt_locks_init_private() installs NLM file lock operations even when
nlmclnt_find_lockowner() fails to allocate a lockowner. nlmclnt_proc()
then returns -ENOMEM, but the VFS still tears down the partially
initialized file_lock and calls locks_release_private().

That invokes nlmclnt_locks_release_private(), which dereferences
fl->fl_u.nfs_fl.owner and crashes because the owner was never installed.

Clear fl_ops before attempting to initialize the NLM private state, and
install the NLM lock operations only after a lockowner has been allocated
successfully.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 fs/lockd/clntproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index f06faf577cea..f8018bfe9c64 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -487,9 +487,12 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
+	fl->fl_ops = NULL;
 	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host,
 						       fl->c.flc_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
+	if (!fl->fl_u.nfs_fl.owner)
+		return;
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 

base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
-- 
2.43.0

