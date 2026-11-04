Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817862;
	b=cGt9nRyhUcEADqQjSmTaKqyEG4GosTsQA2vpV3iZhAQ/4TZyWHnLpJvTYs4kDJCmvzGf
	 T4HKS83yGsdvAUfTIslsj5kjH+gWVZ7gSBZ9KWuxkSYaMWypp14QQ6TRSzgcxvilFui3H
	 0vdg4VPdyf27fBemtYBzwkKYxZl1/h+zE9fbwiYCxs1gVx2ORyJzoP8q1fExdXWFqyyx8
	 66eiF+3P3fhfKJ0j3TiJqZ/779wbsHBC+wwuD2xHH3iLmrVOtb8Agu9+8ZgqJ/XTFkpzJ
	 jjnedUl965NWc3xUtaPLhN9/FfUteV+GJZHkClLDyjEfgTsHS9DoWh7T8nzAOMHFZpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qsTWKZW4aSJH657qRlnryDC5MGLkIqGmC5+Q8I1yFrY=;
	b=PZmrau2jlUNhFwkGE9wqkP1C2XwrVXwiY5xw9hdmpbtCqzVUJnK9I+muzuqm4EPCf55n
	 +rPfXbW8JvwWFbGs6fO2Fx0Fw/XIzE2w+N2ETJjCEmpnGZX7iorm9rqb1OcR5V9GhZ5ak
	 xYR+9LzuwBb/PFliZwmlPV7gf5acQRvgUL5DLZWQT6JeOiNad4Z+uWSAyK/MTGzc+13To
	 IV+CX5K20C2WugE+YjG3WupSvwzV3tJbPJ89R/cG2uAnAb+Wwc5D2NbWI7YZ6uEmzEx/o
	 +NGousdQQWR7hBkQP389tKan+U0AgPLjptNk1zdhzUxOyYKRG5ew9qTk/tesqsqCnOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AbZPgQZv;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9D606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7D9D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AbZPgQZv
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8446af403b5so651372a34.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817861; x=1794422661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qsTWKZW4aSJH657qRlnryDC5MGLkIqGmC5+Q8I1yFrY=;
        b=AbZPgQZvZBruMUhPjZVjGsJ5U+qFbdJirKKaMmyZ5GsLURrDI6eh3c9m7L/0KIsIgp
         sGLQ8MO9YhvNxGEuJdNmvPXBXI3XPhRhINXo7J5uFKZZNR+DAsP32IhLUM6qHFmEzW0B
         7twVIJzvculwh3lgKwYgh8IpbC36aqiMjHGBOnxu6Tpo+1sZmurZoCq1WQjEsL+jKKCm
         SmuDkrYSmlKiSRKEVLgVIRSm1kqwPraNs2NxZG9kSOjpd/56AH7y9oGOm+kRvoTBnlmu
         iDNt1ZE9I0PJEhonZKMiA+4W5h931DTVcqfrvsc2wwLX0U0raqDqKL+5jKwnMZeeH3g5
         aCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817861; x=1794422661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qsTWKZW4aSJH657qRlnryDC5MGLkIqGmC5+Q8I1yFrY=;
        b=GZDyqQoXmuhxzY2BU4uNPUJsIxyLDWRU/RBR/PrT0QmKPeHjul28wysKrbo7lhUNhH
         dgN6/i3c9FrMnFKqrchFQ5nqkBiMw69mZyGotvkX43mV/e6YJ0OXELl+MzPS5Dk4LlL3
         dr973PRTMs7fE9wPScwJwe2gHRQUJqA0ik3NtC9D9o+XGdpRYB3V3aP1zutGYlUOqyZt
         +jEGxX+R8iW2cTvFMbNaTFqPL4aZ/NIpkwaXY2tu49urNLjd0rLxkfOdgIuKX03Cg3Ak
         WtinLZbjzimh7OPS68yTi2IunQL9Fm3kS1gFy6QIFKJB+fCQfM9CH43I3Hr+BkUx0It9
         i+LA==
X-Gm-Message-State: APuU4Z/5VPOZEfR1VUHOnWA0i/5LiqI1mt9xsOquQpYUMegiGStd9EFg
	gKqdfsTkBCvOe7TyEfiScRncoX6VGleLTLs/Y1A7OrQbJFsPWFD+zpnC2zbZZ7bC1VLn2rgC6No
	xtvqxt1Y=
X-Gm-Gg: AYBFou0e4bTq01nge+xu2COkOTuk0H3+IY577ugPfoFf+R9dTCwonmtAyN4Fuq4TB4v
	z3wxrv5VOc7JZNI3/JkR3ph/vyEc6468MdME7g5Oz42DdAUoDi3Iu4NhlmkdL4tLsSXDoDNSXbB
	bn+l2C2KTnzkvAjhG0LVyF+SJhq9hbwU4Hdekb9eQKBKb1g3X1n0SV3u0FM9k8KmDfa2OUzCUyP
	A0ugpXKxUEMK1ERNCpQ5vT3L+ITNWlaEUCkoWpF4K5ikfzI+DbUZbSwAFbof3Ow1dN3pVs6+K4I
	wgHfNOv4WC+QLQzg+SJGPd43K/poDaAXpWjHTHBQ7wNnFp8LhtDgEObDlX3JVOURmZsLV78UmW7
	YZKGlxzTHqwWfyemdqt//ECTMf8s3deqQFN2ypTlo8BWfBon8rRi+CBIjXOUlQhQe8HlMh0+7J4
	rEeke9qAtUcgV/xs+bReKZuOgvX+oJszbvV2BnU1IyOwyYKGRFV9U5a6BVvciHxs4cOklLBTSWP
	fKvdnGq60frYbsJKPzh8Ops2OleIvUl8QrtOJCt4WRyu6TvXyMBqxsQwQ6e/9W0lJZiinWwYISp
	SzOiOXqC5lg9aeBaahzjlyAf4hyWe+YgRzrxOGp99kIFoz3YF88ydOtNC78gPbA0zEP4YTKtcNP
	4Njf/qMFZtfu/FlYLmdE=
X-Received: by 2002:a05:6830:2317:b0:81c:a8c5:633c with SMTP id 46e09a7af769-85d3653a260mr11673895a34.17.1793817860735;
        Wed, 04 Nov 2026 10:44:20 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 04/11] io_uring/io-wq: no new workers once the exit has begun
Date: Wed,  4 Nov 2026 11:44:05 -0700
Message-ID: <20261104184412.516558-5-axboe@kernel.dk>
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
index 7d89aa79d06e..fd53297af26e 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1412,6 +1412,12 @@ void io_wq_exit_start(struct io_wq *wq)
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

