Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD183346A8;
	Tue, 14 Jul 2026 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055507; cv=none; b=pvf5TD23F/QEknWoNO4863NvmMh2muOb3gVkSC2I5GNE5zNy1tgA2DeL2pMupMAdKAKc5gnKcex169bse8LClk/1Xn2oF4G6k4odh60z0vEpFzsGA3APDotVKmd+gDqKD26rIh+HTcMsPFgP6q4juj5r9MmwC96n954hDXJo3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055507; c=relaxed/simple;
	bh=DzLA4w38CFwdzu/Uzj79RDIxzZT2AwfMc39nX/r/t9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P2RzxZJd4CnzdZW+qmtdJ6u4zlIvPkvMzj4rg6AQELpWFQam/UGboYv63MKsOgLXBqy4HrUioGl8FQiCOWCoM214/IZUJDUoF3q6SvTv/b/JFYm3fIGlJzgVygQJ+D4WZtPL8TCdTSkCoSs/3qIds4xEkYeJBOcRWMco//va2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTtq2MfB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTtq2MfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055506; x=1815591506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DzLA4w38CFwdzu/Uzj79RDIxzZT2AwfMc39nX/r/t9k=;
  b=aTtq2MfBexiXXwNaPQE4ohjtNWTDrut4Sr9F4jTpzh3iKCyK3rpe7Cl5
   eeHlNHiKV+qo0OR3/Wjsb6Lz01PJy0k2fTAgDjY2fd7GIdBaOqLP7rfaZ
   HT/jXhHWK5+Y+/jw4yZgmlvwtrA6CZ+9sTEihtwTKV/f2bM31bwl6Po68
   rxkbpr19l15IwP/KxsPkwg8CEHY3iEjwH5Q5wShVYrr9NIGOnuhQTvLxr
   t2EWTFPqSzZ7bjCXZZzcvK7JlsVzaAVZ/tAFia2P1aqjPDKOD0EZmGS8O
   h4AAQw2a+h7zgawEVDZBZ1tHkfgP82N88OtSQ3K4UYCelDiiphUGMeepR
   A==;
X-CSE-ConnectionGUID: xGBJg+B8QqyDCuMj3Gl5sw==
X-CSE-MsgGUID: B5ESX4YpTRuhCZZWsxo14A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88586658"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88586658"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:25 -0700
X-CSE-ConnectionGUID: zJdJZMFdTvexCooRz9Lb5w==
X-CSE-MsgGUID: eYih6CtRRc+2gVaty5xw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255442489"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:25 -0700
Date: Tue, 14 Jul 2026 11:58:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.16.y 0/6] cBPF JIT spray hardening
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAGOGVmoC/yWNvQ6CMBRGX4Xc2UvaBurPRlwcHdyMQykXuAy1a
 dHYEN7douP58uWcBSIFpginYoFAb478dBnkrgA7GjcQcpcZlFBa7GWFtvU9Tjxj9MEkHE3oyLE
 bUKPUmLC2taiqY39QwkK2+EA9f36FO1yb2/myrbqUukzw+B/iq53IzlsH1vULVVaQGZQAAAA=
X-Change-ID: 20260714-cbpf-jit-spray-hardening-6-16-y-5c50449f820c
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

This one is mostly similar to 6.18:

  https://lore.kernel.org/all/20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com/

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/powerpc/net/bpf_jit_comp.c      |  4 +--
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 10 files changed, 135 insertions(+), 22 deletions(-)
---
base-commit: d997d33eb340e2add100eac1222e107cc1396e76
change-id: 20260714-cbpf-jit-spray-hardening-6-16-y-5c50449f820c

Best regards,
--  
Pawan


