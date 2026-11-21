Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296653;
	b=5T6aUGjwm5IMF8OFkt3NW3rwRR/xHMWsNuZGanMmtUdPigXfO/7ShyTXUwuXLqBsJ1bq
	 VrYiCZtAjrAmC4x5xCAFazKB/VIOiqKIUzhDVTVhOOLTmqgeFxyrzZoLQcYI6jYrLa0Pe
	 VZoPrXh2MM5UeltGr3nPSOR6IOTWuq/yKQTKxvM5+nscgUOOWw4W1yXEmmbJHuz5zFWX5
	 a+FUfM3j5DEWmLLODXAq7J7JZCJeNrMWdsO6wpapCeN6CxhLIrUj4gW1eKoGqImgF/m/+
	 f1PYFJMQDcDoQT+BCi4vfcCyYpve0zP8jqbTXGzECT8o060suIwuagHr3NOHXBu4KeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xK7n7i7Gv7qQL0jew0OvTh4cbQ6kROFHIVRale/vXuM=;
	b=1yY2VCXXvyAv2ftd21GXK3is0fIcYUPZi9fnz9SVpG7Lq+zihEq5PJ3Q5Kr7C6NfVG41
	 bezMEao7Xs9bZZ9R7b4IPaRF+4emqBAmBFViu2ZGi8o/lx1c7/HC3RRkOEAxlPmzCwl3D
	 nT9YxqazSdaeHiQybzr1Rq/YUtC7oEEDA+A05ksG96Je81l28eieRooBJ+xUviVn/KrST
	 +eIYsJTzY8X3T+vrhCJV0ShfWOrKyMCObvJbhAxrN+fejDCAeyYDhMzUhKsnVOAeFqr0T
	 JEDxV8hzSR8k84DUJ1M4oArrk8TMY6bfUaFBXBxu2DaWqm8Zty0+Pf73gPuYZOKxy2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=KqbDPSu7;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E06606A332
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E06606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=KqbDPSu7
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71ab5e64742so1261610eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296651; x=1795901451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xK7n7i7Gv7qQL0jew0OvTh4cbQ6kROFHIVRale/vXuM=;
        b=KqbDPSu7KNVVzwTBnU8hZKx1sEmkK7Y+dMr0GMJ0okqj/caMjpHNe5ArX0S7aMDke7
         jJGtmAePLG54rxETR1lpFAcCaMh5HG/a+5VgZDJRTT6RBmrnU83RKbdmgRq67DvUtObS
         KCbJtv7zVboqvT3F2z1YerA9DNy1rS9aBPFfm0u1f1xii6uQd1ZihUa7iiZJC/oSP3Ha
         5pxOTgGcdsm3IuclPhoAp6zEjTmJn4lEzQ+aVOuf2L+JzPgQcfd6DMDD8An6dOiVLctY
         p1QSZj2XtMg8v+1uw68m/b+J5ZN/pes8YCIuTgNTM+ulhWX/6G3DPQUWJHbFNF3M/URN
         B90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296651; x=1795901451;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xK7n7i7Gv7qQL0jew0OvTh4cbQ6kROFHIVRale/vXuM=;
        b=wwo8UW5Ol1SG66YSNP4TpsJj8aBTYpNQc+Pu5mXbNUZX/PjNUTO+jRArpcz+VFosDZ
         eFFKZIxw1DZ3nfLbTv1sCUZi9WQnKS8RY9XT7NzTyxiaR9KckcCox/y6jps+A3bOpnTT
         d6Q1j7R0J+aoFOSz0ll9zLduyBrhCfuzzkcnwO0SXdsxb0GxR92jtoGBTpR4spkMex3n
         Nki22omkKGyuTkcbYVVpo7h8ln1xLXO+zrRPogYYap1LcNvctGEltGwgsTXQOtON7WO5
         e5kwONs7CGZo8OimJApAz5Bxe5fAP1ljjTWi5AMjar08vm2WVaylGFMxSmuzjO/XnIuI
         qnyA==
X-Gm-Message-State: APuU4Z9jdd5wFWXOi9MsFoT2Mt57AJpp+NWQGY19SUEE5As9OAg4KAsJ
	g+6S5qxDwYrl9ASq5yOk9CHyfIiqrNOXt9T/BbW4e1+Wnem4/f+EOz53yow9/h0nR242oRqlSbT
	i9pr3uNw=
