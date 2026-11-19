Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087136;
	b=fEqmBy8RAD5mDqaYJokXHoBPyuJYAwkZt7UZUg/2V4DFLK5y2D3/l8psKGk8KDjm+9uU
	 IQ8sa7/Co305U+oiDttO6n6WKbqEI69aNIEJGfDMjWyLYdxhvmVM3gLuxBpwzUaIYO0gc
	 g+DLb8X4aTxT5aK2cqVU1T/Jc5ENQieZwWHNaN2XgmBolnkx+TEAMEMl/wxofmAwI2cW4
	 yDT2BwupJIXxlGihm2DzKq3UKDMto42X5nuIws24U+tj2KGwN0Odw4HDTzYVdowwgiEPz
	 C11P5/A6NlQb3BOvrH72SeZe7aeL33VZawpGOwbUqjQmyX3ZRPdBgZDOvIf4auYIHDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087136;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hdo31yiX1NgSplArPnMAKiWS3jJZJbo/7jmD/8lHOoY=;
	b=VuqaQTikJ7+X3jPNFqSu2r4Dr/YbD0sY2Bqh/SeevOLhQ5R2RzgQGS70XWDhpoYa0lMx
	 VhXsQXmp/aZ4unAVbQC35zDS6LgjvFicGPlR8os64q5SV2gDGELimyd8ri1Hk0czhOOFo
	 Gp4agHAdB+o5AWmXqYXtbrVLHX0swjZ7XYVTqGqSq9cHnU3fMV/l0GvNi3xK4VmEFxgeL
	 /06k5ZnCSy7+9s9HpHg0dK7FGJSL7Gr8vIT4S+aZx0rVE8L/q2RcmeGgmwc69jjfw43jV
	 7ma4hDz+wKVOxrzltBjMUKheBKWigcubdY0o53XIJcMXg4DYBhp3KlkV3pS2vDAJl2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddrhrIw1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D625606A325;
	Thu, 19 Nov 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddrhrIw1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29CC1F000C5;
	Thu, 19 Nov 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087136;
	bh=hdo31yiX1NgSplArPnMAKiWS3jJZJbo/7jmD/8lHOoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddrhrIw1o9OVE4VgtDLgA5LFH4se0zgUcw/IhmX6IlqCklkfPIUaTJdcseNoMuXGV
	 M8l22jgHiVbDAEcRccHDsU6jQcY3+iHpd8WImqjSMBF+Vu0ryJYnED7Dh3GCxIXVKg
	 FWX4eHPzDkvkk70inKrKaXzsAWc/+aqZqS+tB4z6y4clAvMdmr/vAOj2uIqYfXfkek
	 MWER2rFzg/1eir/OJH2OricpYI5bxvk9z/EtjL2ctHgCC2sOT1KFkzZL74vsWKuTnY
	 Kk5YfVowFmViXJSMQt9xWFHlnGXSg0h16loCM4LsZwuh7RjVTBy6/XP5wnGcoHP2yt
	 dtfLZgk7v0jmw==
Date: Thu, 19 Nov 2026 11:18:48 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
Message-ID: <av7S4fY7f6H_bW8t@gremlin>
References: <20261117074428.7544-1-fuad.tabba@linux.dev>
 <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin>
 <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
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
In-Reply-To: <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>

On Tue, Nov 17, 2026 at 05:05:49PM +0000, Fuad Tabba wrote:
> Hi Lorenzo,
>
> On Tue, 17 Nov 2026 14:23:09 +0000, "Lorenzo Stoakes (ARM)"
> <ljs@kernel.org> wrote:
> [...]
> > > The check also sets run->exit_reason, and arm64's KVM_RUN completes a
> > > pending MMIO exit only if exit_reason is still KVM_EXIT_MMIO. If a
> > > pre-fault stops on a full ring while an MMIO exit is pending, the next
> > > KVM_RUN doesn't complete the exit and the guest repeats the MMIO
> > > access. Userspace can avoid that by completing the exit with KVM_RUN
> > > before it pre-faults.
> >
> > That's also true for riscv:
> >
> >         switch (run->exit_reason) {
> >         case KVM_EXIT_MMIO:
> >                 /* Process MMIO value returned from user-space */
> >                 ret = kvm_riscv_vcpu_mmio_return(vcpu, vcpu->run);
> >                 break;
> >         case KVM_EXIT_RISCV_SBI:
> >                 /* Process SBI value returned from user-space */
> >                 ret = kvm_riscv_vcpu_sbi_return(vcpu, vcpu->run);
> >                 break;
> >         case KVM_EXIT_RISCV_CSR:
> >                 /* Process CSR value returned from user-space */
> >                 ret = kvm_riscv_vcpu_csr_return(vcpu, vcpu->run);
> >                 break;
> >         }
> >
> > (note that it skips CSR, SBI also with a changed exit_reason).
>
> Ack.

