Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597723;
	b=H3VczehLcmpCJFyApqL5F0FH2o1WSzDBAFdt3Djh8ukAdqVB1YXJ38HwQolpaWpvj1xp
	 cbvamghTDGk359QFEDTwjuK6arfCbvb/6yaZwOGEoiNnttAnb1+LLa5jdnUgg/q92iisC
	 Xpsmdck51vtYfB8n3F2ZzipFt79HmZ/Rz5cN9CMIN6I8hwQWX0wXrDqdMCF81jo6/2GFp
	 ijbXQTsEFpCucUycTm7YrvyoTTxBYl7atXkjMFoNot6KwX8uH3iNg+6Z/dKwA60/eP8xo
	 oma7BwrwE9NeGo25YTAidfNU6tZiDV58JGlHiN6oM6rux6yisbZD0f92LuPhWViUYEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597723;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QVie/z0J40GiWaXqHRXPvG+NrtU10m0jzVDp6bMnZM8=;
	b=neAgpwvSgnETqhkPfUjLfbFffcHH4guqTEqR3EMug19exYsqzZDGdxd8CwI+uLzYTH7Q
	 QbVatv5RvG8kAjnmb6/OR0uoJYn2ut6vjnqJDRixnvWrvkMM4AjJWKD9VmmUdvWuTvDPI
	 Z6ZL7ekGb6CgRq5EN//Ocj2xXr+8YjU2Tk+hLbWur0LmbNlwlah5i4/V4cAGiuPIam2OO
	 QZQkuOiWh/Ngzy1aHB8Gb2j+AmS3MjnE0vaWMosW1iXrZTpP06SAqbpNnIoGYtZXgVFHV
	 44sp5QEVBc0HaA0NkdAd7tyPyvO8OXSY6STrNqy8iZJTq66BqwCf8V6mxv2cuOQRXhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dcAnQhGt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF8606A332;
	Wed, 25 Nov 2026 09:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18EF8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dcAnQhGt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9198E339;
	Wed, 25 Nov 2026 01:08:38 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475643F86F;
	Wed, 25 Nov 2026 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795597721; bh=pmOn0GAQ/bIzl3yEFkQbNwWqfmhqh+tr+9j74hBF0n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dcAnQhGtPKyESIvNebDMGfL2TrSqBtOSKEzh2om+0KBX3wkCehatasRziYTiTReSc
	 p/UUMgQHC6adqOhdOTayYPC49JWou0HCkpkyxeUkQrtwhFWHqMDagQJqtyaF2HHbmz
	 KlGBHPKyMdilzcBf8Nwd5t0/GuII1ev/VeEvtsPg=
Message-ID: <0c7c59df-69cd-40fe-830f-60c0f3cedafa@arm.com>
Date: Wed, 25 Nov 2026 09:08:36 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
To: Dan Carpenter <dan@pereq.eu>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Christoffer Dall <c.dall@virtualopensystems.com>,
 Rusty Russell <rusty@rustcorp.com.au>, Marcelo Tosatti
 <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>,
 =?UTF-8?Q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2026 06:56, Dan Carpenter wrote:
> Resetting a vcpu keeps the old values of SP_EL1, ELR_EL1 and SPSR_EL1.
> Commit e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
> changed the reset to only clear the general purpose registers, SP, PC
> and PSTATE, and later commits moved these three registers to the system
> register array without a reset value.  Commit 85d703746154 ("KVM: arm64:
> Fully zero the vcpu state on reset") fixed the FP registers and the
> 32-bit SPSRs the same commit missed, but not these three.
> 
> The impact is that the guest that boots next can read the previous
> kernel's stack pointer and exception return address.  KVM_GET_ONE_REG
> also returns the old values to userspace, and a rebooted VM doesn't
> start in the same state as a new one.
> 
> Zero them in kvm_reset_vcpu().
> 
> Fixes: e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan@pereq.eu>
> ---
>   arch/arm64/kvm/reset.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 26081d273408..9c1b42890c96 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -199,6 +199,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>   
>   	/* Reset core registers */
>   	kvm_reset_vcpu_core(vcpu);
> +	__vcpu_assign_sys_reg(vcpu, SP_EL1, 0);
> +	__vcpu_assign_sys_reg(vcpu, ELR_EL1, 0);
> +	__vcpu_assign_sys_reg(vcpu, SPSR_EL1, 0);

nit: Please could we move these into kvm_reset_vcpu_core() where we
reset other registers ?

With that:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>   	vcpu->mmio_needed = false;
>   
>   	/* Reset system registers */
> 

