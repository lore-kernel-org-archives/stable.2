Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFB3A7F68
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084276; cv=none; b=M1Sgc8PNNGRQhIrSPtB17yxarYOGzKLhJ/vLBQF/wEDI/zhxtE8q8VmwbzHhmBjjTZx/iv2BRy+7YgJQjv1c3P6+2tSzT1MxbwMUYlaAkRXLsH8tBCN/ljTEITBkB66OuxGYhI7dC9F7TnJOpDAsChpwqcPdJy2/THgb9Xx1Qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084276; c=relaxed/simple;
	bh=+HaBGFIUyITYyskn9PZOlaHjJY051XZvXtogon38VX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asFiUkj8Sa5xTyYMw0w1eoPtoeWntl2UwhqMY2B/A/N+ALKmZnh2vFFo11IayiBczIDYOzr9a4tupXlyLNP6V3MdfNk4dKy+BGTgK12zVjcdacwt+YuvY3U7xhEjbaLgZT2ftNwy1qVGf/Tmu+9kjdJmY1owxqmP9ZNHC99uTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=I7426kkj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="I7426kkj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cace91f112so2413555ad.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789084273; x=1789689073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJf7neT2i6yO923W0Lg09fbYqghzTKmlCOt7Ys5/ve0=;
        b=I7426kkj5eLCdd16xhsBDkq2B7GjWZCwad/0JPUanNwdsoWwNqsvVsaP4CmDaB/tsB
         8ATWPeNttn1l1YgBtPuDxO+VCcXGJskG79yqv2ZkV78oOh4a8i27xbBbLenL8Z66Yhbf
         6yR72MGkN9krUEwGOR/ssRSrjVqEpK8M6tqvPHWpCtWiCCXUpuwG2JE9cYMcq1JUrmzm
         vpJqe1hezp0lhbGWuVHKOqt9TmESuW5in75r1iiO/BBOF/EFk0bacnxPePFUUJ41x/b0
         an7qkFQ0J81RnLFtaXDnjDulMEbN4Yj3XWiI9H102ve5CGDLqcFR0CFUtjgB8RbtBBXv
         O77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084273; x=1789689073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJf7neT2i6yO923W0Lg09fbYqghzTKmlCOt7Ys5/ve0=;
        b=bIPuz6QynLzDZf3q6aR9SuTalKEBovdtXqrYMkdP8Ngm2jN+1DiC8zudpZ5aBeYXaV
         dstR+97Flesi6c034r+dW2B9gxB40sxoN8cRcxuBRUkPsDt3a5MGryGJ7vhfxVtok/jm
         hl1jfWXbfuG8EMEjTyxtqkrIQFlkeqtejIGuEYsP6VQfvJKTxpQPBB+Au76LqNBMYTKX
         M5Ep2YYvJ95bteRd6OPjcS0o7GgPngWPGfASiV99kQLUq/vY0GPzpmKM7mw87UVJOw0T
         /aulvEqCEEVoIlRMYF4pPjNkK2zqzoN6LPo3D1OPepqBJLwPc8B1o0CIz16MmPiK1fm6
         C4qw==
X-Forwarded-Encrypted: i=1; AKwUvBwn8oI1B6+UeXanudmybo5PU6h2fDH/+iWWskhK5+wq+h8gSmajFIjf8udlX26aCUgzUq94MyM=@vger.kernel.org
X-Gm-Message-State: AFuF++lUmbVBG0J+tGfO4n21HmTueuM9Qwj12cvhP2AYhTpdQAq7dwTm
	mxl7cTaSoa4zINLQ5mf2rLdnNxy7dY4hmUyIurAlzg/J2oWCqwzmSJfdQyVPB/xwaQ==
X-Gm-Gg: AYBFou1CutwIO8xgkDbFpD2SnWpY0O9EnROFIW/Q4Q2ViPlFeMUjWsv7y6VnqwzvMx1
	bikmnAGotcEi2FL0qtYaeq6xGVgH92wdg1c8lJwiL2ySvwWaqCS7UMH51ZiFUyGPS3AkxGpI0Cz
	g41BBjuS30MVpZy9Bjp7CCSXrF4nEfOatBfWIUY463I9PNgvHXXGh5tIYFhRoLnt6z/2aXd8T+7
	BvtsTOQlm8cOt+zwixu59Rzvw/3+Xkfza/SFqEjpzzJaU4wmdMp1uS+CThYjIoxkQLxIwrmuCYW
	iLjrlQkoVd45NPTx8xNlWSVtqywmhhz5LiJKvSlpqi78tz3m8q2N7ov8d5NqoIaJ9orAzdGupHN
	Rltib0pbgTRt2dfLAE/+hE+J8LFxKK5hMLOKUq7BLzLcS8RAZbxcj7DwJDoZhK6O4IkIU4rY89p
	UUMKExGOBU31mqE7BhCPa/sUv3M8zdKyvYPI1HO0/Q1YBw8SuchnSHjZUrOrLkQ9Qktexvcbl1u
	KiUd3j1e3UPBIMSEi2H0xCF8v/0IXZW7w1hCg==
X-Received: by 2002:a17:90b:518f:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39d9c1bef27mr2132199a91.13.1789084273337;
        Thu, 10 Sep 2026 16:51:13 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm1680718c88.11.2026.09.10.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:51:12 -0700 (PDT)
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
Subject: [PATCH v8 1/2] fuse: don't BUG when the copy buffer is exhausted
Date: Thu, 10 Sep 2026 16:51:09 -0700
Message-ID: <20260910235110.3922068-1-xmei5@asu.edu>
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

The reply path can drain it the same way, via the server-supplied
payload_sz in fuse_uring_copy_from_ring().

Return -EIO instead.  All three fuse_copy_fill() callers already
propagate the error.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v7: fix the panic at its source, as Joanne suggested, instead of
    bounding the copies
v8: drop the "recoverable" claim from the changelog; add Reviewed-by

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

