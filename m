Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817855;
	b=dUaYsXa+W7JcA9HuWYxuiflfdeHtonQqUxnsbRV//q4C+DlC1Xzp1uAMTf9xqVU3+aP/
	 VeUzVPwitVAU/7uMMhhPosbZXfnXzYvykZ27LWVGbOHcJ6atPPxA643Ju6qQvqzk011dv
	 652Gm5LsllZsq3qd80lCRXK4r9tmm6EEUy6riJum5N96ITYf92CHi9wNYt7eHUYSjhAJu
	 OI9Ig2sL2thXUVxMQFqBrmj5b209OF4Ihl2yadYcvXiITq5kUhK6Yrp4Jm55g/BqxLCWl
	 WfEjhOWct24pzyYgz9FUUNdl5l/ZXEVgaMZFRHY+mj3+K4egc3YFJ1fR0D1y10KkFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SN0V+vRtg6zLB3abKle9prcIHS8KmWhlzRvsAMMuxFU=;
	b=fhgI3MmGWOxEJMHF4hSPqQ+7Z2AgeGMLeO8FP1myJaL9G2aIOoB+M23zrI2Rh9o0yB3W
	 9ftDEDFZmHJeV3kXtLgRXb8+JdXA9hGFQ3lEc/KcdeKpmKsJalDmJ8j0MIdyIeE2bibpW
	 +7MjoFIg9U2lO8RmGdsMYcN4+OkXqb5E99J7mpYnkE+MF4KbSSFBkWL2YrAzXEJu1YI5v
	 UKjl32FW3B6G6Q0hBA7goQn17rbwreoWF0xz8B7fWGuiRpkop6iY9Eyp1vY1+4El7coIT
	 GLEahm1YFYtL7ztoHwcQIbADfqsOBZT1uPiX2K7/k0yvm1xLQmd6z8jw2qD+7Cw//IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j0m0baad;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4F606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D4F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j0m0baad
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1135035a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817854; x=1794422654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SN0V+vRtg6zLB3abKle9prcIHS8KmWhlzRvsAMMuxFU=;
        b=j0m0baad8+4QwW78bcJgXy1tQFU0UUjix43t01x8+lf/QiyJnC/Urgszx+5ZYcMsP4
         p3akyG+aPODscq/1YQMF86qdrD9qSZK4EMrOsQqLhESirTDwI8k7m5E0IrB6Mno9M5O7
         kyNZYXzGIMnoPqlJhVJ9Hw3bCypNzVr3Ha8BPh+OQXOLReWGqk84nANJIrFeMqpvRsD9
         F3XeNdMdIDvXPlcBI9Kwo03rVT0Fxm/w+vnT+fzLwef3xhMK/iez7HR3Tjky+1IdPJl4
         vVTHIdJOPyUNvEZN2xjysMOX+EInjrzOGDm0kZldRkEt1FODb1JqVQm6OEP6/1wGR5Tv
         FI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817854; x=1794422654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SN0V+vRtg6zLB3abKle9prcIHS8KmWhlzRvsAMMuxFU=;
        b=vzxZ3qC1BTj0KMBBwIq4msvPYxg6lm3AWHdXAyUcfHnz9XdSaxeHiWiDO7swrevolA
         waoGqHPM+w7QL/DBiPINo9e8xNgeMChuo4XMMU4z9fbA5nL/RH/x629CBmKGqr5x3eVd
         +q3LXtnLyk+UI9DUZHqCrj+DAE57rS8sWiGZakrZIN3S55I6WW96w2KlO/KL/5zmh2pT
         AHzfosDGMyAqWiSdytrC8ZROKuGqJ2PO1VDIjDslPdBxU+8p8F2Rkhb0Nj/BvoNKmGch
         m7kb98aI7RfOgfaZcH+8G/0IG6NuxX0C4ovXVjhoaO/i0650dcYZGy8JtUU/WpC/Arf9
         NhmA==
