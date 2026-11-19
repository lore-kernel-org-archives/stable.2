Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087245;
	b=iODWqSc+0gtXmrlsIUyHabLMVxJ06xDS7UPqmTe+/E12/nAITNJxdMHrZoABePSGnd+7
	 6+u6A7pCLUM7nz9amtUk53YU5WtdWzGIe8poWU2/d+0UWtw1976LPk3SsiEhJLZ2MWhXl
	 rhEhVMnNe9lurz3ErMdPr25vrDPx6uMMH1iM+rY39N4x63543Y161wxn14ZwAsec4jWOA
	 sK3QsMNVBqUJz8+jyIwtVZYpa1y/mAl1Go9kXr2Na1MZj5SfYr72dA36PX2qtwDI17JYv
	 z2fYXIP0jhDzJ/XlW6CB5tMBE5PwoGZD8QEc0I/Pj5wGClURT7U83GaIt+dbqGkO/SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/P5mabH0JHkQS/tGtMzwsxMvwb/yv9fD2MpxixKyD8U=;
	b=ZBAX9nImM5qE7+kamuGX3kBQ6dbP9k5MhavUDjWUTIPSYftX9BxJr5BhqnuXvkbuD+/J
	 oSx+FvwX4Nh1WEGeNhRhCsEtKIrJ9Yg6xNPNqnsKhDJGepvHYqSIyXuxt2va5r+ZWzo+J
	 HgVirMh56G7k3rDdyuf9DgIXXOMQ123N3vxGx8unIpEUaiNNDXO5KHJyf4+zkns5ZISmQ
	 e8h3aDXYHPMIDisV1rSFpAFMDjurlKYeS8RKb5v0aCPuUMjRDLTbFedoAHF+nqO9UG8Qc
	 2xdKg6u+gdQGiXyAwhRyA1RnHPxa6PJqZCNapWjaolqmQR8Om8IAylXm0mioZyUR7rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6QRnhqe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F7606A320;
	Thu, 19 Nov 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6QRnhqe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320261F000C5;
	Thu, 19 Nov 2026 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087245;
	bh=/P5mabH0JHkQS/tGtMzwsxMvwb/yv9fD2MpxixKyD8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6QRnhqeiU7je1XkiTOaqNrgMzrdoqP/BPZSq+iaDn+oJkHi+orLkPCpF8TyD1CJw
	 lIE0ZQgzfPutKfLZwqyvZguVZaw9OvPeTT/qEZsGxXTylHmdhhHW9qXcLM+Asinnil
	 AABvpa8cMTRXIbsymHkB0WFv9VyoUftBs38JkcgsHR+xm0RaA1E0qqsBt6TCkTM6oX
	 qR6iqG9DfHXJ2+YGHLWmNevEs5VG2yy+n3mtoZYWY/TtWu0Im0ExGSeuqrjEhBqwF7
	 vRs93CTwLCONIKIsH7e8vNqdzBjiaNH01eBP3cb4bLKR7PSle64WJLqRjoky4S3MpZ
	 tbJdB43hK8U5g==
Date: Thu, 19 Nov 2026 11:20:38 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
Message-ID: <av7bYb1geEGzaj8e@gremlin>
References: <20261117074428.7544-1-fuad.tabba@linux.dev>
 <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin>
 <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
 <av5CBjbeidUUWiLq@seanjc-mac.roam.internal>
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
In-Reply-To: <av5CBjbeidUUWiLq@seanjc-mac.roam.internal>

On Wed, Nov 18, 2026 at 04:25:42PM -0800, Sean Christopherson wrote:
> On Tue, Nov 17, 2026, Fuad Tabba wrote:
> > > But the overflow bug only applies to x86 (see below), so is this something
> > > we should worry about at all?
> >
> > The ring overflows on arm64 too (below). As for exit_reason, I asked
> > Sean about the arm64 MMIO case on v1, and his answer was that a VMM
> > that pre-faults between a KVM_EXIT_MMIO return and the next KVM_RUN
> > "gets to deal with the fallout" [1]. I think the same goes for riscv's
> > exits.
> >
> > [...]
> > > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > [...]
> > > >  The dirty ring can get full.  When it happens, the KVM_RUN of the
> > > > -vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
> > > > +vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
> > > > +KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
> > > > +ring has been harvested and reset.
> > >
> > > Maybe worth mentioning the exit_reason thing if we keep this arch-generic?
> >
> > Sure, I'll document that userspace should complete a pending exit with
> > KVM_RUN before it pre-faults on that vCPU.
>
> If we're going to do a documentation update, I vote to keep it vague and scary,
> otherwise readers might think the exception proves the rule.  I.e. if we say
> that KVM_PRE_FAULT_MEMORY isn't supported, then userspace might think all other
> ioctls are safe, which is most definitely not the case.  E.g. something like

Yes definitely, like drivers, users can get up to all sorts of mischief if not
properly forewarned :>)

>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e95c9cda085d..45dc1e3c0b03 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6971,10 +6971,13 @@ to the byte array.
>
>        The pending state of the operation is not preserved in state which is
>        visible to userspace, thus userspace should ensure that the operation is
> -      completed before performing a live migration.  Userspace can re-enter the
> -      guest with an unmasked signal pending or with the immediate_exit field set
> -      to complete pending operations without allowing any further instructions
> -      to be executed.
> +      completed before performing a live migration.  In general, userspace should
> +      exercise extreme caution when invoking ioctls other than KVM_RUN prior to
> +      completing the original operation.
> +
> +      Userspace can re-enter the guest with an unmasked signal pending or with
> +      the immediate_exit field set to complete pending operations without
> +      allowing any further instructions to be executed.
>
>  ::

--
Cheers, Lorenzo
