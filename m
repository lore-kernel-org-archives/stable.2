Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817940;
	b=BVHTqCB2fiCz+Foj9PU5JI5G2IhIxm9a3HBJeQ57DN7XrfKIWk+8OrQYJTGj2+p6s6ma
	 PkX67bSXm2DYubHKbTW+qqzSIpDUjcFGT5/Mspsh/w4MyAZ3GJKztDi2d+dmxy5FBzLWx
	 yvotJ58zSCCUwjSt9RIGL1yvh01k5LeYRlo276PvcBG1qJlqIh+RfjosU6waumXoUbazw
	 d1NPWM2hOrLtb+nld6ElHPyv45X1Pnkw+wab4XAi1B5hO6abfGLFekbDBuZJsQjQR9dQF
	 mfdtsR4t5Nuk+mn8bNEtxDDrrxyPdJJGqo7fgmi9rOP5LGKDtQhbYnl1DbYoaGCGT7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/CmzTB3Tk8RTCaRLnypnSuyM/slUzrsowwdlL4L6nY0=;
	b=poh/KZofg3LqNQEKAHZV5VGKIr/K4j+2hvy2TQGu3AA1qhPML29JqPB2KjHc7YFTkYon
	 Uc7NK8rxdu0Z19BQk2j62Oeug8bWVUg/zWyoNO1Tt85H+QOmeazZJV1cjX0FHUS33YXak
	 WM1VkFI9yTQrIbIGkVtCag6BXN8aGeylIagHIF/BlmEkCFc+u5RluAqhgiatVMl/huUXz
	 z9NRZJzLDKOmCkNxmY/pcELTw1fw7s48+aCAcqgjVsn+iQhsYo8LK8mqaXIBr/6gvQ9Gy
	 JdqxQZBRFizlN4Ma9ewn2Otvvoum1x5CXG2YwuCzQHCExQauf4ibSC1pT93afCMaDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A+6gg1N2;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7D606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A+6gg1N2
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-475920b9ca2so372097fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817939; x=1794422739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/CmzTB3Tk8RTCaRLnypnSuyM/slUzrsowwdlL4L6nY0=;
        b=A+6gg1N2lYdQoAauLMjv412QAfegzah1wQdcVlfO2r5aybpbF0TKeIBM7E8gQHT0mn
         oMqLobr5bbsMQnFYDXk3qCBErKoPeb4pW/yTeepCARA8l6o+szQVnsralMw2Ce6BIs+M
         WYDM+7JTdz0qG9hNu//n/6fUfYo1eZKhM5PmvZCJhdAl6HHtNACaiRfzxTTzeUGKsN7a
         Sy/ctsdF87HsS5mSIBZFQy1Bh/qcjfKNpUWRVSyAe/v6+gSamBoQv2DwXWCqVLGPJvXn
         EPUpZ5fbPq/So3woys0Ne14RvL37IUsEUwmiqgyQ3Ddl+tw0VAezej5WMU83yFtECUgD
         azrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817939; x=1794422739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/CmzTB3Tk8RTCaRLnypnSuyM/slUzrsowwdlL4L6nY0=;
        b=VY9Bv4/L3Wvz5uSe9CyspjaYJe0ixoaKygf1+mDGmzbn3VnaeQ/KJkRbo7wlci32YB
         k2kOutZYxuSurGo+FrooV2vKUwqz95ujbC+Iy8cAjNQJX/0qWBgAPJj41FyBXYjsvUVR
         BD0jA5/2OxeETupLuwB/IIIo1K1R8lYDVdzCfRGJ5bQnUy8cjq0+FkMjv73nTeyrNPlI
         zfKYILPuIhR0S0woHes5tCwGH3M2I0kE4GjoWMAteui6xsymZnROJmqdxVd2hORWzeez
         eOid9pq6/7SEil4kgDGuDuqdTa89IrdV9JnYC7DBaReFCdL1uBNskQYqf0rEJ3tgyO0t
         l0qw==
X-Gm-Message-State: APuU4Z8euZrQ+QPs4nUcH0Mm0TYZQooevoBezmWg+jXph1ct6Gj6vxYU
	oPefDin1gJ6LYofYKRSTwVew9o2hBdgR0mId3G3zDIWEa7LzQfrljReYZK7QefU17deVIsxJrPy
	/rOha0ZM=
