Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068123;
	b=TVa6wahN/kXQH8XRpMfhL1i12BjA96HvaIRS5HpBT2KRpVV60IVEV+/9udjiqjOa8mf9
	 acLC6BnvS3ZpJcYwBZfddpOKKIqoFg1gZC4yMjiePoHARrLwJRC5gcV7PvAqu5RE3IPoa
	 JAS2JpDSeyIe76PsWKx/bQqCKrG6LjoI5iTwBy/QWZA03aJ1Sjgqx8Pb+tzTa+MoILA9Z
	 ehQoK8oyrFcHaEmIpFd1WyATwUn4gmmDUEKm4MeLWw+o/AKjPNnGLBcgcGAG45J8w0kj+
	 wCfVyy1nNVxak7MqDYbXsVokyTk/tZJpYywZTtH3opfNlcQSYlle8kuQWF898jrHwIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5b945YIATBMeukiLm6Jk53wC5q/DW+KfjpGi67D5m30=;
	b=X2SlERfXJmkun1y3SvQGys+A2jd/79F0hGxJwQG/I12wjOsICWXS+Olf3bj0wHQgQi6j
	 19AAnCAKNboXEyPXHo7gg4z9RFScxL1mgd2DyELni2y5tixzJf+McKsem67yaFSp7epGP
	 1dzkl9qCv+1UW11sGrONa0rxXAo3L61S7FUOI1LnEBfpwsEeLyRjXc7qnEUD4CVmDDRdT
	 oCGVtz2Y/lXGQVNeedDnxLj66dIDFsf8YZu0JcUljImuJgNFN3SDcjnzVxfvF5yvuKSUJ
	 v+waTFT4AzTJH7Hn++X6X3cHqOvmv6uIe33E/+ltBSbcsRtQdHjuq+kUgf+ABAsfe0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lnNuDK7o;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EB606AC04
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A57EB606AC04
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lnNuDK7o
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed3d8877e6so9236055ad.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068122; x=1794672922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5b945YIATBMeukiLm6Jk53wC5q/DW+KfjpGi67D5m30=;
        b=lnNuDK7oVCVakAh3AOipZt/R2qvcUoZprpEa4dcOO/wGRzG9n3gn2uTYn5dpo1nzDm
         FnyaJByINtByj92f03yrHVz+yLmtbrGhndjOp/2kjbypkeZ5dKD6novZIl9sviYpYKLP
         1/j0MA/tolrb6GTGacLXYQEmm3VyrUH711Q0I/F8Jzm3HjhuaEzLpN5xn3wx1KEny77t
         Rahzcu5ekxcA0U+DpIiuR4lV1wQ3uxQLZy0CybmnBtZq/Sc4UhYjWGJKILoo7YLrmCnh
         5gin2MuwR+RNDB3QRmKqwflsBb2NAdVSgsbbIA44pL5lH4skg2cl8sjceix1TRjexCu1
         wmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068122; x=1794672922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5b945YIATBMeukiLm6Jk53wC5q/DW+KfjpGi67D5m30=;
        b=DSrIOVQmDGlVhSSKuFcj/mc6aXbk4aov5wu7dP4wjhSjEGjQkIJrrauV4xillKC3tZ
         g/XKYa9RadExKsAFYnr7y5tEPfKouy0hg5hm3ENQx4sSvOTvMm0O9iYQFOMQj4mCrMgo
         V4hVCbvT8wOLqKmKwpg/OUE6aVvcZ7sfWfU4oW3sc6a25J7DpRM7XpPhYaazEXI1mMWE
         DHvhhZbICeyDAxdkrb32XQL/T54v7KhKFhDH5KO6ddRkJZ0fcEPtUAZu7N8GKc00y8Vs
         vkjBewlGsm7mrE18JSotyMpD7zssjaguAU2kTR8Br47aOU7Yv+4AcL9IKjGzeyMRCgt1
         LYyA==
X-Gm-Message-State: APuU4Z9vtU/ZIKT1xFfTMakIFCCGPrc1BR7EyE3nyByAonLJERAB1W8P
	bi7p6s2aU0zQd2iW6dLlBVXjGsuNKnT33jW8o2MRqMYlZ+yRJaRIbGJiozRSUHIHJXaM8F+sRpQ
	i57+Z
