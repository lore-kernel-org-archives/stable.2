Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296684;
	b=3P5Rq89BNKB/cBSmpI7celkAXE0XQAt8j0vOHPTSwPLpVeyZdHRmTH3mlIoXVolUa1cv
	 AC72L16lvVPfqiGIH+jNNl2lsU+qiTNjYKt3ZZwDYDSwSWBfOlRGtw1i9fWARIIAMM9kL
	 xuQnep0s73POofCiLTKvgwnfjn59/EHsMRH9W+dNThkhwcHwlvEwikLpR7zfihsQSBlFf
	 UA0wOPqXbcRbjwPa7w5KvzG6gUvtyWkzubx/kEwsCoF9HpbuwjY23VdTgIAj97uMuRdOo
	 OOKkb5EMv5Rp8T6oABCkNtpT3KVBJ/HW20+Y8NKHQt6dUgcKYdjjk0Jx9mKv0x11wDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=H5/GfQIvQW91+SewK3v9bmx10ipmKdbvggx80FKBcJY=;
	b=4xUBz1fOqbF4SOydB0zdFEyeq4nJ//mDioFW2jXhZcqT1f9jj1wsgvtb6Xyh6bPQoMer
	 e6TntL32XT+M1y4YFMVmL6ZzzyydnUoWL9YREM+hZ7TYIa9RlpPeYCYH/fpCUfYYGC+lP
	 RQQZWLbUIlLN/9k/2dWF3ZwcwjKb15wLfO5kAWI5KG4cG/Yt/8HPXKm6sQ5e5An5R5Q3a
	 C7pIxa8b18UgLahWXcU4gq4SLhwKn58XVG10E59ZGU1LRFPuHNNQyLYn3g1qFcb2eSi8u
	 /iqtIAgLmLRMozopnnmwxe+/9rgB6MItoHYPFkKc5LVhjwZIMOAW3NnTZ1vyDnoM3tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="j/nR9zqN";
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7E606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F7E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=j/nR9zqN
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-86288992de5so1628924a34.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296683; x=1795901483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5/GfQIvQW91+SewK3v9bmx10ipmKdbvggx80FKBcJY=;
        b=j/nR9zqNTIKeA84oTV866B/MXTreMq8wN7JBrwMWl+e3aii2mcbSzxfCbXMyfOluZ7
         aiJT5O46u8zGPgdt1WrLqcZDTf39Hfm2GR3zxR09s8yNH7fKvd5FZO9lOkMwoq5vJyZ+
         jSzWJfWiGMvjamDcpE7m1PYfxokiy2p59ArKAJiN88sWKtBAbWmtd3DW132M4nPqgKTM
         kT2P69wb468OG+cUNpE9ZGoTLMQJ7GBgg5WzqbM/80vGkh7KHD7WYpUH0L0695VbacYa
         6M8vOUOFE0F0WiYmEEXbKYAiRGWRCAl3DUkNDCJIpww7Cg1qI4uAcYVUACmX/ZMImxVC
         Nbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296683; x=1795901483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H5/GfQIvQW91+SewK3v9bmx10ipmKdbvggx80FKBcJY=;
        b=VFRp65spk8qwYKxX/1JU1tC59F5nhuPcO29oF3VF4nqcMENiXio5dp64yNRE2NJ6Kf
         UGuJjKqcpxb3fDHs8iedp4pnAgS+LEWdjVxusC1M7QsxXDKzkk8/PJLPKgDwHfjT9Tgl
         XZvIJ+8A5ZDtIplo3OJYxPo8Y0dsv7ny4Mu5VSt44TQKOIecuJXR3Acvh2MYT5yw+ao7
         4TEane9sOuyN2ZZHOc4rRxrJ/G8ozsr3+L1ljiMyjV90q4vRJoMEAzBx3tbvV6gkvJ7o
         K0Cytv15lUxnubMhqDIoVnl/MGAkkIPpl1YTS2fSHY2ZCOKDdNGhRu9MVUgXjiytFPB7
         indA==
