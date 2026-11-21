Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296654;
	b=ZdRpigeAKlq7WV7PKSQhtkCnzbNBldviijLzukvl+HWBRHXklgbqB9+CFKcfhMK9uW8x
	 TVpWajIdxuLc7UqVFfEH07qoewf1ZonjpF1T/+uxIoOZO7YRcCfWfoqucA7WGFmvHbIg4
	 JwpFUtarRLhoq1DmDnoxK0ckxN1SBxBTlUU+8fUUKcJKJeOZKpodV92LzgZR5B40exos6
	 EQSRXTCe2pqr9yGlIZLwuoc3tRa2LZoYQlZrTySpm0yTGMFFzRLtf/JSHuNDdDYbMD6m1
	 cHQzv2oK8JmySQMxnTej3zXmpQ5vZMKCzX2dP8rzrBjMKNBONZ5VVqphCBI6KOZe81A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7fhlljAf8nVCXyikr9eLqQrEEZIZxgejn19tVIrkY20=;
	b=N/D3m+OeDyZZ8oITaV8cNF3WjCEEvh1uDHuznEDfIw+BYBGf7e64SxHwRv46UqT11dXK
	 qw3d0lwwN1JA6PC8jwWj2Ol/BtabTCd6/izzeuermz09od5pKV4lYAuT99EzGPmNqmKC5
	 Jhhtm37ANF91k0VgyfuTxca0tl3YK3NY64ZsI2wnpIH4xZ/V/oN3JrCSK/I9IF7NXzNoR
	 f8os3i9hYZmnJgibqtPeBHW76bbU04+CyIUnyDKgPV7WwMAuRclHm6U6EPAv1kV0IUV+7
	 eCG+nDyzGtldmR3KjxZBEdEX389HHJEbRCaWkIjhWDYDfj5nEvxzdutpCNplPT1LJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=TazUqePr;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECC606A334
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1ECC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=TazUqePr
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71ad5f20016so1428767eaf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296652; x=1795901452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7fhlljAf8nVCXyikr9eLqQrEEZIZxgejn19tVIrkY20=;
        b=TazUqePr3nBln6Xf813Jmy6tYBV6Nk0DH3IcH9SGYV9ziyXvv4YtHH9MuRcG1vWyn6
         a3HxagxREJDRGs8glI1NOKNdnt4xtxYdt85TiqGyvxoZRS/WIu6ENGB92BBDPoaKq3tG
         wYYk8TTJH+mU+pfnh4+eAhmo55d7eLQMWRf5eKUupiiP6GJESFb//kV/LaxaeeljLqjw
         ZVJ3WU/v4Z7eheLH/cplA8daROx46KTIi0I/yFjWuOyiXrvPuNT9T7EKzgFxrxUlGg+2
         IUihBTIHMrOX23ioOtFurJrCoCSV9IDkVB565SiS6o/VGS4RhRcw1gAinoBF3hlKm6lC
         S/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296652; x=1795901452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7fhlljAf8nVCXyikr9eLqQrEEZIZxgejn19tVIrkY20=;
        b=Ee9+sHGf4V9rFKTBJBaViiB6E96wVy9pWBggI81zZOSy24cR+zrJJBqe7HAx6ekZWY
         QZf27w2Nak4La0OPYo6Yw/aRTSAy1lzVWMIn6tAHFtXNn9jlAmI87T+a7KausGnkg7Ba
         ngoKhfNyPiR37gCUfEEHujjbXSUZ/c2Q9965cKdpx2bBj4qW+jcTleQAdbyRhIuWNzg6
         M+7v2POp019aFrm2E40w6Xv4J16sOUC5LaJb0E9+8jTdtSBiX3tfWqGmSSvw0tHDByl2
         EEZ7iog8lLTGex1xc3gfwNLh6lXIbh429ZlG3gXFNn5R8myleCBf15LbtQdcNQFJt+0e
         S7Wg==
X-Gm-Message-State: APuU4Z/sPH6Of1mQly+YOPe4eT0djZhAK2H+LCTfHW84rIKiSRXteNiH
	GtXDbtfgd/rgtLmWTsxTTK4R6TOMZQ7fFU2tTyoN40TMNnp8uu1NTpXumxSWZlqpcF6y1eMwq9U
	qUcediLg=
X-Gm-Gg: AZFdTZcqyFO7AyhrzEsQiYdsSPvcsWKQu+iYzfU+ioCstEiIwVFIPSsVk8A9qz5WPz2
	e153/IR3MFWHzFZB3CpUhPOVIZbIGNZ1E5gYuqxSrXKa3/Gl48a1rFgcEVyZImtYcwE+8s+Livo
	TvEmhhK4aMTuFLeV5vZt5tqTKlKNDnL170JrumF0OL5WBMAhoQo730GDJBh80XhN2mnZZRv63ao
	WwnNeNNi9CmsHnyNMVK2kLkJO3hgetxi0yb+gDSu9ITdFDSBtuHE/ihp5O9yBBZ2tQouvFbzv20
	TmW1GC16L+Oaz1xw0vJpqdnhHGjUXA+hGjxSfnZkxyRercSZO7GWVjU1qdbbdVlSZ6AA7GYh7LO
	xu8dnmG9eEb0x//saKzRa1FfmUIjkDmUqCIV6LMo+dzC+DnwCRis9yqKj73oNURMAy/RcCs6LkS
	nJXnIfGCihtAtdaLKM35OKbrdHDjOtiBmxmFeZWQm8UzUJvyFJfTt2hdTXs5qjH/O4jJGY8Qcgp
	9z8R3yFzeia+7h6VO8zuO/rcGrN3LZtfSDUMmaI7bIE9V04mmgHTFHqchTriL+v6D6I48id6wBq
	aKVqoEJAfWyy8F/K1v5hUeHHTT7+RuEuOiLEqve8VtznGjPKKwUb4ojx/wcCsSCby1mlCiws4Op
	QowrnkfkUI2xY4Y04cC8hVGRtxFlz4BKGMcoS
