Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068129;
	b=yGCxQn15f3odP0ZRv1k6boi/7xX/ofdB1b2ZmCgmkYbb4+XzyFUjA5cVFTSUrhl4Bq9a
	 V2MVtUUMbC5wRi9ySVHjzTtBGSlTjZ/e7sKhRc9vlEHRizmEpgz5Di4czztr9M3N6ifIh
	 zx9/BvAcnaccofSPU68G6QPBWOD/rf9txycniyd6igPJNAWQD5K/R2tLUJchT3mU8gASR
	 nHTKR7xUEdkwGm2xARvGszdjVFjsR7I0oSxUAVGzOTBy4rDlj7799fvnu8HNGy/gFLKmL
	 4fA3S732cABuEo5L+Nj3mz6NZIq6IDuttXOF+ANbgYqc/p6XEVQ7ycESpy3+qx8OkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KsRyFw1r+x3WqoBuVW38qzm2zKnU3CteART8A+/gZAw=;
	b=ekybLP6j4mTHYnaPXgHPATnCFSOF63yWTBJ9RZl1hvYIaYcyrr5YETjsqSCs3vMQP1sN
	 Qw66f0JowMwrjS+hiGAYh0QYIlhQTQU9F7/0g+Tl8hO/G97zYE9s7qGKCCACmlER983LZ
	 kkhB3EMVzbSIGY2tfzlANF5sDnJjmBPGeB9Y27GyBY6xZvuz/d5k74MkssrQEXeeN4G2N
	 f44frMs+LLjJ/4hXecgg0fk9CAvRu8heFuNhQqlBmVqDcM+smlECVeSuu06B5dS7jyA/W
	 iZNvU+WhOvLMlyd0lfrT4Bze7kyyvsimAJYkg7t4iLk5mxr6Sg2gnd7Uq+nLgPagaMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GDFm+NgU;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F5606AC2D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A14F5606AC2D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GDFm+NgU
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb681de50eso583105a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068128; x=1794672928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KsRyFw1r+x3WqoBuVW38qzm2zKnU3CteART8A+/gZAw=;
        b=GDFm+NgU1tzktWCwYY21p/sn+LSc5SIuKbX3+h7klJpTGkv089pJA/inAmqBgjr3Lc
         HW4kQzi2FnDf3XRf8SdkGS5AwVCp7hXfRBq+FB0kuCk/RM6Z1m7aL5Nj0FvX3bdzS2rL
         2EhavymvwS0oNGmdWk9b0dsa09IDq6NLEFK1Ps84oQA4B6jeSTztNBLn1CshQxreQA9o
         Kt8uX48uC6TP/Yt5atP6aNy4adT2iSwPSITNX/HURbCAhpS1xwQrtIYzt3OqS/H59RR6
         JXrQ3wWU2acb2H0UuO+eGee06TwWcGcUZbgoJ75c7qn/3TN1aqoV05nZgU2XMBYqAnX/
         uzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068128; x=1794672928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KsRyFw1r+x3WqoBuVW38qzm2zKnU3CteART8A+/gZAw=;
        b=pmbCF1S5jUdFjur64IoRIQsx9I3I3h950WHKkUxQaK7dCzmnCKBcuKthb06SUWdX4L
         XtoA/nHl0Jyt1yLh608alMr1Ihm3VqhYzLoNqgsV51D1/TpzXPM5OSWGAfWFUkLeCMHf
         MgrUJMsnmGZ2u3O+PSFNZYAGwznCI8BbmQaL60pLYTHDzUDkcmTZIE1y3QqtG288AxQN
         D80hmE9Wc7RlQ7VOoxABzv+aUdlsslkqoFFwITzOR9hwPt7LuA7ZGg0ku44VG0Nu7qRr
         q6QtFUBaC6UvWrLpCUKpi4RuVJI+FK+zNBe1hiN87zzyU9BWG2N77+VKxOP8ztBGuGoH
         T6KQ==
X-Gm-Message-State: APuU4Z8/IEsn2KVpJiVX1cPgiZRmtwrY/sv5jiPu7MM8AKt6wC/wZnOK
	W6Dg/Kjpf68UI/Dt6VckKRcbozNtGaTZiAPqxbX+Uq4IyympHXuPeFScKKghWHvBvZptKNP76wY
	DRIEBYi4=