Probably worth referencing in commit msg I guess?

>
> > But the overflow bug only applies to x86 (see below), so is this something
> > we should worry about at all?
>
> The ring overflows on arm64 too (below). As for exit_reason, I asked
> Sean about the arm64 MMIO case on v1, and his answer was that a VMM
> that pre-faults between a KVM_EXIT_MMIO return and the next KVM_RUN
> "gets to deal with the fallout" [1]. I think the same goes for riscv's
> exits.

I mean generally yeah, users doing silly things can expect silly results I
guess! :)

>
> [...]
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> [...]
> > >  The dirty ring can get full.  When it happens, the KVM_RUN of the
> > > -vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
> > > +vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
> > > +KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
> > > +ring has been harvested and reset.
> >
> > Maybe worth mentioning the exit_reason thing if we keep this arch-generic?
>
> Sure, I'll document that userspace should complete a pending exit with
> KVM_RUN before it pre-faults on that vCPU.

Thanks!

>
> [...]
> > I wonder if this shouldn't just be an x86-only fix, since no other arch is
> > impacted AFAICT.
> >
> > arm64 and riscv never map a dirty-logged memslot writable, so they're never
> > pushed to the rin, and s390 doesn't have a dirty ring at all:
> >
> > arm64:
> >
> > static int kvm_s2_fault_compute_prot(const struct kvm_s2_fault_desc *s2fd,
> >                                      const struct kvm_s2_fault_vma_info *s2vi,
> >                                      enum kvm_pgtable_prot *prot)
> > {
> >         ...
> >         if (s2vi->map_writable && (s2vi->device ||
> >                                    !memslot_is_logging(s2fd->memslot) ||
> >                                    kvm_s2_fault_is_write(s2fd)))
> >                 *prot |= KVM_PGTABLE_PROT_W;
> >         ...
> > }
>
> arm64 does map a logged slot as writable today. memslot_is_logging()
> tests memslot->dirty_bitmap, which isn't allocated when only the dirty
> ring is enabled, and patch 2's selftest triggers the WARN in
> kvm_dirty_ring_push() on arm64 without patch 1. Wei-Lin's fix to
> memslot_is_logging() [2] is in kvmarm/fixes, not in mainline yet.

But Wei-Lin's fix was taken? So I don't think predicating things on the
basis of it not being there really makes any sense.

However...

>
> With it, the s2vi->device case above still maps a device page writable
> on a read fault in a logged slot. kvm_arch_prepare_memory_region()
> rejects logging on a VM_PFNMAP VMA, so that requires userspace to map
> the device under the slot after creating it (I haven't tested it).

...Given that this possibility exists and device pages are unconditionally
marked writable (even if it's mildly contrived to get there), it's fair
enough to put it in the generic code.

>
> So I think the check should be in the generic loop.
>
> [...]
> > An x86-only version would be pretty simple, something like the below.
> >
> > This also covers off the retry (RET_PF_RETRY) loop which a generic version
> > doesn't.
>
> True. To overflow there, the retries for one page would have to push
> more entries than the ring has in reserve (at least 64), and I don't
> see a way to get that, so I left it alone.

Yep that's fair enough!

>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/all/avs5UD79FB_DG1Vs@seanjc-mac.roam.internal/
> [2] https://lore.kernel.org/all/20261029175238.3214788-2-weilin.chang@arm.com/

--
Cheers, Lorenzo
