Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296717;
	b=v7/+bw/7qa5EgfGZ56KYUoJWFxdvCP6w5iMpce5VR623lZE+83RRNPKiqIV4Oi/h2uTm
	 +HLtre+Xkw9S2W7Bmu5O1j19406J+cGMh4mkybz7o7lXF8Cg4pygQXLcaPb1pJp39srLT
	 tegPvKKPyXddvp5cjEBv4ymDGGpUJsnk10/1TxKt5fj8iHkBmZvs40nZeF1ilVtNGaDNc
	 AHr8YsqVQJxPbvhYF6tt67U27GXoFnZRIn6NuH/1J/gk0byFX1R3etfdH+hbe/5xL50QM
	 kp0ihzkf6TST5weRRf4rh0c+YuHnAA9qwRPq5Tzysu0vVNOdf/qzPUy+tmObQOje/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PkiVMft/FJgfSsIyHDQhN1tpNcnaj6QFNY+41GhTK3U=;
	b=2hTpAsxQVYsZaA40z62SYf2+XEdUJCFkq3qXyzriULUcWIBG0N+fvSJk7Ay4oFVmg1W7
	 77rqHX1hlfG7i+kgM+wG3c/KRlNpR7VSkI29/L3+GH5dcbx1LsgDblrKGl+n8CQ3vnKsR
	 ixZZgnbhn0/B+xOcf4avEwvEqYTjscshLgQxY2ccKbHtySh55GLd1Mfl888PTSTDk/yrp
	 V7qYlhGacCr8BUMw8Smx1q81NEGjlezRb1mt1Tf7+EXrGJYlD4E8H0I98gOe+CqDZbmFP
	 1ot+t6Xcv8f3yUiudN2r+Akk0GzGGFStWZGkwH2WOInBq3jurAze6UEcr6LL5lrkm3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=r0yylS96;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB7606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24AB7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=r0yylS96
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8479f46ecd8so836299a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296716; x=1795901516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PkiVMft/FJgfSsIyHDQhN1tpNcnaj6QFNY+41GhTK3U=;
        b=r0yylS96sYoXm9WXhmum9+nmz8VfGLvQ7Q4Hikx6Ai6kQ1wUgFQ9rxljtJo85RAazp
         44j/GxLhpXszLwClk4IFJUDgexbkVCqNKAZXO0SEFgOxKai6PVQBSvUf1hhtioa/pqM6
         mI+xp3YuHTxWuqyR390u40+Cx38toOV8OrLk/aSt5Mc8Wb30AzTsCXlDF7VQL/7/WmU6
         XfiqHUgm7+i/hLg0kJTPeYOnBucDY9prpRTBkKKRwU3FAD0yGq/4DGWbrkOETlxe7OKS
         LIc71Mc0lbpvwVlQwpSzqFP3UElgyeNYo/q0p4lRFxrbu2NO/y1TExuup+Xx6LO7gejY
         8/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296716; x=1795901516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PkiVMft/FJgfSsIyHDQhN1tpNcnaj6QFNY+41GhTK3U=;
        b=1ml+/cyQjtldMRaSNry83mVWRZpi9qBeRDDtpcEdMrB5t8bOTaDJOivP+d+qqXi3zQ
         B6owVh/rRvA39mG5pMLdgVByMqaMbbbeii0HAMQIlS7HrwKSlkYUCOvpJsbRmt7mf/7L
         WNpXceMnk7elU3ExXcm1QwHtP63O5gcYPjWIAIjNJvEdeUenXymMJOoLKx28d41ppvpC
         bBVLR+1nLGo743VZCr6dkATtkjEkTucm0xgr78/F7YjSSwXqSrZyWiydUF8MQZGl2jQi
         dJSQUVmQqIsjjbC7IcAHTKt6k28NuGFMlHGMr91d/qwvYCrncu+sH/+sabsBZGvv4QST
         SL2g==
X-Gm-Message-State: APuU4Z/7rpPVuPkbqAIv7c5eo9KzdCRL1Zr9NlKlVxcVU0ezfOPB/NeN
	+2Au2QppVelCRutmmcJgMGmcAv4Z2BGoYbXiSdsJ6RqtTVsMPn4ZxSG/ZxYw7kaT+9xHpngOeOY
	dihtQUUU=
