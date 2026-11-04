Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817915;
	b=SdPXaxyUp2Jf77RgopsNC6ruc6UAxIdCdILail0LOGA0mStTOOvsuQOT0zbpVnWxFeim
	 8V9KqU8wqPIQCBXHI8LtrUEaQ1ZLjhUOlUrJKsTDa8miat6Lfd7XAOxv5pECAJANcpH/d
	 o0uC4lRDdAMEhQofHHbJuJ/CAzgJ53MxRBfgEdRDQOxL9Y5gSzyIM4Jt42WwO4di3nE6C
	 s6iJRZHMCrLJWq229XYhdFXLFrTAl9Rsrd66kVlpS3JtB1at1vMYLHMAKyf48q3966Y28
	 EW5KYx5oGEZjiYSeI3ezuuV+vwG1ZuWKCaVtqTombhi3U+bgoGt7s83lppJvKxnEFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9CB+uPj6XGfVY2ImJfWHGnXjPQvdTprxe8YxT6UoYSQ=;
	b=euu3vHMLiBAOppqgBTIVRf1/lcapm5Ml846T9FwpKJbP8BaQ6zSsk2D3fMvwXljCsJmm
	 ATuwwWjacGJV5wWR3sD9PXS7KSEJtw4MdSqREyOV9jgivAbbB/fKkpHtGGdYNHspFAVlA
	 zoW255p6PXU/HgkV69w7Y8zke1cWMhEfWRFdG1YnLyMo4S4E2BzNuYCsp+fA9xy4oDTry
	 AWud1TI+HrwbLeSg7JQ4LsMdoe/0ONbAnTS/rktSimxirnfGDiAML8faz0PMAbRbe1wil
	 bCRjJyyw76BZBvw5pRt6amnA6xeVtLGMiJLne2tTyF3bHsdjCKjKN/qv0kXdFv4Y7oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vce+YXlN;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B566606A332
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B566606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vce+YXlN
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-716d052dc23so160362eaf.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817914; x=1794422714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9CB+uPj6XGfVY2ImJfWHGnXjPQvdTprxe8YxT6UoYSQ=;
        b=Vce+YXlNaZBjRwreHO2+BSyg4VzpRivdh24FI3+ou1HIjU+Y6ulS+z7Im5VJNv20Tx
         Z1ComTtmJRlWmx5svV1dmmcan0LK1wjFyrdeJuxMj+VIWWzaUePPlUBW9t0uK7VB+byI
         Pe6PrROGGf4oyOZ1XUBJA4LyF+tCtCx9aN5qBPWnzd5ZFK6vSJr9m2a1IkHOJAbLoZGm
         RRZgB9yTgul3JqI/r2fhvLRybGm6yaaR6ba3UQrbpiJlxt99lXPoVYAsJcG5FvsH2QTt
         U3NRX27MS/gF6eQWs/jUedyjWcSURWdaU322qY3Io0PoGod91GYhj+JA1NxWDx2JGkUQ
         oNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817914; x=1794422714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9CB+uPj6XGfVY2ImJfWHGnXjPQvdTprxe8YxT6UoYSQ=;
        b=u2FvgU/sp/kdvTtGHC0MgT5jy6dKoP/o1Eu9bQNmBVuGR7Cm238EGPVv+8USCrDwQF
         Dq8z1/9jsXvnDc9lnOixqD9FnOal8a0KUZP+0V8N4fdJdSRZw3up6xp5SpHJZAAVrfyA
         bxu7t2+DlY4+QT/hS1GNXv0IAluU0UX4wQMfhiTpbCtTxnWMunVXpISxwOaJdwYTE8cI
         jb9ejtN88/WQ+J9GePwVwSVRJnN9t6j+BZi+6QRIS2CQeFDYcaTv2SDuVUl75yklmLfL
         ewusGc523XhHb6qiyLjujwgyOegkh8FEG8kn525ymnjUTClPI2vtjIA7AhgFoLI+LQBa
         MzjA==
X-Gm-Message-State: APuU4Z+QghnEB8B9HSxBWv5fSx1pSYseFQ88P2VcArfK3kuVjI70InJm
	n0H6pOOCAvK/+2Fvktp4MGoXjUao9JXIIVzGRmtCJored99BiRAgchq09P0nfouO57dMjzLuPBz
	q2CLG28Y=
X-Gm-Gg: AYBFou252i0tuZ4Cayb9pRdVijP82OejUrn6fWdypkz/njrbzdgoLO9MX5BSS00BOn7
	Rj/fI9F36vl6+QP7Tjm9GuNMqD49MkHtQuHm10Brp3a/PPoGG3+HTl5kT46C2RSy0WqkcNOknov
	4xCnI3+rXFvqShPTtcH7ZXR5CmNDWn7nCqrH3mhqognyvc7I/6ECEfiZO2vq+8DVgKxpq//cFwL
	7pMAuIKZPzXF1X/15SRT8d1CVNjV8H6/pS+MsOJuk1S1AbFmdO1g2iyvMPfnk6UuDyq1hz4siEY
	4uWbF/LEQQPr/1nrMY3+8Z+RiCdENgrE0lIrkRgRM1Y0vxYodKT6+0NkCt1AmI2vDSmLpSfIdlS
	QqZiPRNZuKXJEyhVSp07gRw2EVA8kfgHobecqFlOWrjpvI6YGax8mgD7B0kNprK9quwqKqUv9We
	9ytvkNQfPatSkolE5gpgU2gIWbtvYseNX6gaGImFEb5t5+Tth1jHfLP4H1llS+5Cnlsm8BkNTUm
	l64PyjuXa2YEsbnzoiUabhHnGsvH2zayY9GzIGjGoEh2TpKVjkc7AmU5RKZTgEH35sMi2HmKMsU
	CCvUM1I/UeO/NvKKr+MsJ9TNnwEWYip68rLafZnTkSfx01quz8cBwc5ITNBZw3QoVhuHAzgF2g=
	=
X-Received: by 2002:a05:6820:351a:10b0:70b:af3d:2b2b with SMTP id 006d021491bc7-714f29ec710mr6899564eaf.67.1793817914203;
        Wed, 04 Nov 2026 10:45:14 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 07/16] io_uring/io-wq: no new workers once the exit has begun
Date: Wed,  4 Nov 2026 11:44:38 -0700
Message-ID: <20261104184447.516768-8-axboe@kernel.dk>
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
index c48f2475d03c..6b9395060262 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1416,6 +1416,12 @@ void io_wq_exit_start(struct io_wq *wq)
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

