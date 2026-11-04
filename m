Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817844;
	b=GMxw+ijhyifYOm/vJ+lxrY6m91+cMg8PTq6xiaYB3JkqIFdp9UJk96wFnM3e3L+V6Mit
	 vGWT9n9fgUiCgVrMoE4YDD15Mju5yLElYca7Tc6aLo9MRXmFEeRFLTTmkU4jMJHP8Rdtp
	 aGL1ZYPKtQed9IToIC4pGBFgz6daVRF6LBiM/GW0u0OBimAAhmEeHA+0wmsV/LXFBZU4G
	 kFXLdrOLD4e7ioEZYgzUliBRYbygxmdGfu7D7gCGsw+3eCRPAhZpaYVELx7wartwk9Wyb
	 8awWYBoEQBhMz2YZbnmZPzJdV5XhEZBcb2+L1Xg2ttLSd3ucuSFCrr8cOIkftwxX5Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZMHlu8wqV9fNWojUekaR9rUN0xjKm5NODTlbla7QRsU=;
	b=LAN54xlKrYK62njP8sjppkzqRRfbHqSs3yAjXDmKEVdR1QnDeic4/zaZJaC/7oDiSU6v
	 ggFsu5Ap47l1SZgKjMSdJJQY0gxVxhS/Fd0B88YFd3lmmLRyyLY8nwVISNDZYFsMb4P2m
	 MFdCAosvpkIjTWHBO3OzgjffStcGSZ2zGrGkavCAcG2COHaTEHkw+3jgox2U/dFlmDWDO
	 Vi7djvI5clHUihWYB3MDZT4rjZc5vV4+eztT1sYuaax/T+E6Rx8wNlXhfLIkWmFcHzSYG
	 K8KunaaSFwoQbYpMbfTxHiZW1YjRp8IYnhsdLBagPHd9PGWTJ1hE5a9kClXSzxAHcgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eT7dBtt2;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A32606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A32606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eT7dBtt2
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4af173320f9so762790b6e.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817843; x=1794422643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZMHlu8wqV9fNWojUekaR9rUN0xjKm5NODTlbla7QRsU=;
        b=eT7dBtt20AJbthfWoR1Xls2ED51G/dqwLBcahyyvIIRefFVKshWKLGY+ndQvrS0l0W
         bLTbXvR/1wj5M76Oo2aDKi19ynrVcBE4nzXM5dV0RUTrofwiRBSkUKafxdOVwtihSRIo
         HQAoLNEYisidYygPx3/VCJeYqsxKuCBfx8l7us9zIAsfyZfPkqKbakRaqLrXUhmIyExR
         /HBqkBu1encjmZ4zKRr2Wmdu6R9kYtgpDCfg+nh16bbou11AD+/gbDGJjxZpZXDXrAtA
         LQJWmYkqThYhkYOO9TyInrSVnWuf35El7fHNS34kd2K1cjI2gb4gkAEYRZALLNUBZvz4
         Oqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817843; x=1794422643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZMHlu8wqV9fNWojUekaR9rUN0xjKm5NODTlbla7QRsU=;
        b=0xxamGugAHrvVOhfC8tzw/f86wRBC4izFjT0yYHo6KlCIXaq3I6znmo9vGDmkGUKWR
         xVAtFuQiKI0m6Ou1eBdwpUnJ97vxXdf8RW5euqBqwq8PPNNJv9w/g5Cns+2LRF19AL08
         9FaR6OtRZqGg2Bzrn4dj0XicMIMF0cFye0vOidKAaPQIRAc7Tx8Y7wdEut8uk7SGeU1t
         4waAtefB2gzn2UtuUDXj+7VgK7zzh0zvtIFbEXlopEHhl5dET+bNxaveP93lijZJQ1bi
         voKnWkpPS/bHnI4/RK4PYPyNhlug52XBdt4LUTO7I9nfRhiTIk6ozSJDvhDWUBB5Rip2
         +AGQ==
X-Gm-Message-State: APuU4Z89PCHtSNaHAyrIVehfvqieqCVhCHgUKSYE+L/5nHxSLMfq+9gP
	1f3cqlBQbvxS89fBPkPt/0shT9AFEv0huKDRnbFIiLutHi/8txQSO7PbziTdTUV7sjKDZf5Lfe+
	o0l+AXSo=
X-Gm-Gg: AYBFou2jiyGttlGH4cQB/vjHouJI7l4gjPPfuyZEg3CfMcPMnDhuDDWrPwnJy0Lkeuy
	/jv7iSb8BKaSbDTXMQp94arDdlKrs+DKM/ucGg9pO9rBFv/9y+dSmxre/zlZgoQdVUB9E/7rArK
	KbuJSfg5pPH3SvfVkEK8uqXf/dd+idvYSl2BhFhX3BGcyv0ZIpuGcjZINec2B5XbsRsl3OdkgKg
	HJrQ/MOpTTBX8IT6DkSS90l7kYZzrKLoD/SmoNfWX58ukI9CsQ+bSgyF18WLhsifmx3lPSPdx9U
	dRdcFpqknThoQfHHdy5XCDkDR05Sh3gKE5l/cVRRsHnzUuzaIuT/xuv2LymhCnCPlXFYIoNzsyC
	cdGSx5M+TdwVFoujObd4Hr1S0P+CiLFL8I0l+bOmTiqLrevxXqPghU2gxfGMz56qdeRuq01rzz7
	YcEPqtI+ZzPES3cTq4MAvP7uxmyH5VN9w/+mjkqsZLXDhiASZuPCHHwzzZ8BwTRg1jeTrdmt6ai
	1f+pxGj4dgTq3ZytyCbAIBguIKcjprOZ5xkT4mLnPiyWNEUiIK3hb33IJsumhpeEE9PPwc7Uq/N
	Ax5aqwXBx0n5ZpkJ3+ie8bwCpekA8iIsqIYRulzTO4FUS607tE/Gs2EPEpZSB5v//DOhrN7NqQ=
	=
X-Received: by 2002:a05:6808:2388:b0:533:87ee:d131 with SMTP id 5614622812f47-5640de0493dmr12255559b6e.25.1793817843071;
        Wed, 04 Nov 2026 10:44:03 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.44.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:00 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 4/9] io_uring/io-wq: no new workers once the exit has begun
Date: Wed,  4 Nov 2026 11:43:48 -0700
Message-ID: <20261104184353.516403-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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
index e48239486dfe..181eecdb32c0 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1320,6 +1320,12 @@ void io_wq_exit_start(struct io_wq *wq)
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

