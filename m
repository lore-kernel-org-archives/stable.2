Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817829;
	b=OwCgFHCw3NPjFgbNZzMyonkVAzqZeMvR5S40JNCG8+uWaqg8fdnaN8UkwcqijZw2tR+a
	 PP3Zs4GSHCZ5XX0WJp1gcQU1IzQHOFltdeQcB72/ufUA7afvCcPW1zYND7ulimUEo9m67
	 79izXUksqvRiqb0vf12iHbwFTrIvLYBgcf4+kAJRjS+OfkJ5UCM8aYzXPjrOCFnFQ2UTA
	 vmULUjkADo0ZktzKtKiB8tGiL9FfcP+oGQWkxQJZwEkG69AYkR4SIg4XrMNgrRXMUViwD
	 JdpTpADU2u0DF2WYGLcHDlG4jg18Hm6sEQT/c1F4hZRDIVOXdOVeJQXdid12tmFFcxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5rUuT2Ox7AGTeK1wtvtXLQ1ZYyD4xDxrJBv33i6AqKg=;
	b=4Kcb8AOOTlSPYQTkkFZ89mt4wZkniaPZoyV+m7HsT+36aC5yQ9wsU6WNj8PZgCvCNk/A
	 jA85ldCji3AU69Se468y4AWLCjusf+TVkc+N7eavebT/m90cqSze8xtnZ6x1su8E2pq42
	 G07uFZ9Rg8M0cruvv2OP+UrwufBBmIIB9kuwSbZgyDWs0jOvFk6sq9UJpDDLOlb1ZKmbZ
	 QYOFr6CyB6Up6js8Wf2c+TEHskc9Nevp/PhJpMa+6AD5ufHgrLQag8NsLiXHUmzwZPYyi
	 SjXW7f6uF1jrZ+LQ0qmbhJNrbqMbQra7fosH4pUSwzTcPdJKleDwUq+WEhXkg/j6imQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="T/M7W6Yg";
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4E606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C4E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=T/M7W6Yg
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-499f20c7054so622870fac.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817827; x=1794422627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5rUuT2Ox7AGTeK1wtvtXLQ1ZYyD4xDxrJBv33i6AqKg=;
        b=T/M7W6YgabFaMR7kxF/1D7E8UpSxFo9i0Wfaq0fxejEAOhPJuOkLB+wpxy/KQayT8u
         0eW6/zWrPD8V792tAIlnZceBtxI2HPPZKtPFAxo94V+I1TTJZBTDRROjdlGdDdXIh8n6
         dmKLlJx9ehFND1uBr9dR2Hqcas8p1N+mL3hSIkpNIERX9NDMiW1+rIeDRFSe0oN43/0S
         GlEpblNxZ/wV7iKhY0alA4xbhxa8H09gAfUcw4PqOUy7HFCTfe7js20lA7jEut1ejlgG
         rIbr+ScV2yQDDUpx/4e72Y7Cxvh7Qt4b3TKd3UauQxOOrYHMRbP4zx078YAladHC59zI
         j/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817827; x=1794422627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5rUuT2Ox7AGTeK1wtvtXLQ1ZYyD4xDxrJBv33i6AqKg=;
        b=bj2D/RiBpQPDbyHImvTe0HnikP94nlbOfJBwUNCgDp/M5iWS7J+aWZRR1ttjYLFcAd
         PgmsFsEVkZCSALjrWyMdHHPYR2fXijvL0pMQo1N0myIx+UWBXVIRHfquny96BUCMz0KS
         v4+Aw/pcztugp7zibOjScAmyJafHjeZdA3DU4Y4qdNFScQ7HDHYo/M5CzfjRFoIxoM4l
         b2dqkAG5lYrksLtTv/dnwBswC8oLugDU/s3jEY/2JA55OHBRTRittVPGqeOLMo4MyHJi
         +N7QNpsB7Eqx01tbjaZ9zDl+WRWvBYkaJpzrq3FZzV1oRtla2MxQaJ0hL+Fl57V34ciQ
         goWw==
X-Gm-Message-State: APuU4Z/EFHICAa2qMYEZCtZmZknFBwJ5BSmgYDCnOW9ZOzeGEiDiQ5S6
	mHx2Fs3VioUuHnjxQb5Rx3FH693w6tUEhfgiMBgTFP8+J+QVUgfIj75SyHdqb+Dk53pZUphAFMd
	r/8WAieU=
X-Gm-Gg: AYBFou0ZnpedwbJi4wpbz6kX9gI2LW1A8T8HEgoKbUUU2C/k+osv4atFtQoXBGZunYS
	RfqP2W/gch9BlQw/GZfRY/+QE1R7Hqlu59uCRgTuvskS7rnrPMNwoXpy8CBtzBzzILnYyUF4TwL
	n68+XvZxMNKwlsC4krwioen9tcw8DK0Rwac29fMggZknfePqZIT1v28CkH0wPCFXSaAndEO1DSx
	SQsd4KjGO6w4ReFSqvyvnMz/s19zmx9896fktF8/0sjGQFi0MnkQKe1g4pmMUAaEvCXrvS775pL
	tHHQ8mX/7GfM/JTqBBV3SoLR4MRS8oQ13wiN8ejWiQwjHjfErK06DUfIRqtR46tyh+53bBoHlou
	9OvRQjYo6gieOGAk9Lr6oo7bSU3Yz5VrWtitQNrFGCQzi0gBZgRtbe0KBJgj05wRr8pl003lfZg
	Z3ojIXMj98XafBXV3/dGW3etIHH7LKkMZNRuzOlPOp747gVRk+9uuSN2OEhD5fJT1Bsto8SWtAm
	1JdWpLMkAua0rU3/0uLaffDUB4AiyP4ry90Fgyd51tv1W8FkXy3lJ+CMkB2H07qZNp3a/JiuaXV
	aUGbqwC5xSa39vQ09YcqgF4Ox+g3+ogbHLeniRx0n4qPSkJCf/wIBQ4C2LJDAtRHflFMPPi8Pg=
	=
X-Received: by 2002:a05:6870:d40b:b0:4a7:4263:4079 with SMTP id 586e51a60fabf-4a9072d4033mr11873644fac.5.1793817827104;
        Wed, 04 Nov 2026 10:43:47 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 3/8] io_uring/io-wq: no new workers once the exit has begun
Date: Wed,  4 Nov 2026 11:43:36 -0700
Message-ID: <20261104184341.516297-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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
index b3547e30200e..1a5f6ef2dbe1 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1318,6 +1318,12 @@ void io_wq_exit_start(struct io_wq *wq)
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

