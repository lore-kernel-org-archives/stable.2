Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935195;
	b=kRO+YzJvm98trpoyC8BR5An0jmJaruFYEIv+NopheVhcYKqzxi6MPPvilx5X5LRI3ceR
	 QNOutxZHGB/+PKU/dHwEW9g7Sj9D3L05vSOqsMyYVLZjiaorQIp8hng1f5MqwjKiIVzvk
	 c8NmB2H28tfLsdfaKt2pT26MGGB1CZdUTqMktLPoGUI1xn+MdS0q5k97fWLQ4a5tWCJUo
	 +2R9M0IRYiEqLsO+crYntm6u5o1/mBQ0psw4VKqBbfF2FmqrwAUCCiuN1dEXNtW44rJ4q
	 4F0w+isbb28O++KJWxokPMSvsXAxdoGU/kuS45Ys1sKXjy4z/ZnMdO7YXPQpWFnzsRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935195;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=hixzDBYjex72mbAqfdJ0BMP0XnPJdhglkhJ+5expOLw=;
	b=uM6sn0jBgeskJYRaCWEq2/AF9NhVa6BPHrcTMmJRcvNP6gBoCGaFJmxvEjDTQS+KF9Oa
	 luudLnaeT2egL8jdkugoK/2htmnhBCTJ12M7LJOYqYUiqCqG5ecwhbf+q9FRJb+91LFlf
	 AvQQq1de4bYeyNZikTLcb6eHdLrn++xFI1FOzaZqYKOb5urAF3JW5IvM2HFGY+Fw+1OZk
	 zcTCKhyFCmBZHGpvRpvK7hpHP3BNUotA0mAb7xGwdOU60f+Ow11nXu0coajaFIi/uWwhI
	 bSp/1xlseQbWhrHpqvisBh+eTfEfqHF7BRN/q316rKxntUVr5XCMVBMXw/mivgtCIMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="aJ/bZymZ";
	arc=none smtp.remote-ip=95.215.58.176
Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A860A2600
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296A860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aJ/bZymZ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CuWYfoaIeUOLVmPy0v9FnC5ISe1ZRoIopzCKCHIxYjE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794935192; v=1; x=1795539992;
 b=aJ/bZymZTfxsU1N1k61nexnoLH2HUJsxeT7RaxWp3kj1WKQkwCpEHgnd8xPka38625ich6ah
 0hT/hcCD3XS1OgAf8w3CVVNFugM1MoxcdhKRWb9xV/ULtlDVGxZtbLZ1chJ5AdB1kC6WBmGnIoR
 lgJg5tuSGsSjKdXXwSn2P7M4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e272cc3ad4f333ea;
	Tue, 17 Nov 2026 17:06:32 +0000
X-Mizu-Trace-ID: e272cc3ad4f333ea
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso9473e87.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:06:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGE7HzkuL1BOxhJIwAE7ghm3OHJm5d0+AsCbNZ7D4Hcklv5xv2txa2krw7szm5pXt82i6ieOwo=@vger.kernel.org
X-Gm-Message-State: APuU4Z84b0/dK9wMAtKNdLPLw1VdGufWp1G5Fd3C+VG+y+okW9b5N969
	nXUJDonYza+uhYtyyURqZC/lERIhNRhErjNLx9OVTOx5X8PT0FDAEhFdD7BkBfgkpJQASijOcE8
	QaarvU5KwlBvTBytkY1fBizSgAaVHyU6SQbllHJ8k
X-Received: by 2002:a05:6512:b8d:b0:5bf:f0fb:2c9c with SMTP id
 2adb3069b0e04-5c1a189bda1mr156069e87.5.1794935186033; Tue, 17 Nov 2026
 09:06:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117074428.7544-1-fuad.tabba@linux.dev> <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin>
