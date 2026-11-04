Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817891;
	b=LohOeF1X2sX8KrAwyXWmdSoY/NjzDuqzRKJXTLAjN/gx7OkmPt9sqG151xehRXKbeFNv
	 kVYSkA4P5RfFqDOHt37J/F0AAC+Im5Ew+VmqONSxP9V5SIx73zt4YWTbmmgP0VWZ8efGr
	 aa1LIUVlC6Ebhpkxo/imSEyHXOWNLFOh550iJxTBZNbedJy5+wGAEYl42baA+XZEuMlQW
	 6VczMXa1lhDbqevlAyhApTHDeW5pIriaWycSPpVEb4kM6gAz9WsNPpv/bLgU+GtZRRjF6
	 8oIUBATyDh3QysD5gov3kJv4GIQPdqYpWAugyaTs/c4K8ByyxCnGeOhEg/sIAVUhheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IzFeI2cnmmGzvjJZu+hFjAcqQKixXHFpu6q/gaFGong=;
	b=P1pf13/pHeaB/xEfmP5GLjrOT1wd85p4EpWIdNJDVCYj0ARRSNfKUBOAcfEdEf64MRd5
	 OCOW1pabRSpYh2OgWvb7er/mxZ4C6n4qKkB3sOZauKoTbxno8kcm2NSoJiRvk+xQcAG7V
	 nLdp8f7vCjz/aD8fLXmBhqHVxaVPEc4/pNfLPRSqHPV1CQMKUs0yEpAcVrdUmJf4FHj6j
	 JVsx5ULB0zKGn9AVve+TCekH1FsevYavonLmKmUqYQCnPt82qc7gAArvUudsGwVA4rqEk
	 Ll1xTlV93iXjL4BjAeh6tWubiEp34sdkHJ7Mvmv726eJDJeTaq2ovuOviZsyXBh1d5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gSOhCMva;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCB606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DCB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gSOhCMva
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so425655fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817890; x=1794422690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IzFeI2cnmmGzvjJZu+hFjAcqQKixXHFpu6q/gaFGong=;
        b=gSOhCMvahMOPzO/DFr5fE9KZjbqGZhF6423foR37qWpbzlObTC2hLTtzb/BsiVN0qt
         QKY5eQGZzh5+WX+xPERLRiNEVU5oa8/FFvZ+wu86plUIews/jYRtItsGLV3gDBMvtCAZ
         MKDjSq+j7UtFdpd+iBoeKPziw7XHSwYiBQKUVbs72uk7ZNs36+T0hhWPGoGx0TXMpoJm
         lq6G1cQRtNoy61QGXpOyArLL8wYceeP9w+RbH97mcM4Zk9UKioJlOlG8YbdxWXNWNWFI
         MoZySbSGgqDkdIOZAlfge+6nwe/qt9AVbsn9yu+81039ymrLFv+1g/cw2DGMqCwsnjk9
         8AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817890; x=1794422690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IzFeI2cnmmGzvjJZu+hFjAcqQKixXHFpu6q/gaFGong=;
        b=Hi3Ql0Ej4zthMZCKQ4S1y3KENDhAVs9wCyv4PzZ0l6fBJfwgwyGXQKsurXBPdm8Kej
         I0ruyxDlf1kt1Kls5R/Cou5wYK++bOATean/5Pg+U/Ecz1GVJJatb2hqfsP5ET0YS9iP
         3l5fUfYtV5y2hJqN9apiqN39a3/LWhn+lfFaD/bBROkKmNtstIQe4FSizPGtOmmFlwi9
         LSmysuDS6fYQBUknbqfDWxbiGwyj3uYiVhbnlkcQAenSktc+84KOOLoxN6STlVx9kPTH
         WqZwM0xnJuWINs/CUB7zr5jZ8qaV0KDf2CpVz9n1Xzu+dtHth/bf9wftZ9anB7bGdkOv
         MI5w==
X-Gm-Message-State: APuU4Z+cZ9MVsETAUpQjehCET+nbA9y9bIJ7wozhIxlunxL6R1niWRG9
	6AYgkABILatwvoidPvNIv1CyVTDXu1Spa3h866w9SI0BUacNkxep0ciGqQ56x9UgjJe+g78nPeD
	qLU80nd8=
