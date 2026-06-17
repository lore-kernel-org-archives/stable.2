Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFB3A16AE
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735202; cv=none; b=tWALL40JTIPQ1KHuLE+0zaIBEJfeL/qXvRUfZDJWHl9Hlu0E/xB9OnUtPaWD2mjrtGfxaT7vw1dZTg5kOtHJ4/tgkoNSCkBhoK5USQJc7W6FC5g2XeirfGiLXlcx6KdZ6+FP4IXq5KjT4dGVXxCek4oB2op6AOcuqIQC6Kan2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735202; c=relaxed/simple;
	bh=TexFUd0FNIbMCFe6ktlPk7eiHyZsg1GNyJS8GoZOP5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pPNoGynphQIcx8GB38r2HoMQneY4O6tizY/jcjOBft01bhxOttppjeN+xYuEohXZOOmkJqI1LJLgRlKlaKeCYoqkgdgvI1R5nLsjTuvlno+Cn09emi93sfmA5Ws5sS5wlejcP1/reMhNbiamJIsQjZ1+cl1Oft7Dqe40WVEypHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKoe6hFx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKoe6hFx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422382178bso117679b3a.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781735201; x=1782340001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/Ad4YVUF/7gsfcl7+YM6RzYsrPG0W4dlBQkxAzbvq4=;
        b=bKoe6hFx00rKBILWZ4ZDg146IDusUUoB/hQRleyX/lad8jXmOitvg+8VwwLJx0UJSS
         PQEsBx5jCSeXOzoYxVcXEc8Ja2oYrMqaZoVgUhZmGm2fECIJNeNertRTOMBFb7EmopDy
         feyR3kftSP72s0Bb8Si6qegM3sBlFs3oeSdyzyBTDJTe7rgEtAckmvop9axwrnGzhMn1
         Sah5MwXOrUN8wTV5bhxnz0cv8+yQBDvkXdKAFfc6ycSAUMrQgep/cpV8clCfDXwnBcOZ
         p/cHBvYOEDrCeu+QKTMaQsenOZTlerkaScANpu7wtTHyNhO9aMGCpgsnDUzLemMdA9jJ
         VyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735201; x=1782340001;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j/Ad4YVUF/7gsfcl7+YM6RzYsrPG0W4dlBQkxAzbvq4=;
        b=VpNtoemauU1tjVqNF7DPWQVXHGkS7ALUsiGXRxR79b3dxj/sywHrMZ1P5QwNpkxF+R
         PtkQ/qxZCQ/B+npopnRCnSEt6AbYnoRZimS5ACaQaSx9hi5LeYGtRSXMdia8N0jH6KUd
         8jnWn6+Zx3T6NEeAE2XwU9Pl73GNQxvcdfcjPBbARZRf6CTJzXWvOFWCI/pHc9lkfbKd
         26fX3MzD5bCeJ3F6CDpMTvMPXXsoRBQjzj1bvCyB86H22RpNoFO/kBh9/97k3FMGRFQW
         0cc6pIeD5glU7R2tKE5Ft3gPuJsNEbFDVa8MfMvAaAPTiTeJgy3pBZrL6xstymO6ZUry
         gtgg==
X-Forwarded-Encrypted: i=1; AFNElJ/j3KN8LfTMxsk+Cr19/ZsTtAAhW4gNor8Y8CIOKpwNmR3IZpyT8Xil/lhaOa1hjIFATNnAEFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxwaeAB9X4X0FfTXZqsVrtGWxafKz94MmqOdxg1kPkKd+k+2wH
	Xw2GDmpX0EzHON2hWMdQuzeWnsp9JCyQd2KQ+rM+iqmYZ4dW73RQ6GHKL9yqxAqXYVITtcICzwU
	akDumhw==
X-Received: from pgmk4.prod.google.com ([2002:a63:5a44:0:b0:c85:117a:2b31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8cc5:b0:3b8:268d:5208
 with SMTP id adf61e73a8af0-3b8b7ff2b4fmr6341233637.42.1781735200616; Wed, 17
 Jun 2026 15:26:40 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:26:39 -0700
In-Reply-To: <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
 <ajKbCii_1LpyQKjJ@google.com> <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
 <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
Message-ID: <ajMfH1kWnzFuHJoU@google.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Kai Huang <kai.huang@intel.com>, "jmattson@google.com" <jmattson@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026, Yosry Ahmed wrote:
> On Wed, Jun 17, 2026 at 3:03=E2=80=AFPM Huang, Kai <kai.huang@intel.com> =
wrote:
> >
> > On Wed, 2026-06-17 at 06:03 -0700, Sean Christopherson wrote:
> > > On Wed, Jun 17, 2026, Kai Huang wrote:
> > > > On Tue, 2026-06-16 at 21:46 +0000, Yosry Ahmed wrote:
> > > > > Make sure vpid02 is always flushed on first use by setting last_v=
pid=3D0
> > > > > when allocating vpid02.  nested_vmx_transition_tlb_flush() will a=
lways
> > > > > detect a VPID change on first VM-Enter after VMXON, because VPID=
=3D0 in
> > > > > vmcb12 is not allowed if L1 enables VPID.
> > > >
> > > > vmcs12 :-)
> > > >
> > > > >
> > > > > This avoids using stale TLB entries from a previous lifetime of t=
he
> > > > > VPID, that might have been associated with a different vCPU (or a
> > > > > completely different VM).
> > > > >
> > > > > Note that last_vpid is already being initialized as 0 when the vC=
PU is
> > > > > created, but it is not reset when vpid02 is freed on VMXOFF. Henc=
e, the
> > > > > problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, an=
d KVM
> > > > > happens to reuse a VPID that has TLB entries on the physical CPU.
> > > >
> > > > Not sure whether it's better to set it to 0 in free_nested(), which=
 also resets
> > > > some other nested fields to clean slate AFAICT?
> > >
> > > It needs to be set on first use, for the same reason that kvm_mmu_loa=
d() flushes
> > > the root:
> > >
> > >       /*
> > >        * Flush any TLB entries for the new root, the provenance of th=
e root
> > >        * is unknown.  Even if KVM ensures there are no stale TLB entr=
ies
> > >        * for a freed root, in theory another hypervisor could have le=
ft
> > >        * stale entries.  Flushing on alloc also allows KVM to skip th=
e TLB
> > >        * flush when freeing a root (see kvm_tdp_mmu_put_root()).
> > >        */
> > >       kvm_x86_call(flush_tlb_current)(vcpu);
> >
> > I think you mean the "actual flush" needs to be done on the first use. =
 But
> > setting last_vpid to 0 is a setting which is to make sure the actual fl=
ush will
> > always be done on the first use, i.e., the actual flush will always be =
done on
> > the first use.  For this purpose seems to me there's no difference betw=
een
> > setting last_vpid to 0 in enter_vmx_operation() and free_nested(), but =
maybe I
> > am missing something.

You're not missing anything.  It's just that putting it in free_nested() su=
btly
relies on zero-allocating vmx->nested, so that the *very* first use also fl=
ushes
vpid02.  Relying on zero-allocating is generally a-ok, but in this case it =
would
require documenting the same base logic in multiple places.

> > But I guess doing it in enter_vmx_operation() matches the logic of "doi=
ng actual
> > flush on first use" more :-)
>=20
> Yup. I thought about putting it free_nested() as it looks like
> cleanup, but semantically it makes more sense to put it in
> enter_vmx_operation().