X-Gm-Message-State: APuU4Z+0RrhdCCDeFWTF+mWZu0qquWOaecnvzL5IoVobEjZ6y+WN8wmm
	AoleJ8iATwz+wRE4s5H3z53LkNonPyqsodW8bbirsNWg4rPcddKHEUAwIxIr0f2JpOSvHfAyffr
	L7HoFS34=
X-Gm-Gg: AZFdTZd6BnNvIYtIC65iMc4qjUJCc6MZ+vIq+O8STShRn5q7wfe2P9TsQv0H/Vz6s9I
	mtqPCjMPqYa3DiRisWZptQG09v0J/ggE82Y7oZm2Ml5tGVjZ3lhrR6X2dGS2OrwjxbgcSrWheOh
	EVf0EQOJUxGr0CKbpzPsuPx/eW5cGEME3Rm0JBDdU2wXg3tSFUd8+nW7ISOkov40qsWOFoWZYDP
	wB11VuFWe4O2efrmCNu+ODWk5S6FHyTjCfE9FJcHqWqIjQIxeiu+LEgSttZD5qcFO6fm61n8huP
	ESHSx2jjHgZr6s5ZUxMxtotaZgKEUhXEmWzrfvR1zvuNnuVLVxhq906fUZdzxyQrrCTRTicCGIz
	b97TBylPi/+qlhEdtd9fX+5mlbu5oHigZ/kszO9eJcnGaY/hGm0Gv3vUfbkRjZmFPAmWDor+TBy
	cD45vYnSQizHTY1N5zsiGPpYs9HSBlBylQkWvGBdBhR6e/OI8dV/hMenZSZ1JgiJB0oZ/wV1QRN
	bfkObgCfHT7x7jMJoLjd2mXA+pgitc4Cvl6hAG1yYtgihYfEOwIMIMBxOAzHCGPEb1XdhBbnxB5
	THvHqJhKJoatlHSxLk1gsnVB0c1Y/EP459DjpyK4NlzBalQ4qVkQ3Uv3ybbzaysawweJsOHtzvU
	cBLBpz0/n46OLnWDjvaM9d+E+xEZgLxzIuHTBUA==
X-Received: by 2002:a05:6830:2543:b0:847:b333:229f with SMTP id 46e09a7af769-86309211342mr7202785a34.19.1795296683194;
        Sat, 21 Nov 2026 13:31:23 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/9] io_uring fixes for 6.12-stable
Date: Sat, 21 Nov 2026 21:31:12 +0000
Message-ID: <20261121213121.1789042-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
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

Here are io_uring fixes for 6.12-stable. All 9 patches are in Linus's
tree. Patches 3-9 came with the io_uring-7.4 pull, merged as commit
78d9aedf2342 (tag io_uring-7.4-20261119); the others were merged
earlier.

They apply on top of v6.12.118 plus queue-6.12 at stable-queue commit
3dd4b2d3c1f7, and also to v6.12.118 alone.

Patches 1, 3 and 6-7 needed changes for 6.12; the [axboe: ...] note at
the end of each says what was changed and why. The rest are clean
backports.

Patch 1/9 (io_uring: enable toggle of iowait usage when waiting on CQEs)
is a feature, not a fix. It is in stable because the QEMU developers
asked for it: QEMU uses IORING_ENTER_NO_IOWAIT and wants it supported on
all current stable kernels. Nothing changes unless the flag is set.

Testing: ran the liburing-2.15-75-ga10946dc test suite in KVM guests
(PROVE_LOCKING on) on the baseline v6.12.118 kernel and on the patched
kernel, which is v6.12.118 plus these patches and the other io_uring
commits already queued. The patched kernel failed exactly the same tests
as the baseline. The failures that remain are on both kernels (napi-test
timeout, send-zerocopy, timestamp and similar). No new dmesg splat
(WARNING, BUG, lockdep, KASAN, Oops). io_uring/ builds without warnings
on the release plus queue plus patches.

