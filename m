Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA02F6565;
	Fri, 17 Jul 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307933; cv=none; b=AdN5e9BKnLKsXRt1ma7jGVCAkisM1Eu3D96QarA6wmoa+1OlP5Coxvw4br1dJq3Vo9STGYsmiortUje0XSSbwUr9+nZHZjujVRM2/YZWIViu/MtxA7J4F1GOAdaDNhPlPvIr5tAkCVf6HfAH3Zcu17yndkXCjXqoZ4bgz5g8lOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307933; c=relaxed/simple;
	bh=kO8aFzuGHwtDypuu15ShB7rQhwfq0S6rbdCVU3OLqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iH+vMsEkBye+0n6PBTtWXofbRPldmUP9MYMn+kPQG7F0D/ge9WBIqCKlCCtFFim8I4V78YYnNB//M7jzhi4tYktc8bbHVMq3mcudfjhfrZsIKzi+SvM42OF0ds3oiYcZLN3iTjqaoqlmYXvJmwWabcSWMmt+9N5HrqYm0dhl5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8sB13m9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8sB13m9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784307932; x=1815843932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kO8aFzuGHwtDypuu15ShB7rQhwfq0S6rbdCVU3OLqX4=;
  b=O8sB13m922z16po4oH2FrbTG5LHVCioZ7bVDV7txHpnVlYib5qTRjGA0
   J6cbF5WdvRPWw7bpcUWsszgXAch2oTyqQUk8BqkGKf+fqiDHHw2wrODCb
   qXNTRGf1/U3ARJ2ewiWJoDyX4g8b8QR+SXeh7B9ntRVAITVNRAYXtBCDd
   vxHz/pV0Um+rRopPzpK/uXeblOqiw3qOsnbJa2Jla0WH0cYXSzCiIjAX/
   XEbvC7cbD5isqRVMtmdp4RqbvwhBICCQBsKoOLdpz6NIap10AI2JDomrB
   pqJzSVmsuZH9NunZDBACEhNGYzsrEBL0n9cJ3ik6+iSWFcZpjfhELhCpa
   Q==;
X-CSE-ConnectionGUID: 7ymEilQ/RfC5EgamVGQYtw==
X-CSE-MsgGUID: XXyLfEaOR0GCXYAki/6sJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88660696"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88660696"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:05:31 -0700
X-CSE-ConnectionGUID: eUr5wEqQRASVPpk+SZIHHw==
X-CSE-MsgGUID: KJ60gS9dSwGhwnT/tiyPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="295027652"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:05:31 -0700
Date: Fri, 17 Jul 2026 10:05:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.6.y 0/6] cBPF JIT spray hardening
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANleWmoC/yWNMQvCMBCF/0q52SttlAu4iYujg5s4pMmlvQ4xJ
 FUspf/dVHnT9x68b4HMSTjDsVog8VuyPEOBdleBHUzoGcUVBtUoanRLaLvocZQJc0xmxsEkx0F
 Cj1Qyo7FErP1B7bWDchITe/n8BHe4nm7ny9ZSTfUMj/+eX93IdtossK5fuD+rQZIAAAA=
X-Change-ID: 20260716-cbpf-jit-spray-hardening-6-6-y-ac66e7f4237d
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

 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  3 +-
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 7 files changed, 129 insertions(+), 16 deletions(-)
---
base-commit: da47cbc254661aa66d61ef061485a7080305c4be
change-id: 20260716-cbpf-jit-spray-hardening-6-6-y-ac66e7f4237d

Best regards,
--  
Pawan


