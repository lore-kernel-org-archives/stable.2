Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296701;
	b=4MtMeQUOlQaKNh6PxymE0lFN8mGmMsZEdcDn1mD5637AORxdA2kLLVJMqj+zKNrCoei6
	 XHcE3gQ4uxR1BB/SRvwqnvVQHBzrkZEUNxbcVu3GyIZBu6joXGPLpR6jXbPGHpnI199TV
	 6Ulq97m2CqjRYvwXmSgCZLKDcV+bthIop6PbU9XZvj75txwMUzmC8ASWSyQXGktsN6Lp8
	 2jMTAuwPq24fBl08YF79mCbmCa0kC37O1x15immDl0lmVry7/OhfZaFbkquI3ZkUwoIfb
	 DrizJnDObGP1gvlOC4Vg374y8Vx+H0xiSyv5+Su6PteTQSihh6NTQlaERBKtrXsRrnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PKT+mxLmrmb2TmS90Gp5osdP/9WlzgARq7PBUZyWeGQ=;
	b=rjy6eWYF+nrRV7JILds5Ujs+KI9fAYCizxAL+p0qRqVl+wcxjB+v+6LZQOhXk5JR1rEC
	 5HAlN3VDSQUiykj2Pu4RHlYTs0CiHGREA2hWjseMtgbiIpmDszGDF6+wFnCfC9TPjW5xS
	 oqpnbvdQLx81yIHHFLeev2E6j3hsDBiusNiJ+QW5N9uD1tcFwPZgvnhDS1ht5UDQBIIJO
	 l4n4QVGRHjbu1658HnyjCBjNuJA/AiVWnkQcDYE9856Vb1gvB72rkqYwHMUeDdVOkIOyT
	 5JJjKgLWHdLX5RzxBD2WZe2e2gp9IkiU6807vlX0Fp1fDcG/Vzdke3tMjdaT9ITK/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=TU73ni6z;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C33606A332
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C33606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=TU73ni6z
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6de2f213b7aso909389eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296700; x=1795901500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKT+mxLmrmb2TmS90Gp5osdP/9WlzgARq7PBUZyWeGQ=;
        b=TU73ni6z9JxOlIp/pwXY7JIjZk+zJUo2OD3lox8QJmXYnCIMKABIkoN/pw3ZgcoTx3
         FidaO8AEoh/8TCMmfUylf3EVAOTiuEpbCYz7pIFTuRyQNxEsLVcMFN4UC25Rn5gQMJQw
         cYYGDBUqS2XPcc1G8VLnUei8ciOUbX70UgjgIOaDoCiVP0ILLw8L41AqwQefwQ+/7plo
         th+C+RICut+7QoHS2VQihJtRoQHFi1lwKGIO74xfdjSVJgWwgJpKkTRXGYOJEa8PGpDZ
         VW3O7ebEXetKDXJyLhgdDyRo+Lz9Ob4JnVeuY4MpAQkxAGZUUJoStiRDO2OohqRvhX9R
         DbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296700; x=1795901500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PKT+mxLmrmb2TmS90Gp5osdP/9WlzgARq7PBUZyWeGQ=;
        b=0cPX8A7OemBRvCohkazTh2jwGOkXfJqBVHjaHLiUHlJ4TfO8bbY7Y8/zhZZ07fe29Y
         gFgeW2dStNeJcAOeCWwQJrLvRDPkLSURLPSNicjQCpVwNfFMWiWPYhyJV8soFOOTwRbC
         4VLIFtJ7N3NPrq2Nr5cLMRrx5Cf/sCUCbyVJG5/rFL8VfZl37YoNvtd5H3ut0cFJaoFE
         yfcujpDot35IrDcovInOU/ffZloMn9lwByGAfSfn6kA6LlagS8l4PepruSOofY6fjbIH
         KqCYJ+slR7VpghSQNIf26m8DZ0cnf1aHn2jltRCn6Fjndc2DPH2zHVM3kxBzM326NgzK
         1Utg==
X-Gm-Message-State: APuU4Z/3pC1OLrtGkQdclK1nX405LrbvMFHDtbaUSEjCQevfccq5MC/u
	Nt6/OSLluvyW3z4XY1is5RrQs/Vkps+vLLsaNJYxUlE6d3m494YPeod0z8V8bnzWJdAlmIF/LsR
	3NAK/GL8=
