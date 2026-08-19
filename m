Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460E392838
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156915; cv=none; b=iv41mQuq2O0XSDk816ywiy+jrYPovRk2TQ59em5LI1f3QWfcLRTv2SH0rXMAm2+co+guFr8HIvStknksC2hw3Qahe83tZYmnSVqAml8Wquz1h2KfzCftrO3AkXgrwIZPzDs3ZrHyWs+iAe7KKecHI8K2vUOxJc6fqz1mntGnUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156915; c=relaxed/simple;
	bh=gzfJs5HYntu8gcGCJ6sAjebyKzMhabA2OudsbWoFFYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KuB3QWlCStCQfYXW8PHIkpEjaxZHx2PBYiMYu5Lx8eJ6k78aOCpqZ0lo9v7Z3wVGSVCShmuhupMjKyvSjht5HOVocdfSjPmFu0wGyxQ75nJvEqK1/wg3FiAULDN/KsMkPvgbDi40eTwu1ALoT+BbIxBrVvnbqKj3fmOibuYIZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KV4NyNGE; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KV4NyNGE"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc132709c76so1391255a12.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787156905; x=1787761705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+B8j39F6K6IPnckNY9ZHScQQlOhyC0PWjU+Co8ybQzs=;
        b=KV4NyNGEEhtn5LTFoPGMEfcHtx5FjjZPJBx49z+5hmAed75BojHES1DFKqNGG1/v/X
         F5epLoZup3Nb6yLkkxYVCnpvO8DLgyLDgDZEOqzkbabpbmhaVLa8OMhSe+KXfAopotkt
         OwTDBuYGO8PRxgdwVQFWwBFvc0d7HsQGczyzl3qUOeR4O89d9vM/EDPpIDQI7AyzMbJO
         aH0O4xRzO5PhmstZ9RqsGlcFURCN852yePh6NdCRHrXysehbQ1D4HdiYharjg7UpMSZN
         xeqIdyk4OQOsLsMyj2fJ9xiAz/tDY/wVdmV3yQi9AAPhwIWGCBPizwFsUFletUvp4yDt
         KQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156905; x=1787761705;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+B8j39F6K6IPnckNY9ZHScQQlOhyC0PWjU+Co8ybQzs=;
        b=UJ7mVyu2OGOJUR7pWxWD4F746Ww8GH76rnrTZVUNlC2er9iE2rTcfMz4FfMzISe3X4
         zGNExqu0InH73cvt/F7rsAtIpYYLqSRIG4pLnT6yuBMuuvuPGi3BWHEiAQV7IufnV6cI
         NJXW7+4WOuNjSVjewNRXoWNdCy4olo50QBL9DcM75dPS1VPNupMDvrHfDdpk3nt7/6GX
         kzaIQYYZ5K/qZiTvlkna1k0oHq2uczp0I7diwF7uF9IVVT2xPD7a5jRhfWAXMhF5xAJu
         45SWK3G4o0M6UVZ8W0N8Unk+DrNWgyfRWsbVCQDWk0OFiQLRdwFtkKd/vsEP4GY2QdAY
         DdPw==
X-Forwarded-Encrypted: i=1; AHgh+RrrK9xZVcpJBU0P/hr5S0UZyqxWRH1GapQXo9JqBEASeyFG8U/vfl2S0Uz89sysdVS02VEzh3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYrP70rNlTaM+UqkBYiAp6OCrT7cE5YXIvAzV4JEdHO+iU2DF
	qr7PKC5nvQffmzCCMjJvBorkI7+/HTSBSxXLTIp6LstkAmZ2APTtJxcmLbMspp1OBuPSpqwkA40
	2FI5tDg==
X-Received: from pgar15.prod.google.com ([2002:a05:6a02:2e8f:b0:c99:aff5:707b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c7:b0:3c3:cc3e:a9
 with SMTP id adf61e73a8af0-3cd00dd6be8mr9394127637.4.1787156904767; Wed, 19
 Aug 2026 09:28:24 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:28:18 -0700
In-Reply-To: <CAMGffEmqrrFN6O2oqtAZC3iTD5UJrhVK80bmJLkof28C=uAfvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817132535.394764707@linuxfoundation.org> <20260817132539.879554007@linuxfoundation.org>
 <521b22fa-ef09-4449-909f-0120edfc4b24@oracle.com> <CAMGffEmqrrFN6O2oqtAZC3iTD5UJrhVK80bmJLkof28C=uAfvQ@mail.gmail.com>
Message-ID: <aoXZohqTkyXQmteX@google.com>
Subject: Re: [PATCH 6.12 111/181] KVM: SVM: Add support to initialize SEV/SNP
 functionality in KVM
From: Sean Christopherson <seanjc@google.com>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	liam.merwick@oracle.com, Sasha Levin <sashal@kernel.org>, vegard.nossum@oracle.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, Jinpu Wang wrote:
> Hi Harshit,
>=20
> On Wed, Aug 19, 2026 at 9:12=E2=80=AFAM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:

...

> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index 6cec696461da2..bd0344bacaf1e 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -2972,6 +2972,7 @@ void __init sev_set_cpu_caps(void)
> > >   void __init sev_hardware_setup(void)
> > >   {
> > >       unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_co=
unt;
> > > +     struct sev_platform_init_args init_args =3D {0};
> > >       bool sev_snp_supported =3D false;
> > >       bool sev_es_supported =3D false;
> > >       bool sev_supported =3D false;
> > > @@ -3088,6 +3089,15 @@ void __init sev_hardware_setup(void)
> > >       sev_supported_vmsa_features =3D 0;
> > >       if (sev_es_debug_swap_enabled)
> > >               sev_supported_vmsa_features |=3D SVM_SEV_FEAT_DEBUG_SWA=
P;
> > > +
> > > +     if (!sev_enabled)
> > > +             return;
> > > +
> > > +     /*
> > > +      * Do both SNP and SEV initialization at KVM module load.
> > > +      */
> > > +     init_args.probe =3D true;
> > > +     sev_platform_init(&init_args);
> > >   }

...

> That looks like the case, we only use kvm as module, didn't hit the issue=
.
> > The relevant upstream commits are:
> >
> > 435b344a7042 ("crypto: ccp: Add external API interface for PSP module
> > initialization")
> > 44e70718df4f ("KVM: SVM: Ensure PSP module is initialized if KVM module
> > is built-in")
> > 409f45387c93 ("x86/sev: Fix broken SNP support with KVM module built-in=
")
> >
> >
> > https://lore.kernel.org/stable/cover.1739226950.git.ashish.kalra@amd.co=
m/
> >
> >
> > Could the KVM maintainers confirm whether 6.12.y needs this full series=
?

Yes, we should also backport the above fixes to 6.12.y.

> > Probably could be done after this cycle, but still noting it here.

Yes, sadly this patch is needed to make SNP usable for *any* configuration,=
 due
to bb1c84647025 ("crypto: ccp - Move SEV/SNP Platform initialization to KVM=
")
already being in 6.12.