In-Reply-To: <avxfgWNePsGPK9mm@gremlin>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 17 Nov 2026 17:05:49 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
X-Gm-Features: AclHuK8hlW_ShztJ0BsSWqDzcCkcDDTWK01dR1LguEsZLGP95yN_yfyBcMKgMpA
Message-ID: <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Tue, 17 Nov 2026 14:23:09 +0000, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
[...]
> > The check also sets run->exit_reason, and arm64's KVM_RUN completes a
> > pending MMIO exit only if exit_reason is still KVM_EXIT_MMIO. If a
> > pre-fault stops on a full ring while an MMIO exit is pending, the next
> > KVM_RUN doesn't complete the exit and the guest repeats the MMIO
> > access. Userspace can avoid that by completing the exit with KVM_RUN
> > before it pre-faults.
>
> That's also true for riscv:
>
>         switch (run->exit_reason) {
>         case KVM_EXIT_MMIO:
>                 /* Process MMIO value returned from user-space */
>                 ret = kvm_riscv_vcpu_mmio_return(vcpu, vcpu->run);
>                 break;
>         case KVM_EXIT_RISCV_SBI:
>                 /* Process SBI value returned from user-space */
>                 ret = kvm_riscv_vcpu_sbi_return(vcpu, vcpu->run);
>                 break;
>         case KVM_EXIT_RISCV_CSR:
>                 /* Process CSR value returned from user-space */
>                 ret = kvm_riscv_vcpu_csr_return(vcpu, vcpu->run);
>                 break;
>         }
>
> (note that it skips CSR, SBI also with a changed exit_reason).

Ack.

> But the overflow bug only applies to x86 (see below), so is this something
> we should worry about at all?

The ring overflows on arm64 too (below). As for exit_reason, I asked
Sean about the arm64 MMIO case on v1, and his answer was that a VMM
that pre-faults between a KVM_EXIT_MMIO return and the next KVM_RUN
"gets to deal with the fallout" [1]. I think the same goes for riscv's
exits.

[...]
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
[...]
> >  The dirty ring can get full.  When it happens, the KVM_RUN of the
> > -vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
> > +vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
> > +KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
> > +ring has been harvested and reset.
>
> Maybe worth mentioning the exit_reason thing if we keep this arch-generic?

Sure, I'll document that userspace should complete a pending exit with
KVM_RUN before it pre-faults on that vCPU.

[...]
> I wonder if this shouldn't just be an x86-only fix, since no other arch is
> impacted AFAICT.
>
> arm64 and riscv never map a dirty-logged memslot writable, so they're never
> pushed to the rin, and s390 doesn't have a dirty ring at all:
>
> arm64:
>
> static int kvm_s2_fault_compute_prot(const struct kvm_s2_fault_desc *s2fd,
>                                      const struct kvm_s2_fault_vma_info *s2vi,
>                                      enum kvm_pgtable_prot *prot)
> {
>         ...
>         if (s2vi->map_writable && (s2vi->device ||
>                                    !memslot_is_logging(s2fd->memslot) ||
>                                    kvm_s2_fault_is_write(s2fd)))
>                 *prot |= KVM_PGTABLE_PROT_W;
>         ...
> }

arm64 does map a logged slot as writable today. memslot_is_logging()
tests memslot->dirty_bitmap, which isn't allocated when only the dirty
ring is enabled, and patch 2's selftest triggers the WARN in
kvm_dirty_ring_push() on arm64 without patch 1. Wei-Lin's fix to
memslot_is_logging() [2] is in kvmarm/fixes, not in mainline yet.

With it, the s2vi->device case above still maps a device page writable
on a read fault in a logged slot. kvm_arch_prepare_memory_region()
rejects logging on a VM_PFNMAP VMA, so that requires userspace to map
the device under the slot after creating it (I haven't tested it).

So I think the check should be in the generic loop.

[...]
> An x86-only version would be pretty simple, something like the below.
>
> This also covers off the retry (RET_PF_RETRY) loop which a generic version
> doesn't.

True. To overflow there, the retries for one page would have to push
more entries than the ring has in reserve (at least 64), and I don't
see a way to get that, so I left it alone.

Cheers,
/fuad

[1] https://lore.kernel.org/all/avs5UD79FB_DG1Vs@seanjc-mac.roam.internal/
[2] https://lore.kernel.org/all/20261029175238.3214788-2-weilin.chang@arm.com/
