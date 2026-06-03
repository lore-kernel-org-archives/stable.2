Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD649551D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527454; cv=none; b=UcpZtSIrTHJq4V0rlYAA7uVvfw4DK5dmuT4ot7Qp1HdPDx2a8E14LJA1tCQR6HfC03Ax4IBm2ObvvKIMopcf7uGMwKlM2zIz5cijp0rye8kFvWXXN5INo/YkCSsiDIQlRmsorI8BXrg+bfGwNy6O0PjlBoym/BrGPC550t645MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527454; c=relaxed/simple;
	bh=0EIrwD+lgpB/geyCy3UdXRKAOa6LD3lv0ucquiJdRBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq7cyDQUH7kgMR7cpOBZxiGR8wE2EAgRiOGKg9q6Y5dGqoGZYvNNo6VsfSZ35Uc/AWwpTKph6baUTFr/VWzTz0Gqxr3fkdnXugSm13B4cO2b5UsglHBwWC5xO18psg24G4fSHv05j9aAUpAt6jbPxoT5xz5lVoBknZ5n9eUtOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u9embgzY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u9embgzY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D28EA4837;
	Wed,  3 Jun 2026 15:57:25 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83163F632;
	Wed,  3 Jun 2026 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780527450; bh=0EIrwD+lgpB/geyCy3UdXRKAOa6LD3lv0ucquiJdRBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9embgzYSCBW6F3fG2pkIi3sDaOnzDBs91m7puG95nQVk4qSajWCQnNsTtZzf6zcL
	 WvKp/ZWpyfpOSVMa+PziSVKxaPkMiSSYlZ1HB/qa45dp9265aYlEmnEz/YUZzsYpTY
	 h+h90T+6J+z8Zwmrix6fJYoxlRkp/zt0vjBZipnQ=
Date: Wed, 3 Jun 2026 23:57:20 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix handling of XN[0] when
 !FEAT_XNX
Message-ID: <zzprmfdgkd4sfxjuvbj65ssmdbcxvb2lrdv7lgywysuthx6t4i@ffehlydwbwy7>
References: <20260602165901.52800-1-oupton@kernel.org>
 <20260602165901.52800-2-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602165901.52800-2-oupton@kernel.org>

Hi Oliver,

On Tue, Jun 02, 2026 at 09:59:00AM -0700, Oliver Upton wrote:
> XN has already been extracted from its bitfield position so using
> FIELD_PREP() on the mask that clears XN[0] is completely broken, having
> the effect of unconditionally granting execute permissions...
> 
> Fix the obvious mistake by manipulating the right bit.
> 
> Cc: stable@vger.kernel.org
> Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
> Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_nested.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 091544e6af44..a0eb83319c2e 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
>  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
>  
>  	if (!kvm_has_xnx(kvm))
> -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> +		xn &= 0b10;
>  
>  	switch (xn) {
>  	case 0b00:
> @@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
>  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
>  
>  	if (!kvm_has_xnx(kvm))
> -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> +		xn &= 0b10;
>  

Now that the other patch brings up kvm_pgtable_stage2_pte_prot(), what
do you think about also using that here? It can save a little bit of
duplicated decode logic.

Other than this being in a header and we'll have to move the code
around for this to work, I'm curious are there any other issues with
this idea?

Thanks,
Wei-Lin Chang

>  	switch (xn) {
>  	case 0b00:
> -- 
> 2.47.3
> 
