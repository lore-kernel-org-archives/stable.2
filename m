Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACD3AFAEB
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501965; cv=pass; b=eMF+SWYswnbbxmHwH7jDpZoMYPWAnBJ6/84hiawWejgJUph4040qOErLs92ttPv/NfMPS/DYL8JE6SzI6sAXVAsnirYIE19dM7mGwaES/mIqwq9z83VEXsQi8XCGKXVScOwfGXr+TW47sQOUnHjDCZjAXEcKesXGd5Y0sQ1D8ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501965; c=relaxed/simple;
	bh=rY6da5uj5d1fAAUdxNjCRklIiBZnSxH7nKVh3OFeJEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLtuDTtjMrfrtv7dKohrIFEAehoL6KITCvULxgEnr1dJ3BXzyLjQVtderOS+xn9b3EtK03wp/ak8qwk3xvbWJU92p3qTKzeec5MmluEqrFw7k4zen7ZUsStO/rtjjpzW2uOYDBFnBkuDRlzeMwL/YrD3XPUum33zlqL8+uqbsuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Tm1UFQdp; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Tm1UFQdp"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c11fda5470fso10793466b.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782501962; cv=none;
        d=google.com; s=arc-20260327;
        b=WWWRncNj4p3dfyB0uzkhSpJMBieqCOtbJlim/+bR//4F48w8x6NPsmXmdGn+zwdZjG
         Gdy/UkYDwHXj9rSRFAUqm8JSt0ka9xiYXI9h1/zf40cUKMVMgtrnKi4vJKkb+2nX5WHt
         A3KsxnLMBQkUTERJ/7eCNIzWwGwMiEmlOlT+axiWly7QvLQt2bRIz/j5RvWOXa6+l1ri
         NMUwWQ5/vY/gPnr0wKFUmtE63wKph4jldgnFt/oCqDPnBQrD6nX0gV/bI+VF2q5Gba65
         4pPUCFGii7hHhyQo89DX2+vd5/dj0T4S9L4JXNB/EAZAgG1LU6hdQJR2sB3dJf1I1OE6
         qgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nor1h1UbVsKMT7b9fHvKY0zBtdpr2qWp3PEMA3LsGpo=;
        fh=ebM35mJw07IkccuoKG3VBD6lWMWig2n3LlPTXH3P+wE=;
        b=Pyv+VFDJjnr0nsdAbxBm9497nkvwdoDwb/wOLk+Nyv15xihh3HIAqdv9pbMjYznUHf
         IsskzMyD6hFsb0U+kP+K7pzYxl5sYDrkbc/6vfcg4CsydiOP07rPS1R7neGjwgIAacCr
         vElPdCcNq7O8qCmR/i+0FaP5UY1EbTElmogVI3KaIdaPjssLnK4sOfJpxpW0KbFQ88uj
         E8tUBwN5aCbDXlklrLH43KYcu9qmd0TpXs42/ByR1kbFE2WpVo9JuGxgMnmsODwYtvNm
         HL6z4FDCN23th/5v97kKX0dTyrNWu001aVlRqonwu2XTB+HRFGLrKSYVBS3NFAYAGkcN
         SQWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782501962; x=1783106762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nor1h1UbVsKMT7b9fHvKY0zBtdpr2qWp3PEMA3LsGpo=;
        b=Tm1UFQdpFPDI7oziO2BrjAIPdQibJA79oAc2MPrEVtHeoUQjIEZdXTBLZ1uvscoH3u
         +oAOLnGShm5sXRNA93tGen1LSQWbqN4SOMwuqBThP62Hova+GPxo8RvMgccydHmKEhkb
         hk8fiTx4LRICIwHuB7GhwwUXpB5BP0kI0Qf68QmvNMA8SZFW/SVh6gecmMUbn5BvNphB
         i7Ja+AIuwyLLYahmIWOBqBVdU5cBxHl0idfospCw4kTIb3sAOELkdwOCvvxtX63V2Kvo
         Eo2fnxCkMLCGPrv2ZPDrxU5Z7QRV+R7oqEPK5fd1TGAJ3Fcx4U7QBmOSwDxaoxVxwfRI
         VVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782501962; x=1783106762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nor1h1UbVsKMT7b9fHvKY0zBtdpr2qWp3PEMA3LsGpo=;
        b=aRqtoRxOza3RFeMcLOWsXY9NpIc9ysBjNEo2XG5Mn1/aUeFN5YWDO6MeDwZ+vf+DIG
         N2OWqifykMH0UfEC21xxikO/Iyfkh9XUDwdlwBiIfliX5yaVvSYoE1zcspEZ5FDu6vGg
         ErQP4Y88xoC62yvQcba3u4FrytyvLDgK2MJsPHHQEU/dt06DsK8TG1BVOmom92fATxr8
         JytYXNzNb3zoG0fl1wSWcWx5uoapescLP764SF62wDmNwNxXUrPxcrLcx8PJ7MXJFlOj
         /Jt+gedjPzVaH79q5unpvRtPqhawsw9EAV6sJl/hxWfWTkDtWerSpU3YQ26qu5QzbyTi
         krAg==
X-Forwarded-Encrypted: i=1; AHgh+Rquw2orMOrO7A0AmbWk5Sut43SKg/C9kszFLYgtIHHhWRiPlhZOJ1b3XxbSMSZAF8i3Pzd3bs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuavkwx4u5Ljcwbbk7ynwOL0NS8DqBnJrrAvwKFBSCu1lKedJq
	xQ7TiXJGW8y9Kye0LzOxCiELVBGojFYWvBq4SIs16W1urgZuQUvc+2nAqMT68ESHjaI4Fvx3aFn
	umcFu2KqFZIwuq5zb0HyGw0hNfF1nqwFKGfrhBsn12AVt9W9oAdtuu/E=
