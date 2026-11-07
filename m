Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068223;
	b=Tu07aMvEfXtEiHmXLQ2ek1Amc5xqSJqLUvp2XNQcZ4th3HYxzqQ0X2UOnWeZzGJpeA0/
	 pHCGEgccxCL5Qj0vchrtXIrnJ1WK8cQly1a0edFzC/3yCOwaEiXvdKX1swirA5rPNbj1K
	 Lk0SFdQndBJ2zYeWyEKT3yBjFvYa/wMqTQ/+qMuZ3cDusH5iCyrJv44oAc3lhsrqG1uOw
	 LNHVtS2Ek5Y1nR5ihL019kLQ8+DjxOdKEPPMgcmTlBQTEJol/lVYI7k5qNm0wXcGCP0TA
	 Y5k60rt+hLCN6eMtE1rf+2nQS8e9tVLWF7FR+KWMkmIOq+GPFZIf11+s2/KFmK4PG5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yIAPplhKJ5q3GvhTvkbRhKje/frSyngub1PUxksYYmo=;
	b=BfQXnyyx/PLkKjlnMwFEuYFRfJKgNUCa61ij04xpbTUpzncpp7rIayuhJgedtA8Z80TM
	 OIGBQ3+EHeLfuj1vd9OD1JDvnvGh1rlToPnCnYKyqpY1cRvc790jvwvetW8PHjh/7A6mX
	 fz+UJ0UYSPycT3JQ2RAcOTODMjHdEhFc1faHasLhDs7uhkNLr3NivZ7ND2wt5trmfJ0pW
	 Qf/tmLUN32gXMVYqBNWpY7iL5hooz6tlT0cF+LzDZScR+Ca6n98nlORfggpleSNXU/U2s
	 mp0Y+IQe/UpZ1ZzcuM6L5+sPhSmvNVRNIB0+BADIbDDcChCf1YEVhqMAvs70CyIuOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S2m0an4X;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E35606D830
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E35606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S2m0an4X
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso824485a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068222; x=1794673022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yIAPplhKJ5q3GvhTvkbRhKje/frSyngub1PUxksYYmo=;
        b=S2m0an4X9ZtT+s8sns4NIRTuzHUUlxtB7jTUWnrmfUZmPBtJTpRIosuUr4SOGPdFYP
         4/IMAzFRBvbzxCqrWd1goCDiknYD76U4qbq/STvTKS7Zv3JAI7Qu3v2bU5dbIQ+Gba87
         SrmcnxRvPfNdbpfF8c+z+32Nr4zWCharge0ZiqPuHxQ2+uyQGpf2VxxFpbd/GD9lFy4x
         Ve96FrfKaVtIlxoQn4CIc+L4oH8qlhKGqSewKyTi24U9rXv7mG40J+e2zOuGrLx+hCL+
         ctt72Aqsjtk67ZnwZHJPcCsI+oDp5hjFsUi4T2zP4kAIyH1QG07ItviTkUKQHsP0HNFd
         rlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068222; x=1794673022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yIAPplhKJ5q3GvhTvkbRhKje/frSyngub1PUxksYYmo=;
        b=tfGPzlkZs0H7so51xQc7IL+4NttHWtHaVqOJNBqiWkPXu6R75Bak/0xTq3q+iQTtnt
         HWw2rrDO7t60n0iOTHHrt5NhGjz6Qd48jBduEZGYeWuS6NIrh+2JmpfQ87XCf5eQobgF
         Cyt9sUASxjdYzB82yT/921LXuniQOHZoBBZMT0pL35RXkofkDuY6GF3jjFnEmqOQ14rB
         /WtfhN6jaaLbxW+A8mAfwTxvYc0gTumSyeNPliOKHViMRiJAzIaGW7amYAAcln9vrmaY
         FZzYkuQCMOeFCEDBZTBAljkB91peJ6Zp5rTyFCu/8z49A/MOqtOPbIzv0SeFatmbVoXL
         8EsA==
X-Gm-Message-State: APuU4Z8sPX7cM70+vuOTD/gRHieouEBqXlcVg5HwX9SvPYjYqLrOlHKm
	kKYT0Du2mMNlYKZuoSoflMh9Q99YyShn0HSCiyjpBipCZUcpNku0wmtHOdForjMcGJkCyEJy5u9
	Jwsy/MQQ=
X-Gm-Gg: AYBFou3fv6pGTWhbERJmb/Pjt+4hEVLJW1/C8XkOo1jw1++HF0f7jDgd5e8+BqWLmhe
	P5PlKwVj9RxuCcSUqQDGX3idJo0NZkKndoBpM1M9qxZtamI69aFC5Axz+wqlnaGF+nInpt8sRMV
	UDrFiJw2g5PHutoICEIG7Y6f/rHzc5lAn3ELJ2LKM0V5If/0Q57hWbs4ZqYS3k+oej5nDp3xh5/
	RqrLAyyMMr+Q+srPqG7aPS+EIBIdgxKx5xQMoQxA3SObj92fo8NTL6X+NEDcwP4xmxyeehtxzgG
	VcKZOIGLRq2SDwsCzm2dFpX/9UgqDbHqOUYlxnOOms3dSBE7C2ZV4XXrMOewaOuh9tkVpfsv3Y6
	8+/yYwCQLv7xyykRZNvnSSrNwwsz37hM7j5hdLXUrBozyrLhxs1prwfuTg2p/eogcIyqa1lmvwK
	3WIEy5oga/oaY5bGbRnMIXgpP8XxQrGGNo1Zer+V+JcFVF866yB4+2G+p+iAjjZAPvmIGCIoG03
	y1G4ZMeJ2YnQrIMwUIu7IJe5SneZzpr+DKF0upXU+v5sF5Y9eXbvWStW+UF/wgWtyM5P3Bizewv
	D5teQRODuQqvoxegZ1qE7rwvu+kcpSV7kz8p7/5yRVAl7MgTmxuuBwitB2L2v/dYAhWGSys1EFg
	Wqs52edYREz4/qc391gHG
X-Received: by 2002:a17:90b:58c7:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b0db6bbc2fmr6431850a91.12.1794068222261;
        Sat, 07 Nov 2026 08:17:02 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 2/9] io_uring/sqpoll: don't attach to a thread that is canceling
Date: Sat,  7 Nov 2026 09:16:49 -0700
Message-ID: <20261107161656.2500790-3-axboe@kernel.dk>
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
---
 io_uring/sqpoll.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 49c52284ecdd..c833e776320d 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -433,6 +433,12 @@ static int io_sq_thread(void *data)
 	if (io_sq_tw_pending())
 		io_sq_tw(UINT_MAX);
 
+	/*
+	 * Cancelation drops sqd->lock while it waits, and a ring could attach
+	 * to a thread that is on its way out. A fatal signal doesn't set the
+	 * bit, so set it here for io_sq_offload_create() to see.
+	 */
+	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	rcu_assign_pointer(sqd->thread, NULL);
 	put_task_struct(current);
@@ -502,7 +508,10 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

