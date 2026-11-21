Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296610;
	b=FvBOHMFooOg3l2SfoUfj4H/SFykHfdipRn1omJR+SRaU+S056b5O1EU+C9J5CQlsR7/u
	 oDkntx5oa52K29BZPwmiTpsGnDTt7m5VRZAPjWAzySYF6d2uIxoajRkxsPudxB1fZ1EDW
	 5kPQGIYdDFNl65rGLpaYgorsmxm6T2PM4FObMDBpTo4MfiUwV1cmcztlkjpf0IA9o4MJv
	 pURhkQEcgEXvDAmO+czPiVhaBFjGdfkKfBfqfyBEZ3Lkv3YBHyjDx3Uv/tFIbfjboCeXO
	 gB9EU09ch+AGfJH7rksFxHjvxP4uCkFkUpZsNTQerHRikKhR3hHrhdbLo2gbcGHF+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tpK9UpRxWPeJ6LBe8E8DSiQcnX1JYLFK+gyk06OqkBo=;
	b=O1F/5vrPL4pAid7pu4+Z5XgseTZCnSxj94vtseCbJ+7TMsXLEP/n3EEfWDKr6fY9H0sp
	 D49WMcAQsTAmCOpLKc4LRuFhpLleGRdSt9LViz1R3ZbxvWWG8oA5yQ3sgPQb5SM47UEkr
	 OXHjQfbBethcUajTC4b+a1U3tEG+UNf1kGqevzwGM6GkWDPIdpIaDGccxU7OjjS1CYXzM
	 gyTjWnJY15+44l8dKh/At0BAYZ82bxi3wkh+qaSOG6QeTL0EKrqQkh+KubDV4fjhXvWnv
	 fpLoGRDL2j4Rl3Ovv6CwqG7NjeekfED6GTT5dSEXgYEfLN5EX1R3Tj0bHtSA5TzQfbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=rLUJmUAz;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04F606A332
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D04F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=rLUJmUAz
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-490d838b425so1043775fac.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296609; x=1795901409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tpK9UpRxWPeJ6LBe8E8DSiQcnX1JYLFK+gyk06OqkBo=;
        b=rLUJmUAzflLF2UG+6LG6A7b74MJX+qo0siA/uI3Z1Bhsi/cJh2mjOCfNZP5f8qp4Bw
         Y+kKxsFaH1pXfJ0Zoapr35NGx2M6+0ZKkP79vXvyixzO5hJD5d4+3Ov7XTlssuxB2xIe
         4RnRiiKfa4RArQw5yUpDt1vcwvnoOM2ftnA509S00Mkp0r3GPm30U/ZfZdgGNQBjHW2O
         Mj+UEPsGQ3zVB5gRMTrnIY1srDxfrRZ/W6xfWYCcVLsKylbSno3VG/hklCPJjHN36M1V
         ox7gkfuivgTHGJTzdgUTmR9hQ8ZZGzYyXUI3V7Y3m/YPEJ+xMHum1SMuNPkf/M6rqhXJ
         c0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296609; x=1795901409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tpK9UpRxWPeJ6LBe8E8DSiQcnX1JYLFK+gyk06OqkBo=;
        b=K0+pANFic27fly0pNJ/22AhTpXe+fCoLPLAPcoinRrPhvvmRw6q1dJajHU0Hp5hh6a
         h66MHwpO06BtT92CQd5HRIAFP+DInO+bcoUOzqK1tzgTnenC3DdUr0XTkcpMgU8Hd7Ux
         92Rdxo3hSHSG8062Ujgg2ntz1iaHkmMipT/7D+6hJaSIFlotIH92tUBrnlmur+XEfryC
         1doeNERYMh0g6Ie8ra6HadJE9E03WCbnlSecpxcfDmBK3UX8ZaBbDsm6J4zksH+eYARJ
         MtzQ/KbPCn02tcfC4waYNZpdQrbRLfYPEFuBS3rsYolKZu4USu8QH6QKjYLJoFfaLcls
         4UMw==
X-Gm-Message-State: APuU4Z8OoA7G8bU68B3jtbgWkbgE+VYx4x8Po/vdrM0dP64Xvd9M570m
	viuqiT+yj3SDRS/WREn2Zuz5gaypo8rBvNbJ1cvsAR4bNq5FYTnf/S5j8MPWMQfkvug/GxUxkHD
	oMGW5h9Q=
