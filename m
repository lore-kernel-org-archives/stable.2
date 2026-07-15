Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C933CB2CF;
	Wed, 15 Jul 2026 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150862; cv=none; b=qiAYRfUEiEniOgZGq3J0ndTE4LOwMmJyoXi8jyrjuc7+vb4fkrWsU4XMO832cIP3MGkCpQ8Gr8I9vJz0bxESTyBjb/feXjZU1/vOl/N/zXHCOqdQRvSIQ6c3CNImgpRVF+qDAZtKoTLfvpgolzA6VITtmPYrztj/7cPTZE+ta8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150862; c=relaxed/simple;
	bh=Zcl/hJP8vOoXfaWvVzA1OXL0SRddDjKbhCcj2uRFlLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h1WceARShjSjBUEbU9+1DcTsU92IQLP0Tb102f89fjsntIV1EYq5DWKbOpJ8Lrf7x56iSHWqRNL44dDuESYDo5PHaMsbPP4yutErGPJVzpH5DtydCEIkZPZfoiGwXCbjkatLlRKXwk1WZBSBCnQ2sF97h9Wioj1A9oAwAOy2ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evoIL3oR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evoIL3oR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784150860; x=1815686860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zcl/hJP8vOoXfaWvVzA1OXL0SRddDjKbhCcj2uRFlLk=;
  b=evoIL3oRfPndhixZS1hfkJYaSy+IlRsBPWETM2igAaZhUObt7Yro+XmZ
   IoSuC5Oxyxw4Ye2D1sTVVWsNAhBxiJtmXmjxiD7IID7qsCm1CcMLEiXHD
   GvF99cwfoYgZlJr2d7rjwcn4xZ/U0CAtw06L0XQGGgotSw2VeUqM+ItkY
   I0tDZUb8nGbdXTWgAHHfRm6W5AeAuvPDom5tmLWTDdH91qN0uFCHWPRtR
   DSAzaVZW8S5okRWOF/Xpjgulbo8PLdJJfuuT2R4+sO6ry/E30SoFiNLj/
   T2/p6yBLgPAcFFAIIGcpL4T6mUEWK6w2TwuSgiUwYpr54UL8q45aa6elX
   Q==;
X-CSE-ConnectionGUID: 6SQrG8xQSlu7v56DBP87QA==
X-CSE-MsgGUID: r15t3ErWSuyLllGcEi73Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88481976"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88481976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:27:39 -0700
X-CSE-ConnectionGUID: r4pyfzu7Q7+IwAqhuwZT7A==
X-CSE-MsgGUID: c+t89wMuTT2M218KSPaJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="286384073"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:27:40 -0700
Date: Wed, 15 Jul 2026 14:27:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.12.y 0/6] cBPF JIT spray hardening
Message-ID: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAPf6V2oC/yWNsQ6CMBRFf4W82UdoIwXciIujg5txKOUBj6E2L
 Robwr9bdDw3N+esEMgzBThlK3h6c+CnTSAOGZhJ25GQ+8QgC6mKShzRdG7AmRcMzuuIk/Y9WbY
 jKhQSI6qmFKYuha6aGpLFeRr48yvc4drezpd9VbmQeYTH/xBe3Uxm2TuwbV9vroONlAAAAA==
X-Change-ID: 20260714-cbpf-jit-spray-hardening-6-12-y-6951c851a798
X-Mailer: b4 0.16-dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

These backports harden BPF JIT against spectre-v2 class of attacks. Without
a predictor flush, execution of new BPF program may use stale prediction
left behind by the freed one.

To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
The flush is conditional to spectre-v2 mitigation applied.

Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.

	  bpf: Support for hardening against JIT spraying
	  x86/bugs: Enable IBPB flush on BPF JIT allocation

Patch 3-6: Narrow the flush to only unprivileged JIT allocations
	   to avoid redundant flushes. Also adds pack-selection changes
	   that minimizes flushes.

	  bpf: Restrict JIT predictor flush to cBPF
	  bpf: Skip redundant IBPB in pack allocator
	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
	  bpf: Prefer dirty packs for eBPF allocations

Conflicts resolved in patch 2 and 3.

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/powerpc/net/bpf_jit_comp.c      |  2 +-
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 10 files changed, 134 insertions(+), 21 deletions(-)
---
base-commit: 296aabce459470a4c1b68ffd0c0c0920e563aaad
change-id: 20260714-cbpf-jit-spray-hardening-6-12-y-6951c851a798

Best regards,
--  
Pawan

