Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296685;
	b=C5NQebRmhAH+mixYQfS9kDMdGWhr/JexrRL+1QEDYOgKDpmAyJ4VBRE6iJ1/yyJqdlhj
	 G/KE+2LWhk/QsE3b5H1Hr5m9p031S1Rqz8mlyKwLDIfIdKUfNH5YKefW0kRLRdstGkgtT
	 49wYuiUwbDyzOXCfftmOIzPTlJymwZGBNSCb2h36TEuYKlfiCK0G/s2TqVTcQmOFDb1HB
	 v9bmqAxJjeTcuJqZC/6icm3YN2LKbmY++rBl9wx9ovbNe15cht0RQ6/CAdz1nzBrOO5ok
	 liYGvQ47rKOwfJ9Er93xo43QD0JRJLKR01fHH4kCUiLZz0SLom3De0Mvt2NJ+521ntw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rJHJC5cHLw6GZB+zdPHIAh1R+JjJ7/7IrlWpDoYyf8Y=;
	b=teS6aB4KuMAeEBIDKwvn+nqrZ2EznTJgdUxo31jJdDsJYU5iD7R3NJfPDI5K/QwyZ66G
	 DHZ1TdCtV9Q3ArperVdXwUe/9sIEN7HHfgyP6DqR/kdeB2Wz688MIS8YFJEVYhXdBhvPV
	 W/twAju9ZaTRdPpsCcvZPufVFf4B/Y/G9jnP47iCbjAmjzj0nwkJ3W1CurS3CDTX7OcoX
	 K5IH6F4mTglaJ2RCYOw4DGNGAhenPtsrE0vcVEemRZTZNCSq46ONDHJ1pFqYR4B5cOVwt
	 cWbFsqFOaiu+yYOicirrpxcIfO15eYJGoQvR11vSOiW+bDV1N8rBoQIZDekBdDzgjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=gUddsAW0;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA5606A332
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82AA5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=gUddsAW0
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862df509d48so1646252a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296684; x=1795901484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rJHJC5cHLw6GZB+zdPHIAh1R+JjJ7/7IrlWpDoYyf8Y=;
        b=gUddsAW0whmEAcjFDwNxOCln+2mah2VNdqT0TuUSipxFw5Rm5HFR94gTSHiusSU87c
         BY9tRCkGY19xoTtvB8jThxkyEBJNekWRy4x2gsISfNYscLE55wKruFkEsI+GIkIF4e03
         YKpby/ntUmBHNOQWG7sPoJrH/n2i/GsomoNiOKkMGGon6ZTIwKg91vu+woJdYf11dew4
         dNeUVeMzPYg0qdgzAB+VEhznHWwppg5lph2x1ANWtiDWkZgZdGIlSTUmVe8VRT5rVzEB
         MsDApYVJq6MyqwDbhk8DBCkRH4Kcq0vUZYw7WCvLPtH8tmijOFYI+94/SKJZu19CAsjk
         DSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296684; x=1795901484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rJHJC5cHLw6GZB+zdPHIAh1R+JjJ7/7IrlWpDoYyf8Y=;
        b=PPUidlAkpnfZKHPRT3GDsT5HjBI64C/PlWb8IgMZ2SgCJ7RTW0PCrMYdNM+d8/T6ce
         vI+ytkUY89kQ1VY9me4Z5Z9kNB8lB3O3vWsoOTRswYjPeufzsOrkPlcdOoPpzXyKEVEu
         XdsiLTqMpE53lrMhm11DqFCbKICpbEqtimZizh6sAM1Fl3UtsFihI2VWFebNbr5KUIP5
         +YfMajT5tTPZH+jVenEW/XoR90jsD/nnqVPoMB+vzNd8xf/bFVV0NN22neDa3n1DTbcK
         Jyd+DVUuB0X95pJKIkMBTQTdJwiQd/wQS96kddeqg3d8W5F7nTa7gAzET+ihQ7Mk0y8m
         Ysyg==
X-Gm-Message-State: APuU4Z+Q4KTOe/n98xDJcXHeX9sLqoBWcxGFO0GhzVzl710h9qjahbzD
	tB7p3khtHhmEpnS0fOaPKQVFQz+VI9kmPs8IYqpGvqX4vJtoyZYahh93yjoCqSc4stEP1wpOm5g
	4wJ+OAwg=
X-Gm-Gg: AZFdTZf5M/oVA4kYH//mVf8WAylK6DOS1zrmJkmJGEgj2eCFFJ48pTAOSM7Fj5shFxI
	9C+4LXRPvXnf/lOQgHwiw7klZg7EqT4uQumV/RQobbOwry4AbAJoJ3G/gm0bfJ/44UbkkOWS0rZ
	ZftIxDWnGW2fzBwS8oxAdQt/9ysvLgZdwGPg6eGN1kQIBNlDnzf6RhAjwxGKs6mlLrNz7IHZTs0
	CONUZiOXqM572rO988cRl70Z894U612wY8MMEPMa7PpKHTaGzxkzuJtdsTXPGTpVsdUq74SSmxV
	0hKwInxLcTzgA0UOJaflvDhoImhbfymGbxMYNyZJgAPFcrCib1Oqw/mjkLHYWodUboUjasNGS0i
	zY8v6nFdYK1P9Nm+z3roWrCmtm9pFa7n1Ud69vn25z6KCCGEySWp3RTJFPpZLv0WV4PvzYmNKxT
	T/Hh/3YduWxgRNYG4aSOG/xoSHOnCM4T20zX9KL3+/265FZV353gj1yrOzDxXinQVWclEuhh5vn
	egzCQ7gXIv4SSSC1Z9K+y3m3nOlzDFHL3t0cQ+QPktQX/HkVRNvdjgSfJZQoZBhk211m9baJci2
	7Q5uyWdv5Mv6cDUkNo7w31cfd5Ga4XOQBUk9kWzmyiUPSG+jpX/gFyxW+2j4xxo1LN0jy77TIaz
	S+5JBxDnVo684+MvM9kcQ2gx2i/yizXoLcqEH
