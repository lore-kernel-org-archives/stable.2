Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AB35C1BC;
	Wed,  1 Jul 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948204; cv=none; b=c4Qp0153C8tmD6LBlAduMQaDMucuBKAv3n/5VBhy0KuO5twL7+l4R/OUe5ImM/pocLTv54ouXCqzzqzCu6CBzYT4LqlGgNjeFyXohzGrnOEfHvGsjnDjkicxxoseb8zT/HIgoUl5M6ubCuovp5zcVtPbS5zWRX8Xc/g2RhTFfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948204; c=relaxed/simple;
	bh=csNuts0IzkGAc0W7bjedWikPnGB16Sv5nPR4GQNaV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4dfAl9B9kpcX1CunpDfkfs8EUEzFArTSzS85aC0sDKpIYpw/zD2tgbFaEMgDFwlOsaidfEJIZ0V0JWIhg4+aWrZuyl6MPxWmCwhM1anBeWiVWBd2Dw5ymSEYTqe4fn+Jy7HKuXoWhHeXkuee9nt2SAC0DZ5eCsxntMDrhZjJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYWMuWjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYWMuWjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076651F000E9;
	Wed,  1 Jul 2026 23:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782948203;
	bh=hiKmqO0wNrjJu7zzb5rGyi5QeG0KP1hAbxpV1oyAAlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYWMuWjTlBwaME+x1eFSgn+qz2xUyBupMvSmK+RxOlCo3VhCvVTCNWw7Pbhta2G6S
	 vhnTm9ONyh2F7530Zd9GZFgrHkTBNbUCSJGVfe3bgnOTyXL746UtovbEKzL8cp8YBl
	 DNp8gCYtzVL2yrbTy0lFZFUUlzncCkOK9l2wTKQvXOUaEK8Qc7bXze/znzBF/y/0Hy
	 akIizP07KoORUuOhhkQJ6gfRSon37f7Q7oAJdHu0F7xuAFQajfGpzVXsbaxyWt0sTU
	 v3GnLxXouW6CcrzBBZ2YUnGAWiBNO8XJYP3y/qWbFwsy1PN1U2ugbp7URnBPcGdnEv
	 Hw9JJ4NdkGRZg==
Date: Wed, 1 Jul 2026 16:23:21 -0700
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
Message-ID: <akWhad3U5VNjWzxu@kernel.org>
References: <20260701204342.2654385-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701204342.2654385-1-coltonlewis@google.com>

The subject prefix should be "[PATCH 6.6 0/5]" so people know right up
front where this is going.

On Wed, Jul 01, 2026 at 08:43:37PM +0000, Colton Lewis wrote:
> This series backports VHE CPU boot fixes to the 6.6.y stable branch.
> 
> These fixes are already present in the 6.12.y stable branch (and
> newer), but are missing in 6.6.y. They are required to enable booting
> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

It's a bit worse than this. The architecture retroactively made
FEAT_E2H0 an optional feature, there are now implementations in the wild
that do not support the feature.

> Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
> incorrectly configured (because it misses VHE-only detection or early
> initialization), causing early boot hangs/trap loops.
> 
> Conflict resolutions:
> - Patch 4 (KVM: arm64: Initialize HCR_EL2.E2H early) had conflicts in
>   arch/arm64/kvm/hyp/nvhe/hyp-init.S due to differences in state
>   initialization. Resolved by extracting EL2 state initialization into
>   __kvm_init_el2_state.
> - Patch 5 (arm64: Revamp HCR_EL2.E2H RES1 detection) had conflicts in
>   arch/arm64/include/asm/el2_setup.h. Resolved by using raw msr hcr_el2
>   instead of the missing msr_hcr_el2 macro.
> 
> 
> Marc Zyngier (4):
>   arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
>   arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
>     negative
>   arm64: Fix early handling of FEAT_E2H0 not being implemented
>   arm64: Revamp HCR_EL2.E2H RES1 detection
> 
> Mark Rutland (1):
>   KVM: arm64: Initialize HCR_EL2.E2H early
> 
>  arch/arm64/include/asm/el2_setup.h | 52 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/head.S           | 17 +++-------
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 16 +++++++--
>  arch/arm64/tools/sysreg            | 37 +++++++++++++++++++++
>  4 files changed, 107 insertions(+), 15 deletions(-)
> 
> 
> base-commit: d1cfde2d5d15be14123bdd1689162bd27f995a90
> --
> 2.55.0.rc2.803.g1fd1e6609c-goog
> 
