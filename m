Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068146;
	b=XGFLEZ/VWsVanyqAGsCO0D5kiQUik0IbYid+uB7dn7G4EEscWFRBnqnGuaCxIPQdV477
	 MqA7Tia9NFsxFeu7dd3M2EsfxE7rAEg4h+FLqtfHDFxeweZ7aUiLWmpPJ5e7zBtQN7R9l
	 AZ6KCuaGtL8AeHMDjndFSKz40/r9T/ZmcZ0HWI09f63fkJ3aSoYDfgXPYYFhU6JHRZZHu
	 SYLV9AuB4mM6JlN7WMu2GuRIlN5d7Rj9X+iWEylFBelIqeH0DScuQ1ay2jzh7ZTp2MI5e
	 7pcXKOebLqVUv32lj+77NEqxdYIAvSXHDiRP/xa/wZlDZ+DwJWElAPYgewsywegJDYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jTm9q9oITt8HIpZFX8+xiiKxWhAWcjh1wOH1IAth+I0=;
	b=zEsqNuWYAiXQr13dzYgQ1Vzs9qVsog7FGZC1DTbbdhNYRs5rpgs3s9o6CbIj5srMDCGG
	 ozTv2boH5JE3EdR/LOQL9I+XOjtia2uD4ODZ0QgVCs1Vnxk8TRbqUUAsKHRqqZ87lUVTX
	 Y48Nz10AD4aZugoBc1JdVisG40RGhVjbJ9dzAmjQPmPWfKim1BDyIY+mVy7Ts0LHuQ1W/
	 r/M2HWC9chviPAvA/dMgQI0LOpanbSWgnf2v3kHzo3TRI3wRK5ayzGK3jrLUHsxlsZxfj
	 /BZs55jIm0fOwU6gF01pKLG+85uH61tYwwKvNi0o4kHjb34/co7R/zIL+DOI2ssf37A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mmPfnb6m;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC0606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01AC0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mmPfnb6m
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so6522195ad.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068145; x=1794672945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTm9q9oITt8HIpZFX8+xiiKxWhAWcjh1wOH1IAth+I0=;
        b=mmPfnb6muTHJnoUofC6tPzdKZu/g6qJuxU3BAgBcZ46pMJY9bqaSrLq3TIgE+oBQoR
         /18pzDJYW0ue0rH4M1gEWbt2/PhI4dgJu01qrizi38dfsd6G2IdW+OZPPHWzvbr/GlFz
         AjRNU5OrgKatKYbPwJr5VDe/zG968D2Wm7LlC9YgsksztdFo3icHTo1UjcI6r2tnfjXi
         5f5WXiznfF+mTWQIAe+VCxcQY0wBmvXgWjqJM+SysRbSyxsSpdd9BX/g0co8rEYUqqsj
         siEiiGnFoDj3jEyu5lT7yET0cEVQXFDgbGgCZ1yYVOXnXRdDDgQzdEy2mjtlMir20Tm1
         a5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068145; x=1794672945;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTm9q9oITt8HIpZFX8+xiiKxWhAWcjh1wOH1IAth+I0=;
        b=eE/M59Sjo32Z/Xy6QmsbzJkVi9l3v5vJt+by4L6yV+KdIRycTDKJPTihzvuuQ6Ux3f
         MncFxpyRB2qBk8Ee1iJX74ESyJtZ4wPDeWIKX0Un//0Nk6e5t9TMkEVrGCVTO8V9+SZe
         nmWQAkmGZ9Nz8iUN+kvZmTy4++0XQTREYsE1/ypxZEVGP0qjvpFo+e/cUW+GwMjzNW8M
         TSRvtPzWVxBYKgFur7u/lOWkzorZRaVDWIna/8MMNlBC8YzeKnBhCuSPSXIlYtVIGBuW
         8EmeNT5mClcLiLAiM0ThmNzz98GM4eJPhKzDKkvnRyhYSibwXonnGzVhxxMDSS4zagSl
         Iwbg==
