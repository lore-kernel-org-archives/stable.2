Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728745;
	b=rrUsf9/E2qicCA/ok5BPMw6ZJAD/lUiK5IsnAzQDVpcEBU/pWgGIC3ZAuf8DWLqcw198
	 80MWb5+5i3Y6kI6c8zNUPUto/cmB7h0cWLocNj2zZZ5JCbgCAE8K4Trb38sN0a2uT0QBI
	 rX8iwRQy8spWi4L6WErFiMMA+AVbOlS6UgTvL5izaA+nL41t6bL6k7ViqxIneBA/Rt5n8
	 qHAzGKTXcFKLud1JGzh5RyR317OzsWqfV5PFRc8wMfXcCPxT/7+kTgA2v8rKWIXrfI2ke
	 zJgkH/6+SyiyhiVn8ECUiXvFsriiVu9kX2LqGO62zj50OcDFZ8e/8wkkk8eat3NRzag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728745;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=nb+2zXteSe9K33gFH0nZhNQtZBhsvYeg6g30yRJfQBc=;
	b=hIpH730aEOAeY/D6tflZYw+FXJbMUnE7IarYdz+dmCjUkhFJhjJa5+s2mP3rqX+TSENK
	 +a/zAo2zee0TMcaUNqtpaxhvIeEvrM949irJbkv7XJDEwzD/NlyGIpaR0zEq90jWhgj0l
	 wTyNbOzVVMYdWsefjQiKneSCLCnaGXJ3aBSiC0NGKiNoFiIpiTcZuW1Bvz8Fm+wwRv1WS
	 3YPr5gphdjqQOgmQ7Dltaqg3al1gIgSeJuOaYX7p+KzKy1asFhzAPGg/+ktBVDmhWREgb
	 m0ozyFWIKEuArQHfaQiNkXBsVk/H8m6OzZxFLBjG/o1e6X1b/ZlDuVZob6kUChUeC/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="l/VQOHns";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB4606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FBB4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l/VQOHns
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E97E1595;
	Tue,  3 Nov 2026 09:59:00 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CDCF3F673;
	Tue,  3 Nov 2026 09:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793728743; bh=WCd0FKNSdDbaUSntYCHvua7YbBIJWQFqFb59a97J1Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/VQOHnsGnQqRpstpZmODKUw5JRrBreeQ81n4Xwg+Vz3Dh02WmD+Im51nEvjhj/H3
	 JEyCbulUBSur0uG1QPpC4bOjh/Vs+a+CfOpoeTcO/m0OE8UK9cBYofVNVmekuaR6/j
	 w31j2ZsipQaEO17ZjnQr0sEnIgdmvPOFdmFv7uMM=
From: Leonardo Bras <leo.bras@arm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 14/28] KVM: arm64: nv: Respect HA when computing translated TCR
Date: Tue,  3 Nov 2026 17:58:59 +0000
Message-ID: <auog45RgAkr2PhoE@LeoBrasDK>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023205610.1044532-15-oupton@kernel.org>
References: <20261023205610.1044532-1-oupton@kernel.org> <20261023205610.1044532-15-oupton@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 01:55:56PM -0700, Oliver Upton wrote:
> Add the missing forwarding of TCR_EL2.HA to TCR_EL1.HA, which are
> different bit indices, to ensure that FEAT_HAF actually works for an L1
> hypervisor in the EL2 translation regime.
> 
> Cc: stable@vger.kernel.org
> Fixes: d5bbb76f4474 ("KVM: arm64: nv: Expose hardware access flag management to NV guests")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_nested.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index f0ac36fff652..d51d011fc68a 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -29,7 +29,8 @@ static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
>  	       (tcr & TCR_EL2_TG0_MASK) |
>  	       (tcr & TCR_EL2_ORGN0_MASK) |
>  	       (tcr & TCR_EL2_IRGN0_MASK) |
> -	       (tcr & TCR_EL2_T0SZ_MASK);
> +	       (tcr & TCR_EL2_T0SZ_MASK) |
> +	       ((tcr & TCR_EL2_HA) ? TCR_HA : 0);
>  }
>  
>  static inline u64 translate_cptr_el2_to_cpacr_el1(u64 cptr_el2)
> -- 
> 2.47.3
> 

LGTM. FWIW:
Reviewed-by: Leonardo Bras <leo.bras@arm.com>

Thanks!
Leo
