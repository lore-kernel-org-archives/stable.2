Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817869;
	b=ZjjRKoZt3qafWW+kZMxjCRIQ1/14nJLXhBvbBs5ijTqOFsoUMnXmQs0WJLAsQUvLqDeF
	 aka/ukGsqzam2nOX3sjsQe6oVLcpX/K0tYVul9wSyefhXu5bPk98QW08YtuxjhzfoyVbs
	 +aFZjvrjtx0eIBYkU6O7RIAscepZcpClv7BScTX08l6fdg8hD+/VboypjlNC+8vyo3zo/
	 gAI8nSGDwXezMTxWfdssImuJvzVZQQtA2iFSkbTLVSKraDSwwy1BY+ZmIeYo8QNFko4Jh
	 NGrBm3G/ZShhd5NtQnNKvHKZIBM0UAJUakKkl2FFI5X1Sp3s4zTPh4MQ/wg/XCbk+Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h1ZFCRTrARisxTaOwsBhxNjYXnsFEWmbjR/+DhYCYd4=;
	b=lSAGXTJqu1YPx01iLxVizFf6AQ1FFcWwIPBhehAJWmJcDLsOUNwT/7hIUjz+ZS1uM4d5
	 xZJCD8JGKl+z1pcYbtHSINiQtnHkjEL3AU026fs6xC3jzmKQ8ZsZsTiUJLESIJ0MYQFE+
	 X6tbtVVA5gRslEyoXl/qnJUYfJDnanDfuDnkMIj+GjnkTPcCgTAf1Gj0rxcFXR0aa5zAU
	 tP3oNcfIyFPftTRDlcOs6jwJ8v+m1qUEsVV9zBc2LXrV8kWVWJRFhzhBRWkkq4yMoR82B
	 WUIr1jlMeMyMpB+aBON5Q9RLuzRURutUQGw8cQ2FMAmzhZCWf33+5PD8b8lyk4/J3Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EYS0ph3t;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C6606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D6C6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EYS0ph3t
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-845788309b4so416508a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817868; x=1794422668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h1ZFCRTrARisxTaOwsBhxNjYXnsFEWmbjR/+DhYCYd4=;
        b=EYS0ph3tKBi8pFcLV6iaNMD5DFJYv5AS7k3/yo117TnPdRsu3M7HH6pj0VvTK0THSG
         SeTcnriaBx9Z+lgQqFtRCpBd3Nb88CkFb4EFjXjUzp07ZkTE27r+jDICVOhC91wOGM1i
         +HIR1jp5fAmibUOD5HH1gz6RETJkJ0DVqlqH9UjeihYu2q/4IPLOCnXbelf0Im3ORK+M
         V7agPH++iciICYf+gBZCHOIp86zi55xwapHDXFF9HCmLTUOyiuPf/4H1duzox2CFN3bq
         +upcnKcv3NEU4BZSvOYesNdszUwf6UFU41B3cTLohPknovnL1mygyCOWctpAMPco9kHD
         stnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817868; x=1794422668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h1ZFCRTrARisxTaOwsBhxNjYXnsFEWmbjR/+DhYCYd4=;
        b=MMR7aWnkya9mjBbkhpxzz00ChS/Np62pnp7XV6P/Qi9fILk1BawpeUK6zRb7OMKU9q
         aYdVpcQUHgybH4LmrIZTPsQwy0xAmRw2AP4c+ay63ZbvEIRMuDUPKSA+AQHMU/fHSiWf
         ETIHxH5hE7amfPH36sllSBddfl81W/69gI2b4qBhZYlF4O++gv4b8n7WLeeZEi/AIik4
         7mtFD2/tuaqT3AfzmuhoZK1aVMpCPLojja4KM22ZVKm8FLUIpXJT1OxV5fF6x0iB1HMa
         9GRc5vgpdujfeLY2zSvjzrYet7H5c3jb+bY53whBOrBshZpLGFlfVBwJOYQn4Lrqw48q
         h+ew==
X-Gm-Message-State: APuU4Z8/EBPLw7qyUaNT6VNk8EOQSMEMIs65Ln+KlU8Zo8upwXXH7MqI
	WTbERha9HhoOyfsMxeygHKpKpJNYTAq7uzAUXY5LC7XA9KfjSySr7VK8759F4SisBZaY02gmtOp
	cUQiToLs=
