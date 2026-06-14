Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB26307481
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456331; cv=none; b=uZvEGe3nT6JPS2uXIhfwo6y99m8QkY6Nayw/foAPsf946IThSjO0yFanwR18KoAV6j1B8x4i1pEMwgmQ/qs5WYuV3WvxxRZxFsXXtpOp+ejDMjJxKbRE6PLhaa7RBYv6Agkz0YzchdUCgCglo0ld9I4x+TkoHT64Z/W4u8H/+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456331; c=relaxed/simple;
	bh=7IdpY+k79B2YWJ0CnSLw1j3KS2sj8jUBaBz9rtQMWbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1wOvkDsG/DHHr7IK0bDijvaegpT8/ef64GTvBMapsCEIusSUKst1qGDKTIvuyJLB1T7slXGV3H+NIMiq5KPK93y6AfRmB56UJXQmJhfmXD1AiQ7LnF1zEjQmEq4n3mt9VBdjKJLhX9QQThqytdDCHxXcwTx9GPd8YopDK0880U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtA8T52z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtA8T52z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so15835455ad.1
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781456329; x=1782061129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Bwa8OE8aYBzyp2EbWsiox6q4n51csJQ5PupXYRyz4=;
        b=AtA8T52zX+u9rl054YgX1dT7TMEVomrJ4e/9/2zqsw/FH5+qeBpxoKCux5gBNRNUEQ
         kGvOfw7sEB4CXLFRHTMxhX+jJLyFcI8MLiN8ALZhPwJhbe57ygp93DIY0zrMxHCI51he
         l8zAqWnYRhWHPwzwSy9rTuc5TNlLXNV2zlw6IptcDMdV281qknM0/3EDN+/x3p5qU11q
         GxIGJ/WbdmLxXAkuQ64E2u5jFhUmEdjUoxi6YOl0XwQRsMyZoCzZtGB85oF231P0eYGE
         IXpO5zhurVHzvpCWljxPfdITlTMfm/rfmhvp5qu2hLSRb8ujFjKL3mHXrEm3GQb+Frp+
         UTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781456329; x=1782061129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Bwa8OE8aYBzyp2EbWsiox6q4n51csJQ5PupXYRyz4=;
        b=HYM94XAk3DMR/bG21kaVqCmTyGSMhRus+FREzFnNQBzfyVH39xTise8uEbl708i/La
         HAy7QRngNhdznl67+ZTJNWDlUx8Xf0l/lPRWQjetaY1aX9w20LiN3BYVoCbPQHGAhS1a
         3PFUdT/Eb3XbFxe9dImWT1wD2NyxHLji+igCgV6vvVJiTcVUQ8YEdogLH1scRJzuVcDy
         Ym0dMLF6W2HDWrdoaMWpf/OSbFGarS5XFBxfE9vRYOwq0NCmUkmOrE2Hc61M1kCq7CsK
         +w9Jm3nNCVcZMvHR81ggsyb867fAOR0Mzt7oSGnHMnWnc0SXCglhAVxqG8gJ6fZh/LEH
         GUCg==
X-Forwarded-Encrypted: i=1; AFNElJ/idq9EVhIXJ0Bqgtxf2C6/s35GbgCR/Lp6TV0mIKCw3ZQ1H5i7itUxHQ8tIxIEfXVQ5UT8Swc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfVjTRjF8Y8EI18zNeJB4YCwVIzchDkJBEUH44o0N02TMfaIE
	0Zi/93YOKjiwCho+buxkZoYvO0eSzpUtxDYdhrvjUoXUIw47//OneDXU
