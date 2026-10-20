Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459695;
	b=wbBN/YwQJAK5XXQ63ghgTHwTSByQrHiWd5MVHkOhnuKrtiWhAYx8Ib8+ib1cCNgU/ita
	 ZQkpF/1NtVBW73wr8Kma59SLB58OTYGIVeVlUaWWRx35YI0JkkzGeLhceFpnIFl2hcGdY
	 /6bNqdjE5Kx7GEqgnf3D1xcCT8xwa80NxXjsACw+s/wzyVlSh4M8slYdCkiv3mT2geR4I
	 TT1XAkUrDg/lVoC1qkTzw4skBRZIw2shy/enHOtR002Cgcp31NB+InLG7PntLec8x9tLu
	 kxqwPum1E+moNRvNwAz6fyuoWuqWwd7z0Dli3qLch2FSCKTOncVxWCYQzZUCm3UlMew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459695;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:
	 X-Lms-Return-Path:Content-Type:Message-Id:To:Cc:From:Mime-Version:
	 References:Content-Transfer-Encoding;
	bh=4S3cXrB/vXEKNb24NBt0+619h+5BULgdtniLLJ8T2X0=;
	b=rz6HBDwk5fxyMHJNhIiVThrFVyzsiBG0ytLBj+DCgDd9xaTCmvSh7h8pfK5UPA2VH6Hm
	 qcM9eork2gLNi4XB/vxissg9x+ZXq2bsGwHt8rfDIh3E/r2r1iGFksB4U8jYlkafnjKjM
	 Rkbf9CVLIxXaTCr3kxRGoiQtK0Z+fiAjbRQ9J0Gv9hu4OlN/RHXhiwxp7XqHDGAvNh92z
	 XlmnpfaOUiXQTMa0LOL/GPIdwv2ym7wwNeT4+jQAeIXdtFTijXe+wOlEAGTrvO5uarDn6
	 kH8OiWGnDGHl+cXDIdcfmx7bWntwAOvjmOOcCVhqnPNb3TlpZfS4L/7qIMzGDKIZ3zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b="RGzo/fS1";
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A185606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A185606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=RGzo/fS1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792459686; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4S3cXrB/vXEKNb24NBt0+619h+5BULgdtniLLJ8T2X0=;
 b=RGzo/fS1EeFTf7od0ELYU58Xnw6V5qIST6VydJBZ/bRbeTnyUhKmxtUoIncjGU9eXJhouh
 415fY4kr0VsriT97ao08V4PaHFRwA6X1DwJ/cmO8Z5nY/QE6EFelSkpEgHPDFlq3sUIUrc
 fOBwXjH7UZhNhkcX0tj9w628VemBzlPrd/qLzWdhD3QM/aedAO359JFmxSFPYBbCudqk3d
 CWtbiuw9GONdW1Ov+FKtvLTnttajNo9pTOZKizHxzUJiaqyogRmNHdzLPUmuKF8757O3bF
 nU1FLlfA/QPfkdsspAFKSbJL89VBPCda6fqvazUs8ZbGGUE3wHV/pGXB2VfWng==
Date: Tue, 20 Oct 2026 09:28:02 +0800
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()
In-Reply-To: <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
X-Lms-Return-Path: <lba+16ad6c3a4+ee62d3+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <451788d5e97cba38274e663d2b7952c593e959be.c973812f.b02a.403f.801f.b484a31094d0@bytedance.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: <x86@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, 
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1791428412.git.weiguixiong@bytedance.com> <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com>
	<d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
Content-Transfer-Encoding: quoted-printable


> From: "Chang S. Bae"<chang.seok.bae@intel.com>
> Date:=C2=A0 Thu, Oct 15, 2026, 08:19
> Subject:=C2=A0 Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic f=
pstate and exec()
> To: "Guixiong Wei"<weiguixiong@bytedance.com>, <x86@kernel.org>
> Cc: "Thomas Gleixner"<tglx@kernel.org>, "Ingo Molnar"<mingo@redhat.com>, =
"Borislav Petkov"<bp@alien8.de>, "Dave Hansen"<dave.hansen@linux.intel.com>=
, "H . Peter Anvin"<hpa@zytor.com>, <linux-kernel@vger.kernel.org>, <stable=
@vger.kernel.org>
> On 10/7/2026 10:59 PM, Guixiong Wei wrote:
> > The fpstate embedded in struct fpu only accommodates the default
> > xfeatures. After a task obtains permission for an XFD-controlled
> > xfeature, its first use raises #NM. The handler calls
> > __xfd_enable_feature(), which uses fpstate_realloc() to install a large=
r
> > fpstate allocated with vzalloc().
> >=C2=A0
> > On exec(), fpu_flush_thread() calls fpstate_reset(), which overwrites
> > fpu->fpstate with the embedded fpstate. This leaks the dynamic
> > allocation because arch_release_task_struct() cannot free it when the
> > task exits.
>=C2=A0
> Hmm, I'd start with Dave's wording here, or tweak it slightly.
Will do. v3 will picks up Dave's phrasing for the opening paragraphs
describing how the dynamic fpstate is allocated and leaked.