X-Gm-Gg: AYBFou0bVKU3fRlcyJ9FR0hd6QgZvlhM9G/NMbcHLpCkLYqUN+/jy2Xta9gh1a3ZlWR
	9bDJamUDrAZgy/iPyodpoutKgcEmXzZ4/gw/MqiYcj6A4GMqtYLa5AKwc2U6jU1cu576cTjJ4Y8
	XfT/U+Zg/GCUD3IUkft/ObHusLQoFXFhzotCalKzpV3d17bqrSMTFD2rDMSi+5SjziD79539shE
	shP4IaCwqihK8KHLjo2y/5lG5tdi3nygF017cAz2h4jW6gBkAoqtFqfFLg99wPMGg6UlpVPbO90
	wM3Z/z2RL/Wnpq1CjmO7KljkZUvKbUyGV8/qoG50LQlwarhqyeXdrT5/LWg83qTSDGC1v1TrMxH
	x+MFH/RLqQbiuGFZQd/qHTbTBS5IncRuq1UBKTbiqFd4dLhagwEU1YXxeyPf45gSiiWETzlc4uS
	FVuEqs8r+mbUfxC+/2TTcp3/iuFXJRmByW5lrq8iFA0P6RZVZPNoqghZxkiVYCwewIIr0eWBiw+
	XWcGxcuxeb/m2BGTNAFSq/d5AJSIszpSOlxQymhAolgB8+Uxk7rQ9AVSMbeDb7V49DgvOk4A5MB
	qaVbwcycgNAj6oFvy0ggwKDfGIap9BrEkyW4uwvw2w+8YNzew8v9rTyrGtJeVHp+laAfFA/xGcs
	=
X-Received: by 2002:a17:90a:7f83:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3b110ad7bbbmr762412a91.67.1794068127805;
        Sat, 07 Nov 2026 08:15:27 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 4/7] io_uring/poll: cancel all matching requests in one pass
Date: Sat,  7 Nov 2026 09:15:11 -0700
Message-ID: <20261107161514.2499962-5-axboe@kernel.dk>
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
[axboe: 6.1 has bucket locks and two poll hash tables, take each bucket
lock while walking it, and sum what both tables cancelled. 6.1 has no
futex or waitid, so have __io_async_cancel() add up what poll returns]
---
 io_uring/cancel.c |  3 ++-
 io_uring/poll.c   | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 91ed58712b43..6b82f485b39d 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -180,7 +180,8 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		nr++;
+		/* poll returns how many it cancelled */
+		nr += max(ret, 1);
 	} while (1);
 
 	/* slow path, try all io-wq's */
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 904a5a0bae2e..2b4c3550c455 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -895,14 +895,52 @@ static int io_poll_disarm(struct io_kiocb *req)
 	return 0;
 }
 
+/*
+ * Cancel every request matching @cd in one pass. Cancelled requests stay
+ * hashed until their task work runs, so finding them one at a time would
+ * walk past all the earlier ones on each lookup.
+ */
+static int io_poll_cancel_all(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
+			      struct io_hash_table *table)
+{
+	unsigned int nr_buckets = 1U << table->hash_bits;
+	unsigned int i = 0;
+	struct hlist_node *tmp;
+	struct io_kiocb *req;
+	int nr = 0;
+
+	if (!(cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP |
+			   IORING_ASYNC_CANCEL_ANY))) {
+		/* keyed by user_data, so only one bucket can match */
+		i = hash_long(cd->data, table->hash_bits);
+		nr_buckets = i + 1;
+	}
+
+	for (; i < nr_buckets; i++) {
+		struct io_hash_bucket *hb = &table->hbs[i];
+
+		spin_lock(&hb->lock);
+		hlist_for_each_entry_safe(req, tmp, &hb->list, hash_node) {
+			if (!io_cancel_req_match(req, cd))
+				continue;
+			io_poll_cancel_req(req);
+			nr++;
+		}
+		spin_unlock(&hb->lock);
+	}
+	return nr;
+}
+
 static int __io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 			    struct io_hash_table *table)
 {
 	struct io_hash_bucket *bucket;
 	struct io_kiocb *req;
 
-	if (cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP |
-			 IORING_ASYNC_CANCEL_ANY))
+	if (cd->flags & (IORING_ASYNC_CANCEL_ALL | IORING_ASYNC_CANCEL_ANY))
+		return io_poll_cancel_all(ctx, cd, table) ?: -ENOENT;
+
+	if (cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP))
 		req = io_poll_file_find(ctx, cd, table, &bucket);
 	else
 		req = io_poll_find(ctx, false, cd, table, &bucket);
@@ -917,16 +955,22 @@ static int __io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 int io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 		   unsigned issue_flags)
 {
-	int ret;
+	bool all = cd->flags & (IORING_ASYNC_CANCEL_ALL | IORING_ASYNC_CANCEL_ANY);
+	int ret, nr;
 
 	ret = __io_poll_cancel(ctx, cd, &ctx->cancel_table);
-	if (ret != -ENOENT)
+	if (ret != -ENOENT && !all)
 		return ret;
+	nr = max(ret, 0);
 
 	io_ring_submit_lock(ctx, issue_flags);
 	ret = __io_poll_cancel(ctx, cd, &ctx->cancel_table_locked);
 	io_ring_submit_unlock(ctx, issue_flags);
-	return ret;
+	if (!all)
+		return ret;
+	/* with ALL or ANY, both tables return how many they cancelled */
+	nr += max(ret, 0);
+	return nr ?: -ENOENT;
 }
 
 static __poll_t io_poll_parse_events(const struct io_uring_sqe *sqe,
-- 
2.56.0

