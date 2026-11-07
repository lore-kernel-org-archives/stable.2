Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068230;
	b=dfrxhapzlmFP2HXMDSiVY7W0TmrL+y+3JJVaEWwsWxtM1xsP7AtgbgehW5NGh/gdNa3z
	 3bWlaYb3DGIxP8opMA65t0Wul/912rWY3jgJctrfXD1HIXljahLnbmqPbmvtCVYGTBfgK
	 75pQGyXzvlFiwN8+yLOkuASVLXZkDVgMmQhdYrjgpiCmt7XwXv2khlx7ZxLoa5IvF/r+x
	 RkHgy5IKmbIQnoFhZPZSlPo1Lv2/sATWYARYhtHoW5OZSRl51EKsyjrnsiXzOLG7G5xzK
	 qsmJ35F2gce7B0IAceoBTr5CHVIQeIwCle5zJ+r9yHIK0wZvEewS06HL2mHWBO1oG3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pYuJTp96DyWZlmz4Qpx81QhreWGDGx+AiQ1bQ+CLc8M=;
	b=kewUcJSxcYUzH5ptwRLwwdaBhW7BgR/IrdS5//INqVZRax9/bA9Bvpg52fg5R+fhjIkj
	 CO7KNbLavq3sx+5zBGtP7dgxviz/jj5PlSnkdjimn8IJuuH1cg7muHEfJJ+Kup87IK4a8
	 /E4FZxgEiPNpmD7wiyZPcs0t0OKdhrHjoFXT5TCAIXFWBgAPj/I+/e3ufaYNDP81tjHMn
	 Lem4RTWOhLDjZGfEZhHpUWed4Wtcoe/fv31I9LaT41m2e6pJA0YbYkBliO2ztMcbEkXb4
	 ZIN56pKQNkn4sGHrvdGWXTEZTGCtKbxjp+iZLsd/k/T1IgIXgyW6jPPObjc3I9QEE3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oXU0do5B;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00633606AC13
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00633606AC13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oXU0do5B
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb681de50eso583607a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068229; x=1794673029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYuJTp96DyWZlmz4Qpx81QhreWGDGx+AiQ1bQ+CLc8M=;
        b=oXU0do5BQn3SYISJxlGXlvuW7rVTg0D2wUSYDPUXwWwtD+ciYPgI5UvfO5nKX4oVPt
         99MYRMeAA4VWqiETfEyh9rNxJ10LIg7av6M1ZNf8wwnRZ54egjLfXo1Zs7fvKDRPAq0t
         6Qz/Gwo7JIpIyzbHyMAa629Mu98xKk1d6GCTKbTQ+Z0AfWFCjTu1+WHIw7tFDhUqyBdC
         ExTnWYCHiVglW2KTDD9R/uS6ZNJ/G0t4qc1suKB67YR2jntkwoPSeTcuwu/IQE2R9rmn
         cFry+X9+uI0gAp0LQx9DCw697DYt9/82D2z4q6JNmt4wVPzYIJresqIfGv39IDfka2wp
         UsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068229; x=1794673029;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYuJTp96DyWZlmz4Qpx81QhreWGDGx+AiQ1bQ+CLc8M=;
        b=L9WqMPHM8VWtlpQlcLLy2953lnYd5OphcTvBXgFekCmtBbYLt/YvSP7j5nB6tu9z3/
         FEcxtY3DX94hzLKlWAzEDkM7gKld54J2n6sEuB/WyFca7je0Fp+CrjHUx4GEb/TmDFho
         DhFiDCtTf4k9sdkUEuyCnvtIp2Z5UJyPYxDJSodylRoVv8j3BeoHNvxDUFDg6FamhLMo
         4tOeII8y2CkTl2bCkzsX01VuFdE4BLlHInHSkWAdjRySa89MYorepXKSdmIMydljxz+v
         MUeKsyI09h4VxRf+vl7mCDLp/SURTBSwQFEYaFRn08SuB0GtDs418+HYtaOsP4CbHFXC
         x3ew==
X-Gm-Message-State: APuU4Z9E++oAmLL8k8WFDR5K95e4Mbh+fJaPpUmuXynvcDxh/JfvSIDN
	spb4XLQUIESZxAsY9UoDIY1vf4+9l8WD2ALqXg8Q32i9ExOwiEFhu0UoUIy31WAnL7GfbAv/RZU
	KsHBME0E=
