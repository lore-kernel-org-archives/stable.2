Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816830567B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153053; cv=none; b=AzP5qaE0vunifx/+CVEa0g2UB45rj5TQUEBzCqFaEMPkPESvWqqQyuQaaC2iLN+GuiYaLhrmsovNT4zReqVsyRFHozZTz/ACnzfvOh58LUpkw5a0j4mhedKVqT0QKu8N2axrv4WP6PLckejU5KBLdRyTR0pD77sybzjXgaRbqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153053; c=relaxed/simple;
	bh=wc9nLSphBOCT1DkhLyV+K0eqkiSCALgzgP5PlYhJbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrEboOKnygU/uFuJzTTgOdNHgkIbLeUt13s0PzNseIASJzWpsB0ROc28dsCmRxKBPs4D40+LM7a5wXjefoN+rI1ctgMUqvIIA7Y9X+VG91XO/kUB9pnuWvbGsEEVdZtCroPhWhRpMiAxIOWaNBMAQK+3PHFLoJzDBK7cum/lOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FVaR9MbJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FVaR9MbJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1331477;
	Fri, 11 Sep 2026 11:57:24 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00CC73F7B4;
	Fri, 11 Sep 2026 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789153048; bh=wc9nLSphBOCT1DkhLyV+K0eqkiSCALgzgP5PlYhJbIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVaR9MbJyw2GqzIHwA3ysXfqcfdAaAWFOi+2Ipcd7N4AcQM//flL019SAtbrnoxAt
	 K8fe7QzwxzUkrvQRomXTzyWAeheFEtuCZ1yOS/pydtS0bdnetFtlfXIoI5rXopMN84
	 EKhRjZzsVq8/ZulFFDblC1dwHkjbxb072t+XL0cw=
Date: Fri, 11 Sep 2026 19:57:17 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, ljs@kernel.org, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] KVM: arm64: nv: Fix life cycle of the nested_mmus
 array
Message-ID: <klqsux4hc7qalbo7pev3yjpv5tywenjdpinm7tjblhhdf3l2jy@n2s5lqc5jtwd>
References: <20260911162203.1919330-1-maz@kernel.org>
 <20260911162203.1919330-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911162203.1919330-2-maz@kernel.org>

On Fri, Sep 11, 2026 at 05:22:02PM +0100, Marc Zyngier wrote:
> The nested_mmus array holds the shadow page tables that are used when
> a guest is running a nested context. These structures are allocated on
> VCPU_INIT for whole guest, which implies that they may have to be
> relocated as the array grows.
> 
> Should a VCPU_INIT occur whilst a vcpu is actively running an L2 and
> that the allocation requires relocation, that vcpu will still be
> running with a pointer to the previous structure, which will have been
> freed.
> 
> Fix this by turning the array of structures to an array of pointers,
> which is now allocated at VM creation, sized to the absolute maximum
> that KVM can handle.
> 
> In turn, each VCPU_INIT contributes S2_MMU_PER_VCPU to the pool. No
> reallocation is ever performed, and the life cycle of each object is
> much clearer:
> 
> - the nested_mmus array is allocated in kvm_init_nested(), and freed
>   in kvm_arch_destroy_vm()
> 
> - s2_mmu structures are allocated in kvm_vcpu_init_nested(), and freed
>   on kvm_arch_flush_shadow_all()
> 
> Finally, the freeing of vcpu->arch.vncr_array is made consistent
> rather than being done on some failure paths, but not others.
> 
> Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Reported-by: Shen Yongchao <grayhat@foxmail.com>
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Suggested-by: Karl Mehltretter <kmehltretter@gmail.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Link: https://lore.kernel.org/r/20260803224405.41468-1-kmehltretter@gmail.com
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>

> ---

[...]
