Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068228;
	b=o0x0d+j/EJEHg6ihyo5BwGJNr0VFOAf8XmJGd3+YUgQbRyFKcodMJc3VyaIh1yKj5U6Y
	 ZCA54kXEKEaj7YGw1qyq9tjj6Bz41dnbhvlHMRYD3LXB6sfWMfKhki1V6aTX6s2Mjub8G
	 DJPEGP9fJFeb4p2Cp/p/RVGXshNNkX2TeMuoQQ3pPnfXUj0Mfbt9Ss+whXKLCJ2YnQ8kO
	 sDlsJN3J5oRh/jQ8CgPMX4AO6226yiUK3o/9mWRot9N0j0dFbn0TEl1LDdhlTwIFfCFNU
	 DN42gsG4fmhN7E8RNBCb9kLV/1e/2uwS8I779fXDFfvSrROW2qsX9aMqKHnNDGGn8Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KIrue3znvKDSf3iUp82Jtr3uMAYMOyRTsQT8eCI29V8=;
	b=to9Bpv+LUkzz7GsigHsKqscqayAiFR60mRAeSRDnfuv6qFRpQTq+EXK32swzYU/FC+Wi
	 GJ4YtYP711N19ojtcI+2nYgTLlifbXsDEUKa6YZ0vkygt9LakFkifrjtM36ZAhNVue030
	 Zjk8GVssgVITM61Gg/MsLqgdOWqSwE9gjRhTL17TX5+LO1fv4DPSyfTmphyAzsZ8YVEox
	 GuCyhPcncIc6TJCxHRChCL0iHNdaod+q0piuT06rAlfQSqB912bBsMtnWlgprjN3siQ7g
	 7aScvhPJWMECsS8G5lZZwX6S+TRBH/ZERVe1nakisKYp5+AqNR20wk7hLak4rwX/rOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PhSYfOLn;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C993606AC13
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C993606AC13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PhSYfOLn
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1100523a91.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068227; x=1794673027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KIrue3znvKDSf3iUp82Jtr3uMAYMOyRTsQT8eCI29V8=;
        b=PhSYfOLnk1892saq9SShJGOn6PcSBH2k0IBPMovHEL2DNKjxibvh8jt1rp/Aa0aXEO
         u9aJUVhB50pK7AGFPKII5+H9eVSW+qgn5Y7yJSpVe2Tks4GrKnpJUignV8UzUkM877xT
         8vz3NR4b/8AbHpDjWe9d+C4eKgahHwJOFheV2MzOm8j5KxFNS5LpJJajsmmawogBbAC3
         rKPcDOVVu5jR40X/qwn+KIxI4GL86ucf50P6HTxCMgU2rixO/LEo3FMlVnyJa8nCHz5l
         vaC5QoB24LoXaOWYhx0tp7rzZI6nxBoC19IpZbBYfy8Q6S0fuHOX8uhaON0DtXYq37yu
         qmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068227; x=1794673027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KIrue3znvKDSf3iUp82Jtr3uMAYMOyRTsQT8eCI29V8=;
        b=mElPQ8kluUBiZIPHTLmCF6iwITyTLWAtZHn/vwnxvXrANEAR6VOxOh25qMey+vjtWM
         g7LeeKP7kt7Ey9LJ8zqQMLf2n92H3gIG6IzKbixtHD2CdqkWUmIVsiuRKRmEIxdw/EcT
         8ERYapj0hFMzfpWUJ0c/hObnjt3peg2/oBrbZJWZNRPD0fHO75Hn9BYpVOO8Q7IkBkby
         VDjVujIc/5yYImwunnqqSAgRMEGzAAWNpcBHlGzdm1QfwrUNoZ6Ku2LpLe5fMnFSZruO
         NA1AzBiCVvS1fEFz7aH8G65E9+a9o32Io1abBWitdxfcKT3zzwPpbrtOqe08hQ/wJ+z2
         Engg==
X-Gm-Message-State: APuU4Z8axcqYs69dNdr1bykXsIGqAIcj3DJEufESpDyRd/4xZK/Wm1mJ
	ixc44XtGryEf/ksq6tYHHVozFYcyELpkdvGKhWp7GyU6fAMsciavnrr9AlKb3gl5MiypA1tm0MO
	Z5kMP6Ig=
X-Gm-Gg: AYBFou31WSGHcZxyBIrXJKgaxC++lJgGHkiqsJ4XjtuPw94s8BrHASdCI/BDtnrSTs9
	qpaSqHL4kLTk2hdEbLp3Qo+PXZK/PfledDGcjXFA9qztuDKMyFKbTVR8RzHFPPxBWIMNtac+vaM
	TOwP6WAchB5zJRUmlJ9+aff+XJfSuFYGZzWWHhZ6BSxhEtKVtK4mP1YJKn0mifER9Q6bDjuS4R7
	TBmEmMG+O47v4ey198h1v92ozdFNixHZKGX+uyTwk85XQU0Z0Q1sJUem3FyHXfWlJatPP1XInlx
	KnJSWaQ3jGpJWyld3LivWoTmGj9NBgFD7rb/qS+TMuj+BpNLmnOUYhItU0lNggn8ZW15ajL5uyJ
	wSzs2W+l46PsDHVWvXsgZLdadnyb+OP8t1PYelzSJJKJiMQVaoLSWfwRHl48OQSGLAzUeqIISLc
	cNaIDSbNLrJz0R1DCbPUTeivAYmyU9SVLGtWl83kNp8u/ySG6SibKZPdoHXFWuHbXRMmBCKx6iw
	/DYbmTo/3Jyas2UUApEmMCHcnGL8ZvtwPHs+OQ/00llOysp+UjRooHmuym/a0NFoz2YQB7t/btT
	n82nS2zBjsmsmmDqEaYX6/GzC9f60LPT0kkXRgg/CZHjcY7JG1HroMRLmgxEfvZpyXGVyeGvp08
	=
X-Received: by 2002:a17:90b:3c08:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3b0db702ddcmr6025699a91.58.1794068227449;
        Sat, 07 Nov 2026 08:17:07 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 6/9] io_uring/poll: cancel all matching requests in one pass
Date: Sat,  7 Nov 2026 09:16:53 -0700
Message-ID: <20261107161656.2500790-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161656.2500790-1-axboe@kernel.dk>
References: <20261107161656.2500790-1-axboe@kernel.dk>
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
index a34543cb423c..6be224ab53dc 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -198,7 +198,7 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		/* futex and waitid return how many they cancelled */
+		/* poll, futex and waitid return how many they cancelled */
 		nr += max(ret, 1);
 	} while (1);
 
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 4f04bda42f7f..9b73b0d88a0e 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -827,12 +827,47 @@ static int io_poll_disarm(struct io_kiocb *req)
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