X-Gm-Gg: AYBFou3zRT3FWJFnwMQ2lnEbV56DxIt5fe1nWKHcHTnju1TabCx+e18ARFjyRP9/P41
	8ECOqgGG823FXRAna/HdP4hGvh9kl2uNeo8O7a+CIBzg6TcGewLXUGCoBq7enUXdQUTg+4bzg5v
	LSrLYpyc84Kyor58ta2Py63bjtFWDHSwDhJfthezRIB66KEmTYKRjBbQaCy5IPeoPqO9G7Py6oh
	wI4Ew+rUq5740Ka9/h8iFVSJQwZNQohu0mBKLcNPIlo1EzhnBc4zQRCgl94BMDdhDEHeHLY1JSm
	463iG0IvJA1RVW7aJVEuCA8ByVaZ/f8aaZPkZkcZ9tYX8c2pRZK74eucw4cdPpFvppvP1AyuImP
	IdIzpTseH7TrB6HeifGoGa35+o4sN1QOnIT+FjF3BSzyXkcqAfLp+/PEpI5PnSU9ClhMLvVY/Er
	r1CCr+uSXseIHesL2kHH3HP8tZal6xXXyM6NGl2TFCXzIvUUIrzaYv1Z64Pqa8Fnj/qn15/00IH
	zXtQn3+P/NDgHaKLy2CtEPKUBP5JOeXPuKBnjDJRjT2lAs3d6TNyjmKsZMoop4nLBnnmEwnlPSZ
	Iu4BHhKh9U5Y+MFfxlohE7YytKgeifvzO7zz8oDHmcHCbhoDorg4Bu73de3QuODBya1PQHVaZT0
	=
X-Received: by 2002:a17:90a:e7c9:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3b0db014da9mr5942184a91.0.1794068229325;
        Sat, 07 Nov 2026 08:17:09 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 7/9] io_uring/poll: don't poll a writer for a read side hangup
Date: Sat,  7 Nov 2026 09:16:54 -0700
Message-ID: <20261107161656.2500790-8-axboe@kernel.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 74c1f1048e4401d6a953ab2299b14ace1ad6a899 upstream.

io_init_poll_iocb() adds EPOLLRDHUP to every poll, including the async
poll of a send that waits for buffer space. Once the peer has shut down
its sending side, the socket keeps reporting EPOLLRDHUP, so each re-arm
in __io_arm_poll_handler() finds a ready mask and the request is issued
again. The send still can't make progress, the request burns through
APOLL_MAX_RETRY in a few milliseconds and ends up in io-wq.

A send in io-wq blocks until the peer reads, but sendmsg and writev go
through ____sys_sendmsg() and sock_write_iter(), which turn O_NONBLOCK
into MSG_DONTWAIT, and the application gets -EAGAIN for a request that
never asked for a non-blocking send.

Only add EPOLLRDHUP for polls that want to read. A peer that stopped
sending is no event for a writer, and a poll that asks for it explicitly
still gets it.

Fixes: 464dca612bc6 ("io_uring: mask in error/nval/hangup consistently for poll")
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 9b73b0d88a0e..9703a2fdfb44 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -128,12 +128,24 @@ static void io_poll_req_insert(struct io_kiocb *req)
 	hlist_add_head(&req->hash_node, &table->hbs[index].list);
 }
 
+#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL)
+
+static __poll_t io_poll_unmask(__poll_t events)
+{
+	/*
+	 * A peer that stopped sending is an event for a reader, but a write
+	 * only poll must stay armed until the file is writable again.
+	 */
+	if (events & (EPOLLIN | EPOLLRDNORM | EPOLLRDBAND))
+		return IO_POLL_UNMASK | EPOLLRDHUP;
+	return IO_POLL_UNMASK;
+}
+
 static void io_init_poll_iocb(struct io_poll *poll, __poll_t events)
 {
 	poll->head = NULL;
-#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL|EPOLLRDHUP)
 	/* mask in events that we always want/need */
-	poll->events = events | IO_POLL_UNMASK;
+	poll->events = events | io_poll_unmask(events);
 	INIT_LIST_HEAD(&poll->wait.entry);
 	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
 }
@@ -1006,7 +1018,7 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 			poll->events &= ~0xffff;
 			poll->events |= poll_update->events & 0xffff;
-			poll->events |= IO_POLL_UNMASK;
+			poll->events |= io_poll_unmask(poll->events);
 		}
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
-- 
2.56.0