X-Gm-Gg: AZFdTZcNTs81MK848osHZzDdRGICelBLnMeSlGbq/8KmSGUbtdjUQHXVfAG6AEvowLw
	ch3rqQUqLY4co8/BQn+gTL7qKswc85c9xukLu0XWsLv716h8mKSGwxfEAc+oAVHhiMM9vfh/JEX
	5dypTpcdnfzFq4BhFcE3yxcoaCDa4l/qneCdyHTLQLL0Kgmzw/li/GW1ZFMfAqtax2TRcaU2fkL
	HWZu76+aUp4byy6vCsvrVE8l2trkcFuMGyuRfPSNwzjNRUdRnxbl2vBm86jr38RCx7+hn+KhhEP
	vWoWv4mAEsAlSylenJdcYSTEUiXWEUpJkaS9zlvXrnFk+j7jI3thn+kuGMee0nDSnI5rxpDihsO
	VQGcn9DRemfsxPx8kEQj3ju+pQQxAk3ZdQ9cUxK9vvMfVo399PpJtsFHcIDfm0a2MPsvLpe4L0i
	HYUEjgC8dsIfIRP8NgXa83iVLEOmeipyjJHVQ8QkjrTt7BRItrc8a4pj4PhmlpmzCNegoLm2yZ3
	yThiqX6LusyxmiujcTs6Q1TvkFiuLJy/iDQ8Bos8YBMF926ZKDWQRCN6zjoRE5TTksuYI9aYs9F
	1uCJu+NEwMu1jpNRzsr1Wf1gLmQIzoTr6Od4uBqaTm5FU3Et0AUN1wGg6r2ZiAAKdERGbA7LPbB
	cPmafcWlqHd7cXbgtbG9Rkfc5ANx6+OG3opo0
X-Received: by 2002:a05:6820:612:b0:71a:eb23:a7da with SMTP id 006d021491bc7-71b39521213mr6191032eaf.31.1795296651558;
        Sat, 21 Nov 2026 13:30:51 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 00/19] io_uring fixes for 6.6-stable
Date: Sat, 21 Nov 2026 21:30:30 +0000
Message-ID: <20261121213049.1788332-1-axboe@kernel.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are io_uring fixes for 6.6-stable. All 19 patches are in Linus's
tree. Patches 2-5 came with the io_uring-7.4 pull, merged as commit
78d9aedf2342 (tag io_uring-7.4-20261119); the others were merged
earlier.

They apply on top of v6.6.162 plus queue-6.6 at stable-queue commit
3dd4b2d3c1f7. They do not apply to v6.6.162 alone: patches 1-7 do, but
8/19 depends on the queued io_uring sqpoll patches.

Patches 1-8, 11, 15 and 18 needed changes for 6.6; the [axboe: ...] note
at the end of each says what was changed and why. The rest are clean
backports.

Please take patches 6-19 together: they are the SQPOLL private task_work
handling from 6.9 (8/19, with 6/19 and 7/19 as prep) and the fixes that
followed it upstream, whose Fixes: tags name it. Patches 1-5 are
independent of that group.

Patch 1/19 (io_uring: enable toggle of iowait usage when waiting on
CQEs) is a feature, not a fix. It is in stable because the QEMU
developers asked for it: QEMU uses IORING_ENTER_NO_IOWAIT and wants it
supported on all current stable kernels. Nothing changes unless the flag
is set.

Testing: ran the liburing-2.15-75-ga10946dc test suite in KVM guests
(PROVE_LOCKING on) on the baseline v6.6.162 kernel and on the patched
kernel, which is v6.6.162 plus these patches and the other io_uring
commits already queued. The patched kernel failed the same tests as the
baseline, except connect-backlog, which failed only on the baseline (a
flaky test). The failures that remain are on both kernels (napi-test
timeout, send-zerocopy, timestamp and similar). No new dmesg splat
(WARNING, BUG, lockdep, KASAN, Oops). io_uring/ builds without warnings
on the release plus queue plus patches.

CVE assessment, by the io_uring maintainer:

