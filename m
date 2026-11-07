Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068185;
	b=ne71wLhaVxVfXKv4rETvhUlmcmWx5gogio0b5BXRY+Qwoj4YEXTk8bwqSG+KECZ5HhsI
	 EgeLRcKiEH7PtvkHQ3lkcfPbvqCyuNPd+zWSf2A94nJirHRj3dwebOLfmURvEVXfzI6yR
	 FuKEceNReFhIF8zQd98+aIFouJdtTXpW1aePvRkQqdysuXElJxO9+CWlz5l57Tov31dUx
	 91lZ1H31v4ay7svxwtOna/rLUva0DFSFdj6BtvXfSYxR4nPp8BH/lmUGWM6lqeSbE0TPd
	 gPev1ix+PwMK+12Ul8q11a5bJ5UtPg53bM1H7cNotw8cfs9KNeWtPVeFAjNr5un15qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=si87MtqdDn2mC6LRT9XGSFMKeoAhnrl1T8Dsht/RRP8=;
	b=QArCzZDU9hcaZcJ/9Y3ekKqEqB49WIs7n98fpH/qql3j1Ai8ZWONXpt1htNn/UoTowDc
	 5/C6YOOJmT26vcMUTacAGWozTSz1pl6AR73Fqj41BHu/XVdc2Pv238Ics7VRJ0KQZ9oQO
	 N8QEAWzN/IARTBgrAtc65ZyE2uNtVG3dWjgOo/QL49AAx+J6VZlOumth3CElaM7DvF/gE
	 qo8QIgRHo2lBbPkabgpQaYycaRZui2ZD2AyUMyqrlAt7/s21kVdYuceAdeV6WT4Mvf0vh
	 vOJEmsbQG6XlpXZkA6k82bXCjH3lKlDrXxOVKtI7Nv0rBrj4q4Bbjrzlxn4tgWX08vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Zo/fJFbU";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E9606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 442E9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Zo/fJFbU
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so637153b3a.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068185; x=1794672985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=si87MtqdDn2mC6LRT9XGSFMKeoAhnrl1T8Dsht/RRP8=;
        b=Zo/fJFbU0HElVOFvFtZQrI4wz6P83kLHadkFwrYLbVfY3uHVE3gyvvXQBF4hjdVl/d
         lwrg5v9W/mg3qoQUv1kSJfSj+BqNPG0oW7ODB1ThjpllXWhwvZaX5dqP43u3eUciZjS8
         BB7MA0gAOvfQEdu68JZntpiNrUWy9aCl9Z4OikI/SgKAcx3wArNDyyTSzn2T6u3P4Vpr
         f+siFoY3ANYIrBSkcdD6V6d8sR/atFux0PBJYscJcTyw081PTzl0+TFVUbr9SC66cGat
         PDJ78dC1gQVAJUfaiv5gvEiNSWE0BJtJeLk1acyk28tK00Ovmgtb2WFiFsWULt9H/YrN
         OkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068185; x=1794672985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=si87MtqdDn2mC6LRT9XGSFMKeoAhnrl1T8Dsht/RRP8=;
        b=lxmTpMNELwZNMVFXkjCxjFZmsa40uB132xcARSrewD9EGuOWaRrwHOmerlodc2VcFQ
         Xd7zyoy47fysw8nVWdzgcxyRGygN7PF3NMItSkfEQyWYPOK5Fz/mo9YnS2owbvdzgCQa
         EvOnwUFFaXiKZh0Vlgej7/oGy6lU4hvkLUDi+PXfqthdBAii7AryfKd+c5LexquLhWHg
         UBV8Xj4EUrGMy8BBG9ZzpH4Kx1juXfxdAGwJbXpqZ2rbB/dsGl4pfJ2Bd/ffI2tK31RQ
         SCipjFYUunCcaXyq/yzUXOaVxkvPvenIQgfiXnAzUwt1BncmQO7VYiHBnPNve+G3aGmN
         lX3w==
X-Gm-Message-State: APuU4Z+O/vggly9eNA5yyXlL7hu/DpMA/WxlNYJjRoDFHt5KKSttpccI
	doEL7BRpEz/C0lp3QtueNnkQ2qo9JYCN0zATY7BvwdzXiDZw+paOYsV8OpvM+owN0fDL1xVMeVg
	gV5fk
X-Gm-Gg: AYBFou36BTjCU91HyImMMc1YKkg0Qw+denT9L/dMJYO+lwAO3bONN8Ngl5ILjqh2117
	kiAp0TDJ2SqSLGY3qQYnwINwuV5M6OHQdxmdzoQcbiFtRCg/odNSWTfPCQGm8PAHEC+XLpFyT9b
	BleWZdWVTgFdsBMva63RCO+W5tN2nq0wwn2yfdbJahg1UuI/QSR9kgbJOAo2lYWGgO+JvQlKkCy
	CC10mv8vwGs5TkeAzMyF8jD+T0WgGxtKju8yAAsAwhqmXl5mvGwPbjdc952ZiQlrSXu08gnpt+B
	qDWE7NJAI4cHTBjEi1o4FeqrfOb1+3WRwke0YKTuyVkIQHzXzJTlW/umbnkDm1ClaR5qncaFOl3
	qQ31LS4Ch0+JmEqr0Xq0QnQ7x/LNVTo5CKPZ/TEhM1naxfzF1Q85m5IP8171nmNwVjhJhpehFi9
	URHvJAvarhxT2j1Sb4+33cCUbqgrvToHMXNoF7INZPdU45mgfW2G/d22ZcjYqSPTPIQJy1hdH81
	HxI5gDxdA6NQj3UNO1roGFVOYAGuusqGwI8KSfgCzrPBsMZu5gg6QD30ILOWKm2tT2HTtTRH1lv
	yG4Q9M3fv8dj1Bw4x70rz1EzkgsOkpWc9kxMe+nU1XO2JOyes/O+MvvktwaibKzJtptR0pI6nOV
	isospu5ae9RMdBPos8m+0
X-Received: by 2002:a17:90a:d446:b0:3b0:9cc6:62ba with SMTP id 98e67ed59e1d1-3b0db70adc6mr5298326a91.38.1794068184570;
        Sat, 07 Nov 2026 08:16:24 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 6/9] io_uring/poll: cancel all matching requests in one pass
Date: Sat,  7 Nov 2026 09:16:03 -0700
Message-ID: <20261107161606.2500384-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161606.2500384-1-axboe@kernel.dk>
References: <20261107161606.2500384-1-axboe@kernel.dk>
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
[axboe: 6.12 has bucket locks and two poll hash tables, take each bucket
lock while walking it, and sum what both tables cancelled]
---
 io_uring/cancel.c |  2 +-
 io_uring/poll.c   | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 16dd8af6ac98..727166a2ba3e 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -189,7 +189,7 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		/* futex and waitid return how many they cancelled */
+		/* poll, futex and waitid return how many they cancelled */
 		nr += max(ret, 1);
 	} while (1);
 
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 31454c27072b..39418fe05d59 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -892,14 +892,52 @@ static int io_poll_disarm(struct io_kiocb *req)
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
@@ -914,16 +952,22 @@ static int __io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
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