X-Gm-Gg: Acq92OFaJWGbJNACxx+MzCWz6Mi3d/ZahAVWqES7DbWJhrZ15TlXnAi8CGxbhaDPfUK
	D7mhW4kakYpHrAynQDO73prMhXFTmEnIeZIdbdh1hITOcHERtpj/sCDIHByDma0MwQzA3q+YZN9
	+Uh9I1sSii0pH1z7HaELnjSAInn+Cra+GbHaEs3vxNsKYa2sQPI7kZLwcY3EiI8Nf8WuvcGmgmn
	6WBP0aH7Jo9Bq1hoItE8Spc+GGtNwwFwymBmHXZuo469cqLv0VbzT2Kx7mAzKTOIkTKKKxltp+5
	KIsaBoCAtkvX3GzDV1lt9U9mKtKx+pWGih3JdZvdpuNUsRpF/8gifeV2L1hbYxop/CS6ZHIsa1p
	DacOyol6e5VtQdbxW+Om6djOE36m5cB5RXEq5pK2YeCH7VS+cSstrixQ5uvp0vH1/h77S/yBEOG
	HDcES7yGOItZgmxdjcyTL6zLxiamD9vCQ=
X-Received: by 2002:a17:903:198e:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2c412b30fabmr116699975ad.37.1781456329262;
        Sun, 14 Jun 2026 09:58:49 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm74457405ad.36.2026.06.14.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:58:48 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Date: Mon, 15 Jun 2026 00:58:37 +0800
Message-ID: <cover.1781194510.git.jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This v3 targets 6.6.y and changes the backport strategy based on review
feedback on v2.

The original observed failure was found in Rust/Aya-generated eBPF
around helper calls. Rust match lowering can keep a helper return value
and a scalar filled through a by-reference helper argument in the same
enum-style control flow. That makes it easy for the verifier-visible
scalar values to become linked by scalar id.

The relevant verifier-log bytecode from the original reproducer is
below. The later instructions only store r7 into a map so user space can
observe which branch the verifier kept.

  15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
  16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
  17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
  18: (bf) r7 = r0                    ; R0=scalar(id=1) R7=scalar(id=1)
  19: (55) if r0 != 0x0 goto pc+6       ; R0=0
  20: (67) r7 <<= 32                    ; R7_w=0
  21: (77) r7 >>= 32                    ; R7_w=0
  22: (b7) r1 = 1                       ; R1_w=1
  23: (55) if r7 != 0xf goto pc+1

The important verifier state shape is:

  1. The program checks "if r0 == 0". The jump target is the success
     path, and the fallthrough path is the failure path.

  2. On the failure path, "r7 = r0" gives r0 and r7 the same scalar id.
     The real success path skips that assignment, so r7 is independent
     there.

  3. At the later "if r0 != 0" check, an affected verifier can explore
     an impossible continuation where r0 is zero and r7 is narrowed
     through the shared scalar id as well.

  4. That impossible continuation reaches the return-value comparison
     with the wrong r7 value. When the real success path is analyzed
     later, state pruning can consider it safe against the earlier
     cached verifier state and skip the real continuation.

The root cause is verifier scalar state tracking, not helper-specific
behavior. A helper return value in r0 and another scalar can become
linked by scalar id on one branch. The real success path can skip that
assignment, so the two verifier states are not equivalent.

The relevant pruning point is that regsafe()/states_equal() accepted
the real success-path state against an earlier cached state where r0 was
an imprecise scalar and r7 constraints were loose enough to cover the
current r7. In the impossible path, r0 and r7 are linked by scalar id
after instruction 18. In the real success path, instruction 18 is
skipped and that scalar-id relationship does not exist. These states
should therefore not be treated as equivalent for pruning.

The upstream linked-scalar precision series fixes that root cause by
recording, in jmp_history, which linked registers were synchronized at
each conditional jump and by using that per-instruction history during
precision backtracking. This covers both the original r0 == 0 /
r0 != 0 shape and the r0 == 1 / r0 != 1 shape used by the separate
runtime selftest.

A Rust/Aya-specific runtime reproducer/selftest discussed in the v2
thread has been submitted separately to bpf-next for review:

  https://lore.kernel.org/bpf/20260611160749.391279-1-jt26wzz@gmail.com/

That reproducer keeps the same helper-return/control-flow shape but
shifts the success value to 1 before branching. This avoids depending
on the not-equal-zero refinement and exercises linked scalar precision
during state pruning directly. It uses bpf_skb_load_bytes() in the
normal tc test-run path and does not require fexit attach or
bpf_get_func_ret(). It is not included in this stable series because
per review feedback it should go through bpf-next first before being
considered for stable.