X-Gm-Gg: AZFdTZe8wlvkFabtMXWz0QIZDpds5w5gDyiUpB9MInqDKzOpkHIaqg2zM8GVLOUN4v4
	TndNP2pQ3JpuGCZFNwIwSQGFA/GJmTmvSCzkDlXO6jNRNo0uTOYwyfoZtH0oCAyfwtXfSa/bddb
	iBSVs87tl9R1AIuGLNZsKYgv2nRwTUTaGd3Y0UKSfivdq5fNW4n2Wa1KPugwLmi9hef6XnKXt5g
	233C6RfNNzVJIcdFspzPJ+rbUWNYe7+GVR6Elh7RZSnO+5WtYsWZCWkJRjboupjDms6Vnpbss5L
	9vEEHVFrbqVgVqkC/+OOo6RBPdxETIYMR8p6OJpEP03LW5Dj3wrCtc68lu8uNtxRDfsoDAYYjD1
	ZNYCMchyERYBz0J/GqaVjd9F8Z4Cz1Bc4JeXGbucQGFAXuLruGAxedRzl//5AjatlXiHmETR2pb
	MSSF3Klg9/+fjICrfKQobPcTccVlxMzD6n160dJKw0VMCqxVqL9C1GAA//1NnOpwJ0TFaHqln3E
	omRLNNK7c76LkhDrjSZS/jJkzboFYGscqEuMPd7+uECpsigclexADeBy4gAWX9ez+6sq14NBZpY
	8E/ffyNXxTdh8tJsRBftQ4bAD9+uYIx5QwjGiVaSrDAP4nEkajJn5DDWoDT3SLhNoC/1eIILabB
	0r8v1MPsTpulO7oXBfHalQK8d0b7MMZiO/iO6
X-Received: by 2002:a05:6870:c295:b0:456:5d8b:5681 with SMTP id 586e51a60fabf-4bc7bea8150mr5963489fac.1.1795296608965;
        Sat, 21 Nov 2026 13:30:08 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdbb4fsm6110825fac.5.2026.11.21.13.30.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/4] io_uring: enable toggle of iowait usage when waiting on CQEs
Date: Sat, 21 Nov 2026 21:30:03 +0000
Message-ID: <20261121213006.1787626-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213006.1787626-1-axboe@kernel.dk>
References: <20261121213006.1787626-1-axboe@kernel.dk>
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

[ 6.1: no struct ext_arg here. Pass the enter flags to io_cqring_wait()
  and keep the setting in struct io_wait_queue. Flag bits match
  upstream. ]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h |  2 ++
 io_uring/io_uring.c           | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index aeed98cb5c1c..f49ac2a5afa4 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -434,6 +434,7 @@ struct io_cqring_offsets {
 #define IORING_ENTER_SQ_WAIT		(1U << 2)
 #define IORING_ENTER_EXT_ARG		(1U << 3)
 #define IORING_ENTER_REGISTERED_RING	(1U << 4)
+#define IORING_ENTER_NO_IOWAIT		(1U << 7)
 
 /*
  * Passed in for io_uring_setup(2). Copied back with updated info on success
@@ -467,6 +468,7 @@ struct io_uring_params {
 #define IORING_FEAT_RSRC_TAGS		(1U << 10)
 #define IORING_FEAT_CQE_SKIP		(1U << 11)
 #define IORING_FEAT_LINKED_FILE		(1U << 12)
+#define IORING_FEAT_NO_IOWAIT		(1U << 17)
 
 /*
  * io_uring_register(2) opcodes and arguments
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 866c6ad29e4c..c59fbe6905de 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2354,6 +2354,7 @@ struct io_wait_queue {
 	struct io_ring_ctx *ctx;
 	unsigned cq_tail;
 	unsigned nr_timeouts;
+	bool iowait;
 };
 
 static inline bool io_has_work(struct io_ring_ctx *ctx)
@@ -2439,7 +2440,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * to be important for low QD IO.
 	 */
 	io_wait = current->in_iowait;
-	if (current_pending_io())
+	if (iowq->iowait && current_pending_io())
 		current->in_iowait = 1;
 	ret = 1;
 	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
@@ -2452,7 +2453,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
  */
-static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
+static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 			  const sigset_t __user *sig, size_t sigsz,
 			  struct __kernel_timespec __user *uts)
 {
@@ -2501,6 +2502,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	iowq.wq.private = current;
 	INIT_LIST_HEAD(&iowq.wq.entry);
 	iowq.ctx = ctx;
+	iowq.iowait = !(flags & IORING_ENTER_NO_IOWAIT);
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
 	iowq.cq_tail = READ_ONCE(ctx->rings->cq.head) + min_events;
 
@@ -3427,7 +3429,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 
 	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
 			       IORING_ENTER_SQ_WAIT | IORING_ENTER_EXT_ARG |
-			       IORING_ENTER_REGISTERED_RING)))
+			       IORING_ENTER_REGISTERED_RING |
+			       IORING_ENTER_NO_IOWAIT)))
 		return -EINVAL;
 
 	/*
@@ -3530,8 +3533,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			if (likely(!ret2)) {
 				min_complete = min(min_complete,
 						   ctx->cq_entries);
-				ret2 = io_cqring_wait(ctx, min_complete, sig,
-						      argsz, ts);
+				ret2 = io_cqring_wait(ctx, min_complete, flags,
+						      sig, argsz, ts);
 			}
 		}
 
@@ -3785,7 +3788,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 			IORING_FEAT_POLL_32BITS | IORING_FEAT_SQPOLL_NONFIXED |
 			IORING_FEAT_EXT_ARG | IORING_FEAT_NATIVE_WORKERS |
 			IORING_FEAT_RSRC_TAGS | IORING_FEAT_CQE_SKIP |
-			IORING_FEAT_LINKED_FILE;
+			IORING_FEAT_LINKED_FILE | IORING_FEAT_NO_IOWAIT;
 
 	if (copy_to_user(params, p, sizeof(*p))) {
 		ret = -EFAULT;
-- 
2.55.0

