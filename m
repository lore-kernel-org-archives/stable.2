Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B319992C;
	Thu,  2 Jul 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950494; cv=none; b=VbSRPP5zSIPaEQ4w6ilJFPCT5bIUHY6KcPanvXtlF/zKk8eT7HNigslKC+eyQGn+E4oVvxVu3SoerBST0JWOWgxyop+2uWqvtArx6GOWs5MwjPp5QSFRGIZ3oIqdOPxdKJxTwCMj0dml/bDFdfA8GT4HxZnePjTt4k3D0tYhlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950494; c=relaxed/simple;
	bh=pvjJyBojKaaCQDyhnwjMexT9cSQ+Wis9JHDp+sMrsB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=porYfvb1/2QrwHKubX/jH/l+pWl+6fo7Qmy7ca7Lyo6SyF2RygwMy9e/wEidf0uXlD/LRLQXHZacooBjdmgLlMMoVoaIf+VM9lEvSQ1WXZ3zvuoJCObuxAEVLkJYdU1xZ5FxHafLFEZc2ZXpkU+BifustJcLWYlHzvktMRsQlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCSLWpmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCSLWpmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C21B1F000E9;
	Thu,  2 Jul 2026 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950493;
	bh=MKy0RFu7xgDEI2dGgMG+Dk1HrsGATT053SdOOOQC+b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GCSLWpmDDEHjrlT+KseVQxpcJoSLCpI5ureoFaRX4IN4pf2ZgYy3CJqjibEizrE32
	 firSuVyH/BMLdcDdau8xWogD+IbYcegGky7KTpXk87Hn0jidAODsZ8sJZ8MSnxGyj3
	 m1QsTW6pUMkFDv+iRUxIqSGHUXmwKziEl3FQZGRm/SWvCEP2eNtnKHTZVrsvb8Z3OP
	 w2BVPcDPvygS8saTkLyd1vvvqKEcW5Sfb1pZasSYrSjIU68xhp5WWKs5irdDTAEEOd
	 mDmhjE4e0JjyGcoEWpSSLr2n1hQqOYrI6T4wK0lrOcmgjI2WDTAZxf5nSNV8OwPt/X
	 KZ6gil7BYJPvQ==
Date: Wed, 1 Jul 2026 17:01:32 -0700
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
Message-ID: <akWqXBJrJ1n34BQ5@kernel.org>
References: <20260701204342.2654385-1-coltonlewis@google.com>
 <akWhad3U5VNjWzxu@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akWhad3U5VNjWzxu@kernel.org>

Circling back around...

On Wed, Jul 01, 2026 at 04:23:21PM -0700, Oliver Upton wrote:
> The subject prefix should be "[PATCH 6.6 0/5]" so people know right up
> front where this is going.
> 
> On Wed, Jul 01, 2026 at 08:43:37PM +0000, Colton Lewis wrote:
> > This series backports VHE CPU boot fixes to the 6.6.y stable branch.
> > 
> > These fixes are already present in the 6.12.y stable branch (and
> > newer), but are missing in 6.6.y. They are required to enable booting
> > L1 guests with nested virtualization enabled (kvm-arm.mode=nested).
> 
> It's a bit worse than this. The architecture retroactively made
> FEAT_E2H0 an optional feature, there are now implementations in the wild
> that do not support the feature.
> 
> > Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
> > incorrectly configured (because it misses VHE-only detection or early
> > initialization), causing early boot hangs/trap loops.
> > 
> > Conflict resolutions:
> > - Patch 4 (KVM: arm64: Initialize HCR_EL2.E2H early) had conflicts in
> >   arch/arm64/kvm/hyp/nvhe/hyp-init.S due to differences in state
> >   initialization. Resolved by extracting EL2 state initialization into
> >   __kvm_init_el2_state.
> > - Patch 5 (arm64: Revamp HCR_EL2.E2H RES1 detection) had conflicts in
> >   arch/arm64/include/asm/el2_setup.h. Resolved by using raw msr hcr_el2
> >   instead of the missing msr_hcr_el2 macro.
> > 
> > 
> > Marc Zyngier (4):
> >   arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
> >   arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
> >     negative
> >   arm64: Fix early handling of FEAT_E2H0 not being implemented
> >   arm64: Revamp HCR_EL2.E2H RES1 detection
> > 
> > Mark Rutland (1):
> >   KVM: arm64: Initialize HCR_EL2.E2H early

Please go through and correct all of the SHA1s for the cherry-picks,
smells like some LLM just hallucinated some bits given how close they
are to the real deal.

I also want to see that all KVM modes have been tested (nVHE, hVHE, VHE,
protected) before this gets picked up. Overall though taking this to
stable seems like the right thing to do.

Any reason why you've only done 6.6? The kernel was first aware of
E2H=RES1 as far back as 5.13.

Thanks,
Oliver
