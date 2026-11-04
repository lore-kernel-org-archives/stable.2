Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817838;
	b=KXi8YlbEC9hQPcvi6X3bqTLkJb2fSl+KMK4XdRWd1AXCcgHQDxWIR1tDiMfahhGRiXBN
	 FvEr0bKbAqaGp6slBMvnGw6JxxU+4MFYgfQopvSWsXK+y2V5cyQ0Zgs2j3tIznHLPglFz
	 it8eSOVty9qjs15nRE509BQ2IKu8Qy9go1dM65eKt4cbsTjtiM3BhG/t8Y9MFai/ASNVK
	 W9+drN/Z8iCuFvoMKt/O0XwFbh1GqegLhXAYC9IdqqeprzQ4QvnR2FVp4Wzs12gGpeaTO
	 IiQU+eoheVzc3rAWAsj2aQYfDgb1JpaQ2qL0qOYEy+QOnJfLXygwFrX7dQ0StHr3a2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rzIBNmtnhQAizDMO0mckPBbuZE2/wV82lsxH5xvEbjw=;
	b=uQ9VPiAU22uB/XYObMN8t0jpuK/Bo2xVDCnDxAX/N3pkAQhXz8GOJCOE8k3x8SGexEZY
	 Ipgn8wP7RxRhSUy+cUHH+fIfT7SYiCBur/MKD0GS4M2itiK0++JKCKCGbANuK57d5hbBN
	 b6w7Fsxpg+FkwXSiqRGMui03WMKLwdR2r0XogBmY8GB2vUPTMeCSalrkOw+Xin+PN3pby
	 yHBCTwofqD9T/gi7mgZvK8cZhjBKFijByTQlp1zi2xyWBAGdj6mTpVDvHDKqFGt1Yyr7x
	 VEwJncEzOV3B7P6SEeqcztIG0DANCUUh04xcwN1BvJkhwEoXVoK0t9PGxjOD6W4pQ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R9lb5qma;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7A606D809
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B7A606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R9lb5qma
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-51f2e9e6987so1496493b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817836; x=1794422636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzIBNmtnhQAizDMO0mckPBbuZE2/wV82lsxH5xvEbjw=;
        b=R9lb5qmauQQBtZAMFbx/a76627NxV/+CPELBBWU9Qziyf4YzXZ1tBWio6yMcR0F4BS
         ANTNvznSPceWfFwtwLdmujhenEWhMgz3Hu9LKII3CzetR8P2Y1U2h39Dqq6XE9Rdr0ya
         lgC0LH6lgt/v/qTk1SQbFNoXkuJnNYvar/4iTAYaXuaLlEWCHOkJQAq07vGifJZQCupz
         skGMNhRaIeQ6xPB1DD/YszWZvmdtaHgVBKZI39ui8yniXIH/qYNJlnjjFqxiJ7rLcZ+P
         /7cVcvWVTUC8UfhEuYCUHtYaY5LyLZ7Cmo0lN5o/xiESAZg/IolUc8y/K9RJL9ue7kNL
         ziXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817836; x=1794422636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rzIBNmtnhQAizDMO0mckPBbuZE2/wV82lsxH5xvEbjw=;
        b=B0cjDjzRhVeDGVpxTqFbbFfuzcozvxrEEjXgaZvztINGM/kDkPBCQAYQtkhsP1X32y
         u73vjwbGMfTR7VOhrGrUQP142xNnhMmEmAorCGKjV3m+UZLr1/wXwRB8oEUw9LNyUh+P
         Lg0vRaWaIvvHBCp0kMyhKWBvbkYEiDl6DsEv2GbSP28CJLY7ob3zKB70XO1R3dAiOxso
         shYYCAPoj4zrrLR1jRCbQRi6XhMmMpXYTTQAL/BHy0uoGS8szs3mdkQ2jzv0LnNE2LL1
         YotW6qhIh4HO7rG0vQqXMQnsX8bb4HN4lVBPjXNG0FVmbvMr3HSNsoFosokRIw9wODMw
         WEeQ==
