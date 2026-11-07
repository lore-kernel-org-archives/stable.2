Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068214;
	b=CZy+qrKQ1RtFAc1IRzji3lKRvbCC/XlVRRg/TwUBwegJRZRo8t7ttaQJtDG7SJbZ0Njj
	 Bm7AmNmwC93E0WB7E+qPAejHH6Fh1JcijXkyxbmPyx6B6evUMqkEUy7UCj3sEC1P887kl
	 X2I2RoXzab4liYOx4Pwatd9+/RMbynmafLPwQ+ArnmtdIKEz21v6L4QhyjbOMhBkk8p1U
	 OK0yYDA/1vmohNtHNx/BZUtvu3Q8QJQW147qI/Ads5wC+SwYIFbMBBWXAqdDq2ZLxk+s4
	 TrkKsEzE4TUOmYuDFK0v1OCTXqVlRTemTw+xV54WUw/G35OPWfO3ECbkjgq0qEIMo8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PVxG1GqLyKJRjybT5Mn7mq7xXDo3j+IW62Fl/6Y/B+Y=;
	b=hHDomWbLl8Y5954PtrfH8LiA3SIKCh3tKoeW6J6r8Wkit9PHn4+YoqX0Heg2UqGJtQPe
	 k2665EGdIVASzAWTp2GYepU5wHtyez6hjksbLpRkiZgaTe8wKoy5exbgW82ZFeeqopmnd
	 pbf2DokX6Khe+wA9H8mPz4J/EMq0qwe1fcP5vilvTLKGq3r0F+PtbtBnPYZZhoaxHBsnJ
	 8pTLysvmguoqC2TOgqRNLd3HWKJ4oxCsdxDMjS9RCSX10C4cnbL5+eT70ZkEXAmaxWFMO
	 XIgs/jdsq4a12ql1FP6jlaKgITK6IfWO+9EO9I9I4nvwrPNZexTTT5+2i/fQ3puLpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JnA2MmBs;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C31606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C31606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JnA2MmBs
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso307396a91.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068213; x=1794673013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PVxG1GqLyKJRjybT5Mn7mq7xXDo3j+IW62Fl/6Y/B+Y=;
        b=JnA2MmBsPLd3AOVvRzg/h8l5Rzqrt/YP+kdDcn3ihnGDOPxHOt5Ep3QiLMIo6rvPfH
         hlhV91mDjbh3CYwV8RZjNgBbYlcWox4S4fblf+mcQpgHY0PBtfWJDa3/wI2nEu4S/NWk
         eiRxsMCQnCQLOq/JEdXMcVpUxcwDgberR5XWu9m+ubYjwp2d9u7nciMU+UC06TeWdVJ7
         YRw+jND3RRGZ4sDoGdnBCXP0J/cxKEYp8BTSBsvH6vCieEOTP+0XB6jDCkQ29Bs8Azry
         A96BM32YEEjNdZYIrA/cjdyIJdddd9RwIF8g5a310xVux7InVoIGI849w/xBPme3V+ta
         YKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068213; x=1794673013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PVxG1GqLyKJRjybT5Mn7mq7xXDo3j+IW62Fl/6Y/B+Y=;
        b=zueiYyzd4swHjkslyRRuB2odHpKJI1L/ltEGEEJuv8/s7Z1/hNOb8eRWmJ14RE/gvj
         SmBxLyBd1hLcDTTHFLyTbY4nH+Lc7X8IxQ/E8bcMfzd0I8VJ55ZAOvue6VfZY/SsthY8
         Rh2ccVLlBHSlvFwAMsYgLAKrnZBMEXzjv3QIr6DpO4+XXV2R//TZ+sOpAzKk97+45qRZ
         azfs1EuI1gjZLtVCJQVF/YUp3FaEVjFYUfCg5SS58isorkSRasQ9JY0bdqVCcPzVLK+g
         d6t+ONQXTBFg5bSBUtwGZ1wMw6EX5VV3KXDEBOk85MBkblJ0HoTKHM965XHgqKJk8UnN
         VCcQ==
X-Gm-Message-State: APuU4Z+TzFNUSUvzT8vTdxYYvcRBu+Fg1BYZZmn9dsnxosT2/mNSolNf
	NOVIKNj7CyF/PefHXpyX1+hBYfnzn09L3o7vnoATvs68XZZVtSUccOOB5EatndW8nKvvFVdk3us
	4bcdAY2E=
