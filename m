Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068177;
	b=C6dOBbrXU0oFBZbyyA2YxNpqVjzm6VxdBtYwrn2Wplr3ICJeVg6JDkVdK3hd4//O+Sob
	 2xrCGr0xorFQvWIaU/hfQuRJ1POJ9dGFduHIL2RwgReW89dx/76Iar2mN4sgY2Wd+o8py
	 eyIP4gdn+DkoKBEmvwCGqRvQEGETvqgZQpZOoUt4kGBJjUH1Yv3z3yjMiM2/MXLnEFyDD
	 ih+ttHpc7PwHAxb3dvyRFVH0SoPRCQFPBypczJnVJLsv+KqV8jNewO+YSDzB8iGLcWRCH
	 Z77atfJ3e+ZGLa9/PJ5Tmtbh2MI20rWUde3RvYngHQS8ml6sRGFFI1XD+dwmK9OLWcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qEjw2Y2zGtDBL6Dtw6LJmNh5fy0yAquXSw3XyOdS0sU=;
	b=cuhn//M0GRICUQCoT0vwXu/jcBX264nh5uyvI7bCP45zzAwkbIb87bEpU39vTkjRWwsj
	 6x4DEnNqKcjEELAg9CPaPuzmeh2vc71Ks+vBvEk3/EhiNBUcY0dsTHocssaKWi2uDuMU8
	 7bOsi4DjBdMEcMq3yHsznwU42BSSUjTmSId0uo57RKS2Ty5ginWKuiKZaOxQX6/9DdVwV
	 QjStP/nc1XjENUhwph45MnYf+GSU4UO/lM3HtYtUnw8i7gvTYSakIJDlADsDmF5RC99zO
	 +biO4byVnCMOb7jInYS49txWbat5E4JcFhWBpXImjAMydxTuYr8DA202OGoEOKVBVxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hKtpjXZ9;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695ED606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 695ED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hKtpjXZ9
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1224613b3a.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068177; x=1794672977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qEjw2Y2zGtDBL6Dtw6LJmNh5fy0yAquXSw3XyOdS0sU=;
        b=hKtpjXZ99qL0X4AukIKFwfCH0gn7AdXuQWy8fZtRXUEcte3fjNS76ELPds2+vvhavm
         cHiKkOT5Mb5g5INtSOgJbBBnRk5E9VyXsbb/gvxQsviAO/JM+PuJcH4EX2M+2Hen3Fx7
         Rgou9760mjG0aGLZx+ZVkgBzKXxpOjypIXVxzxm1EjhpiQcSRaNB2F66BnUs7vHV5CKZ
         R6aLltFL6mK9tzB0bGREXD3k0zOpQr5Lyi3g0884cCNmFdsXkcqGqoHEWU9KPjjcBiBh
         Hs5RlxITEduwj1AMJFBsVAhd+++JNZbGB5h/o1gLW2lwspFs99OZHCXFO88Hz+HhHUqj
         3jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068177; x=1794672977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qEjw2Y2zGtDBL6Dtw6LJmNh5fy0yAquXSw3XyOdS0sU=;
        b=qPd0eMir+oOzmi3asQZrNDQtheA8d2M2Wiang1xfCMW1uN6Yl6IZMX176kWETWVaWY
         pq+5wWJFDWvBIitt9YadwR4+1GNLWxP8bIMQ+VH+nNn/66r6A7MLjkYTzqm+JlTP7mF/
         vtK2E3V/ONQKzZ4Zra2majiBzuQAWqb2pUFka/44hCq6UoJgTkaLU7IRnV9RGimq2f3g
         ufneNbvz8iz0B9kq+zqvLoWbGi2Sb2cp/QqHkU27hQhnjvnnlRDgmfh859uj6UrbJ1wS
         80cQRA/ht6rzw5/RhEYLHcj7yTZ5ArQVMeReWOBMzGz3OzN8v7rty1mXLjU+xR8swSKM
         AvuQ==
X-Gm-Message-State: APuU4Z84gNuuqzhd6Bd/W1lxdDAcE+kMEgFuU2QzDEDrKe5hqi6+f1g5
	/80CL66NiMhMLf/YpS/XSj8PL4nhuJFo3uqU3COhqJRYGIpmkl7KXNNAqlVABRE1ZN8XubUUrD7
	tjqMjrW0=
X-Gm-Gg: AYBFou3buvnr+jWr/M4j+Rox/Li0BiiMmrO1jV11nEHu4oSEIXNbCIwTeJnTW5V1/iZ
	ks1yjBYcd100UhF10EWFfSJgNCnbdC0868oV/82W1b+UB4aUd29WqhWii/ue368Z0e293qUht1B
	jOJvQVwVAxTYj+x+wql2x5XPmIz+w5dr74URl7pEOuvnM1XSSIP+zXN9Bkb6oA7B3Ks3k2QqEwQ
	hlqAK1JobC6q/JPUJVJKtTYlrKtPUz6Zex2lpou1uqRGSzXF3UiR9Q37sMC4WbSJTmFgGZhUM1L
	qzPLz5ETw3HRu9h1NWD+4A7VaxCEct+rNDaY6Jjwc2Abf4WahOBIkiGc0+/rrE2EX60RPZm0DPQ
	R3G1Q4WQml5cnxXSva4jajAEwKcYSdlTy9WTFVwKjbJi2bgRTEI84OO0MnLVejQ+RrBojnYtH6Q
	kGxI/VsFWj3zUzrdyo8u4dAJIzXfMlm73MDhMEQSTY2/MfXb0CF48FIoGOxTRqJoI3FJvoI0VXI
	eyjsHLDQRlxfKp3DjYMlse/Ov5Avk16XBAIu80JwSbSg9uvtHLEgXvXQDKngANF6avQaJwZSzfV
	2yf/KSkiXrr8FjQGA8CdkpawXq93CnFLcPtgS6iQX2ubuKDynnt/+2JKpkV4kDNhabiS1mSE+Tc
	=
X-Received: by 2002:a05:6a21:7783:b0:3e2:8f5b:8ba6 with SMTP id adf61e73a8af0-3ebb2779efbmr5519369637.2.1794068176668;
        Sat, 07 Nov 2026 08:16:16 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 3/9] io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit
Date: Sat,  7 Nov 2026 09:16:00 -0700
Message-ID: <20261107161606.2500384-4-axboe@kernel.dk>
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
index 6ce73c93a721..09cd74c4d0dd 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -26,6 +26,7 @@
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
 	IO_SQ_THREAD_SHOULD_PARK,
+	IO_SQ_THREAD_EXITING,
 };
 
 void io_sq_thread_unpark(struct io_sq_data *sqd)
@@ -438,9 +439,10 @@ static int io_sq_thread(void *data)
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
@@ -511,7 +513,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

