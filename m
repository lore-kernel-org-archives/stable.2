Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194B43030E;
	Mon, 27 Jul 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192929; cv=none; b=l6KM5WPYV/f21Y5CA+XYKrsi6/7/qQrshaN1+MRP3YScnCM+cdQSzK6eZNoTL81MGpBJJdkL3DNfDNcMXqAoke3fvAzvU2gcTvmEk1RCVJ4DMftpOOeo2ml+LLrLyp3XGReyLAEPEoY9d0nFV+5zNtZKZnVWE3nGJAKChFbf9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192929; c=relaxed/simple;
	bh=hy6xtXL8VeCMC33+8yPSAIe2Fr1GJIfBxQlxLAgtCmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lBOmjUev2HhONVihpJ7kj9YN3l1X3sxPKczCqiDDyV/goPj8PNH6efdUr5OMhZSESzBdaBqs/ELx7dNGK8IoyXc6KkbdgGyJQ0HS/y6G4ZFtXuqXrVnuiRffRssnAKd4L4Zxkb0NN6pqBLPlvq+Q+pUzzK7nN+2Qi96ZoJ/k8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITS55hSU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITS55hSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192927; x=1816728927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hy6xtXL8VeCMC33+8yPSAIe2Fr1GJIfBxQlxLAgtCmo=;
  b=ITS55hSUo+5gD7XOF+M7SQGdPQo0PatE+0YTeQvscI83yJVcQCqZ2XD4
   pc1ETmXPZmBpKIkRPnFQif1zkZE9J9L7vFvgwRhbgLd5AdKemWG4qLKpC
   x5e+2abynewP0BoXNS74VvKmkiNSIININspoqHY3oMgpor/rH0iA665dC
   Ulge+Cwq3kGRlEfJji47CEVYHenHi5pfd8Rwu/tkPSMhJPA4OJQg91y+T
   /Xm/y9MlqYNhQ/GwnAycxciw3gBC6lSSQjTC9yqt2eehFXXNxX/XmSSoB
   M57nUjQMUn2ydb1VnCm2i1CJbLgfI1hB9FPPFnoh3cWcY1DQjGe58S4Fy
   w==;
X-CSE-ConnectionGUID: iBW+kioOTUmtG1WtDPo5vw==
X-CSE-MsgGUID: CsvUr08QRK2ysOHV3seYeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108564898"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="108564898"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:26 -0700
X-CSE-ConnectionGUID: z1ebjzEbSrqfcKYUho283Q==
X-CSE-MsgGUID: u8GVNWbqSj+HQZgbnIRTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="255227001"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:25 -0700
Date: Mon, 27 Jul 2026 15:55:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.1.y 0/6] cBPF JIT spray hardening
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIADThZ2oC/yWNMQ+CMBBG/wq52SM9oiW6GRdHBzfjUMoBx1CaF
 o0N4b9bdHzfl7y3QOQgHOFULBD4LVEml4F2BdjBuJ5R2sxQqUqrmmq0je9wlBmjDybhYELLTly
 PGgkT6iNpa9Te0oEhS3zgTj6/wANu5/vluq26pDLB8//HVzOynbcKrOsXKVp7+5IAAAA=
X-Change-ID: 20260717-cbpf-jit-spray-hardening-6-1-y-6916ca04c15e
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

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  3 +-
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 6 files changed, 127 insertions(+), 15 deletions(-)
---
base-commit: dc5c83b7f5f83ea99aea5c771b1ec77458263a15
change-id: 20260717-cbpf-jit-spray-hardening-6-1-y-6916ca04c15e

Best regards,
--  
Pawan


