Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5E5474F;
	Mon, 31 Aug 2026 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135358; cv=none; b=mWcBbpq6GnyXOEsO5h1eufPpnkILWIS7lF4cHjJD0qFmxfoPzqpmTW3Y5WgdRUt2ohvCa0BbMnZ1pTnTrCxd6SvD7AFb0UVmoX4kf4la74wHA5+40jpLb5+M/QKJcNs8mLJmV6ZmtJ3dTWTONzJrlKlUeGyvRA5pjMtXOvcChgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135358; c=relaxed/simple;
	bh=MXxSIduaxbuHW0xd67+p12yKd+GfCg3iF7VdreuaYB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFWKfT6brfjIOpGAeXbubVdpbI5yM3NUcY0gHteYntVY37/xV0HFZjLzBoJFE87dIDIwN0OUksoFVLaaiRtvQY/by5UyRxC/aFdiCI63NUbj6ynu45DdHSgZhYpcmXBRTwNFwVMG5fW9hZTWZLM+g7Nl9a432Kebgd30l6Yt5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=gZ2ggx2U; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="gZ2ggx2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=6pPk1RKU7b
	lzgrDpApXfta6xf+H6BptHxsrQAtahHPI=; b=gZ2ggx2UmHbFy7A6BaUviVj2dP
	2Ty2+J5jfzy0BrbrHxwFzOosIFwBFcgpmlaaa3AOJHG3lB8UfmKeo6pwSmjlzVb7
	Can0qwZ5i5BaXa1f3AWRxmjB9gqatrMGUqCrXWjNvkUvPxgayjPqo2EE2f9oWOV5
	Bi6Vvgvn/c1/K0gJM=
Received: from localhost (unknown [222.195.81.60])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXSyKhx5RqMKe+AA--.2552S2;
	Mon, 31 Aug 2026 08:15:29 +0800 (CST)
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
Subject: [PATCH 6.6.y v3 0/3] bpf: fix dynptr release handling
Date: Mon, 31 Aug 2026 08:15:21 +0800
Message-ID: <20260831001524.3223134-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBXSyKhx5RqMKe+AA--.2552S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyfGF1UGw48uw1rGFyxAFb_yoWrJw4kpF
	WFk3yYqF1kJr1UCrs7AF4xXFyFkrs3X3y5KFyrK34fZ3Z8JryUurWYgFyUXFZ8KFyfA3yj
	qw4Yq3ZxCa1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_tw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bF3kNUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
an 11-file parent_id refactor. That refactor cannot be applied to
6.6.y, which still represents the relationships with dynptr_id and
ref_obj_id.

This series supplies three stable-sized equivalents using the existing
6.6.y representation. Patch 1 invalidates slice registers with the
released dynptr_id. Patch 2 propagates a referenced-dynptr release
error instead of turning a callback rejection into a kernel warning.
Patch 3 scans every active call frame when invalidating cloned dynptr
stack slots. They are split because the bugs have different
introducing commits and independently testable effects.

These patches are stable-specific implementations authored for the old
verifier, not cherry-picks of Amery Hung's upstream diff. Each commit
keeps 308c7a0ae885 as the upstream provenance for the equivalent fix
and documents how its implementation differs.

Changes in v3:

- make Xu Yunxiang the author of all three stable-specific
  implementations;
- remove the authorship, sign-off, and ack trailers copied from
  308c7a0ae885 because those developers did not write or review these
  rewritten stable patches;
- remove the backporter notes and retain the upstream commit only as
  provenance for the equivalent fixes;
- leave all code and tests byte-for-byte unchanged from v2.

v2: https://lore.kernel.org/r/20260829102618.105116-1-xyx2021@mail.ustc.edu.cn

Changes in v2:

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

The code and tests are unchanged from v2. The following results were
obtained on that identical code tree with Linux 6.6.155 and
panic_on_warn=1:

- test_progs -t dynptr -v --workers=1: 2/92 passed, 0 failed;
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


base-commit: a4a971135a2ff64382ae4235b3ae60503bb1036a
-- 
2.43.0

