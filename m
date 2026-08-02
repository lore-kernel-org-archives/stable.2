Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2733242D9B
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785656183; cv=none; b=k+6Y6fc5RQ9k46XuDvaEvyy20vJeRZpQVQqDyqqIGrE6SkHWXdMOqGGDqd9tksYCFaEwdWhr7ASoKxrXBc8QimbieW1wcDouqfryNbfsSMQiSJF1aQdXs1n9s/bk8d0vkAdeLtSjF43FukBhD3LOAyYM4LpsbojEJ07MsjUfHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785656183; c=relaxed/simple;
	bh=i0G+QSe+rEqjSiXLOrhIPMXcruhSgfqXHbCCwbIII3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlQzbONWaKSq6/8ucRpbP4FjrmYPACLazetzS5vRTWBFOPlcHK4UvgYS7k3wG3ivaBk8UXf/Opz8v9+BlN+JRpBxs+apQL1uC0C85SVSubzSTHJmc6qBto1e6GFqvS0gtSaiZMQTVeWlPDOXKzjd8AFa2acmEPMt+damSnKE8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrihRtG+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrihRtG+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1526501a91.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785656181; x=1786260981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UFDuvOjw6QzhXgiQmLV3vmIEEiB9ylNJEhhslAcVqTA=;
        b=LrihRtG+rXoKs8qVOU26ssYNgrUP+RO1dL7JxWY9n/lFSchnl/Rw+c+jpdGQWrTMrt
         9AtO1UEJdJVtaYitMgWdcZ4etGGA+Os23erRJs3+OdfgSw1rG0Vdcos/N2+TIg2UZXpK
         94FBX8w5Z85pTLzfqBNf694NOTc1ELXxVeQWbiAaHuyA9JQSJMhX0ehYKistWeWWEwPI
         i/tK/aLo5uarruOWZi+iSrzMrV7ilGug+P6+YY8w8VPC5wIu7RdmY9d9MShc/5jnkHh6
         dTKhO3gcq3pt3177IvQK1ByVrPaL84RMIk5ddaZkjnd0LVB0s+9Oklmr7hbh2zqWB7wY
         L3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785656181; x=1786260981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFDuvOjw6QzhXgiQmLV3vmIEEiB9ylNJEhhslAcVqTA=;
        b=U9rM52P3HFPSiw0wR/OiGa1UwSJDY4QKm1MKjslswjoENYB+zpFrbQ1RVEmY3L72tL
         j/Drn/zddvuYeZRbiGHu6QRCMZG63gkzQ9+qFBZNj6Za5gf7QtNxsfZebwrI/8pVxinQ
         AA2OTvMQB/j8/aCOxsy6CWOaxoOycFlvbnEwGKGTXXlXqKGTY4G476P0ZeF4n0RbMiE5
         LHrPP3NjJ8I/ZxzRUsYV/HYDXXBOH1wsag7Qs6/hMcyt5Kj056TRt2/b1RltWA/k6mnz
         KPX/y3cpI+dX9u3WdlHzCrK22MxjB3FfzN/1LuHXTiI/fFnZ4tArQS3LpzB2/1HuPAKa
         i6WQ==
X-Forwarded-Encrypted: i=1; AHgh+Rok7wv9wdoTzb1MjklAtTdsN7pFBbVcBIp4ESSMuC22BNRqChXsDvsblbLxtMYnn8ex9zb/IZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00B5MnKXI5miV3xpcqNdV2Rfum67ujPgXoOvOvh/agVx5dR5j
	6hAGzbjLaHa73jlxUygvwCsUv9TrHzQCT7VsAJHE3yolgnV210v79sqH