X-Gm-Gg: AYBFou1Sp6WYoNc/Sp6NTh9QTIQncF1pWDU7zDDK9AZPFM6C2PpHjZTZzZBGIzSSC67
	7GYgYembr5Jybk/beBKVy+vIDZfxgnAM4uJRrk+5hR1QF/SFDVoPH3ymVbyViWci5e9b+gRS8ZH
	wIm2er7B32qHbvUp4LC1QBBnsmXm3lDzMLD0+ogqkzv+Jfv0SajRfDUggXf8cbrK6SAZYSR0M/i
	Af6pix+93yrO9iPRle8RriwTwkdQxPnL6dJtc3/XGTzQs/M5O/wwc1qOHk8W0Bp2Jnfx3x27Nge
	3nag9ty5DufXZfNrN0mRqyqaPMuOqhY1Iuw0CTgim7zNqvvOWzya43Ykxdn75DOckFxGBuijyF6
	0MYNgSCCUWz+mcjeAfqxZyL9p5iHI5dGdfZleOtQV+OR/0Rdg/WXUK27wk0mK270hbRh4AY7n79
	Q616va9vac9NGUogbqN+seHTL5yqWytV2K5RoDcP5veOXqEPtUuyszXWLHcs8YvmNwTsB82n+F6
	O20qDlHdlgzGMmTcQ1Qf2SjzS21FuZ6gjS/sc6YCDUme4Yfx3gdNkXfdZhm5KOccpskqBNtX8k1
	vou8uj/LhV6Ia74OneG1UU3tOK9QSu/SrzHi585lvMp8UgfhG5QYwNRCznzeSfhglHAIdm9Tphs
	=
X-Received: by 2002:a05:6830:680c:b0:81a:9522:f00f with SMTP id 46e09a7af769-85d364e1379mr10823286a34.6.1793817867924;
        Wed, 04 Nov 2026 10:44:27 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 09/11] io_uring: defer foreign io-wq enqueues to task_work
Date: Wed,  4 Nov 2026 11:44:10 -0700
Message-ID: <20261104184412.516558-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
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
[axboe: 6.18 lacks 13b0742fd058, which removed io_req_queue_iowq(). Name
the new task_work callback io_queue_iowq_foreign_tw() so it doesn't
clash with the existing io_req_queue_iowq_tw()]
---
 io_uring/io_uring.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ac097a9ac8c0..4a9f3a0fe506 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -483,6 +483,19 @@ static __always_inline bool io_assign_file(struct io_kiocb *req,
 	return !!req->file;
 }
 
+static void io_queue_iowq(struct io_kiocb *req);
+
+static void io_queue_iowq_foreign_tw(struct io_tw_req tw_req, io_tw_token_t tw)
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
 static void io_queue_iowq(struct io_kiocb *req)
 {
 	struct io_uring_task *tctx = req->tctx;
@@ -490,10 +503,17 @@ static void io_queue_iowq(struct io_kiocb *req)
 	BUG_ON(!tctx);
 	lockdep_assert_held(&req->ctx->uring_lock);
 
-	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
-		io_req_task_queue_fail(req, -ECANCELED);
+	if (current->flags & PF_KTHREAD)
+		goto cancel;
+
+	/* Only the submitter can safely access its io-wq during task exit. */
+	if (unlikely(current != tctx->task)) {
+		req->io_task_work.func = io_queue_iowq_foreign_tw;
+		io_req_task_work_add(req);
 		return;
 	}
+	if (!tctx->io_wq)
+		goto cancel;
 
 	/*
 	 * The file is looked up as late as possible, as it may be the result
@@ -522,6 +542,9 @@ static void io_queue_iowq(struct io_kiocb *req)
 
 	trace_io_uring_queue_async_work(req, io_wq_is_hashed(&req->work));
 	io_wq_enqueue(tctx->io_wq, &req->work);
+	return;
+cancel:
+	io_req_task_queue_fail(req, -ECANCELED);
 }
 
 static void io_req_queue_iowq_tw(struct io_tw_req tw_req, io_tw_token_t tw)
-- 
2.56.0

