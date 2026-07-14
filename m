Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F435DA7F;
	Tue, 14 Jul 2026 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991486; cv=none; b=KWvlPqDRb7HuX3fmi6fL4NmdjmW1zUvHGrXgOza37KeHoUg/aXlM0jU6lU2EP6nLBKZRL243ScZFY86BFTBx9yu9w8iJxwEYFmAa+UUSPhvlZ/84azDCssP87HBzIBTnUDeiOLiGA9HueuDZtySKNsK4Rm57DZVbsFkRbtkiQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991486; c=relaxed/simple;
	bh=DCbMgnamWUlHK3HfeBnVqU97YJbvkxfbDCJ2xswtGHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MjlabILxEcSeT+bprXtm2pzkGU4IInXc/4lH5yc37ETsouztMGRmSUMBHFmN9gQHsha2Dtuzv/0FZHFY7032JdyGS9rFz2CN383astNYvo4AjVqEZDvaYVrl92lDKduNjqFc9HYZQYmOw8BMd7IvoVkM7vgaaHdcA/A98XDf2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMoaiWkg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMoaiWkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991484; x=1815527484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DCbMgnamWUlHK3HfeBnVqU97YJbvkxfbDCJ2xswtGHo=;
  b=AMoaiWkg1UGKbxlfi+Uyulqce5xp85SEGPUzpfZ72Yatz7EwqtVdgx1s
   OzutdSwHdyn8K4FTVTjxGEZuWoNHMfqj8Qt/nIRwWYx9nhgdMT12BznTq
   UPIRNHJbMMPdK9m+g0LQ+TGuSYMlyEh5dajlw2aa8lgIdzkkiUPqr8tjE
   qj1ei8jXj4VpVo1vDsCZNaiDreJcGZmBJeJdrB/KeWMh0av1kUgl8Sd/g
   KrE4NuLWiswQ9PGh7q1CCNlehHPSQ6CFes5DEcNas1Pbon8vvOs6L1soD
   vBmjuCYclO1IbwJoqnl7g72ml2wO6NdrzR5K8DtRT35e40mHp6wiDNMC5
   A==;
X-CSE-ConnectionGUID: Gs9EIqTfROSWc0ZGhKfHxw==
X-CSE-MsgGUID: J8XXEg+WScOQ+x2qCF839g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84702125"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84702125"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:23 -0700
X-CSE-ConnectionGUID: X0NUj8UzT+uuLyJCHusJHg==
X-CSE-MsgGUID: LMEMMUp0SqmapMABq2oo4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252318584"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:21 -0700
Date: Mon, 13 Jul 2026 18:11:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.18.y 0/6] cBPF JIT spray hardening
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAFWMVWoC/yWNsQ7CIBRFf6V5s68BTAq6GRdHBzfjQOlr+zogg
 WokTf9dqsMdzs3NPQskikwJjtUCkd6c+OkLyF0FbrR+IOSuMCihGqHlHl0bepx4xhSizTja2JF
 nP2CD0mBGK5Qx+uB0CZSXEKnnz89wh+vpdr5sbVNLU2d4/Afp1U7k5s0D6/oFVLm6h5QAAAA=
X-Change-ID: 20260713-cbpf-jit-spray-hardening-6-18-y-a028879c779c
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

Patches 1 & 2 had minor header conflicts. Patch 3 had a few conflicts in
bpf_int_jit_compile(), majorly loongarch bpf_int_jit_compile() doesn't use
pack allocator, dropped was_classic hunk.

x86 builds and boots fine in a VM. I don't have build infra for other
arches, relying on the bots for the builds.

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/loongarch/net/bpf_jit.c         |  2 +-
 arch/powerpc/net/bpf_jit_comp.c      |  4 +--
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 11 files changed, 136 insertions(+), 23 deletions(-)
---
base-commit: e46dc0adfe39724bcf52cea47b8f9c9aed86a394
change-id: 20260713-cbpf-jit-spray-hardening-6-18-y-a028879c779c

Best regards,
--  
Pawan