X-Gm-Message-State: APuU4Z+3yh8HnYEkGCLG4kj9zCAh0XY8mziF+oD+nq7AsM7VPKmhKZTR
	GXrzoM1LNe1f79E/6tjy9mBcv8eKrPA0XbyKhU2JQXT3rJ4YonfpBIF/SKXtZFtRo2UywLOGO9x
	chT2pcm8=
X-Gm-Gg: AYBFou1ScE++YJc7IF8UN1M3aSVx6Hamv92VXVuRc/Rd2U10teO76Vt+mGy6JxowDi0
	Bh+qic9ajiAUTVynV1AvhFb77TN21vNcfopTxeY7j/sF07nWj9vIM8xshS6r+CC+XMRzsh09BIO
	szB1YhlDOeoZJ9VjPFqO1GXhC4dT52kuKdgzsiL0xThzHQi+2yWgFa6KZlhhJvRA6uph6SBYQpx
	/5WeFQaK9wNoB70DrX8M5BG7zAYqQg19aRj8iwz7n8KI8NBtFlY0n1v5n0fr+DWt4kgIKr+n0II
	f1J8grV6IH/aVS4uucSjcCm9DXk+hi5SQneeDPqT/WJ+ZmXPbkqOpcnL5WsUti7OCuMRkFGb3Oe
	VcZt5qXOXYuyPCjgSNpWqHS9dxwbPCBeyLJFOjpZLOg90/BIf3Rz1zMTBfWKjwhc789pImsh2JB
	seWPzF+noHh1sEuADqCh2EHWNDjnwIuukHrK6zmlfE51tvP7OG+q/HYDKCqr+rCJ4yHBTMQjbUA
	GMOCZhAzK6nUH4G09elCDQyB7E8yAUTbqzW5oHPELv4C+SlnUhMt+PoMv3RvJF7cLRvRRLv4pKS
	OCg8qgQgsXtfy6qpFs8x0wewgDXQQnosMHmuivCnJoY7rRtUuCEMaXwb2EibMN6t2zYag6tt3Eb
	D
X-Received: by 2002:a17:903:37c6:b0:2eb:a1b:e9e5 with SMTP id d9443c01a7336-2ed40e24c49mr61534825ad.52.1794068145145;
        Sat, 07 Nov 2026 08:15:45 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 0/7] io_uring fixes for 6.6-stable
Date: Sat,  7 Nov 2026 09:15:35 -0700
Message-ID: <20261107161542.2500190-1-axboe@kernel.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are io_uring fixes for 6.6-stable. They were waiting on the
io_uring pull for 7.4-rc, which Linus has now merged.

They apply on top of v6.6.162 with the current queue-6.6 applied
(stable-queue 0ae08d01c389). They don't depend on anything in the queue,
and apply to v6.6.162 alone as well.

The io_uring series I sent earlier this week is already in queue-6.6,
these go on top of that.

Please take patches 1-3 together. Patch 2 closes a race that patch 1
opens up, and patch 3 fixes a WARN_ON_ONCE() that patch 2 introduces on
SQPOLL thread exit.

Patches 1, 2, 4, 6 and 7 needed changes to apply to 6.6, the
[axboe: ...] note at the end of each says what was changed.

Chris Mason (1):
  io_uring/cancel: drop sqd->lock while SQPOLL waits

Jens Axboe (3):
  io_uring/sqpoll: don't attach to a thread that is canceling
  io_uring/poll: don't poll a writer for a read side hangup
  io_uring/poll: don't poll a writer for urgent data

Shang En Sim (1):
  io_uring/poll: cancel all matching requests in one pass

Shuai Liu (1):
  io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Yuansheng Yang (1):
  io_uring/rsrc: hold uring_lock across index-alloc put_user

 io_uring/cancel.c   |  3 +-
 io_uring/io_uring.c | 23 +++++++++++++-
 io_uring/poll.c     | 77 +++++++++++++++++++++++++++++++++++++++------
 io_uring/rsrc.c     | 21 ++++++++++---
 io_uring/sqpoll.c   | 14 ++++++++-
 5 files changed, 120 insertions(+), 18 deletions(-)

-- 
2.56.0

