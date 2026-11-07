Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068207;
	b=NLbN8ApA5pIsacuaGW099WeEv2RjGXhCb+yMfm+Ybf7ddGwQV/XI4zFY8d6Y/OcdoVJF
	 ezot9tIcUo+fX39QfgvwK49DCwwq7bXT66J2nzkJjft1wENCT4h2e0s5yZrycx5bKXFjT
	 2l1zlSSHifvDJ3IyEK4Q/fGy7kLHAvJRHsOJt2+xalTAi7Z3ZoHehY9yGAg8XzHX2G22o
	 itokDqF8oCZ2WXzM9qhZsMux9PmV69MkoS1v1d9TJsRYYCqcrgaf1OEtQ3CY7yexhI9NJ
	 m0MGrpryfxkjiBFoYTIDqJ/HjFQ0kEplsoCK2kjCP0pIYcHRlb7iBMpEa690QHw92GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LQiateAUKTKyjZ6AFASeVIROgDzTda+PMLnsgfWNUbs=;
	b=jpbLHw3nnjkSnokGQeasfAhRzftgPQM2uRg7Z1+orXf0yBYgUK7315mPmVs9KV2JSy41
	 SRd15alGHMKUxkGuegp1FB6Cw/CZRUrnCugNVprNeeQukbY8LBXxqc/1p5myGMYCb18+B
	 iLSS0uBjozhjFF+8DRvIMUwe4lGGL/jNA856i8+PTYbGk5wXYWDFTnmOx+ainSIevqde4
	 DoBsBloXKwUt6j9LJKg+cYfk70ZLxmnEZarb5/5XLu/Hx+7RiC22cSF0jsia63uKT0adV
	 90StX85wNG3xtsowFt7zwZybaxwaJaT0IsnnULz7LOcP1XP8nQoQvOS9vb/YgwBJJRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jbGFBt6d;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BC606D3CB
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3BC606D3CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jbGFBt6d
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso876978a12.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068207; x=1794673007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LQiateAUKTKyjZ6AFASeVIROgDzTda+PMLnsgfWNUbs=;
        b=jbGFBt6dbrweFITTFh7xeWSk9CB+e7xvBHO21gCqOBvvVVYMR6CsbD6nQFEuGHHaKz
         5bu6cR7nmdsk8YY3oYSM177H4g9otlm02D5z/5KfandYVVy1jnM4sPTRh1lORS7a5eR9
         g0EHxGYN5J3uXgnVPEJShtRhRjzGg4dFWcO2zThdhA+XKdlcxh9t3ue4W1anT8XeANFF
         +XoU5ASLDOFnHJypLGvsdgqX0U/AK+38HDijbRE0/nobVvxXZwvNFQ89AYcj02HHixJy
         h0S96rZ5pNcaPr8GVHFvCopENrLgD2gDpJ2ueb2Yvqfe7OzPCXE0CjFdDw0oTv86UUer
         /hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068207; x=1794673007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LQiateAUKTKyjZ6AFASeVIROgDzTda+PMLnsgfWNUbs=;
        b=VDQd2AGxzO/4H4ZlRb0yQWk782KtZvlNuv/lbYjfzNoWzB4X5RfjsuZv0Kti1EGBMx
         Z4X+mkw5idlF4/5EMFTeSWtbd61I8CYy4N2Pj7ACqlFLwIT9RctzvARSWKngxJsyXmgm
         JYXyPL+3aovEuSy3GN73qPHbi3fAwaPFch5h7TMFBgOZd2Pg8S+oime5wMftEcWK399o
         qH9NxYQQyW5B/CjmgJ92ojtLIc/mT6bqa2eWPjSz8eiYW19A6USbQhWTrk5zkh3i5Vfo
         rOKPGjB0dPIRGOhPDFpSCiBDDKZ9WvMMW1PN62Q0Ag72AQsMq+A26cPhlmtrsp9F7TtW
         lZFw==
X-Gm-Message-State: APuU4Z9CwMSxFCz/uWlJQ/YJ+NDML4j1ZqY5qR29sBhm7+xbl/Qipbvt
	V6nLt8HxguIclbYEBn2HextN13c6Ec1f7p/pDf+RAG7Ryw8bUU93qdV5mSkqQrV/TZnveAMeh4t
	8DPkO