Targeted results for that separate helper-status runtime reproducer are:

  v6.6.142 + reproducer:                                  FAIL
  v6.6.142 + v2 d028/9e backport path + reproducer:      FAIL
  v6.6.142 + this linked-scalars series + reproducer:    PASS
  bpf-next + reproducer:                                  PASS

Changes since v2:
  - update the subject from the v2 not-equal title to reflect the
    linked-scalar precision backport used in this version;
  - replace the d028f87517d6/9e314f5d8682 backport path with the full
    upstream linked-scalar precision-tracking series suggested during
    review;
  - drop the custom Rust/Aya selftest from the stable series and point
    to the separate bpf-next review instead;
  - adapt the linked_regs_broken_link_2 selftest log expectations for
    6.6.y, where the verifier does not derive the same non-constant
    JMP_X scalar-vs-scalar range used by the upstream log check;
  - keep 6.6.y as the first stable target and document that older LTS
    trees need separate adaptations.

v2:
  https://lore.kernel.org/r/20260607170959.823755-1-jt26wzz@gmail.com/

RFC v1:
  https://lore.kernel.org/r/20260601180400.1381736-1-jt26wzz@gmail.com/

Backport details:

This series is based on v6.6.142 / stable/linux-6.6.y commit
924b4a879cbb ("Linux 6.6.142"). I would like it applied to 6.6.y first.
The same issue is reproducible on 6.1.y, 5.15.y, and 5.10.y, but those
trees need separate older-layout adaptations.

Instead of backporting the d028f87517d6 not-equal refinement plus the
9e314f5d8682 range-combining prerequisite, this series backports the
full upstream linked-scalar precision-tracking series:

  4bf79f9be434
    bpf: Track equal scalars history on per-instruction level
  842edb5507a1
    bpf: Remove mark_precise_scalar_ids()
  bebc17b1c03b
    selftests/bpf: Tests for per-insn sync_linked_regs() precision
    tracking
  cfbf25481d6d
    selftests/bpf: Update comments find_equal_scalars->sync_linked_regs

Upstream series:
  https://lore.kernel.org/r/20240718202357.1746514-1-eddyz87@gmail.com/

Patches 1 and 2 are the verifier changes from that upstream series. The
main 6.6.y-specific verifier adaptation is in patch 1: 6.6.y does not
yet have the newer BPF_ADD_CONST scalar-id representation, so
sync_linked_regs() is adapted to the older scalar-id layout. Patch 2
then follows on top of that adapted layout.

Patches 3 and 4 bring the upstream verifier selftests and comment
updates. Patch 3 has one 6.6.y-specific log adaptation:
linked_regs_broken_link_2 keeps the "div by zero" reject check, but
drops the upstream mark_precise log expectations because 6.6.y does not
derive the scalar-vs-scalar range for that non-constant JMP_X
comparison. Patch 4 only updates the two pre-existing comments that are
present in 6.6.y.

Relevant QEMU selftest results on 6.6.y with this backport:

  verifier_scalar_ids passed all 18 subtests, including the newly
  backported linked-scalar precision tests and the related
  check_ids_in_regsafe tests.

Thanks to Shung-Hsi Yu for reviewing v2 and suggesting the upstream
linked-scalar precision series as the preferred backport direction.

Eduard Zingerman (4):
  bpf: Track equal scalars history on per-instruction level
  bpf: Remove mark_precise_scalar_ids()
  selftests/bpf: Tests for per-insn sync_linked_regs() precision
    tracking
  selftests/bpf: Update comments find_equal_scalars->sync_linked_regs

 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/verifier.c                         | 367 +++++++++++-------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 253 ++++++++----
 .../selftests/bpf/progs/verifier_spill_fill.c |   4 +-
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |   2 +-
 6 files changed, 417 insertions(+), 215 deletions(-)


base-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4
-- 
2.43.0
