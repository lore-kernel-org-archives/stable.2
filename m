Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AC38911E;
	Sat, 29 Aug 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999209; cv=none; b=FMiCOxnTfHVXFyV9llT7BAFWWblP3Ein1iVHG1NcQLUNV0Kn9jn5BPIONAc3VVD3f+FtxXRmitVAF7inHIisDretc92wRp3l1ZErkJM9yjb9VBysAaR2YyUcWPyP3SxaYwBZtldl0bMXoBwE3z4Th9TcJ//2h4TxMwYBVdtadAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999209; c=relaxed/simple;
	bh=uk8hvvKRwYozrtduPPhsduNmQNLDU21FaxjAlU36lIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmYc4DdHKJTk6a6PuSYEyllCKDTPPuntcenzxv5Hur69boD/xkRkk6oPjaGn4fvDinj1EMaoBl/3KYaOHW+iHB1YMwKV2LdmG+XFawOBQU7/wux/y0zatZGX5D92UKOiW14UZMCzmy25pDWeMJMf9+7D2jDuxPVQke94yW10M6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=W7bRV6GU; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="W7bRV6GU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=C6nzkse0doyKuR3LJrbug0CE/LWMCV9s7E
	HouB7MvRE=; b=W7bRV6GUSFc7XeceroTI3UmIwIFCPDGtNjdQehwQRTL18SQBzZ
	WeqavybZeFoGUIaruIAK07aCPXQAIu92L7Ws6pk8eNh7XD5zvEgAN02b59ae7jw2
	oYKQre8io577p85sfhsyaTEZSieQS1Wj21VLgHuUUDmBiM3Cmg6SEW3OM=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnKjHgs5Jq1vC0AA--.1355S2;
	Sat, 29 Aug 2026 18:26:40 +0800 (CST)
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
Subject: [PATCH 6.12.y v3 0/3] bpf: fix dynptr release handling
Date: Sat, 29 Aug 2026 18:26:35 +0800
Message-ID: <20260829102638.105170-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
References: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnKjHgs5Jq1vC0AA--.1355S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyfGF1UGw48tr4fZr4UXFb_yoW5Kr17pF
	WrCayYqr1kJr47Ars7Ar48X3WFkrs5X3y5GFyfKryfAa15JryYvrWaga4jqFZ8KryfA3yj
	9w4Yq3ZxCa1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
	Ij6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07b04iUUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Upstream commit 308c7a0ae885 ("bpf: Refactor object relationship
tracking and fix dynptr UAF bug") fixes these lifetime bugs as part of
an 11-file parent_id refactor.  That refactor cannot be applied to
6.12.y, which still represents the relationships with dynptr_id and
ref_obj_id.

This series supplies three stable-sized equivalents using the existing
6.12.y representation.  Patch 1 invalidates slice registers with the
released dynptr_id.  Patch 2 propagates a referenced-dynptr release
error instead of turning a callback rejection into a kernel warning.
Patch 3 scans every active call frame when invalidating cloned dynptr
stack slots.  They are split because the bugs have different
introducing commits and independently testable effects.

All three patches preserve Amery's upstream authorship and complete
trailer chain.  Each commit message explicitly documents the deviations
from 308c7a0ae885 and the reason for the stable-only implementation.

Changes in v3:

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

Changes in v2:

- restore Amery as the author and retain the complete upstream trailer
  chain;
- add bracketed notes documenting the stable-only implementation;
- remove the exact PTR_TO_MEM type filter so slices carrying
  DYNPTR_TYPE_* flags are invalidated by dynptr_id;
- add the applicable dynptr slice/clone Fixes tags and identify the
  reporter;
- add a cross-frame clone regression test and tighten the slice test.

Tested on Linux 6.12.107 with panic_on_warn=1:

- test_progs -t dynptr -v --workers=1: 2/96 passed, 0 failed;
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


base-commit: f717995cb7dcd8998ab15516b8006aea09cfde0d
-- 
2.43.0

