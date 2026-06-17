Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27543B14B8
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733913; cv=none; b=mPQe53WJW6kgfssoVaHsgD0xZbg/l4xmdm/CQvtL4j2XUQ30fI32AN6BXeq0OHJIsGEJu4f2MYSRRBZLCL6sOgooMX6/AZK6w80UImm7cHhmS9JFxKaFIN6qM4jpY1Bi/8eVFlesYnsnSfMObw8BOyBF8B0XecsDXVN/Ap2DxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733913; c=relaxed/simple;
	bh=8fkAycYjvSCIbYGZVD4c1MU7qOFzTXK5OtPvztFXF0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbQzq2bnvf9PFPEMmEvRJolz74oMB8r6m6wIs/kI1AFs88MRrki3sP4taM2/T6PWhUhVQ9YqV5L8gft9ai4bspc12d3LEEGAQYSqY0RamsYQNVFpI/XfZgKYFJdznFBdcvZBIg7AadSj54w0zfB9/MkPRrbtIJ32MwZXE3P+kUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv7CmoPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv7CmoPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4321F00A3A
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733912;
	bh=6ZprISyA6J+KmU4xbaVGWtaPrhyYsV72Dl+agcxWmTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Pv7CmoPtvXJTWVfx4ZwcCltX7JO72xT/Oao0ws3/ZLU2cRq9B47bS6EqBzs7IccOA
	 36HpPKNrwFZZ/4VWIysMUD8Ueu8Q3rOe9LekfO+Gk+/B4W6QJ9Y5DboWI6IiYyIqlK
	 +1roJv+muMwxVXD7r9DcRRaJ6f93wdzNpiNqvXcMfA2/qiM3ukG6DeVGP+Sdx169iu
	 xQaBQJLSMsazClqM8r7Lbu5T8VT1dOEpPY6aGgoV7nr+z0Mop5O3O+0UsYIa6g/qzS
	 ldMm1AnYFzBUxTGXijSOOW2hJotX687Sg7nkacKhtDAybItHNQJvfHGkg4CkmEg2mH
	 0fPdWGiZYb+/g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec449cf976so22304266b.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:05:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9w02+L89sMuW61MS/cYyH6G3q7P2LCr4zwS5/sJhlgzmEQLWtMshnYGd1tFTOvJPkxKh8csdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaew97B+9WS/oopkB0/hyWdLNOINDNYEtSrs642UP/Fs7sei5F
	i8yz50kBgRwEqc3qIx30VqAaTRByOAN54TjqLGsSArw6LzcfbcVqyUkzfO4AYyt6tc3Zy5LmbUl
	QVQ97XVngYzUQt9VH+YWu1a/AEYGEyL4=
X-Received: by 2002:a17:907:68a8:b0:bee:a665:e631 with SMTP id
 a640c23a62f3a-c05d280a3b1mr246569966b.29.1781733911494; Wed, 17 Jun 2026
 15:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
 <ajKbCii_1LpyQKjJ@google.com> <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
In-Reply-To: <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 17 Jun 2026 15:04:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
X-Gm-Features: AVVi8CdLMJVS7K62maZYalwVlGm2kiTyMQQN-sqzz3s7iAGtSn-JmZE0YAgt21A
Message-ID: <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:03=E2=80=AFPM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
> On Wed, 2026-06-17 at 06:03 -0700, Sean Christopherson wrote:
> > On Wed, Jun 17, 2026, Kai Huang wrote:
> > > On Tue, 2026-06-16 at 21:46 +0000, Yosry Ahmed wrote:
> > > > Make sure vpid02 is always flushed on first use by setting last_vpi=
d=3D0
> > > > when allocating vpid02.  nested_vmx_transition_tlb_flush() will alw=
ays
> > > > detect a VPID change on first VM-Enter after VMXON, because VPID=3D=
0 in
> > > > vmcb12 is not allowed if L1 enables VPID.
> > >
> > > vmcs12 :-)
> > >
> > > >
> > > > This avoids using stale TLB entries from a previous lifetime of the
> > > > VPID, that might have been associated with a different vCPU (or a
> > > > completely different VM).
> > > >
> > > > Note that last_vpid is already being initialized as 0 when the vCPU=
 is
> > > > created, but it is not reset when vpid02 is freed on VMXOFF. Hence,=
 the
> > > > problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, and =
KVM
> > > > happens to reuse a VPID that has TLB entries on the physical CPU.
> > >
> > > Not sure whether it's better to set it to 0 in free_nested(), which a=
lso resets
> > > some other nested fields to clean slate AFAICT?
> >
> > It needs to be set on first use, for the same reason that kvm_mmu_load(=
) flushes
> > the root:
> >
> >       /*
> >        * Flush any TLB entries for the new root, the provenance of the =
root
> >        * is unknown.  Even if KVM ensures there are no stale TLB entrie=
s
> >        * for a freed root, in theory another hypervisor could have left
> >        * stale entries.  Flushing on alloc also allows KVM to skip the =
TLB
> >        * flush when freeing a root (see kvm_tdp_mmu_put_root()).
> >        */
> >       kvm_x86_call(flush_tlb_current)(vcpu);
>
> I think you mean the "actual flush" needs to be done on the first use.  B=
ut
> setting last_vpid to 0 is a setting which is to make sure the actual flus=
h will
> always be done on the first use, i.e., the actual flush will always be do=
ne on
> the first use.  For this purpose seems to me there's no difference betwee=
n
> setting last_vpid to 0 in enter_vmx_operation() and free_nested(), but ma=
ybe I
> am missing something.
>
> But I guess doing it in enter_vmx_operation() matches the logic of "doing=
 actual
> flush on first use" more :-)

Yup. I thought about putting it free_nested() as it looks like
cleanup, but semantically it makes more sense to put it in
enter_vmx_operation().