X-Gm-Gg: AYBFou1VRK5LaeYY7m1iVSrUptcJzcMvZheQWZmlta297LjjD2vzcUarjIZcSryBRem
	WF/npc4hkGNEZOjbba7h0GkTzlCLPYi6JFdqGMOSBpsW9twt03KTBrQWZ2P7rqIs8eLTaMsXLZE
	l3eBWl7zRo2T2fQTC6a8a7x5miLFHxlkyRaOEtJoeS1a1aErd5MPMLONIv/owTtsAA4yGgA8kb4
	8wuodam2tUHJRPTVRmUgVgSvpvg68njYvndRSnnNX4LRqz3kMzZTayH4Kwv7JnkaIzrbHJEzpR3
	w53NVRyxvSyU0R1f1VGhgr/sUoChb7uZPR38UUy0/d+KzkpWnI868k4fQWWRNSj+I2fItn2h9Tr
	2CK7bh7nz694syYbYysMv47IMjJxTjanbwEK8+NNP+JuLcCsx7idsJG9KZw5Sgrfty2wYBpgd7S
	yGbbYQKnmLztvwCojUAkFoQopnXZ7jU7emp6wQgNWTzvFeFyVkKfERZZTS1HSwRzCUPpmxTCiG7
	nDZl8UWKF2b+OX2RalKR0af1uNIt8t7rQtgQhuB62Sx3yAESXtTTWnmHjXB1gjn/i/QUn7kgvX4
	lBaZTaBGsi6M5gcW+qrhPZXSOapfpFg+CGDPnsuxGlHKwdkF4UE9C8Z1xEmYl3/W8j1P0PlcOQ=
	=
X-Received: by 2002:a05:6870:bacd:b0:483:cb42:3979 with SMTP id 586e51a60fabf-4a90765f6a0mr11613003fac.17.1793817889721;
        Wed, 04 Nov 2026 10:44:49 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.44.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 00/16] io_uring fixes for 7.3-stable
Date: Wed,  4 Nov 2026 11:44:31 -0700
Message-ID: <20261104184447.516768-1-axboe@kernel.dk>
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

Here are io_uring fixes for 7.3-stable.

They apply on top of v7.3.1 with the current queue-7.3 applied
(stable-queue 6575ff04f2fd). They depend on the io_uring patches that
are already in queue-7.3: from patch 14 onwards they won't apply to
v7.3.1 alone.

The other io_uring fixes I had for 7.3 that are already in queue-7.3
aren't included here.

Cheng Yongkang (2):
  io_uring/timeout: count cancelled timeouts in cq_timeouts
  io_uring/net: fix multishot recv length limit accounting

Chris Mason (6):
  io_uring/rsrc: charge buffer arrays and nodes to memcg
  io_uring: charge tctx nodes and personalities
  io_uring: free XArray nodes left by a failed store
  io_uring/bpf-ops: clear bpf_ctx while submitting SQEs
  io_uring: free the task context after a grace period
  io_uring/sqpoll: don't wait for the thread to exit

Daan De Meyer (1):
  io_uring/net: don't retry a non-blocking connect() that fails with
    -EAGAIN

Dominik Maier (2):
  io_uring/net: mask socket type with SOCK_TYPE_MASK in
    io_socket_bpf_populate()
  io_uring/register: enforce per-task restrictions in
    io_uring_register_blind()

Jens Axboe (1):
  io_uring: keep the drain active when a deferred drain request is
    started

Josef Bacik (1):
  io_uring/io-wq: no new workers once the exit has begun

Kyle Zeng (1):
  io_uring: defer foreign io-wq enqueues to task_work

Yichong Chen (2):
  io_uring/kbuf: advance head when a pickup empties the buffer ring
  io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

 include/linux/io_uring_types.h |  3 ++
 io_uring/bpf-ops.c             | 16 ++++++++++-
 io_uring/io-wq.c               |  6 ++++
 io_uring/io_uring.c            | 50 +++++++++++++++++++++++++++-------
 io_uring/kbuf.c                |  4 ++-
 io_uring/net.c                 | 25 +++++++++++++----
 io_uring/register.c            |  7 +++++
 io_uring/rsrc.c                |  7 +++--
 io_uring/sqpoll.c              | 28 +++++++++++++++----
 io_uring/sqpoll.h              |  3 +-
 io_uring/tctx.c                |  9 ++++--
 io_uring/timeout.c             |  3 ++
 12 files changed, 132 insertions(+), 29 deletions(-)

-- 
2.56.0

