Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068225;
	b=FaB8CNfS0qrdmw+AUBG+VQx+51F6T+DWiSKL292FC9ysiPoPhDLTgHe1Ew9Q6b4Fn+KL
	 0JGZWTh3PpYMz6XyYHwjETcaS9HIO3NKm95gGSv/1RnVhNMQvDm/c/U6Os77ZR1mxRHDD
	 9WrX1iaX3h1TdRrm8V98mX36U62rKRkRfLxYWMJTGjeC8BsJBy/7g9Lea2KIbqDj/eeSW
	 Y4pO74jDAc3MBjGGEaX3GONiWZM0591xUiSfhfjIWPZONLZLxiNeUHNjI4h5yhxUWzwYd
	 d5Fz/lLYU3zP3RjkRNQMkhbsm8OLvULbTMjsjXthl1q6LuvK4M5UGUdYrZMvv8H0uEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2bO5ZMNgrvLUWeDEOFXXGSqcCoAqAJXS6prW5NesO8Q=;
	b=FEHJ6TbMTOo++paoBavWCIL7qnuWUsFyipHssfgCVMxZAI4D70U0M1EzMheZen4BpzTx
	 FFgVsfWl8tgYQ/WflNp67ArPDMLqdGGjj6FFZgpHo/xJ4w7HrpbElwHoTDXuLG1D0mmp7
	 VMrKmcQKDi7aE3pC+Xjx8P+xwiX+C7ftGkCAcF6X17lc5mS1kQg7VBSrU87YeWE1zcCXy
	 bxbeuV5w3ZV0HTyCi6DGk2/OU5eP3LMnhlH6cmMAXtrPveYcF9ikzofHF3wUFoxceDVs7
	 094nJKxtmsfSrzokHVcslSzFDg/wBoynHaUzxRuI4yH7KZeuXD0a2Qis+yrxzUMSpNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lOl3dOEx;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92034606D3DB
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92034606D3DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lOl3dOEx
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso770188a91.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068224; x=1794673024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2bO5ZMNgrvLUWeDEOFXXGSqcCoAqAJXS6prW5NesO8Q=;
        b=lOl3dOExIAdLrEwYz7bpYuc5PjykrSLConsOWwEIz6Q7bYqHQdqa1cQKZ0+VDMSyE7
         HgfeB5ZsxSyWghxIt6/olD7MlRAPnRxelll5GtiMEnV7QhIbMXUNPpsHoo35eHbC9OwA
         qsqfB1fAuC3uXG4M23tKjaizL9GmIXgxCW09eUM03R1/zbbSM04HZjDJ7jjzNTBsyNzm
         0kItNhBJfOJsf/jIL7U5r39BL5ZzznqMDNu9CEdBthfe0lLzVRY27PkYO+xJpWUbQrVt
         eDq+hj8WxGjc66ctzKBpPZXgqMhvwmKNWWrdUAZUQMcLlHtSdfabCB1S8UobPQflhWCd
         AEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068224; x=1794673024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2bO5ZMNgrvLUWeDEOFXXGSqcCoAqAJXS6prW5NesO8Q=;
        b=ECpf8Hpaugz826fr63xL+Nv0TIoculjwP5D/9kSV/ikUqSFEXYCp1uFBWiMOTI0Mxt
         ngNySqXXsDp9hbeP93iTrpDmPTJ7RhqLxaRQNC1DvAnW0lzpenRHshAxAfvTwLWUcu9L
         W2MibfP0KOi8QPSZLPz9hL5nX7jyaT0YWs0nAC5ZlUJAu2mDypGCb2PFHRIhPrBK54J5
         OVwTt29V6BRt6hLE2hW6JYmLUEe2bgTRUXoAeRx5th8m6kWI241aIaNVE2p5C/B16dwi
         uJRRBy2weioKAPsr4XE5WPonPQqt/2YXWtHO99M9N5tckabnyxA+AefZdgqI8LT//GbB
         /2jA==
X-Gm-Message-State: APuU4Z/4ukIO4x/bFao1QSGqie0OJ+jg19znvyzHGJncO+yb5UxM3IaW
	uqyKLtqnS5MCZO6GQ7aXKywsgSO8aR7y+HXh4vMlIraVBV+Fj3E+wjEqgCk09VHj16kt+Bg2CeC
	C2kFvaig=
