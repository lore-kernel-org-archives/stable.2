Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068141;
	b=nBpwi8zpq2tpF3jwvlY7xGIi/g607FEnV4rJ3CGb8JvDMHj6Py9fqjEXbMaSbo7+vyO+
	 IziKc0K3RXKV2yoDGTQF58ZEm4gbDbRUtsLGqBgBU5NQC0G7vxKFCEnnSEP59ivOyB7qD
	 9pFaWBnNyY/tW8XyoBcOSglE18v9jFDQdxvtUNwvtsTdX8UGs0m4Ifiid7IaBIMh434Yi
	 4t5xsVa4yhajw+ZieXtgwD9JcKVyZFXbhqS99LI8QjBECRgH4bx4ugj+pLLv1X3ghqHlJ
	 zK48Wqj5fWTYTaeDCbrNF6dUdFu8QE+69K+b5C9F+cEHrmZjT/L6J4GqrnZwBqaEtRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BP36L6H6wMCB4vLZAelWu0VHnxL9JUmS2DxNZ/lCnkE=;
	b=lRRnrWCnhUOFLiN/R7SRyXiGTsuVHXOBJoDAlJfJ+a31xf/fJwpVVluRFL1O3ieSbezt
	 rHLNE/n0UW8VEhaQrgd+RprwKD1xBLhnu9nVSmQWvRE1M0EfWjgYvySQNCjdpcFf54kP0
	 xLltL4MPj5FnP0XoZeP1+3Jd8Z08mISdylctC+btyZEqXopYPGQT0ZNjV2tvIcfs38Lte
	 RbuxXgt55LzfoQBMmXC8S2DYYEUrgPtN1zxwXGGj1z0UnWvLTC1v8fSRa1RMbAqAiA0jm
	 4LgWF/2n86cmS4ppgauQ6tJ2tssVuVCFY+jk3GNWEPw6wsaKi4HLCe+Z+Z6hk7wVuWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fDXyVaep;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C8606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 089C8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fDXyVaep
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso9351205ad.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068140; x=1794672940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BP36L6H6wMCB4vLZAelWu0VHnxL9JUmS2DxNZ/lCnkE=;
        b=fDXyVaep/IfQ+VvOVEboSzBS1+byfhVO2QFr4C6S+DOMYnBEkZrSLFUi7Icl88SGvf
         1NpyV+6mjq1edyumf4wU48tuhPyHWZvk6xnv/6DH7vIo91maYbiMR0eJRjzK8RMf980L
         mAl82zVcxIREt+HuqDDUk2f/JZlhtYAbTkYpX9JJLxjJyFY5FXmRbtPRGHEklDpnBR+C
         TbERsH/JW5lfvnddw0yghtYxUYsC7QhfTtmTEA6X5yr4WrjEqxzy9ozhy8oRlt3NBEyx
         ZhgGFBMybK5z5OhA2PK3IO9FHP9HYF3vcrIP7qZ9DbHQ6o+Ho4/2HiOCLX+fLHEhPM/i
         aiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068140; x=1794672940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BP36L6H6wMCB4vLZAelWu0VHnxL9JUmS2DxNZ/lCnkE=;
        b=zp/Zl3QrddZvdPU6fny+6pG/GYLibMoulMHExhaJZTAqeAi3kNf++ZvW5P59fzRLh9
         4RVkqc+k4GhfBW7jUuweCx8l/lM6cpSjIhAYIdXO41eODvZlUWvAbKLgv1t7A30FUAKb
         Zw8w9gaoLNlM7PBPrFCDcdGRg0f0g9Sss8J2YA5lIFOiNozykkAB/6/tgusQbo8bXCt+
         H6T/pky5pKD5j0x6ZupBV6xWSoBjuP3UXIVTZ9EUi6LyF+5dgy62VA8jJA7c2Z7/QhAx
         rIbvQrqv/tvWB8MP8EgzlvY4aQu+SwAZ/tzuu2mjHLXVGd6C3oac/5QnjkCbLXSqMw5W
         ZOhA==
X-Gm-Message-State: APuU4Z9gS0pF8x7VCGNeW5vyLY2wZqZrcUiBL17KLKdgNvN4xxXmYv/3
	d2CL80fLGfCSYW6ZFlPNrmS6wRxGeGh45CfsplHfFp44Vd87+tPjfeO30vvN7SRrGeBaw21Ybxd
	uMElTbRc=
X-Gm-Gg: AYBFou0Wsv6Aw6pzLo643/Xa/vhCbaMIj2AwawAxTQsGcrINITzc8IOhgpbXBqgPGeU
	F91vrLemX0b6NTVUVuM5L56+Dgh4HiWTDxE+sZLEkdhKS+cRniHYSOcNIA0vFLaIqgg2HUJKpF0
	g+R7l5ykU+5xkFZ15ErN+gcpQvM8+b6T52RfUNQMlEUzfW+YQYD1x3GgxpzyJPF0Qac8pjKwT+K
	4u8YeT3AuUOfFLzKYVZW3vx2e1jgCv/GQY7ucTrT/zRTs5YBMb0+6at696NQPfkhzo1uz7shJRM
	zCjVrZtERDaq0J3vcyDLDlcgxX29W2oOPWJvHjAmsWTBqAQtB/FW/Bv1o+ZhaFi0cc7FrLRitwc
	XdndJiu+qav1KcZ/O6OJkOSdq9QeqpLMoMoJQWC5eohTkffMG9pUHRI2RB9vPRaj9mGHrQoyoRo
	YKc4JTY3o+i7yZ5tk4+rVHPiKBquJ46Kxug27EFHD+srBw82vEEnzShGLPEhob3zGeXiU1obTt0
	um+N0CeQzZtqYQ7taok4FxdUgCCFVpIiWvfKFy7N/FRbLuYcSrwsfQ/KA0LDUIUh0hsnhQXT9e2
	TmvU8hfwDVltXKYTkofe1VLAdbakGOQuhtuwtRlYlWZw0+3v+B8hnoWCQ7KIozvchPjIkVAsf4Y
	bw67ln3ZxOqQ2UD3k+NLJ
X-Received: by 2002:a17:90b:3b86:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b0db5f1514mr6439133a91.3.1794068140229;
        Sat, 07 Nov 2026 08:15:40 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 7/7] io_uring/rsrc: hold uring_lock across index-alloc put_user
Date: Sat,  7 Nov 2026 09:15:14 -0700
Message-ID: <20261107161514.2499962-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161514.2499962-1-axboe@kernel.dk>
References: <20261107161514.2499962-1-axboe@kernel.dk>
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
[axboe: 6.1 uses copy_to_user() for the slot rather than put_user(), and
->file_data for the table check]
---
 io_uring/rsrc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 6fd3dcaa3c42..eb91f5b28924 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -670,11 +670,12 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
 {
 	struct io_rsrc_update *up = io_kiocb_to_cmd(req, struct io_rsrc_update);
 	__s32 __user *fds = u64_to_user_ptr(up->arg);
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned int done;
 	struct file *file;
 	int ret, fd;
 
-	if (!req->ctx->file_data)
+	if (!ctx->file_data)
 		return -ENXIO;
 
 	for (done = 0; done < up->nr_args; done++) {
@@ -688,15 +689,25 @@ static int io_files_update_with_index_alloc(struct io_kiocb *req,
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