X-Gm-Gg: AZFdTZcS+UKcViIuTFOKYvGT1RjJV2eEnQZZ3l32XtN3IsqS0IvCJa9qREoiOIUTsp/
	dCXEzo8ZXs13fxL4wFZZc18fYSPjVTr0j9YQJ3i0iTHD6d48FnnhdmlCqlkynDykY31zKD6E7qB
	4ADkigpco1iXXTEVLgDT8J/h2y7Dmh1Nd2OCFegiURAgfHwzMg2LqIKoOupjKaN1Lz2nWrG6NLL
	x+dAeHDx9IkVyxbuZmkeP4z6cTn3OaQiJBLqlEcK4ryEEcVcprHKb6MpDiU5xgKj/Snua2zf2a4
	ZdZB0GHo8Bf6GzbzDFSNt7A5n19/dF/JRx0lb3IJTqQZLOgnlz/NLQEe2o4QXpLAZaT0h1k2puB
	71EfOwqvbt0izg33hcJGmlwU6Ve5RF/wPhn3/xLu6BY+4REE0sXD20Wh3VQIk+cwJXC5QTjxK/E
	WUcFNEF44o1vcWeNVgLiedU6nsr5sGHVdikghvey/ewEdMlQiTpNsdg0ISn2gG0t4V3/uPqHcXt
	2iW5VW8r6vQeky3OfmxL7m4fx4Fx2vLsdCN3nJE6R8kMj4a7zCiyeKJ5dolvCfE+R93XbUpg26V
	8fjWwR0fosgCcj05mAPxMcqNk8aiAkX9qXYb/sgNoJEd0EBsc204Rr4n6aGwhImMyLFCFPIHVeZ
	ANsxQDGM+Mp/770G3xduSRZH5hKUkJsHooZxl
X-Received: by 2002:a05:6870:3e07:b0:48f:e137:dc81 with SMTP id 586e51a60fabf-4bc856f64famr6218958fac.58.1795296716110;
        Sat, 21 Nov 2026 13:31:56 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.31.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 0/9] io_uring fixes for 7.3-stable
Date: Sat, 21 Nov 2026 21:31:45 +0000
Message-ID: <20261121213154.1790334-1-axboe@kernel.dk>
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

Here are io_uring fixes for 7.3-stable. All 9 patches are in Linus's
tree. Patches 2-9 came with the io_uring-7.4 pull, merged as commit
78d9aedf2342 (tag io_uring-7.4-20261119); the others were merged
earlier.

They apply on top of v7.3.5 plus queue-7.3 at stable-queue commit
3dd4b2d3c1f7, and also to v7.3.5 alone.

All patches are clean backports.

Testing: ran the liburing-2.15-75-ga10946dc test suite in KVM guests
(PROVE_LOCKING on) on the baseline v7.3.5 kernel and on the patched
kernel, which is v7.3.5 plus these patches and the other io_uring
commits already queued. The patched kernel failed exactly the same tests
as the baseline. The failures that remain are on both kernels (napi-test
timeout, send-zerocopy, timestamp and similar). No new dmesg splat
(WARNING, BUG, lockdep, KASAN, Oops). io_uring/ builds without warnings
on the release plus queue plus patches.

CVE assessment, by the io_uring maintainer:

Should get a CVE:
  5/9 io_uring/io-wq: show stuck workers rather than WARN on a slow exit
      io_wq_exit_workers() did WARN_ON_ONCE() when waiting longer than
      IO_URING_EXIT_WAIT_MAX, reachable by an unprivileged user with an
      open() on a FUSE mount whose server never replies; with
      panic_on_warn that crashes the machine. The diff replaces it with
      a pr_warn() and task dumps.

Should not get a CVE:
  1/9 io_uring/napi: don't end the single NAPI busy poll early on
      need_resched()
      The single NAPI busy poll ended on the first need_resched() and
      slept for the rest of the timeout. Busy poll duration only, a
      performance bug.
  2/9 io_uring: fail soft links on negative IOU_COMPLETE results
      io_issue_sqe() now calls req_set_fail() for negative IOU_COMPLETE
      results, so IOSQE_IO_LINK dependents of a failed request are
      cancelled. This only changes link semantics of the caller's own
      requests.
  3/9 io_uring/futex: fail soft links when cancelling a wait
      __io_futex_cancel() now calls req_set_fail(), so linked requests
      are cancelled. Only the caller's own link chain is affected.
  4/9 io_uring/rw: fail soft links on IOPOLL short or error IO
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
  io_uring/io-wq: show stuck workers rather than WARN on a slow exit

Mikhail Malyshev (1):
  io_uring/io-wq: apply the current cpuset to new workers

Siddharth Chintamaneni (1):
  io_uring/kbuf: initialize arg->out_len from arg->max_len in
    io_buffers_select()

Yang Xiuwei (3):
  io_uring: fail soft links on negative IOU_COMPLETE results
  io_uring/futex: fail soft links when cancelling a wait
  io_uring/rw: fail soft links on IOPOLL short or error IO

 io_uring/futex.c    |  1 +
 io_uring/io-wq.c    | 68 +++++++++++++++++++++++++++++++++++++++------
 io_uring/io_uring.c |  8 ++++--
 io_uring/io_uring.h |  1 +
 io_uring/kbuf.c     |  1 +
 io_uring/napi.c     | 31 ++++++++++-----------
 io_uring/rsrc.c     |  6 ++--
 io_uring/rw.c       |  4 ++-
 io_uring/timeout.c  |  3 +-
 9 files changed, 91 insertions(+), 32 deletions(-)

-- 
2.55.0