X-Received: by 2002:a05:6820:5715:20b0:71a:d99b:e874 with SMTP id 006d021491bc7-71b39555321mr4159902eaf.67.1795296652595;
        Sat, 21 Nov 2026 13:30:52 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 01/19] io_uring: enable toggle of iowait usage when waiting on CQEs
Date: Sat, 21 Nov 2026 21:30:31 +0000
Message-ID: <20261121213049.1788332-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit 07754bfd9aee59063f8549f6e4d455eae636ecc7 upstream.

By default, io_uring marks a waiting task as being in iowait, if it's
sleeping waiting on events and there are pending requests. This isn't
necessarily always useful, and may be confusing on non-storage setups
where iowait isn't expected. It can also cause extra power usage, by
preventing the CPU from entering lower sleep states.

This adds a new enter flag, IORING_ENTER_NO_IOWAIT. If set, then
io_uring will not account the sleeping task as being in iowait. If the
kernel supports this feature, then it will be marked by having the
IORING_FEAT_NO_IOWAIT feature flag set.

As the kernel currently does not support separating the iowait
accounting and CPU frequency boosting, the IORING_ENTER_NO_IOWAIT
controls both of these at the same time. In the future, if those do end
up being split, then it'd be possible to control them separately.
However, it seems more likely that the kernel will decouple iowait and
CPU frequency boosting anyway.

[ 6.6: no struct ext_arg here. Pass the enter flags to io_cqring_wait()
  and keep the setting in struct io_wait_queue. Flag bits match
  upstream. ]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h |  2 ++
 io_uring/io_uring.c           | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 333769bc6abf..7c8c70859c94 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -466,6 +466,7 @@ struct io_cqring_offsets {
 #define IORING_ENTER_SQ_WAIT		(1U << 2)
 #define IORING_ENTER_EXT_ARG		(1U << 3)
 #define IORING_ENTER_REGISTERED_RING	(1U << 4)
+#define IORING_ENTER_NO_IOWAIT		(1U << 7)
 
 /*
  * Passed in for io_uring_setup(2). Copied back with updated info on success
@@ -500,6 +501,7 @@ struct io_uring_params {
 #define IORING_FEAT_CQE_SKIP		(1U << 11)
 #define IORING_FEAT_LINKED_FILE		(1U << 12)
 #define IORING_FEAT_REG_REG_RING	(1U << 13)
+#define IORING_FEAT_NO_IOWAIT		(1U << 17)
 
 /*
  * io_uring_register(2) opcodes and arguments
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 43860048d2bf..b14651c187d4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2520,6 +2520,7 @@ struct io_wait_queue {
 	unsigned cq_tail;
 	unsigned nr_timeouts;
 	ktime_t timeout;
+	bool iowait;
 };
 
 static inline bool io_has_work(struct io_ring_ctx *ctx)
@@ -2601,7 +2602,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	if (current_pending_io())
+	if (iowq->iowait && current_pending_io())
 		current->in_iowait = 1;
 	ret = 0;
 	if (iowq->timeout == KTIME_MAX)
@@ -2616,7 +2617,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
  */
-static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
+static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 			  const sigset_t __user *sig, size_t sigsz,
 			  struct __kernel_timespec __user *uts)
 {
@@ -2638,6 +2639,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	iowq.wq.private = current;
 	INIT_LIST_HEAD(&iowq.wq.entry);
 	iowq.ctx = ctx;
+	iowq.iowait = !(flags & IORING_ENTER_NO_IOWAIT);
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
 	iowq.cq_tail = READ_ONCE(ctx->rings->cq.head) + min_events;
 	iowq.timeout = KTIME_MAX;
@@ -3828,7 +3830,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 
 	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
 			       IORING_ENTER_SQ_WAIT | IORING_ENTER_EXT_ARG |
-			       IORING_ENTER_REGISTERED_RING)))
+			       IORING_ENTER_REGISTERED_RING |
+			       IORING_ENTER_NO_IOWAIT)))
 		return -EINVAL;
 
 	/*
@@ -3928,8 +3931,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			if (likely(!ret2)) {
 				min_complete = min(min_complete,
 						   ctx->cq_entries);
-				ret2 = io_cqring_wait(ctx, min_complete, sig,
-						      argsz, ts);
+				ret2 = io_cqring_wait(ctx, min_complete, flags,
+						      sig, argsz, ts);
 			}
 		}
 
@@ -4211,7 +4214,8 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 			IORING_FEAT_POLL_32BITS | IORING_FEAT_SQPOLL_NONFIXED |
 			IORING_FEAT_EXT_ARG | IORING_FEAT_NATIVE_WORKERS |
 			IORING_FEAT_RSRC_TAGS | IORING_FEAT_CQE_SKIP |
-			IORING_FEAT_LINKED_FILE | IORING_FEAT_REG_REG_RING;
+			IORING_FEAT_LINKED_FILE | IORING_FEAT_REG_REG_RING |
+			IORING_FEAT_NO_IOWAIT;
 
 	if (copy_to_user(params, p, sizeof(*p))) {
 		ret = -EFAULT;
-- 
2.55.0

