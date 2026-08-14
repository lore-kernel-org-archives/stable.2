Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01442175A99
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744999; cv=none; b=GOJsuOm33dqRkdbYIw1ViJxOHN7s511F0uN+yhr0BKUw3iJIY2h8XQmW1dI8zk4RlgPeX63OhcyKj7tpotHzlASJmULF+U8bmdZZvEvRXt424AZYzkY2WD8kVa/S2ZefOvFTiuXRxWPdqQtH9CHKooro6h9iUvuymLgElt0qBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744999; c=relaxed/simple;
	bh=niXznIYx7Ts92aVYTcheGCjl6YW3uqQ3GqUpecuO1p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erBzP0WvW2EaTK/+GJsJUDtivJU43CBVMPDA2/0yBy3UG3g9i2YY3DTGvmURTyK5znC0d0uHeT0C6ObK1RGHEG4rC+i54pHleVF8U1APxWVHyipFnuZqyWEjWpgXdFgdwCk0bDqkRmMS2K699V6/fDJJCmq+m39rXerISzvSiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CjqleVQx; arc=none smtp.client-ip=95.215.58.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CjqleVQx"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=niXznIYx7Ts92aVYTcheGCjl6YW3uqQ3GqUpecuO1p4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786744996; v=1; x=1787349796;
 b=CjqleVQxWBMrC0Mf/lSXCIHE082asg9hNOk+BkOfz2Af9KLAnZME7bQpLf/5Ffq5/aH526SY
 Yw5qP3qeLPt811Pl4QibCtFyD9Bc2wsmq/foREh9VpcsPFwEMrBb41MxXx0KNBXfJdDIAHinzNV
 5M3cLFjUvmZ3WZK8fOem/6ZE=
X-Envelope-To: stable@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id be81eacd4c78865e;
	Fri, 14 Aug 2026 22:03:06 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf v3 0/2] bpf, x86: fix per-CPU address resolution into an extended register
Date: Fri, 14 Aug 2026 15:02:52 -0700
Message-ID: <20260814220254.3797467-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JIT resolves a per-CPU address with

  add <dst>, gs:[this_cpu_off]

but builds the REX prefix with add_1mod(), which sets REX.B. The
destination is encoded in ModRM.reg, which REX.R extends, and the memory
operand is disp32 with no base, so REX.B does nothing and the high
register bit is dropped. Every extended destination therefore resolves
into whichever register shares the low three bits:

  R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI

The address is left unadjusted and an unrelated register is clobbered.
Patch 1 switches to add_2mod() so the bit goes through REX.R.

Clang reloads the address into R1 before each per-CPU access, so the
destination is never an extended register and the bug has been dormant
since v6.10. GCC keeps several per-CPU addresses live at once, which is
how it turned up: test_progs-bpf_gcc panics the kernel in
global_percpu_data/init, with the address of a .percpu variable in R5.

Patch 2 covers every register. A functional test only catches this if
the address happens to land in an extended register, so the test matches
the JITed add instead.

Changes in v3:
- Fold the five per-register programs into one that loads every
  register, and drop the comment explaining the register choice
  (Eduard Zingerman).
- Move the percpu_data declaration inside the arch guard, so other
  targets no longer carry a .percpu section and an unused map (bpf-ci).
- Match the movabsq of each address as well as the add, so the matchers
  stay on consecutive lines and the pair is checked to use the same
  register.
- Restore the Reviewed-by on patch 1, dropped by mistake in v2.

Changes in v2:
- Add the selftest, patch 2/2 (Eduard Zingerman). It uses __jited()
  rather than __xlated(): the xlated stream is identical for every
  register, and the wrong prefix is only visible in the native encoding.
- No functional change to patch 1.

Vineet Gupta (2):
  bpf, x86: Fix per-CPU address resolution into an extended register
  selftests/bpf: Check per-CPU address resolution per register

 arch/x86/net/bpf_jit_comp.c                   |  2 +-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_percpu_addr.c          | 72 +++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c

-- 
2.53.0-Meta

