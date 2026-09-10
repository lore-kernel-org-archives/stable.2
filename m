Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D72BE02C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007117; cv=none; b=iHEQJ7lyRjgsGWb/kQlMSY4NOnhXb78/yrAI6mBcLqoJdruUIPidScE3QaUSSm6uSYLPsNP5XJeWECbjecT1m3sKbZVcIoEXC/0xYZ90Au6qqhoje63+bm8/izjnhrHnxwcXEcbJbXmOCf90QXpJ3uWB8qzW8Q+5Apo4v71DIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007117; c=relaxed/simple;
	bh=U+Me3C9+CP6ZrOYDdK5ENtjrkf4pAKYkEsgkRLmN7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gs0oaNrZDxbcPx5rbeLR0M3GwhQt+gXBcE18tepRFDMiIZzHH4lNiFurFsr3uCgAey0CyIyX1qnpAyZl7Teyv3wHy4rfUjkNGiV5ox4QoISggTH67ZqBpjT7B3hfUeH483tAlxNPzhh7iI6vdV29jaDojhzcf8tswsvd7mMM00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=MVoLSvgK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="MVoLSvgK"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8686f46e4adso466983b3a.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 19:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789007114; x=1789611914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwJ0wHKRMeWCO4z6Il8uP1M5MtMWeVs9uywjTGYzTi8=;
        b=MVoLSvgKhI8CgfNVHYOMs0ZJyBH3njU7qKCbNeMBbo86JoglALDc+slYum9P/gVOsx
         xQtStEiOcqMO6uqlNZleHVPW2P74glA1y6CSHok/v+x2Uvg4GpkG/mBsxh3ja1RtWnuu
         u+HuRS9mQALnDGjZF1b+aC+bbCPzFZrioSsuhM+5FTPrJl9LSoNmffRB841GO9si4rQA
         VayWzCcVTbJlfUcBPwj8L+flaonHAIJTQKFVPCTWUmSdqv2H/VdsSqMatqMgORJbwyoq
         Rj1EZEgUy+c3+hQSmMBCsQr/VHF5Acwh/AQ2N499ANv2/IypmRFGceA0Q/kcZml8vGMx
         HgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789007114; x=1789611914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kwJ0wHKRMeWCO4z6Il8uP1M5MtMWeVs9uywjTGYzTi8=;
        b=hVZ/0bi6WmlVyflScQ8lTy4tbMsAjEZ3c6Qg2eoh+k68ZfBNkiFDxSdSM6oHAd2QbX
         FkrV0c7rl1Ocz4YUxFm/X6uLa2XB1wVfUVQEinAQ5oaEoFAuoA7mRaHa9X2E/QnTVAAy
         5NgYVFrfBFWulaa93deJR9Ur8hK8vDgvyExl28QsERVrg0EVmw/lZ1E/qgI3njOyRhlR
         qIKTZYPsWQqGn2A5Iqy+UenDvViEFPfMcIK+2ErnEEqSVbeoeQn3tj+YolMeQD3TsHjN
         9dEUmK9lTaWTUh8y7FFVxgMhf0pLQL1lNv5/kMjq4Z6woPH26p1wiThZuqEI8tG4lG15
         ts4w==
X-Forwarded-Encrypted: i=1; AKwUvBzMgzD9G79HqPUe5rzCpv7snJ/LsbaK0TEeO0qU1PXjPVW1U1Mxj834m/2bdexY3NLYJi/waVw=@vger.kernel.org
X-Gm-Message-State: AFuF++kxvYZCplvJ4u8kKKImwgiw1mXQ/RSqnkI3+iPOqQYkFI9kTMTY
	pf1/8eBJ6p3TrYBvMuOP+Mx8NaSfjwjKd0JvbYKbyYL8UCEmCtFYvzv6Epsi1juHrA==
X-Gm-Gg: AYBFou30As0XrMYzzKQn0ZiAV0bulrB1hlnEm892PguVSZFP+cEvvnXBrfiiB6vNEn2
	lw/8fS66Ch+HCbxTpRu/TpaO59W97lNq28HgoKpOu34eVp40TdkZfDN8Lw1Jjf1eH3I9tiFknaZ
	a6eHhvef+ztr1F7FWrNR2tMfPvfBNJQ2el9eClR+ZBWo8ONq7WTvLRcVZRqEsYUSWpyGk/RhqUq
	RYPIi8HinH4hry9ORbswGZo+wrOkyazLItRQETl9vmH7Og9sUUrH0DMhGAHMkDzEV0swbyJUTU5
	Vb3J5fDFo5aJgX1aRZ7ZCRFRBeXq6cHp9lvMM4JkvrMOWYAyy+0gx3ltP8tFFQ4WeYzkmYt6Qim
	R5oSSopS6ILrWhoWhWFgxxCWoSdMg0ucgoYZVzLrZeSQBOCveRAkfwm16hpqHRlsvPK9h4Qg0j/
	X1RDBhRSR6ZIZB7SJvxgu7Dq9Q3FWkpcJsI95X+FpqJpL/fVh7cKYoSzZwNnkyHtWjRo2iunOq/
	Xu3J1Ki9tVraTNptH7GGwk2D4BAhSbn3dk=
X-Received: by 2002:a05:6a21:4ccc:b0:3d7:b90:acba with SMTP id adf61e73a8af0-3dacbd6d1a2mr7999128637.6.1789007113811;
        Wed, 09 Sep 2026 19:25:13 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm2688847c88.1.2026.09.09.19.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:25:13 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: fuse-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v7 1/2] fuse: don't BUG when the copy buffer is exhausted
Date: Wed,  9 Sep 2026 19:24:41 -0700
Message-ID: <20260910022442.3594649-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
runs out of pages.  Over io-uring the amount copied is not bounded by the
payload buffer the server registered, so an unprivileged user can drain
the iterator and panic the host - mount a FUSE filesystem with small
payload buffers, then setxattr() a larger value:

  kernel BUG at fs/fuse/dev.c:1064!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 148 Comm: exploit Not tainted 7.3.0-rc1 #2
  RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1033)
  Call Trace:
   <TASK>
   fuse_copy_args (fs/fuse/dev.c:1354 fs/fuse/dev.c:1380)
   fuse_uring_args_to_ring (fs/fuse/dev_uring.c:891)
   fuse_uring_prepare_send (fs/fuse/dev_uring.c:940 fs/fuse/dev_uring.c:1057)
   fuse_uring_send_in_task (fs/fuse/dev_uring.c:1745)
   tctx_task_work_run (io_uring/tw.c:96)
   tctx_task_work (io_uring/tw.c:133)
   task_work_run (kernel/task_work.c:233)
   io_run_task_work (io_uring/tw.h:84)
   io_cqring_wait (io_uring/wait.c:278)
   __do_sys_io_uring_enter (io_uring/io_uring.c:2676)
   do_syscall_64 (arch/x86/entry/syscall_64.c:61)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
   </TASK>

The reply path can drain it the same way, via the server-supplied
payload_sz in fuse_uring_copy_from_ring().

An exhausted iterator is recoverable, so return -EIO.  All three
fuse_copy_fill() callers already propagate the error.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..4148e4488d77 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1061,7 +1061,8 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
 		if (err < 0)
 			return err;
-		BUG_ON(!err);
+		if (!err)
+			return -EIO;
 		cs->len = err;
 		cs->offset = off;
 		cs->pg = page;
-- 
2.43.0