X-Received: by 2002:a05:6830:3916:b0:845:614b:eab9 with SMTP id 46e09a7af769-863091a9d18mr6997287a34.6.1795296684424;
        Sat, 21 Nov 2026 13:31:24 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/9] io_uring: enable toggle of iowait usage when waiting on CQEs
Date: Sat, 21 Nov 2026 21:31:13 +0000
Message-ID: <20261121213121.1789042-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

[ 6.12: only the NO_IOWAIT flag bits are added, the EXT_ARG_REG and
  RW_ATTR bits before them don't exist here. io_get_ext_arg() has no
  ctx argument. ]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h |  2 ++
 io_uring/io_uring.c           | 31 +++++++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index fdd7b931ea1d..e777e6b128e8 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -518,6 +518,7 @@ struct io_cqring_offsets {
 #define IORING_ENTER_EXT_ARG		(1U << 3)
 #define IORING_ENTER_REGISTERED_RING	(1U << 4)
 #define IORING_ENTER_ABS_TIMER		(1U << 5)
+#define IORING_ENTER_NO_IOWAIT		(1U << 7)
 
 /*
  * Passed in for io_uring_setup(2). Copied back with updated info on success
@@ -554,6 +555,7 @@ struct io_uring_params {
 #define IORING_FEAT_REG_REG_RING	(1U << 13)
 #define IORING_FEAT_RECVSEND_BUNDLE	(1U << 14)
 #define IORING_FEAT_MIN_TIMEOUT		(1U << 15)
+#define IORING_FEAT_NO_IOWAIT		(1U << 17)
 
 /*
  * io_uring_register(2) opcodes and arguments
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 09551e3907f9..630b306a849f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2532,8 +2532,17 @@ static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 	return READ_ONCE(iowq->hit_timeout) ? -ETIME : 0;
 }
 
+struct ext_arg {
+	size_t argsz;
+	struct __kernel_timespec __user *ts;
+	const sigset_t __user *sig;
+	ktime_t min_time;
+	bool iowait;
+};
+
 static int __io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 				     struct io_wait_queue *iowq,
+				     struct ext_arg *ext_arg,
 				     ktime_t start_time)
 {
 	int ret = 0;
@@ -2543,7 +2552,7 @@ static int __io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	if (current_pending_io())
+	if (ext_arg->iowait && current_pending_io())
 		current->in_iowait = 1;
 	if (iowq->timeout != KTIME_MAX || iowq->min_timeout)
 		ret = io_cqring_schedule_timeout(iowq, ctx->clockid, start_time);
@@ -2556,6 +2565,7 @@ static int __io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 /* If this returns > 0, the caller should retry */
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
+					  struct ext_arg *ext_arg,
 					  ktime_t start_time)
 {
 	if (unlikely(READ_ONCE(ctx->check_cq)))
@@ -2569,16 +2579,9 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	if (unlikely(io_should_wake(iowq)))
 		return 0;
 
-	return __io_cqring_wait_schedule(ctx, iowq, start_time);
+	return __io_cqring_wait_schedule(ctx, iowq, ext_arg, start_time);
 }
 
-struct ext_arg {
-	size_t argsz;
-	struct __kernel_timespec __user *ts;
-	const sigset_t __user *sig;
-	ktime_t min_time;
-};
-
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
@@ -2660,7 +2663,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 							TASK_INTERRUPTIBLE);
 		}
 
-		ret = io_cqring_wait_schedule(ctx, &iowq, start_time);
+		ret = io_cqring_wait_schedule(ctx, &iowq, ext_arg, start_time);
 		__set_current_state(TASK_RUNNING);
 		atomic_set(&ctx->cq_wait_nr, IO_CQ_WAKE_INIT);
 
@@ -3363,6 +3366,8 @@ static int io_get_ext_arg(unsigned flags, const void __user *argp,
 {
 	struct io_uring_getevents_arg arg;
 
+	ext_arg->iowait = !(flags & IORING_ENTER_NO_IOWAIT);
+
 	/*
 	 * If EXT_ARG isn't set, then we have no timespec and the argp pointer
 	 * is just a pointer to the sigset_t.
@@ -3399,7 +3404,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
 			       IORING_ENTER_SQ_WAIT | IORING_ENTER_EXT_ARG |
 			       IORING_ENTER_REGISTERED_RING |
-			       IORING_ENTER_ABS_TIMER)))
+			       IORING_ENTER_ABS_TIMER |
+			       IORING_ENTER_NO_IOWAIT)))
 		return -EINVAL;
 
 	/*
@@ -3786,7 +3792,8 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 			IORING_FEAT_EXT_ARG | IORING_FEAT_NATIVE_WORKERS |
 			IORING_FEAT_RSRC_TAGS | IORING_FEAT_CQE_SKIP |
 			IORING_FEAT_LINKED_FILE | IORING_FEAT_REG_REG_RING |
-			IORING_FEAT_RECVSEND_BUNDLE | IORING_FEAT_MIN_TIMEOUT;
+			IORING_FEAT_RECVSEND_BUNDLE | IORING_FEAT_MIN_TIMEOUT |
+			IORING_FEAT_NO_IOWAIT;
 
 	if (copy_to_user(params, p, sizeof(*p))) {
 		ret = -EFAULT;
-- 
2.55.0

