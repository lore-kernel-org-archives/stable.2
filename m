Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A413793DF;
	Sat, 29 Aug 2026 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999201; cv=none; b=ghAAQR7yMUm3VZtsbz91avmJ5QibC0iF9c7hO0oES2KQGLla06tfgpx0A14hNRCiagrsZ5EAfWmNSHGZEH9d/72xcuXVCZlObNEgkj5EE2cTIaIqSgAZjOAX2ellTgPkWuU7JMzLeiQZDXkgZu/BFWt8GEv6jaHKvRt08Yrl9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999201; c=relaxed/simple;
	bh=Hj0ta3Eu+x7sjXgwb8J8jJ4p6RmEKsz07ce1JVcDKqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJsjDbU6Gwtg3f7WwEIagWwjEzsJw5KOdHlGl+XGoHpDrzPpTNn7YL6CFTQrW5icOrXwlEq9/IhZjgICCmgB981tnWQp3ggV8/I7D+QWILZZHEj21dJF77iMlFj3Q7rGMEYjROhKLQO7V2hbSzsczILcrxRH2cacXOQxfV2lj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=APouihov; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="APouihov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gLS7pT3T4v7xrlIuSY8uY9IyBACFKGJNjm
	QL1BB2GzI=; b=APouihovRrmi+dlpFaS8xKUpx8WPZeq+sLA+flJEc90msrDx2J
	T5YIeHYFuiSG+6XboK80e1e0N9FONs7Dgh+d+BexdYWLk92wFacqcHad+Mw2SyKd
	AD8B/xBa63Ot1jb/IuwBjHpORbRtRoioHozr4NIW1vpjw7RjYwKyY5wRs=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXUyrLs5JqiPC0AA--.1346S2;
	Sat, 29 Aug 2026 18:26:20 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	joannelkoong@gmail.com
Subject: [PATCH 6.6.y v2 0/3] bpf: fix dynptr release handling
Date: Sat, 29 Aug 2026 18:26:15 +0800
Message-ID: <20260829102618.105116-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
References: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBXUyrLs5JqiPC0AA--.1346S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyfGF1UGw48tr4fZr4UXFb_yoW5CF1fpF
	WFkayYqF1kJrnrCrs7AF48X3WFkrs3Xw43GFyfKrySyan8Jry5ZrWagFyUXFsxKryfA3yj
	qw4Yq3ZxCa1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgXdbDUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
an 11-file parent_id refactor.  That refactor cannot be applied to
6.6.y, which still represents the relationships with dynptr_id and
ref_obj_id.

This series supplies three stable-sized equivalents using the existing
6.6.y representation.  Patch 1 invalidates slice registers with the
released dynptr_id.  Patch 2 propagates a referenced-dynptr release
error instead of turning a callback rejection into a kernel warning.
Patch 3 scans every active call frame when invalidating cloned dynptr
stack slots.  They are split because the bugs have different
introducing commits and independently testable effects.

All three patches preserve Amery's upstream authorship and complete
trailer chain.  Each commit message explicitly documents the deviations
from 308c7a0ae885 and the reason for the stable-only implementation.

Changes in v2:

- check that a register has base type PTR_TO_MEM before reading its
  dynptr_id union member, while retaining DYNPTR_TYPE_* flags;
- add a bpf_dynptr_slice() use-after-submit regression that reaches the
  dynptr_id-only slice path on the target stable verifier;
- add a separate patch that propagates release_reference() errors from
  referenced dynptr release and a callback regression test.  This avoids
  the verifier WARN, and the panic it causes with panic_on_warn=1, when a
  callback tries to release its caller's dynptr;
- make the cross-frame clone regression use bpf_dynptr_data() after the
  callee releases a clone, so it uniquely tests caller-slot invalidation
  instead of a repeated release already rejected by patch 2;
- check STACK_DYNPTR before reading dynptr metadata while scanning call
  frames, so a partially overwritten ordinary spill with stale metadata
  is ignored, and add a success regression test;
- investigate the separately reported slice escape through a returned
  subprogram frame.  A minimal reproducer is also accepted by current
  mainline after 308c7a0ae885, so that issue is not folded into this
  stable-only series and needs a separate mainline fix.

Tested on Linux 6.6.155 with panic_on_warn=1:

- test_progs -t dynptr -v --workers=1: 2/92 passed, 0 failed;
- the slice-after-submit and cross-frame stale-use programs were
  rejected, while their control programs loaded successfully;
- the callback-release reproducer was rejected without a verifier
  warning;
- the independent submit/discard, stale-spill, and cross-frame
  reproducers produced the expected results.

Amery Hung (3):
  bpf: Invalidate dynptr slices by dynptr_id on release
  bpf: Propagate referenced dynptr release errors
  bpf: Invalidate dynptr clones in every call frame on release

 kernel/bpf/verifier.c                         | 55 +++++++++----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 79 +++++++++++++++++++
 2 files changed, 119 insertions(+), 15 deletions(-)


base-commit: a4a971135a2ff64382ae4235b3ae60503bb1036a
-- 
2.43.0