X-Gm-Gg: AfdE7cmRru8NTNewBItmiVQNdjIQjPElzPqwmpeZHFmvnVA63QYdw0ZC7gX70EmAmDY
	/Wy/SH6quGz8aPK9+owoquVTaVH/mnhZBHykLTx3ZqmrBmTSwH2Rz4k1+ZWO3tz5cdVTXdrsCYM
	zx/MkHlROoNetYOaX0pmY2PhEOf8eBGxkCFyry2UTm01kGqLL8VmTyLCqfpU5e2A6H9FsGGV2co
	SF/BNgpOq6LE4kK1Y/pBCYAXSC3KhLKVXtQ07rWWuxbx3sx0ZZzQTEIiEVgw5ZybLAnDCMnv8DF
	AN3zF/JL7xFPirnv+TpRt4weskDG
X-Received: by 2002:a17:907:3e8d:b0:c01:dc31:2d40 with SMTP id
 a640c23a62f3a-c12061dc6c6mr232626966b.8.1782501962270; Fri, 26 Jun 2026
 12:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626124539.201250-1-jinpu.wang@ionos.com> <20260626124539.201250-2-jinpu.wang@ionos.com>
 <77548d09-b133-4616-bdf4-f01d78323ac3@amd.com>
In-Reply-To: <77548d09-b133-4616-bdf4-f01d78323ac3@amd.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 26 Jun 2026 21:25:51 +0200
X-Gm-Features: AVVi8CcmHIdz1ybtWoufS7YUijLzczvk-81X1kW4s-AV-qo_4tmCvTZkT_NvWOI
Message-ID: <CAMGffEnMG0oySLU0x73Guu1S-o9_L8gSL+fvRDyEX_ND8yk8Mw@mail.gmail.com>
Subject: Re: [stable-6.12 1/3] KVM: SEV: Ignore MMIO requests of length '0'
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 5:37=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 6/26/26 07:42, Jack Wang wrote:
> > From: Sean Christopherson <seanjc@google.com>
> >
> > commit 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 upstream.
> >
> > Explicitly ignore MMIO requests of length '0', so that setting up the
> > software scratch area (and other code) doesn't have to worry about
> > underflowing the length, and to allow for special casing '0' in the
> > future.
> >
> > Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-ID: <20260501202250.2115252-3-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  arch/x86/kvm/svm/sev.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 115c59c86f44..9374b1a93df8 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -4356,16 +4356,22 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
> >                                          control->exit_info_2,
> >                                          svm->sev_es.ghcb_sa);
> >               break;
> > -     case SVM_VMGEXIT_MMIO_WRITE:
> > -             ret =3D setup_vmgexit_scratch(svm, false, control->exit_i=
nfo_2);
> > +                     break;
> > +
> > +     case SVM_VMGEXIT_MMIO_WRITE: {
> > +             u64 len =3D control->exit_info_2;
> > +
> > +             if (!len)
> > +                     return 1;
> > +
> > +             ret =3D setup_vmgexit_scratch(svm, false, len);
> >               if (ret)
> >                       break;
> >
> > -             ret =3D kvm_sev_es_mmio_write(vcpu,
> > -                                         control->exit_info_1,
> > -                                         control->exit_info_2,
> > -                                         svm->sev_es.ghcb_sa);
> > +             ret =3D kvm_sev_es_mmio_write(vcpu, control->exit_info_1,=
 len,
> > +                                   svm->sev_es.ghcb_sa);
> >               break;
> > +             }
>
> This isn't right...
>
> After I apply this I get the following code:
>
> 4349         case SVM_VMGEXIT_MMIO_READ:
> 4350                 ret =3D setup_vmgexit_scratch(svm, true, control->ex=
it_info_2);
> 4351                 if (ret)
> 4352                         break;
> 4353
> 4354                 ret =3D kvm_sev_es_mmio_read(vcpu,
> 4355                                            control->exit_info_1,
> 4356                                            control->exit_info_2,
> 4357                                            svm->sev_es.ghcb_sa);
> 4358                 break;
> 4359                         break;
> 4360
> 4361         case SVM_VMGEXIT_MMIO_WRITE: {
> 4362                 u64 len =3D control->exit_info_2;
> 4363
> 4364                 if (!len)
> 4365                         return 1;
> 4366
> 4367                 ret =3D setup_vmgexit_scratch(svm, false, len);
> 4368                 if (ret)
> 4369                         break;
> 4370
> 4371                 ret =3D kvm_sev_es_mmio_write(vcpu, control->exit_in=
fo_1, len,
> 4372                                       svm->sev_es.ghcb_sa);
> 4373                 break;
> 4374                 }
>
> So we end up with an extra break at line 4359 and the length check is onl=
y
> applied to the MMIO_WRITE path. This patch should just add the length che=
ck
> to both MMIO operations before the call to setup_vmgexit_scratch().
>
> This will need to be re-worked, as will the second patch.

Hi Tom,

Thanks for catch it, will send v2.
>
> Thanks,
> Tom
Regards!
Jack
>
> >       case SVM_VMGEXIT_NMI_COMPLETE:
> >               ++vcpu->stat.nmi_window_exits;
> >               svm->nmi_masked =3D false;
>
