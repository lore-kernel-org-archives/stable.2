Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817814;
	b=wegjFdoPr+WkLAj3YPAM5XZF7eteXa9+/KmMWnYWk5pJCAxVD0KmJktlenjuHMuKV8WM
	 RtizEwUUQTm9hhkvfDvd4NaZlMrYVdqtMNbjxdZysm5RVHyE2vE5n9feur7VmkTfHg7eT
	 Fz/VRUMZ7WRDUN1r8dNoOhwClRjDoh/A59lemljiiFgzm430SlJcEm7jjAAaEjM5x315H
	 CTIGxd/N1xsN0+lq9Fdx64R3pFdEs0DTrvD0QgtIgU0lx60i1cZEuy28LmL9YJyW3rYEf
	 pB+jpudwABwF5+i0ZJwqG48JF3SSqc2CioGKZLFdkvtaCIUHWHCa/BLIu1rnUJSmSaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4J6fvrcCPvDuoH5EygD6+3+8jluKj0npvIJH8FwWPog=;
	b=b9WEVvA3U8FH+c0hT0WZXoZDncYUtbZWOLERZlwB7aDzSkUgNEGBSZeO9cNx+KOaXXiX
	 fQEq2RD6lBvdp08Azbk2cRdsRI7DSzQyrW/Gxei9qDajJQvB/DfL9zYeqdtOnLHyb2FLX
	 9hczMbMmh2lmPu/3JXO0KCiIyu72j/CyAN0NDtvetjYujK6amXW884knONYXxgej3I7Ag
	 HhwofjYQiJ9r4n/mj1HaP23P8WgD2vhG+q3WfFpvwDgnhhm4eNRC183DmXffJaBwS8UCb
	 beR7yuJdxjxGKrVRDsDLFKlypnOE/gh5UP5oOjUxqHwP/X2Vw7Nu2V1xFT/51MXDmeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HXrXutP7;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98C606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E98C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HXrXutP7
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-83bbcfba0ffso726416a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817813; x=1794422613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4J6fvrcCPvDuoH5EygD6+3+8jluKj0npvIJH8FwWPog=;
        b=HXrXutP7KfMML9k803P9MIez41OQNmS4OoISNl66BN/TMubXEzN7hTRF2QV0zlofbH
         rJcme2/fx+eWUwDb40EPgl66D61a9i18V4lF0uwRCzYmAzUuqlJovEbohLLvrKitZ+Df
         wSqZrmRNAdsKRYnOQ4POa+nu+Ggx30o2qARjmrUI8EawKwkOMhzr4ksaQsuokLzyf/Kd
         x+u4Y2oK9kMGfmD0hRClXhKz8AAv5B/Byp00blveBUnw1qW0DUvtar9IP7Ze94gipx6Z
         0nM1yySB6H1c7By8a7t0o7Xx2us0QI5NOxoBmPp0qoIvoIfLn78H6jC0jLK9cCkvt9Mt
         Reqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817813; x=1794422613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4J6fvrcCPvDuoH5EygD6+3+8jluKj0npvIJH8FwWPog=;
        b=xqqgYy7RBlKswwZAylqnALXduBHQRh9yzVTwCjonBLuybj2lpbo07QBPD0JY4Oipq0
         dHWy/nOdSBOMC6JUAu+tE850M/vQrHNnpuQgRYPUm1L0YOdD/ZeXzB7zrVcEZ+6nzi6P
         SKeOYIzLB202uzq+DRjZtYmHusv1Y4Zf0IQfjPjGZR/frf6cUIwlwlHT+KMXXDlB4R+F
         LwvsbBPne7FLmXyQkYSpk0PaxnMty4CVBy9ADT3FPglonTMiWGurC4Glon51+O4VFdg0
         b2k6paAs3a50iB8IiUYWWQh5HAHs3QwmTivUUaYnSYyenB+N97C04q2C1hxUThn+4Hc5
         qAUg==