X-Gm-Gg: AZFdTZeA/YcuARFtnLBaw2N5jA5lDg9dTuBxIUbHvAWEu6kKRdPjEcSOm49z8a9zt2B
	048m5hM28BcdCkDaq7dP2j99OAFOH5gMRZQMFaH/6sLB3Oz0gsWhXoPkvStNQWDOdkeSkC/xSGs
	FhzgoU9SB195ab1euRqIb9dgDqJwS5aMMMjnXb5Z8UPNjcwzFjI7McRsPi8VDUw8wfQxp4vnq6r
	W+7Vwr0/8/mhCL0FnpHCjaM7n/JM8fhfvRda/sUeTzoUqqkj/NHHnA69qWS4I1i3TN6zGe+CGeM
	VWMldDVa4el7VVrjMJtbNOId5AuG35I8LwK3nHvjMUKzEKWagA+5goIxNXfdocHJsH5TiKhSOkv
	oQLVlbv2rkReUfoC8vRO8hjQPU3Iz4fVCmx4SttZuKKL7RTx2dBPsu+wIp84Dv2zfxoEH0MzwSx
	JnrfF6TbcnmQ1tcqdY8JsVSLgDn8OF0wO+8lRcw//+L7AmwhxUhP4+2zXfKm08GkgzME1nGiJVt
	6dXo2SNCApiPec8p+B0j6csz609AYHIH/HQIT+yXBYzf19exZ/uCwtG5hrufZLfpHjJVkaof9ie
	C9FFKVdwOX4lPj8P2IF2sOoNSQiXBwYJTWJkfA1oVE7UorNTUrUTe28NeYo8aYV0+ihQ9DTAwy+
	R0LWyTbC7EUGp8LTF629CjTGpl9M1/55H643o
X-Received: by 2002:a05:6820:c7d4:b0:713:e404:7f86 with SMTP id 006d021491bc7-71b3950ebb2mr4176239eaf.54.1795296699882;
        Sat, 21 Nov 2026 13:31:39 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 0/8] io_uring fixes for 6.18-stable
Date: Sat, 21 Nov 2026 21:31:29 +0000
Message-ID: <20261121213137.1789687-1-axboe@kernel.dk>
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

Here are io_uring fixes for 6.18-stable. All 8 patches are in Linus's
tree. Patches 2-8 came with the io_uring-7.4 pull, merged as commit
78d9aedf2342 (tag io_uring-7.4-20261119); the others were merged
earlier.

They apply on top of v6.18.64 plus queue-6.18 at stable-queue commit
3dd4b2d3c1f7, and also to v6.18.64 alone.

Patch 6 needed changes for 6.18; the [axboe: ...] note at the end of
each says what was changed and why. The rest are clean backports.

Testing: ran the liburing-2.15-75-ga10946dc test suite in KVM guests
(PROVE_LOCKING on) on the baseline v6.18.64 kernel and on the patched
kernel, which is v6.18.64 plus these patches and the other io_uring
commits already queued. The patched kernel failed exactly the same tests
as the baseline. The failures that remain are on both kernels (napi-test
timeout, send-zerocopy, timestamp and similar). No new dmesg splat
(WARNING, BUG, lockdep, KASAN, Oops). io_uring/ builds without warnings
on the release plus queue plus patches.

CVE assessment, by the io_uring maintainer:

Should not get a CVE:
  1/8 io_uring/napi: don't end the single NAPI busy poll early on
      need_resched()
      The single NAPI busy poll ended on the first need_resched() and
      slept for the rest of the timeout. Busy poll duration only, a
      performance bug.
  2/8 io_uring: fail soft links on negative IOU_COMPLETE results
      io_issue_sqe() now calls req_set_fail() for negative IOU_COMPLETE
      results, so IOSQE_IO_LINK dependents of a failed request are
      cancelled. This only changes link semantics of the caller's own
      requests.
  3/8 io_uring/futex: fail soft links when cancelling a wait
      __io_futex_cancel() now calls req_set_fail(), so linked requests
      are cancelled. Only the caller's own link chain is affected.
  4/8 io_uring/rw: fail soft links on IOPOLL short or error IO
      The IOPOLL completion path now calls req_set_fail() when the
      result changed, so linked requests are cancelled after a short or
      failed read/write. Only the caller's own link chain is affected.
  5/8 io_uring/timeout: don't rearm a multishot timeout on cancel
      A cancelled multishot timeout was re-armed from the cancel task
      work. A zero interval plus moving the CQ head far ahead only
      delays teardown of the caller's own ring; the loop goes through
      hrtimer and workqueue, so it reschedules and holds no spinlock.
  6/8 io_uring/rsrc: keep the old file when a file update fails
      The old file was dropped from the registered slot before the new
      fd was checked, so a failed update left the slot empty and posted
      its tag CQE. Only the caller's own file table, no refcount or
      lifetime problem.
  7/8 io_uring/kbuf: initialize arg->out_len from arg->max_len in
      io_buffers_select()
      Legacy provided buffers ignored sqe->len and used the full
      buf->len. The copy is still bounded by the length of the buffer
      the app provided, so this is data accounting visible to the app
      only.
  8/8 io_uring/io-wq: apply the current cpuset to new workers
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
 io_uring/io-wq.c    | 44 +++++++++++++++++++++++++++++++++++++++-----
 io_uring/io_uring.c |  8 +++++---
 io_uring/io_uring.h |  1 +
 io_uring/kbuf.c     |  1 +
 io_uring/napi.c     | 31 ++++++++++++++-----------------
 io_uring/rsrc.c     |  7 ++++---
 io_uring/rw.c       |  4 +++-
 io_uring/timeout.c  |  3 ++-
 9 files changed, 70 insertions(+), 30 deletions(-)

-- 
2.55.0

