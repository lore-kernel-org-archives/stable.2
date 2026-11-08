Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794115831;
	b=uRUZJrpNzXK+jDA6GHfoLRhhPBGYB7pVnrQI7gJv4g7+PsCHDWq4U0FJ/1LzMe1yJ/H9
	 b0jET8YPh3AeXtFbgWwjG2JPPpWlgTsoz0ZnJJ0FLX2owBLF3ceh09uDh1QTD92bvtOJ8
	 BwFPC7mKzwX+aaTP5bKj49U/nUJoaOjoLc5mVSt7r6mbSV8frFkLHa1oHFYJ96yA1OhpW
	 AcAkks6qLfBKfvc6Ce6XsCI38hQ0MZHjO6xQd6rjdP1YSgYTZ7hlfbgKK1SwfblgVguN8
	 jnsAlCMKikDDr9mjIHNSdn+2BymCL5fJhAhA8qXibpqtE6jeRwK0aYo14NuWrbSlWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794115831;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vbEpgxz4sVD3mNL1jqD1O1PKL8o5YBWuqb4l0sIq1ZE=;
	b=deb7PDoLdxY+KXWpSCKN4sNsfFIaG9/7UTVlXWM1nPWfUL4V5EoH8WY1aY/spbmNGVWh
	 3x/ILB9YLDlX5fSKmgZJMSBM4dO/YFQTjuOL+Q3cJqF0xvWOCbJVxX187nrb7L7A4QZwE
	 E+sZXhkIYgNWewibn3w2gi1sd37lq5wilf1kb7Np/XYphYk0y6w4RwPFSAHZBnUkl8M8P
	 wfgdV50H1YYRuwog46RqGxmIE68zpEWP64eW7c/7lJGymD3vAzKT7fQqEhXwLf6gcuag1
	 DihIDuCd+T6B8qE5wMUnvZFAUobdRd6G+IKR0IiFzmsSO1hrX1h/1GMCUIkPRrSl8Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GtXLjA2t;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7681606A31A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 05:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7681606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GtXLjA2t
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12D8152B;
	Sat,  7 Nov 2026 21:30:25 -0800 (PST)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570983F632;
	Sat,  7 Nov 2026 21:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794115828; bh=yv49NO0eLLUbklg23CJ7sdd/RqUNVCdDN1eU5ZpyV8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtXLjA2t1ZUhUYhDMJnVVvyPZSYXp+XHSjVaG3OXMl8rfHp6BNKP9rdgyJqwyYq14
	 yBKh+871YDJw87BZR6yUYE88Pm2me+dXAH0p94zHmNKsQiHICDd4bKWfFGTb0HmHA9
	 VqRQPukGYmwhVYyFAtsrDoPNbWNHM4XgOxAsyhV4=
Date: Sun, 8 Nov 2026 05:30:21 +0000
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] KVM: arm64: nv: Disallow KVM_CAP_ARM_MTE +
 FEAT_EL2
Message-ID: <nln54klqhvfxdd56uemeqcbb2bmsjyjfia3c4esglvjppcajhd@jnr3qpzgvyyg>
References: <20261106183154.3590825-1-oupton@kernel.org>
 <20261106183154.3590825-2-oupton@kernel.org>
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
In-Reply-To: <20261106183154.3590825-2-oupton@kernel.org>

On Fri, Nov 06, 2026 at 10:31:47AM -0800, Oliver Upton wrote:
> KVM's nested implementation already hides FEAT_MTE and its laundry list
> of derivatives from an NV guest. While good, this is insonsistent with
> the UAPI which does not explicitly prevent the combination of MTE and
> NV.
> 
> Bite the bullet and refuse to create a nested VM if KVM_CAP_ARM_MTE has
> been enabled.
> 
> Cc: stable@vger.kernel.org
> Fixes: a7484c80e5ca ("KVM: arm64: Allow userspace to request KVM_ARM_VCPU_EL2*")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  Documentation/virt/kvm/api.rst |  1 +
>  arch/arm64/kvm/arm.c           | 16 +++++++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e95c9cda085d..4ce4166d415f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3602,6 +3602,7 @@ Possible features:
>  	- KVM_ARM_VCPU_HAS_EL2: Enable Nested Virtualisation support,
>  	  booting the guest from EL2 instead of EL1.
>  	  Depends on KVM_CAP_ARM_EL2.
> +          Cannot be enabled if KVM_CAP_ARM_MTE has been enabled for the VM.
>  	  The VM is running with HCR_EL2.E2H being RES1 (VHE) unless
>  	  KVM_ARM_VCPU_HAS_EL2_E2H0 is also set.
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 157bf4b81202..4108ff30830c 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -480,7 +480,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = cpus_have_final_cap(ARM64_HAS_32BIT_EL1);
>  		break;
>  	case KVM_CAP_ARM_EL2:
> -		r = cpus_have_final_cap(ARM64_HAS_NESTED_VIRT);
> +		/* Nested virt is incompatible with MTE */
> +		if (kvm && kvm_has_mte(kvm))
> +			r = 0;
> +		else
> +			r = cpus_have_final_cap(ARM64_HAS_NESTED_VIRT);

More of a question, do we really want to consider VM feature
compatibility during KVM_CHECK_EXTENSION?

This duplicates the checks which is a bit error-prone. For example I
think we need to also update the KVM_CAP_ARM_EL1_32BIT case to check
kvm_has_mte() if we want to do this. Additionally the information
reported can still become stale if userspace changes it afterwards.

OTOH the KVM_CAP_ARM_MTE case becomes awkward, as its contract states it
needs to be enabled before creating vCPUs so it is strange for it to
check for whether there are vCPUs initialized with NV.

Thanks,
Wei-Lin Chang

>  		break;
>  	case KVM_CAP_ARM_EL2_E2H0:
>  		r = cpus_have_final_cap(ARM64_HAS_HCR_NV1);
> @@ -1793,13 +1797,15 @@ static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
>  	    !test_bit(KVM_ARM_VCPU_PMU_V3, &features))
>  		return -EINVAL;
>  
> +	/* MTE is incompatible with AArch32 and nested virt */
> +	if (kvm_has_mte(vcpu->kvm) &&
> +	    (test_bit(KVM_ARM_VCPU_EL1_32BIT, &features) ||
> +	     test_bit(KVM_ARM_VCPU_HAS_EL2, &features)))
> +		return -EINVAL;
> +
>  	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
>  		return 0;
>  
> -	/* MTE is incompatible with AArch32 */
> -	if (kvm_has_mte(vcpu->kvm))
> -		return -EINVAL;
> -
>  	/* NV is incompatible with AArch32 */
>  	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
>  		return -EINVAL;
> -- 
> 2.47.3
> 