X-Gm-Gg: AYBFou0QUx7/1KL1jf+/B06q3FP0x1tiUtEMIMZzSruVnZVAmqCUscZ7EnTfhkvxNNf
	uLNxsWClJBfQ573UspG8cXmNvBYKB/VQR9ChbzfBABW6CLW39poOK5bv1pi2BeA9q9gZ404MOe1
	+TbJERZj+nDiaIlCY58H2gB17Uzo/eXAro4Tut8dnuObTAhTeQk6bSoMAwMD//NrnTPCI6P1m+s
	2mBIkdNLDI5jeO7espZHby3O86g1Hi38jM1oN2wBEq7eYs3ETYt4g6kRU+mkAa1brOoaDaAWQPO
	pWCl3SzQ53QNY1EHR/JERMRdtWtdMowoGp6WrgfxDWmZcPMoAbFFA/oL8qOyiNIkrH+OmqjI2UE
	NWTz3/OhwEEk59hHH5EinnUzKxNKyKCQzpuPpO0z7vk1QpbvEWB2HH+sC5czFfLsfzBc2r45Bbi
	iGuDU4GXfUuFd8FT0JbFcoQ4SNf79PZer6QDOMbhpLGYy/8loDvg0SrL7qZ2XHO3RsyWrjFDJcZ
	ziPCAFLUut3lEASjD0CcsXbNa9+MwWD54p1ouqTjh4A2IKlZMv8ODWhuSnWH7cmRP4ixkypt66e
	X2dlvu0/QLpbmnaVv4tzxIGrSD3/mKDl7hBoZkTLRBLVAbxSinxejv874gKqR6FEpjLmXgTo91c
	=
X-Received: by 2002:a17:90b:5623:b0:3a4:b509:88bd with SMTP id 98e67ed59e1d1-3b106081848mr1579527a91.2.1794068213080;
        Sat, 07 Nov 2026 08:16:53 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 9/9] io_uring/rsrc: hold uring_lock across index-alloc put_user
Date: Sat,  7 Nov 2026 09:16:34 -0700
Message-ID: <20261107161634.2500557-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161634.2500557-1-axboe@kernel.dk>
References: <20261107161634.2500557-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuansheng Yang <0xbeac@gmail.com>

Commit d7c7037253f6935af243570635d71b4920b5a4ea upstream.

io_files_update_with_index_alloc() installs a fixed file via
io_fixed_fd_install(), which drops ->uring_lock when the request runs on
io-wq, then put_user()s the allocated slot back to userspace. If that
faults, the error path calls __io_close_fixed() by slot index after
re-taking the lock.

The slot can be closed and reused between the install and that cleanup:
another fixed CLOSE plus open/accept/pipe/socket, or a FILES_UPDATE, can
put an unrelated file into the same slot. The error path then removes
that file instead of the one this request installed, ending an unrelated
file's fixed-table reference early. This is a correctness/DoS issue, not
a use-after-free: fixed-file requests hold an io_rsrc_node reference, so
the node and file stay alive until they are done.

Hold ->uring_lock across __io_fixed_fd_install() and put_user(), and do
the failure cleanup with io_fixed_fd_remove() under the same lock. This
is the same class as the io_pipe_fixed() fix in a3d7ee11289f. Faulting
while holding ->uring_lock is fine, the registration paths already do
it.

Fixes: a7c41b4687f5 ("io_uring: let IORING_OP_FILES_UPDATE support choosing fixed file slots")
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
Link: https://patch.msgid.link/20261104154655.81876-1-0xbeac@gmail.com
[axboe: various touch-ups]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.18 uses copy_to_user() for the slot rather than put_user()]
---
 io_uring/rsrc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 41e5755bd9aa..7170b3f001d4 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -429,11 +429,12 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 {
 	struct io_rsrc_update *up = io_kiocb_to_cmd(req, struct io_rsrc_update);
 	__s32 __user *fds = u64_to_user_ptr(up->arg);
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned int done;
 	struct file *file;
 	int ret, fd;
 
-	if (!req->ctx->file_table.data.nr)
+	if (!ctx->file_table.data.nr)
 		return -ENXIO;
 
 	for (done = 0; done < up->nr_args; done++) {
@@ -447,15 +448,25 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 			ret = -EBADF;
 			break;
 		}
-		ret = io_fixed_fd_install(req, issue_flags, file,
-					  IORING_FILE_INDEX_ALLOC);
-		if (ret < 0)
+		/*
+		 * Hold the lock across the copy_to_user(), if it's dropped the
+		 * slot can be closed and reused before the error path runs.
+		 */
+		io_ring_submit_lock(ctx, issue_flags);
+		ret = __io_fixed_fd_install(ctx, file,
+					    IORING_FILE_INDEX_ALLOC);
+		if (ret < 0) {
+			io_ring_submit_unlock(ctx, issue_flags);
+			fput(file);
 			break;
+		}
 		if (copy_to_user(&fds[done], &ret, sizeof(ret))) {
-			__io_close_fixed(req->ctx, issue_flags, ret);
+			io_fixed_fd_remove(ctx, ret);
+			io_ring_submit_unlock(ctx, issue_flags);
 			ret = -EFAULT;
 			break;
 		}
+		io_ring_submit_unlock(ctx, issue_flags);
 	}
 
 	if (done)
-- 
2.56.0