Should not get a CVE:
  1/19 io_uring: enable toggle of iowait usage when waiting on CQEs
      Feature, not a fix. IORING_ENTER_NO_IOWAIT only skips setting
      in_iowait; nothing changes unless the flag is set.
  2/19 io_uring: fail soft links on negative IOU_COMPLETE results
      io_issue_sqe() now calls req_set_fail() for negative IOU_COMPLETE
      results, so IOSQE_IO_LINK dependents of a failed request are
      cancelled. This only changes link semantics of the caller's own
      requests.
  3/19 io_uring/rw: fail soft links on IOPOLL short or error IO
      The IOPOLL completion path now calls req_set_fail() when the
      result changed, so linked requests are cancelled after a short or
      failed read/write. Only the caller's own link chain is affected.
  4/19 io_uring/timeout: don't rearm a multishot timeout on cancel
      A cancelled multishot timeout was re-armed from the cancel task
      work. A zero interval plus moving the CQ head far ahead only
      delays teardown of the caller's own ring; the loop goes through
      hrtimer and workqueue, so it reschedules and holds no spinlock.
  5/19 io_uring/rsrc: keep the old file when a file update fails
      The old file was dropped from the registered slot before the new
      fd was checked, so a failed update left the slot empty and posted
      its tag CQE. Only the caller's own file table, no refcount or
      lifetime problem.
  6/19 io_uring: cleanup handle_tw_list() calling convention
      prep for 8/19 (handle_tw_list() calling convention).
  7/19 io_uring: pass in counter to handle_tw_list() rather than return
      it
      prep for 8/19 (handle_tw_list() counter).
  8/19 io_uring/sqpoll: manage task_work privately
      Rework, not a fix: SQPOLL runs its own task_work list. Prep for
      the follow-up fixes 9-19, which are fixes for this patch.
  9/19 io_uring: wake SQPOLL task when task_work is added to an empty
      queue
      Fixes a stall introduced by 8/19; 6.6 releases don't have it.
      Missed wakeup.
  10/19 io_uring/sqpoll: use the correct check for pending task_work
      Fixes 8/19: wrong pending check, a stall. Not present in any 6.6
      release.
  11/19 io_uring/sqpoll: early exit thread if task_context wasn't
      allocated
      Fixes 8/19 (a missing tctx early exit). Part of the same rework,
      no 6.6 release has the bug.
  12/19 io_uring/sqpoll: ensure that normal task_work is also run timely
      Fixes 8/19: normal task_work not run timely, a latency bug.
  13/19 io_uring: signal SQPOLL task_work with TWA_SIGNAL_NO_IPI
      Fixes 8/19: signal method for SQPOLL task_work, a latency bug.
  14/19 io_uring/sqpoll: ensure task state is TASK_RUNNING when running
      task_work
      Fixes a might_sleep WARN that 8/19 introduces; the old 6.6 code
      ran task_work through io_run_task_work() and never had it. Not in
      any 6.6 release.
  15/19 io_uring: don't touch sqd->thread off tw add
      Fixes 9/19: a theoretical sqd->thread reload, the author says
      unlikely.
  16/19 io_uring/sqpoll: zero sqd->thread on tctx errors
      KASAN UAF in fdinfo, but only with fault injection and only on the
      early exit added by 11/19; no 6.6 release has it.
  17/19 io_uring/sqpoll: Increase task_work submission batch size
      Batch size tuning for 8/19, performance.
  18/19 io_uring: fix task_work add use-after-free with SQPOLL MIME-
      Version: 1.0 Content-Type: text/plain; charset=UTF-8 Content-
      Transfer-Encoding: 8bit
      KASAN UAF in the task_work add, but only through the private
      SQPOLL list added by 8/19; no 6.6 release has it.
  19/19 io_uring/sqpoll: do the return-to-userspace work in the SQPOLL
      thread
      Fixes 8/19: memory.high reclaim not done in the SQPOLL thread,
      accounting/throttling only.

Cheng Yongkang (2):
  io_uring/timeout: don't rearm a multishot timeout on cancel
  io_uring/rsrc: keep the old file when a file update fails

Gabriel Krisman Bertazi (1):
  io_uring/sqpoll: Increase task_work submission batch size

Jens Axboe (11):
  io_uring: enable toggle of iowait usage when waiting on CQEs
  io_uring: cleanup handle_tw_list() calling convention
  io_uring: pass in counter to handle_tw_list() rather than return it
  io_uring/sqpoll: manage task_work privately
  io_uring: wake SQPOLL task when task_work is added to an empty queue
  io_uring/sqpoll: use the correct check for pending task_work
  io_uring/sqpoll: early exit thread if task_context wasn't allocated
  io_uring/sqpoll: ensure that normal task_work is also run timely
  io_uring: signal SQPOLL task_work with TWA_SIGNAL_NO_IPI
  io_uring/sqpoll: ensure task state is TASK_RUNNING when running
    task_work
  io_uring: fix task_work add use-after-free with SQPOLL

Pavel Begunkov (2):
  io_uring: don't touch sqd->thread off tw add
  io_uring/sqpoll: zero sqd->thread on tctx errors

Shakeel Butt (1):
  io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread

Yang Xiuwei (2):
  io_uring: fail soft links on negative IOU_COMPLETE results
  io_uring/rw: fail soft links on IOPOLL short or error IO

 include/uapi/linux/io_uring.h |   2 +
 io_uring/io_uring.c           | 104 ++++++++++++++++++++++------------
 io_uring/io_uring.h           |  25 ++++++--
 io_uring/rsrc.c               |  25 ++++----
 io_uring/rw.c                 |   1 +
 io_uring/sqpoll.c             |  62 +++++++++++++++++++-
 io_uring/timeout.c            |   8 ++-
 7 files changed, 168 insertions(+), 59 deletions(-)

-- 
2.55.0

