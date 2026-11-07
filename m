Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068150;
	b=NKRDZgm8231d5RtnXeaeMDwf6/Jzm/7F2+51Qj2V7CXmb5t3vhhpuhJoLNeCnw9kdxWi
	 Tt1Di2885dBsGlPHrJTIv41NG4kTnzedbJYO1s7K6TfjncquD4RoHV9GYpSRr3xTqXEaa
	 3x0jaJbng9mkUHEUmayc4AlG6mXN0XtlBAFnWMux7+e1fpym4CARHOsKub5jxITKqx7Hn
	 iRxt3smeuwLohF+dRPOw31Tyr2pAfJGymA9XpuX66sPBtOIaEP3v72VrClsEMHtyfvEii
	 2pwDVUO2GgxdIIOurfhn9PmLc5APEmoU6ecRHo4g8OkkYmO4msB4Vgagaye8vr2EDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0l9a8F8b3R0bByphjNyOQOmuR99cdUm7qpAeyEpqtGU=;
	b=TTXyrIYGpYSP3K50d4omyMe79b+xNdji7OdUAvHHsnpf4vpYzKyjHkZtoo2425wx5a0B
	 fbkMUIK/N6vyuit6imhZye7UPJkZwT7HHHVKDyLMSsOw2eIj+ml6L/iDmzfFQmv62sB24
	 mJgEgDK/Wae6lg8kNQtHb/OksV2sl0OBDov0WxCfiRnsGECJFsy9KaqODIBoOxehBSwY/
	 6uh4zdyFL4MfDNpcwcm7HhbInVDJ/FTW46KSjqnyUMjLJyroJlVFuKx85grQ1em0jN7PK
	 pJvpNXCo9r0UuZzg2kK15dDxfADv/zANRYMJX6ZHhsDtqPCGk9uu+iG4xKPEAhNcndg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FINARx1L;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773E606D832
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7773E606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FINARx1L
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eb0f1b592bso5602175ad.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068149; x=1794672949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0l9a8F8b3R0bByphjNyOQOmuR99cdUm7qpAeyEpqtGU=;
        b=FINARx1LOAKJQvSiWGDEdG5367CaZadq+9GjnZQlIRzX9zpQ0iID4ohexszIk5hf9W
         BPuI8O9n6/ty8dfF4Us3p7IkBmy29p29nbBqZ7zG3VU3BW52yaiO345pMxVEdpUbK0GR
         R2GBXO75B5L7pFVfslNo8cGIy0yHpOqHjqUDEO3xBh7w9u6CJJrWTu10Tbk5DgvUVvkQ
         ohQTHmgnVFgMVnfuf++MBS62BxqMR5fK8RSUnotws5WvpDYblPhQqS96jIu1O9ee6tZ7
         eWDxbSDtRKLM+kiJW9zRDk4N+tAYiTA3OJhvvQbjHrAGg685Mp7EjwUAR27+Hvb7+Q40
         UBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068149; x=1794672949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0l9a8F8b3R0bByphjNyOQOmuR99cdUm7qpAeyEpqtGU=;
        b=KnOKbQAUxQCrcCFX1sBeMmCvpLQNrET1Nja7u1+/W/fSQrFoNs7enNgM+9UTKkQbNE
         TDkEm4jawJJTikQLJT3D8GeipAu441DK6lQrwn/pnf21vPLPKintzYrsIRTes6o0LLpV
         vDI1QmWGyp5M9b7CGZQwWGaVHDoxTg/sAAEl1JGbW5lkng9o3i5NaSP2acBdX2R810t7
         iW3Wzf10dWzySQSjnCaGYAOrDD4cLEsnEdziayCbzYt9h5hZCvfmS3V0mNZ5ewKeABh1
         BjaKbSlp2fP9IFKSDOn5iVqHHkUVLP9moU6ssm0XPapCalbCdY40UqWrCun9iB35cqQS
         RToQ==
X-Gm-Message-State: APuU4Z9TvPCs1bE8MlDixlmnE+1NXQiIe3ZMqazhwg4giK7SFU6m5YBJ
	8ucuMq/0yr7VNErcILsvnYEOwz/RxRIWoBsjEQrh7AKfQzPP3Sus0cBISPS9EzKc/fOSYbGW8PR
	7ykw+jh4=
X-Gm-Gg: AYBFou2+/DttdFLdnKfd5+OEuiyEhfPA8FHe40HdaYcuyBKDVu78w2YFPCzM7eD+3xQ
	WIa5Dn9eb7JR37Cp+AKT4pmFaQXl4IC7bKALEA0YRLB1LP6zGTlLc2JR4rc3HrrcDM446DU4WtN
	CtDi1mKtjQ3VW4yFx0sXkOzlsEa24Db77Wuw18/obUB8zRwSGplrD8xYIP25DvCBZ96VOZ2EeVl
	L9tjY3cmVTJAbcAPOZ083Hanskqc1LvGER9PbDqmcXCE82l1J3lRYWpkkMXsp6XrC1bqf5U/l3K
	arww2RltXgGfnF8pfQxVO0nPixBKziQ0MOTnGxHNLqEkBNeYlCyeWSWmMts8YUniINowJe/YqOY
	mgv8kPuaZChJ/Nqhv14HVUdFKuK8cLVBL1A6YX/OE1zM+SvOr2SqB9WdFLXzeht7+RRSWrum2bl
	g1PnW/7bXQCY2lmVoVmAbsM+s1x+kz94819GH/iem4TTcaSKIetAhmQkhuTVkNG0vrb4/RdQ1QX
	Ks9uyZQt2LBwiEA/AuJLUWvHnVAYsohM1weW223gh/rwHuJRSfwHiAt+r9fV6qngQzvRl9UaVQD
	1LZEr4Lcu9wnQLGCj2Hj1JdEW1EpT5SCKcra49PdNFry6qcbGboWL4JDvDmqvwz10kItofo+qPE
	=
X-Received: by 2002:a17:902:cccd:b0:2dd:c100:4248 with SMTP id d9443c01a7336-2ed40deb075mr71479495ad.44.1794068148584;
        Sat, 07 Nov 2026 08:15:48 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/7] io_uring/sqpoll: don't attach to a thread that is canceling
Date: Sat,  7 Nov 2026 09:15:37 -0700
Message-ID: <20261107161542.2500190-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161542.2500190-1-axboe@kernel.dk>
References: <20261107161542.2500190-1-axboe@kernel.dk>
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
[axboe: 6.6 has no io_sq_tw_pending() before the final cancel]
---
 io_uring/sqpoll.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index f458c1191e2d..d0f4f05397b1 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -345,6 +345,12 @@ static int io_sq_thread(void *data)
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
@@ -418,7 +424,10 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

