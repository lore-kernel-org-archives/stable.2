Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068201;
	b=UqLMDOXuAHC9PrH6Z8CP4tgq/d3QFNoclqhPIl2ZclinNwFuCZZ/r+JMBkeZa59DMw9h
	 HQdzQYhhD0VbapgqurZULK1TiGw3HIiBuS9yOWspL4RIKIFnuF2w8Yv5zFwimkWC22rL8
	 7yBy5db/VJT/l1/dgc6EB1gCkCwoR5vnx8/3AZkU6yEJXsgL1QzH5dEmvlvv64qdY/ZML
	 BSTm6CAxLf92OKw79KGwSeo071lIKqJP+rS4DfM2RxD0GnqopwmJMEHH/NUiZYiJNjVcp
	 K8jJIGSxUaSL+ADOnoFYifYeh592rlZBYUc3pgOebQfKsiZo0IObhH0mNkRJ0Q7RzhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PdgozSx6HOc+Pg7LBxQiboa2njUZ1gM7CjeOMOBinyw=;
	b=ke3IAxDSMmToyDqF5Wld87qQ2JX6oDML5sS1vmSnK8+w8khKMmkf8qldpI5NHekWIX3Z
	 XTiannbfx1gxFMBROdf4RPEwcWsbRv/2fPLRI8vnc0lMLmiQjdTwIFWU7hsR1evIJETB5
	 w/040zQM7v8+L1TGyiO+vMPOm3bNvXxD/mNWj6fNSbMh/LAgq2qXMwozgOg4FP2/sUa3N
	 bapPNxdZhQ8uNcWLJkt3YrLU+z5axVVfNjZJ/V5A09UDZVfPfj+vpa4gALA7LNfwmLeS0
	 tHPvt6DrTE1Ano0RgqkSVa7nOMThiNvFvwEFRJURR4OXD97SyNRAcZVE85AtDETZOXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="A/lhsXw1";
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCD606AC24
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FCD606AC24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A/lhsXw1
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb760113d5so357569a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068200; x=1794673000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PdgozSx6HOc+Pg7LBxQiboa2njUZ1gM7CjeOMOBinyw=;
        b=A/lhsXw1SSRsAm1+lb6Gan0qHRC16DfbGWbdh/DKLsemo8Ar17Y5FQOC37XrGoL4bh
         nCaXJCxtA2r5SkqfKoSst7OT9pxlGvfd4dKl2DfhtUDGAIPVYZPTwyJIOKYdkNBq74M8
         H9rLcYdMmukALIWEHHVxJuVypSi+n++1uMzXWxfW5PJFoyV3AGDCMriUJHv40TSaKptM
         SnzZg2ttmvxO0j+W/AqTkocZqCNYofp4/pn0FvPJh8GbGP++MVSUhZq8r03rpeUE8heZ
         PlgJDVu/cXVK9YQLZBJ7fJJAqxjc+mV1+/GVSFxcm+fDonPbYLjVpNsEGWZzg/t81Ub6
         6WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068200; x=1794673000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PdgozSx6HOc+Pg7LBxQiboa2njUZ1gM7CjeOMOBinyw=;
        b=UsuJjW1Ynpje6EN3iAOND6fwYYRRfbHK/Fr0QkDPjP1clsDl0BKk1eLI1n2jiEvCVO
         1YcFmWKnQNfHgi2Rz0JGTKCbQE/lnG1h/HOBJB3WLINu4qAeoxqVtGcqPFCqvHHEMkJQ
         5F8MsmFZiY0ENm3JLKHMTGufk6gVzt8EEFEBu8OZKymBDsoYOTvZQuAxA0wCTkqyn785
         SLBaiJJeoUmQtU36s9q2ULrnsAVXflSM8sw9rHHC0k8M5fXWIMbD9h2anAhK56oZ+3Iy
         vm3K7xN9qEOOIilMEgjbiYfeKPPXB95M6kXPlrihuK7CoWOwSUPvCqLOdx7pgftT+VNe
         nviw==
X-Gm-Message-State: APuU4Z/aZ6V9/mDwHgY+3aJvSuQRItOpsMwz1WUtAFBMu6EucApHWtaM
	+KVZpyQ8IygyaMEYif+XJ1JiIplVRicsQzaeL/n510UrR+B4t63kDsQEPArT2z0fCmdaFkCVagB
	J61NN
X-Gm-Gg: AYBFou0Bu8mDFLV8C2wEFfTRvUiAJ3KNkIJUFpzA6DAQE9k32Av0n+3RaRUMI2OQh6V
	NTRQn9nTGecqSvuE1FxZn1HWuKBNa9MuACZfijh+PcBp2LA1oTWk4YQVhUKfl346gFpyfdx5uJ2
	7sycmTierht2buO4XQ6CjQ52H8Ukzg4X579ORkLJJhXpP0HnBdY4eGQeD4x+NShJbYcLMvp0joP
	QM5ir6G8VYSPcnWvCHs+hK+ND2bWwWvlVtVd/x9hi+ww1z08QAHH/OM0vCOpswyXr/mVehwfYeP
	uJ7atZSq4mtb8ZCHpzwgz6HWk8T4kaSt4HK7RvzOwthLgY/Ew4JmZuYErhoxCf2MBknWzQ+aMes
	Wdk1Usz6W9MQQgaQlnv9YU7mUWn2K6/geTIyL4OsRAjRnhA858D3/eC3vZpr8q0WanDBUni1EiX
	RJlkopTfecf17yl7hPkrle5/9tOzR9lRa8+7hnzgB9IFeIv0XQ7bNVPUGL//tFu3Ylb6eDVwW6J
	3hPK0PQMNlvNWddjh0kBVEMCSUYVcNQBtz0wtzw68JHGfVKFLohbMrtwDAxz1gNiEZFhmKYZ1vG
	Biq6ToTWnYmXAZucZvt+otz9adXc/iNeZNpPc7JG+ktrJ5NeVXpwQMj22ZHoGWhYuI9p5njUtdH
	t22WmuIO9OeUDX94X6U51
X-Received: by 2002:a17:90b:4b0f:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b0db6e5c68mr5970891a91.26.1794068199805;
        Sat, 07 Nov 2026 08:16:39 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 2/9] io_uring/sqpoll: don't attach to a thread that is canceling
Date: Sat,  7 Nov 2026 09:16:27 -0700
Message-ID: <20261107161634.2500557-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161634.2500557-1-axboe@kernel.dk>
References: <20261107161634.2500557-1-axboe@kernel.dk>
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
index 406029c14fbc..1c7f84192c0a 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -438,6 +438,12 @@ static int io_sq_thread(void *data)
 	if (retry_list)
 		io_sq_tw(&retry_list, UINT_MAX);
 
+	/*
+	 * Cancelation drops sqd->lock while it waits, and a ring could attach
+	 * to a thread that is on its way out. A fatal signal doesn't set the
+	 * bit, so set it here for io_sq_offload_create() to see.
+	 */
+	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	rcu_assign_pointer(sqd->thread, NULL);
 	put_task_struct(current);
@@ -506,7 +512,10 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

