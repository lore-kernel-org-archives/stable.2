Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068153;
	b=uF1sQLbhu9nsc9O2l5ZlZ+/jUQcIwcXcPvh5sfstyMJQnoCnWiYXPXJl/ziuQAUSkvkS
	 lA96g1t6v5brozm4lt0lSBgOUwPF0NS806yx1j7BdSjkuiQNxieZa/5GKy+FpyohoiSJZ
	 mDyQqOOSzAfj96AjPwxzNVbPFQOpGZflxQEwBc6Vo9SQ4+qtM6bvcTgc46BfkcfeOGnMQ
	 3Uuy9+1oBtd6ODEdCEOQcpTVvZvv1+MTCLZLBomKy9QO2vrhsfpLa6bsIHH+MUZhzHTjE
	 xL23ixUGHfcuFXLHz33uEsKDMVXYlxIYZ107PJ/LXteLsQ8ZsxN2yfZ5WisihExeB+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CbNrpY22GWYoKnYWn3gwmn4amcehWCT00xg4ZlrmFrw=;
	b=ZdKxdcF9nXavkifwSc95XfR17gJ0RMBcO9OPBWs9e/dCmKeya8xNJpDhYVQhuGNHsjiC
	 vU+XpE4cHAPZdf3HKD2KzQvPqPwYshH7IauUDM6euhRw627UZWPyXytcyY3lYWSXw8EJn
	 8FH/ap6fkAg6T9Pp74mnZo+kmeembppongLIMrb2pZmTKpoiOxdS18j7ZmukgDAMBrFlt
	 BTK2q11M4/IHbUUd/FN8n6i5IUdzzUZ48QACraSJP19UEBzIHTveDOyAxhdpo6Z1xYuRN
	 Yr/tF9qrcVa0/kDoJIUJyfoRawro4zB4Y7Iy9zLiud7Ysqtu0qn1FzBt5utlv9xGkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jTz9+nYb;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40490606EE8A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40490606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jTz9+nYb
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso9352355ad.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068153; x=1794672953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CbNrpY22GWYoKnYWn3gwmn4amcehWCT00xg4ZlrmFrw=;
        b=jTz9+nYb8tugohcNyIUvtjpJ70+VsaDy9f6a3XtfuwJfznnvEC09gwAi/x259XXV6s
         yFo5jSBXmhTnkv9gYPogVfITHuYuRSvETTPIlIvb/HtAxIHLC7zV2FfUvJMWpLcAd/k8
         aBAP1lbJ/8EAwkdb7jOC4194IkwOR23DbzYRBN6FtIxq/hJQ+eE7OWgtwMKlHHwZksle
         7SHMAD/77DoFeRIy/sWElPavQGklPRA1Uf93nJKDffqSgbLHFBR++Nay4FTbEMMkw1G4
         bM90Yps9xEb5QjKxxntI9/7l+2Y2I3O9HPVfi+fSdleV+MethMfrE/AOa4GLTplfs6rw
         6tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068153; x=1794672953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CbNrpY22GWYoKnYWn3gwmn4amcehWCT00xg4ZlrmFrw=;
        b=M2LP1cnHHLWBaKjUjfwWv9FQRkk/9yqK54HYM7z/WIUQDScYMKW6YHg4mx9j90f4ZC
         ws8bwtF4kgdJZjoEPitQ4num4y5DrMCcxRMnd2mRv+65lPOlrxU+bcIElfrmvgeMnwvY
         /wWZEIhgMlVeD4GkDiX98Zekl2B/Xu5/Ob22PS7dx+yB9FUUZXhSVg2dbexfK0PFnrcS
         V1i2oAia8tH3X9uo5vVD8DetqzlNguvdKPScSXhd8IATShdK8tHjD2I/8On43jjVJ4A4
         aTLjhBIKgL8Nm5NsHcCeVljpDT6H+QvpTSVMMwMM+ZxTbR6KREtYsYyLA394IOGWuTVj
         Snag==
X-Gm-Message-State: APuU4Z+hXy+4tFaHalkoxCmftX8YMEkmg/dVAL96Ri+V6rMfDzwtHwtS
	QbA3bbFtaKeoVYw//ieu0qf5XiEXlbi1x/oDGxl1kJcytSHFQu0SlUOZGcHihL4xEJ6HL9tppqe
	ifzupX/M=
X-Gm-Gg: AYBFou2GyLAc+HsBnx0GExpK1R8UDjrM2bX8OWX/OPPnrRwbM0sLYGkxKEuBEZn3jIu
	st4MbUn10QbD6WQwp5BBZr6gih+T46T5ciflf25BTukzElZxWSLAvP+eGEEQRoy9xmz9y2hC4Qv
	ypmKqQ8PPhpLt//RxB3oU+DvIwS/nEIqEvz5Ihb9lHwDUknQeCQXxI3RUQIMJl5+O2Wdw11DKx7
	uMh8h4RXPEHcMpY9nCZSEC+jUfCV5Om+aFzDsLMYjntNH3U04VkNd4D7AYenzwaNkOwtPki4vyA
	ruWRn4s/HwgA59DsxLjbb/m7xF7IeTIzdOJoVVHGrA3Do++gOToyuT8DIr6b5D1AjJq5xLJ3dn2
	Ax0BwGoMxMVujF9rQcBj+0WHqkny9q3NU9d6LraDtENDi8g9yH84KnPDCf+rrz+6Ug0DsUW8JR8
	U181e9N+mIMsvq27PWc9p1sr2QgnWQKaV9ehB+KKkUOXNMdVuGtkrO0r/QQPc/yrYGXmiDsgaqa
	wwny0kLwaF8ONyfFdOgI4R/kMR7Cx3xHWb4D6927LNvz/4OEo8gMttCyjGA/5HgqPzczyo2UTJV
	Kpn1QOYEue8oQ6wnB9O1vsU8RxGUzZDfX5JYaLEyUyNNh7HAFgEml3WODyeABrqfsSvklYiKu+Y
	=
X-Received: by 2002:a17:902:e946:b0:2e9:460e:ca49 with SMTP id d9443c01a7336-2ed41836b5fmr72280985ad.18.1794068152594;
        Sat, 07 Nov 2026 08:15:52 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 4/7] io_uring/poll: cancel all matching requests in one pass
Date: Sat,  7 Nov 2026 09:15:39 -0700
Message-ID: <20261107161542.2500190-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161542.2500190-1-axboe@kernel.dk>
References: <20261107161542.2500190-1-axboe@kernel.dk>
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
[axboe: 6.6 has bucket locks and two poll hash tables, take each bucket
lock while walking it, and sum what both tables cancelled. 6.6 has no
futex or waitid, so have __io_async_cancel() add up what poll returns]
---
 io_uring/cancel.c |  3 ++-
 io_uring/poll.c   | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 5663b8bf4ccb..cadf3fb349ea 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -179,7 +179,8 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		nr++;
+		/* poll returns how many it cancelled */
+		nr += max(ret, 1);
 	} while (1);
 
 	/* slow path, try all io-wq's */
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 8050261ffba0..08d65792f3cb 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -879,14 +879,52 @@ static int io_poll_disarm(struct io_kiocb *req)
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
@@ -901,16 +939,22 @@ static int __io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
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