X-Gm-Gg: AYBFou29me4DJhsoejkUkBlEUFWTb3CKPa+uorKZAXnFsHpgisFZ7FcmScv6A1603Dv
	K1ghEMw3DqR5wrACRVoXFxIp2+XlInbZE9X9iKfmBbu621THfEWbei0BIHuFhuTXOqjjR10hxkW
	1lVYhCSLolx3aisUG8uS73YqxtKI2Pbr+IDftd+2UhIvzxPGBkM5fPdfBjVBC5XU6B7sMYluCAf
	7tfWuTw5DbQTmT2WoIveEIehUEuCr+Vj+LzCpAL0v9lsy7ZJik7UNTUOwKwSjKnJ4+4nmZOJheF
	Frrt3MU6vRS6XYRWj0JcFSBTEuudPEpfSF4T9MO5AmRIjNBuKcoHMBAp8ekACiYqIBQd2HRP9Rc
	C7hvGcHkMWgbmYYYKhULxGRyDZzskTiemQdeHQUEUYX79KstzLMKutzaPhtrX9vt7b/RvDYI4Dg
	/D6UgZ3+EK1hxpYkxbhEqMRJlr0uQA4oB1LrDyJr2EmFQHJPPYpziJTpljb4Y0F8p1hwhi8GIFt
	l9oCgELwsKtyOvTXcS9m47B0RRkC9mg3hWnD72+1Qy7IBT0SGhvmi6eQI3OET7HrR+dRvgjkV7m
	1RzkXS27nv8y/XYvGx/BoUHCp0VZj3c7SvXeKgCXDNMIRcuUejjeo450o+pnbjJ9VuZha7pgI9U
	=
X-Received: by 2002:a17:90b:2748:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3b0db6eca36mr6260587a91.48.1794068121908;
        Sat, 07 Nov 2026 08:15:21 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 2/7] io_uring/sqpoll: don't attach to a thread that is canceling
Date: Sat,  7 Nov 2026 09:15:09 -0700
Message-ID: <20261107161514.2499962-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161514.2499962-1-axboe@kernel.dk>
References: <20261107161514.2499962-1-axboe@kernel.dk>
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

Commit 22d9db9fd64a493525d692b32c556875b7254665 upstream.

io_sq_offload_create() refuses to attach a ring to an SQPOLL thread
that has already gone, by checking sqd->thread under sqd->lock. Since
the thread drops the lock while io_uring_cancel_generic() waits for its
requests, that check can run while the thread is on its way out and
still see it. The new ring is then added to ctx_list, io_uring_setup()
succeeds, the thread finishes canceling and exits without ever having
looked at the ring, and io_uring_enter() fails with -EOWNERDEAD.

Only a thread that exits on a fatal signal can be caught like this, as
the stop bit is set once the last ring has let go of the sqd, when no fd
is left to attach through. A fatal signal is group wide and attaching
needs the same thread group, so the attacher is on its way out as well.
Still, make the check see it: set the stop bit before canceling,
whatever the reason for the exit, and test it when attaching.

Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Fixes: cb0306c52ffa ("io_uring/cancel: drop sqd->lock while SQPOLL waits")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 has no io_sq_tw_pending() before the final cancel]
---
 io_uring/sqpoll.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 2cbe580d76af..a9400233053d 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -337,6 +337,12 @@ static int io_sq_thread(void *data)
 		timeout = jiffies + sqd->sq_thread_idle;
 	}
 
+	/*
+	 * Cancelation drops sqd->lock while it waits, and a ring could attach
+	 * to a thread that is on its way out. A fatal signal doesn't set the
+	 * bit, so set it here for io_sq_offload_create() to see.
+	 */
+	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	sqd->thread = NULL;
 	list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
@@ -411,7 +417,10 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		list_add(&ctx->sqd_list, &sqd->ctx_list);
 		io_sqd_update_thread_idle(sqd);
 		/* don't attach to a dying SQPOLL thread, would be racy */
-		ret = (attached && !sqd->thread) ? -ENXIO : 0;
+		ret = 0;
+		if (attached && (!sqd->thread ||
+		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state)))
+			ret = -ENXIO;
 		io_sq_thread_unpark(sqd);
 
 		if (ret < 0)
-- 
2.56.0