X-Gm-Message-State: APuU4Z+RMRGVBEgEcpA/AYszPoF4+0u/FTOl9gNX5JaE+rNmDXyfWtEl
	doeBi92rbxZ9YpNt3WVY066KJ8MZe4WwQlIYoZn2fAroB0U/Vn5T+VtuzJfR6OAzXawWiac7e9F
	Mqr/gOyE=
X-Gm-Gg: AYBFou3A0K2u3F5TxW66J3ajQ96iuafxBR5VHSZHqWbc1td3x0ac3HltwIjLrR8aqx9
	1mfLDZ+qXJB0yV901/fPVJyVLpS1Rl7NjT2GWzVGr0ExEBhdb5VxRx0GhdGjZ9xJO9GlZRjp+bv
	TF/lB6/a2GRON9mMnIvcwf5KQqrYqCgdXiyR7o1S9vAAJ8/WovoQbveFXMdcamTzdRXEDrEJQvz
	xRYIEG1FHm8V7uKoVzWyHjkFuBzZK1cSHER4Q/pdK+/Qadk4YRqqqTUQQup3CV+nBYIszoaPZct
	GdVyVV9TQx57PhAGFA+qyba0eeHTTRKQGnbgxi7YGBGUy8q2qXLjv2LxVHwqYzyCaMmvybITd+j
	u4Vt7r8QQJK3jqUY+OFpKiJ/Fy+pBw00tOXsXALHWwsAPO3M7MAzS5e8+wiMfFX2ZjOEnOhWJ2J
	J9saE12R0ut5TOaEq0fovubQgROguN41+J81t+km+tbqJbt8S15xv8qVZQOOrMTAKU9nKhl97u+
	clylWOyitXpJKWmpL2B5ZrEXMlB0pLCVcqOEauiX5dH/bu2nkOOZTY99mqLWiPN0cjxTibslNY7
	xY3A9U+RuiEpMPpf2l0NdVOj3K/k8nonB+ucc2pJlErZvTqlkQQR5kByhTosEq+Ey9BlDbuEJg=
	=
X-Received: by 2002:a05:6808:2391:b0:567:baa0:39a3 with SMTP id 5614622812f47-567be4360damr237078b6e.32.1793817836415;
        Wed, 04 Nov 2026 10:43:56 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.43.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/9] io_uring fixes for 6.12-stable
Date: Wed,  4 Nov 2026 11:43:44 -0700
Message-ID: <20261104184353.516403-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
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

Hi Greg,

Here are io_uring fixes for 6.12-stable.

They apply on top of v6.12.115 with the current queue-6.12 applied
(stable-queue 6575ff04f2fd). They don't depend on anything in the queue,
and apply to v6.12.115 alone as well.

"io_uring/io-wq: save worker type before dropping its reference" is
already in queue-6.12, so it's not included here.

Patches 5, 6, 7 and 9 needed changes to apply to 6.12, the [axboe: ...]
note in each says what was changed.

Cheng Yongkang (1):
  io_uring/timeout: count cancelled timeouts in cq_timeouts

Chris Mason (4):
  io_uring/rsrc: charge buffer arrays and nodes to memcg
  io_uring: charge tctx nodes and personalities
  io_uring: free XArray nodes left by a failed store
  io_uring/sqpoll: don't wait for the thread to exit

Daan De Meyer (1):
  io_uring/net: don't retry a non-blocking connect() that fails with
    -EAGAIN

Josef Bacik (1):
  io_uring/io-wq: no new workers once the exit has begun

Yichong Chen (2):
  io_uring/kbuf: advance head when a pickup empties the buffer ring
  io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

 io_uring/io-wq.c    |  6 ++++++
 io_uring/io_uring.c |  3 ++-
 io_uring/kbuf.c     |  4 +++-
 io_uring/net.c      | 12 ++++++++++++
 io_uring/rsrc.c     |  4 ++--
 io_uring/sqpoll.c   | 28 +++++++++++++++++++++++-----
 io_uring/sqpoll.h   |  3 ++-
 io_uring/tctx.c     |  6 ++++--
 io_uring/timeout.c  |  3 +++
 9 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.56.0

