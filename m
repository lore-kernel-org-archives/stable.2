Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460982;
	b=t3mhtkRpxJCEqSYotKvHHWh4zFNXJIa0vLnK5JzVxDxhey8/zbyvEKIzyEOO7S74fBB6
	 cqAZ5sU4I+YONuW84DaMc77fLOC7+l65POcKtrd7y03xu6jMl62UCatIw7TY1rDGr7ok+
	 hJBLB9fpqwgU13haiw5MrOjU5sTcg5BhleLl6j7nfREiS6k92tBV1+O5uKTPXWiy3bESd
	 x+gnDBUjklomyDU1EcLJoObEISk5rEycYDAyLc3R+OL/RX/u+1CNa0dKFLSEoL0JAmo65
	 TGy92nLc1IURbrv6qCbcm0X+JK8oHUHki4Vu6wOj1Mlugobl8HKlZg5zOLuEfGALnng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460982;
	h=DMARC-Filter:DKIM-Signature:Content-Type:Content-Transfer-Encoding:
	 Message-Id:To:Cc:Subject:Mime-Version:In-Reply-To:Date:From:
	 References:X-Lms-Return-Path;
	bh=yf4VGcXfi4tnX0bWwxta6Va+tyS9bGRKiK9sqlYKPys=;
	b=BUIX0ReIzY/SbJERyBKn7fffXVv6uW4MWagdqDBDw8Ro2wf3s9zQZeuc01H7UnSUOOSi
	 GrOtBfXtT1ym09ZGzAga7KigLSvp7V3cLhfNifgFf6suhA3pFi1uXfvuMr7tfaA2SrWF8
	 Ow+84X0crBcfbiYYUdqfet4Kev/qZpY+4Geoo8yqAqlSTtQkPG+NR+5NvVizicSufB3GP
	 BTovdBF+A8WfgVXsgS8CFlVqEET27ynlUYuu8IOsc2nn/Xuk9GsaIEY+LOZ32MxU6Sevw
	 ORiLsRGCMqIl8ZbMiitA3lZejguxJprLCFfEXS4etjxv+Y3eCR08DLwb/ur/AjYTJ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=fnr2Cz3v;
	arc=none smtp.remote-ip=209.127.230.111
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0191606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0191606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=fnr2Cz3v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792460971; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yf4VGcXfi4tnX0bWwxta6Va+tyS9bGRKiK9sqlYKPys=;
 b=fnr2Cz3vQ9JV+hzRuxhbJLdc8U7pDwvwRug74JLpSM2zN9lTXBUabwIJ2v7VQX9da9QN/g
 09W7GIMSHIx6Ux+XCntxbklDAf5itzgZwigUyLcED6ZM67B3TnLLJWfSJqi8QBMszMEFAV
 9CJ5pzvt5CmhyGcMc2r0YRBqF5IAVWKIUBMNcyLoNp80u93r4KHRobMxtdd/henfw0IpT3
 UU1bpAWvYsO7tQ6+anhXTG6XVQDFyafKNzr6S0pCIdYCQiB4igEFIgMniKexh4U99kE6in
 10jUWGNIflf4fWD3zsKa6qHkPIFwkHGKCKWXC1WRK3oCzCMRvYt5KX+K+5A84w==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <451788d5e97cba38274e663d2b7952c593e959be.299fa9aa.210c.4b1f.9ab7.7acb67f42a19@bytedance.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: <x86@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, 
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Guixiong Wei" <weiguixiong@bytedance.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
In-Reply-To: <89727492-b1d1-4f14-955a-0673ebaee753@intel.com>
Date: Tue, 20 Oct 2026 09:49:26 +0800
From: "Guixiong Wei" <weiguixiong@bytedance.com>
References: <cover.1791428412.git.weiguixiong@bytedance.com> <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com> <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
	<89727492-b1d1-4f14-955a-0673ebaee753@intel.com>
X-Lms-Return-Path: <lba+16ad6c8a9+77c9a2+vger.kernel.org+weiguixiong@bytedance.com>


> From: "Chang S. Bae"<chang.seok.bae@intel.com>
> Date:=C2=A0 Tue, Oct 20, 2026, 01:53
> Subject:=C2=A0 Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic f=
pstate and exec()
> To: "Guixiong Wei"<weiguixiong@bytedance.com>, <x86@kernel.org>
> Cc: "Thomas Gleixner"<tglx@kernel.org>, "Ingo Molnar"<mingo@redhat.com>, =
"Borislav Petkov"<bp@alien8.de>, "Dave Hansen"<dave.hansen@linux.intel.com>=
, "H . Peter Anvin"<hpa@zytor.com>, <linux-kernel@vger.kernel.org>, <stable=
@vger.kernel.org>
> On 10/14/2026 5:19 PM, Chang S. Bae wrote:
> > On 10/7/2026 10:59 PM, Guixiong Wei wrote:
> >>
> >> -void fpstate_free(struct fpu *fpu)
> >> +void fpstate_free(struct fpstate *fpstate)
> >> =C2=A0 {
> >> -=C2=A0=C2=A0=C2=A0 if (fpu->fpstate && fpu->fpstate !=3D &fpu->__fpst=
ate)
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfree(fpu->fpstate);
> >> +=C2=A0=C2=A0=C2=A0 if (fpstate && fpstate->is_valloc)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfree(fpstate);
> >> =C2=A0 }
> >=C2=A0
> > Shouldn't is_valloc be cleared here, or when fpstate_reset() replaces=
=C2=A0
> > fpu->fpstate with the embedded fpstate?
>=C2=A0
> No, is_valloc is pat of the vmalloc'ed memory itself.
>=C2=A0
> That said, removing the original check does not seem reassuring either.=
=C2=A0
> Maybe, another option would be adding an internal helper:
>=C2=A0
> =C2=A0 =C2=A0void __fpstate_reset(struct fpstate *fpstate)
> =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fpstate && fpstate->is_valloc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vfree(fpstate);
> =C2=A0 =C2=A0}
>=C2=A0
> Then, refactor fpstate_realloc() and replace the vfree() in=C2=A0
> fpstate_free() with it, keeping the fpstate_free() prototype unchanged.
>=C2=A0

Good suggestion, adopted in v3 with one small naming divergence
worth flagging: core.c already has a static
__fpstate_reset(struct fpstate *) that initializes fpstate fields,
so I named the new helper __fpstate_free() to preserve the
"reset vs. free" split and avoid shadowing. Final shape:

=C2=A0=C2=A0=C2=A0 static void __fpstate_free(struct fpstate *fpstate)
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (fpstate && fpstate->is_v=
alloc)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
vfree(fpstate);
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 void fpstate_free(struct fpu *fpu)
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 __fpstate_free(fpu->fpstate)=
;
=C2=A0=C2=A0=C2=A0 }

fpstate_realloc() ends with __fpstate_free(curfps) on its detached
pointer.=C2=A0

> Thanks,
> Chang
>=C2=A0

Thanks,
Guixiong
