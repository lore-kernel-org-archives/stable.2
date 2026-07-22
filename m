Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D035C1B7;
	Wed, 22 Jul 2026 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733494; cv=none; b=Peki0YJeyhFbeYDaLmm8P5xkETk1o9G6th1SdRstFwBGso1Rd61mvgw/Xl9MFiUC2/s2OArk/LRzX3qRNo1Qz3B54PObYYaH/mO/e+/d/qO3zGvKR2j5ZIrg95B9eAoYHuZe/Q07cSD9T4Go7e/T3AJjLP8JQHkTbJT+PHj7VOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733494; c=relaxed/simple;
	bh=eIJCq0U0nvzWtAAiZhSd0Lkda2QdVkytVVFdCRV0V4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRIxYvt1ETPxedFvPhUnTmLoNmPOdQA7Y7AXACtyMbtTPlCmvCH4d6SYNCuSv+qJTjKXvnzUsdkHrHfJCKmNfva4C73F2sbBjXxKgZYsOdCfYSZXq/vkkuuCYmbhSQnUPLkMTonZwcSnErdnJS3LH5so8jM0gIDjrEvYcuI9JTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiSY9JuH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiSY9JuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784733493; x=1816269493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eIJCq0U0nvzWtAAiZhSd0Lkda2QdVkytVVFdCRV0V4Q=;
  b=EiSY9JuHAfHyy0ZtuUSMtCoT5PHI3PiiinuZ7p0ewsDMVeN6SlMMkwkP
   L8ZXAH6YljNAdM3MqAjYhgI+ep0m8TxqC+K7DkAPa3E7DQKAxh42tfzZr
   ImAunlj31w/e0IGPdDvm+joYRXhJajgD3TD07h4JJUlb++k8zXTxz8lZU
   vCQYSv3eIC8oLlbBitDw4fm69yLJ2JKgWtZA2MiUiH1UkjyTv7GPv+lKv
   wxHbKZLdJHvDktaIq6z+cVPj6ttq6zvOEX9i0yaBLiSQHw7rRD3EvW5JV
   mLNnwksMivieLtCLu8+ZpGxfRF+iWS10oK5kTm5/uK93/zsoPC0lAat+2
   w==;
X-CSE-ConnectionGUID: Na1gp5WNQ0WO+BndY9IrDw==
X-CSE-MsgGUID: 7g7tSZ9eRnaJX/eB43sHzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102920096"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="102920096"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:18:12 -0700
X-CSE-ConnectionGUID: hLa2fyDLSsyVnjwP3QieRw==
X-CSE-MsgGUID: XxCvddLSRgOcXJMGgzV5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="282641187"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:18:12 -0700
Date: Wed, 22 Jul 2026 08:18:03 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.16.y 0/6] cBPF JIT spray hardening
Message-ID: <gymgr5t5ocl3v5gykum2xlb5u3jhejmurgnodca534i6lih5q4@n7e6n3qf7szu>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
 <2026072151-outsell-suburb-64ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072151-outsell-suburb-64ea@gregkh>

On Tue, Jul 21, 2026 at 03:08:11PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 14, 2026 at 11:58:24AM -0700, Pawan Gupta wrote:
> > Hi,
> > 
> > These backports harden BPF JIT against spectre-v2 class of attacks. Without
> > a predictor flush, execution of new BPF program may use stale prediction
> > left behind by the freed one.
> > 
> > To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
> > The flush is conditional to spectre-v2 mitigation applied.
> > 
> > Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.
> > 
> > 	  bpf: Support for hardening against JIT spraying
> > 	  x86/bugs: Enable IBPB flush on BPF JIT allocation
> > 
> > Patch 3-6: Narrow the flush to only unprivileged JIT allocations
> > 	   to avoid redundant flushes. Also adds pack-selection changes
> > 	   that minimizes flushes.
> > 
> > 	  bpf: Restrict JIT predictor flush to cBPF
> > 	  bpf: Skip redundant IBPB in pack allocator
> > 	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
> > 	  bpf: Prefer dirty packs for eBPF allocations
> > 
> > This one is mostly similar to 6.18:
> > 
> >   https://lore.kernel.org/all/20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com/
> 
> There is no active 6.16.y kernel branch, so why is this being sent to
> us?

Sorry that was a mistake. I had an old 6.16.y worktree in my machine and I
assumed it was still active. Please ignore.