X-Gm-Gg: AR+sD135Ot3SpRKWX6bAsnL2383noDTWXnvmJ79w/Jr4wJ8v31Sul8F3BPsN8+n045i
	YgggUEyALJw+LRIno16nMPWG772Az/dCHHv0dcUkBbIXTLtELFdVgw4LbpyD0rMAKYrAvS/XXqc
	x54lctyHttIVlcwlDVNjWiaJxDxEEAtSiMiM9u+egmwjO4+hmJ21/zj/Q2CI0rTsJEJnkBm//Wn
	QUxL5RCUPDvjFp63usE0KJabKC9nKcXiu4LFUvMKtsGPewoYLuYpZhbQxlN8XApoj6eftjHPnAU
	bKtqdJF7k/yasHBR2YpS6o42hFgXrvPnkUl0IBWsC/vHGDQN1Mof4s9o9uHd5ZWmsRD1vwMOjlM
	6pwxLNgW+28NWj8H80aEBD1OxO41+mhnxDYnq5sgqJFEo+7DvkH7tCMs67tc2UxTmvJdX3XHjYb
	qnLIaGIxn8y9cR7WGHlrOuqZCk2UMev/qL21cv6f5d9y2VvsKbxJlK2J8Si25tA7MeTNegMpdZI
	zdozy/WAZqGykre7p7B2Lklz7NDa41vU388jc80TVGtA9Qjg86808PDlZE+
X-Received: by 2002:a17:90b:17c5:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-38fbc424a3dmr4963381a91.10.1785656180857;
        Sun, 02 Aug 2026 00:36:20 -0700 (PDT)
