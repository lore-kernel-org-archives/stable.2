Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5C2F7EE4;
	Fri, 17 Jul 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308023; cv=none; b=LeoLLnYYPGMUX5q0o9aMmE9uos0XZJeiT/ZEnjFr55EVkhPzkxca9chFrp7PJbrUmrLVHbp7a/2zvBgkoLm6cfFTVCfRLrgu539DVvWLzoacmQta4KDlitP2RXmiS0SgB+doiczf1ccgYtePi4aqlHmLlY29miret9BjMHBe0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308023; c=relaxed/simple;
	bh=0Vi4XcTkAZJbkjqmtACMfa0Zc5DhaJox1a7m2QlS3jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFWa1Remj94XCyX+6vBCwd+bp/QN94h+itMef2CkPj+9vfrNLQzbEqoPtbJ/wA3BAVq8ODBXwj9YhuE7fKlEAjqAfiWdzYqk4iXJjhDIRZnyN/81EJjVLG7qrJrw2dCXksLPvY5+dMw5d35Zy5kH6pccOf75bpwpvPcXqXio5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZ8EQfEY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZ8EQfEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308022; x=1815844022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Vi4XcTkAZJbkjqmtACMfa0Zc5DhaJox1a7m2QlS3jo=;
  b=TZ8EQfEYMAr1z6EjN9Y38NAW+FRjirfffGl7yVGAQcA7wZknS8Rj8avN
   YnuEgRROc8xkaI3gp3xNogQXYgg0YINQlCFDgKYmS4tvpwru8j/cxi8eZ
   C3ECmWT5tK7a4DR/rufo3D3TXHtRILA594bpcjXifiw+EMfCaikeUoJkL
   BBrq+F0FUEeG+TLHe6CHuXjwkgYqGb3TB3Z7iyCzbCEyTm3PMIr4T87Hl
   UWHq9YuyUhiJHoQyHr/Mjr55QcnVP47hp+9ms1+44VutSLZeh/pc7q52u
   zF2Nxrm9yFBHBXicd6i9z6X3PJcHnvFKHHm304VV4IbnW68/5W/SC9sBv
   w==;
X-CSE-ConnectionGUID: jIVsAwvwTueY9ni64bGfXA==
X-CSE-MsgGUID: N7S896jWRSmwL8MfnWUE7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="110533861"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110533861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:07:02 -0700
X-CSE-ConnectionGUID: QsBHxzL7TnG5yB9vKgLUgg==
X-CSE-MsgGUID: xE1DH7+0Qj6GVrNzYrHArQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="286903978"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:07:02 -0700
Date: Fri, 17 Jul 2026 10:07:01 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-6-e04f1b2893de@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>

commit b72e29e0f7ee329d89f86db8700c8ea99b4a370a upstream.

The pack allocator only flushes predictors when reusing a dirty pack for
cBPF, eBPF allocations never trigger a flush. Currently, eBPF picks the
first free pack, which could be a clean pack. As an optimization, leaving
a clean pack for cBPF can avoid flushes.

Prefer dirty packs for eBPF and keep clean packs free for cBPF. This
mirrors the existing cBPF preference for clean packs: each program kind
prefers the pack that avoids an extra flush, and falls back to the other
kind only when no preferred pack has room. eBPF reuse of a dirty pack is
harmless since eBPF being privileged does not flush.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7dc59570cd25..4669a57265ad 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -950,10 +950,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 			goto found_free_area;
 		/*
 		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
-		 * clean pack for cBPF. eBPF never flushes, so pick the first
-		 * free pack, dirty or clean.
+		 * clean pack for cBPF. eBPF never flushes, so steer it to a
+		 * dirty pack and keep clean packs free for cBPF.
 		 */
-		if (!was_classic || !pack->arch_flush_needed)
+		if (was_classic ^ pack->arch_flush_needed)
 			goto found_free_area;
 		if (!fallback_pack) {
 			fallback_pack = pack;

-- 
2.43.0


