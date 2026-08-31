Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CDC4317D;
	Mon, 31 Aug 2026 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135363; cv=none; b=VtOIo3pVnukbvX7tw36bn0RM7fSPFhEh4K0AmkBHwpfFyn4Kt3k6ELvX/qCsySmre7j1RuA4vDmDdYNIOxG4CNfPLOllbMepjZAuln4etqSqK+DoZMi00UwdxKZVKxLP6dkfw6mmkrIWxwdfejtqHLuUtfbq4YjGyW8f8nEed08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135363; c=relaxed/simple;
	bh=ALQuptyZocd75gbnpK08A9je3ejcOpQftlI63oC20+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfS9lF+whM99tPlRMK4ECQJqkiTPyoOKFHU9uaH8m86Nisz61KhULbJ8VUhBlpb4+Z5pu9T1q2OVKcQ0U4AZjEztHjWMNBSj7Xo1AMfJzNl5XfmEdMHEMTb3P4EsJ2eR4t9pcbbcz5oLtFLC0WXvzvn0AbbmYrZUMhNf4D9wfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=b1woP9lj; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="b1woP9lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=0jF8PBwmlF
	0HLQpVGJdcqsHYumrIU7CllVUzTIvnxLM=; b=b1woP9lj1e/1ebnDVDNOEjUUWy
	6miFt9olcxP/jLy9J2RK998xTkGv3D5RICIzElVQ7JDUBm0VhQK2Okpryab/TaTk
	r+Isr1gJFgGkTc5FPLDx6O5qevPJkJqcro2FQAE6rxNIL6BFtUJUCzH2LJL+M990
	BQFmXPKQFT6xzqxr0=
Received: from localhost (unknown [222.195.81.60])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXmjG6x5Rqlae+AA--.2756S2;
	Mon, 31 Aug 2026 08:15:54 +0800 (CST)
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
	joannelkoong@gmail.com,
	sashal@kernel.org
Subject: [PATCH 6.12.y v4 0/3] bpf: fix dynptr release handling
Date: Mon, 31 Aug 2026 08:15:49 +0800
Message-ID: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCXmjG6x5Rqlae+AA--.2756S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyfGF1UGw48uw1rGFyxAFb_yoWrAF43pF
	WFkayYqr1kJr47Crs7AF48XryFkrs5X3y5KFyfK34fA3Z8Jryj9rWaqa4jqFZ8KryfA3yj
	qw4Yq3ZxCa1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r
	1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6w
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5WuWtUUUUU=
	=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
an 11-file parent_id refactor. That refactor cannot be applied to
6.12.y, which still represents the relationships with dynptr_id and
ref_obj_id.

This series supplies three stable-sized equivalents using the existing
6.12.y representation. Patch 1 invalidates slice registers with the
released dynptr_id. Patch 2 propagates a referenced-dynptr release
error instead of turning a callback rejection into a kernel warning.
Patch 3 scans every active call frame when invalidating cloned dynptr
stack slots. They are split because the bugs have different
introducing commits and independently testable effects.

These patches are stable-specific implementations authored for the old
verifier, not cherry-picks of Amery Hung's upstream diff. Each commit
keeps 308c7a0ae885 as the upstream provenance for the equivalent fix
and documents how its implementation differs.

Changes in v4:

- make Xu Yunxiang the author of all three stable-specific
  implementations;
- remove the authorship, sign-off, and ack trailers copied from
  308c7a0ae885 because those developers did not write or review these
  rewritten stable patches;
- remove the backporter notes and retain the upstream commit only as
  provenance for the equivalent fixes;
- leave all code and tests byte-for-byte unchanged from v3.

v3: https://lore.kernel.org/r/20260829102638.105170-1-xyx2021@mail.ustc.edu.cn

Changes in v3:

- check that a register has base type PTR_TO_MEM before reading its
  dynptr_id union member, while retaining DYNPTR_TYPE_* flags;
- add a bpf_dynptr_slice() use-after-submit regression that reaches the
  dynptr_id-only slice path on the target stable verifier;
- add a separate patch that propagates release_reference() errors from
  referenced dynptr release and a callback regression test. This avoids
  the verifier WARN, and the panic it causes with panic_on_warn=1, when a
  callback tries to release its caller's dynptr;
- make the cross-frame clone regression use bpf_dynptr_data() after the
  callee releases a clone, so it uniquely tests caller-slot invalidation
  instead of a repeated release already rejected by patch 2;
- check STACK_DYNPTR before reading dynptr metadata while scanning call
  frames, so a partially overwritten ordinary spill with stale metadata
  is ignored, and add a success regression test;
- investigate the separately reported slice escape through a returned
  subprogram frame. A minimal reproducer is also accepted by current
  mainline after 308c7a0ae885, so that issue is not folded into this
  stable-only series and needs a separate mainline fix.

Changes in v2:

- restore Amery as the author and retain the complete upstream trailer
  chain;
- add bracketed notes documenting the stable-only implementation;
- remove the exact PTR_TO_MEM type filter so slices carrying
  DYNPTR_TYPE_* flags are invalidated by dynptr_id;
- add the applicable dynptr slice/clone Fixes tags and identify the
  reporter;
- add a cross-frame clone regression test and tighten the slice test.

The code and tests are unchanged from v3. The following results were
obtained on that identical code tree with Linux 6.12.107 and
panic_on_warn=1:

- test_progs -t dynptr -v --workers=1: 2/96 passed, 0 failed;
- the slice-after-submit and cross-frame stale-use programs were
  rejected, while their control programs loaded successfully;
- the callback-release reproducer was rejected without a verifier
  warning;
- the independent submit/discard, stale-spill, and cross-frame
  reproducers produced the expected results.

Xu Yunxiang (3):
  bpf: Invalidate dynptr slices by dynptr_id on release
  bpf: Propagate referenced dynptr release errors
  bpf: Invalidate dynptr clones in every call frame on release

 kernel/bpf/verifier.c                         | 55 +++++++++----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 79 +++++++++++++++++++
 2 files changed, 119 insertions(+), 15 deletions(-)


base-commit: f717995cb7dcd8998ab15516b8006aea09cfde0d
-- 
2.43.0