X-Gm-Message-State: APuU4Z9tf3x3wuAr4kFHLsgk5cLdQY3naQ/VchhHOa7FtZP1nvKWUic1
	cUy07EG0nmEhhNqipF9IwyhVTEpB2Y7E//+8ynhcqPgrgJTyXlck/vLQYMotcXzqFlpWS36jl5T
	zWsj9H5s=
X-Gm-Gg: AYBFou3uN3y7Z6AVBumao4cqL3TXqLXvcUsN2T/S5nTSDbtaTZMhPS0llCtSGFytudB
	6G5V6T0T5pSnYvy8Bc3XaYv7M4y6tiSah4xbq2s/2xPFBud6tmgVHF/Rvnf0KXGvi+V5dxUVNIf
	eQULR3a3cnhpdeB6GvHwVfdpveOXLggj05bd55AcmNRr/BCWMqeOoyCz7EUvjXWcbgAZ/gTBtYx
	jb+T49JaxgyNsJxgTwbtSBN6akjuEagAvdpjnQ6/C81uAxCVpdPXEsz+PqZbFGRdw6MWQX4iD0H
	htKA9p0SWW004/Z6nw0awh+PGPFyBmdI+YTwcyceWKqo4QrOUj/wdEKIRui8JAmLisb0Kyr/ddq
	JiAltkj/VPwhMZFkgFOapUYOrfT/o6SCmbOjo91vyVfRQY5ph2r0zmK/M32R/Jwj2mimYj/Y66W
	d9ovifXCr+bjoAYeot5B1mLb2ONtZy1FnhFZEpcPc5xAKw5VqteShUPGZw0Q1MtCzamFOMGFsCH
	M42iCBncvIyGGZM+xv65tYZIHlGbZPtdJKhNGz5B721J+W2MrYGmXBd+r1WkJFxn5rXTJ28o2D4
	S37DORhwYcOXsgPi7Y+K6DsQ3Z+lYe1ZssWII2YXOx9r6UMiWKF636ID4gCPqUsXTCnoLTsZ9w=
	=
X-Received: by 2002:a05:6830:911:b0:80c:6371:21fb with SMTP id 46e09a7af769-85d3653b805mr18744693a34.16.1793817812926;
        Wed, 04 Nov 2026 10:43:32 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 3/8] io_uring/io-wq: no new workers once the exit has begun
Date: Wed,  4 Nov 2026 11:43:23 -0700
Message-ID: <20261104184328.516206-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

Commit 47c68f925062a6013235d06add85a59f7d91e0fb upstream.

io_wq_exit_start() sets IO_WQ_BIT_EXIT, but worker creation task_work
queued before that stays queued until io_wq_exit_workers() cancels it.
In between the task runs its task_work while canceling requests, and a
worker can still get created.

That's a problem for exec. begin_new_exec() calls io_uring_task_cancel()
after de_thread(), when it's supposedly the only thread left, and
io_wq_exit_workers() only waits for ->worker_done, which a worker
completes before do_exit(). So the exiting worker is still in the thread
group, using the mm, files and sighand, while exec replaces them. Easy
to hit with a signal pending when create_io_thread() fails and the retry
gets queued right before execve().

Cancel the queued creation task_work as soon as the exit bit is set.
Pending work that isn't otherwise canceled now ends with -ECANCELED when
the io-wq is destroyed, rather than depending on whether the task
happened to run its task_work first.

Fixes: 685fe7feedb9 ("io-wq: eliminate the need for a manager thread")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[axboe: the barrier is already upstream, see 0e5663856b69, only the
 cancel is new]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io-wq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index a8ef73963dba..0300bc6d17ae 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1335,6 +1335,12 @@ void io_wq_exit_start(struct io_wq *wq)
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
 	/* Pairs with task_work_add() in io_queue_worker_create(). */
 	smp_mb__after_atomic();
+	/*
+	 * No more workers from here on. The caller is going to run its task
+	 * work, and on exec a thread that is created now would still be
+	 * around, exiting, by the time that the caller must be on its own.
+	 */
+	io_wq_cancel_tw_create(wq);
 }
 
 static void io_wq_cancel_tw_create(struct io_wq *wq)
-- 
2.56.0