X-Gm-Gg: AYBFou19tiEXUFLgM4Ozhn+651rIKQWTdFezg5ohcVxD0gWYryBDafb+PsJCkLQPkjX
	+C/Jd1MJUAFG7A/Pt9o5lvKqv6oEVdYhLKxO6lSuALJfbC9FSAy3nGVbKUQUOQWv3XwJ2pYZ59X
	Sk7IE1Ck2tQGhbBfYqFgTNGpIjxQ2CrVL4RlPvyJjDi2hB0CWTjye7aEQhqChJ9leER0sJSXxhf
	73ibVnJWOWhY7gSnLh6pRxs3PPMuPEb+j5ddn2s7WNeIC4v4d+to3NndSQE/rhcxUgEVX5baSse
	kP8CU8CndYf5oWDLbvdva0DuhjaksSjUFCZ2wX+fn5TxIRPA2FwDZvMXZLPdHOSVZ03Iw6U0SRM
	pChGeqPNVkrxqMaN6io95gK8lNS0vipvGVZ/xX/n03IgkRY6KGnQj2EGlig2HjFb4tFIPGhCU8Q
	78k1vTW1sURbCAFRt96eT67Fz0l68M4unT8RF2KSXBdi4QsO/qQfF1UBLY3nrN3nGtt0Q3EE0C5
	ffy4kBhrNSxiC8OTpFpqG0JZMHGc+SsAAaBdnKcqz7w57iIm8Xfj/5vipDmspUHGDGhBjzkeLqJ
	wHFe7sM/8WuDRFBf1fJhkalXGWyRsPHVHURQBSw46iX71OwV0O04CILPuOO0pktXm8nayd48CQQ
	=
X-Received: by 2002:a17:90b:224c:b0:3ac:b3e5:428f with SMTP id 98e67ed59e1d1-3b0db6f8d0dmr6133229a91.53.1794068206849;
        Sat, 07 Nov 2026 08:16:46 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 6/9] io_uring/poll: cancel all matching requests in one pass
Date: Sat,  7 Nov 2026 09:16:31 -0700
Message-ID: <20261107161634.2500557-7-axboe@kernel.dk>
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

From: Shang En Sim <sim@shangen.org>

Commit 9eff9c07e927dcd9c57150cd6fb3d4ec76f00480 upstream.

With IORING_ASYNC_CANCEL_ALL, __io_async_cancel() calls io_try_cancel()
until nothing is found, and io_poll_cancel() cancels one request per
call, starting each lookup at the beginning of the hash. A cancelled
request stays hashed until its task work runs, so every lookup walks
past the ones already cancelled. Cancelling K of N pending polls visits
about K*N/2 requests in one io_uring_enter(), with uring_lock held.

A single CANCEL_FD|ALL on 80000 polls on one eventfd takes 17.06s,
0.02s with this change. With voluntary preemption the soft lockup
watchdog fires:

  watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [repro:100]
  RIP: 0010:io_cancel_req_match+0x19/0xa0
   io_poll_cancel+0x73/0x170
   io_try_cancel+0x7b/0xf0
   __io_async_cancel+0x41/0x110

Walk the hash once and cancel every match, as io_cancel_remove() does
for futex and waitid. Cancel by user_data only needs its own bucket.
__io_async_cancel() still loops until nothing is found, so a request
that io-wq parks in the poll hash meanwhile is still cancelled.

A cancel that matches one request now walks the whole hash twice instead
of stopping at the match.

Cc: stable@vger.kernel.org
Fixes: 8e29da69fead ("io_uring: add support for IORING_ASYNC_CANCEL_ALL")
Signed-off-by: Shang En Sim <sim@shangen.org>
Link: https://patch.msgid.link/20261030050319.1448530-3-sim@shangen.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/cancel.c |  2 +-
 io_uring/poll.c   | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 1db26c66e45c..471d6f2e5f18 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -192,7 +192,7 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		/* futex and waitid return how many they cancelled */
+		/* poll, futex and waitid return how many they cancelled */
 		nr += max(ret, 1);
 	} while (1);
 
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 48381f0cbe32..6af64c7618e5 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -824,12 +824,47 @@ static int io_poll_disarm(struct io_kiocb *req)
 	return 0;
 }
 
+/*
+ * Cancel every request matching @cd in one pass. Cancelled requests stay
+ * hashed until their task work runs, so finding them one at a time would
+ * walk past all the earlier ones on each lookup.
+ */
+static int io_poll_cancel_all(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
+{
+	unsigned int nr_buckets = 1U << ctx->cancel_table.hash_bits;
+	unsigned int i = 0;
+	struct hlist_node *tmp;
+	struct io_kiocb *req;
+	int nr = 0;
+
+	if (!(cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP |
+			   IORING_ASYNC_CANCEL_ANY))) {
+		/* keyed by user_data, so only one bucket can match */
+		i = hash_long(cd->data, ctx->cancel_table.hash_bits);
+		nr_buckets = i + 1;
+	}
+
+	for (; i < nr_buckets; i++) {
+		struct io_hash_bucket *hb = &ctx->cancel_table.hbs[i];
+
+		hlist_for_each_entry_safe(req, tmp, &hb->list, hash_node) {
+			if (!io_cancel_req_match(req, cd))
+				continue;
+			io_poll_cancel_req(req);
+			nr++;
+		}
+	}
+	return nr ?: -ENOENT;
+}
+
 static int __io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 {
 	struct io_kiocb *req;
 
-	if (cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP |
-			 IORING_ASYNC_CANCEL_ANY))
+	if (cd->flags & (IORING_ASYNC_CANCEL_ALL | IORING_ASYNC_CANCEL_ANY))
+		return io_poll_cancel_all(ctx, cd);
+
+	if (cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP))
 		req = io_poll_file_find(ctx, cd);
 	else
 		req = io_poll_find(ctx, false, cd);
-- 
2.56.0