CVE assessment, by the io_uring maintainer:

Should not get a CVE:
  1/9 io_uring: enable toggle of iowait usage when waiting on CQEs
      Feature, not a fix. IORING_ENTER_NO_IOWAIT only skips setting
      in_iowait; nothing changes unless the flag is set.
  2/9 io_uring/napi: don't end the single NAPI busy poll early on
      need_resched()
      The single NAPI busy poll ended on the first need_resched() and
      slept for the rest of the timeout. Busy poll duration only, a
      performance bug.
  3/9 io_uring: fail soft links on negative IOU_COMPLETE results
      io_issue_sqe() now calls req_set_fail() for negative IOU_COMPLETE
      results, so IOSQE_IO_LINK dependents of a failed request are
      cancelled. This only changes link semantics of the caller's own
      requests.
  4/9 io_uring/futex: fail soft links when cancelling a wait
      __io_futex_cancel() now calls req_set_fail(), so linked requests
      are cancelled. Only the caller's own link chain is affected.
  5/9 io_uring/rw: fail soft links on IOPOLL short or error IO
      The IOPOLL completion path now calls req_set_fail() when the
      result changed, so linked requests are cancelled after a short or
      failed read/write. Only the caller's own link chain is affected.
  6/9 io_uring/timeout: don't rearm a multishot timeout on cancel
      A cancelled multishot timeout was re-armed from the cancel task
      work. A zero interval plus moving the CQ head far ahead only
      delays teardown of the caller's own ring; the loop goes through
      hrtimer and workqueue, so it reschedules and holds no spinlock.
  7/9 io_uring/rsrc: keep the old file when a file update fails
      The old file was dropped from the registered slot before the new
      fd was checked, so a failed update left the slot empty and posted
      its tag CQE. Only the caller's own file table, no refcount or
      lifetime problem.
  8/9 io_uring/kbuf: initialize arg->out_len from arg->max_len in
      io_buffers_select()
      Legacy provided buffers ignored sqe->len and used the full
      buf->len. The copy is still bounded by the length of the buffer
      the app provided, so this is data accounting visible to the app
      only.
  9/9 io_uring/io-wq: apply the current cpuset to new workers
      New io-wq workers took a stale copy of the cpuset, so they could
      run on CPUs the cgroup no longer has. cpuset is a CPU placement
      control, not a privilege boundary; the worst case is scheduling
      interference.

Cheng Yongkang (2):
  io_uring/timeout: don't rearm a multishot timeout on cancel
  io_uring/rsrc: keep the old file when a file update fails

Cinq Prairie (1):
  io_uring/napi: don't end the single NAPI busy poll early on
    need_resched()

Jens Axboe (1):
  io_uring: enable toggle of iowait usage when waiting on CQEs

Mikhail Malyshev (1):
  io_uring/io-wq: apply the current cpuset to new workers

Siddharth Chintamaneni (1):
  io_uring/kbuf: initialize arg->out_len from arg->max_len in
    io_buffers_select()

Yang Xiuwei (3):
  io_uring: fail soft links on negative IOU_COMPLETE results
  io_uring/futex: fail soft links when cancelling a wait
  io_uring/rw: fail soft links on IOPOLL short or error IO

 include/uapi/linux/io_uring.h |  2 ++
 io_uring/futex.c              |  1 +
 io_uring/io-wq.c              | 44 +++++++++++++++++++++++++++++++----
 io_uring/io_uring.c           | 39 +++++++++++++++++++------------
 io_uring/io_uring.h           |  1 +
 io_uring/kbuf.c               |  1 +
 io_uring/napi.c               | 31 +++++++++++-------------
 io_uring/rsrc.c               | 25 ++++++++++++--------
 io_uring/rw.c                 |  4 +++-
 io_uring/timeout.c            |  3 ++-
 10 files changed, 102 insertions(+), 49 deletions(-)

-- 
2.55.0