X-Gm-Message-State: APuU4Z/pkpHHZsEcpTBnbe0BzfKmDlap58xJ8RO6MiAGuoOwl4RooXNE
	PF9frpVz+DdYkpOnTDH9s4fvUv5EmVFRnioO64b74fqW6eNh/YdgJuagRgxawWqH14sDH+PGS8F
	rwL7NzgE=
X-Gm-Gg: AYBFou1eTQrLRNvMfzZWgnMB4SpnfT0sZq/0BBaB7uwfSozIBrqB3C/pUaUikF9J8Qt
	U/IdjgLp5S3qbitqkIorkPfO9T0esH4hyKIMPfzdsWsRGgp2ksUtwUlUX6oLoa+tzFf/Z4xqLyR
	ZRDaNYDEBDPYPUWm2HG2ri+IYnLarl4JMgdulIMYVyRFCYXIvnr42nfJH7pD+0ws6GWcevI0V10
	8JaGGK9bi7FAkel9PMJFt9GVslijqrJlxErRg0Z79mQgEBvaQWm5MQQA4mWWy12OumdtwKbb47K
	b5t/+bd04tcVgD2Q2FAnXF7tOdOoDA8do0RDjfJsQmyhfsZ43N9tdqfDPpeYNO3bNbrOGIMP57L
	pJBKgt9viUn/UqUSikh532RCU7CvQ0UNTx8IXLGanjVz57Eg42kh5aog7smYpXHMFMfvJNRv5wL
	s43KWcBzIfGGAcGLY0miRN+WKq37s82yLoEwMQEOxsZC43fRlZQj52pd5mtYt5ZkxCHcbZ+DdJR
	U9eJfezAgPXy9NPdvCIrXs0eV1X7Cs4WQcwYFkbRiklXLITB9ObbbeO7tlbgV82GQcrj43vleq8
	fJU9MSW4lnjdfo/pcTCy1U6O3kyeywaWzcO6X1THfTeeKvkYNEChOnK+6cFXOl/SpWoa/rExRw=
	=
X-Received: by 2002:a05:6830:7181:b0:846:5201:5286 with SMTP id 46e09a7af769-85d364d3d77mr13487294a34.12.1793817854032;
        Wed, 04 Nov 2026 10:44:14 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 00/11] io_uring fixes for 6.18-stable
Date: Wed,  4 Nov 2026 11:44:01 -0700
Message-ID: <20261104184412.516558-1-axboe@kernel.dk>
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

Here are io_uring fixes for 6.18-stable.

They apply on top of v6.18.60 with the current queue-6.18 applied
(stable-queue 6575ff04f2fd). They don't depend on anything in the queue,
and apply to v6.18.60 alone as well.

"io_uring/io-wq: save worker type before dropping its reference" is
already in queue-6.18, so it's not included here.

Patches 5, 6, 7 and 9 needed changes to apply to 6.18, the [axboe: ...]
note in each says what was changed.

Cheng Yongkang (2):
  io_uring/timeout: count cancelled timeouts in cq_timeouts
  io_uring/net: fix multishot recv length limit accounting

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

Kyle Zeng (1):
  io_uring: defer foreign io-wq enqueues to task_work

Yichong Chen (2):
  io_uring/kbuf: advance head when a pickup empties the buffer ring
  io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

 io_uring/io-wq.c    |  6 ++++++
 io_uring/io_uring.c | 30 +++++++++++++++++++++++++++---
 io_uring/kbuf.c     |  4 +++-
 io_uring/net.c      | 23 +++++++++++++++++++----
 io_uring/rsrc.c     |  6 +++---
 io_uring/sqpoll.c   | 28 +++++++++++++++++++++++-----
 io_uring/sqpoll.h   |  3 ++-
 io_uring/tctx.c     |  6 ++++--
 io_uring/timeout.c  |  3 +++
 9 files changed, 90 insertions(+), 19 deletions(-)

-- 
2.56.0