>=C2=A0
> > Make fpstate_reset() own the complete lifetime transition. Preserve the
> > old pointer, install and initialize the embedded fpstate, and then free
> > the old allocation. This detaches the allocation from fpu->fpstate
> > before freeing it and makes future reset callers release dynamic state
> > automatically.
>=C2=A0
> I'm not sure what the intended argument is here. Does this mean the old=
=C2=A0
> allocation cannot or should not be freed at the beginning of=C2=A0
> fpstate_reset()? If so, please explain functional issues. Otherwise, I'd=
=C2=A0
> simply follow Dave earlier suggestion.
Agreed, no functional reason. Will free at the beginning of
fpstate_reset() in v3.

>=C2=A0
> > On an AMX-capable KVM guest, 1000 iterations left 1000 dynamic fpstate
> > allocations on an unfixed kernel and none with this change.
>=C2=A0
> Since the selftest can reproduce the issue without KVM, I'm not sure why
> the KVM guest is relevant here. In any case, the entire sentence could=C2=
=A0
> be dropped if the problem description is clear enough.
>=C2=A0
Will do. Dropped in v3;=C2=A0

> > =C2=A0=C2=A0
> > =C2=A0 void fpstate_reset(struct fpu *fpu)
> > =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct fpstate *oldfpstate =3D fpu->fpstat=
e;
> > +
>=C2=A0
> Hmm, again, why not just call fpstate_free(fpu->fpstate) here?
>=C2=A0
> I see Dave also noted this comment along the lines:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Free dynamic fpstate (if any) before reset=
ting pointer: */
>=C2=A0
Will do.

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the fpstate pointer to the de=
fault fpstate */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fpu->fpstate =3D &fpu->__fpstate;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fpstate_reset(fpu->fpstate);
> > @@ -610,6 +612,8 @@ void fpstate_reset(struct fpu *fpu)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* guest FPUs, which allows for=
 common guest and userspace ABI.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fpu->guest_perm.__user_state_size =
=3D fpu_user_cfg.default_size;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0fpstate_free(oldfpstate);
> > =C2=A0 }
>=C2=A0
>=C2=A0
> > @@ -670,6 +674,7 @@ int fpu_clone(struct task_struct *dst, u64 clone_fl=
ags, bool minimal,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The new task's FPU state cannot b=
e valid in the hardware. */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_fpu->last_cpu =3D -1;
> > =C2=A0=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_fpu->fpstate =3D NULL;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fpstate_reset(dst_fpu);
>=C2=A0
> Dave also suggested adding a comment here:
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Break the link to the other FPU's fp=
state: =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_fpu->fpstate =3D NULL;
>=C2=A0
Will do.

> > =C2=A0=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_feature_enabled(X86_FEATURE=
_FPU))
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.=
c
> > index a7b6524a9dea2..ea3736a74fd43 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -1556,10 +1556,10 @@ static int __init xfd_update_static_branch(void=
)
> > =C2=A0 }
> > =C2=A0 arch_initcall(xfd_update_static_branch)
> > =C2=A0=C2=A0
> > -void fpstate_free(struct fpu *fpu)
> > +void fpstate_free(struct fpstate *fpstate)
> > =C2=A0 {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fpu->fpstate && fpu->fpstate !=3D &fpu=
->__fpstate)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vfree(fpu->fps=
tate);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fpstate && fpstate->is_valloc)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vfree(fpstate)=
;
> > =C2=A0 }
>=C2=A0
> Shouldn't is_valloc be cleared here, or when fpstate_reset() replaces=C2=
=A0
> fpu->fpstate with the embedded fpstate?
>=C2=A0
No need: is_valloc lives inside the vmalloc'ed buffer itself, so
vfree() releases the flag together with the storage.

> Thanks,
> Chang
>=C2=A0