Received: from DESKTOP-4AJO944.tail156a05.ts.net (ppp-49-237-104-56.revip6.asianet.co.th. [49.237.104.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bac459sm1649732a91.4.2026.08.02.00.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 00:36:19 -0700 (PDT)
From: Woraphat Khiaodaeng <worapat.kd2@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Woraphat Khiaodaeng <worapat.kd2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/cmd: fix iovec leak when the async cmd is not recycled
Date: Sun,  2 Aug 2026 14:35:18 +0700
Message-ID: <20260802073518.419-1-worapat.kd2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An io_async_cmd carries an iovec array in ->vec.iovec, allocated when the
vec has to grow and kept across recycling through ctx->cmd_cache.  On two
paths nothing frees it and io_clean_op()'s kfree(req->async_data) drops
the io_async_cmd without it.

io_req_uring_cleanup() clears the async data flags only when
io_alloc_cache_put() succeeds, and the cache holds IO_ALLOC_CACHE_MAX ==
128 entries, so once it is full the put fails and the vec is left behind.
An NVMe passthrough workload gets there without doing anything unusual:
nvme_uring_cmd_io() returns -EIOCBQUEUED, so the io_async_cmd stays
attached for the lifetime of the command and the live object count tracks
the queue depth.  Above 128 the puts start failing.

->cleanup is the last chance to free an inherited vec, since
io_req_uring_cleanup() returns early for an io-wq issued command and is
not called at all for one completed without ever being issued.  But
io_clean_op() calls ->cleanup only if REQ_F_NEED_CLEANUP is set, and for
uring_cmd that happens only where the vec has to grow, so a command
reusing a large enough cached vec never sets it.  io_rw_alloc_async() and
io_msg_alloc_async() flag an inherited vec for exactly this reason;
io_uring_cmd_prep() does not.

Flag an inherited vec in io_uring_cmd_prep(), and free the vec when the
cache put fails, as io_req_rw_cleanup() does.

The leak is invisible under KASAN, where io_alloc_cache_vec_kasan() frees
the vec unconditionally.

Fixes: 3a4689ac109f ("io_uring/cmd: add iovec cache for commands")
Cc: stable@vger.kernel.org
Signed-off-by: Woraphat Khiaodaeng <worapat.kd2@gmail.com>
---

Found by comparing the three users of struct iou_vec, then confirmed on
v7.2-rc5 in a QEMU guest with kmemleak and CONFIG_KASAN=n.

On the design choice: net.c does not free on a failed put either, but its
->cleanup is io_sendmsg_recvmsg_cleanup(), which calls
io_netmsg_iovec_free(), so the comment there -- "Let normal cleanup path
reap it if we fail adding to the cache" -- holds.  uring_cmd's ->cleanup
only retries the put, so nothing reaps it.  Having ->cleanup free the vec
unconditionally would work too, but it gives up recycling, hence freeing
only on a failed put.  That leaves REQ_F_NEED_CLEANUP set so ->cleanup
runs once more, which is harmless -- io_vec_free() returns early on a
NULL ->iovec, and the second put may now succeed.

  no fix                  5360 unreferenced objects
  cleanup hunk only       2432
  both hunks                 0

all of them reported as

  unreferenced object 0xffff888006af5e00 (size 512):
    comm "iou-wrk-70"
      io_vec_realloc
      io_import_reg_vec
      io_mock_cmd
      io_uring_cmd
      io_wq_submit_work
      io_worker_handle_work
      io_wq_worker

The middle row is the io-wq path.  With only the cleanup hunk, a command
whose vec came from the cache already large enough never sets
REQ_F_NEED_CLEANUP; io_req_uring_cleanup() had already returned early on
IO_URING_F_UNLOCKED, so ->cleanup was never called and nothing ran at all.

The reproducer drives IORING_MOCK_CMD_COPY_REGBUF and needs
CONFIG_IO_URING_MOCK_FILE=y, CONFIG_DEBUG_KMEMLEAK=y and CONFIG_KASAN=n.

IOSQE_ASYNC in the reproducer is load bearing, and not just to keep the
cache full: it is what routes the command through io-wq and therefore
through the IO_URING_F_UNLOCKED early return, i.e. the second path.
Without it the mock command completes inline, the cache barely fills, and
nothing leaks, so anyone reproducing this needs to keep it.

nvme is not like that.  It completes from the device via
nvme_uring_task_cb() -> io_uring_cmd_done32() with
IO_URING_CMD_TASK_WORK_ISSUE_FLAGS, which is IO_URING_F_COMPLETE_DEFER
(include/linux/io_uring/cmd.h:144), and the inline IOPOLL variant passes
0.  Neither carries IO_URING_F_UNLOCKED, so nvme always runs
io_req_uring_cleanup() in full and only ever hits the first path.

To be clear about what is measured and what is not: the numbers above only
exercise the io-wq route, through the mock file.  The only in-tree callers
of io_uring_cmd_import_fixed_vec() are drivers/nvme/host/ioctl.c:495 and
io_uring/mock_file.c:85, and the mock file is the one I could drive
without hardware.

The other two routes into the second path come from reading the code and
I have not measured either:

 - a uring_cmd completed without ever being issued, where
   io_req_uring_cleanup() is never called and IORING_OP_URING_CMD has no
   ->fail handler to stand in for it.  Reachable from a submission
   failure (io_submit_fail_init() -> io_queue_sqe_fallback() ->
   io_req_defer_failed()), from a link member failed behind its head
   (io_disarm_next() -> io_fail_links()), and from a drained request
   cancelled when the ring goes away (io_cancel_defer_files() ->
   io_req_task_queue_fail()).  None of these need a provider at all,
   only a ring whose cmd_cache already holds an io_async_cmd with a vec.
 - nvme returning an error inline after a successful import, from
   nvme_alloc_user_request() or nvme_map_user_request(), on a command
   issued from io-wq.  That one is on real hardware, in an error path.

Happy to follow up with a liburing test for this if that helps.

Unrelated, but noticed while comparing: rw.c, net.c and uring_cmd.c now
spell the same recycle-or-free dance three slightly different ways.  That
looks like it wants a shared helper, but as a separate cleanup rather than
mixed into a fix.

Reproducer:

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <liburing.h>
#include <linux/io_uring/mock_file.h>

#define NSEGS		8	/* <= IO_VEC_CACHE_SOFT_CAP */
#define INFLIGHT	400	/* > IO_ALLOC_CACHE_MAX */
#define ROUNDS		20
#define BUFSZ		(1 << 20)

static int mock_create(struct io_uring *ring, int devfd)
{
	struct io_uring_mock_create mc = { .file_size = BUFSZ };
	struct io_uring_sqe *sqe;
	struct io_uring_cqe *cqe;
	int ret;

	sqe = io_uring_get_sqe(ring);
	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, devfd, NULL, 0, 0);
	sqe->cmd_op = IORING_MOCK_MGR_CMD_CREATE;
	sqe->addr = (unsigned long)&mc;
	sqe->len = sizeof(mc);
	io_uring_submit(ring);
	if (io_uring_wait_cqe(ring, &cqe))
		return -1;
	ret = cqe->res;
	io_uring_cqe_seen(ring, cqe);
	return ret < 0 ? ret : (int)mc.out_fd;
}

int main(void)
{
	struct io_uring_sqe *sqe;
	struct io_uring_cqe *cqe;
	struct io_uring ring;
	struct iovec iovs[NSEGS], reg;
	unsigned char *buf;
	int devfd, mockfd, ret, i, r;

	devfd = open("/dev/io_uring_mock", O_RDWR);
	if (devfd < 0)
		return perror("open /dev/io_uring_mock"), 1;
	if (io_uring_queue_init(1024, &ring, 0) < 0)
		return 1;

	buf = mmap(NULL, BUFSZ, PROT_READ | PROT_WRITE,
		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
	memset(buf, 0x5a, BUFSZ);
	reg.iov_base = buf;
	reg.iov_len = BUFSZ;
	if (syscall(__NR_io_uring_register, ring.ring_fd,
		    IORING_REGISTER_BUFFERS, &reg, 1))
		return perror("register buffers"), 1;

	mockfd = mock_create(&ring, devfd);
	if (mockfd < 0)
		return fprintf(stderr, "mock create failed\n"), 1;

	for (i = 0; i < NSEGS; i++) {
		iovs[i].iov_base = buf + i * 4096;
		iovs[i].iov_len = 4096;
	}

	for (r = 0; r < ROUNDS; r++) {
		for (i = 0; i < INFLIGHT; i++) {
			sqe = io_uring_get_sqe(&ring);
			if (!sqe)
				break;
			io_uring_prep_rw(IORING_OP_URING_CMD, sqe, mockfd,
					 NULL, 0, 0);
			sqe->cmd_op = IORING_MOCK_CMD_COPY_REGBUF;
			sqe->addr = (unsigned long)iovs;
			sqe->len = NSEGS;
			sqe->addr3 = (unsigned long)buf;
			sqe->buf_index = 0;
			sqe->uring_cmd_flags = IORING_URING_CMD_FIXED;
			sqe->flags |= IOSQE_ASYNC;
		}
		ret = io_uring_submit(&ring);
		if (ret < 0)
			break;
		for (i = 0; i < ret; i++) {
			if (io_uring_wait_cqe(&ring, &cqe))
				break;
			io_uring_cqe_seen(&ring, cqe);
		}
	}

	io_uring_queue_exit(&ring);
	puts("done; now: echo scan > /sys/kernel/debug/kmemleak");
	return 0;
}

 io_uring/uring_cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index c14c22cff..7f33eba23 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -38,6 +38,8 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	if (io_alloc_cache_put(&req->ctx->cmd_cache, ac)) {
 		ioucmd->sqe = NULL;
 		io_req_async_data_clear(req, REQ_F_NEED_CLEANUP);
+	} else {
+		io_vec_free(&ac->vec);
 	}
 }
 
@@ -208,6 +210,8 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	ac = io_uring_alloc_async_data(&req->ctx->cmd_cache, req);
 	if (!ac)
 		return -ENOMEM;
+	if (ac->vec.iovec)
+		req->flags |= REQ_F_NEED_CLEANUP;
 	ioucmd->sqe = sqe;
 	return 0;
 }
-- 
2.43.0