X-Gm-Gg: AYBFou1cs+xKBumQsyhn9lSp/vFQFxcxOBbtWliie5enQKD4jdja2MMURVxiC3B9f2J
	yyJkIgIoleOQbrBSyeidpxiwrxZSjWLlgCde7yAz1zAr/BdJacNmbBmsDPynATX5Hp1Cg/Hvy+V
	6DWdYTA8kJDwJ0eLKvFQOf9d3cdJBeBupXwPHp9+GvfmPvfSuynw8vjKsswOogfGXZC+GTmfzZ0
	QAd/2KGRdKJtVJMo1WLFY7FHvwH9Q8mhtkArpJ3g9QVKQgpHC20cfLXzZBUhTY9pta47up4wOpH
	2cdAHxR9aoNaGUrW8dZWO2+8NDlVGBrD5hWI5wWm3TzF9N0hLHn1WD/bhum0sV5njLq0xq9Kp8w
	xLlCpVa4oIKPhddLYVXjPdm70HLuG+98kI8KCYs8+uWu/4dW7Zq3r5I74w6u3mJCEA4bm/s4QxU
	ospcX+q1NMxojH4v6C/3RjS5tsT81jRTnXsF3lM9aZqmw1yyBwBbr/CaCWopRGhXnVOI/I9JuUG
	bkMrh5BnoINNfXJE3wrD3HfoeODpTrGV0BRiDKs4ZCrZJRdJuJqTeYYAU2CnYDX58wxxtsPLuci
	VgSeiNX3UnU1keW/4FERF87mV+H49HlfEvPMP1xeMr6SGFuCVy1c+nP4maLZR8Au+V7YPCVWQAT
	LfDUCJg28qxuCSgKjonNv
X-Received: by 2002:a17:90b:390d:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3b0db6e4762mr5183000a91.24.1794068223769;
        Sat, 07 Nov 2026 08:17:03 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 3/9] io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit
Date: Sat,  7 Nov 2026 09:16:50 -0700
Message-ID: <20261107161656.2500790-4-axboe@kernel.dk>
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

From: Shuai Liu <847807867@qq.com>

Commit fca3ff9e2eee7d285585daf51942e0b5e2be354a upstream.

io_sq_thread_stop() carries a WARN_ON_ONCE() asserting that
IO_SQ_THREAD_SHOULD_STOP isn't set yet, i.e. that stopping the SQPOLL
thread is never attempted twice. Since commit 22d9db9fd64a
("io_uring/sqpoll: don't attach to a thread that is canceling"), the
SQPOLL thread itself sets that bit on its way out, so that
io_sq_offload_create() won't attach a new ring to a thread that is
canceling.

When the thread exits on a fatal signal, the bit is thus set before the
ring teardown gets to io_sq_thread_stop(), which now triggers the
warning on every such exit:

  WARNING: io_uring/sqpoll.c:88 at io_sq_thread_stop
  Workqueue: iou_exit io_ring_exit_work
  Call Trace:
   io_put_sq_data
   io_sq_thread_finish
   io_ring_ctx_free
   io_ring_exit_work

Introduce a separate IO_SQ_THREAD_EXITING bit for the thread marking
itself as on its way out, and check it in io_sq_offload_create() along
with IO_SQ_THREAD_SHOULD_STOP. IO_SQ_THREAD_SHOULD_STOP regains its
original meaning, "a stop has been requested", and the WARN_ON_ONCE()
holds again.

Reproduced with an SQPOLL ring and an immediate fatal signal: the
warning fires on v7.3.0+ (22d9db9fd64a present) and is gone with this
change.

Reported-by: syzbot+675af112519ca34f5502@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=675af112519ca34f5502
Fixes: 22d9db9fd64a ("io_uring/sqpoll: don't attach to a thread that is canceling")
Signed-off-by: Shuai Liu <847807867@qq.com>
Link: https://patch.msgid.link/tencent_BB08960D79E0261B5C1EB1E589787734E907@qq.com
[axboe: trim excessive comment]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index c833e776320d..e86658ede44b 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -29,6 +29,7 @@
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
 	IO_SQ_THREAD_SHOULD_PARK,
+	IO_SQ_THREAD_EXITING,
 };
 
 void io_sq_thread_unpark(struct io_sq_data *sqd)
@@ -436,9 +437,10 @@ static int io_sq_thread(void *data)
 	/*
 	 * Cancelation drops sqd->lock while it waits, and a ring could attach
 	 * to a thread that is on its way out. A fatal signal doesn't set the
-	 * bit, so set it here for io_sq_offload_create() to see.
+	 * stop bit, so mark the thread as exiting here for
+	 * io_sq_offload_create() to see.
 	 */
-	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
+	set_bit(IO_SQ_THREAD_EXITING, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	rcu_assign_pointer(sqd->thread, NULL);
 	put_task_struct(current);
@@ -510,7 +512,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		/* don't attach to a dying SQPOLL thread, would be racy */
 		ret = 0;
 		if (attached && (!sqd->thread ||
-		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state)))
+		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state) ||
+		    test_bit(IO_SQ_THREAD_EXITING, &sqd->state)))
 			ret = -ENXIO;
 		io_sq_thread_unpark(sqd);
 
-- 
2.56.0