X-Gm-Gg: AYBFou0rGep0E5zNRiEqKnQOsqrxv4Fc9ECIh6Kt13RgO4x6QsPh5rOF5uTnWVRfbBs
	dgyKYc+HlsJB/TYjOXklhzoa3IyoPWs+E/ao8U9bU14qhsPMj5kG3hcun2cRz5GgSKHvuVJdvvz
	5bfouF2XluyK8knd4NzZA3+tDep1BEU8PglbDavPzeH17GjwKvW04mdqqWGI8DeoeXlc6B3jc4I
	yiRdg8WeTK99i5MX1nOnWltToSYMVEiGpFryJz8OU9U+abGNkzsoJcikppsuQ5dLt4cM0wXZ8MY
	vRggQVonI5/xylnVJfErmLy7AI8HdlsC8ArvLaKz/akosnqgz+5H+0u69qZGlNOX4NmiXgpBNTC
	HCo5MqoNnCpCDOa69h4KwxAuZE42reffCDLrOCZWvdAV6DuhlUUEVdtaLuc1TcfOFvoDpzrLfFU
	cQcHjGGDJSho0UZ+r3keIG/QEGD9ozKDJ1zEFZEjsVqcLBzGRfXtyrk94mo2j6QF2OSahtFbo7r
	w1hISFh+e5ym0R0p0XYYOD7PEn0+xMQKqVfdWxQPY67n6cwu9kgMEKsvVIYsorFXqI4BGng8PgF
	jLkeDX+21DfyFkH558H4dNH2imosfIKM5OCeqE3PwEUAL3XZ7EwMPsEvPYDfLb/qDLOnlMOCqA=
	=
X-Received: by 2002:a05:6871:a31c:b0:4ad:5a7a:f7e5 with SMTP id 586e51a60fabf-4ad5a7cb935mr1349073fac.18.1793817938883;
        Wed, 04 Nov 2026 10:45:38 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 14/16] io_uring: defer foreign io-wq enqueues to task_work
Date: Wed,  4 Nov 2026 11:44:45 -0700
Message-ID: <20261104184447.516768-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

From: Kyle Zeng <kylebot@openai.com>

Commit 3de16279b43dc285ed2222aba06cebdc82fdb28b upstream.

An IOPOLL ring without DEFER_TASKRUN can be reaped by a task other than
the one that submitted the I/O. If a polled request is marked
REQ_F_REISSUE, io_free_batch_list() calls io_queue_iowq() with the
original tctx. Ordinary task exit can tear down tctx->io_wq after
draining only the tracked requests. The live request pins the task, but
not its io-wq, so the foreign task can race io_wq_put_and_exit() and
enqueue through a freed or NULL queue.

Forward foreign userspace enqueues to the owning task before accessing
tctx->io_wq. Use a dedicated task_work callback so reissues still go
straight to io-wq, and fail them if task_work is running in cancellation
mode. Preserve the existing PF_KTHREAD cancellation path. This also
covers the other callers of io_queue_iowq() without changing the
worker-owned enqueue path.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c8aa6ca4a7cc..41a03979cb8b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -423,6 +423,17 @@ static __always_inline bool io_assign_file(struct io_kiocb *req,
 	return !!req->file;
 }
 
+static void io_req_queue_iowq_tw(struct io_tw_req tw_req, io_tw_token_t tw)
+{
+	struct io_kiocb *req = tw_req.req;
+
+	io_tw_lock(req->ctx, tw);
+	if (unlikely(tw.cancel))
+		io_req_defer_failed(req, -ECANCELED);
+	else
+		io_queue_iowq(req);
+}
+
 void io_queue_iowq(struct io_kiocb *req)
 {
 	struct io_uring_task *tctx = req->tctx;
@@ -430,10 +441,17 @@ void io_queue_iowq(struct io_kiocb *req)
 	BUG_ON(!tctx);
 	lockdep_assert_held(&req->ctx->uring_lock);
 
-	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
-		io_req_task_queue_fail(req, -ECANCELED);
+	if (current->flags & PF_KTHREAD)
+		goto cancel;
+
+	/* Only the submitter can safely access its io-wq during task exit. */
+	if (unlikely(current != tctx->task)) {
+		req->io_task_work.func = io_req_queue_iowq_tw;
+		io_req_task_work_add(req);
 		return;
 	}
+	if (!tctx->io_wq)
+		goto cancel;
 
 	/*
 	 * The file is looked up as late as possible, as it may be the result
@@ -462,6 +480,9 @@ void io_queue_iowq(struct io_kiocb *req)
 
 	trace_io_uring_queue_async_work(req, io_wq_is_hashed(&req->work));
 	io_wq_enqueue(tctx->io_wq, &req->work);
+	return;
+cancel:
+	io_req_task_queue_fail(req, -ECANCELED);
 }
 
 unsigned io_linked_nr(struct io_kiocb *req)
-- 
2.56.0

